/* 
 * cam_vip.sv
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 *
 * Copyright (C) 2013-2018 ETH Zurich, University of Bologna.
 *
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the "License"); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 */

 module cam_vip    #(
        parameter HRES = 640,
        parameter VRES = 480
)
(
    input logic        en_i,
    output logic       cam_clk_o,
    output logic       cam_vsync_o,
    output logic       cam_href_o,
    output logic [7:0] cam_data_o
);
    timeunit      1ns;
    timeprecision 1ps;

    localparam clk_period=150; // 6MHz
    localparam TP = 2;
    localparam TLINE = (HRES+144)*TP;

    logic cam_pclk_o;

    logic [23:0] pixel_array0 [(HRES*VRES)-1:0];
    logic [23:0] pixel_array1 [(HRES*VRES)-1:0];

    logic [15:0] s_targetcnt;
    logic        s_startcnt;
    logic        s_rstn;
    logic [15:0] r_counter;
    logic [15:0] r_target;

    logic [15:0] r_colptr;
    logic [15:0] s_colptr;
    logic [15:0] r_lineptr;
    logic [15:0] s_lineptr;

    logic [23:0] s_currentpixel;

    logic        r_bytesel;
    logic        s_bytesel;
    logic        r_framesel;
    logic        s_framesel;

    logic        r_done;
    logic        r_active;

  string vsim_path;
  string frame0_path;
  string frame1_path;

    enum logic [4:0] {RST,SOF,WAIT_SOF,WAIT_EOF,SEND_LINE} state,state_next;

    assign s_currentpixel = r_framesel ? pixel_array1[(r_lineptr*HRES)+r_colptr] : pixel_array0[(r_lineptr*HRES)+r_colptr];
    assign cam_data_o     = r_bytesel ? {s_currentpixel[12:10],s_currentpixel[7:3]} : {s_currentpixel[23:19],s_currentpixel[15:13]}; //coded with RGB565
    assign cam_clk_o =  cam_pclk_o ;
    
    initial
    begin
        cam_pclk_o  = 1'b0;
        
        @(posedge en_i);
        // wait one cycle first
        #(clk_period);

        forever cam_pclk_o = #(clk_period/2) ~cam_pclk_o;
    end

    initial begin
        int f0, f1, stop0, stop1, flag, p0, p1;
        stop0=0;
        stop1=-1;
        flag=-5;
        p0=0;
        p1=0;

        `ifdef GENERATE_H
        f0 = $fopen("./rgb565_f0.h","w");
        f1 = $fopen("./rgb565_f1.h","w");
        $fwrite(f0,"\n\n\nint volatile frame_0[N_PIXEL] = {\n");
        $fwrite(f1,"\n\n\nint volatile frame_1[N_PIXEL] = {\n");
        `endif

        @(negedge s_rstn);
        @(posedge en_i);
        @(posedge cam_pclk_o);
        for(int i=0; i<=2;i++) begin
            @(posedge cam_href_o) 
            while(cam_href_o==1'b1) begin
               @(posedge cam_pclk_o);
                if (r_framesel==1'b1) begin  
                    if (stop0==0) begin
                        stop0=1;
                        `ifdef GENERATE_H
                        $fwrite(f0,"};\n");
                        $fwrite(f0,"#define N_PIXEL %d\n",p0);
                        $fclose(f0);
                        `endif
                    end
                    if(stop1>-1) begin
                        if(p1<HRES*VRES*2) begin
                            `ifdef GENERATE_H
                            $fwrite(f1,"    0x%h,\n",cam_data_o);
                            `endif
                            p1++;
                            flag=1;
                        end
                    end 
                end else begin
                    if (stop0==0) begin
                        if(p0<HRES*VRES*2) begin
                           `ifdef GENERATE_H
                            $fwrite(f0,"    0x%h,\n",cam_data_o);
                            `endif
                            p0++;
                            stop1++;
                        end
                    end else begin
                        if(flag>0) begin
                            `ifdef GENERATE_H
                            $fwrite(f1,"};\n");
                            $fwrite(f1,"#define N_PIXEL %d\n",p1);
                            $fclose(f1);
                            `endif
                            flag=-5;
                            stop1=-1;
                        end
                    end
                end
            end
        end
    end

    


    initial 
    begin
        


        s_rstn = 1'b0;
        if ($test$plusargs("VSIM_PATH")) 
            if (!$value$plusargs("VSIM_PATH=%s", vsim_path)) 
                vsim_path = "../";

        frame0_path = {vsim_path, "./tb/vip/camera/img/frame0.img"};
        frame1_path = {vsim_path, "./tb/vip/camera/img/frame1.img"};
        $readmemh(frame0_path, pixel_array0);
        $readmemh(frame1_path, pixel_array1);
        #30ms s_rstn = 1'b1;
    end

    always_comb begin : proc_sm
        cam_vsync_o = 1'b0;
        cam_href_o  = 1'b0;
        s_startcnt  = 1'b0;
        s_targetcnt =  'h0;
        s_lineptr   = r_lineptr;
        s_colptr    = r_colptr;
        s_bytesel   = r_bytesel;
        s_framesel  = r_framesel;
        state_next  = state;
        case(state)
            RST:
            begin
                state_next = SOF;
                s_startcnt = 1'b1;
                s_targetcnt = 3*TLINE;
                s_bytesel  = 1'b0;
                s_framesel = 1'b0;
            end
            SOF:
            begin
                cam_vsync_o = 1'b1;
                if(r_done)
                begin
                    state_next = WAIT_SOF;
                    s_startcnt = 1'b1;
                    s_targetcnt = 17*TLINE;
                end
            end
            WAIT_SOF:
            begin
                if(r_done)
                begin
                    state_next = SEND_LINE;
                    s_lineptr = 'h0;
                    s_colptr  = 'h0;
                end
            end
            SEND_LINE:
            begin
                cam_href_o = 1'b1;
                if(r_bytesel == 1)
                begin
                    s_bytesel = 1'b0;
                    if(r_colptr == (HRES-1))
                    begin
                        s_colptr = 'h0;
                        if(r_lineptr == (VRES-1))
                        begin
                            state_next = WAIT_EOF;
                            s_startcnt = 1'b1;
                            s_targetcnt = 10*TLINE;
                            s_lineptr = 'h0;
                        end
                        else
                        begin
                            s_lineptr = r_lineptr + 1;
                        end
                    end
                    else
                    begin
                        s_colptr = r_colptr + 1;
                    end
                end
                else
                begin
                    s_bytesel = 1'b1;
                end
            end
    
            WAIT_EOF:
            begin
                if(r_done)
                begin
                    state_next = SOF;
                    s_startcnt = 1'b1;
                    s_targetcnt = 3*TLINE;
                    s_framesel = ~r_framesel;
                end
            end
        endcase // state
    end

    always_ff @(posedge cam_pclk_o or negedge s_rstn or negedge en_i) begin : proc_r_bytesel
        if(~s_rstn | ~en_i) begin
            r_bytesel  <= 'h0;
            r_colptr   <= 'h0;
            r_lineptr  <= 'h0;
            r_framesel <= 'h0;
        end else begin
            r_bytesel  <= s_bytesel;
            r_colptr   <= s_colptr;
            r_lineptr  <= s_lineptr;
            r_framesel <= s_framesel;
        end
    end

    always_ff @(posedge cam_pclk_o or negedge s_rstn or negedge en_i) begin : proc_r_counter
        if(~s_rstn | ~en_i) begin
            r_counter <= 0;
            r_target  <= 0;
            r_active  <= 0;
        end else begin
            if (r_active)
            begin
                if(r_counter == r_target)
                begin
                    r_done    <= 1'b1;
                    r_counter <=  'h0;
                    r_active  <= 1'b0; 
                end
                else
                begin
                    r_counter <= r_counter + 1;
                    r_done    <= 1'b0;
                end
            end
            else
            begin
                if (s_startcnt)
                begin
                    r_active <= 1'b1;
                    r_target <= s_targetcnt;
                end
                r_counter <=  'h0;
                r_done    <= 1'b0;
            end
        end
    end

    always_ff @(posedge cam_pclk_o or negedge s_rstn or negedge en_i) begin : proc_state
        if(~s_rstn | ~en_i) begin
            state <= RST;
        end else begin
            state <= state_next;
        end
    end

endmodule

// Copyright 2024 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Maicol Ciani <maicol.ciani@unibo.it> University of Bologna
// Date: 24/07/2024

module snooping_engine
   import snooper_pkg::*;
   import cfg_regs_reg_pkg::*;
#(
   parameter int unsigned NumFields = 5,
   parameter int unsigned AddrWidth = 15,
   parameter int unsigned DataWidth = 32
)  (
   input  logic clk_i,
   input  logic rst_ni,
   // Memory interface
   output logic [NumFields-1:0]                   buff_req_o,
   output logic [NumFields-1:0] [AddrWidth-1:0]   buff_add_o,
   output logic [NumFields-1:0]                   buff_wen_o,
   output logic [NumFields-1:0] [DataWidth-1:0]   buff_wdata_o,
   output logic [NumFields-1:0] [DataWidth/8-1:0] buff_be_o,
   // Control interface
   input trace_t                                  traces_i,
   input cfg_regs_reg2hw_t                        config_i,
   input logic                                    snoop_en_i,
   // Last Valid Entry
   output logic [AddrWidth-1:0]                   cnt_o,
   output logic [AddrWidth-1:0]                   first_valid_o,
   output logic [AddrWidth-1:0]                   last_valid_o
);

   typedef enum logic [1:0] {
       ADDRESS     = 2'b00,
       INSTRUCTION = 2'b01
   } modes_t;

   logic count_incr;
   logic count_rst;
   logic count_rst_comb;

   logic buffer_full;

   assign count_rst_comb = count_rst | config_i.ctrl.cnt_rst.q;

   assign buff_wdata_o = config_i.ctrl.trace_mode.q[0] ?
                  { 32'h0,
                    32'h0,
                    32'h0,
                    32'h0,
                    traces_i.opcode } :
                  { traces_i.metadata,
                    traces_i.pc_dst_h,
                    traces_i.pc_dst_l,
                    traces_i.pc_src_h,
                    traces_i.pc_src_l };

   always_comb begin : mem_interfcace_fsm
      buff_req_o   = '0;
      buff_add_o   = '0;
      buff_wen_o   = '0;
      buff_be_o    = '1;
      count_rst    = '0;
      count_incr   = '0;
      case(config_i.ctrl.trace_mode.q)
          ADDRESS: begin
              if(snoop_en_i) begin;
                 for(int i=0; i<NumFields ;i++) begin
                    buff_req_o[i]   = 1'b1;
                    buff_wen_o[i]   = 1'b1;
                    buff_add_o[i]   = cnt_o + 4*i;
                    buff_be_o[i]    = '1;
                 end
                 if(cnt_o == 16'h3FE8)
                   count_rst= 1'b1;
                 else
                   count_incr = 1'b1;
              end
          end INSTRUCTION: begin
              if(snoop_en_i) begin
                 buff_req_o[0]   = 1'b1;
                 buff_wen_o[0]   = 1'b1;
                 buff_add_o[0]   = cnt_o;
                 buff_be_o[0]    = '1;
                 if(cnt_o == 16'h3FFC)
                   count_rst= 1'b1;
                 else
                   count_incr = 1'b1;
              end
          end default: begin
              buff_req_o   = '0;
              buff_add_o   = '0;
              buff_wen_o   = '0;
              buff_be_o    = '0;
          end
      endcase
   end

   // Address counter
   always_ff @(posedge clk_i or negedge rst_ni or posedge count_rst_comb or posedge snoop_en_i) begin : counter
      if(~rst_ni) begin
         cnt_o <= '0;
      end else if (count_rst_comb) begin
         cnt_o <= '0;
      end else if (snoop_en_i) begin
         if(config_i.ctrl.trace_mode.q == 2'b00 && cnt_o < 16'h3FFC) begin
            cnt_o <= cnt_o + 4*5;
         end else if(config_i.ctrl.trace_mode.q == 2'b01 && cnt_o < 16'h3FFC) begin
            cnt_o <= cnt_o + 4;
         end
      end
   end

   // Detect when the buffer is full
   always_ff @(posedge clk_i or negedge rst_ni) begin
       if (~rst_ni) begin
           buffer_full <= 1'b0;
       end else if (count_rst_comb) begin
           buffer_full <= 1'b1;
       end
   end

   // Register updates
   always_ff @(posedge clk_i or negedge rst_ni) begin
       if (~rst_ni) begin
           first_valid_o <= '0;
           last_valid_o <= '0;
       end else begin
           if(snoop_en_i) begin
              last_valid_o <= cnt_o;
              if (buffer_full && cnt_o < 16'h3FFC) begin
                 if(config_i.ctrl.trace_mode.q == 2'b00) begin
                    first_valid_o <= cnt_o + 20;
                 end else if(config_i.ctrl.trace_mode.q == 2'b01) begin
                    first_valid_o <= cnt_o + 4;
                 end
              end
           end
       end
   end

endmodule


module i2s_dsp_tx_device #(
    parameter DATA = 12
)
(
  input logic [31:0] data,
  input logic lsb_first,
  
  input logic dsp_mode,
  input logic ws,
  input logic bclk,
  output logic dout,
  output logic wso
  
);

  enum {IDLE,RUN} state, next_state; 
  /*
   NB: This generic DSP slave start to transmit data out when receives the ws

   cfg_dsp_mode_i = 0 : DATA OUTPUT ON POSEDGE
   cfg_dsp_mode_i = 1 : DATA OUTPUT ON NEGEDGE
*/
  
  reg [5:0] count=0;
  
  logic start=0;
  
  logic tristate;
  logic mode;
  assign dout = data[count];   
  assign mode= dsp_mode? 1: 0;

   //it receive ws on falling and drives data immediately
   always_ff@ (negedge bclk)
   begin
      if(mode==1'b0) begin
         if(ws==1'b1) begin
            if (lsb_first==1'b0)
               count<=30;
            else
               count<=1;
            start<=1;
         end else begin
            if(start==1'b1) begin
               if (lsb_first==1'b0)
                  if(count==0) begin
                     count<=31;
                     start<=0;
                  end else 
                     count<=count-1;
               else
                  if(count==31) begin
                     count<=0;
                     start<=0;
                  end else
                     count<=count+1;
            end
         end
      end 
   end

   //it receive ws on rising and drives data immediately
   always_ff@ (posedge bclk)
   begin
      if(mode==1'b1) begin
         if(ws==1'b1) begin
            if (lsb_first==1'b0)
               count<=30;
            else
               count<=1;
            start<=1;
         end else begin
            if(start==1'b1) begin
               if (lsb_first==1'b0)
                  if(count==0) begin
                     count<=31;
                     start<=0;
                  end else 
                     count<=count-1;
               else
                  if(count==31) begin
                     count<=0;
                     start<=0;
                  end else
                     count<=count+1;
            end
         end
      end 
   end
   

endmodule


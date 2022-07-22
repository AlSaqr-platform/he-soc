`include "network_define.v"

module alsaqr_valrdy_to_credit (
   clk,
   reset,
                
   //val/rdy interface
   data_in,
   valid_in,
   ready_in,

   //credit based interface   
   data_out,
   valid_out,
   yummy_out
);

input clk;
input reset;

 
input [`DATA_WIDTH-1:0]  data_in;
input valid_in;        // sending data to the output
output reg ready_in;    // is there space available?

output reg [`DATA_WIDTH-1:0]  data_out;
output reg valid_out;
input yummy_out;       // output consumed data

reg[1:0] State;


/* states  
0 idle no data to send, and have no data 
1 getting data and sending credit back
2 waiting to send valid/ready data to AXI
*/

reg[3:0] msgCounter;
reg[3:0] outCounter;
reg[15:0][`DATA_WIDTH-1:0] mybuffer;

always @(posedge clk) begin 
   if(~reset) begin
   State          <= 0;
   msgCounter     <= 0;
   valid_out      <= 0;
   data_out       <= 0;
   ready_in       <= 1;
   outCounter     <= 0;
   end else begin
      case (State)
      2'b00  : 
      begin
         if (valid_in == 1)
         begin
            State <= 1;
            mybuffer[msgCounter]    <= data_in;
            msgCounter              <= msgCounter + 1;
         end
      end
      2'b01  :
      begin 
         if (valid_in == 0) begin
            State       <= 2;
            ready_in   <= 0;
            valid_out <= 1;
            data_out    <= mybuffer[outCounter];
            outCounter <= outCounter +1;
         end
         else begin
            msgCounter              <= msgCounter + 1;
            mybuffer[msgCounter]    <= data_in;
            State   <= 1;
         end
      end
      2'b10  :
      begin 
         data_out    <= mybuffer[outCounter];
         valid_out   <= 1;
         if (msgCounter > 1 ) begin
               State <= 2;
               outCounter  <= outCounter + 1;
               msgCounter  <= msgCounter - 1;  
         end
         else begin
               State       <= 0;
               msgCounter  <= 0;
               valid_out   <= 0;
               outCounter  <= 0;
               ready_in    <= 1;
         end
      end
    endcase
   end
end


endmodule




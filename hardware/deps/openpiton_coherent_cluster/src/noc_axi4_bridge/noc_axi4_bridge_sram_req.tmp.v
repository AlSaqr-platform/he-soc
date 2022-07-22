/*
Copyright (c) 2019 Princeton University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Princeton University nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// This file is auto-generated

`include "noc_axi4_bridge_define.vh"
`include "define.tmp.h"
// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml

`include "define.tmp.h"
`ifdef DEFAULT_NETTYPE_NONE
`default_nettype none
`endif
module noc_axi4_bridge_sram_req
(
input wire MEMCLK,
input wire RESET_N,
input wire CEA,
input wire [`NOC_AXI4_BRIDGE_BUFFER_ADDR_SIZE-1:0] AA,
input wire RDWENA,
input wire CEB,
input wire [`NOC_AXI4_BRIDGE_BUFFER_ADDR_SIZE-1:0] AB,
input wire RDWENB,
input wire [`MSG_HEADER_WIDTH-1:0] BWA,
input wire [`MSG_HEADER_WIDTH-1:0] DINA,
output wire [`MSG_HEADER_WIDTH-1:0] DOUTA,
input wire [`MSG_HEADER_WIDTH-1:0] BWB,
input wire [`MSG_HEADER_WIDTH-1:0] DINB,
output wire [`MSG_HEADER_WIDTH-1:0] DOUTB,
input wire [`BIST_OP_WIDTH-1:0] BIST_COMMAND,
input wire [`SRAM_WRAPPER_BUS_WIDTH-1:0] BIST_DIN,
output reg [`SRAM_WRAPPER_BUS_WIDTH-1:0] BIST_DOUT,
input wire [`BIST_ID_WIDTH-1:0] SRAMID
);
  
`ifdef SYNTHESIZABLE_BRAM
wire [`MSG_HEADER_WIDTH-1:0] DOUTA_bram;
wire [`MSG_HEADER_WIDTH-1:0] DOUTB_bram;
assign DOUTA = DOUTA_bram;
assign DOUTB = DOUTB_bram;

bram_1r1w_wrapper #(
   .NAME          (""             ),
   .DEPTH         (`NOC_AXI4_BRIDGE_IN_FLIGHT_LIMIT),
   .ADDR_WIDTH    (`NOC_AXI4_BRIDGE_BUFFER_ADDR_SIZE),
   .BITMASK_WIDTH (`MSG_HEADER_WIDTH),
   .DATA_WIDTH    (`MSG_HEADER_WIDTH)
)   noc_axi4_bridge_sram_req (
   .MEMCLK        (MEMCLK     ),
   .RESET_N        (RESET_N     ),
   .CEA        (CEA     ),
   .AA        (AA     ),
   .AB        (AB     ),
   .RDWENA        (RDWENA     ),
   .CEB        (CEB     ),
   .RDWENB        (RDWENB     ),
   .BWA        (BWA     ),
   .DINA        (DINA     ),
   .DOUTA        (DOUTA_bram     ),
   .BWB        (BWB     ),
   .DINB        (DINB     ),
   .DOUTB        (DOUTB_bram     )
);
      
`else

reg [`MSG_HEADER_WIDTH-1:0] cache [`NOC_AXI4_BRIDGE_IN_FLIGHT_LIMIT-1:0];

integer i;
initial
begin
   for (i = 0; i < `NOC_AXI4_BRIDGE_IN_FLIGHT_LIMIT; i = i + 1)
   begin
      cache[i] = 0;
   end
end

   reg [`MSG_HEADER_WIDTH-1:0] dout_f0;
   assign DOUTA = dout_f0;
   always @ (posedge MEMCLK)
   begin
      if (CEA)
      begin
         if (RDWENA == 1'b0)
            cache[AA] <= (DINA & BWA) | (cache[AA] & ~BWA);
         else
            dout_f0 <= cache[AA];
      end
   end

   reg [`MSG_HEADER_WIDTH-1:0] dout_f1;
   assign DOUTB = dout_f1;
   always @ (posedge MEMCLK)
   begin
      if (CEB)
      begin
         if (RDWENB == 1'b0)
            cache[AB] <= (DINB & BWB) | (cache[AB] & ~BWB);
         else
            dout_f1 <= cache[AB];
      end
   end
  
`endif 

 endmodule


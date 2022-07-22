/*
Copyright (c) 2015 Princeton University
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


//==================================================================================================
//  Filename      : rf_l15_lrsc_flag.v
//  Created On    : 2018-11-08 18:14:58
//  Last Modified : 
//  Revision      :
//  Author        : Fei Gao
//  Company       : Princeton University
//  Email         : feig@princeton.edu
//
//  Description   :
//
//
//==================================================================================================
//rf_l15_lrsc_flag.v

//`timescale 1 ns / 10 ps
//`default_nettype none


// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml

module rf_l15_lrsc_flag(
   input wire clk,
   input wire rst_n,

   input wire read_valid,
   input wire [`L15_CACHE_INDEX_WIDTH-1:0] read_index,

   input wire write_valid,
   input wire [`L15_CACHE_INDEX_WIDTH-1:0] write_index,
   input wire [3:0] write_mask,
   input wire [3:0] write_data,

   output wire [3:0] read_data
   );



// reg read_valid_f;
reg [`L15_CACHE_INDEX_WIDTH-1:0] read_index_f;
reg [`L15_CACHE_INDEX_WIDTH-1:0] write_index_f;
reg [3:0] write_data_f;
reg [3:0] write_mask_f;
reg write_valid_f;

reg [3:0] regfile [0:`L15_CACHE_INDEX_VECTOR_WIDTH-1];

always @ (posedge clk)
begin
   if (!rst_n)
   begin
      read_index_f <= 0;
   end
   else
   if (read_valid)
      read_index_f <= read_index;
   else
      read_index_f <= read_index_f;
end

// read port
assign read_data = regfile[read_index_f];

// Write port
always @ (posedge clk)
begin
   write_valid_f <= write_valid;
   if (write_valid)
   begin
      write_data_f <= write_data;
      write_index_f <= write_index;
      write_mask_f <= write_mask;
   end
end

always @ (posedge clk)
begin
   if (!rst_n)
   begin
      regfile[0] <= 4'b0;
regfile[1] <= 4'b0;
regfile[2] <= 4'b0;
regfile[3] <= 4'b0;
regfile[4] <= 4'b0;
regfile[5] <= 4'b0;
regfile[6] <= 4'b0;
regfile[7] <= 4'b0;
regfile[8] <= 4'b0;
regfile[9] <= 4'b0;
regfile[10] <= 4'b0;
regfile[11] <= 4'b0;
regfile[12] <= 4'b0;
regfile[13] <= 4'b0;
regfile[14] <= 4'b0;
regfile[15] <= 4'b0;
regfile[16] <= 4'b0;
regfile[17] <= 4'b0;
regfile[18] <= 4'b0;
regfile[19] <= 4'b0;
regfile[20] <= 4'b0;
regfile[21] <= 4'b0;
regfile[22] <= 4'b0;
regfile[23] <= 4'b0;
regfile[24] <= 4'b0;
regfile[25] <= 4'b0;
regfile[26] <= 4'b0;
regfile[27] <= 4'b0;
regfile[28] <= 4'b0;
regfile[29] <= 4'b0;
regfile[30] <= 4'b0;
regfile[31] <= 4'b0;
regfile[32] <= 4'b0;
regfile[33] <= 4'b0;
regfile[34] <= 4'b0;
regfile[35] <= 4'b0;
regfile[36] <= 4'b0;
regfile[37] <= 4'b0;
regfile[38] <= 4'b0;
regfile[39] <= 4'b0;
regfile[40] <= 4'b0;
regfile[41] <= 4'b0;
regfile[42] <= 4'b0;
regfile[43] <= 4'b0;
regfile[44] <= 4'b0;
regfile[45] <= 4'b0;
regfile[46] <= 4'b0;
regfile[47] <= 4'b0;
regfile[48] <= 4'b0;
regfile[49] <= 4'b0;
regfile[50] <= 4'b0;
regfile[51] <= 4'b0;
regfile[52] <= 4'b0;
regfile[53] <= 4'b0;
regfile[54] <= 4'b0;
regfile[55] <= 4'b0;
regfile[56] <= 4'b0;
regfile[57] <= 4'b0;
regfile[58] <= 4'b0;
regfile[59] <= 4'b0;
regfile[60] <= 4'b0;
regfile[61] <= 4'b0;
regfile[62] <= 4'b0;
regfile[63] <= 4'b0;
regfile[64] <= 4'b0;
regfile[65] <= 4'b0;
regfile[66] <= 4'b0;
regfile[67] <= 4'b0;
regfile[68] <= 4'b0;
regfile[69] <= 4'b0;
regfile[70] <= 4'b0;
regfile[71] <= 4'b0;
regfile[72] <= 4'b0;
regfile[73] <= 4'b0;
regfile[74] <= 4'b0;
regfile[75] <= 4'b0;
regfile[76] <= 4'b0;
regfile[77] <= 4'b0;
regfile[78] <= 4'b0;
regfile[79] <= 4'b0;
regfile[80] <= 4'b0;
regfile[81] <= 4'b0;
regfile[82] <= 4'b0;
regfile[83] <= 4'b0;
regfile[84] <= 4'b0;
regfile[85] <= 4'b0;
regfile[86] <= 4'b0;
regfile[87] <= 4'b0;
regfile[88] <= 4'b0;
regfile[89] <= 4'b0;
regfile[90] <= 4'b0;
regfile[91] <= 4'b0;
regfile[92] <= 4'b0;
regfile[93] <= 4'b0;
regfile[94] <= 4'b0;
regfile[95] <= 4'b0;
regfile[96] <= 4'b0;
regfile[97] <= 4'b0;
regfile[98] <= 4'b0;
regfile[99] <= 4'b0;
regfile[100] <= 4'b0;
regfile[101] <= 4'b0;
regfile[102] <= 4'b0;
regfile[103] <= 4'b0;
regfile[104] <= 4'b0;
regfile[105] <= 4'b0;
regfile[106] <= 4'b0;
regfile[107] <= 4'b0;
regfile[108] <= 4'b0;
regfile[109] <= 4'b0;
regfile[110] <= 4'b0;
regfile[111] <= 4'b0;
regfile[112] <= 4'b0;
regfile[113] <= 4'b0;
regfile[114] <= 4'b0;
regfile[115] <= 4'b0;
regfile[116] <= 4'b0;
regfile[117] <= 4'b0;
regfile[118] <= 4'b0;
regfile[119] <= 4'b0;
regfile[120] <= 4'b0;
regfile[121] <= 4'b0;
regfile[122] <= 4'b0;
regfile[123] <= 4'b0;
regfile[124] <= 4'b0;
regfile[125] <= 4'b0;
regfile[126] <= 4'b0;
regfile[127] <= 4'b0;

      // regfile <= 1024'b0;
   end
   else
   if (write_valid_f)
   begin
      // regfile[write_index] <= (write_data & write_mask) | (regfile[write_index] & ~write_mask);
      regfile[write_index_f] <= (write_data_f & write_mask_f) | (regfile[write_index_f] & ~write_mask_f);
   end
end
endmodule

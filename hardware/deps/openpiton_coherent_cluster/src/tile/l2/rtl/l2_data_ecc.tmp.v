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
//  Filename      : l2_data_ecc.v
//  Created On    : 2014-06-02
//  Revision      :
//  Author        : Yaosheng Fu
//  Company       : Princeton University
//  Email         : yfu@princeton.edu
//
//  Description   : L2 cache array error detection and correction
//
//
//==================================================================================================

`include "l2.tmp.h"
`include "define.tmp.h"




module l2_data_ecc ( 
   input  [`L2_DATA_ECC_DATA_WIDTH-1:0]      din,
   input  [`L2_DATA_ECC_PARITY_WIDTH-1:0]	 parity,

   output [`L2_DATA_ECC_DATA_WIDTH-1:0]      dout,
   output                                    corr_error,
   output                                    uncorr_error
);

   
wire [`L2_DATA_ECC_DATA_WIDTH-1:0] 	err_bit_pos;
wire [`L2_DATA_ECC_PARITY_WIDTH-2:0]    cflag;
wire 	                                pflag;
assign cflag[0] = parity[0]  ^ din[0] ^ din[1] ^ din[3] ^ din[4] ^ din[6] ^ din[8] ^ din[10] ^ din[11] ^ din[13] ^ din[15] ^ din[17] ^ din[19] ^ din[21] ^ din[23] ^ din[25] ^ din[26] ^ din[28] ^ din[30] ^ din[32] ^ din[34] ^ din[36] ^ din[38] ^ din[40] ^ din[42] ^ din[44] ^ din[46] ^ din[48] ^ din[50] ^ din[52] ^ din[54] ^ din[56] ^ din[57] ^ din[59] ^ din[61] ^ din[63] ;

assign cflag[1] = parity[1]  ^ din[0] ^ din[2] ^ din[3] ^ din[5] ^ din[6] ^ din[9] ^ din[10] ^ din[12] ^ din[13] ^ din[16] ^ din[17] ^ din[20] ^ din[21] ^ din[24] ^ din[25] ^ din[27] ^ din[28] ^ din[31] ^ din[32] ^ din[35] ^ din[36] ^ din[39] ^ din[40] ^ din[43] ^ din[44] ^ din[47] ^ din[48] ^ din[51] ^ din[52] ^ din[55] ^ din[56] ^ din[58] ^ din[59] ^ din[62] ^ din[63] ;

assign cflag[2] = parity[2]  ^ din[1] ^ din[2] ^ din[3] ^ din[7] ^ din[8] ^ din[9] ^ din[10] ^ din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;

assign cflag[3] = parity[3]  ^ din[4] ^ din[5] ^ din[6] ^ din[7] ^ din[8] ^ din[9] ^ din[10] ^ din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ;

assign cflag[4] = parity[4]  ^ din[11] ^ din[12] ^ din[13] ^ din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ;

assign cflag[5] = parity[5]  ^ din[26] ^ din[27] ^ din[28] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ;

assign cflag[6] = parity[6]  ^ din[57] ^ din[58] ^ din[59] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;

assign pflag = cflag[0]
 ^ parity[1]  ^ parity[2]  ^ parity[3]  ^ parity[4]  ^ parity[5]  ^ parity[6] 
^ din[2] ^ din[5] ^ din[7] ^ din[9] ^ din[12] ^ din[14] ^ din[16] ^ din[18] ^ din[20] ^ din[22] ^ din[24] ^ din[27] ^ din[29] ^ din[31] ^ din[33] ^ din[35] ^ din[37] ^ din[39] ^ din[41] ^ din[43] ^ din[45] ^ din[47] ^ din[49] ^ din[51] ^ din[53] ^ din[55] ^ din[58] ^ din[60] ^ din[62] ;

assign err_bit_pos[0] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[1] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[2] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[3] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[4] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[5] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[6] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[7] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[8] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[9] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[10] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[11] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[12] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[13] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[14] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[15] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[16] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[17] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[18] =  (~cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[19] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[20] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[21] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[22] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[23] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[24] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[25] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (~cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[26] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[27] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[28] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[29] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[30] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[31] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[32] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[33] =  (~cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[34] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[35] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[36] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[37] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[38] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[39] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[40] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (~cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[41] =  (~cflag[0]) & (~cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[42] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[43] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[44] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[45] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[46] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[47] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[48] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[49] =  (~cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[50] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[51] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[52] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[53] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[54] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[55] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[56] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (cflag[3]) & (cflag[4]) & (cflag[5]) & (~cflag[6]) ;

assign err_bit_pos[57] =  (cflag[0]) & (~cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;

assign err_bit_pos[58] =  (~cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;

assign err_bit_pos[59] =  (cflag[0]) & (cflag[1]) & (~cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;

assign err_bit_pos[60] =  (~cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;

assign err_bit_pos[61] =  (cflag[0]) & (~cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;

assign err_bit_pos[62] =  (~cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;

assign err_bit_pos[63] =  (cflag[0]) & (cflag[1]) & (cflag[2]) & (~cflag[3]) & (~cflag[4]) & (~cflag[5]) & (cflag[6]) ;





//correct the error bit, it can only correct one error bit.

assign dout = din ^ err_bit_pos;

assign corr_error = pflag;

assign uncorr_error = |(cflag[`L2_DATA_ECC_PARITY_WIDTH-2:0]) & ~pflag;


endmodule



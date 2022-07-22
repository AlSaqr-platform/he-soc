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
//  Filename      : l2_data_pgen.v
//  Created On    : 2014-06-02
//  Revision      :
//  Author        : Yaosheng Fu
//  Company       : Princeton University
//  Email         : yfu@princeton.edu
//
//  Description   : L2 cache array parity bits generation
//
//
//==================================================================================================

`include "l2.tmp.h"
`include "define.tmp.h"




module l2_data_pgen ( 
   input    [`L2_DATA_ECC_DATA_WIDTH-1:0]   din,

   output   [`L2_DATA_ECC_PARITY_WIDTH-1:0] parity
);


//generate parity bits based on the hamming codes
assign parity[0] =  din[0] ^ din[1] ^ din[3] ^ din[4] ^ din[6] ^ din[8] ^ din[10] ^ din[11] ^ din[13] ^ din[15] ^ din[17] ^ din[19] ^ din[21] ^ din[23] ^ din[25] ^ din[26] ^ din[28] ^ din[30] ^ din[32] ^ din[34] ^ din[36] ^ din[38] ^ din[40] ^ din[42] ^ din[44] ^ din[46] ^ din[48] ^ din[50] ^ din[52] ^ din[54] ^ din[56] ^ din[57] ^ din[59] ^ din[61] ^ din[63] ;

assign parity[1] =  din[0] ^ din[2] ^ din[3] ^ din[5] ^ din[6] ^ din[9] ^ din[10] ^ din[12] ^ din[13] ^ din[16] ^ din[17] ^ din[20] ^ din[21] ^ din[24] ^ din[25] ^ din[27] ^ din[28] ^ din[31] ^ din[32] ^ din[35] ^ din[36] ^ din[39] ^ din[40] ^ din[43] ^ din[44] ^ din[47] ^ din[48] ^ din[51] ^ din[52] ^ din[55] ^ din[56] ^ din[58] ^ din[59] ^ din[62] ^ din[63] ;

assign parity[2] =  din[1] ^ din[2] ^ din[3] ^ din[7] ^ din[8] ^ din[9] ^ din[10] ^ din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;

assign parity[3] =  din[4] ^ din[5] ^ din[6] ^ din[7] ^ din[8] ^ din[9] ^ din[10] ^ din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ;

assign parity[4] =  din[11] ^ din[12] ^ din[13] ^ din[14] ^ din[15] ^ din[16] ^ din[17] ^ din[18] ^ din[19] ^ din[20] ^ din[21] ^ din[22] ^ din[23] ^ din[24] ^ din[25] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ;

assign parity[5] =  din[26] ^ din[27] ^ din[28] ^ din[29] ^ din[30] ^ din[31] ^ din[32] ^ din[33] ^ din[34] ^ din[35] ^ din[36] ^ din[37] ^ din[38] ^ din[39] ^ din[40] ^ din[41] ^ din[42] ^ din[43] ^ din[44] ^ din[45] ^ din[46] ^ din[47] ^ din[48] ^ din[49] ^ din[50] ^ din[51] ^ din[52] ^ din[53] ^ din[54] ^ din[55] ^ din[56] ;

assign parity[6] =  din[57] ^ din[58] ^ din[59] ^ din[60] ^ din[61] ^ din[62] ^ din[63] ;

assign parity[7] =  din[0] ^ din[1] ^ din[2] ^ din[4] ^ din[5] ^ din[7] ^ din[10] ^ din[11] ^ din[12] ^ din[14] ^ din[17] ^ din[18] ^ din[21] ^ din[23] ^ din[24] ^ din[26] ^ din[27] ^ din[29] ^ din[32] ^ din[33] ^ din[36] ^ din[38] ^ din[39] ^ din[41] ^ din[44] ^ din[46] ^ din[47] ^ din[50] ^ din[51] ^ din[53] ^ din[56] ^ din[57] ^ din[58] ^ din[60] ^ din[63] ;




endmodule 



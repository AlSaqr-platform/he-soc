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
//  Filename      : l2_state.v
//  Created On    : 2014-02-24
//  Revision      :
//  Author        : Yaosheng Fu
//  Company       : Princeton University
//  Email         : yfu@princeton.edu
//
//  Description   : The state array in the L2 cache
//
//
//==================================================================================================

`include "l2.tmp.h"
`include "define.tmp.h"

module l2_state(


    input wire clk,
    input wire rst_n,
    input wire pdout_en,
    input wire deepsleep,

    input wire rd_en,
    input wire wr_en,
    input wire [`L2_STATE_INDEX_WIDTH-1:0] rd_addr,
    input wire [`L2_STATE_INDEX_WIDTH-1:0] wr_addr,
    input wire [`L2_STATE_ARRAY_WIDTH-1:0] data_in,
    input wire [`L2_STATE_ARRAY_WIDTH-1:0] data_mask_in,

    output reg [`L2_STATE_ARRAY_WIDTH-1:0] data_out,
    output wire [`L2_STATE_ARRAY_WIDTH-1:0] pdata_out,

    // sram interface
    output wire [`SRAM_WRAPPER_BUS_WIDTH-1:0] srams_rtap_data,
    input wire  [`BIST_OP_WIDTH-1:0] rtap_srams_bist_command,
    input wire  [`SRAM_WRAPPER_BUS_WIDTH-1:0] rtap_srams_bist_data

);




//Need to bypass the read data if both read and write are valid for the same index in the same cycle


reg [`L2_STATE_ARRAY_WIDTH-1:0] data_in_buf;
reg [`L2_STATE_ARRAY_WIDTH-1:0] data_mask_in_buf;
wire [`L2_STATE_ARRAY_WIDTH-1:0] data_out_real;

always @ (posedge clk)
begin
    data_in_buf <= data_in;
    data_mask_in_buf <= data_mask_in;
end

reg bypass_f;
reg bypass_next;

always @ *
begin
    if (rd_en && wr_en && (rd_addr == wr_addr))
    begin
        bypass_next = 1'b1;
    end
    else
    begin
        bypass_next = 1'b0;
    end
end


always @ (posedge clk)
begin
    bypass_f <= bypass_next;
end

always @ *
begin
    if (bypass_f)
    begin

        data_out[0] = data_mask_in_buf[0] ? data_in_buf[0] : data_out_real[0];
    

        data_out[1] = data_mask_in_buf[1] ? data_in_buf[1] : data_out_real[1];
    

        data_out[2] = data_mask_in_buf[2] ? data_in_buf[2] : data_out_real[2];
    

        data_out[3] = data_mask_in_buf[3] ? data_in_buf[3] : data_out_real[3];
    

        data_out[4] = data_mask_in_buf[4] ? data_in_buf[4] : data_out_real[4];
    

        data_out[5] = data_mask_in_buf[5] ? data_in_buf[5] : data_out_real[5];
    

        data_out[6] = data_mask_in_buf[6] ? data_in_buf[6] : data_out_real[6];
    

        data_out[7] = data_mask_in_buf[7] ? data_in_buf[7] : data_out_real[7];
    

        data_out[8] = data_mask_in_buf[8] ? data_in_buf[8] : data_out_real[8];
    

        data_out[9] = data_mask_in_buf[9] ? data_in_buf[9] : data_out_real[9];
    

        data_out[10] = data_mask_in_buf[10] ? data_in_buf[10] : data_out_real[10];
    

        data_out[11] = data_mask_in_buf[11] ? data_in_buf[11] : data_out_real[11];
    

        data_out[12] = data_mask_in_buf[12] ? data_in_buf[12] : data_out_real[12];
    

        data_out[13] = data_mask_in_buf[13] ? data_in_buf[13] : data_out_real[13];
    

        data_out[14] = data_mask_in_buf[14] ? data_in_buf[14] : data_out_real[14];
    

        data_out[15] = data_mask_in_buf[15] ? data_in_buf[15] : data_out_real[15];
    

        data_out[16] = data_mask_in_buf[16] ? data_in_buf[16] : data_out_real[16];
    

        data_out[17] = data_mask_in_buf[17] ? data_in_buf[17] : data_out_real[17];
    

        data_out[18] = data_mask_in_buf[18] ? data_in_buf[18] : data_out_real[18];
    

        data_out[19] = data_mask_in_buf[19] ? data_in_buf[19] : data_out_real[19];
    

        data_out[20] = data_mask_in_buf[20] ? data_in_buf[20] : data_out_real[20];
    

        data_out[21] = data_mask_in_buf[21] ? data_in_buf[21] : data_out_real[21];
    

        data_out[22] = data_mask_in_buf[22] ? data_in_buf[22] : data_out_real[22];
    

        data_out[23] = data_mask_in_buf[23] ? data_in_buf[23] : data_out_real[23];
    

        data_out[24] = data_mask_in_buf[24] ? data_in_buf[24] : data_out_real[24];
    

        data_out[25] = data_mask_in_buf[25] ? data_in_buf[25] : data_out_real[25];
    

        data_out[26] = data_mask_in_buf[26] ? data_in_buf[26] : data_out_real[26];
    

        data_out[27] = data_mask_in_buf[27] ? data_in_buf[27] : data_out_real[27];
    

        data_out[28] = data_mask_in_buf[28] ? data_in_buf[28] : data_out_real[28];
    

        data_out[29] = data_mask_in_buf[29] ? data_in_buf[29] : data_out_real[29];
    

        data_out[30] = data_mask_in_buf[30] ? data_in_buf[30] : data_out_real[30];
    

        data_out[31] = data_mask_in_buf[31] ? data_in_buf[31] : data_out_real[31];
    

        data_out[32] = data_mask_in_buf[32] ? data_in_buf[32] : data_out_real[32];
    

        data_out[33] = data_mask_in_buf[33] ? data_in_buf[33] : data_out_real[33];
    

        data_out[34] = data_mask_in_buf[34] ? data_in_buf[34] : data_out_real[34];
    

        data_out[35] = data_mask_in_buf[35] ? data_in_buf[35] : data_out_real[35];
    

        data_out[36] = data_mask_in_buf[36] ? data_in_buf[36] : data_out_real[36];
    

        data_out[37] = data_mask_in_buf[37] ? data_in_buf[37] : data_out_real[37];
    

        data_out[38] = data_mask_in_buf[38] ? data_in_buf[38] : data_out_real[38];
    

        data_out[39] = data_mask_in_buf[39] ? data_in_buf[39] : data_out_real[39];
    

        data_out[40] = data_mask_in_buf[40] ? data_in_buf[40] : data_out_real[40];
    

        data_out[41] = data_mask_in_buf[41] ? data_in_buf[41] : data_out_real[41];
    

        data_out[42] = data_mask_in_buf[42] ? data_in_buf[42] : data_out_real[42];
    

        data_out[43] = data_mask_in_buf[43] ? data_in_buf[43] : data_out_real[43];
    

        data_out[44] = data_mask_in_buf[44] ? data_in_buf[44] : data_out_real[44];
    

        data_out[45] = data_mask_in_buf[45] ? data_in_buf[45] : data_out_real[45];
    

        data_out[46] = data_mask_in_buf[46] ? data_in_buf[46] : data_out_real[46];
    

        data_out[47] = data_mask_in_buf[47] ? data_in_buf[47] : data_out_real[47];
    

        data_out[48] = data_mask_in_buf[48] ? data_in_buf[48] : data_out_real[48];
    

        data_out[49] = data_mask_in_buf[49] ? data_in_buf[49] : data_out_real[49];
    

        data_out[50] = data_mask_in_buf[50] ? data_in_buf[50] : data_out_real[50];
    

        data_out[51] = data_mask_in_buf[51] ? data_in_buf[51] : data_out_real[51];
    

        data_out[52] = data_mask_in_buf[52] ? data_in_buf[52] : data_out_real[52];
    

        data_out[53] = data_mask_in_buf[53] ? data_in_buf[53] : data_out_real[53];
    

        data_out[54] = data_mask_in_buf[54] ? data_in_buf[54] : data_out_real[54];
    

        data_out[55] = data_mask_in_buf[55] ? data_in_buf[55] : data_out_real[55];
    

        data_out[56] = data_mask_in_buf[56] ? data_in_buf[56] : data_out_real[56];
    

        data_out[57] = data_mask_in_buf[57] ? data_in_buf[57] : data_out_real[57];
    

        data_out[58] = data_mask_in_buf[58] ? data_in_buf[58] : data_out_real[58];
    

        data_out[59] = data_mask_in_buf[59] ? data_in_buf[59] : data_out_real[59];
    

        data_out[60] = data_mask_in_buf[60] ? data_in_buf[60] : data_out_real[60];
    

        data_out[61] = data_mask_in_buf[61] ? data_in_buf[61] : data_out_real[61];
    

        data_out[62] = data_mask_in_buf[62] ? data_in_buf[62] : data_out_real[62];
    

        data_out[63] = data_mask_in_buf[63] ? data_in_buf[63] : data_out_real[63];
    

        data_out[64] = data_mask_in_buf[64] ? data_in_buf[64] : data_out_real[64];
    

        data_out[65] = data_mask_in_buf[65] ? data_in_buf[65] : data_out_real[65];
    

    end
    else
    begin
        data_out = data_out_real;
    end
end

 // sram_2rw_256x66 l2_state_array (
 sram_l2_state l2_state_array (
     .RESET_N(rst_n),
     .MEMCLK         (clk),

     .CEA            (rd_en),
     .RDWENA          (1'b1),
     .AA             (rd_addr),
     .BWA             (),
     .DINA            (),
     .DOUTA           (data_out_real),

     .CEB            (wr_en),
     .RDWENB            (1'b0),
     .AB             (wr_addr),
     .BWB             (data_mask_in),
     .DINB            (data_in),
     .DOUTB           (),

    .BIST_COMMAND(rtap_srams_bist_command),
    .BIST_DIN(rtap_srams_bist_data),
    .BIST_DOUT(srams_rtap_data),
    .SRAMID(`BIST_ID_L2_STATE)

 );





endmodule

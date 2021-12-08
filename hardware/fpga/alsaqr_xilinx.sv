//-----------------------------------------------------------------------------
// Title         : PULPissimo Verilog Wrapper
//-----------------------------------------------------------------------------
// File          : alsaqr_xilinx.v
// Author        : Luca Valente <luca.valente@unibo.it>
// Created       : 15-07-2021
//-----------------------------------------------------------------------------
// Description :
// Verilog Wrapper of AlSaqr to use the module within Xilinx IP integrator.
//-----------------------------------------------------------------------------
// Copyright (C) 2021 ETH Zurich, University of Bologna
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//-----------------------------------------------------------------------------

module alsaqr_xilinx
  (
   input wire  ref_clk_p,
   input wire  ref_clk_n,

   inout wire  pad_uart_rx,
   inout wire  pad_uart_tx,
   
   inout       FMC_hyper0_dqio0 ,
   inout       FMC_hyper0_dqio1 ,
   inout       FMC_hyper0_dqio2 ,
   inout       FMC_hyper0_dqio3 ,
   inout       FMC_hyper0_dqio4 ,
   inout       FMC_hyper0_dqio5 ,
   inout       FMC_hyper0_dqio6 ,
   inout       FMC_hyper0_dqio7 ,
   inout       FMC_hyper0_ck    ,
   inout       FMC_hyper0_ckn   ,
   inout       FMC_hyper0_csn0  ,
   inout       FMC_hyper0_csn1  ,
   inout       FMC_hyper0_rwds  ,
   inout       FMC_hyper0_reset ,

   inout       FMC_hyper1_dqio0 ,
   inout       FMC_hyper1_dqio1 ,
   inout       FMC_hyper1_dqio2 ,
   inout       FMC_hyper1_dqio3 ,
   inout       FMC_hyper1_dqio4 ,
   inout       FMC_hyper1_dqio5 ,
   inout       FMC_hyper1_dqio6 ,
   inout       FMC_hyper1_dqio7 ,
   inout       FMC_hyper1_ck    ,
   inout       FMC_hyper1_ckn   ,
   inout       FMC_hyper1_csn0  ,
   inout       FMC_hyper1_csn1  ,
   inout       FMC_hyper1_rwds0 ,
   inout       FMC_hyper1_reset ,

   input wire  pad_reset,

   input wire  pad_jtag_trst,
   input wire  pad_jtag_tck,
   input wire  pad_jtag_tdi,
   output wire pad_jtag_tdo,
   input wire  pad_jtag_tms
  );

   wire        ref_clk;
   
   //Differential to single ended clock conversion
   IBUFGDS
     #(
       .IOSTANDARD("LVDS"),
       .DIFF_TERM("FALSE"),
       .IBUF_LOW_PWR("FALSE"))
   i_sysclk_iobuf
     (
      .I(ref_clk_p),
      .IB(ref_clk_n),
      .O(ref_clk)
      );
   
   logic       s_locked;
   logic       s_clk;
   
   logic       reset_n;

   assign reset_n = ~pad_reset & pad_jtag_trst;

   wire [7:0] s_pad_hyper0_dq;
   wire [1:0] s_pad_hyper0_csn;
   wire [7:0] s_pad_hyper1_dq;
   wire [1:0] s_pad_hyper1_csn;

   assign s_pad_hyper0_csn[0] = FMC_hyper0_csn0;
   assign s_pad_hyper0_csn[1] = FMC_hyper0_csn1;   
   assign s_pad_hyper0_dq[0]  = FMC_hyper0_dqio0;
   assign s_pad_hyper0_dq[1]  = FMC_hyper0_dqio1;
   assign s_pad_hyper0_dq[2]  = FMC_hyper0_dqio2;
   assign s_pad_hyper0_dq[3]  = FMC_hyper0_dqio3;
   assign s_pad_hyper0_dq[4]  = FMC_hyper0_dqio4;
   assign s_pad_hyper0_dq[5]  = FMC_hyper0_dqio5;
   assign s_pad_hyper0_dq[6]  = FMC_hyper0_dqio6;
   assign s_pad_hyper0_dq[7]  = FMC_hyper0_dqio7;

   assign s_pad_hyper1_csn[0] = FMC_hyper1_csn0;
   assign s_pad_hyper1_csn[1] = FMC_hyper1_csn1;   
   assign s_pad_hyper1_dq[0]  = FMC_hyper1_dqio0;
   assign s_pad_hyper1_dq[1]  = FMC_hyper1_dqio1;
   assign s_pad_hyper1_dq[2]  = FMC_hyper1_dqio2;
   assign s_pad_hyper1_dq[3]  = FMC_hyper1_dqio3;
   assign s_pad_hyper1_dq[4]  = FMC_hyper1_dqio4;
   assign s_pad_hyper1_dq[5]  = FMC_hyper1_dqio5;
   assign s_pad_hyper1_dq[6]  = FMC_hyper1_dqio6;
   assign s_pad_hyper1_dq[7]  = FMC_hyper1_dqio7;
   
    al_saqr #(
        .JtagEnable        ( 1'b1          )
    ) i_alsaqr (
        .rst_ni           ( reset_n          ),
        .rtc_i            ( ref_clk          ),
        .jtag_TCK         ( pad_jtag_tck     ),
        .jtag_TMS         ( pad_jtag_tms     ),
        .jtag_TDI         ( pad_jtag_tdi     ),
        .jtag_TRSTn       ( 1'b1             ),
        .jtag_TDO_data    ( pad_jtag_tdo     ),
        .jtag_TDO_driven  (                  ),
        .pad_hyper_dq0    (                  ),
        .pad_hyper_dq1    (                  ),
        .pad_hyper_ck     (                  ),
        .pad_hyper_ckn    (                  ),
        .pad_hyper_csn0   (                  ),
        .pad_hyper_csn1   (                  ),
        .pad_hyper_rwds0  (                  ),
        .pad_hyper_rwds1  (                  ),
        .pad_hyper_reset  (                  ),
        .cva6_uart_rx_i   ( pad_uart_rx      ),
        .cva6_uart_tx_o   ( pad_uart_tx      ),

        .pad_hyper0_dq    ( s_pad_hyper0_dq  ),
        .pad_hyper0_ck    ( FMC_hyper0_ck    ),
        .pad_hyper0_ckn   ( FMC_hyper0_ckn   ),
        .pad_hyper0_csn   ( s_pad_hyper0_csn ),
        .pad_hyper0_rwds  ( FMC_hyper0_rwds  ),
        .pad_hyper0_reset ( FMC_hyper0_reset ),

        .pad_hyper1_dq    ( s_pad_hyper1_dq  ),
        .pad_hyper1_ck    ( FMC_hyper1_ck    ),
        .pad_hyper1_ckn   ( FMC_hyper1_ckn   ),
        .pad_hyper1_csn   ( s_pad_hyper1_csn ),
        .pad_hyper1_rwds  ( FMC_hyper1_rwds  ),
        .pad_hyper1_reset ( FMC_hyper1_reset )
   );


endmodule

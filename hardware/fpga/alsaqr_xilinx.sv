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
    input         c0_sys_clk_p,
    input         c0_sys_clk_n,
    inout wire    pad_uart0_rx,
    inout wire    pad_uart0_tx,
    inout wire    pad_uart1_rx,
    inout wire    pad_uart1_tx,
      
    input wire    pad_reset,

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
    
    input wire    pad_jtag_trst,
    input wire    pad_jtag_tck,
    input wire    pad_jtag_tdi,
    output wire   pad_jtag_tdo,
    input wire    pad_jtag_tms
  );

  `ifdef EXCLUDE_LLC
   localparam AXI_ID_WIDTH = 7;
  `else
   localparam AXI_ID_WIDTH = 8;
  `endif
   
   wire        ref_clk;
   wire        ddr_ref_clk;
   logic       s_locked;
   logic       s_clk;
   
   logic       reset_n;
        
   assign reset_n = ~pad_reset & pad_jtag_trst;

  //***********************************************************************
  // Differential input clock input buffers
  //***********************************************************************
  wire c0_sys_clk_o;
  wire c0_sys_clk_s;
   
  IBUFDS #
    (
     .IBUF_LOW_PWR ("FALSE")
     )
    u_ibufg_sys_clk
      (
       .I  (c0_sys_clk_p),
       .IB (c0_sys_clk_n),
       .O  (c0_sys_clk_s)
       );  

  IBUF #
    (
     .IBUF_LOW_PWR ("FALSE")
     ) u_ibufg_sys_clk_o
      (
       .I  (c0_sys_clk_s),
       .O  (c0_sys_clk_o)
       );  

   xilinx_clk_mngr alsaqr_clk_manager(
                                      .resetn(reset_n),
                                      .locked(),
                                      .clk_in1(c0_sys_clk_o),
                                      .clk_out1(ref_clk)
                                      );

    localparam NumPhys = 1;
    wire  [NumPhys-1:0][1:0] hyper_cs_n_wire    ;
    wire  [NumPhys-1:0]      hyper_ck_wire      ;
    wire  [NumPhys-1:0]      hyper_ck_n_wire    ;
    wire  [NumPhys-1:0]      hyper_rwds_wire    ;
    wire  [NumPhys-1:0][7:0] hyper_dq_wire      ;
    wire  [NumPhys-1:0]      hyper_reset_n_wire ;

    al_saqr #(
        .JtagEnable        ( 1'b1          )
    ) i_alsaqr (
        .rst_ni           ( reset_n            ),
        .rtc_i            ( ref_clk            ),
        .jtag_TCK         ( pad_jtag_tck       ),
        .jtag_TMS         ( pad_jtag_tms       ),
        .jtag_TDI         ( pad_jtag_tdi       ),
        .jtag_TRSTn       ( 1'b1               ),
        .jtag_TDO_data    ( pad_jtag_tdo       ),
        .jtag_TDO_driven  (                    ),

        .pad_hyper_csn    ( hyper_cs_n_wire     ),
        .pad_hyper_ck     ( hyper_ck_wire       ),
        .pad_hyper_ckn    ( hyper_ck_n_wire     ),
        .pad_hyper_rwds   ( hyper_rwds_wire     ),
        .pad_hyper_reset  ( hyper_reset_n_wire  ),
        .pad_hyper_dq     ( hyper_dq_wire       ),
                
        .cva6_uart_rx_i   ( pad_uart0_rx       ),
        .cva6_uart_tx_o   ( pad_uart0_tx       ),

        .apb_uart_rx_i    ( pad_uart1_rx       ),
        .apb_uart_tx_o    ( pad_uart1_tx       )
                
   );

   assign hyper_cs_n_wire[0][0] = FMC_hyper0_csn0;
   assign hyper_cs_n_wire[0][1] = FMC_hyper0_csn1;
   assign hyper_ck_wire[0]      = FMC_hyper0_ck;
   assign hyper_ck_n_wire[0]    = FMC_hyper0_ckn;
   assign hyper_rwds_wire[0]    = FMC_hyper0_rwds;
   assign hyper_reset_n_wire[0] = FMC_hyper0_reset;
   assign hyper_dq_wire[0][0]   = FMC_hyper0_dqio0;
   assign hyper_dq_wire[0][1]   = FMC_hyper0_dqio1;
   assign hyper_dq_wire[0][2]   = FMC_hyper0_dqio2;
   assign hyper_dq_wire[0][3]   = FMC_hyper0_dqio3;
   assign hyper_dq_wire[0][4]   = FMC_hyper0_dqio4;
   assign hyper_dq_wire[0][5]   = FMC_hyper0_dqio5;
   assign hyper_dq_wire[0][6]   = FMC_hyper0_dqio6;
   assign hyper_dq_wire[0][7]   = FMC_hyper0_dqio7;

endmodule

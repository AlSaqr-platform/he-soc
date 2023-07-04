// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Date: 15/04/2017
// Description: Top level testbench module. Instantiates the top level DUT, configures
//              the virtual interfaces and starts the test passed by +UVM_TEST+
//`define TEST_CLOCK_BYPASS

`timescale 1ps/1ps

import ariane_pkg::*;
import uvm_pkg::*;
import ariane_soc::*;

`include "uvm_macros.svh"
`include "axi/assign.svh"
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

`define POWER_PROFILE
`define POWER_CVA6

import "DPI-C" function byte read_elf(input string filename);
import "DPI-C" function byte get_entry(output longint entry);
import "DPI-C" function byte get_section(output longint address, output longint len);
import "DPI-C" context function byte read_section(input longint address, inout byte buffer[], input longint len);


module ariane_tb;

    static uvm_cmdline_processor uvcl = uvm_cmdline_processor::get_inst();

    localparam int unsigned REFClockPeriod = 67000ps; // jtag clock
    // toggle with RTC period
    `ifndef TEST_CLOCK_BYPASS
      localparam int unsigned RTC_CLOCK_PERIOD = 30.517us;
    `else
      localparam int unsigned RTC_CLOCK_PERIOD = 10ns;
    `endif

    localparam NUM_WORDS = 2**25;
    logic clk_i;
    logic rst_ni;
    logic rtc_i;
    logic s_rst_ni;
    logic s_rtc_i;
    logic s_bypass;
    logic rst_DTM;
    localparam NumPhys = ariane_soc::HyperbusNumPhys;
    localparam NumChips = ariane_soc::NumChipsPerHyperbus;

    localparam ENABLE_DM_TESTS = 0;

    parameter  USE_HYPER_MODELS     = 1;
    parameter  USE_24FC1025_MODEL   = 1;
    parameter  USE_S25FS256S_MODEL  = 1;
    parameter  USE_UART             = 1;

    `ifndef FPGA_EMUL
      `ifndef SIMPLE_PADFRAME
        parameter  USE_SDIO_0       = 0;
        parameter  USE_SDIO_1       = 1;
      `else
        parameter  USE_SDIO_0       = 1;
        parameter  USE_SDIO_1       = 0;
      `endif
    `else
      parameter  USE_SDIO_0       = 0;
      parameter  USE_SDIO_1       = 1;
    `endif

    // use camera verification IP
    `ifndef FPGA_EMUL
      `ifndef SIMPLE_PADFRAME
        parameter  USE_SDVT_CPI = 1; /// IMPORTANT, SET IT BACK TO 1 AFTER TEST I2C MEM1
      `else
        parameter  USE_SDVT_CPI = 0;
      `endif
    `else
      parameter  USE_SDVT_CPI = 0;
    `endif

  `ifdef PRELOAD
    parameter  PRELOAD_HYPERRAM    = 1;
    parameter  LOCAL_JTAG          = 1;
    parameter  CHECK_LOCAL_JTAG    = 0;
    // when preload is enabled LINKER_ENTRY specifies the linker address (L3: 32'h80000000 - L2: 32'h1C000000)
    parameter  LINKER_ENTRY        = 32'h80000000;
  `else
    parameter PRELOAD_HYPERRAM = 0;
    parameter  LINKER_ENTRY    = 0;
    `ifdef USE_LOCAL_JTAG
      parameter  LOCAL_JTAG          = 1;
      parameter  CHECK_LOCAL_JTAG    = 0;
    `else
      parameter  LOCAL_JTAG          = 0;
      parameter  CHECK_LOCAL_JTAG    = 0;
    `endif
  `endif

  `ifdef POSTLAYOUT
    localparam int unsigned JtagSampleDelay = (REFClockPeriod < 10ns) ? 2 : 1;
  `else
    localparam int unsigned JtagSampleDelay = 0;
  `endif

  `ifdef JTAG_RBB
    parameter int   jtag_enable = '1 ;
  `else
    parameter int   jtag_enable = '0 ;
  `endif

    localparam logic [15:0] PartNumber = 1;
    logic program_loaded = 0;
    logic  eoc;
    logic [31:0]  retval = 32'h0;  // Store return value

    localparam AxiWideBeWidth    = ariane_axi_soc::DataWidth / 8;
    localparam AxiWideByteOffset = $clog2(AxiWideBeWidth);
    typedef logic [ariane_axi_soc::AddrWidth-1:0] addr_t;
    typedef logic [ariane_axi_soc::DataWidth-1:0] data_t;
    data_t memory [bit [31:0]];
    int sections  [bit [31:0]];

    wire                  s_dmi_req_valid;
    wire                  s_dmi_req_ready;
    wire [ 6:0]           s_dmi_req_bits_addr;
    wire [ 1:0]           s_dmi_req_bits_op;
    wire [31:0]           s_dmi_req_bits_data;
    wire                  s_dmi_resp_valid;
    wire                  s_dmi_resp_ready;
    wire [ 1:0]           s_dmi_resp_bits_resp;
    wire [31:0]           s_dmi_resp_bits_data;
    wire                  s_dmi_exit;

    wire                  s_jtag_TCK       ;
    wire                  s_jtag_TMS       ;
    wire                  s_jtag_TDI       ;
    wire                  s_jtag_TRSTn     ;
    wire                  s_jtag_TDO_data  ;
    wire                  s_jtag_TDO_driven;
    wire                  s_jtag_exit      ;

    string                stimuli_file      ;
    logic                 s_tck         ;
    logic                 s_tms         ;
    logic                 s_tdi         ;
    logic                 s_trstn       ;
    logic                 s_tdo         ;

    wire                  s_jtag_to_alsaqr_tck       ;
    wire                  s_jtag_to_alsaqr_tms       ;
    wire                  s_jtag_to_alsaqr_tdi       ;
    wire                  s_jtag_to_alsaqr_trstn     ;
    wire                  s_jtag_to_alsaqr_tdo       ;

    wire  [NumPhys-1:0][1:0] hyper_cs_n_wire;
    wire  [NumPhys-1:0]      hyper_ck_wire;
    wire  [NumPhys-1:0]      hyper_ck_n_wire;
    wire  [NumPhys-1:0]      hyper_rwds_wire;
    wire  [NumPhys-1:0][7:0] hyper_dq_wire;
    wire  [NumPhys-1:0]      hyper_reset_n_wire;

    wire                  soc_clock;

    wire                  w_i2c_sda      ;
    wire                  w_i2c_scl      ;

    tri                   w_spim_sck     ;
    tri                   w_spim_csn0    ;
    tri                   w_spim_sdio0   ;
    wire                  w_spim_sdio1   ;
    tri                   w_spim_sdio2   ;
    tri                   w_spim_sdio3   ;

    wire                  w_cam_pclk;
    wire [7:0]            w_cam_data;
    wire                  w_cam_hsync;
    wire                  w_cam_vsync;

    //NEW PAD PERIPHERALS SIGNALS
    wire    pad_periphs_pad_gpio_b_00_pad;
    wire    pad_periphs_pad_gpio_b_01_pad;
    wire    pad_periphs_pad_gpio_b_02_pad;
    wire    pad_periphs_pad_gpio_b_03_pad;
    wire    pad_periphs_pad_gpio_b_04_pad;
    wire    pad_periphs_pad_gpio_b_05_pad;
    wire    pad_periphs_pad_gpio_b_06_pad;
    wire    pad_periphs_pad_gpio_b_07_pad;
    wire    pad_periphs_pad_gpio_b_08_pad;
    wire    pad_periphs_pad_gpio_b_09_pad;
    wire    pad_periphs_pad_gpio_b_10_pad;
    wire    pad_periphs_pad_gpio_b_11_pad;
    wire    pad_periphs_pad_gpio_b_12_pad;
    wire    pad_periphs_pad_gpio_b_13_pad;
    wire    pad_periphs_pad_gpio_b_14_pad;
    wire    pad_periphs_pad_gpio_b_15_pad;
    wire    pad_periphs_pad_gpio_b_16_pad;
    wire    pad_periphs_pad_gpio_b_17_pad;
    wire    pad_periphs_pad_gpio_b_18_pad;
    wire    pad_periphs_pad_gpio_b_19_pad;
    wire    pad_periphs_pad_gpio_b_20_pad;
    wire    pad_periphs_pad_gpio_b_21_pad;
    wire    pad_periphs_pad_gpio_b_22_pad;
    wire    pad_periphs_pad_gpio_b_23_pad;
    wire    pad_periphs_pad_gpio_b_24_pad;
    wire    pad_periphs_pad_gpio_b_25_pad;
    wire    pad_periphs_pad_gpio_b_26_pad;
    wire    pad_periphs_pad_gpio_b_27_pad;
    wire    pad_periphs_pad_gpio_b_28_pad;
    wire    pad_periphs_pad_gpio_b_29_pad;
    wire    pad_periphs_pad_gpio_b_30_pad;
    wire    pad_periphs_pad_gpio_b_31_pad;
    wire    pad_periphs_pad_gpio_b_32_pad;
    wire    pad_periphs_pad_gpio_b_33_pad;
    wire    pad_periphs_pad_gpio_b_34_pad;
    wire    pad_periphs_pad_gpio_b_35_pad;
    wire    pad_periphs_pad_gpio_b_36_pad;
    wire    pad_periphs_pad_gpio_b_37_pad;
    wire    pad_periphs_pad_gpio_b_38_pad;
    wire    pad_periphs_pad_gpio_b_39_pad;
    wire    pad_periphs_pad_gpio_b_40_pad;
    wire    pad_periphs_pad_gpio_b_41_pad;
    wire    pad_periphs_pad_gpio_b_42_pad;
    wire    pad_periphs_pad_gpio_b_43_pad;
    wire    pad_periphs_pad_gpio_b_44_pad;
    wire    pad_periphs_pad_gpio_b_45_pad;
    wire    pad_periphs_pad_gpio_b_46_pad;
    wire    pad_periphs_pad_gpio_b_47_pad;
    wire    pad_periphs_pad_gpio_b_48_pad;
    wire    pad_periphs_pad_gpio_b_49_pad;
    wire    pad_periphs_pad_gpio_b_50_pad;
    wire    pad_periphs_pad_gpio_b_51_pad;
    wire    pad_periphs_pad_gpio_b_52_pad;
    wire    pad_periphs_pad_gpio_b_53_pad;
    wire    pad_periphs_pad_gpio_b_54_pad;
    wire    pad_periphs_pad_gpio_b_55_pad;
    wire    pad_periphs_pad_gpio_b_56_pad;
    wire    pad_periphs_pad_gpio_b_57_pad;
    wire    pad_periphs_pad_gpio_b_58_pad;
    wire    pad_periphs_pad_gpio_b_59_pad;
    wire    pad_periphs_pad_gpio_b_60_pad;
    wire    pad_periphs_pad_gpio_b_61_pad;
    wire    pad_periphs_pad_gpio_c_00_pad;
    wire    pad_periphs_pad_gpio_c_01_pad;
    wire    pad_periphs_pad_gpio_c_02_pad;
    wire    pad_periphs_pad_gpio_c_03_pad;
    wire    pad_periphs_pad_gpio_d_00_pad;
    wire    pad_periphs_pad_gpio_d_01_pad;
    wire    pad_periphs_pad_gpio_d_02_pad;
    wire    pad_periphs_pad_gpio_d_03_pad;
    wire    pad_periphs_pad_gpio_d_04_pad;
    wire    pad_periphs_pad_gpio_d_05_pad;
    wire    pad_periphs_pad_gpio_d_06_pad;
    wire    pad_periphs_pad_gpio_d_07_pad;
    wire    pad_periphs_pad_gpio_d_08_pad;
    wire    pad_periphs_pad_gpio_d_09_pad;
    wire    pad_periphs_pad_gpio_d_10_pad;
    wire    pad_periphs_pad_gpio_e_00_pad;
    wire    pad_periphs_pad_gpio_e_01_pad;
    wire    pad_periphs_pad_gpio_e_02_pad;
    wire    pad_periphs_pad_gpio_e_03_pad;
    wire    pad_periphs_pad_gpio_e_04_pad;
    wire    pad_periphs_pad_gpio_e_05_pad;
    wire    pad_periphs_pad_gpio_e_06_pad;
    wire    pad_periphs_pad_gpio_e_07_pad;
    wire    pad_periphs_pad_gpio_e_08_pad;
    wire    pad_periphs_pad_gpio_e_09_pad;
    wire    pad_periphs_pad_gpio_e_10_pad;
    wire    pad_periphs_pad_gpio_e_11_pad;
    wire    pad_periphs_pad_gpio_e_12_pad;
    wire    pad_periphs_pad_gpio_f_00_pad;
    wire    pad_periphs_pad_gpio_f_01_pad;
    wire    pad_periphs_pad_gpio_f_02_pad;
    wire    pad_periphs_pad_gpio_f_03_pad;
    wire    pad_periphs_pad_gpio_f_04_pad;
    wire    pad_periphs_pad_gpio_f_05_pad;
    wire    pad_periphs_pad_gpio_f_06_pad;
    wire    pad_periphs_pad_gpio_f_07_pad;
    wire    pad_periphs_pad_gpio_f_08_pad;
    wire    pad_periphs_pad_gpio_f_09_pad;
    wire    pad_periphs_pad_gpio_f_10_pad;
    wire    pad_periphs_pad_gpio_f_11_pad;
    wire    pad_periphs_pad_gpio_f_12_pad;
    wire    pad_periphs_pad_gpio_f_13_pad;
    wire    pad_periphs_pad_gpio_f_14_pad;
    wire    pad_periphs_pad_gpio_f_15_pad;
    wire    pad_periphs_pad_gpio_f_16_pad;

    wire    pad_periphs_pad_gpio_pwm0_pad;
    wire    pad_periphs_pad_gpio_pwm1_pad;
    wire    pad_periphs_pad_gpio_pwm2_pad;
    wire    pad_periphs_pad_gpio_pwm3_pad;
    wire    pad_periphs_pad_gpio_pwm4_pad;
    wire    pad_periphs_pad_gpio_pwm5_pad;
    wire    pad_periphs_pad_gpio_pwm6_pad;
    wire    pad_periphs_pad_gpio_pwm7_pad;


    wire                  w_cva6_uart_rx ;
    wire                  w_cva6_uart_tx ;
    wire                  apb_uart_rx ;
    wire                  apb_uart_tx ;

    wire ddr_ext_clk;

    longint unsigned cycles;
    longint unsigned max_cycles;

    logic [31:0] exit_o;
    bit [31:0]  exit_code;

    string        binary ;
    string        cluster_binary;

  // NB: This test is not used on FPGA
  `ifndef FPGA_EMUL
    `ifndef SIMPLE_PADFRAME
      assign pad_periphs_pad_gpio_b_37_pad = pad_periphs_pad_gpio_b_05_pad;
      assign pad_periphs_pad_gpio_b_38_pad = pad_periphs_pad_gpio_b_06_pad;
      assign pad_periphs_pad_gpio_b_39_pad = pad_periphs_pad_gpio_b_07_pad;
    `endif
  `endif

  `ifndef TEST_CLOCK_BYPASS
    assign s_bypass=1'b0;
  `else
    assign s_bypass=1'b1;
  `endif

  assign s_rst_ni=rst_ni;
  assign s_rtc_i=rtc_i;

  assign exit_o              = (jtag_enable[0]) ? s_jtag_exit          : s_dmi_exit;

  assign s_jtag_to_alsaqr_tck    = LOCAL_JTAG==1  ?  s_tck   : s_jtag_TCK   ;
  assign s_jtag_to_alsaqr_tms    = LOCAL_JTAG==1  ?  s_tms   : s_jtag_TMS   ;
  assign s_jtag_to_alsaqr_tdi    = LOCAL_JTAG==1  ?  s_tdi   : s_jtag_TDI   ;
  assign s_jtag_to_alsaqr_trstn  = LOCAL_JTAG==1  ?  s_trstn : s_jtag_TRSTn ;
  assign s_jtag_TDO_data      = s_jtag_to_alsaqr_tdo       ;
  assign s_tdo                = s_jtag_to_alsaqr_tdo       ;

  if (~jtag_enable[0] & !LOCAL_JTAG) begin
    SimDTM i_SimDTM (
      .clk                  ( clk_i                 ),
      .reset                ( ~rst_DTM              ),
      .debug_req_valid      ( s_dmi_req_valid       ),
      .debug_req_ready      ( s_dmi_req_ready       ),
      .debug_req_bits_addr  ( s_dmi_req_bits_addr   ),
      .debug_req_bits_op    ( s_dmi_req_bits_op     ),
      .debug_req_bits_data  ( s_dmi_req_bits_data   ),
      .debug_resp_valid     ( s_dmi_resp_valid      ),
      .debug_resp_ready     ( s_dmi_resp_ready      ),
      .debug_resp_bits_resp ( s_dmi_resp_bits_resp  ),
      .debug_resp_bits_data ( s_dmi_resp_bits_data  ),
      .exit                 ( s_dmi_exit            )
    );
  end else begin
    assign dmi_req_valid = '0;
    assign debug_req_bits_op = '0;
    assign dmi_exit = 1'b0;
  end

  // SiFive's SimJTAG Module
  // Converts to DPI calls
  SimJTAG i_SimJTAG (
    .clock                ( clk_i                ),
    .reset                ( ~rst_ni              ),
    .enable               ( jtag_enable[0]       ),
    .init_done            ( rst_ni               ),
    .jtag_TCK             ( s_jtag_TCK           ),
    .jtag_TMS             ( s_jtag_TMS           ),
    .jtag_TDI             ( s_jtag_TDI           ),
    .jtag_TRSTn           ( s_jtag_TRSTn         ),
    .jtag_TDO_data        ( s_jtag_TDO_data      ),
    .jtag_TDO_driven      ( s_jtag_TDO_driven    ),
    .exit                 ( s_jtag_exit          )
  );

    al_saqr
    `ifndef TARGET_TOP_POST_SYNTH_SIM #(
        .NUM_WORDS         ( NUM_WORDS                   ),
        .InclSimDTM        ( 1'b1                        ),
        .StallRandomOutput ( 1'b1                        ),
        .StallRandomInput  ( 1'b1                        ),
        .JtagEnable        ( jtag_enable[0] | LOCAL_JTAG )
    ) `endif dut (
        .rst_ni               ( s_rst_ni               ),
        .rtc_i                ( s_rtc_i                ),
        .bypass_clk_i         ( s_bypass               ),
        `ifndef TARGET_TOP_POST_SYNTH_SIM
          .dmi_req_valid        ( s_dmi_req_valid        ),
          .dmi_req_ready        ( s_dmi_req_ready        ),
          .dmi_req_bits_addr    ( s_dmi_req_bits_addr    ),
          .dmi_req_bits_op      ( s_dmi_req_bits_op      ),
          .dmi_req_bits_data    ( s_dmi_req_bits_data    ),
          .dmi_resp_valid       ( s_dmi_resp_valid       ),
          .dmi_resp_ready       ( s_dmi_resp_ready       ),
          .dmi_resp_bits_resp   ( s_dmi_resp_bits_resp   ),
          .dmi_resp_bits_data   ( s_dmi_resp_bits_data   ),
        `endif
          .jtag_TCK             ( s_jtag_to_alsaqr_tck      ),
          .jtag_TMS             ( s_jtag_to_alsaqr_tms      ),
          .jtag_TDI             ( s_jtag_to_alsaqr_tdi      ),
          .jtag_TRSTn           ( s_jtag_to_alsaqr_trstn    ),
          .jtag_TDO_data        ( s_jtag_to_alsaqr_tdo      ),
          .jtag_TDO_driven      ( s_jtag_TDO_driven      ),

          .cva6_uart_rx_i       ( w_cva6_uart_rx         ),
          .cva6_uart_tx_o       ( w_cva6_uart_tx         ),
          .apb_uart_rx_i        ( apb_uart_rx            ),
          .apb_uart_tx_o        ( apb_uart_tx            ),

        `ifndef EXCLUDE_PADFRAME
          .pad_periphs_pad_gpio_b_00_pad(pad_periphs_pad_gpio_b_00_pad),
          .pad_periphs_pad_gpio_b_01_pad(pad_periphs_pad_gpio_b_01_pad),
          .pad_periphs_pad_gpio_b_02_pad(pad_periphs_pad_gpio_b_02_pad),
          .pad_periphs_pad_gpio_b_03_pad(pad_periphs_pad_gpio_b_03_pad),
          .pad_periphs_pad_gpio_b_04_pad(pad_periphs_pad_gpio_b_04_pad),
          .pad_periphs_pad_gpio_b_05_pad(pad_periphs_pad_gpio_b_05_pad),
          .pad_periphs_pad_gpio_b_06_pad(pad_periphs_pad_gpio_b_06_pad),
          .pad_periphs_pad_gpio_b_07_pad(pad_periphs_pad_gpio_b_07_pad),
          .pad_periphs_pad_gpio_b_08_pad(pad_periphs_pad_gpio_b_08_pad),
          .pad_periphs_pad_gpio_b_09_pad(pad_periphs_pad_gpio_b_09_pad),
          .pad_periphs_pad_gpio_b_10_pad(pad_periphs_pad_gpio_b_10_pad),
          .pad_periphs_pad_gpio_b_11_pad(pad_periphs_pad_gpio_b_11_pad),
          .pad_periphs_pad_gpio_b_12_pad(pad_periphs_pad_gpio_b_12_pad),
          .pad_periphs_pad_gpio_b_13_pad(pad_periphs_pad_gpio_b_13_pad),

          `ifndef FPGA_EMUL
            `ifndef SIMPLE_PADFRAME
              .pad_periphs_pad_gpio_b_14_pad(),
              .pad_periphs_pad_gpio_b_15_pad(),
              .pad_periphs_pad_gpio_b_16_pad(),
              .pad_periphs_pad_gpio_b_17_pad(),
              .pad_periphs_pad_gpio_b_18_pad(),
              .pad_periphs_pad_gpio_b_19_pad(),
              .pad_periphs_pad_gpio_b_20_pad(),
              .pad_periphs_pad_gpio_b_21_pad(),
              .pad_periphs_pad_gpio_b_22_pad(),
              .pad_periphs_pad_gpio_b_23_pad(),
              .pad_periphs_pad_gpio_b_24_pad(),
              .pad_periphs_pad_gpio_b_25_pad(),
              .pad_periphs_pad_gpio_b_26_pad(),
              .pad_periphs_pad_gpio_b_27_pad(),
              .pad_periphs_pad_gpio_b_28_pad(),
              .pad_periphs_pad_gpio_b_29_pad(),
              .pad_periphs_pad_gpio_b_30_pad(),
              .pad_periphs_pad_gpio_b_31_pad(),
              .pad_periphs_pad_gpio_b_32_pad(),
              .pad_periphs_pad_gpio_b_33_pad(),
              .pad_periphs_pad_gpio_b_34_pad(pad_periphs_pad_gpio_b_34_pad),
              .pad_periphs_pad_gpio_b_35_pad(pad_periphs_pad_gpio_b_35_pad),
              .pad_periphs_pad_gpio_b_36_pad(pad_periphs_pad_gpio_b_36_pad),
              .pad_periphs_pad_gpio_b_37_pad(pad_periphs_pad_gpio_b_37_pad),
              .pad_periphs_pad_gpio_b_38_pad(pad_periphs_pad_gpio_b_38_pad),
              .pad_periphs_pad_gpio_b_39_pad(pad_periphs_pad_gpio_b_39_pad),
              .pad_periphs_pad_gpio_b_40_pad(pad_periphs_pad_gpio_b_40_pad),
              .pad_periphs_pad_gpio_b_41_pad(pad_periphs_pad_gpio_b_41_pad),
              .pad_periphs_pad_gpio_b_42_pad(),
              .pad_periphs_pad_gpio_b_43_pad(),
              .pad_periphs_pad_gpio_b_44_pad(pad_periphs_pad_gpio_b_44_pad),
              .pad_periphs_pad_gpio_b_45_pad(pad_periphs_pad_gpio_b_45_pad),
              .pad_periphs_pad_gpio_b_46_pad(pad_periphs_pad_gpio_b_46_pad),
              .pad_periphs_pad_gpio_b_47_pad(),
              .pad_periphs_pad_gpio_b_48_pad(),
              .pad_periphs_pad_gpio_b_49_pad(),
              .pad_periphs_pad_gpio_b_50_pad(pad_periphs_pad_gpio_b_50_pad),
              .pad_periphs_pad_gpio_b_51_pad(pad_periphs_pad_gpio_b_51_pad),
              .pad_periphs_pad_gpio_b_52_pad(),
              .pad_periphs_pad_gpio_b_53_pad(),
              .pad_periphs_pad_gpio_b_54_pad(),
              .pad_periphs_pad_gpio_b_55_pad(),
              .pad_periphs_pad_gpio_b_56_pad(pad_periphs_pad_gpio_b_56_pad),
              .pad_periphs_pad_gpio_b_57_pad(pad_periphs_pad_gpio_b_57_pad),

              .pad_periphs_pad_gpio_c_00_pad(),
              .pad_periphs_pad_gpio_c_01_pad(),
              .pad_periphs_pad_gpio_c_02_pad(),
              .pad_periphs_pad_gpio_c_03_pad(),

              .pad_periphs_pad_gpio_d_00_pad(pad_periphs_pad_gpio_d_00_pad),
              .pad_periphs_pad_gpio_d_01_pad(pad_periphs_pad_gpio_d_01_pad),
              .pad_periphs_pad_gpio_d_02_pad(pad_periphs_pad_gpio_d_02_pad),
              .pad_periphs_pad_gpio_d_03_pad(pad_periphs_pad_gpio_d_03_pad),
              .pad_periphs_pad_gpio_d_04_pad(pad_periphs_pad_gpio_d_04_pad),
              .pad_periphs_pad_gpio_d_05_pad(pad_periphs_pad_gpio_d_05_pad),
              .pad_periphs_pad_gpio_d_06_pad(pad_periphs_pad_gpio_d_06_pad),
              .pad_periphs_pad_gpio_d_07_pad(pad_periphs_pad_gpio_d_07_pad),
              .pad_periphs_pad_gpio_d_08_pad(pad_periphs_pad_gpio_d_08_pad),
              .pad_periphs_pad_gpio_d_09_pad(pad_periphs_pad_gpio_d_09_pad),
              .pad_periphs_pad_gpio_d_10_pad(pad_periphs_pad_gpio_d_10_pad),

              .pad_periphs_pad_gpio_e_00_pad(),
              .pad_periphs_pad_gpio_e_01_pad(),
              .pad_periphs_pad_gpio_e_02_pad(),
              .pad_periphs_pad_gpio_e_03_pad(),
              .pad_periphs_pad_gpio_e_04_pad(),
              .pad_periphs_pad_gpio_e_05_pad(),
              .pad_periphs_pad_gpio_e_06_pad(),
              .pad_periphs_pad_gpio_e_07_pad(),
              .pad_periphs_pad_gpio_e_08_pad(),
              .pad_periphs_pad_gpio_e_09_pad(),
              .pad_periphs_pad_gpio_e_10_pad(),
              .pad_periphs_pad_gpio_e_11_pad(),
              .pad_periphs_pad_gpio_e_12_pad(),

              .pad_periphs_pad_gpio_f_00_pad(),
              .pad_periphs_pad_gpio_f_01_pad(pad_periphs_pad_gpio_f_01_pad),
              .pad_periphs_pad_gpio_f_02_pad(pad_periphs_pad_gpio_f_02_pad),
              .pad_periphs_pad_gpio_f_03_pad(pad_periphs_pad_gpio_f_03_pad),
              .pad_periphs_pad_gpio_f_04_pad(pad_periphs_pad_gpio_f_04_pad),
              .pad_periphs_pad_gpio_f_05_pad(pad_periphs_pad_gpio_f_05_pad),
              .pad_periphs_pad_gpio_f_06_pad(pad_periphs_pad_gpio_f_06_pad),
              .pad_periphs_pad_gpio_f_07_pad(),
              .pad_periphs_pad_gpio_f_08_pad(),
              .pad_periphs_pad_gpio_f_09_pad(),
              .pad_periphs_pad_gpio_f_10_pad(),
              .pad_periphs_pad_gpio_f_11_pad(),
              .pad_periphs_pad_gpio_f_12_pad(),
              .pad_periphs_pad_gpio_f_13_pad(),
              .pad_periphs_pad_gpio_f_14_pad(),
              .pad_periphs_pad_gpio_f_15_pad(),
              .pad_periphs_pad_gpio_f_16_pad(),

              .pad_periphs_pad_gpio_pwm0_pad(),
              .pad_periphs_pad_gpio_pwm1_pad(),
              .pad_periphs_pad_gpio_pwm2_pad(),
              .pad_periphs_pad_gpio_pwm3_pad(),
              .pad_periphs_pad_gpio_pwm4_pad(),
              .pad_periphs_pad_gpio_pwm5_pad(),
              .pad_periphs_pad_gpio_pwm6_pad(),
              .pad_periphs_pad_gpio_pwm7_pad(),
            `endif //simple pad
          `endif //fpga_emul
        `endif //exclude

        .pad_hyper_csn        ( hyper_cs_n_wire        ),
        .pad_hyper_ck         ( hyper_ck_wire          ),
        .pad_hyper_ckn        ( hyper_ck_n_wire        ),
        .pad_hyper_rwds       ( hyper_rwds_wire        ),
        .pad_hyper_reset      ( hyper_reset_n_wire     ),
        .pad_hyper_dq         ( hyper_dq_wire          )
      );

   if (USE_UART == 1) begin
      `ifndef FPGA_EMUL
        `ifndef SIMPLE_PADFRAME
          assign pad_periphs_pad_gpio_b_41_pad =pad_periphs_pad_gpio_b_40_pad;
        `else
          assign pad_periphs_pad_gpio_b_07_pad =pad_periphs_pad_gpio_b_06_pad;
        `endif
      `else
          assign pad_periphs_pad_gpio_b_07_pad =pad_periphs_pad_gpio_b_06_pad;
      `endif
   end

  /* I2C memory models connected on I2C0
      I2C_MEM0 ADDRESS 0x50
      I2C_MEM1 ADDRESS 0x51
  */

   generate
     if (USE_24FC1025_MODEL == 1) begin
      `ifndef FPGA_EMUL
        `ifndef SIMPLE_PADFRAME

          pullup scl0_pullup_i (pad_periphs_pad_gpio_b_50_pad);
          pullup sda0_pullup_i (pad_periphs_pad_gpio_b_51_pad);

           M24FC1025 i_i2c_mem_0 (
             .A0    ( 1'b0       ),
             .A1    ( 1'b0       ),
             .A2    ( 1'b1       ),
             .WP    ( 1'b0       ),
             .SDA   ( pad_periphs_pad_gpio_b_51_pad ),
             .SCL   ( pad_periphs_pad_gpio_b_50_pad ),
             .RESET ( 1'b0       )
          );

          pullup scl1_pullup_i (pad_periphs_pad_gpio_d_00_pad);
          pullup sda1_pullup_i (pad_periphs_pad_gpio_d_01_pad);

          M24FC1025 i_i2c_mem_1 (
             .A0    ( 1'b1       ),
             .A1    ( 1'b0       ),
             .A2    ( 1'b1       ),
             .WP    ( 1'b0       ),
             .SDA   ( pad_periphs_pad_gpio_d_01_pad ),
             .SCL   ( pad_periphs_pad_gpio_d_00_pad ),
             .RESET ( 1'b0       )
          );

        `else

          pullup scl0_pullup_i (pad_periphs_pad_gpio_b_04_pad);
          pullup sda0_pullup_i (pad_periphs_pad_gpio_b_05_pad);

          M24FC1025 i_i2c_mem_0 (
             .A0    ( 1'b0       ),
             .A1    ( 1'b0       ),
             .A2    ( 1'b1       ),
             .WP    ( 1'b0       ),
             .SDA   ( pad_periphs_pad_gpio_b_05_pad ),
             .SCL   ( pad_periphs_pad_gpio_b_04_pad ),
             .RESET ( 1'b0       )
          );

          M24FC1025 i_i2c_mem_1 (
             .A0    ( 1'b1       ),
             .A1    ( 1'b0       ),
             .A2    ( 1'b1       ),
             .WP    ( 1'b0       ),
             .SDA   ( pad_periphs_pad_gpio_b_05_pad ),
             .SCL   ( pad_periphs_pad_gpio_b_04_pad ),
             .RESET ( 1'b0       )
          );

        `endif
      `endif
   end
   endgenerate


  /* SPI flash */
  generate

      if(USE_S25FS256S_MODEL == 1) begin

         s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm" ),
            .UserPreload   ( 0 )
         ) i_spi_flash_csn0 (
            .SI       ( pad_periphs_pad_gpio_b_03_pad  ),
            .SO       ( pad_periphs_pad_gpio_b_02_pad  ),
            .SCK      ( pad_periphs_pad_gpio_b_01_pad  ),
            .CSNeg    ( pad_periphs_pad_gpio_b_00_pad  ),
            .WPNeg    (  ),
            .RESETNeg (  )
         );

      end
  endgenerate


  generate
      if (USE_SDVT_CPI==1) begin
        `ifndef FPGA_EMUL
          `ifndef SIMPLE_PADFRAME
             cam_vip #(
                .HRES       ( 32 ), //320
                .VRES       ( 32 ) //240
             ) i_cam_vip (
                .en_i        ( pad_periphs_pad_gpio_b_00_pad  ),  //GPIO B 0
                .cam_clk_o   ( pad_periphs_pad_gpio_d_00_pad  ),
                .cam_vsync_o ( pad_periphs_pad_gpio_d_10_pad ),
                .cam_href_o  ( pad_periphs_pad_gpio_d_01_pad ),
                .cam_data_o  ( w_cam_data  )
             );


              assign pad_periphs_pad_gpio_d_02_pad = w_cam_data[0];
              assign pad_periphs_pad_gpio_d_03_pad = w_cam_data[1];
              assign pad_periphs_pad_gpio_d_04_pad = w_cam_data[2];
              assign pad_periphs_pad_gpio_d_05_pad = w_cam_data[3];
              assign pad_periphs_pad_gpio_d_06_pad = w_cam_data[4];
              assign pad_periphs_pad_gpio_d_07_pad = w_cam_data[5];
              assign pad_periphs_pad_gpio_d_08_pad = w_cam_data[6];
              assign pad_periphs_pad_gpio_d_09_pad = w_cam_data[7];
          `endif
        `endif
      end
  endgenerate

  generate
      if (USE_SDIO_0==1) begin
        `ifndef FPGA_EMUL
          `ifndef SIMPLE_PADFRAME
            sdModel sdModelTB0(
            .sdClk ( pad_periphs_pad_gpio_b_38_pad ),
            .cmd   ( pad_periphs_pad_gpio_b_39_pad ),
            .dat   ( {
                      pad_periphs_pad_gpio_b_37_pad,
                      pad_periphs_pad_gpio_b_36_pad,
                      pad_periphs_pad_gpio_b_35_pad,
                      pad_periphs_pad_gpio_b_34_pad }
                    )
            );
          `else
              sdModel sdModelTB0(
              .sdClk ( pad_periphs_pad_gpio_b_12_pad ),
              .cmd   ( pad_periphs_pad_gpio_b_13_pad ),
              .dat   ( {
                        pad_periphs_pad_gpio_b_11_pad,
                        pad_periphs_pad_gpio_b_10_pad,
                        pad_periphs_pad_gpio_b_09_pad,
                        pad_periphs_pad_gpio_b_08_pad }
                      )
              );
          `endif
        `endif
      end
  endgenerate

  generate
      if (USE_SDIO_1==1) begin
        sdModel sdModelTB1(
        .sdClk ( pad_periphs_pad_gpio_f_05_pad ),
        .cmd   ( pad_periphs_pad_gpio_f_06_pad ),
        .dat   ( {
                  pad_periphs_pad_gpio_f_04_pad,
                  pad_periphs_pad_gpio_f_03_pad,
                  pad_periphs_pad_gpio_f_02_pad,
                  pad_periphs_pad_gpio_f_01_pad }
               )
        );
      end
  endgenerate

  generate
     for (genvar i=0; i< NumChips ; i++) begin : hyperrams

        if ( NumPhys == 2 ) begin : double

           s27ks0641 #(
                 .TimingModel   ( "S27KS0641DPBHI020"    ),
                 .UserPreload   ( PRELOAD_HYPERRAM       ),
                 .mem_file_name ( "./hyperram0.slm"      )
             ) i_main_hyperram0 (
                    .DQ7           ( hyper_dq_wire[0][7]      ),
                    .DQ6           ( hyper_dq_wire[0][6]      ),
                    .DQ5           ( hyper_dq_wire[0][5]      ),
                    .DQ4           ( hyper_dq_wire[0][4]      ),
                    .DQ3           ( hyper_dq_wire[0][3]      ),
                    .DQ2           ( hyper_dq_wire[0][2]      ),
                    .DQ1           ( hyper_dq_wire[0][1]      ),
                    .DQ0           ( hyper_dq_wire[0][0]      ),
                    .RWDS          ( hyper_rwds_wire[0]       ),
                    .CSNeg         ( hyper_cs_n_wire[0][i]    ),
                    .CK            ( hyper_ck_wire[0]         ),
                    .CKNeg         ( hyper_ck_n_wire[0]       ),
                    .RESETNeg      ( hyper_reset_n_wire[0]    )
           );
           s27ks0641 #(
                 .TimingModel   ( "S27KS0641DPBHI020"    ),
                 .UserPreload   ( PRELOAD_HYPERRAM       ),
                 .mem_file_name ( "./hyperram1.slm"      )
             ) i_main_hyperram1 (
                    .DQ7           ( hyper_dq_wire[1][7]      ),
                    .DQ6           ( hyper_dq_wire[1][6]      ),
                    .DQ5           ( hyper_dq_wire[1][5]      ),
                    .DQ4           ( hyper_dq_wire[1][4]      ),
                    .DQ3           ( hyper_dq_wire[1][3]      ),
                    .DQ2           ( hyper_dq_wire[1][2]      ),
                    .DQ1           ( hyper_dq_wire[1][1]      ),
                    .DQ0           ( hyper_dq_wire[1][0]      ),
                    .RWDS          ( hyper_rwds_wire[1]       ),
                    .CSNeg         ( hyper_cs_n_wire[1][i]    ),
                    .CK            ( hyper_ck_wire[1]         ),
                    .CKNeg         ( hyper_ck_n_wire[1]       ),
                    .RESETNeg      ( hyper_reset_n_wire[1]    )
           );
        end else begin : single

           s27ks0641 #(
                 .TimingModel   ( "S27KS0641DPBHI020"    ),
                 .UserPreload   ( PRELOAD_HYPERRAM       ),
                 .mem_file_name ( "./hyperram.slm"       )
             ) i_main_hyperram0 (
                    .DQ7           ( hyper_dq_wire[0][7]      ),
                    .DQ6           ( hyper_dq_wire[0][6]      ),
                    .DQ5           ( hyper_dq_wire[0][5]      ),
                    .DQ4           ( hyper_dq_wire[0][4]      ),
                    .DQ3           ( hyper_dq_wire[0][3]      ),
                    .DQ2           ( hyper_dq_wire[0][2]      ),
                    .DQ1           ( hyper_dq_wire[0][1]      ),
                    .DQ0           ( hyper_dq_wire[0][0]      ),
                    .RWDS          ( hyper_rwds_wire[0]       ),
                    .CSNeg         ( hyper_cs_n_wire[0][i]    ),
                    .CK            ( hyper_ck_wire[0]         ),
                    .CKNeg         ( hyper_ck_n_wire[0]       ),
                    .RESETNeg      ( hyper_reset_n_wire[0]    )
           );
        end // block: single

     end // block: hyperrams
   endgenerate

   `ifdef POWER_PROFILE
   initial begin
      @( posedge dut.i_host_domain.i_apb_subsystem.i_alsaqr_clk_rst_gen.clk_soc_o &&
         dut.i_host_domain.i_l2_subsystem.CUTS[0].bank_i.req_i &&
         dut.i_host_domain.i_l2_subsystem.CUTS[0].bank_i.addr_i =='0 &&
         dut.i_host_domain.i_l2_subsystem.CUTS[0].bank_i.wdata_i ==32'heeeeeeee );
      `ifdef POWER_CVA6
      $dumpfile("cva6.vcd");
    	$dumpvars(0, dut.i_host_domain.i_cva6_subsystem.i_ariane_wrap);
      `elsif POWER_CL
      $dumpfile("cl.vcd");
    	$dumpvars(0, dut.cluster_i);
      `elsif POWER_TOP
      $dumpfile("top.vcd");
    	$dumpvars(0, dut);
      `endif
    	$dumpon;
      @( posedge dut.i_host_domain.i_apb_subsystem.i_alsaqr_clk_rst_gen.clk_soc_o &&
         dut.i_host_domain.i_l2_subsystem.CUTS[0].bank_i.req_i &&
         dut.i_host_domain.i_l2_subsystem.CUTS[0].bank_i.addr_i =='0 &&
         dut.i_host_domain.i_l2_subsystem.CUTS[0].bank_i.wdata_i ==32'heeeeeeee );
	  $dumpoff;
   	$dumpflush;
   end // initial begin
   `endif //  `ifdef POWER_PROFILE


   uart_bus #(.BAUD_RATE(115200), .PARITY_EN(0)) i_uart0_bus (.rx(w_cva6_uart_tx), .tx(w_cva6_uart_rx), .rx_en(1'b1));
   uart_bus #(.BAUD_RATE(115200), .PARITY_EN(0)) i_uart1_bus (.rx(apb_uart_tx), .tx(apb_uart_rx), .rx_en(1'b1));

  // Clock process
  initial begin
    rst_ni = 1'b0;
    rst_DTM = 1'b0;

    repeat(2)
      @(posedge rtc_i);
      @(negedge rtc_i);
      rst_ni = 1'b1;
      repeat(8)
        @(posedge rtc_i);
      rst_DTM = 1'b1;
      forever begin
        @(posedge clk_i);
        cycles++;
      end
  end

  initial begin
    forever begin
      rtc_i = 1'b0;
      #(RTC_CLOCK_PERIOD/2) rtc_i = 1'b1;
      #(RTC_CLOCK_PERIOD/2) rtc_i = 1'b0;
    end
  end

  assign clk_i = dut.i_host_domain.i_apb_subsystem.i_alsaqr_clk_rst_gen.clk_soc_o;

  initial begin
    s_tck = '0;
    forever
      #(REFClockPeriod/2) s_tck=~s_tck;
  end

  ////////////
  //  JTAG  //
  ////////////

  //typedef used only within the JTAG task
  typedef bit [ 7:0] byte_bt;
  typedef bit [15:0] shrt_bt;
  typedef bit [31:0] word_bt;
  typedef bit [63:0] doub_bt;
  typedef bit [ 9:0] dw_bt;   // data widths
  typedef bit [ 5:0] aw_bt;   // address, ID widths or small buffers

  // Default JTAG ID code type
  typedef struct packed {
    bit         _one;
    bit [10:0]  manufacturer;
    bit [15:0]  part_num;
    bit [ 3:0]  version;
  } jtag_idcode_t;

  // JTAG Definition
  typedef jtag_test::riscv_dbg #(
      .IrLength       (5                 ),
      .TA             (REFClockPeriod*0.1),
      .TT             (REFClockPeriod*0.9)
  ) riscv_dbg_t;

  // JTAG driver
  JTAG_DV jtag_mst (s_tck);
  riscv_dbg_t::jtag_driver_t jtag_driver = new(jtag_mst);
  riscv_dbg_t jtag_dbg = new(jtag_driver);

  localparam logic [31:0] dm_idcode  = ariane_soc::DbgIdCode;

  localparam dm::sbcs_t JtagInitSbcs = dm::sbcs_t'{
                                      sbautoincrement: 1'b1,
                                      sbreadondata: 1'b1,
                                      sbaccess: 3,
                                      default: '0
                                    };

    // Connect DUT to test bus
    assign s_trstn      = jtag_mst.trst_n;
    assign s_tms        = jtag_mst.tms;
    assign s_tdi        = jtag_mst.tdi;
    assign jtag_mst.tdo = s_tdo;

    //reset jtag_dbg driver
    initial begin
      @(negedge s_rst_ni);
        jtag_dbg.reset_master();
    end

    // JTAG offload procedure

  initial  begin: local_jtag_preload

    logic [63:0] rdata;
    logic [32:0] addr;

    logic [31:0] linker_addr;
    logic [63:0] binary_entry;

    if(LOCAL_JTAG==1) begin
      $display("LOCAL_JTAG : %d", LOCAL_JTAG);
      if(PRELOAD_HYPERRAM==0) begin
        if ( $value$plusargs ("CVA6_STRING=%s", binary));
          $display("Testing %s", binary);
        if ( $value$plusargs ("CL_STRING=%s", cluster_binary));
          if(cluster_binary!="none")
            $display("Testing cluster: %s", cluster_binary);
      end
      $display("PRELOAD_HYPERRAM : %d", PRELOAD_HYPERRAM);

      repeat(20)
      @(posedge rtc_i);
      jtag_init();

      if(PRELOAD_HYPERRAM==0) begin
        // Load cluster code
        if(cluster_binary!="none")
          jtag_elf_load(cluster_binary, binary_entry);

        /*$display("Amos KEY: FFFFFFFFFFFF327F000000000000EEBA");
        $display("DW KEY  : FFFFFFFFFFFEEE6E00000000000212FF");
        key0=128'hFFFFFFFFFFFF327F000000000000EEBA; //amos
        key1=128'hFFFFFFFFFFFEEE6E00000000000212FF; //dw
        $display("Write key0[31:0] %x", key0[31:0]); // insert the keys here
        jtag_write_reg(32'h1A106000,{key0[31:0],32'h00000001});
        $display("Write key0[95:32] %x", key0[95:32]);
        jtag_write_reg(32'h1A106008,key0[95:32]);
        $display("Write key1[31:0] %x; key0[127:96] %x", key1[31:0], key0[127:96]);
        jtag_write_reg(32'h1A106010,{key1[31:0],key0[127:96]});
        $display("Write key1[95:32] %x", key1[95:32]);
        jtag_write_reg(32'h1A106018,key1[95:32]);
        $display("Write key1[127:96] %x", key1[127:96]);
        jtag_write_reg(32'h1A106020,{32'h0,key1[127:96]});*/

        $display("Load binary...");
        // Load host code
        jtag_elf_load(binary, binary_entry);
        $display("Wakeup Core..");
        jtag_elf_run(binary_entry);
        $display("Wait EOC...");
        jtag_wait_for_eoc (exit_code, binary_entry);
      end else begin

        /*$display("Sanity write/read at 0x1C000000"); // word = 8 bytes here
        addr = 32'h1c000000;
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.write_dmi(dm::SBCS, sbcs);
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.write_dmi(dm::SBAddress0, addr);
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.write_dmi(dm::SBData1, 32'hdeadcaca);
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.write_dmi(dm::SBData0, 32'habbaabba);
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        sbcs.sbreadonaddr = 1;
        jtag_dbg.write_dmi(dm::SBCS, sbcs);
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.write_dmi(dm::SBAddress0, addr);
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.read_dmi(dm::SBData1, rdata[63:32]);
        // Wait until SBA is free to read another 32 bits
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        jtag_dbg.read_dmi(dm::SBData0, rdata[32:0]);
        // Wait until SBA is free to read another 32 bits
        do jtag_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
        if(rdata!=64'hdeadcacaabbaabba) begin
          $fatal(1,"rdata at 0x1c000000: %x" , rdata);
        end else begin
          $display("R/W sanity check ok!");
        end*/

        binary_entry={32'h00000000,LINKER_ENTRY};
        #(REFClockPeriod);
        $display("Wakeup here at %x!!", binary_entry);
        jtag_ariane_wakeup(LINKER_ENTRY);
        jtag_wait_for_eoc (exit_code, binary_entry);
      end
    end
  end

  task automatic jtag_write_reg;
    input logic [31:0] start_addr;
    input logic [63:0] value;

    logic [31:0]      addr;
    logic [63:0]      rdata;

    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    addr = start_addr;

    jtag_write(dm::SBCS, sbcs);
    jtag_write(dm::SBAddress0, addr);
    jtag_write(dm::SBData1, value[63:32]);
    jtag_write(dm::SBData0, value[31:0]);
    sbcs.sbreadonaddr = 1;
    jtag_write(dm::SBCS, sbcs);
    jtag_write(dm::SBAddress0, addr);

    riscv_dbg.read_dmi_exp_backoff(dm::SBData1, rdata[63:32]);
    // Wait until SBA is free to read another 32 bits
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);

    riscv_dbg.read_dmi_exp_backoff(dm::SBData0, rdata[31:0]);
    // Wait until SBA is free to read another 32 bits
    do riscv_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
    while (sbcs.sbbusy);

    if(rdata!=value) begin
      $fatal(1,"rdata at %x: %x" , addr, rdata);
    end else begin
      $display("R/W sanity check ok!");
    end

  endtask // execute_application

  task automatic jtag_write(
    input dm::dm_csr_e addr,
    input word_bt data,
    input bit wait_cmd = 0,
    input bit wait_sba = 0
  );
    jtag_dbg.write_dmi(addr, data);
    if (wait_cmd) begin
      dm::abstractcs_t acs;
      do begin
        jtag_dbg.read_dmi_exp_backoff(dm::AbstractCS, acs);
        if (acs.cmderr) $fatal(1, "[JTAG] Abstract command error!");
      end while (acs.busy);
    end
    if (wait_sba) begin
      dm::sbcs_t sbcs;
      do begin
        jtag_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
        if (sbcs.sberror | sbcs.sbbusyerror) $fatal(1, "[JTAG] System bus error!");
      end while (sbcs.sbbusy);
    end
  endtask

  // Initialize the debug module
  task automatic jtag_init;
    jtag_idcode_t idcode;
    dm::dmcontrol_t dmcontrol = '{dmactive: 1, default: '0};
    // Check ID code
    repeat(100) @(posedge s_tck);
    jtag_dbg.get_idcode(idcode);
    if (idcode != dm_idcode)
        $fatal(1, "[JTAG] Unexpected ID code: expected 0x%h, got 0x%h!", ariane_soc::DbgIdCode, idcode);
    // Activate, wait for debug module
    jtag_write(dm::DMControl, dmcontrol);
    do jtag_dbg.read_dmi_exp_backoff(dm::DMControl, dmcontrol);
    while (~dmcontrol.dmactive);
    // Activate, wait for system bus
    jtag_write(dm::SBCS, JtagInitSbcs, 0, 1);
    $display("[JTAG] Initialization success");
  endtask

  task automatic jtag_poll_bit0(
    input doub_bt addr,
    output word_bt data,
    input int unsigned idle_cycles
  );
    automatic dm::sbcs_t sbcs = dm::sbcs_t'{sbreadonaddr: 1'b1, sbaccess: 2, default: '0};
    jtag_write(dm::SBCS, sbcs, 0, 1);
    jtag_write(dm::SBAddress1, addr[63:32]);
    do begin
      jtag_write(dm::SBAddress0, addr[31:0]);
      jtag_dbg.wait_idle(idle_cycles);
      jtag_dbg.read_dmi_exp_backoff(dm::SBData0, data);
    end while (~data[0]);
  endtask

  // Load a binary
  task automatic jtag_elf_load(input string binary, output doub_bt binary_entry );
    dm::dmstatus_t status;
    // Halt hart 0
    jtag_write(dm::DMControl, dm::dmcontrol_t'{haltreq: 1, dmactive: 1, default: '0});
    do jtag_dbg.read_dmi_exp_backoff(dm::DMStatus, status);
    while (~status.allhalted);
    $display("[JTAG] Halted hart 0");
    // Preload binary
    jtag_elf_preload(binary, binary_entry);
  endtask

  // Run a binary
  task automatic jtag_elf_run(input doub_bt binary_entry);
    dm::sbcs_t sbcs;
    do begin
      jtag_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
      if (sbcs.sberror | sbcs.sbbusyerror) $fatal(1, "[JTAG] System bus error!");
    end while (sbcs.sbbusy);
    // Repoint execution
    jtag_write(dm::Data1, binary_entry[63:32]);
    jtag_write(dm::Data0, binary_entry[31:0]);
    jtag_write(dm::Command, 32'h0033_07b1, 0, 1);
    // Resume hart 0
    jtag_write(dm::DMControl, dm::dmcontrol_t'{resumereq: 1, dmactive: 1, default: '0});
    $display("[JTAG] Resumed hart 0 from 0x%h", binary_entry);
  endtask

  // Load a binary
  task automatic jtag_elf_preload(input string binary, output doub_bt entry);
    longint sec_addr, sec_len;
    $display("[JTAG] Preloading ELF binary: %s", binary);
    if (read_elf(binary))
      $fatal(1, "[JTAG] Failed to load ELF!");
    while (get_section(sec_addr, sec_len)) begin
      byte bf[] = new [sec_len];
      $display("[JTAG] Preloading section at 0x%h (%0d bytes)", sec_addr, sec_len);
      if (read_section(sec_addr, bf, sec_len)) $fatal(1, "[JTAG] Failed to read ELF section!");
      jtag_write(dm::SBCS, JtagInitSbcs, 1, 1);
      // Write address as 64-bit double
      jtag_write(dm::SBAddress1, sec_addr[63:32]);
      jtag_write(dm::SBAddress0, sec_addr[31:0]);
      for (longint i = 0; i <= sec_len ; i += 8) begin
        bit checkpoint = (i != 0 && i % 512 == 0);
        if (checkpoint)
          $display("[JTAG] - %0d/%0d bytes (%0d%%)", i, sec_len, i*100/(sec_len>1 ? sec_len-1 : 1));
        jtag_write(dm::SBData1, {bf[i+7], bf[i+6], bf[i+5], bf[i+4]});
        jtag_write(dm::SBData0, {bf[i+3], bf[i+2], bf[i+1], bf[i]}, checkpoint, checkpoint);
      end
    end
    void'(get_entry(entry));
    $display("[JTAG] Preload complete");
  endtask

  // Wait for termination signal and get return code
  task automatic jtag_wait_for_eoc(output word_bt exit_code, input doub_bt entry);
    jtag_poll_bit0(entry[31:0] + 32'h1000, exit_code, 800);
    exit_code >>= 1;
    if (exit_code) $error("[JTAG] FAILED: return code %0d", exit_code);
    else $display("[JTAG] SUCCESS");
    $stop;
  endtask

  task jtag_ariane_wakeup;
    input logic [31:0] start_addr;
    logic [31:0] dm_status;

    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    $info("======== Waking up Ariane using JTAG ========");
    // Initialize the dm module again, otherwise it will not work
    jtag_init();
    // Write PC to Data0 and Data1
    jtag_write(dm::Data0, start_addr);

    jtag_write(dm::Data1, 32'h0000_0000);

    // Halt Req
    jtag_write(dm::DMControl, 32'h8000_0001);

    // Wait for CVA6 to be halted
    do jtag_dbg.read_dmi_exp_backoff(dm::DMStatus, dm_status);
    while (!dm_status[8]);

    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    jtag_write(dm::DMControl, 32'h0000_0001);

    // Register Access Abstract Command
    jtag_write(dm::Command, {8'h0,1'b0,3'h3,1'b0,1'b0,1'b1,1'b1,4'h0,dm::CSR_DPC});

    // Resume req. Exiting from debug mode CVA6 will jump at the DPC address.
    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    jtag_write(dm::DMControl, 32'h4000_0001);
    jtag_write(dm::DMControl, 32'h0000_0001);


    // Wait till end of computation
    program_loaded = 1;

    // When task completed reading the return value using JTAG
    // Mainly used for post synthesis part
    $info("======== Wait for Completion ========");

  endtask // execute_application

endmodule // ariane_tb


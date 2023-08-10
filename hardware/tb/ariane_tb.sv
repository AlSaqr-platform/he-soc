// Copyright 2023 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Luca Valente, University of Bologna
// Author: Mattia Sinigaglia, University of Bologna
// Date: 13/07/2023
// Description: Top level testbench module. Instantiates the top level DUT, configures
//              the virtual interfaces and starts the test passed by +UVM_TEST+
//`define TEST_CLOCK_BYPASS

`timescale 1ps/1ps

import ariane_pkg::*;
import uvm_pkg::*;
import ariane_soc::*;
import jtag_ot_pkg::*;
import ariane_soc::HyperbusNumPhys;
import ariane_soc::NumChipsPerHyperbus;
import pkg_internal_alsaqr_periph_padframe_periphs::*;

`include "uvm_macros.svh"
`include "axi/assign.svh"
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

`define POWER_PROFILE
`define POWER_CVA6
`define PAD_MUX_REG_PATH dut.i_alsaqr_periph_padframe.i_periphs.i_periphs_muxer.s_reg2hw

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
  parameter  USE_USART            = 1;
  parameter  USE_SDVT_CPI         = 1;
  parameter  USE_SDIO             = 1;
  parameter  USE_CAN              = 1;

  ////////////////////////////////
  //                            //
  //  LINKER SCRIPT PARAMETERS  //
  //                            //
  ////////////////////////////////

  // when preload is enabled LINKER_ENTRY specifies the linker address which must be L3 -> 32'h80000000
  parameter  LINKER_ENTRY        = 32'h80000000;
  // IMPORTANT : If you change the linkerscript check the tohost address and update this paramater
  parameter  TOHOST              = LINKER_ENTRY + 32'h1C0;

  `ifdef PRELOAD
    parameter  PRELOAD_HYPERRAM    = 1;
    parameter  LOCAL_JTAG          = 1;
    parameter  CHECK_LOCAL_JTAG    = 0;
  `else
    `ifdef SEC_BOOT
    parameter  CHECK_LOCAL_JTAG = 0;
    parameter  PRELOAD_HYPERRAM = 1;
    parameter  LOCAL_JTAG       = 0;
    `else
       `ifdef USE_LOCAL_JTAG
       parameter  LOCAL_JTAG       = 1;
       parameter  PRELOAD_HYPERRAM = 0;
       parameter  CHECK_LOCAL_JTAG = 0;
       `else
       parameter  LOCAL_JTAG       = 0;
       parameter  PRELOAD_HYPERRAM = 0;
       parameter  CHECK_LOCAL_JTAG = 0;
       `endif
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
    localparam AxiWideBeWidth_ib    = 4;
    localparam AxiWideByteOffset_ib = $clog2(AxiWideBeWidth_ib);
    typedef logic [ariane_axi_soc::AddrWidth-1:0] addr_t;
    typedef logic [ariane_axi_soc::DataWidth-1:0] data_t;
    data_t memory [bit [31:0]];
    int sections  [bit [31:0]];

    logic [31:0] ibex_memory [bit [31:0]];
    int   ibex_sections [bit [31:0]];


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

    wire                  w_cam_pclk;   //is his even needed???
    wire [7:0]            w_cam_0_data;
    wire [7:0]            w_cam_1_data;
    wire                  w_cam_hsync;  //is his even needed???
    wire                  w_cam_vsync;  //is his even needed???

    logic                 s_ot_tms         ;
    logic                 s_ot_tdi         ;
    logic                 s_ot_trstn       ;
    logic                 s_ot_tdo         ;

    wire                  s_jtag2ot_tck    ;
    wire                  s_jtag2ot_tms    ;
    wire                  s_jtag2ot_tdi    ;
    wire                  s_jtag2ot_trstn  ;
    wire                  s_jtag2ot_tdo    ;

    logic                 bootmode;
    logic                 boot_mode;

    //NEW PAD PERIPHERALS SIGNALS
    wire    pad_periphs_a_00_pad;
    wire    pad_periphs_a_01_pad;
    wire    pad_periphs_a_02_pad;
    wire    pad_periphs_a_03_pad;
    wire    pad_periphs_a_04_pad;
    wire    pad_periphs_a_05_pad;
    wire    pad_periphs_a_06_pad;
    wire    pad_periphs_a_07_pad;
    wire    pad_periphs_a_08_pad;
    wire    pad_periphs_a_09_pad;
    wire    pad_periphs_a_10_pad;
    wire    pad_periphs_a_11_pad;
    wire    pad_periphs_a_12_pad;
    wire    pad_periphs_a_13_pad;
    wire    pad_periphs_a_14_pad;
    wire    pad_periphs_a_15_pad;
    wire    pad_periphs_a_16_pad;
    wire    pad_periphs_a_17_pad;
    wire    pad_periphs_a_18_pad;
    wire    pad_periphs_a_19_pad;
    wire    pad_periphs_a_20_pad;
    wire    pad_periphs_a_21_pad;
    wire    pad_periphs_a_22_pad;
    wire    pad_periphs_a_23_pad;
    wire    pad_periphs_a_24_pad;
    wire    pad_periphs_a_25_pad;
    wire    pad_periphs_a_26_pad;
    wire    pad_periphs_a_27_pad;
    wire    pad_periphs_a_28_pad;
    wire    pad_periphs_a_29_pad;
    wire    pad_periphs_a_30_pad;
    wire    pad_periphs_a_31_pad;
    wire    pad_periphs_a_32_pad;
    wire    pad_periphs_a_33_pad;
    wire    pad_periphs_a_34_pad;
    wire    pad_periphs_a_35_pad;
    wire    pad_periphs_a_36_pad;
    wire    pad_periphs_a_37_pad;
    wire    pad_periphs_a_38_pad;
    wire    pad_periphs_a_39_pad;
    wire    pad_periphs_a_40_pad;
    wire    pad_periphs_a_41_pad;
    wire    pad_periphs_a_42_pad;
    wire    pad_periphs_a_43_pad;
    wire    pad_periphs_a_44_pad;
    wire    pad_periphs_a_45_pad;
    wire    pad_periphs_a_46_pad;
    wire    pad_periphs_a_47_pad;
    wire    pad_periphs_a_48_pad;
    wire    pad_periphs_a_49_pad;
    wire    pad_periphs_a_50_pad;
    wire    pad_periphs_a_51_pad;
    wire    pad_periphs_a_52_pad;
    wire    pad_periphs_a_53_pad;
    wire    pad_periphs_a_54_pad;
    wire    pad_periphs_a_55_pad;
    wire    pad_periphs_a_56_pad;
    wire    pad_periphs_a_57_pad;
    wire    pad_periphs_a_58_pad;
    wire    pad_periphs_a_59_pad;
    wire    pad_periphs_a_60_pad;
    wire    pad_periphs_a_61_pad;
    wire    pad_periphs_a_62_pad;
    wire    pad_periphs_a_63_pad;
    wire    pad_periphs_a_64_pad;
    wire    pad_periphs_a_65_pad;
    wire    pad_periphs_a_66_pad;
    wire    pad_periphs_a_67_pad;
    wire    pad_periphs_a_68_pad;
    wire    pad_periphs_a_69_pad;
    wire    pad_periphs_a_70_pad;
    wire    pad_periphs_a_71_pad;
    wire    pad_periphs_a_72_pad;
    wire    pad_periphs_a_73_pad;
    wire    pad_periphs_a_74_pad;
    wire    pad_periphs_a_75_pad;
    wire    pad_periphs_a_76_pad;
    wire    pad_periphs_a_77_pad;
    wire    pad_periphs_a_78_pad;
    wire    pad_periphs_a_79_pad;
    wire    pad_periphs_a_80_pad;
    wire    pad_periphs_a_81_pad;
    wire    pad_periphs_a_82_pad;
    wire    pad_periphs_a_83_pad;
    wire    pad_periphs_a_84_pad;
    wire    pad_periphs_a_85_pad;
    wire    pad_periphs_a_86_pad;
    wire    pad_periphs_a_87_pad;
    wire    pad_periphs_a_88_pad;
    wire    pad_periphs_a_89_pad;
    wire    pad_periphs_a_90_pad;
    wire    pad_periphs_a_91_pad;
    wire    pad_periphs_a_92_pad;

    wire    pad_periphs_b_00_pad;
    wire    pad_periphs_b_01_pad;
    wire    pad_periphs_b_02_pad;
    wire    pad_periphs_b_03_pad;
    wire    pad_periphs_b_04_pad;
    wire    pad_periphs_b_05_pad;
    wire    pad_periphs_b_06_pad;
    wire    pad_periphs_b_07_pad;
    wire    pad_periphs_b_08_pad;
    wire    pad_periphs_b_09_pad;
    wire    pad_periphs_b_10_pad;
    wire    pad_periphs_b_11_pad;
    wire    pad_periphs_b_12_pad;
    wire    pad_periphs_b_13_pad;
    wire    pad_periphs_b_14_pad;
    wire    pad_periphs_b_15_pad;
    wire    pad_periphs_b_16_pad;
    wire    pad_periphs_b_17_pad;
    wire    pad_periphs_b_18_pad;
    wire    pad_periphs_b_19_pad;
    wire    pad_periphs_b_20_pad;
    wire    pad_periphs_b_21_pad;
    wire    pad_periphs_b_22_pad;
    wire    pad_periphs_b_23_pad;
    wire    pad_periphs_b_24_pad;
    wire    pad_periphs_b_25_pad;
    wire    pad_periphs_b_26_pad;
    wire    pad_periphs_b_27_pad;
    wire    pad_periphs_b_28_pad;
    wire    pad_periphs_b_29_pad;
    wire    pad_periphs_b_30_pad;
    wire    pad_periphs_b_31_pad;
    wire    pad_periphs_b_32_pad;
    wire    pad_periphs_b_33_pad;
    wire    pad_periphs_b_34_pad;
    wire    pad_periphs_b_35_pad;
    wire    pad_periphs_b_36_pad;
    wire    pad_periphs_b_37_pad;
    wire    pad_periphs_b_38_pad;
    wire    pad_periphs_b_39_pad;
    wire    pad_periphs_b_40_pad;
    wire    pad_periphs_b_41_pad;
    wire    pad_periphs_b_42_pad;
    wire    pad_periphs_b_43_pad;
    wire    pad_periphs_b_44_pad;
    wire    pad_periphs_b_45_pad;
    wire    pad_periphs_b_46_pad;
    wire    pad_periphs_b_47_pad;
    wire    pad_periphs_b_48_pad;
    wire    pad_periphs_b_49_pad;
    wire    pad_periphs_b_50_pad;
    wire    pad_periphs_b_51_pad;
    wire    pad_periphs_b_52_pad;
    wire    pad_periphs_b_53_pad;
    wire    pad_periphs_b_54_pad;
    wire    pad_periphs_b_55_pad;
    wire    pad_periphs_b_56_pad;
    wire    pad_periphs_b_57_pad;
    wire    pad_periphs_b_58_pad;
    wire    pad_periphs_b_59_pad;
    wire    pad_periphs_b_60_pad;
    wire    pad_periphs_b_61_pad;
    wire    pad_periphs_b_62_pad;

    wire    pad_periphs_ot_qspi_00_pad;
    wire    pad_periphs_ot_qspi_01_pad;
    wire    pad_periphs_ot_qspi_02_pad;
    wire    pad_periphs_ot_qspi_03_pad;
    wire    pad_periphs_ot_qspi_04_pad;
    wire    pad_periphs_ot_qspi_05_pad;

    wire    pad_periphs_linux_qspi_00_pad;
    wire    pad_periphs_linux_qspi_01_pad;
    wire    pad_periphs_linux_qspi_02_pad;
    wire    pad_periphs_linux_qspi_03_pad;
    wire    pad_periphs_linux_qspi_04_pad;
    wire    pad_periphs_linux_qspi_05_pad;

    wire    pad_periphs_ot_gpio_00_pad;
    wire    pad_periphs_ot_gpio_01_pad;

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
    string        ot_sram;

    // NEW PAD VIP SIGNALS
    wire    pad_periphs_a_00_pad_i2c0_scl  ;
    wire    pad_periphs_a_01_pad_i2c0_sda  ;
    wire    pad_periphs_a_02_pad_spi0_sck  ;
    wire    pad_periphs_a_03_pad_spi0_cs   ;
    wire    pad_periphs_a_04_pad_spi0_miso ;
    wire    pad_periphs_a_05_pad_spi0_mosi ;
    wire    pad_periphs_a_06_pad_spi1_sck  ;
    wire    pad_periphs_a_07_pad_spi1_cs   ;
    wire    pad_periphs_a_08_pad_spi1_miso ;
    wire    pad_periphs_a_09_pad_spi1_mosi ;
    wire    pad_periphs_a_10_pad_spi2_sck  ;
    wire    pad_periphs_a_11_pad_spi2_cs   ;
    wire    pad_periphs_a_12_pad_spi2_miso ;
    wire    pad_periphs_a_13_pad_spi2_mosi ;
    wire    pad_periphs_a_14_pad_spi3_sck  ;
    wire    pad_periphs_a_15_pad_spi3_cs   ;
    wire    pad_periphs_a_16_pad_spi3_miso ;
    wire    pad_periphs_a_17_pad_spi3_mosi ;
    wire    pad_periphs_a_18_pad_sdio0_d1  ;
    wire    pad_periphs_a_19_pad_sdio0_d2  ;
    wire    pad_periphs_a_20_pad_sdio0_d3  ;
    wire    pad_periphs_a_21_pad_sdio0_d4  ;
    wire    pad_periphs_a_22_pad_sdio0_clk ;
    wire    pad_periphs_a_23_pad_sdio0_cmd ;
    wire    pad_periphs_a_24_pad_uart0_tx  ;
    wire    pad_periphs_a_25_pad_uart0_rx  ;
    wire    pad_periphs_a_26_pad_i2c1_scl  ;
    wire    pad_periphs_a_27_pad_i2c1_sda  ;
    wire    pad_periphs_a_28_pad_usart0_tx ;
    wire    pad_periphs_a_29_pad_usart0_rx ;
    wire    pad_periphs_a_30_pad_usart0_rts;
    wire    pad_periphs_a_31_pad_usart0_cts;
    wire    pad_periphs_a_32_pad_spi4_sck  ;
    wire    pad_periphs_a_33_pad_spi4_cs   ;
    wire    pad_periphs_a_34_pad_spi4_miso ;
    wire    pad_periphs_a_35_pad_spi4_mosi ;
    wire    pad_periphs_a_36_pad_i2c2_scl  ;
    wire    pad_periphs_a_37_pad_i2c2_sda  ;
    wire    pad_periphs_a_38_pad_pwm_out0  ;
    wire    pad_periphs_a_39_pad_pwm_out1  ;
    wire    pad_periphs_a_40_pad_pwm_out2  ;
    wire    pad_periphs_a_41_pad_pwm_out3  ;
    wire    pad_periphs_a_42_pad_cpi0_clk  ;
    wire    pad_periphs_a_42_pad_i2c3_scl  ;
    wire    pad_periphs_a_43_pad_cpi0_vsync;
    wire    pad_periphs_a_43_pad_i2c3_sda  ;
    wire    pad_periphs_a_44_pad_cpi0_dat0 ;
    wire    pad_periphs_a_44_pad_spi5_sck  ;
    wire    pad_periphs_a_45_pad_cpi0_dat1 ;
    wire    pad_periphs_a_45_pad_spi5_cs   ;
    wire    pad_periphs_a_46_pad_cpi0_dat2 ;
    wire    pad_periphs_a_46_pad_spi5_miso ;
    wire    pad_periphs_a_47_pad_cpi0_dat3 ;
    wire    pad_periphs_a_47_pad_spi5_mosi ;
    wire    pad_periphs_a_48_pad_cpi0_dat5 ;
    wire    pad_periphs_a_48_pad_spi6_clk  ;
    wire    pad_periphs_a_49_pad_cpi0_dat6 ;
    wire    pad_periphs_a_49_pad_spi6_cs   ;
    wire    pad_periphs_a_50_pad_cpi0_dat7 ;
    wire    pad_periphs_a_50_pad_spi6_miso ;
    wire    pad_periphs_a_51_pad_cpi1_clk  ;
    wire    pad_periphs_a_51_pad_spi6_mosi ;
    wire    pad_periphs_a_52_pad_cpi1_hsync;
    wire    pad_periphs_a_52_pad_spi7_sck  ;
    wire    pad_periphs_a_53_pad_cpi1_dat0 ;
    wire    pad_periphs_a_53_pad_spi7_miso ;
    wire    pad_periphs_a_54_pad_cpi1_dat1 ;
    wire    pad_periphs_a_54_pad_spi7_mosi ;
    wire    pad_periphs_a_55_pad_cpi1_dat5 ;
    wire    pad_periphs_a_55_pad_spi7_cs0  ;
    wire    pad_periphs_a_56_pad_cpi1_dat6 ;
    wire    pad_periphs_a_56_pad_spi7_cs1  ;
    wire    pad_periphs_a_57_pad_cpi1_dat7 ;
    wire    pad_periphs_a_57_pad_i2c4_scl  ;
    wire    pad_periphs_a_58_pad_sdio1_d0  ;
    wire    pad_periphs_a_58_pad_i2c4_sda  ;
    wire    pad_periphs_a_59_pad_sdio1_d2  ;
    wire    pad_periphs_a_59_pad_uart1_tx  ;
    wire    pad_periphs_a_60_pad_sdio1_d3  ;
    wire    pad_periphs_a_60_pad_uart1_rx  ;
    wire    pad_periphs_a_61_pad_sdio1_clk ;
    wire    pad_periphs_a_61_pad_usart1_tx ;
    wire    pad_periphs_a_62_pad_sdio1_cmd ;
    wire    pad_periphs_a_62_pad_usart1_rx ;
    wire    pad_periphs_a_63_pad_usart1_rts;
    wire    pad_periphs_a_64_pad_usart1_cts;
    wire    pad_periphs_a_65_pad_uart2_tx  ;
    wire    pad_periphs_a_66_pad_uart2_rx  ;
    wire    pad_periphs_a_67_pad_i2c5_scl  ;
    wire    pad_periphs_a_68_pad_i2c5_sda  ;
    wire    pad_periphs_a_69_pad_usart2_tx ;
    wire    pad_periphs_a_70_pad_usart2_rx ;
    wire    pad_periphs_a_71_pad_usart2_rts;
    wire    pad_periphs_a_72_pad_usart2_cts;
    wire    pad_periphs_a_73_pad_usart3_tx ;
    wire    pad_periphs_a_74_pad_usart3_rx ;
    wire    pad_periphs_a_75_pad_usart3_rts;
    wire    pad_periphs_a_76_pad_usart3_cts;
    wire    pad_periphs_a_77_pad_pwm_out4  ;
    wire    pad_periphs_a_78_pad_pwm_out5  ;
    wire    pad_periphs_a_79_pad_pwm_out6  ;
    wire    pad_periphs_a_80_pad_pwm_out7  ;
    wire    pad_periphs_a_81_pad_spi8_sck  ;
    wire    pad_periphs_a_81_pad_can0_tx   ;
    wire    pad_periphs_a_82_pad_spi8_cs   ;
    wire    pad_periphs_a_82_pad_can0_rx   ;
    wire    pad_periphs_a_83_pad_spi8_miso ;
    wire    pad_periphs_a_83_pad_can1_tx   ;
    wire    pad_periphs_a_84_pad_spi8_mosi ;
    wire    pad_periphs_a_84_pad_can1_rx   ;
    wire    pad_periphs_a_85_pad_spi9_sck  ;
    wire    pad_periphs_a_86_pad_spi9_cs   ;
    wire    pad_periphs_a_87_pad_spi9_miso ;
    wire    pad_periphs_a_88_pad_spi9_mosi ;
    wire    pad_periphs_a_89_pad_spi10_sck ;
    wire    pad_periphs_a_90_pad_spi10_cs  ;
    wire    pad_periphs_a_91_pad_spi10_miso;
    wire    pad_periphs_a_92_pad_spi10_mosi;

    wire    pad_periphs_b_00_pad_drdy_gpio0  ;
    wire    pad_periphs_b_01_pad_drdy_gpio1  ;
    wire    pad_periphs_b_02_pad_drdy_gpio2  ;
    wire    pad_periphs_b_03_pad_sync_gpio3  ;
    wire    pad_periphs_b_04_pad_adio_gpio4  ;
    wire    pad_periphs_b_05_pad_adio_gpio5  ;
    wire    pad_periphs_b_06_pad_adio_gpio6  ;
    wire    pad_periphs_b_07_pad_adio_gpio7  ;
    wire    pad_periphs_b_08_pad_led_r_gpio8 ;
    wire    pad_periphs_b_09_pad_led_g_gpio9 ;
    wire    pad_periphs_b_10_pad_led_b_gpio10;
    wire    pad_periphs_b_11_pad_gpio11      ;
    wire    pad_periphs_b_12_pad_gpio12      ;
    wire    pad_periphs_b_13_pad_gpio13      ;
    wire    pad_periphs_b_14_pad_gpio14      ;
    wire    pad_periphs_b_15_pad_adc0_gpio15 ;
    wire    pad_periphs_b_16_pad_adc0_gpio16 ;
    wire    pad_periphs_b_17_pad_adc0_gpio17 ;
    wire    pad_periphs_b_18_pad_pwrgd_gpio18;
    wire    pad_periphs_b_19_pad_cpi0_hsync  ;
    wire    pad_periphs_b_19_pad_drdy_gpio19 ;
    wire    pad_periphs_b_20_pad_cpi0_dat4   ;
    wire    pad_periphs_b_20_pad_drdy_gpio20 ;
    wire    pad_periphs_b_21_pad_cpi1_vsync  ;
    wire    pad_periphs_b_21_pad_drdy_gpio21 ;
    wire    pad_periphs_b_22_pad_cpi1_dat2   ;
    wire    pad_periphs_b_22_pad_rst_gpio22  ;
    wire    pad_periphs_b_23_pad_cpi1_dat3   ;
    wire    pad_periphs_b_23_pad_drdy1_gpio23;
    wire    pad_periphs_b_24_pad_cpi1_dat4   ;
    wire    pad_periphs_b_24_pad_drdy2_gpio24;
    wire    pad_periphs_b_25_pad_sdio1_d1    ;
    wire    pad_periphs_b_25_pad_nfc_gpio25  ;
    wire    pad_periphs_b_26_pad_gps1_gpio26 ;
    wire    pad_periphs_b_27_pad_gps1_gpio27 ;
    wire    pad_periphs_b_28_pad_gps1_gpio28 ;
    wire    pad_periphs_b_29_pad_io_gpio29   ;
    wire    pad_periphs_b_30_pad_io_gpio30   ;
    wire    pad_periphs_b_31_pad_io_gpio31   ;
    wire    pad_periphs_b_32_pad_io_gpio32   ;
    wire    pad_periphs_b_33_pad_io_gpio33   ;
    wire    pad_periphs_b_34_pad_io_gpio34   ;
    wire    pad_periphs_b_35_pad_io_gpio35   ;
    wire    pad_periphs_b_36_pad_io_gpio36   ;
    wire    pad_periphs_b_37_pad_io_gpio37   ;
    wire    pad_periphs_b_38_pad_io_gpio38   ;
    wire    pad_periphs_b_39_pad_io_gpio39   ;
    wire    pad_periphs_b_40_pad_io_gpio40   ;
    wire    pad_periphs_b_41_pad_io_gpio41   ;
    wire    pad_periphs_b_42_pad_io_gpio42   ;
    wire    pad_periphs_b_43_pad_io_gpio43   ;
    wire    pad_periphs_b_44_pad_io_gpio44   ;
    wire    pad_periphs_b_45_pad_io_gpio45   ;
    wire    pad_periphs_b_46_pad_io_gpio46   ;
    wire    pad_periphs_b_47_pad_eth_rst     ;
    wire    pad_periphs_b_47_pad_io_gpio47   ;
    wire    pad_periphs_b_48_pad_eth_rxck    ;
    wire    pad_periphs_b_48_pad_io_gpio48   ;
    wire    pad_periphs_b_49_pad_eth_rxctl   ;
    wire    pad_periphs_b_49_pad_io_gpio49   ;
    wire    pad_periphs_b_50_pad_eth_rxd0    ;
    wire    pad_periphs_b_50_pad_io_gpio50   ;
    wire    pad_periphs_b_51_pad_eth_rxd1    ;
    wire    pad_periphs_b_51_pad_io_gpio51   ;
    wire    pad_periphs_b_52_pad_eth_rxd2    ;
    wire    pad_periphs_b_52_pad_io_gpio52   ;
    wire    pad_periphs_b_53_pad_eth_rxd3    ;
    wire    pad_periphs_b_53_pad_io_gpio53   ;
    wire    pad_periphs_b_54_pad_eth_txck    ;
    wire    pad_periphs_b_54_pad_io_gpio54   ;
    wire    pad_periphs_b_55_pad_eth_txctl   ;
    wire    pad_periphs_b_55_pad_io_gpio55   ;
    wire    pad_periphs_b_56_pad_eth_txd0    ;
    wire    pad_periphs_b_56_pad_io_gpio56   ;
    wire    pad_periphs_b_57_pad_eth_txd1    ;
    wire    pad_periphs_b_57_pad_io_gpio57   ;
    wire    pad_periphs_b_58_pad_eth_txd2    ;
    wire    pad_periphs_b_58_pad_io_gpio58   ;
    wire    pad_periphs_b_59_pad_eth_txd3    ;
    wire    pad_periphs_b_59_pad_io_gpio59   ;
    wire    pad_periphs_b_60_pad_eth_mdio    ;
    wire    pad_periphs_b_60_pad_io_gpio60   ;
    wire    pad_periphs_b_61_pad_eth_mdc     ;
    wire    pad_periphs_b_61_pad_io_gpio61   ;
    wire    pad_periphs_b_62_pad_eth_intb    ;
    wire    pad_periphs_b_62_pad_io_gpio62   ;

    // NEW PAD VIP MUX SEL SIGNALS
    logic    pad_periphs_a_00_pad_mux_sel_i2c0_scl  ;
    logic    pad_periphs_a_01_pad_mux_sel_i2c0_sda  ;
    logic    pad_periphs_a_02_pad_mux_sel_spi0_sck  ;
    logic    pad_periphs_a_03_pad_mux_sel_spi0_cs   ;
    logic    pad_periphs_a_04_pad_mux_sel_spi0_miso ;
    logic    pad_periphs_a_05_pad_mux_sel_spi0_mosi ;
    logic    pad_periphs_a_06_pad_mux_sel_spi1_sck  ;
    logic    pad_periphs_a_07_pad_mux_sel_spi1_cs   ;
    logic    pad_periphs_a_08_pad_mux_sel_spi1_miso ;
    logic    pad_periphs_a_09_pad_mux_sel_spi1_mosi ;
    logic    pad_periphs_a_10_pad_mux_sel_spi2_sck  ;
    logic    pad_periphs_a_11_pad_mux_sel_spi2_cs   ;
    logic    pad_periphs_a_12_pad_mux_sel_spi2_miso ;
    logic    pad_periphs_a_13_pad_mux_sel_spi2_mosi ;
    logic    pad_periphs_a_14_pad_mux_sel_spi3_sck  ;
    logic    pad_periphs_a_15_pad_mux_sel_spi3_cs   ;
    logic    pad_periphs_a_16_pad_mux_sel_spi3_miso ;
    logic    pad_periphs_a_17_pad_mux_sel_spi3_mosi ;
    logic    pad_periphs_a_18_pad_mux_sel_sdio0_d1  ;
    logic    pad_periphs_a_19_pad_mux_sel_sdio0_d2  ;
    logic    pad_periphs_a_20_pad_mux_sel_sdio0_d3  ;
    logic    pad_periphs_a_21_pad_mux_sel_sdio0_d4  ;
    logic    pad_periphs_a_22_pad_mux_sel_sdio0_clk ;
    logic    pad_periphs_a_23_pad_mux_sel_sdio0_cmd ;
    logic    pad_periphs_a_24_pad_mux_sel_uart0_tx  ;
    logic    pad_periphs_a_25_pad_mux_sel_uart0_rx  ;
    logic    pad_periphs_a_26_pad_mux_sel_i2c1_scl  ;
    logic    pad_periphs_a_27_pad_mux_sel_i2c1_sda  ;
    logic    pad_periphs_a_28_pad_mux_sel_usart0_tx ;
    logic    pad_periphs_a_29_pad_mux_sel_usart0_rx ;
    logic    pad_periphs_a_30_pad_mux_sel_usart0_rts;
    logic    pad_periphs_a_31_pad_mux_sel_usart0_cts;
    logic    pad_periphs_a_32_pad_mux_sel_spi4_sck  ;
    logic    pad_periphs_a_33_pad_mux_sel_spi4_cs   ;
    logic    pad_periphs_a_34_pad_mux_sel_spi4_miso ;
    logic    pad_periphs_a_35_pad_mux_sel_spi4_mosi ;
    logic    pad_periphs_a_36_pad_mux_sel_i2c2_scl  ;
    logic    pad_periphs_a_37_pad_mux_sel_i2c2_sda  ;
    logic    pad_periphs_a_38_pad_mux_sel_pwm_out0  ;
    logic    pad_periphs_a_39_pad_mux_sel_pwm_out1  ;
    logic    pad_periphs_a_40_pad_mux_sel_pwm_out2  ;
    logic    pad_periphs_a_41_pad_mux_sel_pwm_out3  ;
    logic    pad_periphs_a_42_pad_mux_sel_cpi0_clk  ;
    logic    pad_periphs_a_42_pad_mux_sel_i2c3_scl  ;
    logic    pad_periphs_a_43_pad_mux_sel_cpi0_vsync;
    logic    pad_periphs_a_43_pad_mux_sel_i2c3_sda  ;
    logic    pad_periphs_a_44_pad_mux_sel_cpi0_dat0 ;
    logic    pad_periphs_a_44_pad_mux_sel_spi5_sck  ;
    logic    pad_periphs_a_45_pad_mux_sel_cpi0_dat1 ;
    logic    pad_periphs_a_45_pad_mux_sel_spi5_cs   ;
    logic    pad_periphs_a_46_pad_mux_sel_cpi0_dat2 ;
    logic    pad_periphs_a_46_pad_mux_sel_spi5_miso ;
    logic    pad_periphs_a_47_pad_mux_sel_cpi0_dat3 ;
    logic    pad_periphs_a_47_pad_mux_sel_spi5_mosi ;
    logic    pad_periphs_a_48_pad_mux_sel_cpi0_dat5 ;
    logic    pad_periphs_a_48_pad_mux_sel_spi6_clk  ;
    logic    pad_periphs_a_49_pad_mux_sel_cpi0_dat6 ;
    logic    pad_periphs_a_49_pad_mux_sel_spi6_cs   ;
    logic    pad_periphs_a_50_pad_mux_sel_cpi0_dat7 ;
    logic    pad_periphs_a_50_pad_mux_sel_spi6_miso ;
    logic    pad_periphs_a_51_pad_mux_sel_cpi1_clk  ;
    logic    pad_periphs_a_51_pad_mux_sel_spi6_mosi ;
    logic    pad_periphs_a_52_pad_mux_sel_cpi1_hsync;
    logic    pad_periphs_a_52_pad_mux_sel_spi7_sck  ;
    logic    pad_periphs_a_53_pad_mux_sel_cpi1_dat0 ;
    logic    pad_periphs_a_53_pad_mux_sel_spi7_miso ;
    logic    pad_periphs_a_54_pad_mux_sel_cpi1_dat1 ;
    logic    pad_periphs_a_54_pad_mux_sel_spi7_mosi ;
    logic    pad_periphs_a_55_pad_mux_sel_cpi1_dat5 ;
    logic    pad_periphs_a_55_pad_mux_sel_spi7_cs0  ;
    logic    pad_periphs_a_56_pad_mux_sel_cpi1_dat6 ;
    logic    pad_periphs_a_56_pad_mux_sel_spi7_cs1  ;
    logic    pad_periphs_a_57_pad_mux_sel_cpi1_dat7 ;
    logic    pad_periphs_a_57_pad_mux_sel_i2c4_scl  ;
    logic    pad_periphs_a_58_pad_mux_sel_sdio1_d0  ;
    logic    pad_periphs_a_58_pad_mux_sel_i2c4_sda  ;
    logic    pad_periphs_a_59_pad_mux_sel_sdio1_d2  ;
    logic    pad_periphs_a_59_pad_mux_sel_uart1_tx  ;
    logic    pad_periphs_a_60_pad_mux_sel_sdio1_d3  ;
    logic    pad_periphs_a_60_pad_mux_sel_uart1_rx  ;
    logic    pad_periphs_a_61_pad_mux_sel_sdio1_clk ;
    logic    pad_periphs_a_61_pad_mux_sel_usart1_tx ;
    logic    pad_periphs_a_62_pad_mux_sel_sdio1_cmd ;
    logic    pad_periphs_a_62_pad_mux_sel_usart1_rx ;
    logic    pad_periphs_a_63_pad_mux_sel_usart1_rts;
    logic    pad_periphs_a_64_pad_mux_sel_usart1_cts;
    logic    pad_periphs_a_65_pad_mux_sel_uart2_tx  ;
    logic    pad_periphs_a_66_pad_mux_sel_uart2_rx  ;
    logic    pad_periphs_a_67_pad_mux_sel_i2c5_scl  ;
    logic    pad_periphs_a_68_pad_mux_sel_i2c5_sda  ;
    logic    pad_periphs_a_69_pad_mux_sel_usart2_tx ;
    logic    pad_periphs_a_70_pad_mux_sel_usart2_rx ;
    logic    pad_periphs_a_71_pad_mux_sel_usart2_rts;
    logic    pad_periphs_a_72_pad_mux_sel_usart2_cts;
    logic    pad_periphs_a_73_pad_mux_sel_usart3_tx ;
    logic    pad_periphs_a_74_pad_mux_sel_usart3_rx ;
    logic    pad_periphs_a_75_pad_mux_sel_usart3_rts;
    logic    pad_periphs_a_76_pad_mux_sel_usart3_cts;
    logic    pad_periphs_a_77_pad_mux_sel_pwm_out4  ;
    logic    pad_periphs_a_78_pad_mux_sel_pwm_out5  ;
    logic    pad_periphs_a_79_pad_mux_sel_pwm_out6  ;
    logic    pad_periphs_a_80_pad_mux_sel_pwm_out7  ;
    logic    pad_periphs_a_81_pad_mux_sel_spi8_sck  ;
    logic    pad_periphs_a_81_pad_mux_sel_can0_tx   ;
    logic    pad_periphs_a_82_pad_mux_sel_spi8_cs   ;
    logic    pad_periphs_a_82_pad_mux_sel_can0_rx   ;
    logic    pad_periphs_a_83_pad_mux_sel_spi8_miso ;
    logic    pad_periphs_a_83_pad_mux_sel_can1_tx   ;
    logic    pad_periphs_a_84_pad_mux_sel_spi8_mosi ;
    logic    pad_periphs_a_84_pad_mux_sel_can1_rx   ;
    logic    pad_periphs_a_85_pad_mux_sel_spi9_sck  ;
    logic    pad_periphs_a_86_pad_mux_sel_spi9_cs   ;
    logic    pad_periphs_a_87_pad_mux_sel_spi9_miso ;
    logic    pad_periphs_a_88_pad_mux_sel_spi9_mosi ;
    logic    pad_periphs_a_89_pad_mux_sel_spi10_sck ;
    logic    pad_periphs_a_90_pad_mux_sel_spi10_cs  ;
    logic    pad_periphs_a_91_pad_mux_sel_spi10_miso;
    logic    pad_periphs_a_92_pad_mux_sel_spi10_mosi;

    logic    pad_periphs_b_00_pad_mux_sel_drdy_gpio0  ;
    logic    pad_periphs_b_01_pad_mux_sel_drdy_gpio1  ;
    logic    pad_periphs_b_02_pad_mux_sel_drdy_gpio2  ;
    logic    pad_periphs_b_03_pad_mux_sel_sync_gpio3  ;
    logic    pad_periphs_b_04_pad_mux_sel_adio_gpio4  ;
    logic    pad_periphs_b_05_pad_mux_sel_adio_gpio5  ;
    logic    pad_periphs_b_06_pad_mux_sel_adio_gpio6  ;
    logic    pad_periphs_b_07_pad_mux_sel_adio_gpio7  ;
    logic    pad_periphs_b_08_pad_mux_sel_led_r_gpio8 ;
    logic    pad_periphs_b_09_pad_mux_sel_led_g_gpio9 ;
    logic    pad_periphs_b_10_pad_mux_sel_led_b_gpio10;
    logic    pad_periphs_b_11_pad_mux_sel_gpio11      ;
    logic    pad_periphs_b_12_pad_mux_sel_gpio12      ;
    logic    pad_periphs_b_13_pad_mux_sel_gpio13      ;
    logic    pad_periphs_b_14_pad_mux_sel_gpio14      ;
    logic    pad_periphs_b_15_pad_mux_sel_adc0_gpio15 ;
    logic    pad_periphs_b_16_pad_mux_sel_adc0_gpio16 ;
    logic    pad_periphs_b_17_pad_mux_sel_adc0_gpio17 ;
    logic    pad_periphs_b_18_pad_mux_sel_pwrgd_gpio18;
    logic    pad_periphs_b_19_pad_mux_sel_cpi0_hsync  ;
    logic    pad_periphs_b_19_pad_mux_sel_drdy_gpio19 ;
    logic    pad_periphs_b_20_pad_mux_sel_cpi0_dat4   ;
    logic    pad_periphs_b_20_pad_mux_sel_drdy_gpio20 ;
    logic    pad_periphs_b_21_pad_mux_sel_cpi1_vsync  ;
    logic    pad_periphs_b_21_pad_mux_sel_drdy_gpio21 ;
    logic    pad_periphs_b_22_pad_mux_sel_cpi1_dat2   ;
    logic    pad_periphs_b_22_pad_mux_sel_rst_gpio22  ;
    logic    pad_periphs_b_23_pad_mux_sel_cpi1_dat3   ;
    logic    pad_periphs_b_23_pad_mux_sel_drdy1_gpio23;
    logic    pad_periphs_b_24_pad_mux_sel_cpi1_dat4   ;
    logic    pad_periphs_b_24_pad_mux_sel_drdy2_gpio24;
    logic    pad_periphs_b_25_pad_mux_sel_sdio1_d1    ;
    logic    pad_periphs_b_25_pad_mux_sel_nfc_gpio25  ;
    logic    pad_periphs_b_26_pad_mux_sel_gps1_gpio26 ;
    logic    pad_periphs_b_27_pad_mux_sel_gps1_gpio27 ;
    logic    pad_periphs_b_28_pad_mux_sel_gps1_gpio28 ;
    logic    pad_periphs_b_29_pad_mux_sel_io_gpio29   ;
    logic    pad_periphs_b_30_pad_mux_sel_io_gpio30   ;
    logic    pad_periphs_b_31_pad_mux_sel_io_gpio31   ;
    logic    pad_periphs_b_32_pad_mux_sel_io_gpio32   ;
    logic    pad_periphs_b_33_pad_mux_sel_io_gpio33   ;
    logic    pad_periphs_b_34_pad_mux_sel_io_gpio34   ;
    logic    pad_periphs_b_35_pad_mux_sel_io_gpio35   ;
    logic    pad_periphs_b_36_pad_mux_sel_io_gpio36   ;
    logic    pad_periphs_b_37_pad_mux_sel_io_gpio37   ;
    logic    pad_periphs_b_38_pad_mux_sel_io_gpio38   ;
    logic    pad_periphs_b_39_pad_mux_sel_io_gpio39   ;
    logic    pad_periphs_b_40_pad_mux_sel_io_gpio40   ;
    logic    pad_periphs_b_41_pad_mux_sel_io_gpio41   ;
    logic    pad_periphs_b_42_pad_mux_sel_io_gpio42   ;
    logic    pad_periphs_b_43_pad_mux_sel_io_gpio43   ;
    logic    pad_periphs_b_44_pad_mux_sel_io_gpio44   ;
    logic    pad_periphs_b_45_pad_mux_sel_io_gpio45   ;
    logic    pad_periphs_b_46_pad_mux_sel_io_gpio46   ;
    logic    pad_periphs_b_47_pad_mux_sel_eth_rst     ;
    logic    pad_periphs_b_47_pad_mux_sel_io_gpio47   ;
    logic    pad_periphs_b_48_pad_mux_sel_eth_rxck    ;
    logic    pad_periphs_b_48_pad_mux_sel_io_gpio48   ;
    logic    pad_periphs_b_49_pad_mux_sel_eth_rxctl   ;
    logic    pad_periphs_b_49_pad_mux_sel_io_gpio49   ;
    logic    pad_periphs_b_50_pad_mux_sel_eth_rxd0    ;
    logic    pad_periphs_b_50_pad_mux_sel_io_gpio50   ;
    logic    pad_periphs_b_51_pad_mux_sel_eth_rxd1    ;
    logic    pad_periphs_b_51_pad_mux_sel_io_gpio51   ;
    logic    pad_periphs_b_52_pad_mux_sel_eth_rxd2    ;
    logic    pad_periphs_b_52_pad_mux_sel_io_gpio52   ;
    logic    pad_periphs_b_53_pad_mux_sel_eth_rxd3    ;
    logic    pad_periphs_b_53_pad_mux_sel_io_gpio53   ;
    logic    pad_periphs_b_54_pad_mux_sel_eth_txck    ;
    logic    pad_periphs_b_54_pad_mux_sel_io_gpio54   ;
    logic    pad_periphs_b_55_pad_mux_sel_eth_txctl   ;
    logic    pad_periphs_b_55_pad_mux_sel_io_gpio55   ;
    logic    pad_periphs_b_56_pad_mux_sel_eth_txd0    ;
    logic    pad_periphs_b_56_pad_mux_sel_io_gpio56   ;
    logic    pad_periphs_b_57_pad_mux_sel_eth_txd1    ;
    logic    pad_periphs_b_57_pad_mux_sel_io_gpio57   ;
    logic    pad_periphs_b_58_pad_mux_sel_eth_txd2    ;
    logic    pad_periphs_b_58_pad_mux_sel_io_gpio58   ;
    logic    pad_periphs_b_59_pad_mux_sel_eth_txd3    ;
    logic    pad_periphs_b_59_pad_mux_sel_io_gpio59   ;
    logic    pad_periphs_b_60_pad_mux_sel_eth_mdio    ;
    logic    pad_periphs_b_60_pad_mux_sel_io_gpio60   ;
    logic    pad_periphs_b_61_pad_mux_sel_eth_mdc     ;
    logic    pad_periphs_b_61_pad_mux_sel_io_gpio61   ;
    logic    pad_periphs_b_62_pad_mux_sel_eth_intb    ;
    logic    pad_periphs_b_62_pad_mux_sel_io_gpio62   ;

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

  assign s_jtag2ot_tck        = s_tck         ;
  assign s_jtag2ot_tms        = s_ot_tms      ;
  assign s_jtag2ot_tdi        = s_ot_tdi      ;
  assign s_jtag2ot_trstn      = s_ot_trstn    ;
  assign s_ot_tdo             = s_jtag2ot_tdo ;

  if (~jtag_enable[0] & !LOCAL_JTAG & !PRELOAD_HYPERRAM) begin
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
          .jtag_TCK             ( s_jtag_to_alsaqr_tck   ),
          .jtag_TMS             ( s_jtag_to_alsaqr_tms   ),
          .jtag_TDI             ( s_jtag_to_alsaqr_tdi   ),
          .jtag_TRSTn           ( s_jtag_to_alsaqr_trstn ),
          .jtag_TDO_data        ( s_jtag_to_alsaqr_tdo   ),
          .jtag_TDO_driven      ( s_jtag_TDO_driven      ),

          .jtag_ot_TCK          ( s_jtag2ot_tck          ),
          .jtag_ot_TMS          ( s_jtag2ot_tms          ),
          .jtag_ot_TDI          ( s_jtag2ot_tdi          ),
          .jtag_ot_TRSTn        ( s_jtag2ot_trstn        ),
          .jtag_ot_TDO_data     ( s_jtag2ot_tdo          ),

          .cva6_uart_rx_i       ( w_cva6_uart_rx         ),
          .cva6_uart_tx_o       ( w_cva6_uart_tx         ),
          .apb_uart_rx_i        ( apb_uart_rx            ),
          .apb_uart_tx_o        ( apb_uart_tx            ),

        `ifndef EXCLUDE_PADFRAME

               .pad_periphs_a_00_pad(pad_periphs_a_00_pad),
               .pad_periphs_a_01_pad(pad_periphs_a_01_pad),
               .pad_periphs_a_02_pad(pad_periphs_a_02_pad),
               .pad_periphs_a_03_pad(pad_periphs_a_03_pad),
               .pad_periphs_a_04_pad(pad_periphs_a_04_pad),
               .pad_periphs_a_05_pad(pad_periphs_a_05_pad),
               .pad_periphs_a_06_pad(pad_periphs_a_06_pad),
               .pad_periphs_a_07_pad(pad_periphs_a_07_pad),
               .pad_periphs_a_08_pad(pad_periphs_a_08_pad),
               .pad_periphs_a_09_pad(pad_periphs_a_09_pad),
               .pad_periphs_a_10_pad(pad_periphs_a_10_pad),
               .pad_periphs_a_11_pad(pad_periphs_a_11_pad),
               .pad_periphs_a_12_pad(pad_periphs_a_12_pad),
               .pad_periphs_a_13_pad(pad_periphs_a_13_pad),

          `ifndef FPGA_EMUL
            `ifndef SIMPLE_PADFRAME
               .pad_periphs_a_14_pad(pad_periphs_a_14_pad),
               .pad_periphs_a_15_pad(pad_periphs_a_15_pad),
               .pad_periphs_a_16_pad(pad_periphs_a_16_pad),
               .pad_periphs_a_17_pad(pad_periphs_a_17_pad),
               .pad_periphs_a_18_pad(pad_periphs_a_18_pad),
               .pad_periphs_a_19_pad(pad_periphs_a_19_pad),
               .pad_periphs_a_20_pad(pad_periphs_a_20_pad),
               .pad_periphs_a_21_pad(pad_periphs_a_21_pad),
               .pad_periphs_a_22_pad(pad_periphs_a_22_pad),
               .pad_periphs_a_23_pad(pad_periphs_a_23_pad),
               .pad_periphs_a_24_pad(pad_periphs_a_24_pad),
               .pad_periphs_a_25_pad(pad_periphs_a_25_pad),
               .pad_periphs_a_26_pad(pad_periphs_a_26_pad),
               .pad_periphs_a_27_pad(pad_periphs_a_27_pad),
               .pad_periphs_a_28_pad(pad_periphs_a_28_pad),
               .pad_periphs_a_29_pad(pad_periphs_a_29_pad),
               .pad_periphs_a_30_pad(pad_periphs_a_30_pad),
               .pad_periphs_a_31_pad(pad_periphs_a_31_pad),
               .pad_periphs_a_32_pad(pad_periphs_a_32_pad),
               .pad_periphs_a_33_pad(pad_periphs_a_33_pad),
               .pad_periphs_a_34_pad(pad_periphs_a_34_pad),
               .pad_periphs_a_35_pad(pad_periphs_a_35_pad),
               .pad_periphs_a_36_pad(pad_periphs_a_36_pad),
               .pad_periphs_a_37_pad(pad_periphs_a_37_pad),
               .pad_periphs_a_38_pad(pad_periphs_a_38_pad),
               .pad_periphs_a_39_pad(pad_periphs_a_39_pad),
               .pad_periphs_a_40_pad(pad_periphs_a_40_pad),
               .pad_periphs_a_41_pad(pad_periphs_a_41_pad),
               .pad_periphs_a_42_pad(pad_periphs_a_42_pad),
               .pad_periphs_a_43_pad(pad_periphs_a_43_pad),
               .pad_periphs_a_44_pad(pad_periphs_a_44_pad),
               .pad_periphs_a_45_pad(pad_periphs_a_45_pad),
               .pad_periphs_a_46_pad(pad_periphs_a_46_pad),
               .pad_periphs_a_47_pad(pad_periphs_a_47_pad),
               .pad_periphs_a_48_pad(pad_periphs_a_48_pad),
               .pad_periphs_a_49_pad(pad_periphs_a_49_pad),
               .pad_periphs_a_50_pad(pad_periphs_a_50_pad),
               .pad_periphs_a_51_pad(pad_periphs_a_51_pad),
               .pad_periphs_a_52_pad(pad_periphs_a_52_pad),
               .pad_periphs_a_53_pad(pad_periphs_a_53_pad),
               .pad_periphs_a_54_pad(pad_periphs_a_54_pad),
               .pad_periphs_a_55_pad(pad_periphs_a_55_pad),
               .pad_periphs_a_56_pad(pad_periphs_a_56_pad),
               .pad_periphs_a_57_pad(pad_periphs_a_57_pad),
               .pad_periphs_a_58_pad(pad_periphs_a_58_pad),
               .pad_periphs_a_59_pad(pad_periphs_a_59_pad),
               .pad_periphs_a_60_pad(pad_periphs_a_60_pad),
               .pad_periphs_a_61_pad(pad_periphs_a_61_pad),
               .pad_periphs_a_62_pad(pad_periphs_a_62_pad),
               .pad_periphs_a_63_pad(pad_periphs_a_63_pad),
               .pad_periphs_a_64_pad(pad_periphs_a_64_pad),
               .pad_periphs_a_65_pad(pad_periphs_a_65_pad),
               .pad_periphs_a_66_pad(pad_periphs_a_66_pad),
               .pad_periphs_a_67_pad(pad_periphs_a_67_pad),
               .pad_periphs_a_68_pad(pad_periphs_a_68_pad),
               .pad_periphs_a_69_pad(pad_periphs_a_69_pad),
               .pad_periphs_a_70_pad(pad_periphs_a_70_pad),
               .pad_periphs_a_71_pad(pad_periphs_a_71_pad),
               .pad_periphs_a_72_pad(pad_periphs_a_72_pad),
               .pad_periphs_a_73_pad(pad_periphs_a_73_pad),
               .pad_periphs_a_74_pad(pad_periphs_a_74_pad),
               .pad_periphs_a_75_pad(pad_periphs_a_75_pad),
               .pad_periphs_a_76_pad(pad_periphs_a_76_pad),
               .pad_periphs_a_77_pad(pad_periphs_a_77_pad),
               .pad_periphs_a_78_pad(pad_periphs_a_78_pad),
               .pad_periphs_a_79_pad(pad_periphs_a_79_pad),
               .pad_periphs_a_80_pad(pad_periphs_a_80_pad),
               .pad_periphs_a_81_pad(pad_periphs_a_81_pad),
               .pad_periphs_a_82_pad(pad_periphs_a_82_pad),
               .pad_periphs_a_83_pad(pad_periphs_a_83_pad),
               .pad_periphs_a_84_pad(pad_periphs_a_84_pad),
               .pad_periphs_a_85_pad(pad_periphs_a_85_pad),
               .pad_periphs_a_86_pad(pad_periphs_a_86_pad),
               .pad_periphs_a_87_pad(pad_periphs_a_87_pad),
               .pad_periphs_a_88_pad(pad_periphs_a_88_pad),
               .pad_periphs_a_89_pad(pad_periphs_a_89_pad),
               .pad_periphs_a_90_pad(pad_periphs_a_90_pad),
               .pad_periphs_a_91_pad(pad_periphs_a_91_pad),
               .pad_periphs_a_92_pad(pad_periphs_a_92_pad),

               .pad_periphs_b_00_pad(pad_periphs_b_00_pad),
               .pad_periphs_b_01_pad(pad_periphs_b_01_pad),
               .pad_periphs_b_02_pad(pad_periphs_b_02_pad),
               .pad_periphs_b_03_pad(pad_periphs_b_03_pad),
               .pad_periphs_b_04_pad(pad_periphs_b_04_pad),
               .pad_periphs_b_05_pad(pad_periphs_b_05_pad),
               .pad_periphs_b_06_pad(pad_periphs_b_06_pad),
               .pad_periphs_b_07_pad(pad_periphs_b_07_pad),
               .pad_periphs_b_08_pad(pad_periphs_b_08_pad),
               .pad_periphs_b_09_pad(pad_periphs_b_09_pad),
               .pad_periphs_b_10_pad(pad_periphs_b_10_pad),
               .pad_periphs_b_11_pad(pad_periphs_b_11_pad),
               .pad_periphs_b_12_pad(pad_periphs_b_12_pad),
               .pad_periphs_b_13_pad(pad_periphs_b_13_pad),
               .pad_periphs_b_14_pad(pad_periphs_b_14_pad),
               .pad_periphs_b_15_pad(pad_periphs_b_15_pad),
               .pad_periphs_b_16_pad(pad_periphs_b_16_pad),
               .pad_periphs_b_17_pad(pad_periphs_b_17_pad),
               .pad_periphs_b_18_pad(pad_periphs_b_18_pad),
               .pad_periphs_b_19_pad(pad_periphs_b_19_pad),
               .pad_periphs_b_20_pad(pad_periphs_b_20_pad),
               .pad_periphs_b_21_pad(pad_periphs_b_21_pad),
               .pad_periphs_b_22_pad(pad_periphs_b_22_pad),
               .pad_periphs_b_23_pad(pad_periphs_b_23_pad),
               .pad_periphs_b_24_pad(pad_periphs_b_24_pad),
               .pad_periphs_b_25_pad(pad_periphs_b_25_pad),
               .pad_periphs_b_26_pad(pad_periphs_b_26_pad),
               .pad_periphs_b_27_pad(pad_periphs_b_27_pad),
               .pad_periphs_b_28_pad(pad_periphs_b_28_pad),
               .pad_periphs_b_29_pad(pad_periphs_b_29_pad),
               .pad_periphs_b_30_pad(pad_periphs_b_30_pad),
               .pad_periphs_b_31_pad(pad_periphs_b_31_pad),
               .pad_periphs_b_32_pad(pad_periphs_b_32_pad),
               .pad_periphs_b_33_pad(pad_periphs_b_33_pad),
               .pad_periphs_b_34_pad(pad_periphs_b_34_pad),
               .pad_periphs_b_35_pad(pad_periphs_b_35_pad),
               .pad_periphs_b_36_pad(pad_periphs_b_36_pad),
               .pad_periphs_b_37_pad(pad_periphs_b_37_pad),
               .pad_periphs_b_38_pad(pad_periphs_b_38_pad),
               .pad_periphs_b_39_pad(pad_periphs_b_39_pad),
               .pad_periphs_b_40_pad(pad_periphs_b_40_pad),
               .pad_periphs_b_41_pad(pad_periphs_b_41_pad),
               .pad_periphs_b_42_pad(pad_periphs_b_42_pad),
               .pad_periphs_b_43_pad(pad_periphs_b_43_pad),
               .pad_periphs_b_44_pad(pad_periphs_b_44_pad),
               .pad_periphs_b_45_pad(pad_periphs_b_45_pad),
               .pad_periphs_b_46_pad(pad_periphs_b_46_pad),
               .pad_periphs_b_47_pad(pad_periphs_b_47_pad),
               .pad_periphs_b_48_pad(pad_periphs_b_48_pad),
               .pad_periphs_b_49_pad(pad_periphs_b_49_pad),
               .pad_periphs_b_50_pad(pad_periphs_b_50_pad),
               .pad_periphs_b_51_pad(pad_periphs_b_51_pad),
               .pad_periphs_b_52_pad(pad_periphs_b_52_pad),
               .pad_periphs_b_53_pad(pad_periphs_b_53_pad),
               .pad_periphs_b_54_pad(pad_periphs_b_54_pad),
               .pad_periphs_b_55_pad(pad_periphs_b_55_pad),
               .pad_periphs_b_56_pad(pad_periphs_b_56_pad),
               .pad_periphs_b_57_pad(pad_periphs_b_57_pad),
               .pad_periphs_b_58_pad(pad_periphs_b_58_pad),
               .pad_periphs_b_59_pad(pad_periphs_b_59_pad),
               .pad_periphs_b_60_pad(pad_periphs_b_60_pad),
               .pad_periphs_b_61_pad(pad_periphs_b_61_pad),
               .pad_periphs_b_62_pad(pad_periphs_b_62_pad),

               .pad_periphs_ot_qspi_00_pad(pad_periphs_ot_qspi_00_pad),
               .pad_periphs_ot_qspi_01_pad(pad_periphs_ot_qspi_01_pad),
               .pad_periphs_ot_qspi_02_pad(pad_periphs_ot_qspi_02_pad),
               .pad_periphs_ot_qspi_03_pad(pad_periphs_ot_qspi_03_pad),
               .pad_periphs_ot_qspi_04_pad(pad_periphs_ot_qspi_04_pad),
               .pad_periphs_ot_qspi_05_pad(pad_periphs_ot_qspi_05_pad),

               .pad_periphs_linux_qspi_00_pad(pad_periphs_linux_qspi_00_pad),
               .pad_periphs_linux_qspi_01_pad(pad_periphs_linux_qspi_01_pad),
               .pad_periphs_linux_qspi_02_pad(pad_periphs_linux_qspi_02_pad),
               .pad_periphs_linux_qspi_03_pad(pad_periphs_linux_qspi_03_pad),
               .pad_periphs_linux_qspi_04_pad(pad_periphs_linux_qspi_04_pad),
               .pad_periphs_linux_qspi_05_pad(pad_periphs_linux_qspi_05_pad),

               .pad_periphs_ot_gpio_00_pad(pad_periphs_ot_gpio_00_pad),
               .pad_periphs_ot_gpio_01_pad(pad_periphs_ot_gpio_01_pad),

            `endif //simple pad
          `endif //fpga_emul
        `endif //exclude

        .pad_hyper_csn        ( hyper_cs_n_wire        ),
        .pad_hyper_ck         ( hyper_ck_wire          ),
        .pad_hyper_ckn        ( hyper_ck_n_wire        ),
        .pad_hyper_rwds       ( hyper_rwds_wire        ),
        .pad_hyper_reset      ( hyper_reset_n_wire     ),
        .pad_hyper_dq         ( hyper_dq_wire          ),

        .pad_bootmode         ( bootmode               )
      );

  //**************************************************
  // DEFAULT VIPs BEGINNING
  //**************************************************
  generate

    /* I2C VIPs
      I2C_MEM0 ADDRESS 0x50 -(dirrection bit)-> 0xA0
      I2C_MEM1 ADDRESS 0x50 -(dirrection bit)-> 0xA0
      I2C_MEM2 ADDRESS 0x51 -(dirrection bit)-> 0xA2
      I2C_MEM5 ADDRESS 0x53 -(dirrection bit)-> 0xA6
    */
    if (USE_24FC1025_MODEL == 1) begin
      `ifndef FPGA_EMUL
        `ifndef SIMPLE_PADFRAME

          // configure the I2C0 pads, non muxed
          pullup sda0_pullup_i (pad_periphs_a_01_pad_i2c0_sda);
          pullup scl0_pullup_i (pad_periphs_a_00_pad_i2c0_scl);
            M24FC1025 i_i2c_mem_0 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( pad_periphs_a_01_pad_i2c0_sda ),
              .SCL   ( pad_periphs_a_00_pad_i2c0_scl ),
              .RESET ( 1'b0       )
          );

          // configure the I2C1 pads, non muxed
          pullup sda1_pullup_i (pad_periphs_a_27_pad_i2c1_sda);
          pullup scl1_pullup_i (pad_periphs_a_26_pad_i2c1_scl);
            M24FC1025 i_i2c_mem_1 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( pad_periphs_a_27_pad_i2c1_sda ),
              .SCL   ( pad_periphs_a_26_pad_i2c1_scl ),
              .RESET ( 1'b0       )
          );

          // configure the I2C2 pads, non muxed
          pullup sda2_pullup_i (pad_periphs_a_37_pad_i2c2_sda);
          pullup scl2_pullup_i (pad_periphs_a_36_pad_i2c2_scl);
            M24FC1025 i_i2c_mem_2 (
              .A0    ( 1'b1       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( pad_periphs_a_37_pad_i2c2_sda ),
              .SCL   ( pad_periphs_a_36_pad_i2c2_scl ),
              .RESET ( 1'b0       )
          );

          // configure the I2C5 pads, non muxed
          pullup sda5_pullup_i (pad_periphs_a_68_pad_i2c5_sda);
          pullup scl5_pullup_i (pad_periphs_a_67_pad_i2c5_scl);
            M24FC1025 i_i2c_mem_5 (
              .A0    ( 1'b1       ),
              .A1    ( 1'b1       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( pad_periphs_a_68_pad_i2c5_sda ),
              .SCL   ( pad_periphs_a_67_pad_i2c5_scl ),
              .RESET ( 1'b0       )
          );

        `else // !`ifndef SIMPLE_PADFRAME

          //TODO

        `endif
      `endif
    end

    /* SPI VIPs
    */
    if(USE_S25FS256S_MODEL == 1) begin

      // configure the SPI0 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn0 (
        .SI       ( pad_periphs_a_05_pad_spi0_mosi ),
        .SO       ( pad_periphs_a_04_pad_spi0_miso ),
        .SCK      ( pad_periphs_a_02_pad_spi0_sck  ),
        .CSNeg    ( pad_periphs_a_03_pad_spi0_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI1 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn1 (
        .SI       ( pad_periphs_a_09_pad_spi1_mosi ),
        .SO       ( pad_periphs_a_08_pad_spi1_miso ),
        .SCK      ( pad_periphs_a_06_pad_spi1_sck  ),
        .CSNeg    ( pad_periphs_a_07_pad_spi1_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI2 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn2 (
        .SI       ( pad_periphs_a_13_pad_spi2_mosi ),
        .SO       ( pad_periphs_a_12_pad_spi2_miso ),
        .SCK      ( pad_periphs_a_10_pad_spi2_sck  ),
        .CSNeg    ( pad_periphs_a_11_pad_spi2_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI3 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn3 (
        .SI       ( pad_periphs_a_17_pad_spi3_mosi ),
        .SO       ( pad_periphs_a_16_pad_spi3_miso ),
        .SCK      ( pad_periphs_a_14_pad_spi3_sck  ),
        .CSNeg    ( pad_periphs_a_15_pad_spi3_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI4 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn4 (
        .SI       ( pad_periphs_a_35_pad_spi4_mosi ),
        .SO       ( pad_periphs_a_34_pad_spi4_miso ),
        .SCK      ( pad_periphs_a_32_pad_spi4_sck  ),
        .CSNeg    ( pad_periphs_a_33_pad_spi4_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

    end

    /* SDIO VIPs
    */
    if(USE_SDIO == 1) begin
      `ifndef FPGA_EMUL
        `ifndef SIMPLE_PADFRAME

          // config the SDIO0 pads, not muxed
          sdModel sdModelTB0(
          .sdClk ( pad_periphs_a_22_pad_sdio0_clk ),
          .cmd   ( pad_periphs_a_23_pad_sdio0_cmd ),
          .dat   ( {
                    pad_periphs_a_21_pad_sdio0_d4,
                    pad_periphs_a_20_pad_sdio0_d3,
                    pad_periphs_a_19_pad_sdio0_d2,
                    pad_periphs_a_18_pad_sdio0_d1
                 } )
          );

        `else // !`ifndef SIMPLE_PADFRAME

          //TODO

        `endif
      `endif
    end

    /* UART VIPs
    */
    if(USE_UART == 1) begin

      // config the UART0 pads, not muxed
      assign pad_periphs_a_25_pad_uart0_rx = pad_periphs_a_24_pad_uart0_tx; // UART0_TX -> UART0_RX

    end


    /* USART VIPs
    */
    if(USE_USART == 1) begin

      // config the USART0 pads, not muxed
      assign pad_periphs_a_29_pad_usart0_rx  = pad_periphs_a_28_pad_usart0_tx;  // UART0_TX  -> UART0_RX
      assign pad_periphs_a_31_pad_usart0_cts = pad_periphs_a_30_pad_usart0_rts; // UART0_RTS -> UART0_CTS

    end

  endgenerate

  //**************************************************
  // DEFAULT VIPs END
  //**************************************************

  //**************************************************
  // NANO VIPs BEGINNING
  //**************************************************
  generate

    /* CAM VIPs
    */
    if (USE_SDVT_CPI==1) begin
      `ifndef FPGA_EMUL
        `ifndef SIMPLE_PADFRAME

          // configure the CAM0 pads, muxed with I2C3 (42, 43), GPIO19 (19),
          // SPI5 (44, 45, 46, 47), GPIO20 (20) and SPI6 (48, 49, 50)
          cam_vip #(
            .HRES       ( 32 ), //320
            .VRES       ( 32 )  //240
          ) i_cam_vip_0 (
            .en_i        ( pad_periphs_b_11_pad_gpio11     ),  //GPIO11
            .cam_clk_o   ( pad_periphs_a_42_pad_cpi0_clk   ),
            .cam_vsync_o ( pad_periphs_a_43_pad_cpi0_vsync ),
            .cam_href_o  ( pad_periphs_b_19_pad_cpi0_hsync ),
            .cam_data_o  ( w_cam_0_data  )
          );
          assign pad_periphs_a_44_pad_cpi0_dat0 = w_cam_0_data[0];
          assign pad_periphs_a_45_pad_cpi0_dat1 = w_cam_0_data[1];
          assign pad_periphs_a_46_pad_cpi0_dat2 = w_cam_0_data[2];
          assign pad_periphs_a_47_pad_cpi0_dat3 = w_cam_0_data[3];
          assign pad_periphs_b_20_pad_cpi0_dat4 = w_cam_0_data[4];
          assign pad_periphs_a_48_pad_cpi0_dat5 = w_cam_0_data[5];
          assign pad_periphs_a_49_pad_cpi0_dat6 = w_cam_0_data[6];
          assign pad_periphs_a_50_pad_cpi0_dat7 = w_cam_0_data[7];

          // configure the CAM1 pads, muxed with SPI6 (51), GPIO21 (21), SPI7 (52, 53, 54),
          // GPIO22 (22), GPIO23 (23), GPIO24 (24) and SPI7 (55, 56, 57)
          cam_vip #(
            .HRES       ( 32 ), //320
            .VRES       ( 32 )  //240
          ) i_cam_vip_1 (
            .en_i        ( pad_periphs_b_12_pad_gpio12     ),  //GPIO12
            .cam_clk_o   ( pad_periphs_a_51_pad_cpi1_clk   ),
            .cam_vsync_o ( pad_periphs_b_21_pad_cpi1_vsync ),
            .cam_href_o  ( pad_periphs_a_52_pad_cpi1_hsync ),
            .cam_data_o  ( w_cam_1_data  )
          );
          assign pad_periphs_a_53_pad_cpi1_dat0 = w_cam_1_data[0];
          assign pad_periphs_a_54_pad_cpi1_dat1 = w_cam_1_data[1];
          assign pad_periphs_b_22_pad_cpi1_dat2 = w_cam_1_data[2];
          assign pad_periphs_b_23_pad_cpi1_dat3 = w_cam_1_data[3];
          assign pad_periphs_b_24_pad_cpi1_dat4 = w_cam_1_data[4];
          assign pad_periphs_a_55_pad_cpi1_dat5 = w_cam_1_data[5];
          assign pad_periphs_a_56_pad_cpi1_dat6 = w_cam_1_data[6];
          assign pad_periphs_a_57_pad_cpi1_dat7 = w_cam_1_data[7];

        `endif
      `endif
    end

    /* SDIO VIPs
    */
    if (USE_SDIO == 1) begin

      // config the SDIO1 pads, muxed with I2C4 (58), GPIO25 (25), UART1 (59, 60), USART1 (61, 62)
      sdModel sdModelTB1(
      .sdClk ( pad_periphs_a_61_pad_sdio1_clk ),
      .cmd   ( pad_periphs_a_62_pad_sdio1_cmd ),
      .dat   ( {
                pad_periphs_a_60_pad_sdio1_d3,
                pad_periphs_a_59_pad_sdio1_d2,
                pad_periphs_b_25_pad_sdio1_d1,
                pad_periphs_a_58_pad_sdio1_d0
              } )
      );

    end

    /* UART VIPs
    */
    if(USE_UART == 1) begin

      // config the UART1 pads, muxed with SDIO1
      assign pad_periphs_a_60_pad_uart1_rx = pad_periphs_a_59_pad_uart1_tx; // UART1_TX -> UART1_RX

      // config the UART2 pads, not muxed
      assign pad_periphs_a_66_pad_uart2_rx = pad_periphs_a_65_pad_uart2_tx; // UART2_TX -> UART2_RX

    end

  endgenerate
  //**************************************************
  // NANO VIPs END
  //**************************************************

  //**************************************************
  // STANDARD 0 VIPs BEGINNING
  //**************************************************
  generate

    /* I2C VIPs
      I2C_MEM3 ADDRESS 0x52 -(dirrection bit)-> 0xA4
      I2C_MEM4 ADDRESS 0x53 -(dirrection bit)-> 0xA6
    */
    if (USE_24FC1025_MODEL == 1) begin
      `ifndef FPGA_EMUL
        `ifndef SIMPLE_PADFRAME

          // configure the I2C3 pads, muxed with CPI0
          pullup sda3_pullup_i (pad_periphs_a_43_pad_i2c3_sda);
          pullup scl3_pullup_i (pad_periphs_a_42_pad_i2c3_scl);
            M24FC1025 i_i2c_mem_3 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b1       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( pad_periphs_a_43_pad_i2c3_sda ),
              .SCL   ( pad_periphs_a_42_pad_i2c3_scl ),
              .RESET ( 1'b0       )
          );

          // configure the I2C4 pads, muxed with SDIO1 (58) and CPI1 (57)
          pullup sda4_pullup_i (pad_periphs_a_58_pad_i2c4_sda);
          pullup scl4_pullup_i (pad_periphs_a_57_pad_i2c4_scl);
            M24FC1025 i_i2c_mem_4 (
              .A0    ( 1'b1       ),
              .A1    ( 1'b1       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( pad_periphs_a_58_pad_i2c4_sda ),
              .SCL   ( pad_periphs_a_57_pad_i2c4_scl ),
              .RESET ( 1'b0       )
          );

        `else // !`ifndef SIMPLE_PADFRAME

          //TODO

        `endif
      `endif
    end

    /* SPI VIPs
    */
    if(USE_S25FS256S_MODEL == 1) begin

      // configure the SPI5 pads, muxed with CPI0
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn5 (
        .SI       ( pad_periphs_a_47_pad_spi5_mosi ),
        .SO       ( pad_periphs_a_46_pad_spi5_miso ),
        .SCK      ( pad_periphs_a_44_pad_spi5_sck  ),
        .CSNeg    ( pad_periphs_a_45_pad_spi5_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI6 pads, muxed with CPI0 (48, 49, 50) and CPI1 (51)
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn6 (
        .SI       ( pad_periphs_a_51_pad_spi6_mosi ),
        .SO       ( pad_periphs_a_50_pad_spi6_miso ),
        .SCK      ( pad_periphs_a_48_pad_spi6_clk  ),
        .CSNeg    ( pad_periphs_a_49_pad_spi6_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI7 pads, muxed with CPI1
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn7 (
        .SI       ( pad_periphs_a_54_pad_spi7_mosi ),
        .SO       ( pad_periphs_a_53_pad_spi7_miso ),
        .SCK      ( pad_periphs_a_52_pad_spi7_sck  ),
        .CSNeg    ( pad_periphs_a_55_pad_spi7_cs0  ),  /*CS0*/
        // .CSNeg    ( pad_periphs_a_56_pad_spi7_cs1  ),  /*CS1*/
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI8 pads, muxed with CAN1 (81, 82) and CAN2 (83, 84)
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn8 (
        .SI       ( pad_periphs_a_84_pad_spi8_mosi ),
        .SO       ( pad_periphs_a_83_pad_spi8_miso ),
        .SCK      ( pad_periphs_a_81_pad_spi8_sck  ),
        .CSNeg    ( pad_periphs_a_82_pad_spi8_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI9 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn9 (
        .SI       ( pad_periphs_a_88_pad_spi9_mosi ),
        .SO       ( pad_periphs_a_87_pad_spi9_miso ),
        .SCK      ( pad_periphs_a_85_pad_spi9_sck  ),
        .CSNeg    ( pad_periphs_a_86_pad_spi9_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

      // configure the SPI10 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_spi_flash_csn10 (
        .SI       ( pad_periphs_a_92_pad_spi10_mosi ),
        .SO       ( pad_periphs_a_91_pad_spi10_miso ),
        .SCK      ( pad_periphs_a_89_pad_spi10_sck  ),
        .CSNeg    ( pad_periphs_a_90_pad_spi10_cs   ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );

    end

    /* USART VIPs
    */
    if(USE_USART == 1) begin

      // config the USART1 pads, muxed with SDIO1 (61, 62)
      assign pad_periphs_a_62_pad_usart1_rx  = pad_periphs_a_61_pad_usart1_tx;  // UART1_TX  -> UART1_RX
      assign pad_periphs_a_64_pad_usart1_cts = pad_periphs_a_63_pad_usart1_rts; // UART1_RTS -> UART1_CTS

      // config the USART2 pads, not muxed
      assign pad_periphs_a_70_pad_usart2_rx  = pad_periphs_a_69_pad_usart2_tx;  // UART2_TX  -> UART2_RX
      assign pad_periphs_a_72_pad_usart2_cts = pad_periphs_a_71_pad_usart2_rts; // UART2_RTS -> UART2_CTS

      // config the USART3 pads, not muxed
      assign pad_periphs_a_74_pad_usart3_rx  = pad_periphs_a_73_pad_usart3_tx;  // UART3_TX  -> UART3_RX
      assign pad_periphs_a_76_pad_usart3_cts = pad_periphs_a_75_pad_usart3_rts; // UART3_RTS -> UART3_CTS

    end

  endgenerate
  //**************************************************
  // STANDARD 0 VIPs END
  //**************************************************

  //**************************************************
  // STANDARD 1 VIPs BEGINNING
  //**************************************************
  generate

    /* CAN VIPs
    */
    if(USE_CAN == 1) begin

      // config the CAN0 pads, muxed with SPI8
      assign pad_periphs_a_82_pad_can0_rx = pad_periphs_a_81_pad_can0_tx; // CAN0_TX -> CAN0_RX

      // config the CAN1 pads, muxed with SPI8
      assign pad_periphs_a_84_pad_can1_rx = pad_periphs_a_83_pad_can1_tx; // CAN1_TX -> CAN1_RX

    end

  endgenerate
  //**************************************************
  // STANDARD 1 VIPs END
  //**************************************************

  //**************************************************
  // VIP MUX SEL BEGINNING
  //**************************************************
  assign pad_periphs_a_00_pad_mux_sel_i2c0_scl     = (`PAD_MUX_REG_PATH.a_00_mux_sel.q == PAD_MUX_GROUP_A_00_SEL_I2C0_I2C_SCL    );
  assign pad_periphs_a_01_pad_mux_sel_i2c0_sda     = (`PAD_MUX_REG_PATH.a_01_mux_sel.q == PAD_MUX_GROUP_A_01_SEL_I2C0_I2C_SDA    );
  assign pad_periphs_a_02_pad_mux_sel_spi0_sck     = (`PAD_MUX_REG_PATH.a_02_mux_sel.q == PAD_MUX_GROUP_A_02_SEL_SPI0_SPI_SCK    );
  assign pad_periphs_a_03_pad_mux_sel_spi0_cs      = (`PAD_MUX_REG_PATH.a_03_mux_sel.q == PAD_MUX_GROUP_A_03_SEL_SPI0_SPI_CS0    );
  assign pad_periphs_a_04_pad_mux_sel_spi0_miso    = (`PAD_MUX_REG_PATH.a_04_mux_sel.q == PAD_MUX_GROUP_A_04_SEL_SPI0_SPI_MISO   );
  assign pad_periphs_a_05_pad_mux_sel_spi0_mosi    = (`PAD_MUX_REG_PATH.a_05_mux_sel.q == PAD_MUX_GROUP_A_05_SEL_SPI0_SPI_MOSI   );
  assign pad_periphs_a_06_pad_mux_sel_spi1_sck     = (`PAD_MUX_REG_PATH.a_06_mux_sel.q == PAD_MUX_GROUP_A_06_SEL_SPI1_SPI_SCK    );
  assign pad_periphs_a_07_pad_mux_sel_spi1_cs      = (`PAD_MUX_REG_PATH.a_07_mux_sel.q == PAD_MUX_GROUP_A_07_SEL_SPI1_SPI_CS0    );
  assign pad_periphs_a_08_pad_mux_sel_spi1_miso    = (`PAD_MUX_REG_PATH.a_08_mux_sel.q == PAD_MUX_GROUP_A_08_SEL_SPI1_SPI_MISO   );
  assign pad_periphs_a_09_pad_mux_sel_spi1_mosi    = (`PAD_MUX_REG_PATH.a_09_mux_sel.q == PAD_MUX_GROUP_A_09_SEL_SPI1_SPI_MOSI   );
  assign pad_periphs_a_10_pad_mux_sel_spi2_sck     = (`PAD_MUX_REG_PATH.a_10_mux_sel.q == PAD_MUX_GROUP_A_10_SEL_SPI2_SPI_SCK    );
  assign pad_periphs_a_11_pad_mux_sel_spi2_cs      = (`PAD_MUX_REG_PATH.a_11_mux_sel.q == PAD_MUX_GROUP_A_11_SEL_SPI2_SPI_CS0    );
  assign pad_periphs_a_12_pad_mux_sel_spi2_miso    = (`PAD_MUX_REG_PATH.a_12_mux_sel.q == PAD_MUX_GROUP_A_12_SEL_SPI2_SPI_MISO   );
  assign pad_periphs_a_13_pad_mux_sel_spi2_mosi    = (`PAD_MUX_REG_PATH.a_13_mux_sel.q == PAD_MUX_GROUP_A_13_SEL_SPI2_SPI_MOSI   );
  assign pad_periphs_a_14_pad_mux_sel_spi3_sck     = (`PAD_MUX_REG_PATH.a_14_mux_sel.q == PAD_MUX_GROUP_A_14_SEL_SPI3_SPI_SCK    );
  assign pad_periphs_a_15_pad_mux_sel_spi3_cs      = (`PAD_MUX_REG_PATH.a_15_mux_sel.q == PAD_MUX_GROUP_A_15_SEL_SPI3_SPI_CS0    );
  assign pad_periphs_a_16_pad_mux_sel_spi3_miso    = (`PAD_MUX_REG_PATH.a_16_mux_sel.q == PAD_MUX_GROUP_A_16_SEL_SPI3_SPI_MISO   );
  assign pad_periphs_a_17_pad_mux_sel_spi3_mosi    = (`PAD_MUX_REG_PATH.a_17_mux_sel.q == PAD_MUX_GROUP_A_17_SEL_SPI3_SPI_MOSI   );
  assign pad_periphs_a_18_pad_mux_sel_sdio0_d1     = (`PAD_MUX_REG_PATH.a_18_mux_sel.q == PAD_MUX_GROUP_A_18_SEL_SDIO0_SDIO_DATA0);
  assign pad_periphs_a_19_pad_mux_sel_sdio0_d2     = (`PAD_MUX_REG_PATH.a_19_mux_sel.q == PAD_MUX_GROUP_A_19_SEL_SDIO0_SDIO_DATA1);
  assign pad_periphs_a_20_pad_mux_sel_sdio0_d3     = (`PAD_MUX_REG_PATH.a_20_mux_sel.q == PAD_MUX_GROUP_A_20_SEL_SDIO0_SDIO_DATA2);
  assign pad_periphs_a_21_pad_mux_sel_sdio0_d4     = (`PAD_MUX_REG_PATH.a_21_mux_sel.q == PAD_MUX_GROUP_A_21_SEL_SDIO0_SDIO_DATA3);
  assign pad_periphs_a_22_pad_mux_sel_sdio0_clk    = (`PAD_MUX_REG_PATH.a_22_mux_sel.q == PAD_MUX_GROUP_A_22_SEL_SDIO0_SDIO_CLK  );
  assign pad_periphs_a_23_pad_mux_sel_sdio0_cmd    = (`PAD_MUX_REG_PATH.a_23_mux_sel.q == PAD_MUX_GROUP_A_23_SEL_SDIO0_SDIO_CMD  );
  assign pad_periphs_a_24_pad_mux_sel_uart0_tx     = (`PAD_MUX_REG_PATH.a_24_mux_sel.q == PAD_MUX_GROUP_A_24_SEL_UART0_UART_TX   );
  assign pad_periphs_a_25_pad_mux_sel_uart0_rx     = (`PAD_MUX_REG_PATH.a_25_mux_sel.q == PAD_MUX_GROUP_A_25_SEL_UART0_UART_RX   );
  assign pad_periphs_a_26_pad_mux_sel_i2c1_scl     = (`PAD_MUX_REG_PATH.a_26_mux_sel.q == PAD_MUX_GROUP_A_26_SEL_I2C1_I2C_SCL    );
  assign pad_periphs_a_27_pad_mux_sel_i2c1_sda     = (`PAD_MUX_REG_PATH.a_27_mux_sel.q == PAD_MUX_GROUP_A_27_SEL_I2C1_I2C_SDA    );
  assign pad_periphs_a_28_pad_mux_sel_usart0_tx    = (`PAD_MUX_REG_PATH.a_28_mux_sel.q == PAD_MUX_GROUP_A_28_SEL_USART0_UART_TX  );
  assign pad_periphs_a_29_pad_mux_sel_usart0_rx    = (`PAD_MUX_REG_PATH.a_29_mux_sel.q == PAD_MUX_GROUP_A_29_SEL_USART0_UART_RX  );
  assign pad_periphs_a_30_pad_mux_sel_usart0_rts   = (`PAD_MUX_REG_PATH.a_30_mux_sel.q == PAD_MUX_GROUP_A_30_SEL_USART0_UART_RTS );
  assign pad_periphs_a_31_pad_mux_sel_usart0_cts   = (`PAD_MUX_REG_PATH.a_31_mux_sel.q == PAD_MUX_GROUP_A_31_SEL_USART0_UART_CTS );
  assign pad_periphs_a_32_pad_mux_sel_spi4_sck     = (`PAD_MUX_REG_PATH.a_32_mux_sel.q == PAD_MUX_GROUP_A_32_SEL_SPI4_SPI_SCK    );
  assign pad_periphs_a_33_pad_mux_sel_spi4_cs      = (`PAD_MUX_REG_PATH.a_33_mux_sel.q == PAD_MUX_GROUP_A_33_SEL_SPI4_SPI_CS0    );
  assign pad_periphs_a_34_pad_mux_sel_spi4_miso    = (`PAD_MUX_REG_PATH.a_34_mux_sel.q == PAD_MUX_GROUP_A_34_SEL_SPI4_SPI_MISO   );
  assign pad_periphs_a_35_pad_mux_sel_spi4_mosi    = (`PAD_MUX_REG_PATH.a_35_mux_sel.q == PAD_MUX_GROUP_A_35_SEL_SPI4_SPI_MOSI   );
  assign pad_periphs_a_36_pad_mux_sel_i2c2_scl     = (`PAD_MUX_REG_PATH.a_36_mux_sel.q == PAD_MUX_GROUP_A_36_SEL_I2C2_I2C_SCL    );
  assign pad_periphs_a_37_pad_mux_sel_i2c2_sda     = (`PAD_MUX_REG_PATH.a_37_mux_sel.q == PAD_MUX_GROUP_A_37_SEL_I2C2_I2C_SDA    );
  assign pad_periphs_a_38_pad_mux_sel_pwm_out0     = (`PAD_MUX_REG_PATH.a_38_mux_sel.q == PAD_MUX_GROUP_A_38_SEL_PWM0_PWM0       );
  assign pad_periphs_a_39_pad_mux_sel_pwm_out1     = (`PAD_MUX_REG_PATH.a_39_mux_sel.q == PAD_MUX_GROUP_A_39_SEL_PWM0_PWM1       );
  assign pad_periphs_a_40_pad_mux_sel_pwm_out2     = (`PAD_MUX_REG_PATH.a_40_mux_sel.q == PAD_MUX_GROUP_A_40_SEL_PWM0_PWM2       );
  assign pad_periphs_a_41_pad_mux_sel_pwm_out3     = (`PAD_MUX_REG_PATH.a_41_mux_sel.q == PAD_MUX_GROUP_A_41_SEL_PWM0_PWM3       );
  assign pad_periphs_a_42_pad_mux_sel_cpi0_clk     = (`PAD_MUX_REG_PATH.a_42_mux_sel.q == PAD_MUX_GROUP_A_42_SEL_CAM0_CAM_PCLK   );
  assign pad_periphs_a_42_pad_mux_sel_i2c3_scl     = (`PAD_MUX_REG_PATH.a_42_mux_sel.q == PAD_MUX_GROUP_A_42_SEL_I2C3_I2C_SCL    );
  assign pad_periphs_a_43_pad_mux_sel_cpi0_vsync   = (`PAD_MUX_REG_PATH.a_43_mux_sel.q == PAD_MUX_GROUP_A_43_SEL_CAM0_CAM_VSYNC  );
  assign pad_periphs_a_43_pad_mux_sel_i2c3_sda     = (`PAD_MUX_REG_PATH.a_43_mux_sel.q == PAD_MUX_GROUP_A_43_SEL_I2C3_I2C_SDA    );
  assign pad_periphs_a_44_pad_mux_sel_cpi0_dat0    = (`PAD_MUX_REG_PATH.a_44_mux_sel.q == PAD_MUX_GROUP_A_44_SEL_CAM0_CAM_DATA0_I);
  assign pad_periphs_a_44_pad_mux_sel_spi5_sck     = (`PAD_MUX_REG_PATH.a_44_mux_sel.q == PAD_MUX_GROUP_A_44_SEL_SPI5_SPI_SCK    );
  assign pad_periphs_a_45_pad_mux_sel_cpi0_dat1    = (`PAD_MUX_REG_PATH.a_45_mux_sel.q == PAD_MUX_GROUP_A_45_SEL_CAM0_CAM_DATA1_I);
  assign pad_periphs_a_45_pad_mux_sel_spi5_cs      = (`PAD_MUX_REG_PATH.a_45_mux_sel.q == PAD_MUX_GROUP_A_45_SEL_SPI5_SPI_CS0    );
  assign pad_periphs_a_46_pad_mux_sel_cpi0_dat2    = (`PAD_MUX_REG_PATH.a_46_mux_sel.q == PAD_MUX_GROUP_A_46_SEL_CAM0_CAM_DATA2_I);
  assign pad_periphs_a_46_pad_mux_sel_spi5_miso    = (`PAD_MUX_REG_PATH.a_46_mux_sel.q == PAD_MUX_GROUP_A_46_SEL_SPI5_SPI_MISO   );
  assign pad_periphs_a_47_pad_mux_sel_cpi0_dat3    = (`PAD_MUX_REG_PATH.a_47_mux_sel.q == PAD_MUX_GROUP_A_47_SEL_CAM0_CAM_DATA3_I);
  assign pad_periphs_a_47_pad_mux_sel_spi5_mosi    = (`PAD_MUX_REG_PATH.a_47_mux_sel.q == PAD_MUX_GROUP_A_47_SEL_SPI5_SPI_MOSI   );
  assign pad_periphs_a_48_pad_mux_sel_cpi0_dat5    = (`PAD_MUX_REG_PATH.a_48_mux_sel.q == PAD_MUX_GROUP_A_48_SEL_CAM0_CAM_DATA5_I);
  assign pad_periphs_a_48_pad_mux_sel_spi6_clk     = (`PAD_MUX_REG_PATH.a_48_mux_sel.q == PAD_MUX_GROUP_A_48_SEL_SPI6_SPI_SCK    );
  assign pad_periphs_a_49_pad_mux_sel_cpi0_dat6    = (`PAD_MUX_REG_PATH.a_49_mux_sel.q == PAD_MUX_GROUP_A_49_SEL_CAM0_CAM_DATA6_I);
  assign pad_periphs_a_49_pad_mux_sel_spi6_cs      = (`PAD_MUX_REG_PATH.a_49_mux_sel.q == PAD_MUX_GROUP_A_49_SEL_SPI6_SPI_CS0    );
  assign pad_periphs_a_50_pad_mux_sel_cpi0_dat7    = (`PAD_MUX_REG_PATH.a_50_mux_sel.q == PAD_MUX_GROUP_A_50_SEL_CAM0_CAM_DATA7_I);
  assign pad_periphs_a_50_pad_mux_sel_spi6_miso    = (`PAD_MUX_REG_PATH.a_50_mux_sel.q == PAD_MUX_GROUP_A_50_SEL_SPI6_SPI_MISO   );
  assign pad_periphs_a_51_pad_mux_sel_cpi1_clk     = (`PAD_MUX_REG_PATH.a_51_mux_sel.q == PAD_MUX_GROUP_A_51_SEL_CAM1_CAM_PCLK   );
  assign pad_periphs_a_51_pad_mux_sel_spi6_mosi    = (`PAD_MUX_REG_PATH.a_51_mux_sel.q == PAD_MUX_GROUP_A_51_SEL_SPI6_SPI_MOSI   );
  assign pad_periphs_a_52_pad_mux_sel_cpi1_hsync   = (`PAD_MUX_REG_PATH.a_52_mux_sel.q == PAD_MUX_GROUP_A_52_SEL_CAM1_CAM_HSYNC  );
  assign pad_periphs_a_52_pad_mux_sel_spi7_sck     = (`PAD_MUX_REG_PATH.a_52_mux_sel.q == PAD_MUX_GROUP_A_52_SEL_SPI7_SPI_SCK    );
  assign pad_periphs_a_53_pad_mux_sel_cpi1_dat0    = (`PAD_MUX_REG_PATH.a_53_mux_sel.q == PAD_MUX_GROUP_A_53_SEL_CAM1_CAM_DATA0_I);
  assign pad_periphs_a_53_pad_mux_sel_spi7_miso    = (`PAD_MUX_REG_PATH.a_53_mux_sel.q == PAD_MUX_GROUP_A_53_SEL_SPI7_SPI_MISO   );
  assign pad_periphs_a_54_pad_mux_sel_cpi1_dat1    = (`PAD_MUX_REG_PATH.a_54_mux_sel.q == PAD_MUX_GROUP_A_54_SEL_CAM1_CAM_DATA1_I);
  assign pad_periphs_a_54_pad_mux_sel_spi7_mosi    = (`PAD_MUX_REG_PATH.a_54_mux_sel.q == PAD_MUX_GROUP_A_54_SEL_SPI7_SPI_MOSI   );
  assign pad_periphs_a_55_pad_mux_sel_cpi1_dat5    = (`PAD_MUX_REG_PATH.a_55_mux_sel.q == PAD_MUX_GROUP_A_55_SEL_CAM1_CAM_DATA5_I);
  assign pad_periphs_a_55_pad_mux_sel_spi7_cs0     = (`PAD_MUX_REG_PATH.a_55_mux_sel.q == PAD_MUX_GROUP_A_55_SEL_SPI7_SPI_CS0    );
  assign pad_periphs_a_56_pad_mux_sel_cpi1_dat6    = (`PAD_MUX_REG_PATH.a_56_mux_sel.q == PAD_MUX_GROUP_A_56_SEL_CAM1_CAM_DATA6_I);
  assign pad_periphs_a_56_pad_mux_sel_spi7_cs1     = (`PAD_MUX_REG_PATH.a_56_mux_sel.q == PAD_MUX_GROUP_A_56_SEL_SPI7_SPI_CS1    );
  assign pad_periphs_a_57_pad_mux_sel_cpi1_dat7    = (`PAD_MUX_REG_PATH.a_57_mux_sel.q == PAD_MUX_GROUP_A_57_SEL_CAM1_CAM_DATA7_I);
  assign pad_periphs_a_57_pad_mux_sel_i2c4_scl     = (`PAD_MUX_REG_PATH.a_57_mux_sel.q == PAD_MUX_GROUP_A_57_SEL_I2C4_I2C_SCL    );
  assign pad_periphs_a_58_pad_mux_sel_sdio1_d0     = (`PAD_MUX_REG_PATH.a_58_mux_sel.q == PAD_MUX_GROUP_A_58_SEL_SDIO1_SDIO_DATA0);
  assign pad_periphs_a_58_pad_mux_sel_i2c4_sda     = (`PAD_MUX_REG_PATH.a_58_mux_sel.q == PAD_MUX_GROUP_A_58_SEL_I2C4_I2C_SDA    );
  assign pad_periphs_a_59_pad_mux_sel_sdio1_d2     = (`PAD_MUX_REG_PATH.a_59_mux_sel.q == PAD_MUX_GROUP_A_59_SEL_SDIO1_SDIO_DATA2);
  assign pad_periphs_a_59_pad_mux_sel_uart1_tx     = (`PAD_MUX_REG_PATH.a_59_mux_sel.q == PAD_MUX_GROUP_A_59_SEL_UART1_UART_TX   );
  assign pad_periphs_a_60_pad_mux_sel_sdio1_d3     = (`PAD_MUX_REG_PATH.a_60_mux_sel.q == PAD_MUX_GROUP_A_60_SEL_SDIO1_SDIO_DATA3);
  assign pad_periphs_a_60_pad_mux_sel_uart1_rx     = (`PAD_MUX_REG_PATH.a_60_mux_sel.q == PAD_MUX_GROUP_A_60_SEL_UART1_UART_RX   );
  assign pad_periphs_a_61_pad_mux_sel_sdio1_clk    = (`PAD_MUX_REG_PATH.a_61_mux_sel.q == PAD_MUX_GROUP_A_61_SEL_SDIO1_SDIO_CLK  );
  assign pad_periphs_a_61_pad_mux_sel_usart1_tx    = (`PAD_MUX_REG_PATH.a_61_mux_sel.q == PAD_MUX_GROUP_A_61_SEL_USART1_UART_TX  );
  assign pad_periphs_a_62_pad_mux_sel_sdio1_cmd    = (`PAD_MUX_REG_PATH.a_62_mux_sel.q == PAD_MUX_GROUP_A_62_SEL_SDIO1_SDIO_CMD  );
  assign pad_periphs_a_62_pad_mux_sel_usart1_rx    = (`PAD_MUX_REG_PATH.a_62_mux_sel.q == PAD_MUX_GROUP_A_62_SEL_USART1_UART_RX  );
  assign pad_periphs_a_63_pad_mux_sel_usart1_rts   = (`PAD_MUX_REG_PATH.a_63_mux_sel.q == PAD_MUX_GROUP_A_63_SEL_USART1_UART_RTS );
  assign pad_periphs_a_64_pad_mux_sel_usart1_cts   = (`PAD_MUX_REG_PATH.a_64_mux_sel.q == PAD_MUX_GROUP_A_64_SEL_USART1_UART_CTS );
  assign pad_periphs_a_65_pad_mux_sel_uart2_tx     = (`PAD_MUX_REG_PATH.a_65_mux_sel.q == PAD_MUX_GROUP_A_65_SEL_UART2_UART_TX   );
  assign pad_periphs_a_66_pad_mux_sel_uart2_rx     = (`PAD_MUX_REG_PATH.a_66_mux_sel.q == PAD_MUX_GROUP_A_66_SEL_UART2_UART_RX   );
  assign pad_periphs_a_67_pad_mux_sel_i2c5_scl     = (`PAD_MUX_REG_PATH.a_67_mux_sel.q == PAD_MUX_GROUP_A_67_SEL_I2C5_I2C_SCL    );
  assign pad_periphs_a_68_pad_mux_sel_i2c5_sda     = (`PAD_MUX_REG_PATH.a_68_mux_sel.q == PAD_MUX_GROUP_A_68_SEL_I2C5_I2C_SDA    );
  assign pad_periphs_a_69_pad_mux_sel_usart2_tx    = (`PAD_MUX_REG_PATH.a_69_mux_sel.q == PAD_MUX_GROUP_A_69_SEL_USART2_UART_TX  );
  assign pad_periphs_a_70_pad_mux_sel_usart2_rx    = (`PAD_MUX_REG_PATH.a_70_mux_sel.q == PAD_MUX_GROUP_A_70_SEL_USART2_UART_RX  );
  assign pad_periphs_a_71_pad_mux_sel_usart2_rts   = (`PAD_MUX_REG_PATH.a_71_mux_sel.q == PAD_MUX_GROUP_A_71_SEL_USART2_UART_RTS );
  assign pad_periphs_a_72_pad_mux_sel_usart2_cts   = (`PAD_MUX_REG_PATH.a_72_mux_sel.q == PAD_MUX_GROUP_A_72_SEL_USART2_UART_CTS );
  assign pad_periphs_a_73_pad_mux_sel_usart3_tx    = (`PAD_MUX_REG_PATH.a_73_mux_sel.q == PAD_MUX_GROUP_A_73_SEL_USART3_UART_TX  );
  assign pad_periphs_a_74_pad_mux_sel_usart3_rx    = (`PAD_MUX_REG_PATH.a_74_mux_sel.q == PAD_MUX_GROUP_A_74_SEL_USART3_UART_RX  );
  assign pad_periphs_a_75_pad_mux_sel_usart3_rts   = (`PAD_MUX_REG_PATH.a_75_mux_sel.q == PAD_MUX_GROUP_A_75_SEL_USART3_UART_RTS );
  assign pad_periphs_a_76_pad_mux_sel_usart3_cts   = (`PAD_MUX_REG_PATH.a_76_mux_sel.q == PAD_MUX_GROUP_A_76_SEL_USART3_UART_CTS );
  assign pad_periphs_a_77_pad_mux_sel_pwm_out4     = (`PAD_MUX_REG_PATH.a_77_mux_sel.q == PAD_MUX_GROUP_A_77_SEL_PWM1_PWM0       );
  assign pad_periphs_a_78_pad_mux_sel_pwm_out5     = (`PAD_MUX_REG_PATH.a_78_mux_sel.q == PAD_MUX_GROUP_A_78_SEL_PWM1_PWM1       );
  assign pad_periphs_a_79_pad_mux_sel_pwm_out6     = (`PAD_MUX_REG_PATH.a_79_mux_sel.q == PAD_MUX_GROUP_A_79_SEL_PWM1_PWM2       );
  assign pad_periphs_a_80_pad_mux_sel_pwm_out7     = (`PAD_MUX_REG_PATH.a_80_mux_sel.q == PAD_MUX_GROUP_A_80_SEL_PWM1_PWM3       );
  assign pad_periphs_a_81_pad_mux_sel_spi8_sck     = (`PAD_MUX_REG_PATH.a_81_mux_sel.q == PAD_MUX_GROUP_A_81_SEL_SPI8_SPI_SCK    );
  assign pad_periphs_a_81_pad_mux_sel_can0_tx      = (`PAD_MUX_REG_PATH.a_81_mux_sel.q == PAD_MUX_GROUP_A_81_SEL_CAN0_CAN_TX     );
  assign pad_periphs_a_82_pad_mux_sel_spi8_cs      = (`PAD_MUX_REG_PATH.a_82_mux_sel.q == PAD_MUX_GROUP_A_82_SEL_SPI8_SPI_CS0    );
  assign pad_periphs_a_82_pad_mux_sel_can0_rx      = (`PAD_MUX_REG_PATH.a_82_mux_sel.q == PAD_MUX_GROUP_A_82_SEL_CAN0_CAN_RX     );
  assign pad_periphs_a_83_pad_mux_sel_spi8_miso    = (`PAD_MUX_REG_PATH.a_83_mux_sel.q == PAD_MUX_GROUP_A_83_SEL_SPI8_SPI_MISO   );
  assign pad_periphs_a_83_pad_mux_sel_can1_tx      = (`PAD_MUX_REG_PATH.a_83_mux_sel.q == PAD_MUX_GROUP_A_83_SEL_CAN1_CAN_TX     );
  assign pad_periphs_a_84_pad_mux_sel_spi8_mosi    = (`PAD_MUX_REG_PATH.a_84_mux_sel.q == PAD_MUX_GROUP_A_84_SEL_SPI8_SPI_MOSI   );
  assign pad_periphs_a_84_pad_mux_sel_can1_rx      = (`PAD_MUX_REG_PATH.a_84_mux_sel.q == PAD_MUX_GROUP_A_84_SEL_CAN1_CAN_RX     );
  assign pad_periphs_a_85_pad_mux_sel_spi9_sck     = (`PAD_MUX_REG_PATH.a_85_mux_sel.q == PAD_MUX_GROUP_A_85_SEL_SPI9_SPI_SCK    );
  assign pad_periphs_a_86_pad_mux_sel_spi9_cs      = (`PAD_MUX_REG_PATH.a_86_mux_sel.q == PAD_MUX_GROUP_A_86_SEL_SPI9_SPI_CS0    );
  assign pad_periphs_a_87_pad_mux_sel_spi9_miso    = (`PAD_MUX_REG_PATH.a_87_mux_sel.q == PAD_MUX_GROUP_A_87_SEL_SPI9_SPI_MISO   );
  assign pad_periphs_a_88_pad_mux_sel_spi9_mosi    = (`PAD_MUX_REG_PATH.a_88_mux_sel.q == PAD_MUX_GROUP_A_88_SEL_SPI9_SPI_MOSI   );
  assign pad_periphs_a_89_pad_mux_sel_spi10_sck    = (`PAD_MUX_REG_PATH.a_89_mux_sel.q == PAD_MUX_GROUP_A_89_SEL_SPI10_SPI_SCK   );
  assign pad_periphs_a_90_pad_mux_sel_spi10_cs     = (`PAD_MUX_REG_PATH.a_90_mux_sel.q == PAD_MUX_GROUP_A_90_SEL_SPI10_SPI_CS0   );
  assign pad_periphs_a_91_pad_mux_sel_spi10_miso   = (`PAD_MUX_REG_PATH.a_91_mux_sel.q == PAD_MUX_GROUP_A_91_SEL_SPI10_SPI_MISO  );
  assign pad_periphs_a_92_pad_mux_sel_spi10_mosi   = (`PAD_MUX_REG_PATH.a_92_mux_sel.q == PAD_MUX_GROUP_A_92_SEL_SPI10_SPI_MOSI  );

  assign pad_periphs_b_00_pad_mux_sel_drdy_gpio0   = (`PAD_MUX_REG_PATH.b_00_mux_sel.q == PAD_MUX_GROUP_B_00_SEL_GPIO_B_GPIO0    );
  assign pad_periphs_b_01_pad_mux_sel_drdy_gpio1   = (`PAD_MUX_REG_PATH.b_01_mux_sel.q == PAD_MUX_GROUP_B_01_SEL_GPIO_B_GPIO1    );
  assign pad_periphs_b_02_pad_mux_sel_drdy_gpio2   = (`PAD_MUX_REG_PATH.b_02_mux_sel.q == PAD_MUX_GROUP_B_02_SEL_GPIO_B_GPIO2    );
  assign pad_periphs_b_03_pad_mux_sel_sync_gpio3   = (`PAD_MUX_REG_PATH.b_03_mux_sel.q == PAD_MUX_GROUP_B_03_SEL_GPIO_B_GPIO3    );
  assign pad_periphs_b_04_pad_mux_sel_adio_gpio4   = (`PAD_MUX_REG_PATH.b_04_mux_sel.q == PAD_MUX_GROUP_B_04_SEL_GPIO_B_GPIO4    );
  assign pad_periphs_b_05_pad_mux_sel_adio_gpio5   = (`PAD_MUX_REG_PATH.b_05_mux_sel.q == PAD_MUX_GROUP_B_05_SEL_GPIO_B_GPIO5    );
  assign pad_periphs_b_06_pad_mux_sel_adio_gpio6   = (`PAD_MUX_REG_PATH.b_06_mux_sel.q == PAD_MUX_GROUP_B_06_SEL_GPIO_B_GPIO6    );
  assign pad_periphs_b_07_pad_mux_sel_adio_gpio7   = (`PAD_MUX_REG_PATH.b_07_mux_sel.q == PAD_MUX_GROUP_B_07_SEL_GPIO_B_GPIO7    );
  assign pad_periphs_b_08_pad_mux_sel_led_r_gpio8  = (`PAD_MUX_REG_PATH.b_08_mux_sel.q == PAD_MUX_GROUP_B_08_SEL_GPIO_B_GPIO8    );
  assign pad_periphs_b_09_pad_mux_sel_led_g_gpio9  = (`PAD_MUX_REG_PATH.b_09_mux_sel.q == PAD_MUX_GROUP_B_09_SEL_GPIO_B_GPIO9    );
  assign pad_periphs_b_10_pad_mux_sel_led_b_gpio10 = (`PAD_MUX_REG_PATH.b_10_mux_sel.q == PAD_MUX_GROUP_B_10_SEL_GPIO_B_GPIO10   );
  assign pad_periphs_b_11_pad_mux_sel_gpio11       = (`PAD_MUX_REG_PATH.b_11_mux_sel.q == PAD_MUX_GROUP_B_11_SEL_GPIO_B_GPIO11   );
  assign pad_periphs_b_12_pad_mux_sel_gpio12       = (`PAD_MUX_REG_PATH.b_12_mux_sel.q == PAD_MUX_GROUP_B_12_SEL_GPIO_B_GPIO12   );
  assign pad_periphs_b_13_pad_mux_sel_gpio13       = (`PAD_MUX_REG_PATH.b_13_mux_sel.q == PAD_MUX_GROUP_B_13_SEL_GPIO_B_GPIO13   );
  assign pad_periphs_b_14_pad_mux_sel_gpio14       = (`PAD_MUX_REG_PATH.b_14_mux_sel.q == PAD_MUX_GROUP_B_14_SEL_GPIO_B_GPIO14   );
  assign pad_periphs_b_15_pad_mux_sel_adc0_gpio15  = (`PAD_MUX_REG_PATH.b_15_mux_sel.q == PAD_MUX_GROUP_B_15_SEL_GPIO_B_GPIO15   );
  assign pad_periphs_b_16_pad_mux_sel_adc0_gpio16  = (`PAD_MUX_REG_PATH.b_16_mux_sel.q == PAD_MUX_GROUP_B_16_SEL_GPIO_B_GPIO16   );
  assign pad_periphs_b_17_pad_mux_sel_adc0_gpio17  = (`PAD_MUX_REG_PATH.b_17_mux_sel.q == PAD_MUX_GROUP_B_17_SEL_GPIO_B_GPIO17   );
  assign pad_periphs_b_18_pad_mux_sel_pwrgd_gpio18 = (`PAD_MUX_REG_PATH.b_18_mux_sel.q == PAD_MUX_GROUP_B_18_SEL_GPIO_B_GPIO18   );
  assign pad_periphs_b_19_pad_mux_sel_cpi0_hsync   = (`PAD_MUX_REG_PATH.b_19_mux_sel.q == PAD_MUX_GROUP_B_19_SEL_CAM0_CAM_HSYNC  );
  assign pad_periphs_b_19_pad_mux_sel_drdy_gpio19  = (`PAD_MUX_REG_PATH.b_19_mux_sel.q == PAD_MUX_GROUP_B_19_SEL_GPIO_B_GPIO19   );
  assign pad_periphs_b_20_pad_mux_sel_cpi0_dat4    = (`PAD_MUX_REG_PATH.b_20_mux_sel.q == PAD_MUX_GROUP_B_20_SEL_CAM0_CAM_DATA4_I);
  assign pad_periphs_b_20_pad_mux_sel_drdy_gpio20  = (`PAD_MUX_REG_PATH.b_20_mux_sel.q == PAD_MUX_GROUP_B_20_SEL_GPIO_B_GPIO20   );
  assign pad_periphs_b_21_pad_mux_sel_cpi1_vsync   = (`PAD_MUX_REG_PATH.b_21_mux_sel.q == PAD_MUX_GROUP_B_21_SEL_CAM1_CAM_VSYNC  );
  assign pad_periphs_b_21_pad_mux_sel_drdy_gpio21  = (`PAD_MUX_REG_PATH.b_21_mux_sel.q == PAD_MUX_GROUP_B_21_SEL_GPIO_B_GPIO21   );
  assign pad_periphs_b_22_pad_mux_sel_cpi1_dat2    = (`PAD_MUX_REG_PATH.b_22_mux_sel.q == PAD_MUX_GROUP_B_22_SEL_CAM1_CAM_DATA2_I);
  assign pad_periphs_b_22_pad_mux_sel_rst_gpio22   = (`PAD_MUX_REG_PATH.b_22_mux_sel.q == PAD_MUX_GROUP_B_22_SEL_GPIO_B_GPIO22   );
  assign pad_periphs_b_23_pad_mux_sel_cpi1_dat3    = (`PAD_MUX_REG_PATH.b_23_mux_sel.q == PAD_MUX_GROUP_B_23_SEL_CAM1_CAM_DATA3_I);
  assign pad_periphs_b_23_pad_mux_sel_drdy1_gpio23 = (`PAD_MUX_REG_PATH.b_23_mux_sel.q == PAD_MUX_GROUP_B_23_SEL_GPIO_B_GPIO23   );
  assign pad_periphs_b_24_pad_mux_sel_cpi1_dat4    = (`PAD_MUX_REG_PATH.b_24_mux_sel.q == PAD_MUX_GROUP_B_24_SEL_CAM1_CAM_DATA4_I);
  assign pad_periphs_b_24_pad_mux_sel_drdy2_gpio24 = (`PAD_MUX_REG_PATH.b_24_mux_sel.q == PAD_MUX_GROUP_B_24_SEL_GPIO_B_GPIO24   );
  assign pad_periphs_b_25_pad_mux_sel_sdio1_d1     = (`PAD_MUX_REG_PATH.b_25_mux_sel.q == PAD_MUX_GROUP_B_25_SEL_SDIO1_SDIO_DATA1);
  assign pad_periphs_b_25_pad_mux_sel_nfc_gpio25   = (`PAD_MUX_REG_PATH.b_25_mux_sel.q == PAD_MUX_GROUP_B_25_SEL_GPIO_B_GPIO25   );
  assign pad_periphs_b_26_pad_mux_sel_gps1_gpio26  = (`PAD_MUX_REG_PATH.b_26_mux_sel.q == PAD_MUX_GROUP_B_26_SEL_GPIO_B_GPIO26   );
  assign pad_periphs_b_27_pad_mux_sel_gps1_gpio27  = (`PAD_MUX_REG_PATH.b_27_mux_sel.q == PAD_MUX_GROUP_B_27_SEL_GPIO_B_GPIO27   );
  assign pad_periphs_b_28_pad_mux_sel_gps1_gpio28  = (`PAD_MUX_REG_PATH.b_28_mux_sel.q == PAD_MUX_GROUP_B_28_SEL_GPIO_B_GPIO28   );
  assign pad_periphs_b_29_pad_mux_sel_io_gpio29    = (`PAD_MUX_REG_PATH.b_29_mux_sel.q == PAD_MUX_GROUP_B_29_SEL_GPIO_B_GPIO29   );
  assign pad_periphs_b_30_pad_mux_sel_io_gpio30    = (`PAD_MUX_REG_PATH.b_30_mux_sel.q == PAD_MUX_GROUP_B_30_SEL_GPIO_B_GPIO30   );
  assign pad_periphs_b_31_pad_mux_sel_io_gpio31    = (`PAD_MUX_REG_PATH.b_31_mux_sel.q == PAD_MUX_GROUP_B_31_SEL_GPIO_B_GPIO31   );
  assign pad_periphs_b_32_pad_mux_sel_io_gpio32    = (`PAD_MUX_REG_PATH.b_32_mux_sel.q == PAD_MUX_GROUP_B_32_SEL_GPIO_B_GPIO32   );
  assign pad_periphs_b_33_pad_mux_sel_io_gpio33    = (`PAD_MUX_REG_PATH.b_33_mux_sel.q == PAD_MUX_GROUP_B_33_SEL_GPIO_B_GPIO33   );
  assign pad_periphs_b_34_pad_mux_sel_io_gpio34    = (`PAD_MUX_REG_PATH.b_34_mux_sel.q == PAD_MUX_GROUP_B_34_SEL_GPIO_B_GPIO34   );
  assign pad_periphs_b_35_pad_mux_sel_io_gpio35    = (`PAD_MUX_REG_PATH.b_35_mux_sel.q == PAD_MUX_GROUP_B_35_SEL_GPIO_B_GPIO35   );
  assign pad_periphs_b_36_pad_mux_sel_io_gpio36    = (`PAD_MUX_REG_PATH.b_36_mux_sel.q == PAD_MUX_GROUP_B_36_SEL_GPIO_B_GPIO36   );
  assign pad_periphs_b_37_pad_mux_sel_io_gpio37    = (`PAD_MUX_REG_PATH.b_37_mux_sel.q == PAD_MUX_GROUP_B_37_SEL_GPIO_B_GPIO37   );
  assign pad_periphs_b_38_pad_mux_sel_io_gpio38    = (`PAD_MUX_REG_PATH.b_38_mux_sel.q == PAD_MUX_GROUP_B_38_SEL_GPIO_B_GPIO38   );
  assign pad_periphs_b_39_pad_mux_sel_io_gpio39    = (`PAD_MUX_REG_PATH.b_39_mux_sel.q == PAD_MUX_GROUP_B_39_SEL_GPIO_B_GPIO39   );
  assign pad_periphs_b_40_pad_mux_sel_io_gpio40    = (`PAD_MUX_REG_PATH.b_40_mux_sel.q == PAD_MUX_GROUP_B_40_SEL_GPIO_B_GPIO40   );
  assign pad_periphs_b_41_pad_mux_sel_io_gpio41    = (`PAD_MUX_REG_PATH.b_41_mux_sel.q == PAD_MUX_GROUP_B_41_SEL_GPIO_B_GPIO41   );
  assign pad_periphs_b_42_pad_mux_sel_io_gpio42    = (`PAD_MUX_REG_PATH.b_42_mux_sel.q == PAD_MUX_GROUP_B_42_SEL_GPIO_B_GPIO42   );
  assign pad_periphs_b_43_pad_mux_sel_io_gpio43    = (`PAD_MUX_REG_PATH.b_43_mux_sel.q == PAD_MUX_GROUP_B_43_SEL_GPIO_B_GPIO43   );
  assign pad_periphs_b_44_pad_mux_sel_io_gpio44    = (`PAD_MUX_REG_PATH.b_44_mux_sel.q == PAD_MUX_GROUP_B_44_SEL_GPIO_B_GPIO44   );
  assign pad_periphs_b_45_pad_mux_sel_io_gpio45    = (`PAD_MUX_REG_PATH.b_45_mux_sel.q == PAD_MUX_GROUP_B_45_SEL_GPIO_B_GPIO45   );
  assign pad_periphs_b_46_pad_mux_sel_io_gpio46    = (`PAD_MUX_REG_PATH.b_46_mux_sel.q == PAD_MUX_GROUP_B_46_SEL_GPIO_B_GPIO46   );
  assign pad_periphs_b_47_pad_mux_sel_eth_rst      = (`PAD_MUX_REG_PATH.b_47_mux_sel.q == PAD_MUX_GROUP_B_47_SEL_ETH_ETH_RST     );
  assign pad_periphs_b_47_pad_mux_sel_io_gpio47    = (`PAD_MUX_REG_PATH.b_47_mux_sel.q == PAD_MUX_GROUP_B_47_SEL_GPIO_B_GPIO47   );
  assign pad_periphs_b_48_pad_mux_sel_eth_rxck     = (`PAD_MUX_REG_PATH.b_48_mux_sel.q == PAD_MUX_GROUP_B_48_SEL_ETH_ETH_RXCK    );
  assign pad_periphs_b_48_pad_mux_sel_io_gpio48    = (`PAD_MUX_REG_PATH.b_48_mux_sel.q == PAD_MUX_GROUP_B_48_SEL_GPIO_B_GPIO48   );
  assign pad_periphs_b_49_pad_mux_sel_eth_rxctl    = (`PAD_MUX_REG_PATH.b_49_mux_sel.q == PAD_MUX_GROUP_B_49_SEL_ETH_ETH_RXCTL   );
  assign pad_periphs_b_49_pad_mux_sel_io_gpio49    = (`PAD_MUX_REG_PATH.b_49_mux_sel.q == PAD_MUX_GROUP_B_49_SEL_GPIO_B_GPIO49   );
  assign pad_periphs_b_50_pad_mux_sel_eth_rxd0     = (`PAD_MUX_REG_PATH.b_50_mux_sel.q == PAD_MUX_GROUP_B_50_SEL_ETH_ETH_RXD0    );
  assign pad_periphs_b_50_pad_mux_sel_io_gpio50    = (`PAD_MUX_REG_PATH.b_50_mux_sel.q == PAD_MUX_GROUP_B_50_SEL_GPIO_B_GPIO50   );
  assign pad_periphs_b_51_pad_mux_sel_eth_rxd1     = (`PAD_MUX_REG_PATH.b_51_mux_sel.q == PAD_MUX_GROUP_B_51_SEL_ETH_ETH_RXD1    );
  assign pad_periphs_b_51_pad_mux_sel_io_gpio51    = (`PAD_MUX_REG_PATH.b_51_mux_sel.q == PAD_MUX_GROUP_B_51_SEL_GPIO_B_GPIO51   );
  assign pad_periphs_b_52_pad_mux_sel_eth_rxd2     = (`PAD_MUX_REG_PATH.b_52_mux_sel.q == PAD_MUX_GROUP_B_52_SEL_ETH_ETH_RXD2    );
  assign pad_periphs_b_52_pad_mux_sel_io_gpio52    = (`PAD_MUX_REG_PATH.b_52_mux_sel.q == PAD_MUX_GROUP_B_52_SEL_GPIO_B_GPIO52   );
  assign pad_periphs_b_53_pad_mux_sel_eth_rxd3     = (`PAD_MUX_REG_PATH.b_53_mux_sel.q == PAD_MUX_GROUP_B_53_SEL_ETH_ETH_RXD3    );
  assign pad_periphs_b_53_pad_mux_sel_io_gpio53    = (`PAD_MUX_REG_PATH.b_53_mux_sel.q == PAD_MUX_GROUP_B_53_SEL_GPIO_B_GPIO53   );
  assign pad_periphs_b_54_pad_mux_sel_eth_txck     = (`PAD_MUX_REG_PATH.b_54_mux_sel.q == PAD_MUX_GROUP_B_54_SEL_ETH_ETH_TXCK    );
  assign pad_periphs_b_54_pad_mux_sel_io_gpio54    = (`PAD_MUX_REG_PATH.b_54_mux_sel.q == PAD_MUX_GROUP_B_54_SEL_GPIO_B_GPIO54   );
  assign pad_periphs_b_55_pad_mux_sel_eth_txctl    = (`PAD_MUX_REG_PATH.b_55_mux_sel.q == PAD_MUX_GROUP_B_55_SEL_ETH_ETH_TXCTL   );
  assign pad_periphs_b_55_pad_mux_sel_io_gpio55    = (`PAD_MUX_REG_PATH.b_55_mux_sel.q == PAD_MUX_GROUP_B_55_SEL_GPIO_B_GPIO55   );
  assign pad_periphs_b_56_pad_mux_sel_eth_txd0     = (`PAD_MUX_REG_PATH.b_56_mux_sel.q == PAD_MUX_GROUP_B_56_SEL_ETH_ETH_TXD0    );
  assign pad_periphs_b_56_pad_mux_sel_io_gpio56    = (`PAD_MUX_REG_PATH.b_56_mux_sel.q == PAD_MUX_GROUP_B_56_SEL_GPIO_B_GPIO56   );
  assign pad_periphs_b_57_pad_mux_sel_eth_txd1     = (`PAD_MUX_REG_PATH.b_57_mux_sel.q == PAD_MUX_GROUP_B_57_SEL_ETH_ETH_TXD1    );
  assign pad_periphs_b_57_pad_mux_sel_io_gpio57    = (`PAD_MUX_REG_PATH.b_57_mux_sel.q == PAD_MUX_GROUP_B_57_SEL_GPIO_B_GPIO57   );
  assign pad_periphs_b_58_pad_mux_sel_eth_txd2     = (`PAD_MUX_REG_PATH.b_58_mux_sel.q == PAD_MUX_GROUP_B_58_SEL_ETH_ETH_TXD2    );
  assign pad_periphs_b_58_pad_mux_sel_io_gpio58    = (`PAD_MUX_REG_PATH.b_58_mux_sel.q == PAD_MUX_GROUP_B_58_SEL_GPIO_B_GPIO58   );
  assign pad_periphs_b_59_pad_mux_sel_eth_txd3     = (`PAD_MUX_REG_PATH.b_59_mux_sel.q == PAD_MUX_GROUP_B_59_SEL_ETH_ETH_TXD3    );
  assign pad_periphs_b_59_pad_mux_sel_io_gpio59    = (`PAD_MUX_REG_PATH.b_59_mux_sel.q == PAD_MUX_GROUP_B_59_SEL_GPIO_B_GPIO59   );
  assign pad_periphs_b_60_pad_mux_sel_eth_mdio     = (`PAD_MUX_REG_PATH.b_60_mux_sel.q == PAD_MUX_GROUP_B_60_SEL_ETH_ETH_MDIO    );
  assign pad_periphs_b_60_pad_mux_sel_io_gpio60    = (`PAD_MUX_REG_PATH.b_60_mux_sel.q == PAD_MUX_GROUP_B_60_SEL_GPIO_B_GPIO60   );
  assign pad_periphs_b_61_pad_mux_sel_eth_mdc      = (`PAD_MUX_REG_PATH.b_61_mux_sel.q == PAD_MUX_GROUP_B_61_SEL_ETH_ETH_MDC     );
  assign pad_periphs_b_61_pad_mux_sel_io_gpio61    = (`PAD_MUX_REG_PATH.b_61_mux_sel.q == PAD_MUX_GROUP_B_61_SEL_GPIO_B_GPIO61   );
  assign pad_periphs_b_62_pad_mux_sel_eth_intb     = (`PAD_MUX_REG_PATH.b_62_mux_sel.q == PAD_MUX_GROUP_B_62_SEL_ETH_ETH_INTB    );
  assign pad_periphs_b_62_pad_mux_sel_io_gpio62    = (`PAD_MUX_REG_PATH.b_62_mux_sel.q == PAD_MUX_GROUP_B_62_SEL_GPIO_B_GPIO62   );
  //**************************************************
  // VIP MUX SEL END
  //**************************************************

  //**************************************************
  // VIP MUXING BEGINNING
  //**************************************************
  tranif1 a_00_pad_i2c0_scl    (pad_periphs_a_00_pad, pad_periphs_a_00_pad_i2c0_scl  , pad_periphs_a_00_pad_mux_sel_i2c0_scl   );
  tranif1 a_01_pad_i2c0_sda    (pad_periphs_a_01_pad, pad_periphs_a_01_pad_i2c0_sda  , pad_periphs_a_01_pad_mux_sel_i2c0_sda   );
  tranif1 a_02_pad_spi0_sck    (pad_periphs_a_02_pad, pad_periphs_a_02_pad_spi0_sck  , pad_periphs_a_02_pad_mux_sel_spi0_sck   );
  tranif1 a_03_pad_spi0_cs     (pad_periphs_a_03_pad, pad_periphs_a_03_pad_spi0_cs   , pad_periphs_a_03_pad_mux_sel_spi0_cs    );
  tranif1 a_04_pad_spi0_miso   (pad_periphs_a_04_pad, pad_periphs_a_04_pad_spi0_miso , pad_periphs_a_04_pad_mux_sel_spi0_miso  );
  tranif1 a_05_pad_spi0_mosi   (pad_periphs_a_05_pad, pad_periphs_a_05_pad_spi0_mosi , pad_periphs_a_05_pad_mux_sel_spi0_mosi  );
  tranif1 a_06_pad_spi1_sck    (pad_periphs_a_06_pad, pad_periphs_a_06_pad_spi1_sck  , pad_periphs_a_06_pad_mux_sel_spi1_sck   );
  tranif1 a_07_pad_spi1_cs     (pad_periphs_a_07_pad, pad_periphs_a_07_pad_spi1_cs   , pad_periphs_a_07_pad_mux_sel_spi1_cs    );
  tranif1 a_08_pad_spi1_miso   (pad_periphs_a_08_pad, pad_periphs_a_08_pad_spi1_miso , pad_periphs_a_08_pad_mux_sel_spi1_miso  );
  tranif1 a_09_pad_spi1_mosi   (pad_periphs_a_09_pad, pad_periphs_a_09_pad_spi1_mosi , pad_periphs_a_09_pad_mux_sel_spi1_mosi  );
  tranif1 a_10_pad_spi2_sck    (pad_periphs_a_10_pad, pad_periphs_a_10_pad_spi2_sck  , pad_periphs_a_10_pad_mux_sel_spi2_sck   );
  tranif1 a_11_pad_spi2_cs     (pad_periphs_a_11_pad, pad_periphs_a_11_pad_spi2_cs   , pad_periphs_a_11_pad_mux_sel_spi2_cs    );
  tranif1 a_12_pad_spi2_miso   (pad_periphs_a_12_pad, pad_periphs_a_12_pad_spi2_miso , pad_periphs_a_12_pad_mux_sel_spi2_miso  );
  tranif1 a_13_pad_spi2_mosi   (pad_periphs_a_13_pad, pad_periphs_a_13_pad_spi2_mosi , pad_periphs_a_13_pad_mux_sel_spi2_mosi  );
  tranif1 a_14_pad_spi3_sck    (pad_periphs_a_14_pad, pad_periphs_a_14_pad_spi3_sck  , pad_periphs_a_14_pad_mux_sel_spi3_sck   );
  tranif1 a_15_pad_spi3_cs     (pad_periphs_a_15_pad, pad_periphs_a_15_pad_spi3_cs   , pad_periphs_a_15_pad_mux_sel_spi3_cs    );
  tranif1 a_16_pad_spi3_miso   (pad_periphs_a_16_pad, pad_periphs_a_16_pad_spi3_miso , pad_periphs_a_16_pad_mux_sel_spi3_miso  );
  tranif1 a_17_pad_spi3_mosi   (pad_periphs_a_17_pad, pad_periphs_a_17_pad_spi3_mosi , pad_periphs_a_17_pad_mux_sel_spi3_mosi  );
  tranif1 a_18_pad_sdio0_d1    (pad_periphs_a_18_pad, pad_periphs_a_18_pad_sdio0_d1  , pad_periphs_a_18_pad_mux_sel_sdio0_d1   );
  tranif1 a_19_pad_sdio0_d2    (pad_periphs_a_19_pad, pad_periphs_a_19_pad_sdio0_d2  , pad_periphs_a_19_pad_mux_sel_sdio0_d2   );
  tranif1 a_20_pad_sdio0_d3    (pad_periphs_a_20_pad, pad_periphs_a_20_pad_sdio0_d3  , pad_periphs_a_20_pad_mux_sel_sdio0_d3   );
  tranif1 a_21_pad_sdio0_d4    (pad_periphs_a_21_pad, pad_periphs_a_21_pad_sdio0_d4  , pad_periphs_a_21_pad_mux_sel_sdio0_d4   );
  tranif1 a_22_pad_sdio0_clk   (pad_periphs_a_22_pad, pad_periphs_a_22_pad_sdio0_clk , pad_periphs_a_22_pad_mux_sel_sdio0_clk  );
  tranif1 a_23_pad_sdio0_cmd   (pad_periphs_a_23_pad, pad_periphs_a_23_pad_sdio0_cmd , pad_periphs_a_23_pad_mux_sel_sdio0_cmd  );
  tranif1 a_24_pad_uart0_tx    (pad_periphs_a_24_pad, pad_periphs_a_24_pad_uart0_tx  , pad_periphs_a_24_pad_mux_sel_uart0_tx   );
  tranif1 a_25_pad_uart0_rx    (pad_periphs_a_25_pad, pad_periphs_a_25_pad_uart0_rx  , pad_periphs_a_25_pad_mux_sel_uart0_rx   );
  tranif1 a_26_pad_i2c1_scl    (pad_periphs_a_26_pad, pad_periphs_a_26_pad_i2c1_scl  , pad_periphs_a_26_pad_mux_sel_i2c1_scl   );
  tranif1 a_27_pad_i2c1_sda    (pad_periphs_a_27_pad, pad_periphs_a_27_pad_i2c1_sda  , pad_periphs_a_27_pad_mux_sel_i2c1_sda   );
  tranif1 a_28_pad_usart0_tx   (pad_periphs_a_28_pad, pad_periphs_a_28_pad_usart0_tx , pad_periphs_a_28_pad_mux_sel_usart0_tx  );
  tranif1 a_29_pad_usart0_rx   (pad_periphs_a_29_pad, pad_periphs_a_29_pad_usart0_rx , pad_periphs_a_29_pad_mux_sel_usart0_rx  );
  tranif1 a_30_pad_usart0_rts  (pad_periphs_a_30_pad, pad_periphs_a_30_pad_usart0_rts, pad_periphs_a_30_pad_mux_sel_usart0_rts );
  tranif1 a_31_pad_usart0_cts  (pad_periphs_a_31_pad, pad_periphs_a_31_pad_usart0_cts, pad_periphs_a_31_pad_mux_sel_usart0_cts );
  tranif1 a_32_pad_spi4_sck    (pad_periphs_a_32_pad, pad_periphs_a_32_pad_spi4_sck  , pad_periphs_a_32_pad_mux_sel_spi4_sck   );
  tranif1 a_33_pad_spi4_cs     (pad_periphs_a_33_pad, pad_periphs_a_33_pad_spi4_cs   , pad_periphs_a_33_pad_mux_sel_spi4_cs    );
  tranif1 a_34_pad_spi4_miso   (pad_periphs_a_34_pad, pad_periphs_a_34_pad_spi4_miso , pad_periphs_a_34_pad_mux_sel_spi4_miso  );
  tranif1 a_35_pad_spi4_mosi   (pad_periphs_a_35_pad, pad_periphs_a_35_pad_spi4_mosi , pad_periphs_a_35_pad_mux_sel_spi4_mosi  );
  tranif1 a_36_pad_i2c2_scl    (pad_periphs_a_36_pad, pad_periphs_a_36_pad_i2c2_scl  , pad_periphs_a_36_pad_mux_sel_i2c2_scl   );
  tranif1 a_37_pad_i2c2_sda    (pad_periphs_a_37_pad, pad_periphs_a_37_pad_i2c2_sda  , pad_periphs_a_37_pad_mux_sel_i2c2_sda   );
  tranif1 a_38_pad_pwm_out0    (pad_periphs_a_38_pad, pad_periphs_a_38_pad_pwm_out0  , pad_periphs_a_38_pad_mux_sel_pwm_out0   );
  tranif1 a_39_pad_pwm_out1    (pad_periphs_a_39_pad, pad_periphs_a_39_pad_pwm_out1  , pad_periphs_a_39_pad_mux_sel_pwm_out1   );
  tranif1 a_40_pad_pwm_out2    (pad_periphs_a_40_pad, pad_periphs_a_40_pad_pwm_out2  , pad_periphs_a_40_pad_mux_sel_pwm_out2   );
  tranif1 a_41_pad_pwm_out3    (pad_periphs_a_41_pad, pad_periphs_a_41_pad_pwm_out3  , pad_periphs_a_41_pad_mux_sel_pwm_out3   );
  tranif1 a_42_pad_cpi0_clk    (pad_periphs_a_42_pad, pad_periphs_a_42_pad_cpi0_clk  , pad_periphs_a_42_pad_mux_sel_cpi0_clk   );
  tranif1 a_42_pad_i2c3_scl    (pad_periphs_a_42_pad, pad_periphs_a_42_pad_i2c3_scl  , pad_periphs_a_42_pad_mux_sel_i2c3_scl   );
  tranif1 a_43_pad_cpi0_vsync  (pad_periphs_a_43_pad, pad_periphs_a_43_pad_cpi0_vsync, pad_periphs_a_43_pad_mux_sel_cpi0_vsync );
  tranif1 a_43_pad_i2c3_sda    (pad_periphs_a_43_pad, pad_periphs_a_43_pad_i2c3_sda  , pad_periphs_a_43_pad_mux_sel_i2c3_sda   );
  tranif1 a_44_pad_cpi0_dat0   (pad_periphs_a_44_pad, pad_periphs_a_44_pad_cpi0_dat0 , pad_periphs_a_44_pad_mux_sel_cpi0_dat0  );
  tranif1 a_44_pad_spi5_sck    (pad_periphs_a_44_pad, pad_periphs_a_44_pad_spi5_sck  , pad_periphs_a_44_pad_mux_sel_spi5_sck   );
  tranif1 a_45_pad_cpi0_dat1   (pad_periphs_a_45_pad, pad_periphs_a_45_pad_cpi0_dat1 , pad_periphs_a_45_pad_mux_sel_cpi0_dat1  );
  tranif1 a_45_pad_spi5_cs     (pad_periphs_a_45_pad, pad_periphs_a_45_pad_spi5_cs   , pad_periphs_a_45_pad_mux_sel_spi5_cs    );
  tranif1 a_46_pad_cpi0_dat2   (pad_periphs_a_46_pad, pad_periphs_a_46_pad_cpi0_dat2 , pad_periphs_a_46_pad_mux_sel_cpi0_dat2  );
  tranif1 a_46_pad_spi5_miso   (pad_periphs_a_46_pad, pad_periphs_a_46_pad_spi5_miso , pad_periphs_a_46_pad_mux_sel_spi5_miso  );
  tranif1 a_47_pad_cpi0_dat3   (pad_periphs_a_47_pad, pad_periphs_a_47_pad_cpi0_dat3 , pad_periphs_a_47_pad_mux_sel_cpi0_dat3  );
  tranif1 a_47_pad_spi5_mosi   (pad_periphs_a_47_pad, pad_periphs_a_47_pad_spi5_mosi , pad_periphs_a_47_pad_mux_sel_spi5_mosi  );
  tranif1 a_48_pad_cpi0_dat5   (pad_periphs_a_48_pad, pad_periphs_a_48_pad_cpi0_dat5 , pad_periphs_a_48_pad_mux_sel_cpi0_dat5  );
  tranif1 a_48_pad_spi6_clk    (pad_periphs_a_48_pad, pad_periphs_a_48_pad_spi6_clk  , pad_periphs_a_48_pad_mux_sel_spi6_clk   );
  tranif1 a_49_pad_cpi0_dat6   (pad_periphs_a_49_pad, pad_periphs_a_49_pad_cpi0_dat6 , pad_periphs_a_49_pad_mux_sel_cpi0_dat6  );
  tranif1 a_49_pad_spi6_cs     (pad_periphs_a_49_pad, pad_periphs_a_49_pad_spi6_cs   , pad_periphs_a_49_pad_mux_sel_spi6_cs    );
  tranif1 a_50_pad_cpi0_dat7   (pad_periphs_a_50_pad, pad_periphs_a_50_pad_cpi0_dat7 , pad_periphs_a_50_pad_mux_sel_cpi0_dat7  );
  tranif1 a_50_pad_spi6_miso   (pad_periphs_a_50_pad, pad_periphs_a_50_pad_spi6_miso , pad_periphs_a_50_pad_mux_sel_spi6_miso  );
  tranif1 a_51_pad_cpi1_clk    (pad_periphs_a_51_pad, pad_periphs_a_51_pad_cpi1_clk  , pad_periphs_a_51_pad_mux_sel_cpi1_clk   );
  tranif1 a_51_pad_spi6_mosi   (pad_periphs_a_51_pad, pad_periphs_a_51_pad_spi6_mosi , pad_periphs_a_51_pad_mux_sel_spi6_mosi  );
  tranif1 a_52_pad_cpi1_hsync  (pad_periphs_a_52_pad, pad_periphs_a_52_pad_cpi1_hsync, pad_periphs_a_52_pad_mux_sel_cpi1_hsync );
  tranif1 a_52_pad_spi7_sck    (pad_periphs_a_52_pad, pad_periphs_a_52_pad_spi7_sck  , pad_periphs_a_52_pad_mux_sel_spi7_sck   );
  tranif1 a_53_pad_cpi1_dat0   (pad_periphs_a_53_pad, pad_periphs_a_53_pad_cpi1_dat0 , pad_periphs_a_53_pad_mux_sel_cpi1_dat0  );
  tranif1 a_53_pad_spi7_miso   (pad_periphs_a_53_pad, pad_periphs_a_53_pad_spi7_miso , pad_periphs_a_53_pad_mux_sel_spi7_miso  );
  tranif1 a_54_pad_cpi1_dat1   (pad_periphs_a_54_pad, pad_periphs_a_54_pad_cpi1_dat1 , pad_periphs_a_54_pad_mux_sel_cpi1_dat1  );
  tranif1 a_54_pad_spi7_mosi   (pad_periphs_a_54_pad, pad_periphs_a_54_pad_spi7_mosi , pad_periphs_a_54_pad_mux_sel_spi7_mosi  );
  tranif1 a_55_pad_cpi1_dat5   (pad_periphs_a_55_pad, pad_periphs_a_55_pad_cpi1_dat5 , pad_periphs_a_55_pad_mux_sel_cpi1_dat5  );
  tranif1 a_55_pad_spi7_cs0    (pad_periphs_a_55_pad, pad_periphs_a_55_pad_spi7_cs0  , pad_periphs_a_55_pad_mux_sel_spi7_cs0   );
  tranif1 a_56_pad_cpi1_dat6   (pad_periphs_a_56_pad, pad_periphs_a_56_pad_cpi1_dat6 , pad_periphs_a_56_pad_mux_sel_cpi1_dat6  );
  tranif1 a_56_pad_spi7_cs1    (pad_periphs_a_56_pad, pad_periphs_a_56_pad_spi7_cs1  , pad_periphs_a_56_pad_mux_sel_spi7_cs1   );
  tranif1 a_57_pad_cpi1_dat7   (pad_periphs_a_57_pad, pad_periphs_a_57_pad_cpi1_dat7 , pad_periphs_a_57_pad_mux_sel_cpi1_dat7  );
  tranif1 a_57_pad_i2c4_scl    (pad_periphs_a_57_pad, pad_periphs_a_57_pad_i2c4_scl  , pad_periphs_a_57_pad_mux_sel_i2c4_scl   );
  tranif1 a_58_pad_sdio1_d0    (pad_periphs_a_58_pad, pad_periphs_a_58_pad_sdio1_d0  , pad_periphs_a_58_pad_mux_sel_sdio1_d0   );
  tranif1 a_58_pad_i2c4_sda    (pad_periphs_a_58_pad, pad_periphs_a_58_pad_i2c4_sda  , pad_periphs_a_58_pad_mux_sel_i2c4_sda   );
  tranif1 a_59_pad_sdio1_d2    (pad_periphs_a_59_pad, pad_periphs_a_59_pad_sdio1_d2  , pad_periphs_a_59_pad_mux_sel_sdio1_d2   );
  tranif1 a_59_pad_uart1_tx    (pad_periphs_a_59_pad, pad_periphs_a_59_pad_uart1_tx  , pad_periphs_a_59_pad_mux_sel_uart1_tx   );
  tranif1 a_60_pad_sdio1_d3    (pad_periphs_a_60_pad, pad_periphs_a_60_pad_sdio1_d3  , pad_periphs_a_60_pad_mux_sel_sdio1_d3   );
  tranif1 a_60_pad_uart1_rx    (pad_periphs_a_60_pad, pad_periphs_a_60_pad_uart1_rx  , pad_periphs_a_60_pad_mux_sel_uart1_rx   );
  tranif1 a_61_pad_sdio1_clk   (pad_periphs_a_61_pad, pad_periphs_a_61_pad_sdio1_clk , pad_periphs_a_61_pad_mux_sel_sdio1_clk  );
  tranif1 a_61_pad_usart1_tx   (pad_periphs_a_61_pad, pad_periphs_a_61_pad_usart1_tx , pad_periphs_a_61_pad_mux_sel_usart1_tx  );
  tranif1 a_62_pad_sdio1_cmd   (pad_periphs_a_62_pad, pad_periphs_a_62_pad_sdio1_cmd , pad_periphs_a_62_pad_mux_sel_sdio1_cmd  );
  tranif1 a_62_pad_usart1_rx   (pad_periphs_a_62_pad, pad_periphs_a_62_pad_usart1_rx , pad_periphs_a_62_pad_mux_sel_usart1_rx  );
  tranif1 a_63_pad_usart1_rts  (pad_periphs_a_63_pad, pad_periphs_a_63_pad_usart1_rts, pad_periphs_a_63_pad_mux_sel_usart1_rts );
  tranif1 a_64_pad_usart1_cts  (pad_periphs_a_64_pad, pad_periphs_a_64_pad_usart1_cts, pad_periphs_a_64_pad_mux_sel_usart1_cts );
  tranif1 a_65_pad_uart2_tx    (pad_periphs_a_65_pad, pad_periphs_a_65_pad_uart2_tx  , pad_periphs_a_65_pad_mux_sel_uart2_tx   );
  tranif1 a_66_pad_uart2_rx    (pad_periphs_a_66_pad, pad_periphs_a_66_pad_uart2_rx  , pad_periphs_a_66_pad_mux_sel_uart2_rx   );
  tranif1 a_67_pad_i2c5_scl    (pad_periphs_a_67_pad, pad_periphs_a_67_pad_i2c5_scl  , pad_periphs_a_67_pad_mux_sel_i2c5_scl   );
  tranif1 a_68_pad_i2c5_sda    (pad_periphs_a_68_pad, pad_periphs_a_68_pad_i2c5_sda  , pad_periphs_a_68_pad_mux_sel_i2c5_sda   );
  tranif1 a_69_pad_usart2_tx   (pad_periphs_a_69_pad, pad_periphs_a_69_pad_usart2_tx , pad_periphs_a_69_pad_mux_sel_usart2_tx  );
  tranif1 a_70_pad_usart2_rx   (pad_periphs_a_70_pad, pad_periphs_a_70_pad_usart2_rx , pad_periphs_a_70_pad_mux_sel_usart2_rx  );
  tranif1 a_71_pad_usart2_rts  (pad_periphs_a_71_pad, pad_periphs_a_71_pad_usart2_rts, pad_periphs_a_71_pad_mux_sel_usart2_rts );
  tranif1 a_72_pad_usart2_cts  (pad_periphs_a_72_pad, pad_periphs_a_72_pad_usart2_cts, pad_periphs_a_72_pad_mux_sel_usart2_cts );
  tranif1 a_73_pad_usart3_tx   (pad_periphs_a_73_pad, pad_periphs_a_73_pad_usart3_tx , pad_periphs_a_73_pad_mux_sel_usart3_tx  );
  tranif1 a_74_pad_usart3_rx   (pad_periphs_a_74_pad, pad_periphs_a_74_pad_usart3_rx , pad_periphs_a_74_pad_mux_sel_usart3_rx  );
  tranif1 a_75_pad_usart3_rts  (pad_periphs_a_75_pad, pad_periphs_a_75_pad_usart3_rts, pad_periphs_a_75_pad_mux_sel_usart3_rts );
  tranif1 a_76_pad_usart3_cts  (pad_periphs_a_76_pad, pad_periphs_a_76_pad_usart3_cts, pad_periphs_a_76_pad_mux_sel_usart3_cts );
  tranif1 a_77_pad_pwm_out4    (pad_periphs_a_77_pad, pad_periphs_a_77_pad_pwm_out4  , pad_periphs_a_77_pad_mux_sel_pwm_out4   );
  tranif1 a_78_pad_pwm_out5    (pad_periphs_a_78_pad, pad_periphs_a_78_pad_pwm_out5  , pad_periphs_a_78_pad_mux_sel_pwm_out5   );
  tranif1 a_79_pad_pwm_out6    (pad_periphs_a_79_pad, pad_periphs_a_79_pad_pwm_out6  , pad_periphs_a_79_pad_mux_sel_pwm_out6   );
  tranif1 a_80_pad_pwm_out7    (pad_periphs_a_80_pad, pad_periphs_a_80_pad_pwm_out7  , pad_periphs_a_80_pad_mux_sel_pwm_out7   );
  tranif1 a_81_pad_spi8_sck    (pad_periphs_a_81_pad, pad_periphs_a_81_pad_spi8_sck  , pad_periphs_a_81_pad_mux_sel_spi8_sck   );
  tranif1 a_81_pad_can0_tx     (pad_periphs_a_81_pad, pad_periphs_a_81_pad_can0_tx   , pad_periphs_a_81_pad_mux_sel_can0_tx    );
  tranif1 a_82_pad_spi8_cs     (pad_periphs_a_82_pad, pad_periphs_a_82_pad_spi8_cs   , pad_periphs_a_82_pad_mux_sel_spi8_cs    );
  tranif1 a_82_pad_can0_rx     (pad_periphs_a_82_pad, pad_periphs_a_82_pad_can0_rx   , pad_periphs_a_82_pad_mux_sel_can0_rx    );
  tranif1 a_83_pad_spi8_miso   (pad_periphs_a_83_pad, pad_periphs_a_83_pad_spi8_miso , pad_periphs_a_83_pad_mux_sel_spi8_miso  );
  tranif1 a_83_pad_can1_tx     (pad_periphs_a_83_pad, pad_periphs_a_83_pad_can1_tx   , pad_periphs_a_83_pad_mux_sel_can1_tx    );
  tranif1 a_84_pad_spi8_mosi   (pad_periphs_a_84_pad, pad_periphs_a_84_pad_spi8_mosi , pad_periphs_a_84_pad_mux_sel_spi8_mosi  );
  tranif1 a_84_pad_can1_rx     (pad_periphs_a_84_pad, pad_periphs_a_84_pad_can1_rx   , pad_periphs_a_84_pad_mux_sel_can1_rx    );
  tranif1 a_85_pad_spi9_sck    (pad_periphs_a_85_pad, pad_periphs_a_85_pad_spi9_sck  , pad_periphs_a_85_pad_mux_sel_spi9_sck   );
  tranif1 a_86_pad_spi9_cs     (pad_periphs_a_86_pad, pad_periphs_a_86_pad_spi9_cs   , pad_periphs_a_86_pad_mux_sel_spi9_cs    );
  tranif1 a_87_pad_spi9_miso   (pad_periphs_a_87_pad, pad_periphs_a_87_pad_spi9_miso , pad_periphs_a_87_pad_mux_sel_spi9_miso  );
  tranif1 a_88_pad_spi9_mosi   (pad_periphs_a_88_pad, pad_periphs_a_88_pad_spi9_mosi , pad_periphs_a_88_pad_mux_sel_spi9_mosi  );
  tranif1 a_89_pad_spi10_sck   (pad_periphs_a_89_pad, pad_periphs_a_89_pad_spi10_sck , pad_periphs_a_89_pad_mux_sel_spi10_sck  );
  tranif1 a_90_pad_spi10_cs    (pad_periphs_a_90_pad, pad_periphs_a_90_pad_spi10_cs  , pad_periphs_a_90_pad_mux_sel_spi10_cs   );
  tranif1 a_91_pad_spi10_miso  (pad_periphs_a_91_pad, pad_periphs_a_91_pad_spi10_miso, pad_periphs_a_91_pad_mux_sel_spi10_miso );
  tranif1 a_92_pad_spi10_mosi  (pad_periphs_a_92_pad, pad_periphs_a_92_pad_spi10_mosi, pad_periphs_a_92_pad_mux_sel_spi10_mosi );

  tranif1 b_00_pad_drdy_gpio0  (pad_periphs_b_00_pad, pad_periphs_b_00_pad_drdy_gpio0  , pad_periphs_b_00_pad_mux_sel_drdy_gpio0   );
  tranif1 b_01_pad_drdy_gpio1  (pad_periphs_b_01_pad, pad_periphs_b_01_pad_drdy_gpio1  , pad_periphs_b_01_pad_mux_sel_drdy_gpio1   );
  tranif1 b_02_pad_drdy_gpio2  (pad_periphs_b_02_pad, pad_periphs_b_02_pad_drdy_gpio2  , pad_periphs_b_02_pad_mux_sel_drdy_gpio2   );
  tranif1 b_03_pad_sync_gpio3  (pad_periphs_b_03_pad, pad_periphs_b_03_pad_sync_gpio3  , pad_periphs_b_03_pad_mux_sel_sync_gpio3   );
  tranif1 b_04_pad_adio_gpio4  (pad_periphs_b_04_pad, pad_periphs_b_04_pad_adio_gpio4  , pad_periphs_b_04_pad_mux_sel_adio_gpio4   );
  tranif1 b_05_pad_adio_gpio5  (pad_periphs_b_05_pad, pad_periphs_b_05_pad_adio_gpio5  , pad_periphs_b_05_pad_mux_sel_adio_gpio5   );
  tranif1 b_06_pad_adio_gpio6  (pad_periphs_b_06_pad, pad_periphs_b_06_pad_adio_gpio6  , pad_periphs_b_06_pad_mux_sel_adio_gpio6   );
  tranif1 b_07_pad_adio_gpio7  (pad_periphs_b_07_pad, pad_periphs_b_07_pad_adio_gpio7  , pad_periphs_b_07_pad_mux_sel_adio_gpio7   );
  tranif1 b_08_pad_led_r_gpio8 (pad_periphs_b_08_pad, pad_periphs_b_08_pad_led_r_gpio8 , pad_periphs_b_08_pad_mux_sel_led_r_gpio8  );
  tranif1 b_09_pad_led_g_gpio9 (pad_periphs_b_09_pad, pad_periphs_b_09_pad_led_g_gpio9 , pad_periphs_b_09_pad_mux_sel_led_g_gpio9  );
  tranif1 b_10_pad_led_b_gpio10(pad_periphs_b_10_pad, pad_periphs_b_10_pad_led_b_gpio10, pad_periphs_b_10_pad_mux_sel_led_b_gpio10 );
  tranif1 b_11_pad_gpio11      (pad_periphs_b_11_pad, pad_periphs_b_11_pad_gpio11      , pad_periphs_b_11_pad_mux_sel_gpio11       );
  tranif1 b_12_pad_gpio12      (pad_periphs_b_12_pad, pad_periphs_b_12_pad_gpio12      , pad_periphs_b_12_pad_mux_sel_gpio12       );
  tranif1 b_13_pad_gpio13      (pad_periphs_b_13_pad, pad_periphs_b_13_pad_gpio13      , pad_periphs_b_13_pad_mux_sel_gpio13       );
  tranif1 b_14_pad_gpio14      (pad_periphs_b_14_pad, pad_periphs_b_14_pad_gpio14      , pad_periphs_b_14_pad_mux_sel_gpio14       );
  tranif1 b_15_pad_adc0_gpio15 (pad_periphs_b_15_pad, pad_periphs_b_15_pad_adc0_gpio15 , pad_periphs_b_15_pad_mux_sel_adc0_gpio15  );
  tranif1 b_16_pad_adc0_gpio16 (pad_periphs_b_16_pad, pad_periphs_b_16_pad_adc0_gpio16 , pad_periphs_b_16_pad_mux_sel_adc0_gpio16  );
  tranif1 b_17_pad_adc0_gpio17 (pad_periphs_b_17_pad, pad_periphs_b_17_pad_adc0_gpio17 , pad_periphs_b_17_pad_mux_sel_adc0_gpio17  );
  tranif1 b_18_pad_pwrgd_gpio18(pad_periphs_b_18_pad, pad_periphs_b_18_pad_pwrgd_gpio18, pad_periphs_b_18_pad_mux_sel_pwrgd_gpio18 );
  tranif1 b_19_pad_cpi0_hsync  (pad_periphs_b_19_pad, pad_periphs_b_19_pad_cpi0_hsync  , pad_periphs_b_19_pad_mux_sel_cpi0_hsync   );
  tranif1 b_19_pad_drdy_gpio19 (pad_periphs_b_19_pad, pad_periphs_b_19_pad_drdy_gpio19 , pad_periphs_b_19_pad_mux_sel_drdy_gpio19  );
  tranif1 b_20_pad_cpi0_dat4   (pad_periphs_b_20_pad, pad_periphs_b_20_pad_cpi0_dat4   , pad_periphs_b_20_pad_mux_sel_cpi0_dat4    );
  tranif1 b_20_pad_drdy_gpio20 (pad_periphs_b_20_pad, pad_periphs_b_20_pad_drdy_gpio20 , pad_periphs_b_20_pad_mux_sel_drdy_gpio20  );
  tranif1 b_21_pad_cpi1_vsync  (pad_periphs_b_21_pad, pad_periphs_b_21_pad_cpi1_vsync  , pad_periphs_b_21_pad_mux_sel_cpi1_vsync   );
  tranif1 b_21_pad_drdy_gpio21 (pad_periphs_b_21_pad, pad_periphs_b_21_pad_drdy_gpio21 , pad_periphs_b_21_pad_mux_sel_drdy_gpio21  );
  tranif1 b_22_pad_cpi1_dat2   (pad_periphs_b_22_pad, pad_periphs_b_22_pad_cpi1_dat2   , pad_periphs_b_22_pad_mux_sel_cpi1_dat2    );
  tranif1 b_22_pad_rst_gpio22  (pad_periphs_b_22_pad, pad_periphs_b_22_pad_rst_gpio22  , pad_periphs_b_22_pad_mux_sel_rst_gpio22   );
  tranif1 b_23_pad_cpi1_dat3   (pad_periphs_b_23_pad, pad_periphs_b_23_pad_cpi1_dat3   , pad_periphs_b_23_pad_mux_sel_cpi1_dat3    );
  tranif1 b_23_pad_drdy1_gpio23(pad_periphs_b_23_pad, pad_periphs_b_23_pad_drdy1_gpio23, pad_periphs_b_23_pad_mux_sel_drdy1_gpio23 );
  tranif1 b_24_pad_cpi1_dat4   (pad_periphs_b_24_pad, pad_periphs_b_24_pad_cpi1_dat4   , pad_periphs_b_24_pad_mux_sel_cpi1_dat4    );
  tranif1 b_24_pad_drdy2_gpio24(pad_periphs_b_24_pad, pad_periphs_b_24_pad_drdy2_gpio24, pad_periphs_b_24_pad_mux_sel_drdy2_gpio24 );
  tranif1 b_25_pad_sdio1_d1    (pad_periphs_b_25_pad, pad_periphs_b_25_pad_sdio1_d1    , pad_periphs_b_25_pad_mux_sel_sdio1_d1     );
  tranif1 b_25_pad_nfc_gpio25  (pad_periphs_b_25_pad, pad_periphs_b_25_pad_nfc_gpio25  , pad_periphs_b_25_pad_mux_sel_nfc_gpio25   );
  tranif1 b_26_pad_gps1_gpio26 (pad_periphs_b_26_pad, pad_periphs_b_26_pad_gps1_gpio26 , pad_periphs_b_26_pad_mux_sel_gps1_gpio26  );
  tranif1 b_27_pad_gps1_gpio27 (pad_periphs_b_27_pad, pad_periphs_b_27_pad_gps1_gpio27 , pad_periphs_b_27_pad_mux_sel_gps1_gpio27  );
  tranif1 b_28_pad_gps1_gpio28 (pad_periphs_b_28_pad, pad_periphs_b_28_pad_gps1_gpio28 , pad_periphs_b_28_pad_mux_sel_gps1_gpio28  );
  tranif1 b_29_pad_io_gpio29   (pad_periphs_b_29_pad, pad_periphs_b_29_pad_io_gpio29   , pad_periphs_b_29_pad_mux_sel_io_gpio29    );
  tranif1 b_30_pad_io_gpio30   (pad_periphs_b_30_pad, pad_periphs_b_30_pad_io_gpio30   , pad_periphs_b_30_pad_mux_sel_io_gpio30    );
  tranif1 b_31_pad_io_gpio31   (pad_periphs_b_31_pad, pad_periphs_b_31_pad_io_gpio31   , pad_periphs_b_31_pad_mux_sel_io_gpio31    );
  tranif1 b_32_pad_io_gpio32   (pad_periphs_b_32_pad, pad_periphs_b_32_pad_io_gpio32   , pad_periphs_b_32_pad_mux_sel_io_gpio32    );
  tranif1 b_33_pad_io_gpio33   (pad_periphs_b_33_pad, pad_periphs_b_33_pad_io_gpio33   , pad_periphs_b_33_pad_mux_sel_io_gpio33    );
  tranif1 b_34_pad_io_gpio34   (pad_periphs_b_34_pad, pad_periphs_b_34_pad_io_gpio34   , pad_periphs_b_34_pad_mux_sel_io_gpio34    );
  tranif1 b_35_pad_io_gpio35   (pad_periphs_b_35_pad, pad_periphs_b_35_pad_io_gpio35   , pad_periphs_b_35_pad_mux_sel_io_gpio35    );
  tranif1 b_36_pad_io_gpio36   (pad_periphs_b_36_pad, pad_periphs_b_36_pad_io_gpio36   , pad_periphs_b_36_pad_mux_sel_io_gpio36    );
  tranif1 b_37_pad_io_gpio37   (pad_periphs_b_37_pad, pad_periphs_b_37_pad_io_gpio37   , pad_periphs_b_37_pad_mux_sel_io_gpio37    );
  tranif1 b_38_pad_io_gpio38   (pad_periphs_b_38_pad, pad_periphs_b_38_pad_io_gpio38   , pad_periphs_b_38_pad_mux_sel_io_gpio38    );
  tranif1 b_39_pad_io_gpio39   (pad_periphs_b_39_pad, pad_periphs_b_39_pad_io_gpio39   , pad_periphs_b_39_pad_mux_sel_io_gpio39    );
  tranif1 b_40_pad_io_gpio40   (pad_periphs_b_40_pad, pad_periphs_b_40_pad_io_gpio40   , pad_periphs_b_40_pad_mux_sel_io_gpio40    );
  tranif1 b_41_pad_io_gpio41   (pad_periphs_b_41_pad, pad_periphs_b_41_pad_io_gpio41   , pad_periphs_b_41_pad_mux_sel_io_gpio41    );
  tranif1 b_42_pad_io_gpio42   (pad_periphs_b_42_pad, pad_periphs_b_42_pad_io_gpio42   , pad_periphs_b_42_pad_mux_sel_io_gpio42    );
  tranif1 b_43_pad_io_gpio43   (pad_periphs_b_43_pad, pad_periphs_b_43_pad_io_gpio43   , pad_periphs_b_43_pad_mux_sel_io_gpio43    );
  tranif1 b_44_pad_io_gpio44   (pad_periphs_b_44_pad, pad_periphs_b_44_pad_io_gpio44   , pad_periphs_b_44_pad_mux_sel_io_gpio44    );
  tranif1 b_45_pad_io_gpio45   (pad_periphs_b_45_pad, pad_periphs_b_45_pad_io_gpio45   , pad_periphs_b_45_pad_mux_sel_io_gpio45    );
  tranif1 b_46_pad_io_gpio46   (pad_periphs_b_46_pad, pad_periphs_b_46_pad_io_gpio46   , pad_periphs_b_46_pad_mux_sel_io_gpio46    );
  tranif1 b_47_pad_eth_rst     (pad_periphs_b_47_pad, pad_periphs_b_47_pad_eth_rst     , pad_periphs_b_47_pad_mux_sel_eth_rst      );
  tranif1 b_47_pad_io_gpio47   (pad_periphs_b_47_pad, pad_periphs_b_47_pad_io_gpio47   , pad_periphs_b_47_pad_mux_sel_io_gpio47    );
  tranif1 b_48_pad_eth_rxck    (pad_periphs_b_48_pad, pad_periphs_b_48_pad_eth_rxck    , pad_periphs_b_48_pad_mux_sel_eth_rxck     );
  tranif1 b_48_pad_io_gpio48   (pad_periphs_b_48_pad, pad_periphs_b_48_pad_io_gpio48   , pad_periphs_b_48_pad_mux_sel_io_gpio48    );
  tranif1 b_49_pad_eth_rxctl   (pad_periphs_b_49_pad, pad_periphs_b_49_pad_eth_rxctl   , pad_periphs_b_49_pad_mux_sel_eth_rxctl    );
  tranif1 b_49_pad_io_gpio49   (pad_periphs_b_49_pad, pad_periphs_b_49_pad_io_gpio49   , pad_periphs_b_49_pad_mux_sel_io_gpio49    );
  tranif1 b_50_pad_eth_rxd0    (pad_periphs_b_50_pad, pad_periphs_b_50_pad_eth_rxd0    , pad_periphs_b_50_pad_mux_sel_eth_rxd0     );
  tranif1 b_50_pad_io_gpio50   (pad_periphs_b_50_pad, pad_periphs_b_50_pad_io_gpio50   , pad_periphs_b_50_pad_mux_sel_io_gpio50    );
  tranif1 b_51_pad_eth_rxd1    (pad_periphs_b_51_pad, pad_periphs_b_51_pad_eth_rxd1    , pad_periphs_b_51_pad_mux_sel_eth_rxd1     );
  tranif1 b_51_pad_io_gpio51   (pad_periphs_b_51_pad, pad_periphs_b_51_pad_io_gpio51   , pad_periphs_b_51_pad_mux_sel_io_gpio51    );
  tranif1 b_52_pad_eth_rxd2    (pad_periphs_b_52_pad, pad_periphs_b_52_pad_eth_rxd2    , pad_periphs_b_52_pad_mux_sel_eth_rxd2     );
  tranif1 b_52_pad_io_gpio52   (pad_periphs_b_52_pad, pad_periphs_b_52_pad_io_gpio52   , pad_periphs_b_52_pad_mux_sel_io_gpio52    );
  tranif1 b_53_pad_eth_rxd3    (pad_periphs_b_53_pad, pad_periphs_b_53_pad_eth_rxd3    , pad_periphs_b_53_pad_mux_sel_eth_rxd3     );
  tranif1 b_53_pad_io_gpio53   (pad_periphs_b_53_pad, pad_periphs_b_53_pad_io_gpio53   , pad_periphs_b_53_pad_mux_sel_io_gpio53    );
  tranif1 b_54_pad_eth_txck    (pad_periphs_b_54_pad, pad_periphs_b_54_pad_eth_txck    , pad_periphs_b_54_pad_mux_sel_eth_txck     );
  tranif1 b_54_pad_io_gpio54   (pad_periphs_b_54_pad, pad_periphs_b_54_pad_io_gpio54   , pad_periphs_b_54_pad_mux_sel_io_gpio54    );
  tranif1 b_55_pad_eth_txctl   (pad_periphs_b_55_pad, pad_periphs_b_55_pad_eth_txctl   , pad_periphs_b_55_pad_mux_sel_eth_txctl    );
  tranif1 b_55_pad_io_gpio55   (pad_periphs_b_55_pad, pad_periphs_b_55_pad_io_gpio55   , pad_periphs_b_55_pad_mux_sel_io_gpio55    );
  tranif1 b_56_pad_eth_txd0    (pad_periphs_b_56_pad, pad_periphs_b_56_pad_eth_txd0    , pad_periphs_b_56_pad_mux_sel_eth_txd0     );
  tranif1 b_56_pad_io_gpio56   (pad_periphs_b_56_pad, pad_periphs_b_56_pad_io_gpio56   , pad_periphs_b_56_pad_mux_sel_io_gpio56    );
  tranif1 b_57_pad_eth_txd1    (pad_periphs_b_57_pad, pad_periphs_b_57_pad_eth_txd1    , pad_periphs_b_57_pad_mux_sel_eth_txd1     );
  tranif1 b_57_pad_io_gpio57   (pad_periphs_b_57_pad, pad_periphs_b_57_pad_io_gpio57   , pad_periphs_b_57_pad_mux_sel_io_gpio57    );
  tranif1 b_58_pad_eth_txd2    (pad_periphs_b_58_pad, pad_periphs_b_58_pad_eth_txd2    , pad_periphs_b_58_pad_mux_sel_eth_txd2     );
  tranif1 b_58_pad_io_gpio58   (pad_periphs_b_58_pad, pad_periphs_b_58_pad_io_gpio58   , pad_periphs_b_58_pad_mux_sel_io_gpio58    );
  tranif1 b_59_pad_eth_txd3    (pad_periphs_b_59_pad, pad_periphs_b_59_pad_eth_txd3    , pad_periphs_b_59_pad_mux_sel_eth_txd3     );
  tranif1 b_59_pad_io_gpio59   (pad_periphs_b_59_pad, pad_periphs_b_59_pad_io_gpio59   , pad_periphs_b_59_pad_mux_sel_io_gpio59    );
  tranif1 b_60_pad_eth_mdio    (pad_periphs_b_60_pad, pad_periphs_b_60_pad_eth_mdio    , pad_periphs_b_60_pad_mux_sel_eth_mdio     );
  tranif1 b_60_pad_io_gpio60   (pad_periphs_b_60_pad, pad_periphs_b_60_pad_io_gpio60   , pad_periphs_b_60_pad_mux_sel_io_gpio60    );
  tranif1 b_61_pad_eth_mdc     (pad_periphs_b_61_pad, pad_periphs_b_61_pad_eth_mdc     , pad_periphs_b_61_pad_mux_sel_eth_mdc      );
  tranif1 b_61_pad_io_gpio61   (pad_periphs_b_61_pad, pad_periphs_b_61_pad_io_gpio61   , pad_periphs_b_61_pad_mux_sel_io_gpio61    );
  tranif1 b_62_pad_eth_intb    (pad_periphs_b_62_pad, pad_periphs_b_62_pad_eth_intb    , pad_periphs_b_62_pad_mux_sel_eth_intb     );
  tranif1 b_62_pad_io_gpio62   (pad_periphs_b_62_pad, pad_periphs_b_62_pad_io_gpio62   , pad_periphs_b_62_pad_mux_sel_io_gpio62    );

  //**************************************************
  // VIP MUXING END
  //**************************************************

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

   generate
     if(USE_S25FS256S_MODEL == 1) begin
      // configure the LINUX_QSPI1 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .mem_file_name ( "./vectors/qspi_stim.slm"  ),
        .UserPreload   ( 0 )
      ) i_qspi_flash_csn0 (
        .SI       ( pad_periphs_linux_qspi_02_pad ),
        .SO       ( pad_periphs_linux_qspi_03_pad ),
        .SCK      ( pad_periphs_linux_qspi_00_pad ),
        .CSNeg    ( pad_periphs_linux_qspi_01_pad ),
        .WPNeg    (  ),
        .RESETNeg (  )
      );
     end
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

  `ifndef PRELOAD
    `ifndef SEC_BOOT
      `ifndef USE_LOCAL_JTAG
        initial begin
          forever begin
            wait (exit_o[0]);

              if ((exit_o >> 1)) begin
                `uvm_error( "Core Test",  $sformatf("*** FAILED *** (tohost = %0d)", (exit_o >> 1)))
              end else begin
                `uvm_info( "Core Test",  $sformatf("*** SUCCESS *** (tohost = %0d)", (exit_o >> 1)), UVM_LOW)
              end
                $finish;
          end
        end
      `endif
    `endif
  `endif


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

    typedef jtag_ot_test::riscv_dbg #(
      .IrLength       (5                 ),
      .TA             (REFClockPeriod*0.1),
      .TT             (REFClockPeriod*0.9)
    ) riscv_dbg_ot_t;

    JTAG_DV jtag_ibex_mst (s_tck);
    riscv_dbg_ot_t::jtag_driver_t jtag_ibex_driver = new(jtag_ibex_mst);
    riscv_dbg_ot_t riscv_ibex_dbg = new(jtag_ibex_driver);

    assign s_ot_trstn = jtag_ibex_mst.trst_n;
    assign s_ot_tms   = jtag_ibex_mst.tms;
    assign s_ot_tdi   = jtag_ibex_mst.tdi;
    assign jtag_ibex_mst.tdo  = s_ot_tdo;

    // Clock process
    initial begin
        rst_ni = 1'b0;
        rst_DTM = 1'b0;
        jtag_mst.trst_n = 1'b0;
        jtag_ibex_mst.trst_n = 1'b0;
        jtag_ibex_mst.tdi    = 1'b0;
        jtag_ibex_mst.tms    = 1'b0;

        repeat(2)
            @(posedge rtc_i);
        @(negedge rtc_i);
        rst_ni = 1'b1;
        repeat(8)
            @(posedge rtc_i);
        rst_DTM = 1'b1;
        jtag_mst.trst_n = 1'b1;
        jtag_ibex_mst.trst_n = 1'b1;
        forever begin
            @(posedge clk_i);
            cycles++;
        end
    end

    // JTAG offload procedure

  initial  begin: local_jtag_preload

    logic [63:0] rdata;
    logic [32:0] addr;

    logic [31:0] linker_addr;
    logic [63:0] binary_entry;
    dm::sbcs_t sbcs;

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

        $display("Load binary...");
        // Load host code
        jtag_elf_load(binary, binary_entry);
        $display("Wakeup Core..");
        jtag_elf_run(binary_entry);
        $display("Wait EOC...");
        jtag_wait_for_eoc ( TOHOST );
      end else begin

        $display("Preload at %x - Sanity write/read at 0x1C000000", LINKER_ENTRY);
        addr = 32'h1c000000;

        jtag_write_reg (addr, {32'hdeadcaca, 32'habbaabba});

        binary_entry={32'h00000000,LINKER_ENTRY};
        #(REFClockPeriod);
        $display("Wakeup here at %x!!", binary_entry);
        jtag_ariane_wakeup( LINKER_ENTRY );
        jtag_wait_for_eoc ( TOHOST );
      end
    end
  end

  task automatic jtag_read_reg;
    input logic [31:0] addr;
    output logic [63:0] rdata;

    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    sbcs.sbreadonaddr = 1;
    jtag_dbg.write_dmi(dm::SBCS, sbcs);
    do jtag_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    jtag_dbg.write_dmi(dm::SBAddress0, addr);
    do jtag_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    jtag_dbg.read_dmi_exp_backoff(dm::SBData1, rdata[63:32]);
    // Wait until SBA is free to read another 32 bits
    do jtag_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    jtag_dbg.read_dmi_exp_backoff(dm::SBData0, rdata[31:0]);
    // Wait until SBA is free to read another 32 bits
    do jtag_dbg.read_dmi_exp_backoff(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
  endtask

  task automatic jtag_write_reg(input logic [31:0] start_addr, input doub_bt value);
    logic [63:0]      rdata;

    $display("[JTAG] Start writing at %x ", start_addr);
    jtag_write(dm::SBCS, JtagInitSbcs, 1, 1);
    // Write address
    jtag_write(dm::SBAddress0, start_addr);
    // Write data
    jtag_write(dm::SBData1, value[63:32]);
    jtag_write(dm::SBData0, value[31:0]);

    //Check correctess
    jtag_read_reg(start_addr, rdata);
    if(rdata!=value) begin
      $fatal(1,"rdata at %x: %x" , start_addr, rdata);
    end else begin
      $display("W/R sanity check at %x ok! : %x", start_addr, rdata);
    end
  endtask

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
  task automatic jtag_wait_for_eoc(input word_bt tohost);
    //jtag_init();
    jtag_poll_bit0(tohost, exit_code, 800);
    exit_code >>= 1;
    if (exit_code) $error("[JTAG] FAILED: return code %0d", exit_code);
    else $display("[JTAG] SUCCESS");
    $finish;
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

/////////////////////////////////////////////////////////////////
                 //IBEX PROCESS AND TASKS//
////////////////////////////////////////////////////////////////

   initial  begin : bootmodes

     if(!$value$plusargs("BOOTMODE=%d", boot_mode)) begin
        boot_mode=0;
        $display("BOOTMODE: %d", boot_mode);
     end
     if(!$value$plusargs("OT_SRAM=%s", ot_sram)) begin
        ot_sram="";
        $display("Loading to SRAM: %s", ot_sram);
     end
     case(boot_mode)
         0:begin
           bootmode = 1'b0;
           riscv_ibex_dbg.reset_master();
           if (ot_sram != "") begin
                repeat(8)
                  @(posedge rtc_i);
                debug_secd_module_init();
                load_secd_binary(ot_sram);
                jtag_secd_data_preload();
                jtag_secd_wakeup(32'h e0000080); //preload the flashif
           `ifdef JTAG_SEC_BOOT
                repeat(500)
                  @(posedge rtc_i);
                jtag_secd_wakeup(32'h d0008080); //secure boot
           `endif
           end
         end
         1:begin
           bootmode = 1'b1;
           riscv_ibex_dbg.reset_master();
         end
         default:begin
           bootmode = 1'b0;
           $fatal("Unsupported bootmode");
         end
     endcase // case (bootmode)
   end // block: bootmodes

///////////////////////////// Tasks ///////////////////////////////

   task debug_secd_module_init;

     logic [31:0]  idcode;

     automatic dm_ot::sbcs_t sbcs = '{
       sbautoincrement: 1'b1,
       sbreadondata   : 1'b1,
       sbaccess       : 3'h2,
       default        : 1'b0
     };
     //dm_ot::dtm_op_status_e op;
     automatic int dmi_wait_cycles = 10;


     $display("[JTAG SECD] Start SECD JTAG Preloading");
     riscv_ibex_dbg.wait_idle(300);
     riscv_ibex_dbg.get_idcode(idcode);
     $display("[JTAG SECD] IDCode = %h", idcode);
     // Activate Debug Module
     riscv_ibex_dbg.write_dmi(dm_ot::DMControl, 32'h0000_0001);
     do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
     while (sbcs.sbbusy);

   endtask // debug_module_init

   task jtag_secd_data_preload;
     logic [31:0] rdata;

     automatic dm_ot::sbcs_t sbcs = '{
       sbautoincrement: 1'b1,
       sbreadondata   : 1'b1,
       sbaccess       : 3'h2,
       default        : 1'b0
     };
     //dm_ot::dtm_op_status_e op;
     automatic int dmi_wait_cycles = 10;


     $display("[JTAG SECD] Initializing the Debug Module");
     debug_secd_module_init();
     riscv_ibex_dbg.write_dmi(dm_ot::SBCS, sbcs);

     do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);

     while (sbcs.sbbusy);

     $display("[JTAG SECD] Preload data to SRAM");

     // Start writing to SRAM
     foreach (ibex_sections[addr]) begin
       $display("[JTAG SECD] Writing %h with %0d words", addr << 2, ibex_sections[addr]); // word = 8 bytes here
       riscv_ibex_dbg.write_dmi(dm_ot::SBAddress0, (addr << 2));

       do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);

       while (sbcs.sbbusy);
       for (int i = 0; i < ibex_sections[addr]; i++) begin
         if(i%100 == 0)
           $display("[JTAG SECD] Preloading: %0d/100%%",  i*100/ibex_sections[addr]);
         riscv_ibex_dbg.write_dmi(dm_ot::SBData0, ibex_memory[addr + i]);
         // Wait until SBA is free to write next 32 bits
         do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
         while (sbcs.sbbusy);
       end // for (int i = 0; i < sections[addr]; i++
       $display("[JTAG SECD] Preloading: 100/100%%");
     end // foreach (sections[addr])

    $display("[JTAG SECD] Preloading finished");


    // Preloading finished. Can now start executing
    sbcs.sbreadonaddr = 0;
    sbcs.sbreadondata = 0;
    riscv_ibex_dbg.write_dmi(dm_ot::SBCS, sbcs);

  endtask // jtag_data_preload

  task jtag_secd_wakeup;
    input logic [31:0] start_addr;
    logic [31:0] dm_status;

    automatic dm_ot::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      sbaccess       : 3'h2,
      default        : 1'b0
    };
    //dm_ot::dtm_op_status_e op;
    automatic int dmi_wait_cycles = 10;
    $display("[JTAG SECD] Waking up Ibex");
    // Initialize the dm module again, otherwise it will not work
    debug_secd_module_init();
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
    while (sbcs.sbbusy);
    // Write PC to Data0 and Data1
    riscv_ibex_dbg.write_dmi(dm_ot::Data0, start_addr);
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
    while (sbcs.sbbusy);
    // Halt Req
    riscv_ibex_dbg.write_dmi(dm_ot::DMControl, 32'h8000_0001);
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
    while (sbcs.sbbusy);
    // Wait for CVA6 to be halted
    do riscv_ibex_dbg.read_dmi(dm_ot::DMStatus, dm_status, dmi_wait_cycles);
    while (!dm_status[8]);
    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    riscv_ibex_dbg.write_dmi(dm_ot::DMControl, 32'h0000_0001);
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
    while (sbcs.sbbusy);
    // Register Access Abstract Command
    riscv_ibex_dbg.write_dmi(dm_ot::Command, {8'h0,1'b0,3'h2,1'b0,1'b0,1'b1,1'b1,4'h0,dm_ot::CSR_DPC});
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
    while (sbcs.sbbusy);
    // Resume req. Exiting from debug mode CVA6 will jump at the DPC address.
    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    riscv_ibex_dbg.write_dmi(dm_ot::DMControl, 32'h4000_0001);
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);
    while (sbcs.sbbusy);
    riscv_ibex_dbg.write_dmi(dm_ot::DMControl, 32'h0000_0001);
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs, dmi_wait_cycles);

    while (sbcs.sbbusy);

    // Wait till end of computation

  endtask // execute_application

  task load_secd_binary;
    input string binary;                   // File name
    logic [31:0] section_addr, section_len;
    byte         buffer[];

    // Read ELF
    void'(read_elf(binary));
    $display("[JTAG SECD] Reading %s", binary);

    while (get_section(section_addr, section_len)) begin
      // Read Sections
      automatic int num_words = (section_len + AxiWideBeWidth_ib - 1)/AxiWideBeWidth_ib;
      $display("[JTAG SECD] Reading section %x with %0d words", section_addr, num_words);

      ibex_sections[section_addr >> AxiWideByteOffset_ib] = num_words;
      buffer                                      = new[num_words * AxiWideBeWidth_ib];
      void'(read_section(section_addr, buffer, section_len));
      for (int i = 0; i < num_words; i++) begin
        automatic logic [AxiWideBeWidth_ib-1:0][7:0] word = '0;
        for (int j = 0; j < AxiWideBeWidth_ib; j++) begin
          word[j] = buffer[i * AxiWideBeWidth_ib + j];
        end
        ibex_memory[section_addr/AxiWideBeWidth_ib + i] = word;
      end
    end

  endtask // load_binary
endmodule // ariane_tb

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
import pkg_internal_alsaqr_periph_fpga_padframe_periphs::*;

`include "uvm_macros.svh"
`include "axi/assign.svh"
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

//`define POWER_PROFILE
//`define POWER_CVA6
`define PAD_MUX_REG_PATH dut.i_alsaqr_periph_padframe.i_periphs.i_periphs_muxer.s_reg2hw
`define SIMPLE_PAD_MUX_REG_PATH dut.i_alsaqr_periph_fpga_padframe.i_periphs.i_periphs_muxer.s_reg2hw

import "DPI-C" function byte read_elf(input string filename);
import "DPI-C" function byte get_entry(output longint entry);
import "DPI-C" function byte get_section(output longint address, output longint len);
import "DPI-C" context function byte read_section(input longint address, inout byte buffer[], input longint len);


module ariane_tb;

  static uvm_cmdline_processor uvcl = uvm_cmdline_processor::get_inst();
  `ifdef TARGET_ASIC
  localparam int unsigned REFClockPeriod = 500ns; // jtag clock: 2MHz
  `else
  localparam int unsigned REFClockPeriod = 67000ps;  // jtag clock: around 15MHz
  `endif
  // toggle with RTC period
  `ifndef TEST_CLOCK_BYPASS
    localparam int unsigned RTC_CLOCK_PERIOD = 30.517us;
  `else
    localparam int unsigned RTC_CLOCK_PERIOD = 2ns;
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
  // IMPORTANT : to host mapped in L2 non-cached region because we use WB cache
  parameter  TOHOST              = 32'h1C000000;

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

    wire  [NumPhys-1:0][NumChips-1:0] hyper_cs_n_wire;
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

    wire    pad_periphs_ot_spi_00_pad;
    wire    pad_periphs_ot_spi_01_pad;
    wire    pad_periphs_ot_spi_02_pad;
    wire    pad_periphs_ot_spi_03_pad;

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
    string        ot_flash;

    logic         cid;

    //**************************************************
    // PAD VIPs SIGNALS BEGINNING
    //**************************************************
    wire    alt_0_pad_periphs_a_00_pad_CORE_UART_TX    ;
    wire    alt_0_pad_periphs_a_01_pad_CORE_UART_RX    ;
    wire    alt_0_pad_periphs_a_02_pad_SDIO0_D1        ;
    wire    alt_0_pad_periphs_a_03_pad_SDIO0_D2        ;
    wire    alt_0_pad_periphs_a_04_pad_SDIO0_D3        ;
    wire    alt_0_pad_periphs_a_05_pad_SDIO0_D4        ;
    wire    alt_0_pad_periphs_a_06_pad_SDIO0_CLK       ;
    wire    alt_0_pad_periphs_a_07_pad_SDIO0_CMD       ;
    wire    alt_0_pad_periphs_a_08_pad_PWM0_CHANNEL0   ;
    wire    alt_0_pad_periphs_a_09_pad_PWM1_CHANNEL0   ;
    wire    alt_0_pad_periphs_a_10_pad_PWM2_CHANNEL0   ;
    wire    alt_0_pad_periphs_a_11_pad_PWM3_CHANNEL0   ;
    wire    alt_0_pad_periphs_a_12_pad_BARO1_I2C0_SCL  ;
    wire    alt_0_pad_periphs_a_13_pad_BARO1_I2C0_SDA  ;
    wire    alt_0_pad_periphs_a_14_pad_IMU1_SPI0_SCK   ;
    wire    alt_0_pad_periphs_a_15_pad_IMU1_SPI0_CS    ;
    wire    alt_0_pad_periphs_a_16_pad_IMU1_SPI0_MISO  ;
    wire    alt_0_pad_periphs_a_17_pad_IMU1_SPI0_MOSI  ;
    wire    alt_0_pad_periphs_a_18_pad_FRAM_SPI2_SCK   ;
    wire    alt_0_pad_periphs_a_19_pad_FRAM_SPI2_CS    ;
    wire    alt_0_pad_periphs_a_20_pad_FRAM_SPI2_MISO  ;
    wire    alt_0_pad_periphs_a_21_pad_FRAM_SPI2_MOSI  ;
    wire    alt_0_pad_periphs_a_22_pad_ADIO1_SPI3_SCK  ;
    wire    alt_0_pad_periphs_a_23_pad_ADIO1_SPI3_CS   ;
    wire    alt_0_pad_periphs_a_24_pad_ADIO1_SPI3_MISO ;
    wire    alt_0_pad_periphs_a_25_pad_ADIO1_SPI3_MOSI ;
    wire    alt_0_pad_periphs_a_26_pad_GPS2_UART0_TX   ;
    wire    alt_0_pad_periphs_a_27_pad_GPS2_UART0_RX   ;
    wire    alt_0_pad_periphs_a_28_pad_GPS2_I2C1_SCL   ;
    wire    alt_0_pad_periphs_a_29_pad_GPS2_I2C1_SDA   ;
    wire    alt_1_pad_periphs_a_00_pad_CORE_UART_TX    ;
    wire    alt_1_pad_periphs_a_01_pad_CORE_UART_RX    ;
    wire    alt_1_pad_periphs_a_02_pad_LINUX_QSPI_SCK  ;
    wire    alt_1_pad_periphs_a_03_pad_LINUX_QSPI_CSN  ;
    wire    alt_1_pad_periphs_a_04_pad_LINUX_QSPI_IO0  ;
    wire    alt_1_pad_periphs_a_05_pad_LINUX_QSPI_IO1  ;
    wire    alt_1_pad_periphs_a_06_pad_LINUX_QSPI_IO2  ;
    wire    alt_1_pad_periphs_a_07_pad_LINUX_QSPI_IO3  ;
    wire    alt_1_pad_periphs_a_08_pad_BARO1_I2C0_SCL  ;
    wire    alt_1_pad_periphs_a_09_pad_BARO1_I2C0_SDA  ;
    wire    alt_1_pad_periphs_a_10_pad_PWM0_CHANNEL0   ;
    wire    alt_1_pad_periphs_a_11_pad_PWM1_CHANNEL0   ;
    wire    alt_1_pad_periphs_a_12_pad_PWM2_CHANNEL0   ;
    wire    alt_1_pad_periphs_a_13_pad_PWM3_CHANNEL0   ;
    wire    alt_1_pad_periphs_a_14_pad_GPS1_UART2_TX   ;
    wire    alt_1_pad_periphs_a_15_pad_GPS1_UART2_RX   ;
    wire    alt_1_pad_periphs_a_16_pad_GPS1_I2C5_SCL   ;
    wire    alt_1_pad_periphs_a_17_pad_GPS1_I2C5_SDA   ;
    wire    alt_1_pad_periphs_a_18_pad_CAM0_CPI0_CLK   ;
    wire    alt_1_pad_periphs_a_19_pad_CAM0_CPI0_VSYNC ;
    wire    alt_1_pad_periphs_a_20_pad_CAM0_CPI0_HSYNC ;
    wire    alt_1_pad_periphs_a_21_pad_CAM0_CPI0_DAT0  ;
    wire    alt_1_pad_periphs_a_22_pad_CAM0_CPI0_DAT1  ;
    wire    alt_1_pad_periphs_a_23_pad_CAM0_CPI0_DAT2  ;
    wire    alt_1_pad_periphs_a_24_pad_CAM0_CPI0_DAT3  ;
    wire    alt_1_pad_periphs_a_25_pad_CAM0_CPI0_DAT4  ;
    wire    alt_1_pad_periphs_a_26_pad_CAM0_CPI0_DAT5  ;
    wire    alt_1_pad_periphs_a_27_pad_CAM0_CPI0_DAT6  ;
    wire    alt_1_pad_periphs_a_28_pad_CAM0_CPI0_DAT7  ;
    wire    alt_1_pad_periphs_a_29_pad_FLL_SOC         ;
    wire    alt_2_pad_periphs_a_00_pad_CAN0_TX            ;
    wire    alt_2_pad_periphs_a_01_pad_CAN0_RX            ;
    wire    alt_2_pad_periphs_a_02_pad_CAN1_TX            ;
    wire    alt_2_pad_periphs_a_03_pad_CAN1_RX            ;
    wire    alt_2_pad_periphs_a_04_pad_FLL_SOC            ;
    wire    alt_2_pad_periphs_a_05_pad_IO_USART1_TX       ;
    wire    alt_2_pad_periphs_a_06_pad_IO_USART1_RX       ;
    wire    alt_2_pad_periphs_a_07_pad_IO_USART1_RTS      ;
    wire    alt_2_pad_periphs_a_08_pad_IO_USART1_CTS      ;
    wire    alt_2_pad_periphs_a_09_pad_WIRELESS_SDIO1_D0  ;
    wire    alt_2_pad_periphs_a_10_pad_WIRELESS_SDIO1_D1  ;
    wire    alt_2_pad_periphs_a_11_pad_WIRELESS_SDIO1_D2  ;
    wire    alt_2_pad_periphs_a_12_pad_WIRELESS_SDIO1_D3  ;
    wire    alt_2_pad_periphs_a_13_pad_WIRELESS_SDIO1_CLK ;
    wire    alt_2_pad_periphs_a_14_pad_WIRELESS_SDIO1_CMD ;
    wire    alt_2_pad_periphs_a_15_pad_ETH_RST            ;
    wire    alt_2_pad_periphs_a_16_pad_ETH_RXCK           ;
    wire    alt_2_pad_periphs_a_17_pad_ETH_RXCTL          ;
    wire    alt_2_pad_periphs_a_18_pad_ETH_RXD0           ;
    wire    alt_2_pad_periphs_a_19_pad_ETH_RXD1           ;
    wire    alt_2_pad_periphs_a_20_pad_ETH_RXD2           ;
    wire    alt_2_pad_periphs_a_21_pad_ETH_RXD3           ;
    wire    alt_2_pad_periphs_a_22_pad_ETH_TXCK           ;
    wire    alt_2_pad_periphs_a_23_pad_ETH_TXCTL          ;
    wire    alt_2_pad_periphs_a_24_pad_ETH_TXD0           ;
    wire    alt_2_pad_periphs_a_25_pad_ETH_TXD1           ;
    wire    alt_2_pad_periphs_a_26_pad_ETH_TXD2           ;
    wire    alt_2_pad_periphs_a_27_pad_ETH_TXD3           ;
    wire    alt_2_pad_periphs_a_28_pad_ETH_MDIO           ;
    wire    alt_2_pad_periphs_a_29_pad_ETH_MDC            ;
    wire    alt_3_pad_periphs_a_00_pad_IO_GPIO00 ;
    wire    alt_3_pad_periphs_a_01_pad_IO_GPIO01 ;
    wire    alt_3_pad_periphs_a_02_pad_IO_GPIO02 ;
    wire    alt_3_pad_periphs_a_03_pad_IO_GPIO03 ;
    wire    alt_3_pad_periphs_a_04_pad_IO_GPIO04 ;
    wire    alt_3_pad_periphs_a_05_pad_IO_GPIO05 ;
    wire    alt_3_pad_periphs_a_06_pad_IO_GPIO06 ;
    wire    alt_3_pad_periphs_a_07_pad_IO_GPIO07 ;
    wire    alt_3_pad_periphs_a_08_pad_IO_GPIO08 ;
    wire    alt_3_pad_periphs_a_09_pad_IO_GPIO09 ;
    wire    alt_3_pad_periphs_a_10_pad_IO_GPIO10 ;
    wire    alt_3_pad_periphs_a_11_pad_IO_GPIO11 ;
    wire    alt_3_pad_periphs_a_12_pad_IO_GPIO12 ;
    wire    alt_3_pad_periphs_a_13_pad_IO_GPIO13 ;
    wire    alt_3_pad_periphs_a_14_pad_IO_GPIO14 ;
    wire    alt_3_pad_periphs_a_15_pad_IO_GPIO15 ;
    wire    alt_3_pad_periphs_a_16_pad_IO_GPIO16 ;
    wire    alt_3_pad_periphs_a_17_pad_IO_GPIO17 ;
    wire    alt_3_pad_periphs_a_18_pad_IO_GPIO18 ;
    wire    alt_3_pad_periphs_a_19_pad_IO_GPIO19 ;
    wire    alt_3_pad_periphs_a_20_pad_IO_GPIO20 ;
    wire    alt_3_pad_periphs_a_21_pad_IO_GPIO21 ;
    wire    alt_3_pad_periphs_a_22_pad_IO_GPIO22 ;
    wire    alt_3_pad_periphs_a_23_pad_IO_GPIO23 ;
    wire    alt_3_pad_periphs_a_24_pad_IO_GPIO24 ;
    wire    alt_3_pad_periphs_a_25_pad_IO_GPIO25 ;
    wire    alt_3_pad_periphs_a_26_pad_IO_GPIO26 ;
    wire    alt_3_pad_periphs_a_27_pad_IO_GPIO27 ;
    wire    alt_3_pad_periphs_a_28_pad_IO_GPIO28 ;
    wire    alt_3_pad_periphs_a_29_pad_IO_GPIO29 ;

    wire    alt_0_pad_periphs_b_00_pad_TLM1_USART0_TX  ;
    wire    alt_0_pad_periphs_b_01_pad_TLM1_USART0_RX  ;
    wire    alt_0_pad_periphs_b_02_pad_TLM1_USART0_RTS ;
    wire    alt_0_pad_periphs_b_03_pad_TLM1_USART0_CTS ;
    wire    alt_0_pad_periphs_b_04_pad_ADC0_SPI4_SCK   ;
    wire    alt_0_pad_periphs_b_05_pad_ADC0_SPI4_CS    ;
    wire    alt_0_pad_periphs_b_06_pad_ADC0_SPI4_MISO  ;
    wire    alt_0_pad_periphs_b_07_pad_ADC0_SPI4_MOSI  ;
    wire    alt_0_pad_periphs_b_08_pad_PMIC_I2C2_SCL   ;
    wire    alt_0_pad_periphs_b_09_pad_PMIC_I2C2_SDA   ;
    wire    alt_0_pad_periphs_b_10_pad_EXT1_SPI7_SCK   ;
    wire    alt_0_pad_periphs_b_11_pad_EXT1_SPI7_MISO  ;
    wire    alt_0_pad_periphs_b_12_pad_EXT1_SPI7_MOSI  ;
    wire    alt_0_pad_periphs_b_13_pad_EXT1_SPI7_CS0   ;
    wire    alt_0_pad_periphs_b_14_pad_EXT1_SPI7_CS1   ;
    wire    alt_0_pad_periphs_b_15_pad_EXT2_I2C4_SCL   ;
    wire    alt_0_pad_periphs_b_16_pad_EXT2_I2C4_SDA   ;
    wire    alt_0_pad_periphs_b_17_pad_EXT3_UART1_TX   ;
    wire    alt_0_pad_periphs_b_18_pad_EXT3_UART1_RX   ;
    wire    alt_0_pad_periphs_b_19_pad_IO_USART1_TX    ;
    wire    alt_0_pad_periphs_b_20_pad_IO_USART1_RX    ;
    wire    alt_0_pad_periphs_b_21_pad_IO_USART1_RTS   ;
    wire    alt_0_pad_periphs_b_22_pad_IO_USART1_CTS   ;
    wire    alt_0_pad_periphs_b_23_pad_ETH_RST         ;
    wire    alt_0_pad_periphs_b_24_pad_ETH_RXCK        ;
    wire    alt_0_pad_periphs_b_25_pad_ETH_RXCTL       ;
    wire    alt_0_pad_periphs_b_26_pad_ETH_RXD0        ;
    wire    alt_0_pad_periphs_b_27_pad_ETH_RXD1        ;
    wire    alt_0_pad_periphs_b_28_pad_ETH_RXD2        ;
    wire    alt_0_pad_periphs_b_29_pad_ETH_RXD3        ;
    wire    alt_0_pad_periphs_b_30_pad_ETH_TXCK        ;
    wire    alt_0_pad_periphs_b_31_pad_ETH_TXCTL       ;
    wire    alt_0_pad_periphs_b_32_pad_ETH_TXD0        ;
    wire    alt_0_pad_periphs_b_33_pad_ETH_TXD1        ;
    wire    alt_0_pad_periphs_b_34_pad_ETH_TXD2        ;
    wire    alt_0_pad_periphs_b_35_pad_ETH_TXD3        ;
    wire    alt_0_pad_periphs_b_36_pad_ETH_MDIO        ;
    wire    alt_0_pad_periphs_b_37_pad_ETH_MDC         ;
    wire    alt_0_pad_periphs_b_38_pad_USB1_SPI10_SCK  ;
    wire    alt_0_pad_periphs_b_39_pad_USB1_SPI10_CS   ;
    wire    alt_0_pad_periphs_b_40_pad_USB1_SPI10_MISO ;
    wire    alt_0_pad_periphs_b_41_pad_USB1_SPI10_MOSI ;
    wire    alt_0_pad_periphs_b_42_pad_CAN0_TX         ;
    wire    alt_0_pad_periphs_b_43_pad_CAN0_RX         ;
    wire    alt_0_pad_periphs_b_44_pad_PWM0_CHANNEL1   ;
    wire    alt_0_pad_periphs_b_45_pad_PWM1_CHANNEL1   ;
    wire    alt_0_pad_periphs_b_46_pad_PWM2_CHANNEL1   ;
    wire    alt_0_pad_periphs_b_47_pad_PWM3_CHANNEL1   ;
    wire    alt_1_pad_periphs_b_00_pad_WIRELESS_SDIO1_D0  ;
    wire    alt_1_pad_periphs_b_01_pad_WIRELESS_SDIO1_D1  ;
    wire    alt_1_pad_periphs_b_02_pad_WIRELESS_SDIO1_D2  ;
    wire    alt_1_pad_periphs_b_03_pad_WIRELESS_SDIO1_D3  ;
    wire    alt_1_pad_periphs_b_04_pad_WIRELESS_SDIO1_CLK ;
    wire    alt_1_pad_periphs_b_05_pad_WIRELESS_SDIO1_CMD ;
    wire    alt_1_pad_periphs_b_06_pad_IMU1_SPI0_SCK      ;
    wire    alt_1_pad_periphs_b_07_pad_IMU1_SPI0_CS       ;
    wire    alt_1_pad_periphs_b_08_pad_IMU1_SPI0_MISO     ;
    wire    alt_1_pad_periphs_b_09_pad_IMU1_SPI0_MOSI     ;
    wire    alt_1_pad_periphs_b_10_pad_TLM1_USART0_TX     ;
    wire    alt_1_pad_periphs_b_11_pad_TLM1_USART0_RX     ;
    wire    alt_1_pad_periphs_b_12_pad_TLM1_USART0_RTS    ;
    wire    alt_1_pad_periphs_b_13_pad_TLM1_USART0_CTS    ;
    wire    alt_1_pad_periphs_b_14_pad_ADC0_SPI4_SCK      ;
    wire    alt_1_pad_periphs_b_15_pad_ADC0_SPI4_CS       ;
    wire    alt_1_pad_periphs_b_16_pad_ADC0_SPI4_MISO     ;
    wire    alt_1_pad_periphs_b_17_pad_ADC0_SPI4_MOSI     ;
    wire    alt_1_pad_periphs_b_18_pad_FRAM_SPI2_SCK      ;
    wire    alt_1_pad_periphs_b_19_pad_FRAM_SPI2_CS       ;
    wire    alt_1_pad_periphs_b_20_pad_FRAM_SPI2_MISO     ;
    wire    alt_1_pad_periphs_b_21_pad_FRAM_SPI2_MOSI     ;
    wire    alt_1_pad_periphs_b_22_pad_ADIO1_SPI3_SCK     ;
    wire    alt_1_pad_periphs_b_23_pad_ADIO1_SPI3_CS      ;
    wire    alt_1_pad_periphs_b_24_pad_ADIO1_SPI3_MISO    ;
    wire    alt_1_pad_periphs_b_25_pad_ADIO1_SPI3_MOSI    ;
    wire    alt_1_pad_periphs_b_26_pad_MAG_SPI1_SCK       ;
    wire    alt_1_pad_periphs_b_27_pad_MAG_SPI1_CS        ;
    wire    alt_1_pad_periphs_b_28_pad_MAG_SPI1_MISO      ;
    wire    alt_1_pad_periphs_b_29_pad_MAG_SPI1_MOSI      ;
    wire    alt_1_pad_periphs_b_30_pad_CAN1_TX            ;
    wire    alt_1_pad_periphs_b_31_pad_CAN1_RX            ;
    wire    alt_1_pad_periphs_b_32_pad_PWM0_CHANNEL1      ;
    wire    alt_1_pad_periphs_b_33_pad_PWM1_CHANNEL1      ;
    wire    alt_1_pad_periphs_b_34_pad_PWM2_CHANNEL1      ;
    wire    alt_1_pad_periphs_b_35_pad_PWM3_CHANNEL1      ;
    wire    alt_1_pad_periphs_b_36_pad_CAM1_CPI1_CLK      ;
    wire    alt_1_pad_periphs_b_37_pad_CAM1_CPI1_VSYNC    ;
    wire    alt_1_pad_periphs_b_38_pad_CAM1_CPI1_HSYNC    ;
    wire    alt_1_pad_periphs_b_39_pad_CAM1_CPI1_DAT0     ;
    wire    alt_1_pad_periphs_b_40_pad_CAM1_CPI1_DAT1     ;
    wire    alt_1_pad_periphs_b_41_pad_CAM1_CPI1_DAT2     ;
    wire    alt_1_pad_periphs_b_42_pad_CAM1_CPI1_DAT3     ;
    wire    alt_1_pad_periphs_b_43_pad_CAM1_CPI1_DAT4     ;
    wire    alt_1_pad_periphs_b_44_pad_CAM1_CPI1_DAT5     ;
    wire    alt_1_pad_periphs_b_45_pad_CAM1_CPI1_DAT6     ;
    wire    alt_1_pad_periphs_b_46_pad_CAM1_CPI1_DAT7     ;
    wire    alt_1_pad_periphs_b_47_pad_FLL_CVA6           ;
    wire    alt_2_pad_periphs_b_00_pad_IO_GPIO00 ;
    wire    alt_2_pad_periphs_b_01_pad_IO_GPIO01 ;
    wire    alt_2_pad_periphs_b_02_pad_IO_GPIO02 ;
    wire    alt_2_pad_periphs_b_03_pad_IO_GPIO03 ;
    wire    alt_2_pad_periphs_b_04_pad_IO_GPIO04 ;
    wire    alt_2_pad_periphs_b_05_pad_IO_GPIO05 ;
    wire    alt_2_pad_periphs_b_06_pad_IO_GPIO06 ;
    wire    alt_2_pad_periphs_b_07_pad_IO_GPIO07 ;
    wire    alt_2_pad_periphs_b_08_pad_IO_GPIO08 ;
    wire    alt_2_pad_periphs_b_09_pad_IO_GPIO09 ;
    wire    alt_2_pad_periphs_b_10_pad_IO_GPIO10 ;
    wire    alt_2_pad_periphs_b_11_pad_IO_GPIO11 ;
    wire    alt_2_pad_periphs_b_12_pad_IO_GPIO12 ;
    wire    alt_2_pad_periphs_b_13_pad_IO_GPIO13 ;
    wire    alt_2_pad_periphs_b_14_pad_IO_GPIO14 ;
    wire    alt_2_pad_periphs_b_15_pad_IO_GPIO15 ;
    wire    alt_2_pad_periphs_b_16_pad_IO_GPIO16 ;
    wire    alt_2_pad_periphs_b_17_pad_IO_GPIO17 ;
    wire    alt_2_pad_periphs_b_18_pad_IO_GPIO18 ;
    wire    alt_2_pad_periphs_b_19_pad_IO_GPIO19 ;
    wire    alt_2_pad_periphs_b_20_pad_IO_GPIO20 ;
    wire    alt_2_pad_periphs_b_21_pad_IO_GPIO21 ;
    wire    alt_2_pad_periphs_b_22_pad_IO_GPIO22 ;
    wire    alt_2_pad_periphs_b_23_pad_IO_GPIO23 ;
    wire    alt_2_pad_periphs_b_24_pad_IO_GPIO24 ;
    wire    alt_2_pad_periphs_b_25_pad_IO_GPIO25 ;
    wire    alt_2_pad_periphs_b_26_pad_IO_GPIO26 ;
    wire    alt_2_pad_periphs_b_27_pad_IO_GPIO27 ;
    wire    alt_2_pad_periphs_b_28_pad_IO_GPIO28 ;
    wire    alt_2_pad_periphs_b_29_pad_IO_GPIO29 ;
    wire    alt_2_pad_periphs_b_30_pad_IO_GPIO30 ;
    wire    alt_2_pad_periphs_b_31_pad_IO_GPIO31 ;
    wire    alt_2_pad_periphs_b_32_pad_IO_GPIO32 ;
    wire    alt_2_pad_periphs_b_33_pad_IO_GPIO33 ;
    wire    alt_2_pad_periphs_b_34_pad_IO_GPIO34 ;
    wire    alt_2_pad_periphs_b_35_pad_IO_GPIO35 ;
    wire    alt_2_pad_periphs_b_36_pad_IO_GPIO36 ;
    wire    alt_2_pad_periphs_b_37_pad_IO_GPIO37 ;
    wire    alt_2_pad_periphs_b_38_pad_IO_GPIO38 ;
    wire    alt_2_pad_periphs_b_39_pad_IO_GPIO39 ;
    wire    alt_2_pad_periphs_b_40_pad_IO_GPIO40 ;
    wire    alt_2_pad_periphs_b_41_pad_IO_GPIO41 ;
    wire    alt_2_pad_periphs_b_42_pad_IO_GPIO42 ;
    wire    alt_2_pad_periphs_b_43_pad_IO_GPIO43 ;
    wire    alt_2_pad_periphs_b_44_pad_IO_GPIO44 ;
    wire    alt_2_pad_periphs_b_45_pad_IO_GPIO45 ;
    wire    alt_2_pad_periphs_b_46_pad_IO_GPIO46 ;
    wire    alt_2_pad_periphs_b_47_pad_IO_GPIO47 ;
    wire    alt_3_pad_periphs_b_00_pad_GPS2_UART0_TX   ;
    wire    alt_3_pad_periphs_b_01_pad_GPS2_UART0_RX   ;
    wire    alt_3_pad_periphs_b_02_pad_GPS2_I2C1_SCL   ;
    wire    alt_3_pad_periphs_b_03_pad_GPS2_I2C1_SDA   ;
    wire    alt_3_pad_periphs_b_04_pad_IMU2_SPI5_SCK   ;
    wire    alt_3_pad_periphs_b_05_pad_IMU2_SPI5_CS    ;
    wire    alt_3_pad_periphs_b_06_pad_IMU2_SPI5_MISO  ;
    wire    alt_3_pad_periphs_b_07_pad_IMU2_SPI5_MOSI  ;
    wire    alt_3_pad_periphs_b_08_pad_BARO2_I2C3_SCL  ;
    wire    alt_3_pad_periphs_b_09_pad_BARO2_I2C3_SDA  ;
    wire    alt_3_pad_periphs_b_10_pad_IMU3_SPI6_SCK   ;
    wire    alt_3_pad_periphs_b_11_pad_IMU3_SPI6_CS    ;
    wire    alt_3_pad_periphs_b_12_pad_IMU3_SPI6_MISO  ;
    wire    alt_3_pad_periphs_b_13_pad_IMU3_SPI6_MOSI  ;
    wire    alt_3_pad_periphs_b_14_pad_TLM2_USART2_TX  ;
    wire    alt_3_pad_periphs_b_15_pad_TLM2_USART2_RX  ;
    wire    alt_3_pad_periphs_b_16_pad_TLM2_USART2_RTS ;
    wire    alt_3_pad_periphs_b_17_pad_TLM2_USART2_CTS ;
    wire    alt_3_pad_periphs_b_18_pad_TLM3_USART3_TX  ;
    wire    alt_3_pad_periphs_b_19_pad_TLM3_USART3_RX  ;
    wire    alt_3_pad_periphs_b_20_pad_TLM3_USART3_RTS ;
    wire    alt_3_pad_periphs_b_21_pad_TLM3_USART3_CTS ;
    wire    alt_3_pad_periphs_b_22_pad_CAN0_SPI8_SCK   ;
    wire    alt_3_pad_periphs_b_23_pad_CAN0_SPI8_CS    ;
    wire    alt_3_pad_periphs_b_24_pad_CAN0_SPI8_MISO  ;
    wire    alt_3_pad_periphs_b_25_pad_CAN0_SPI8_MOSI  ;
    wire    alt_3_pad_periphs_b_26_pad_CAN1_SPI9_SCK   ;
    wire    alt_3_pad_periphs_b_27_pad_CAN1_SPI9_CS    ;
    wire    alt_3_pad_periphs_b_28_pad_CAN1_SPI9_MISO  ;
    wire    alt_3_pad_periphs_b_29_pad_CAN1_SPI9_MOSI  ;
    wire    alt_3_pad_periphs_b_30_pad_USB1_SPI10_SCK  ;
    wire    alt_3_pad_periphs_b_31_pad_USB1_SPI10_CS   ;
    wire    alt_3_pad_periphs_b_32_pad_USB1_SPI10_MISO ;
    wire    alt_3_pad_periphs_b_33_pad_USB1_SPI10_MOSI ;
    wire    alt_3_pad_periphs_b_34_pad_IO_GPIO34       ;
    wire    alt_3_pad_periphs_b_35_pad_IO_GPIO35       ;
    wire    alt_3_pad_periphs_b_36_pad_IO_GPIO36       ;
    wire    alt_3_pad_periphs_b_37_pad_IO_GPIO37       ;
    wire    alt_3_pad_periphs_b_38_pad_IO_GPIO38       ;
    wire    alt_3_pad_periphs_b_39_pad_IO_GPIO39       ;
    wire    alt_3_pad_periphs_b_40_pad_IO_GPIO40       ;
    wire    alt_3_pad_periphs_b_41_pad_IO_GPIO41       ;
    wire    alt_3_pad_periphs_b_42_pad_IO_GPIO42       ;
    wire    alt_3_pad_periphs_b_43_pad_IO_GPIO43       ;
    wire    alt_3_pad_periphs_b_44_pad_IO_GPIO44       ;
    wire    alt_3_pad_periphs_b_45_pad_IO_GPIO45       ;
    wire    alt_3_pad_periphs_b_46_pad_IO_GPIO46       ;
    wire    alt_3_pad_periphs_b_47_pad_IO_GPIO47       ;

    wire    alt_0_simple_pad_periphs_00_spi0_cs   ;
    wire    alt_0_simple_pad_periphs_01_spi0_ck   ;
    wire    alt_0_simple_pad_periphs_02_spi0_so   ;
    wire    alt_0_simple_pad_periphs_03_spi0_si   ;
    wire    alt_0_simple_pad_periphs_04_i2c0_scl  ;
    wire    alt_0_simple_pad_periphs_05_i2c0_sda  ;
    wire    alt_0_simple_pad_periphs_06_uart0_tx  ;
    wire    alt_0_simple_pad_periphs_07_uart0_rx  ;
    wire    alt_0_simple_pad_periphs_08_sdio0_d1  ;
    wire    alt_0_simple_pad_periphs_09_sdio0_d2  ;
    wire    alt_0_simple_pad_periphs_10_sdio0_d3  ;
    wire    alt_0_simple_pad_periphs_11_sdio0_d4  ;
    wire    alt_0_simple_pad_periphs_12_sdio0_clk ;
    wire    alt_0_simple_pad_periphs_13_sdio0_cmd ;
    wire    alt_1_simple_pad_periphs_00_gpio00 ;
    wire    alt_1_simple_pad_periphs_01_gpio01 ;
    wire    alt_1_simple_pad_periphs_02_gpio02 ;
    wire    alt_1_simple_pad_periphs_03_gpio03 ;
    wire    alt_1_simple_pad_periphs_04_gpio04 ;
    wire    alt_1_simple_pad_periphs_05_gpio05 ;
    wire    alt_1_simple_pad_periphs_06_gpio06 ;
    wire    alt_1_simple_pad_periphs_07_gpio07 ;
    wire    alt_1_simple_pad_periphs_08_gpio08 ;
    wire    alt_1_simple_pad_periphs_09_gpio09 ;
    wire    alt_1_simple_pad_periphs_10_gpio10 ;
    wire    alt_1_simple_pad_periphs_11_gpio11 ;
    wire    alt_1_simple_pad_periphs_12_gpio12 ;
    wire    alt_1_simple_pad_periphs_13_gpio13 ;
    //**************************************************
    // PAD VIPs SIGNALS END
    //**************************************************

    //**************************************************
    // PAD VIPs MUX SEL SIGNALS BEGINNING
    //**************************************************
    logic    alt_0_pad_periphs_a_00_pad_mux_sel_CORE_UART_TX    ;
    logic    alt_0_pad_periphs_a_01_pad_mux_sel_CORE_UART_RX    ;
    logic    alt_0_pad_periphs_a_02_pad_mux_sel_SDIO0_D1        ;
    logic    alt_0_pad_periphs_a_03_pad_mux_sel_SDIO0_D2        ;
    logic    alt_0_pad_periphs_a_04_pad_mux_sel_SDIO0_D3        ;
    logic    alt_0_pad_periphs_a_05_pad_mux_sel_SDIO0_D4        ;
    logic    alt_0_pad_periphs_a_06_pad_mux_sel_SDIO0_CLK       ;
    logic    alt_0_pad_periphs_a_07_pad_mux_sel_SDIO0_CMD       ;
    logic    alt_0_pad_periphs_a_08_pad_mux_sel_PWM0_CHANNEL0   ;
    logic    alt_0_pad_periphs_a_09_pad_mux_sel_PWM1_CHANNEL0   ;
    logic    alt_0_pad_periphs_a_10_pad_mux_sel_PWM2_CHANNEL0   ;
    logic    alt_0_pad_periphs_a_11_pad_mux_sel_PWM3_CHANNEL0   ;
    logic    alt_0_pad_periphs_a_12_pad_mux_sel_BARO1_I2C0_SCL  ;
    logic    alt_0_pad_periphs_a_13_pad_mux_sel_BARO1_I2C0_SDA  ;
    logic    alt_0_pad_periphs_a_14_pad_mux_sel_IMU1_SPI0_SCK   ;
    logic    alt_0_pad_periphs_a_15_pad_mux_sel_IMU1_SPI0_CS    ;
    logic    alt_0_pad_periphs_a_16_pad_mux_sel_IMU1_SPI0_MISO  ;
    logic    alt_0_pad_periphs_a_17_pad_mux_sel_IMU1_SPI0_MOSI  ;
    logic    alt_0_pad_periphs_a_18_pad_mux_sel_FRAM_SPI2_SCK   ;
    logic    alt_0_pad_periphs_a_19_pad_mux_sel_FRAM_SPI2_CS    ;
    logic    alt_0_pad_periphs_a_20_pad_mux_sel_FRAM_SPI2_MISO  ;
    logic    alt_0_pad_periphs_a_21_pad_mux_sel_FRAM_SPI2_MOSI  ;
    logic    alt_0_pad_periphs_a_22_pad_mux_sel_ADIO1_SPI3_SCK  ;
    logic    alt_0_pad_periphs_a_23_pad_mux_sel_ADIO1_SPI3_CS   ;
    logic    alt_0_pad_periphs_a_24_pad_mux_sel_ADIO1_SPI3_MISO ;
    logic    alt_0_pad_periphs_a_25_pad_mux_sel_ADIO1_SPI3_MOSI ;
    logic    alt_0_pad_periphs_a_26_pad_mux_sel_GPS2_UART0_TX   ;
    logic    alt_0_pad_periphs_a_27_pad_mux_sel_GPS2_UART0_RX   ;
    logic    alt_0_pad_periphs_a_28_pad_mux_sel_GPS2_I2C1_SCL   ;
    logic    alt_0_pad_periphs_a_29_pad_mux_sel_GPS2_I2C1_SDA   ;
    logic    alt_1_pad_periphs_a_00_pad_mux_sel_CORE_UART_TX    ;
    logic    alt_1_pad_periphs_a_01_pad_mux_sel_CORE_UART_RX    ;
    logic    alt_1_pad_periphs_a_02_pad_mux_sel_LINUX_QSPI_SCK  ;
    logic    alt_1_pad_periphs_a_03_pad_mux_sel_LINUX_QSPI_CSN  ;
    logic    alt_1_pad_periphs_a_04_pad_mux_sel_LINUX_QSPI_IO0  ;
    logic    alt_1_pad_periphs_a_05_pad_mux_sel_LINUX_QSPI_IO1  ;
    logic    alt_1_pad_periphs_a_06_pad_mux_sel_LINUX_QSPI_IO2  ;
    logic    alt_1_pad_periphs_a_07_pad_mux_sel_LINUX_QSPI_IO3  ;
    logic    alt_1_pad_periphs_a_08_pad_mux_sel_BARO1_I2C0_SCL  ;
    logic    alt_1_pad_periphs_a_09_pad_mux_sel_BARO1_I2C0_SDA  ;
    logic    alt_1_pad_periphs_a_10_pad_mux_sel_PWM0_CHANNEL0   ;
    logic    alt_1_pad_periphs_a_11_pad_mux_sel_PWM1_CHANNEL0   ;
    logic    alt_1_pad_periphs_a_12_pad_mux_sel_PWM2_CHANNEL0   ;
    logic    alt_1_pad_periphs_a_13_pad_mux_sel_PWM3_CHANNEL0   ;
    logic    alt_1_pad_periphs_a_14_pad_mux_sel_GPS1_UART2_TX   ;
    logic    alt_1_pad_periphs_a_15_pad_mux_sel_GPS1_UART2_RX   ;
    logic    alt_1_pad_periphs_a_16_pad_mux_sel_GPS1_I2C5_SCL   ;
    logic    alt_1_pad_periphs_a_17_pad_mux_sel_GPS1_I2C5_SDA   ;
    logic    alt_1_pad_periphs_a_18_pad_mux_sel_CAM0_CPI0_CLK   ;
    logic    alt_1_pad_periphs_a_19_pad_mux_sel_CAM0_CPI0_VSYNC ;
    logic    alt_1_pad_periphs_a_20_pad_mux_sel_CAM0_CPI0_HSYNC ;
    logic    alt_1_pad_periphs_a_21_pad_mux_sel_CAM0_CPI0_DAT0  ;
    logic    alt_1_pad_periphs_a_22_pad_mux_sel_CAM0_CPI0_DAT1  ;
    logic    alt_1_pad_periphs_a_23_pad_mux_sel_CAM0_CPI0_DAT2  ;
    logic    alt_1_pad_periphs_a_24_pad_mux_sel_CAM0_CPI0_DAT3  ;
    logic    alt_1_pad_periphs_a_25_pad_mux_sel_CAM0_CPI0_DAT4  ;
    logic    alt_1_pad_periphs_a_26_pad_mux_sel_CAM0_CPI0_DAT5  ;
    logic    alt_1_pad_periphs_a_27_pad_mux_sel_CAM0_CPI0_DAT6  ;
    logic    alt_1_pad_periphs_a_28_pad_mux_sel_CAM0_CPI0_DAT7  ;
    logic    alt_1_pad_periphs_a_29_pad_mux_sel_FLL_SOC         ;
    logic    alt_2_pad_periphs_a_00_pad_mux_sel_CAN0_TX            ;
    logic    alt_2_pad_periphs_a_01_pad_mux_sel_CAN0_RX            ;
    logic    alt_2_pad_periphs_a_02_pad_mux_sel_CAN1_TX            ;
    logic    alt_2_pad_periphs_a_03_pad_mux_sel_CAN1_RX            ;
    logic    alt_2_pad_periphs_a_04_pad_mux_sel_FLL_SOC            ;
    logic    alt_2_pad_periphs_a_05_pad_mux_sel_IO_USART1_TX       ;
    logic    alt_2_pad_periphs_a_06_pad_mux_sel_IO_USART1_RX       ;
    logic    alt_2_pad_periphs_a_07_pad_mux_sel_IO_USART1_RTS      ;
    logic    alt_2_pad_periphs_a_08_pad_mux_sel_IO_USART1_CTS      ;
    logic    alt_2_pad_periphs_a_09_pad_mux_sel_WIRELESS_SDIO1_D0  ;
    logic    alt_2_pad_periphs_a_10_pad_mux_sel_WIRELESS_SDIO1_D1  ;
    logic    alt_2_pad_periphs_a_11_pad_mux_sel_WIRELESS_SDIO1_D2  ;
    logic    alt_2_pad_periphs_a_12_pad_mux_sel_WIRELESS_SDIO1_D3  ;
    logic    alt_2_pad_periphs_a_13_pad_mux_sel_WIRELESS_SDIO1_CLK ;
    logic    alt_2_pad_periphs_a_14_pad_mux_sel_WIRELESS_SDIO1_CMD ;
    logic    alt_2_pad_periphs_a_15_pad_mux_sel_ETH_RST            ;
    logic    alt_2_pad_periphs_a_16_pad_mux_sel_ETH_RXCK           ;
    logic    alt_2_pad_periphs_a_17_pad_mux_sel_ETH_RXCTL          ;
    logic    alt_2_pad_periphs_a_18_pad_mux_sel_ETH_RXD0           ;
    logic    alt_2_pad_periphs_a_19_pad_mux_sel_ETH_RXD1           ;
    logic    alt_2_pad_periphs_a_20_pad_mux_sel_ETH_RXD2           ;
    logic    alt_2_pad_periphs_a_21_pad_mux_sel_ETH_RXD3           ;
    logic    alt_2_pad_periphs_a_22_pad_mux_sel_ETH_TXCK           ;
    logic    alt_2_pad_periphs_a_23_pad_mux_sel_ETH_TXCTL          ;
    logic    alt_2_pad_periphs_a_24_pad_mux_sel_ETH_TXD0           ;
    logic    alt_2_pad_periphs_a_25_pad_mux_sel_ETH_TXD1           ;
    logic    alt_2_pad_periphs_a_26_pad_mux_sel_ETH_TXD2           ;
    logic    alt_2_pad_periphs_a_27_pad_mux_sel_ETH_TXD3           ;
    logic    alt_2_pad_periphs_a_28_pad_mux_sel_ETH_MDIO           ;
    logic    alt_2_pad_periphs_a_29_pad_mux_sel_ETH_MDC            ;
    logic    alt_3_pad_periphs_a_00_pad_mux_sel_IO_GPIO00 ;
    logic    alt_3_pad_periphs_a_01_pad_mux_sel_IO_GPIO01 ;
    logic    alt_3_pad_periphs_a_02_pad_mux_sel_IO_GPIO02 ;
    logic    alt_3_pad_periphs_a_03_pad_mux_sel_IO_GPIO03 ;
    logic    alt_3_pad_periphs_a_04_pad_mux_sel_IO_GPIO04 ;
    logic    alt_3_pad_periphs_a_05_pad_mux_sel_IO_GPIO05 ;
    logic    alt_3_pad_periphs_a_06_pad_mux_sel_IO_GPIO06 ;
    logic    alt_3_pad_periphs_a_07_pad_mux_sel_IO_GPIO07 ;
    logic    alt_3_pad_periphs_a_08_pad_mux_sel_IO_GPIO08 ;
    logic    alt_3_pad_periphs_a_09_pad_mux_sel_IO_GPIO09 ;
    logic    alt_3_pad_periphs_a_10_pad_mux_sel_IO_GPIO10 ;
    logic    alt_3_pad_periphs_a_11_pad_mux_sel_IO_GPIO11 ;
    logic    alt_3_pad_periphs_a_12_pad_mux_sel_IO_GPIO12 ;
    logic    alt_3_pad_periphs_a_13_pad_mux_sel_IO_GPIO13 ;
    logic    alt_3_pad_periphs_a_14_pad_mux_sel_IO_GPIO14 ;
    logic    alt_3_pad_periphs_a_15_pad_mux_sel_IO_GPIO15 ;
    logic    alt_3_pad_periphs_a_16_pad_mux_sel_IO_GPIO16 ;
    logic    alt_3_pad_periphs_a_17_pad_mux_sel_IO_GPIO17 ;
    logic    alt_3_pad_periphs_a_18_pad_mux_sel_IO_GPIO18 ;
    logic    alt_3_pad_periphs_a_19_pad_mux_sel_IO_GPIO19 ;
    logic    alt_3_pad_periphs_a_20_pad_mux_sel_IO_GPIO20 ;
    logic    alt_3_pad_periphs_a_21_pad_mux_sel_IO_GPIO21 ;
    logic    alt_3_pad_periphs_a_22_pad_mux_sel_IO_GPIO22 ;
    logic    alt_3_pad_periphs_a_23_pad_mux_sel_IO_GPIO23 ;
    logic    alt_3_pad_periphs_a_24_pad_mux_sel_IO_GPIO24 ;
    logic    alt_3_pad_periphs_a_25_pad_mux_sel_IO_GPIO25 ;
    logic    alt_3_pad_periphs_a_26_pad_mux_sel_IO_GPIO26 ;
    logic    alt_3_pad_periphs_a_27_pad_mux_sel_IO_GPIO27 ;
    logic    alt_3_pad_periphs_a_28_pad_mux_sel_IO_GPIO28 ;
    logic    alt_3_pad_periphs_a_29_pad_mux_sel_IO_GPIO29 ;

    logic    alt_0_pad_periphs_b_00_pad_mux_sel_TLM1_USART0_TX  ;
    logic    alt_0_pad_periphs_b_01_pad_mux_sel_TLM1_USART0_RX  ;
    logic    alt_0_pad_periphs_b_02_pad_mux_sel_TLM1_USART0_RTS ;
    logic    alt_0_pad_periphs_b_03_pad_mux_sel_TLM1_USART0_CTS ;
    logic    alt_0_pad_periphs_b_04_pad_mux_sel_ADC0_SPI4_SCK   ;
    logic    alt_0_pad_periphs_b_05_pad_mux_sel_ADC0_SPI4_CS    ;
    logic    alt_0_pad_periphs_b_06_pad_mux_sel_ADC0_SPI4_MISO  ;
    logic    alt_0_pad_periphs_b_07_pad_mux_sel_ADC0_SPI4_MOSI  ;
    logic    alt_0_pad_periphs_b_08_pad_mux_sel_PMIC_I2C2_SCL   ;
    logic    alt_0_pad_periphs_b_09_pad_mux_sel_PMIC_I2C2_SDA   ;
    logic    alt_0_pad_periphs_b_10_pad_mux_sel_EXT1_SPI7_SCK   ;
    logic    alt_0_pad_periphs_b_11_pad_mux_sel_EXT1_SPI7_MISO  ;
    logic    alt_0_pad_periphs_b_12_pad_mux_sel_EXT1_SPI7_MOSI  ;
    logic    alt_0_pad_periphs_b_13_pad_mux_sel_EXT1_SPI7_CS0   ;
    logic    alt_0_pad_periphs_b_14_pad_mux_sel_EXT1_SPI7_CS1   ;
    logic    alt_0_pad_periphs_b_15_pad_mux_sel_EXT2_I2C4_SCL   ;
    logic    alt_0_pad_periphs_b_16_pad_mux_sel_EXT2_I2C4_SDA   ;
    logic    alt_0_pad_periphs_b_17_pad_mux_sel_EXT3_UART1_TX   ;
    logic    alt_0_pad_periphs_b_18_pad_mux_sel_EXT3_UART1_RX   ;
    logic    alt_0_pad_periphs_b_19_pad_mux_sel_IO_USART1_TX    ;
    logic    alt_0_pad_periphs_b_20_pad_mux_sel_IO_USART1_RX    ;
    logic    alt_0_pad_periphs_b_21_pad_mux_sel_IO_USART1_RTS   ;
    logic    alt_0_pad_periphs_b_22_pad_mux_sel_IO_USART1_CTS   ;
    logic    alt_0_pad_periphs_b_23_pad_mux_sel_ETH_RST         ;
    logic    alt_0_pad_periphs_b_24_pad_mux_sel_ETH_RXCK        ;
    logic    alt_0_pad_periphs_b_25_pad_mux_sel_ETH_RXCTL       ;
    logic    alt_0_pad_periphs_b_26_pad_mux_sel_ETH_RXD0        ;
    logic    alt_0_pad_periphs_b_27_pad_mux_sel_ETH_RXD1        ;
    logic    alt_0_pad_periphs_b_28_pad_mux_sel_ETH_RXD2        ;
    logic    alt_0_pad_periphs_b_29_pad_mux_sel_ETH_RXD3        ;
    logic    alt_0_pad_periphs_b_30_pad_mux_sel_ETH_TXCK        ;
    logic    alt_0_pad_periphs_b_31_pad_mux_sel_ETH_TXCTL       ;
    logic    alt_0_pad_periphs_b_32_pad_mux_sel_ETH_TXD0        ;
    logic    alt_0_pad_periphs_b_33_pad_mux_sel_ETH_TXD1        ;
    logic    alt_0_pad_periphs_b_34_pad_mux_sel_ETH_TXD2        ;
    logic    alt_0_pad_periphs_b_35_pad_mux_sel_ETH_TXD3        ;
    logic    alt_0_pad_periphs_b_36_pad_mux_sel_ETH_MDIO        ;
    logic    alt_0_pad_periphs_b_37_pad_mux_sel_ETH_MDC         ;
    logic    alt_0_pad_periphs_b_38_pad_mux_sel_USB1_SPI10_SCK  ;
    logic    alt_0_pad_periphs_b_39_pad_mux_sel_USB1_SPI10_CS   ;
    logic    alt_0_pad_periphs_b_40_pad_mux_sel_USB1_SPI10_MISO ;
    logic    alt_0_pad_periphs_b_41_pad_mux_sel_USB1_SPI10_MOSI ;
    logic    alt_0_pad_periphs_b_42_pad_mux_sel_CAN0_TX         ;
    logic    alt_0_pad_periphs_b_43_pad_mux_sel_CAN0_RX         ;
    logic    alt_0_pad_periphs_b_44_pad_mux_sel_PWM0_CHANNEL1   ;
    logic    alt_0_pad_periphs_b_45_pad_mux_sel_PWM1_CHANNEL1   ;
    logic    alt_0_pad_periphs_b_46_pad_mux_sel_PWM2_CHANNEL1   ;
    logic    alt_0_pad_periphs_b_47_pad_mux_sel_PWM3_CHANNEL1   ;
    logic    alt_1_pad_periphs_b_00_pad_mux_sel_WIRELESS_SDIO1_D0  ;
    logic    alt_1_pad_periphs_b_01_pad_mux_sel_WIRELESS_SDIO1_D1  ;
    logic    alt_1_pad_periphs_b_02_pad_mux_sel_WIRELESS_SDIO1_D2  ;
    logic    alt_1_pad_periphs_b_03_pad_mux_sel_WIRELESS_SDIO1_D3  ;
    logic    alt_1_pad_periphs_b_04_pad_mux_sel_WIRELESS_SDIO1_CLK ;
    logic    alt_1_pad_periphs_b_05_pad_mux_sel_WIRELESS_SDIO1_CMD ;
    logic    alt_1_pad_periphs_b_06_pad_mux_sel_IMU1_SPI0_SCK      ;
    logic    alt_1_pad_periphs_b_07_pad_mux_sel_IMU1_SPI0_CS       ;
    logic    alt_1_pad_periphs_b_08_pad_mux_sel_IMU1_SPI0_MISO     ;
    logic    alt_1_pad_periphs_b_09_pad_mux_sel_IMU1_SPI0_MOSI     ;
    logic    alt_1_pad_periphs_b_10_pad_mux_sel_TLM1_USART0_TX     ;
    logic    alt_1_pad_periphs_b_11_pad_mux_sel_TLM1_USART0_RX     ;
    logic    alt_1_pad_periphs_b_12_pad_mux_sel_TLM1_USART0_RTS    ;
    logic    alt_1_pad_periphs_b_13_pad_mux_sel_TLM1_USART0_CTS    ;
    logic    alt_1_pad_periphs_b_14_pad_mux_sel_ADC0_SPI4_SCK      ;
    logic    alt_1_pad_periphs_b_15_pad_mux_sel_ADC0_SPI4_CS       ;
    logic    alt_1_pad_periphs_b_16_pad_mux_sel_ADC0_SPI4_MISO     ;
    logic    alt_1_pad_periphs_b_17_pad_mux_sel_ADC0_SPI4_MOSI     ;
    logic    alt_1_pad_periphs_b_18_pad_mux_sel_FRAM_SPI2_SCK      ;
    logic    alt_1_pad_periphs_b_19_pad_mux_sel_FRAM_SPI2_CS       ;
    logic    alt_1_pad_periphs_b_20_pad_mux_sel_FRAM_SPI2_MISO     ;
    logic    alt_1_pad_periphs_b_21_pad_mux_sel_FRAM_SPI2_MOSI     ;
    logic    alt_1_pad_periphs_b_22_pad_mux_sel_ADIO1_SPI3_SCK     ;
    logic    alt_1_pad_periphs_b_23_pad_mux_sel_ADIO1_SPI3_CS      ;
    logic    alt_1_pad_periphs_b_24_pad_mux_sel_ADIO1_SPI3_MISO    ;
    logic    alt_1_pad_periphs_b_25_pad_mux_sel_ADIO1_SPI3_MOSI    ;
    logic    alt_1_pad_periphs_b_26_pad_mux_sel_MAG_SPI1_SCK       ;
    logic    alt_1_pad_periphs_b_27_pad_mux_sel_MAG_SPI1_CS        ;
    logic    alt_1_pad_periphs_b_28_pad_mux_sel_MAG_SPI1_MISO      ;
    logic    alt_1_pad_periphs_b_29_pad_mux_sel_MAG_SPI1_MOSI      ;
    logic    alt_1_pad_periphs_b_30_pad_mux_sel_CAN1_TX            ;
    logic    alt_1_pad_periphs_b_31_pad_mux_sel_CAN1_RX            ;
    logic    alt_1_pad_periphs_b_32_pad_mux_sel_PWM0_CHANNEL1      ;
    logic    alt_1_pad_periphs_b_33_pad_mux_sel_PWM1_CHANNEL1      ;
    logic    alt_1_pad_periphs_b_34_pad_mux_sel_PWM2_CHANNEL1      ;
    logic    alt_1_pad_periphs_b_35_pad_mux_sel_PWM3_CHANNEL1      ;
    logic    alt_1_pad_periphs_b_36_pad_mux_sel_CAM1_CPI1_CLK      ;
    logic    alt_1_pad_periphs_b_37_pad_mux_sel_CAM1_CPI1_VSYNC    ;
    logic    alt_1_pad_periphs_b_38_pad_mux_sel_CAM1_CPI1_HSYNC    ;
    logic    alt_1_pad_periphs_b_39_pad_mux_sel_CAM1_CPI1_DAT0     ;
    logic    alt_1_pad_periphs_b_40_pad_mux_sel_CAM1_CPI1_DAT1     ;
    logic    alt_1_pad_periphs_b_41_pad_mux_sel_CAM1_CPI1_DAT2     ;
    logic    alt_1_pad_periphs_b_42_pad_mux_sel_CAM1_CPI1_DAT3     ;
    logic    alt_1_pad_periphs_b_43_pad_mux_sel_CAM1_CPI1_DAT4     ;
    logic    alt_1_pad_periphs_b_44_pad_mux_sel_CAM1_CPI1_DAT5     ;
    logic    alt_1_pad_periphs_b_45_pad_mux_sel_CAM1_CPI1_DAT6     ;
    logic    alt_1_pad_periphs_b_46_pad_mux_sel_CAM1_CPI1_DAT7     ;
    logic    alt_1_pad_periphs_b_47_pad_mux_sel_FLL_CVA6           ;
    logic    alt_2_pad_periphs_b_00_pad_mux_sel_IO_GPIO00 ;
    logic    alt_2_pad_periphs_b_01_pad_mux_sel_IO_GPIO01 ;
    logic    alt_2_pad_periphs_b_02_pad_mux_sel_IO_GPIO02 ;
    logic    alt_2_pad_periphs_b_03_pad_mux_sel_IO_GPIO03 ;
    logic    alt_2_pad_periphs_b_04_pad_mux_sel_IO_GPIO04 ;
    logic    alt_2_pad_periphs_b_05_pad_mux_sel_IO_GPIO05 ;
    logic    alt_2_pad_periphs_b_06_pad_mux_sel_IO_GPIO06 ;
    logic    alt_2_pad_periphs_b_07_pad_mux_sel_IO_GPIO07 ;
    logic    alt_2_pad_periphs_b_08_pad_mux_sel_IO_GPIO08 ;
    logic    alt_2_pad_periphs_b_09_pad_mux_sel_IO_GPIO09 ;
    logic    alt_2_pad_periphs_b_10_pad_mux_sel_IO_GPIO10 ;
    logic    alt_2_pad_periphs_b_11_pad_mux_sel_IO_GPIO11 ;
    logic    alt_2_pad_periphs_b_12_pad_mux_sel_IO_GPIO12 ;
    logic    alt_2_pad_periphs_b_13_pad_mux_sel_IO_GPIO13 ;
    logic    alt_2_pad_periphs_b_14_pad_mux_sel_IO_GPIO14 ;
    logic    alt_2_pad_periphs_b_15_pad_mux_sel_IO_GPIO15 ;
    logic    alt_2_pad_periphs_b_16_pad_mux_sel_IO_GPIO16 ;
    logic    alt_2_pad_periphs_b_17_pad_mux_sel_IO_GPIO17 ;
    logic    alt_2_pad_periphs_b_18_pad_mux_sel_IO_GPIO18 ;
    logic    alt_2_pad_periphs_b_19_pad_mux_sel_IO_GPIO19 ;
    logic    alt_2_pad_periphs_b_20_pad_mux_sel_IO_GPIO20 ;
    logic    alt_2_pad_periphs_b_21_pad_mux_sel_IO_GPIO21 ;
    logic    alt_2_pad_periphs_b_22_pad_mux_sel_IO_GPIO22 ;
    logic    alt_2_pad_periphs_b_23_pad_mux_sel_IO_GPIO23 ;
    logic    alt_2_pad_periphs_b_24_pad_mux_sel_IO_GPIO24 ;
    logic    alt_2_pad_periphs_b_25_pad_mux_sel_IO_GPIO25 ;
    logic    alt_2_pad_periphs_b_26_pad_mux_sel_IO_GPIO26 ;
    logic    alt_2_pad_periphs_b_27_pad_mux_sel_IO_GPIO27 ;
    logic    alt_2_pad_periphs_b_28_pad_mux_sel_IO_GPIO28 ;
    logic    alt_2_pad_periphs_b_29_pad_mux_sel_IO_GPIO29 ;
    logic    alt_2_pad_periphs_b_30_pad_mux_sel_IO_GPIO30 ;
    logic    alt_2_pad_periphs_b_31_pad_mux_sel_IO_GPIO31 ;
    logic    alt_2_pad_periphs_b_32_pad_mux_sel_IO_GPIO32 ;
    logic    alt_2_pad_periphs_b_33_pad_mux_sel_IO_GPIO33 ;
    logic    alt_2_pad_periphs_b_34_pad_mux_sel_IO_GPIO34 ;
    logic    alt_2_pad_periphs_b_35_pad_mux_sel_IO_GPIO35 ;
    logic    alt_2_pad_periphs_b_36_pad_mux_sel_IO_GPIO36 ;
    logic    alt_2_pad_periphs_b_37_pad_mux_sel_IO_GPIO37 ;
    logic    alt_2_pad_periphs_b_38_pad_mux_sel_IO_GPIO38 ;
    logic    alt_2_pad_periphs_b_39_pad_mux_sel_IO_GPIO39 ;
    logic    alt_2_pad_periphs_b_40_pad_mux_sel_IO_GPIO40 ;
    logic    alt_2_pad_periphs_b_41_pad_mux_sel_IO_GPIO41 ;
    logic    alt_2_pad_periphs_b_42_pad_mux_sel_IO_GPIO42 ;
    logic    alt_2_pad_periphs_b_43_pad_mux_sel_IO_GPIO43 ;
    logic    alt_2_pad_periphs_b_44_pad_mux_sel_IO_GPIO44 ;
    logic    alt_2_pad_periphs_b_45_pad_mux_sel_IO_GPIO45 ;
    logic    alt_2_pad_periphs_b_46_pad_mux_sel_IO_GPIO46 ;
    logic    alt_2_pad_periphs_b_47_pad_mux_sel_IO_GPIO47 ;
    logic    alt_3_pad_periphs_b_00_pad_mux_sel_GPS2_UART0_TX   ;
    logic    alt_3_pad_periphs_b_01_pad_mux_sel_GPS2_UART0_RX   ;
    logic    alt_3_pad_periphs_b_02_pad_mux_sel_GPS2_I2C1_SCL   ;
    logic    alt_3_pad_periphs_b_03_pad_mux_sel_GPS2_I2C1_SDA   ;
    logic    alt_3_pad_periphs_b_04_pad_mux_sel_IMU2_SPI5_SCK   ;
    logic    alt_3_pad_periphs_b_05_pad_mux_sel_IMU2_SPI5_CS    ;
    logic    alt_3_pad_periphs_b_06_pad_mux_sel_IMU2_SPI5_MISO  ;
    logic    alt_3_pad_periphs_b_07_pad_mux_sel_IMU2_SPI5_MOSI  ;
    logic    alt_3_pad_periphs_b_08_pad_mux_sel_BARO2_I2C3_SCL  ;
    logic    alt_3_pad_periphs_b_09_pad_mux_sel_BARO2_I2C3_SDA  ;
    logic    alt_3_pad_periphs_b_10_pad_mux_sel_IMU3_SPI6_SCK   ;
    logic    alt_3_pad_periphs_b_11_pad_mux_sel_IMU3_SPI6_CS    ;
    logic    alt_3_pad_periphs_b_12_pad_mux_sel_IMU3_SPI6_MISO  ;
    logic    alt_3_pad_periphs_b_13_pad_mux_sel_IMU3_SPI6_MOSI  ;
    logic    alt_3_pad_periphs_b_14_pad_mux_sel_TLM2_USART2_TX  ;
    logic    alt_3_pad_periphs_b_15_pad_mux_sel_TLM2_USART2_RX  ;
    logic    alt_3_pad_periphs_b_16_pad_mux_sel_TLM2_USART2_RTS ;
    logic    alt_3_pad_periphs_b_17_pad_mux_sel_TLM2_USART2_CTS ;
    logic    alt_3_pad_periphs_b_18_pad_mux_sel_TLM3_USART3_TX  ;
    logic    alt_3_pad_periphs_b_19_pad_mux_sel_TLM3_USART3_RX  ;
    logic    alt_3_pad_periphs_b_20_pad_mux_sel_TLM3_USART3_RTS ;
    logic    alt_3_pad_periphs_b_21_pad_mux_sel_TLM3_USART3_CTS ;
    logic    alt_3_pad_periphs_b_22_pad_mux_sel_CAN0_SPI8_SCK   ;
    logic    alt_3_pad_periphs_b_23_pad_mux_sel_CAN0_SPI8_CS    ;
    logic    alt_3_pad_periphs_b_24_pad_mux_sel_CAN0_SPI8_MISO  ;
    logic    alt_3_pad_periphs_b_25_pad_mux_sel_CAN0_SPI8_MOSI  ;
    logic    alt_3_pad_periphs_b_26_pad_mux_sel_CAN1_SPI9_SCK   ;
    logic    alt_3_pad_periphs_b_27_pad_mux_sel_CAN1_SPI9_CS    ;
    logic    alt_3_pad_periphs_b_28_pad_mux_sel_CAN1_SPI9_MISO  ;
    logic    alt_3_pad_periphs_b_29_pad_mux_sel_CAN1_SPI9_MOSI  ;
    logic    alt_3_pad_periphs_b_30_pad_mux_sel_USB1_SPI10_SCK  ;
    logic    alt_3_pad_periphs_b_31_pad_mux_sel_USB1_SPI10_CS   ;
    logic    alt_3_pad_periphs_b_32_pad_mux_sel_USB1_SPI10_MISO ;
    logic    alt_3_pad_periphs_b_33_pad_mux_sel_USB1_SPI10_MOSI ;
    logic    alt_3_pad_periphs_b_34_pad_mux_sel_IO_GPIO34       ;
    logic    alt_3_pad_periphs_b_35_pad_mux_sel_IO_GPIO35       ;
    logic    alt_3_pad_periphs_b_36_pad_mux_sel_IO_GPIO36       ;
    logic    alt_3_pad_periphs_b_37_pad_mux_sel_IO_GPIO37       ;
    logic    alt_3_pad_periphs_b_38_pad_mux_sel_IO_GPIO38       ;
    logic    alt_3_pad_periphs_b_39_pad_mux_sel_IO_GPIO39       ;
    logic    alt_3_pad_periphs_b_40_pad_mux_sel_IO_GPIO40       ;
    logic    alt_3_pad_periphs_b_41_pad_mux_sel_IO_GPIO41       ;
    logic    alt_3_pad_periphs_b_42_pad_mux_sel_IO_GPIO42       ;
    logic    alt_3_pad_periphs_b_43_pad_mux_sel_IO_GPIO43       ;
    logic    alt_3_pad_periphs_b_44_pad_mux_sel_IO_GPIO44       ;
    logic    alt_3_pad_periphs_b_45_pad_mux_sel_IO_GPIO45       ;
    logic    alt_3_pad_periphs_b_46_pad_mux_sel_IO_GPIO46       ;
    logic    alt_3_pad_periphs_b_47_pad_mux_sel_IO_GPIO47       ;

    logic    alt_0_simple_pad_periphs_00_mux_sel_spi0_cs   ;
    logic    alt_0_simple_pad_periphs_01_mux_sel_spi0_ck   ;
    logic    alt_0_simple_pad_periphs_02_mux_sel_spi0_so   ;
    logic    alt_0_simple_pad_periphs_03_mux_sel_spi0_si   ;
    logic    alt_0_simple_pad_periphs_04_mux_sel_i2c0_scl  ;
    logic    alt_0_simple_pad_periphs_05_mux_sel_i2c0_sda  ;
    logic    alt_0_simple_pad_periphs_06_mux_sel_uart0_tx  ;
    logic    alt_0_simple_pad_periphs_07_mux_sel_uart0_rx  ;
    logic    alt_0_simple_pad_periphs_08_mux_sel_sdio0_d1  ;
    logic    alt_0_simple_pad_periphs_09_mux_sel_sdio0_d2  ;
    logic    alt_0_simple_pad_periphs_10_mux_sel_sdio0_d3  ;
    logic    alt_0_simple_pad_periphs_11_mux_sel_sdio0_d4  ;
    logic    alt_0_simple_pad_periphs_12_mux_sel_sdio0_clk ;
    logic    alt_0_simple_pad_periphs_13_mux_sel_sdio0_cmd ;
    logic    alt_1_simple_pad_periphs_00_mux_sel_gpio00 ;
    logic    alt_1_simple_pad_periphs_01_mux_sel_gpio01 ;
    logic    alt_1_simple_pad_periphs_02_mux_sel_gpio02 ;
    logic    alt_1_simple_pad_periphs_03_mux_sel_gpio03 ;
    logic    alt_1_simple_pad_periphs_04_mux_sel_gpio04 ;
    logic    alt_1_simple_pad_periphs_05_mux_sel_gpio05 ;
    logic    alt_1_simple_pad_periphs_06_mux_sel_gpio06 ;
    logic    alt_1_simple_pad_periphs_07_mux_sel_gpio07 ;
    logic    alt_1_simple_pad_periphs_08_mux_sel_gpio08 ;
    logic    alt_1_simple_pad_periphs_09_mux_sel_gpio09 ;
    logic    alt_1_simple_pad_periphs_10_mux_sel_gpio10 ;
    logic    alt_1_simple_pad_periphs_11_mux_sel_gpio11 ;
    logic    alt_1_simple_pad_periphs_12_mux_sel_gpio12 ;
    logic    alt_1_simple_pad_periphs_13_mux_sel_gpio13 ;
    //**************************************************
    // PAD VIPs MUX SEL SIGNALS END
    //**************************************************

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
    `ifndef TARGET_POST_SYNTH_SIM_TOP #(
        .NUM_WORDS         ( NUM_WORDS                   ),
        .InclSimDTM        ( 1'b1                        ),
        .StallRandomOutput ( 1'b1                        ),
        .StallRandomInput  ( 1'b1                        ),
        .JtagEnable        ( jtag_enable[0] | LOCAL_JTAG )
    ) `endif dut (
        .rst_ni               ( s_rst_ni               ),
        .rtc_i                ( s_rtc_i                ),
        .bypass_clk_i         ( s_bypass               ),
        `ifndef TARGET_POST_SYNTH_SIM_TOP
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

          .jtag_ot_TCK          ( s_jtag2ot_tck          ),
          .jtag_ot_TMS          ( s_jtag2ot_tms          ),
          .jtag_ot_TDI          ( s_jtag2ot_tdi          ),
          .jtag_ot_TRSTn        ( s_jtag2ot_trstn        ),
          .jtag_ot_TDO_data     ( s_jtag2ot_tdo          ),

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

               .pad_periphs_ot_spi_00_pad(pad_periphs_ot_spi_00_pad),
               .pad_periphs_ot_spi_01_pad(pad_periphs_ot_spi_01_pad),
               .pad_periphs_ot_spi_02_pad(pad_periphs_ot_spi_02_pad),
               .pad_periphs_ot_spi_03_pad(pad_periphs_ot_spi_03_pad),

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
  // VIPs BEGINNING
  //**************************************************
  generate
    `ifndef FPGA_EMUL
      `ifndef SIMPLE_PADFRAME
        //**************************************************
        // ALTERNAME 0 - STANDARD QFN VIPs BEGINNING
        //**************************************************
        if (USE_UART == 1) begin
          // config the CORE_UART pads
          assign alt_0_pad_periphs_a_01_pad_CORE_UART_RX = alt_0_pad_periphs_a_00_pad_CORE_UART_TX;
          // config the UART0 pads
          assign alt_0_pad_periphs_a_27_pad_GPS2_UART0_RX = alt_0_pad_periphs_a_26_pad_GPS2_UART0_TX;
        end

        if(USE_SDIO == 1) begin
          // configure the SDIO0 pads
          sdModel alt_0_sdModelTB0(
          .sdClk ( alt_0_pad_periphs_a_06_pad_SDIO0_CLK ),
          .cmd   ( alt_0_pad_periphs_a_07_pad_SDIO0_CMD ),
          .dat   ( {
                    alt_0_pad_periphs_a_05_pad_SDIO0_D4,
                    alt_0_pad_periphs_a_04_pad_SDIO0_D3,
                    alt_0_pad_periphs_a_03_pad_SDIO0_D2,
                    alt_0_pad_periphs_a_02_pad_SDIO0_D1
                  } )
          );
        end

        if (USE_24FC1025_MODEL == 1) begin
          // configure the I2C0 pads
          pullup alt_0_sda0_pullup_i (alt_0_pad_periphs_a_13_pad_BARO1_I2C0_SDA);
          pullup alt_0_scl0_pullup_i (alt_0_pad_periphs_a_12_pad_BARO1_I2C0_SCL);
            M24FC1025 alt_0_i_i2c_mem_0 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_0_pad_periphs_a_13_pad_BARO1_I2C0_SDA ),
              .SCL   ( alt_0_pad_periphs_a_12_pad_BARO1_I2C0_SCL ),
              .RESET ( 1'b0       )
          );
          // configure the I2C1 pads
          pullup alt_0_sda1_pullup_i (alt_0_pad_periphs_a_29_pad_GPS2_I2C1_SDA);
          pullup alt_0_scl1_pullup_i (alt_0_pad_periphs_a_28_pad_GPS2_I2C1_SCL);
            M24FC1025 alt_0_i_i2c_mem_1 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_0_pad_periphs_a_29_pad_GPS2_I2C1_SDA ),
              .SCL   ( alt_0_pad_periphs_a_28_pad_GPS2_I2C1_SCL ),
              .RESET ( 1'b0       )
          );
        end

        if(USE_S25FS256S_MODEL == 1) begin
          // configure the SPI0 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_0_i_spi_flash_csn0 (
            .SI       ( alt_0_pad_periphs_a_17_pad_IMU1_SPI0_MOSI ),
            .SO       ( alt_0_pad_periphs_a_16_pad_IMU1_SPI0_MISO ),
            .SCK      ( alt_0_pad_periphs_a_14_pad_IMU1_SPI0_SCK  ),
            .CSNeg    ( alt_0_pad_periphs_a_15_pad_IMU1_SPI0_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI2 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_0_i_spi_flash_csn2 (
            .SI       ( alt_0_pad_periphs_a_21_pad_FRAM_SPI2_MOSI ),
            .SO       ( alt_0_pad_periphs_a_20_pad_FRAM_SPI2_MISO ),
            .SCK      ( alt_0_pad_periphs_a_18_pad_FRAM_SPI2_SCK  ),
            .CSNeg    ( alt_0_pad_periphs_a_19_pad_FRAM_SPI2_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI3 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_0_i_spi_flash_csn3 (
            .SI       ( alt_0_pad_periphs_a_25_pad_ADIO1_SPI3_MOSI ),
            .SO       ( alt_0_pad_periphs_a_24_pad_ADIO1_SPI3_MISO ),
            .SCK      ( alt_0_pad_periphs_a_22_pad_ADIO1_SPI3_SCK  ),
            .CSNeg    ( alt_0_pad_periphs_a_23_pad_ADIO1_SPI3_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
        end
        //**************************************************
        // ALTERNAME 0 - STANDARD QFN VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 0 - STANDARD CPGA VIPs BEGINNING
        //**************************************************
        if(USE_USART == 1) begin
          // config the USART0 pads
          assign alt_0_pad_periphs_b_01_pad_TLM1_USART0_RX  = alt_0_pad_periphs_b_00_pad_TLM1_USART0_TX;
          assign alt_0_pad_periphs_b_03_pad_TLM1_USART0_CTS = alt_0_pad_periphs_b_02_pad_TLM1_USART0_RTS;
          // config the USART1 pads
          assign alt_0_pad_periphs_b_20_pad_IO_USART1_RX  = alt_0_pad_periphs_b_19_pad_IO_USART1_TX;
          assign alt_0_pad_periphs_b_22_pad_IO_USART1_CTS = alt_0_pad_periphs_b_21_pad_IO_USART1_RTS;
        end

        if(USE_S25FS256S_MODEL == 1) begin
          // configure the SPI4 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_0_i_spi_flash_csn4 (
            .SI       ( alt_0_pad_periphs_b_07_pad_ADC0_SPI4_MOSI ),
            .SO       ( alt_0_pad_periphs_b_06_pad_ADC0_SPI4_MISO ),
            .SCK      ( alt_0_pad_periphs_b_04_pad_ADC0_SPI4_SCK  ),
            .CSNeg    ( alt_0_pad_periphs_b_05_pad_ADC0_SPI4_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI7 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_0_i_spi_flash_csn7 (
            .SI       ( alt_0_pad_periphs_b_12_pad_EXT1_SPI7_MOSI ),
            .SO       ( alt_0_pad_periphs_b_11_pad_EXT1_SPI7_MISO ),
            .SCK      ( alt_0_pad_periphs_b_10_pad_EXT1_SPI7_SCK  ),
            .CSNeg    ( alt_0_pad_periphs_b_13_pad_EXT1_SPI7_CS0  ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI10 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_0_i_spi_flash_csn10 (
            .SI       ( alt_0_pad_periphs_b_41_pad_USB1_SPI10_MOSI ),
            .SO       ( alt_0_pad_periphs_b_40_pad_USB1_SPI10_MISO ),
            .SCK      ( alt_0_pad_periphs_b_38_pad_USB1_SPI10_SCK  ),
            .CSNeg    ( alt_0_pad_periphs_b_39_pad_USB1_SPI10_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
        end

        if (USE_24FC1025_MODEL == 1) begin
          // configure the I2C2 pads
          pullup alt_0_sda2_pullup_i (alt_0_pad_periphs_b_09_pad_PMIC_I2C2_SDA);
          pullup alt_0_scl2_pullup_i (alt_0_pad_periphs_b_08_pad_PMIC_I2C2_SCL);
            M24FC1025 alt_0_i_i2c_mem_2 (
              .A0    ( 1'b1       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_0_pad_periphs_b_09_pad_PMIC_I2C2_SDA ),
              .SCL   ( alt_0_pad_periphs_b_08_pad_PMIC_I2C2_SCL ),
              .RESET ( 1'b0       )
          );
          // configure the I2C4 pads
          pullup alt_0_sda4_pullup_i (alt_0_pad_periphs_b_16_pad_EXT2_I2C4_SDA);
          pullup alt_0_scl4_pullup_i (alt_0_pad_periphs_b_15_pad_EXT2_I2C4_SCL);
            M24FC1025 alt_0_i_i2c_mem_4 (
              .A0    ( 1'b1       ),
              .A1    ( 1'b1       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_0_pad_periphs_b_16_pad_EXT2_I2C4_SDA ),
              .SCL   ( alt_0_pad_periphs_b_15_pad_EXT2_I2C4_SCL ),
              .RESET ( 1'b0       )
          );
        end

        if (USE_UART == 1) begin
          // config the UART1 pads
          assign alt_0_pad_periphs_b_18_pad_EXT3_UART1_RX = alt_0_pad_periphs_b_17_pad_EXT3_UART1_TX;
        end

        if (USE_CAN == 1) begin
          // config the CAN0 pads
          assign alt_0_pad_periphs_b_43_pad_CAN0_RX = alt_0_pad_periphs_b_42_pad_CAN0_TX;
        end
        //**************************************************
        // ALTERNAME 0 - STANDARD CPGA VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 1 - NANO QFN VIPs BEGINNING
        //**************************************************
        if (USE_UART == 1) begin
          // config the CORE_UART pads
          assign alt_1_pad_periphs_a_01_pad_CORE_UART_RX = alt_1_pad_periphs_a_00_pad_CORE_UART_TX;
          // config the UART2 pads
          assign alt_1_pad_periphs_a_15_pad_GPS1_UART2_RX = alt_1_pad_periphs_a_14_pad_GPS1_UART2_TX;
        end

        if(USE_S25FS256S_MODEL == 1) begin
          // configure the LINUX QSPI pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_1_i_linux_qspi (
            .SI       ( alt_1_pad_periphs_a_04_pad_LINUX_QSPI_IO0 ),
            .SO       ( alt_1_pad_periphs_a_05_pad_LINUX_QSPI_IO1 ),
            .SCK      ( alt_1_pad_periphs_a_02_pad_LINUX_QSPI_SCK ),
            .CSNeg    ( alt_1_pad_periphs_a_03_pad_LINUX_QSPI_CSN ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
        end

        if (USE_24FC1025_MODEL == 1) begin
          // configure the I2C0 pads
          pullup alt_1_sda0_pullup_i (alt_1_pad_periphs_a_09_pad_BARO1_I2C0_SDA);
          pullup alt_1_scl0_pullup_i (alt_1_pad_periphs_a_08_pad_BARO1_I2C0_SCL);
            M24FC1025 alt_1_i_i2c_mem_0 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_1_pad_periphs_a_09_pad_BARO1_I2C0_SDA ),
              .SCL   ( alt_1_pad_periphs_a_08_pad_BARO1_I2C0_SCL ),
              .RESET ( 1'b0       )
          );
          // configure the I2C5 pads
          pullup alt_1_sda5_pullup_i (alt_1_pad_periphs_a_17_pad_GPS1_I2C5_SDA);
          pullup alt_1_scl5_pullup_i (alt_1_pad_periphs_a_16_pad_GPS1_I2C5_SCL);
            M24FC1025 alt_1_i_i2c_mem_5 (
              .A0    ( 1'b1       ),
              .A1    ( 1'b1       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_1_pad_periphs_a_17_pad_GPS1_I2C5_SDA ),
              .SCL   ( alt_1_pad_periphs_a_16_pad_GPS1_I2C5_SCL ),
              .RESET ( 1'b0       )
          );
        end

        if (USE_SDVT_CPI==1) begin
          // configure the CAM0 pads
          cam_vip #(
            .HRES       ( 32 ), //320
            .VRES       ( 32 )  //240
          ) alt_1_i_cam_vip_0 (
            .en_i        ( alt_3_pad_periphs_a_00_pad_IO_GPIO00       ),  //GPIO00
            .cam_clk_o   ( alt_1_pad_periphs_a_18_pad_CAM0_CPI0_CLK   ),
            .cam_vsync_o ( alt_1_pad_periphs_a_19_pad_CAM0_CPI0_VSYNC ),
            .cam_href_o  ( alt_1_pad_periphs_a_20_pad_CAM0_CPI0_HSYNC ),
            .cam_data_o  ( w_cam_0_data  )
          );
          assign alt_1_pad_periphs_a_21_pad_CAM0_CPI0_DAT0 = w_cam_0_data[0];
          assign alt_1_pad_periphs_a_22_pad_CAM0_CPI0_DAT1 = w_cam_0_data[1];
          assign alt_1_pad_periphs_a_23_pad_CAM0_CPI0_DAT2 = w_cam_0_data[2];
          assign alt_1_pad_periphs_a_24_pad_CAM0_CPI0_DAT3 = w_cam_0_data[3];
          assign alt_1_pad_periphs_a_25_pad_CAM0_CPI0_DAT4 = w_cam_0_data[4];
          assign alt_1_pad_periphs_a_26_pad_CAM0_CPI0_DAT5 = w_cam_0_data[5];
          assign alt_1_pad_periphs_a_27_pad_CAM0_CPI0_DAT6 = w_cam_0_data[6];
          assign alt_1_pad_periphs_a_28_pad_CAM0_CPI0_DAT7 = w_cam_0_data[7];
        end
        //**************************************************
        // ALTERNAME 1 - NANO QFN VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 1 - NANO CPGA VIPs BEGINNING
        //**************************************************
        if(USE_SDIO == 1) begin
          // configure the SDIO1 pads
          sdModel alt_1_sdModelTB1(
          .sdClk ( alt_1_pad_periphs_b_04_pad_WIRELESS_SDIO1_CLK ),
          .cmd   ( alt_1_pad_periphs_b_05_pad_WIRELESS_SDIO1_CMD ),
          .dat   ( {
                    alt_1_pad_periphs_b_03_pad_WIRELESS_SDIO1_D3,
                    alt_1_pad_periphs_b_02_pad_WIRELESS_SDIO1_D2,
                    alt_1_pad_periphs_b_01_pad_WIRELESS_SDIO1_D1,
                    alt_1_pad_periphs_b_00_pad_WIRELESS_SDIO1_D0
                  } )
          );
        end

        if(USE_S25FS256S_MODEL == 1) begin
          // configure the SPI0 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_1_i_spi_flash_csn0 (
            .SI       ( alt_1_pad_periphs_b_09_pad_IMU1_SPI0_MOSI ),
            .SO       ( alt_1_pad_periphs_b_08_pad_IMU1_SPI0_MISO ),
            .SCK      ( alt_1_pad_periphs_b_06_pad_IMU1_SPI0_SCK  ),
            .CSNeg    ( alt_1_pad_periphs_b_07_pad_IMU1_SPI0_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI4 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_1_i_spi_flash_csn4 (
            .SI       ( alt_1_pad_periphs_b_17_pad_ADC0_SPI4_MOSI ),
            .SO       ( alt_1_pad_periphs_b_16_pad_ADC0_SPI4_MISO ),
            .SCK      ( alt_1_pad_periphs_b_14_pad_ADC0_SPI4_SCK  ),
            .CSNeg    ( alt_1_pad_periphs_b_15_pad_ADC0_SPI4_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI2 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_1_i_spi_flash_csn2 (
            .SI       ( alt_1_pad_periphs_b_21_pad_FRAM_SPI2_MOSI ),
            .SO       ( alt_1_pad_periphs_b_20_pad_FRAM_SPI2_MISO ),
            .SCK      ( alt_1_pad_periphs_b_18_pad_FRAM_SPI2_SCK  ),
            .CSNeg    ( alt_1_pad_periphs_b_19_pad_FRAM_SPI2_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI3 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_1_i_spi_flash_csn3 (
            .SI       ( alt_1_pad_periphs_b_25_pad_ADIO1_SPI3_MOSI ),
            .SO       ( alt_1_pad_periphs_b_24_pad_ADIO1_SPI3_MISO ),
            .SCK      ( alt_1_pad_periphs_b_22_pad_ADIO1_SPI3_SCK  ),
            .CSNeg    ( alt_1_pad_periphs_b_23_pad_ADIO1_SPI3_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI1 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_1_i_spi_flash_csn1 (
            .SI       ( alt_1_pad_periphs_b_29_pad_MAG_SPI1_MOSI ),
            .SO       ( alt_1_pad_periphs_b_28_pad_MAG_SPI1_MISO ),
            .SCK      ( alt_1_pad_periphs_b_26_pad_MAG_SPI1_SCK  ),
            .CSNeg    ( alt_1_pad_periphs_b_27_pad_MAG_SPI1_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
        end

        if(USE_USART == 1) begin
          // config the USART0 pads
          assign alt_1_pad_periphs_b_11_pad_TLM1_USART0_RX  = alt_1_pad_periphs_b_10_pad_TLM1_USART0_TX;
          assign alt_1_pad_periphs_b_13_pad_TLM1_USART0_CTS = alt_1_pad_periphs_b_12_pad_TLM1_USART0_RTS;
        end

        if (USE_CAN == 1) begin
          // config the CAN1 pads
          assign alt_1_pad_periphs_b_31_pad_CAN1_RX = alt_1_pad_periphs_b_30_pad_CAN1_TX;
        end

        if (USE_SDVT_CPI==1) begin
          // configure the CAM1 pads
          cam_vip #(
            .HRES       ( 32 ), //320
            .VRES       ( 32 )  //240
          ) alt_1_i_cam_vip_1 (
            .en_i        ( alt_3_pad_periphs_a_01_pad_IO_GPIO01       ),  //GPIO01
            .cam_clk_o   ( alt_1_pad_periphs_b_36_pad_CAM1_CPI1_CLK   ),
            .cam_vsync_o ( alt_1_pad_periphs_b_37_pad_CAM1_CPI1_VSYNC ),
            .cam_href_o  ( alt_1_pad_periphs_b_38_pad_CAM1_CPI1_HSYNC ),
            .cam_data_o  ( w_cam_1_data  )
          );
          assign alt_1_pad_periphs_b_39_pad_CAM1_CPI1_DAT0 = w_cam_1_data[0];
          assign alt_1_pad_periphs_b_40_pad_CAM1_CPI1_DAT1 = w_cam_1_data[1];
          assign alt_1_pad_periphs_b_41_pad_CAM1_CPI1_DAT2 = w_cam_1_data[2];
          assign alt_1_pad_periphs_b_42_pad_CAM1_CPI1_DAT3 = w_cam_1_data[3];
          assign alt_1_pad_periphs_b_43_pad_CAM1_CPI1_DAT4 = w_cam_1_data[4];
          assign alt_1_pad_periphs_b_44_pad_CAM1_CPI1_DAT5 = w_cam_1_data[5];
          assign alt_1_pad_periphs_b_45_pad_CAM1_CPI1_DAT6 = w_cam_1_data[6];
          assign alt_1_pad_periphs_b_46_pad_CAM1_CPI1_DAT7 = w_cam_1_data[7];
        end
        //**************************************************
        // ALTERNAME 1 - NANO CPGA VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 2 - COMM QFN VIPs BEGINNING
        //**************************************************
        if (USE_CAN == 1) begin
          // config the CAN0 pads
          assign alt_2_pad_periphs_a_01_pad_CAN0_RX = alt_2_pad_periphs_a_00_pad_CAN0_TX;
          // config the CAN1 pads
          assign alt_2_pad_periphs_a_03_pad_CAN1_RX = alt_2_pad_periphs_a_02_pad_CAN1_TX;
        end

        if(USE_USART == 1) begin
          // config the USART1 pads
          assign alt_2_pad_periphs_a_06_pad_IO_USART1_RX  = alt_2_pad_periphs_a_05_pad_IO_USART1_TX;
          assign alt_2_pad_periphs_a_08_pad_IO_USART1_CTS = alt_2_pad_periphs_a_07_pad_IO_USART1_RTS;
        end

        if(USE_SDIO == 1) begin
          // configure the SDIO1 pads
          sdModel alt_2_sdModelTB1(
          .sdClk ( alt_2_pad_periphs_a_13_pad_WIRELESS_SDIO1_CLK ),
          .cmd   ( alt_2_pad_periphs_a_14_pad_WIRELESS_SDIO1_CMD ),
          .dat   ( {
                    alt_2_pad_periphs_a_12_pad_WIRELESS_SDIO1_D3,
                    alt_2_pad_periphs_a_11_pad_WIRELESS_SDIO1_D2,
                    alt_2_pad_periphs_a_10_pad_WIRELESS_SDIO1_D1,
                    alt_2_pad_periphs_a_09_pad_WIRELESS_SDIO1_D0
                  } )
          );
        end
        //**************************************************
        // ALTERNAME 2 - COMM QFN VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 2 - COMM CPGA VIPs BEGINNING
        //**************************************************
        tran alt_2_pad_periphs_b_00_47_gpio_loopback (alt_2_pad_periphs_b_00_pad_IO_GPIO00, alt_2_pad_periphs_b_47_pad_IO_GPIO47);
        tran alt_2_pad_periphs_b_01_46_gpio_loopback (alt_2_pad_periphs_b_01_pad_IO_GPIO01, alt_2_pad_periphs_b_46_pad_IO_GPIO46);
        tran alt_2_pad_periphs_b_02_45_gpio_loopback (alt_2_pad_periphs_b_02_pad_IO_GPIO02, alt_2_pad_periphs_b_45_pad_IO_GPIO45);
        tran alt_2_pad_periphs_b_03_44_gpio_loopback (alt_2_pad_periphs_b_03_pad_IO_GPIO03, alt_2_pad_periphs_b_44_pad_IO_GPIO44);
        tran alt_2_pad_periphs_b_04_43_gpio_loopback (alt_2_pad_periphs_b_04_pad_IO_GPIO04, alt_2_pad_periphs_b_43_pad_IO_GPIO43);
        tran alt_2_pad_periphs_b_05_42_gpio_loopback (alt_2_pad_periphs_b_05_pad_IO_GPIO05, alt_2_pad_periphs_b_42_pad_IO_GPIO42);
        tran alt_2_pad_periphs_b_06_41_gpio_loopback (alt_2_pad_periphs_b_06_pad_IO_GPIO06, alt_2_pad_periphs_b_41_pad_IO_GPIO41);
        tran alt_2_pad_periphs_b_07_40_gpio_loopback (alt_2_pad_periphs_b_07_pad_IO_GPIO07, alt_2_pad_periphs_b_40_pad_IO_GPIO40);
        tran alt_2_pad_periphs_b_08_39_gpio_loopback (alt_2_pad_periphs_b_08_pad_IO_GPIO08, alt_2_pad_periphs_b_39_pad_IO_GPIO39);
        tran alt_2_pad_periphs_b_09_38_gpio_loopback (alt_2_pad_periphs_b_09_pad_IO_GPIO09, alt_2_pad_periphs_b_38_pad_IO_GPIO38);
        tran alt_2_pad_periphs_b_10_37_gpio_loopback (alt_2_pad_periphs_b_10_pad_IO_GPIO10, alt_2_pad_periphs_b_37_pad_IO_GPIO37);
        tran alt_2_pad_periphs_b_11_36_gpio_loopback (alt_2_pad_periphs_b_11_pad_IO_GPIO11, alt_2_pad_periphs_b_36_pad_IO_GPIO36);
        tran alt_2_pad_periphs_b_12_35_gpio_loopback (alt_2_pad_periphs_b_12_pad_IO_GPIO12, alt_2_pad_periphs_b_35_pad_IO_GPIO35);
        tran alt_2_pad_periphs_b_13_34_gpio_loopback (alt_2_pad_periphs_b_13_pad_IO_GPIO13, alt_2_pad_periphs_b_34_pad_IO_GPIO34);
        tran alt_2_pad_periphs_b_14_33_gpio_loopback (alt_2_pad_periphs_b_14_pad_IO_GPIO14, alt_2_pad_periphs_b_33_pad_IO_GPIO33);
        tran alt_2_pad_periphs_b_15_32_gpio_loopback (alt_2_pad_periphs_b_15_pad_IO_GPIO15, alt_2_pad_periphs_b_32_pad_IO_GPIO32);
        tran alt_2_pad_periphs_b_16_31_gpio_loopback (alt_2_pad_periphs_b_16_pad_IO_GPIO16, alt_2_pad_periphs_b_31_pad_IO_GPIO31);
        tran alt_2_pad_periphs_b_17_30_gpio_loopback (alt_2_pad_periphs_b_17_pad_IO_GPIO17, alt_2_pad_periphs_b_30_pad_IO_GPIO30);
        tran alt_2_pad_periphs_b_18_29_gpio_loopback (alt_2_pad_periphs_b_18_pad_IO_GPIO18, alt_2_pad_periphs_b_29_pad_IO_GPIO29);
        tran alt_2_pad_periphs_b_19_28_gpio_loopback (alt_2_pad_periphs_b_19_pad_IO_GPIO19, alt_2_pad_periphs_b_28_pad_IO_GPIO28);
        tran alt_2_pad_periphs_b_20_27_gpio_loopback (alt_2_pad_periphs_b_20_pad_IO_GPIO20, alt_2_pad_periphs_b_27_pad_IO_GPIO27);
        tran alt_2_pad_periphs_b_21_26_gpio_loopback (alt_2_pad_periphs_b_21_pad_IO_GPIO21, alt_2_pad_periphs_b_26_pad_IO_GPIO26);
        tran alt_2_pad_periphs_b_22_25_gpio_loopback (alt_2_pad_periphs_b_22_pad_IO_GPIO22, alt_2_pad_periphs_b_25_pad_IO_GPIO25);
        tran alt_2_pad_periphs_b_23_24_gpio_loopback (alt_2_pad_periphs_b_23_pad_IO_GPIO23, alt_2_pad_periphs_b_24_pad_IO_GPIO24);
        //**************************************************
        // ALTERNAME 2 - COMM CPGA VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 3 - GPIOs QFN VIPs BEGINNING
        //**************************************************
        tran alt_3_pad_periphs_a_00_29_gpio_loopback (alt_3_pad_periphs_a_00_pad_IO_GPIO00, alt_3_pad_periphs_a_29_pad_IO_GPIO29);
        tran alt_3_pad_periphs_a_01_28_gpio_loopback (alt_3_pad_periphs_a_01_pad_IO_GPIO01, alt_3_pad_periphs_a_28_pad_IO_GPIO28);
        tran alt_3_pad_periphs_a_02_27_gpio_loopback (alt_3_pad_periphs_a_02_pad_IO_GPIO02, alt_3_pad_periphs_a_27_pad_IO_GPIO27);
        tran alt_3_pad_periphs_a_03_26_gpio_loopback (alt_3_pad_periphs_a_03_pad_IO_GPIO03, alt_3_pad_periphs_a_26_pad_IO_GPIO26);
        tran alt_3_pad_periphs_a_04_25_gpio_loopback (alt_3_pad_periphs_a_04_pad_IO_GPIO04, alt_3_pad_periphs_a_25_pad_IO_GPIO25);
        tran alt_3_pad_periphs_a_05_24_gpio_loopback (alt_3_pad_periphs_a_05_pad_IO_GPIO05, alt_3_pad_periphs_a_24_pad_IO_GPIO24);
        tran alt_3_pad_periphs_a_06_23_gpio_loopback (alt_3_pad_periphs_a_06_pad_IO_GPIO06, alt_3_pad_periphs_a_23_pad_IO_GPIO23);
        tran alt_3_pad_periphs_a_07_22_gpio_loopback (alt_3_pad_periphs_a_07_pad_IO_GPIO07, alt_3_pad_periphs_a_22_pad_IO_GPIO22);
        tran alt_3_pad_periphs_a_08_21_gpio_loopback (alt_3_pad_periphs_a_08_pad_IO_GPIO08, alt_3_pad_periphs_a_21_pad_IO_GPIO21);
        tran alt_3_pad_periphs_a_09_20_gpio_loopback (alt_3_pad_periphs_a_09_pad_IO_GPIO09, alt_3_pad_periphs_a_20_pad_IO_GPIO20);
        tran alt_3_pad_periphs_a_10_19_gpio_loopback (alt_3_pad_periphs_a_10_pad_IO_GPIO10, alt_3_pad_periphs_a_19_pad_IO_GPIO19);
        tran alt_3_pad_periphs_a_11_18_gpio_loopback (alt_3_pad_periphs_a_11_pad_IO_GPIO11, alt_3_pad_periphs_a_18_pad_IO_GPIO18);
        tran alt_3_pad_periphs_a_12_17_gpio_loopback (alt_3_pad_periphs_a_12_pad_IO_GPIO12, alt_3_pad_periphs_a_17_pad_IO_GPIO17);
        tran alt_3_pad_periphs_a_13_16_gpio_loopback (alt_3_pad_periphs_a_13_pad_IO_GPIO13, alt_3_pad_periphs_a_16_pad_IO_GPIO16);
        tran alt_3_pad_periphs_a_14_15_gpio_loopback (alt_3_pad_periphs_a_14_pad_IO_GPIO14, alt_3_pad_periphs_a_15_pad_IO_GPIO15);
        //**************************************************
        // ALTERNAME 3 - GPIOs QFN VIPs END
        //**************************************************

        //**************************************************
        // ALTERNAME 3 - GPIOs CPGA VIPs BEGINNING
        //**************************************************
        if (USE_UART == 1) begin
          // config the UART0 pads
          assign alt_3_pad_periphs_b_01_pad_GPS2_UART0_RX = alt_3_pad_periphs_b_00_pad_GPS2_UART0_TX;
        end

        if (USE_24FC1025_MODEL == 1) begin
          // configure the I2C1 pads
          pullup alt_3_sda1_pullup_i (alt_3_pad_periphs_b_03_pad_GPS2_I2C1_SDA);
          pullup alt_3_scl1_pullup_i (alt_3_pad_periphs_b_02_pad_GPS2_I2C1_SCL);
            M24FC1025 alt_3_i_i2c_mem_1 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_3_pad_periphs_b_03_pad_GPS2_I2C1_SDA ),
              .SCL   ( alt_3_pad_periphs_b_02_pad_GPS2_I2C1_SCL ),
              .RESET ( 1'b0       )
          );
          // configure the I2C3 pads
          pullup alt_3_sda3_pullup_i (alt_3_pad_periphs_b_09_pad_BARO2_I2C3_SDA);
          pullup alt_3_scl3_pullup_i (alt_3_pad_periphs_b_08_pad_BARO2_I2C3_SCL);
            M24FC1025 alt_3_i_i2c_mem_3 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b1       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_3_pad_periphs_b_09_pad_BARO2_I2C3_SDA ),
              .SCL   ( alt_3_pad_periphs_b_08_pad_BARO2_I2C3_SCL ),
              .RESET ( 1'b0       )
          );
        end

        if(USE_S25FS256S_MODEL == 1) begin
          // configure the SPI5 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_3_i_spi_flash_csn5 (
            .SI       ( alt_3_pad_periphs_b_07_pad_IMU2_SPI5_MOSI ),
            .SO       ( alt_3_pad_periphs_b_06_pad_IMU2_SPI5_MISO ),
            .SCK      ( alt_3_pad_periphs_b_04_pad_IMU2_SPI5_SCK  ),
            .CSNeg    ( alt_3_pad_periphs_b_05_pad_IMU2_SPI5_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI6 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_3_i_spi_flash_csn6 (
            .SI       ( alt_3_pad_periphs_b_13_pad_IMU3_SPI6_MOSI ),
            .SO       ( alt_3_pad_periphs_b_12_pad_IMU3_SPI6_MISO ),
            .SCK      ( alt_3_pad_periphs_b_10_pad_IMU3_SPI6_SCK  ),
            .CSNeg    ( alt_3_pad_periphs_b_11_pad_IMU3_SPI6_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI8 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_3_i_spi_flash_csn8 (
            .SI       ( alt_3_pad_periphs_b_25_pad_CAN0_SPI8_MOSI ),
            .SO       ( alt_3_pad_periphs_b_24_pad_CAN0_SPI8_MISO ),
            .SCK      ( alt_3_pad_periphs_b_22_pad_CAN0_SPI8_SCK  ),
            .CSNeg    ( alt_3_pad_periphs_b_23_pad_CAN0_SPI8_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI9 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_3_i_spi_flash_csn9 (
            .SI       ( alt_3_pad_periphs_b_29_pad_CAN1_SPI9_MOSI ),
            .SO       ( alt_3_pad_periphs_b_28_pad_CAN1_SPI9_MISO ),
            .SCK      ( alt_3_pad_periphs_b_26_pad_CAN1_SPI9_SCK  ),
            .CSNeg    ( alt_3_pad_periphs_b_27_pad_CAN1_SPI9_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
          // configure the SPI10 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) alt_3_i_spi_flash_csn10 (
            .SI       ( alt_3_pad_periphs_b_33_pad_USB1_SPI10_MOSI ),
            .SO       ( alt_3_pad_periphs_b_32_pad_USB1_SPI10_MISO ),
            .SCK      ( alt_3_pad_periphs_b_30_pad_USB1_SPI10_SCK  ),
            .CSNeg    ( alt_3_pad_periphs_b_31_pad_USB1_SPI10_CS   ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
        end

        if(USE_USART == 1) begin
          // config the USART2 pads
          assign alt_3_pad_periphs_b_15_pad_TLM2_USART2_RX  = alt_3_pad_periphs_b_14_pad_TLM2_USART2_TX;
          assign alt_3_pad_periphs_b_17_pad_TLM2_USART2_CTS = alt_3_pad_periphs_b_16_pad_TLM2_USART2_RTS;
          // config the USART3 pads
          assign alt_3_pad_periphs_b_19_pad_TLM3_USART3_RX  = alt_3_pad_periphs_b_18_pad_TLM3_USART3_TX;
          assign alt_3_pad_periphs_b_21_pad_TLM3_USART3_CTS = alt_3_pad_periphs_b_20_pad_TLM3_USART3_RTS;
        end
        //**************************************************
        // ALTERNAME 3 - GPIOs CPGA VIPs END
        //**************************************************
      `else // !`ifndef SIMPLE_PADFRAME
        //**************************************************
        // ALTERNATE 0 - PERIPH VIPs BEGINNING
        //**************************************************
        if (USE_24FC1025_MODEL == 1) begin
          // configure the I2C0 pads
          pullup alt_0_sda0_pullup_i (alt_0_simple_pad_periphs_05_i2c0_sda);
          pullup alt_0_scl0_pullup_i (alt_0_simple_pad_periphs_04_i2c0_scl);
            M24FC1025 i_i2c_mem_0 (
              .A0    ( 1'b0       ),
              .A1    ( 1'b0       ),
              .A2    ( 1'b1       ),
              .WP    ( 1'b0       ),
              .SDA   ( alt_0_simple_pad_periphs_05_i2c0_sda ),
              .SCL   ( alt_0_simple_pad_periphs_04_i2c0_scl ),
              .RESET ( 1'b0       )
          );
        end

        if(USE_S25FS256S_MODEL == 1) begin
          // configure the SPI0 pads
          s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm"  ),
            .UserPreload   ( 0 )
          ) i_spi_flash_csn0 (
            .SI       ( alt_0_simple_pad_periphs_03_spi0_si ),
            .SO       ( alt_0_simple_pad_periphs_02_spi0_so ),
            .SCK      ( alt_0_simple_pad_periphs_01_spi0_ck ),
            .CSNeg    ( alt_0_simple_pad_periphs_00_spi0_cs ),
            .WPNeg    (  ),
            .RESETNeg (  )
          );
        end

        if(USE_SDIO == 1) begin
          // configure the SDIO0 pads
          sdModel sdModelTB0(
          .sdClk ( alt_0_simple_pad_periphs_12_sdio0_clk ),
          .cmd   ( alt_0_simple_pad_periphs_13_sdio0_cmd ),
          .dat   ( {
                    alt_0_simple_pad_periphs_11_sdio0_d4,
                    alt_0_simple_pad_periphs_10_sdio0_d3,
                    alt_0_simple_pad_periphs_09_sdio0_d2,
                    alt_0_simple_pad_periphs_08_sdio0_d1
                  } )
          );
        end

        if(USE_UART == 1) begin
          // config the UART0 pads
          assign simple_pad_periphs_07_uart0_rx = simple_pad_periphs_06_uart0_tx; // UART0_TX -> UART0_RX
        end
        //**************************************************
        // ALTERNATE 0 - PERIPH VIPs END
        //**************************************************

        //**************************************************
        // ALTERNATE 1 - GPIOs VIPs BEGINNING
        //**************************************************
        tran simple_pad_periphs_00_13_gpio_loopback (alt_1_simple_pad_periphs_00_gpio00, alt_1_simple_pad_periphs_13_gpio13);
        tran simple_pad_periphs_01_12_gpio_loopback (alt_1_simple_pad_periphs_01_gpio01, alt_1_simple_pad_periphs_12_gpio12);
        tran simple_pad_periphs_02_11_gpio_loopback (alt_1_simple_pad_periphs_02_gpio02, alt_1_simple_pad_periphs_11_gpio11);
        tran simple_pad_periphs_03_10_gpio_loopback (alt_1_simple_pad_periphs_03_gpio03, alt_1_simple_pad_periphs_10_gpio10);
        tran simple_pad_periphs_04_09_gpio_loopback (alt_1_simple_pad_periphs_04_gpio04, alt_1_simple_pad_periphs_09_gpio09);
        tran simple_pad_periphs_05_08_gpio_loopback (alt_1_simple_pad_periphs_05_gpio05, alt_1_simple_pad_periphs_08_gpio08);
        tran simple_pad_periphs_06_07_gpio_loopback (alt_1_simple_pad_periphs_06_gpio06, alt_1_simple_pad_periphs_07_gpio07);
        //**************************************************
        // ALTERNATE 1 - GPIOs VIPs END
        //**************************************************
      `endif
    `endif
  endgenerate
  //**************************************************
  // VIPs END
  //**************************************************

  //**************************************************
  // VIP MUX SEL BEGINNING
  //**************************************************
  `ifndef TARGET_POST_SYNTH_SIM_TOP
    `ifndef FPGA_EMUL
      `ifndef SIMPLE_PADFRAME
        assign alt_0_pad_periphs_a_00_pad_mux_sel_CORE_UART_TX    = (`PAD_MUX_REG_PATH.a_00_mux_sel.q == PAD_MUX_GROUP_A_00_SEL_UART_CORE_UART_TX);
        assign alt_0_pad_periphs_a_01_pad_mux_sel_CORE_UART_RX    = (`PAD_MUX_REG_PATH.a_01_mux_sel.q == PAD_MUX_GROUP_A_01_SEL_UART_CORE_UART_RX);
        assign alt_0_pad_periphs_a_02_pad_mux_sel_SDIO0_D1        = (`PAD_MUX_REG_PATH.a_02_mux_sel.q == PAD_MUX_GROUP_A_02_SEL_SDIO0_SDIO_DATA0);
        assign alt_0_pad_periphs_a_03_pad_mux_sel_SDIO0_D2        = (`PAD_MUX_REG_PATH.a_03_mux_sel.q == PAD_MUX_GROUP_A_03_SEL_SDIO0_SDIO_DATA1);
        assign alt_0_pad_periphs_a_04_pad_mux_sel_SDIO0_D3        = (`PAD_MUX_REG_PATH.a_04_mux_sel.q == PAD_MUX_GROUP_A_04_SEL_SDIO0_SDIO_DATA2);
        assign alt_0_pad_periphs_a_05_pad_mux_sel_SDIO0_D4        = (`PAD_MUX_REG_PATH.a_05_mux_sel.q == PAD_MUX_GROUP_A_05_SEL_SDIO0_SDIO_DATA3);
        assign alt_0_pad_periphs_a_06_pad_mux_sel_SDIO0_CLK       = (`PAD_MUX_REG_PATH.a_06_mux_sel.q == PAD_MUX_GROUP_A_06_SEL_SDIO0_SDIO_CLK);
        assign alt_0_pad_periphs_a_07_pad_mux_sel_SDIO0_CMD       = (`PAD_MUX_REG_PATH.a_07_mux_sel.q == PAD_MUX_GROUP_A_07_SEL_SDIO0_SDIO_CMD);
        assign alt_0_pad_periphs_a_08_pad_mux_sel_PWM0_CHANNEL0   = (`PAD_MUX_REG_PATH.a_08_mux_sel.q == PAD_MUX_GROUP_A_08_SEL_PWM0_PWM0);
        assign alt_0_pad_periphs_a_09_pad_mux_sel_PWM1_CHANNEL0   = (`PAD_MUX_REG_PATH.a_09_mux_sel.q == PAD_MUX_GROUP_A_09_SEL_PWM0_PWM1);
        assign alt_0_pad_periphs_a_10_pad_mux_sel_PWM2_CHANNEL0   = (`PAD_MUX_REG_PATH.a_10_mux_sel.q == PAD_MUX_GROUP_A_10_SEL_PWM0_PWM2);
        assign alt_0_pad_periphs_a_11_pad_mux_sel_PWM3_CHANNEL0   = (`PAD_MUX_REG_PATH.a_11_mux_sel.q == PAD_MUX_GROUP_A_11_SEL_PWM0_PWM3);
        assign alt_0_pad_periphs_a_12_pad_mux_sel_BARO1_I2C0_SCL  = (`PAD_MUX_REG_PATH.a_12_mux_sel.q == PAD_MUX_GROUP_A_12_SEL_I2C0_I2C_SCL);
        assign alt_0_pad_periphs_a_13_pad_mux_sel_BARO1_I2C0_SDA  = (`PAD_MUX_REG_PATH.a_13_mux_sel.q == PAD_MUX_GROUP_A_13_SEL_I2C0_I2C_SDA);
        assign alt_0_pad_periphs_a_14_pad_mux_sel_IMU1_SPI0_SCK   = (`PAD_MUX_REG_PATH.a_14_mux_sel.q == PAD_MUX_GROUP_A_14_SEL_SPI0_SPI_SCK);
        assign alt_0_pad_periphs_a_15_pad_mux_sel_IMU1_SPI0_CS    = (`PAD_MUX_REG_PATH.a_15_mux_sel.q == PAD_MUX_GROUP_A_15_SEL_SPI0_SPI_CS0);
        assign alt_0_pad_periphs_a_16_pad_mux_sel_IMU1_SPI0_MISO  = (`PAD_MUX_REG_PATH.a_16_mux_sel.q == PAD_MUX_GROUP_A_16_SEL_SPI0_SPI_MISO);
        assign alt_0_pad_periphs_a_17_pad_mux_sel_IMU1_SPI0_MOSI  = (`PAD_MUX_REG_PATH.a_17_mux_sel.q == PAD_MUX_GROUP_A_17_SEL_SPI0_SPI_MOSI);
        assign alt_0_pad_periphs_a_18_pad_mux_sel_FRAM_SPI2_SCK   = (`PAD_MUX_REG_PATH.a_18_mux_sel.q == PAD_MUX_GROUP_A_18_SEL_SPI2_SPI_SCK);
        assign alt_0_pad_periphs_a_19_pad_mux_sel_FRAM_SPI2_CS    = (`PAD_MUX_REG_PATH.a_19_mux_sel.q == PAD_MUX_GROUP_A_19_SEL_SPI2_SPI_CS0);
        assign alt_0_pad_periphs_a_20_pad_mux_sel_FRAM_SPI2_MISO  = (`PAD_MUX_REG_PATH.a_20_mux_sel.q == PAD_MUX_GROUP_A_20_SEL_SPI2_SPI_MISO);
        assign alt_0_pad_periphs_a_21_pad_mux_sel_FRAM_SPI2_MOSI  = (`PAD_MUX_REG_PATH.a_21_mux_sel.q == PAD_MUX_GROUP_A_21_SEL_SPI2_SPI_MOSI);
        assign alt_0_pad_periphs_a_22_pad_mux_sel_ADIO1_SPI3_SCK  = (`PAD_MUX_REG_PATH.a_22_mux_sel.q == PAD_MUX_GROUP_A_22_SEL_SPI3_SPI_SCK);
        assign alt_0_pad_periphs_a_23_pad_mux_sel_ADIO1_SPI3_CS   = (`PAD_MUX_REG_PATH.a_23_mux_sel.q == PAD_MUX_GROUP_A_23_SEL_SPI3_SPI_CS0);
        assign alt_0_pad_periphs_a_24_pad_mux_sel_ADIO1_SPI3_MISO = (`PAD_MUX_REG_PATH.a_24_mux_sel.q == PAD_MUX_GROUP_A_24_SEL_SPI3_SPI_MISO);
        assign alt_0_pad_periphs_a_25_pad_mux_sel_ADIO1_SPI3_MOSI = (`PAD_MUX_REG_PATH.a_25_mux_sel.q == PAD_MUX_GROUP_A_25_SEL_SPI3_SPI_MOSI);
        assign alt_0_pad_periphs_a_26_pad_mux_sel_GPS2_UART0_TX   = (`PAD_MUX_REG_PATH.a_26_mux_sel.q == PAD_MUX_GROUP_A_26_SEL_UART0_UART_TX);
        assign alt_0_pad_periphs_a_27_pad_mux_sel_GPS2_UART0_RX   = (`PAD_MUX_REG_PATH.a_27_mux_sel.q == PAD_MUX_GROUP_A_27_SEL_UART0_UART_RX);
        assign alt_0_pad_periphs_a_28_pad_mux_sel_GPS2_I2C1_SCL   = (`PAD_MUX_REG_PATH.a_28_mux_sel.q == PAD_MUX_GROUP_A_28_SEL_I2C1_I2C_SCL);
        assign alt_0_pad_periphs_a_29_pad_mux_sel_GPS2_I2C1_SDA   = (`PAD_MUX_REG_PATH.a_29_mux_sel.q == PAD_MUX_GROUP_A_29_SEL_I2C1_I2C_SDA);
        assign alt_1_pad_periphs_a_00_pad_mux_sel_CORE_UART_TX    = (`PAD_MUX_REG_PATH.a_00_mux_sel.q == PAD_MUX_GROUP_A_00_SEL_UART_CORE_UART_TX);
        assign alt_1_pad_periphs_a_01_pad_mux_sel_CORE_UART_RX    = (`PAD_MUX_REG_PATH.a_01_mux_sel.q == PAD_MUX_GROUP_A_01_SEL_UART_CORE_UART_RX);
        assign alt_1_pad_periphs_a_02_pad_mux_sel_LINUX_QSPI_SCK  = (`PAD_MUX_REG_PATH.a_02_mux_sel.q == PAD_MUX_GROUP_A_02_SEL_QSPI_LINUX_QSPI_SCK);
        assign alt_1_pad_periphs_a_03_pad_mux_sel_LINUX_QSPI_CSN  = (`PAD_MUX_REG_PATH.a_03_mux_sel.q == PAD_MUX_GROUP_A_03_SEL_QSPI_LINUX_QSPI_CSN);
        assign alt_1_pad_periphs_a_04_pad_mux_sel_LINUX_QSPI_IO0  = (`PAD_MUX_REG_PATH.a_04_mux_sel.q == PAD_MUX_GROUP_A_04_SEL_QSPI_LINUX_QSPI_SD0);
        assign alt_1_pad_periphs_a_05_pad_mux_sel_LINUX_QSPI_IO1  = (`PAD_MUX_REG_PATH.a_05_mux_sel.q == PAD_MUX_GROUP_A_05_SEL_QSPI_LINUX_QSPI_SD1);
        assign alt_1_pad_periphs_a_06_pad_mux_sel_LINUX_QSPI_IO2  = (`PAD_MUX_REG_PATH.a_06_mux_sel.q == PAD_MUX_GROUP_A_06_SEL_QSPI_LINUX_QSPI_SD2);
        assign alt_1_pad_periphs_a_07_pad_mux_sel_LINUX_QSPI_IO3  = (`PAD_MUX_REG_PATH.a_07_mux_sel.q == PAD_MUX_GROUP_A_07_SEL_QSPI_LINUX_QSPI_SD3);
        assign alt_1_pad_periphs_a_08_pad_mux_sel_BARO1_I2C0_SCL  = (`PAD_MUX_REG_PATH.a_08_mux_sel.q == PAD_MUX_GROUP_A_08_SEL_I2C0_I2C_SCL);
        assign alt_1_pad_periphs_a_09_pad_mux_sel_BARO1_I2C0_SDA  = (`PAD_MUX_REG_PATH.a_09_mux_sel.q == PAD_MUX_GROUP_A_09_SEL_I2C0_I2C_SDA);
        assign alt_1_pad_periphs_a_10_pad_mux_sel_PWM0_CHANNEL0   = (`PAD_MUX_REG_PATH.a_10_mux_sel.q == PAD_MUX_GROUP_A_10_SEL_PWM0_PWM0);
        assign alt_1_pad_periphs_a_11_pad_mux_sel_PWM1_CHANNEL0   = (`PAD_MUX_REG_PATH.a_11_mux_sel.q == PAD_MUX_GROUP_A_11_SEL_PWM0_PWM1);
        assign alt_1_pad_periphs_a_12_pad_mux_sel_PWM2_CHANNEL0   = (`PAD_MUX_REG_PATH.a_12_mux_sel.q == PAD_MUX_GROUP_A_12_SEL_PWM0_PWM2);
        assign alt_1_pad_periphs_a_13_pad_mux_sel_PWM3_CHANNEL0   = (`PAD_MUX_REG_PATH.a_13_mux_sel.q == PAD_MUX_GROUP_A_13_SEL_PWM0_PWM3);
        assign alt_1_pad_periphs_a_14_pad_mux_sel_GPS1_UART2_TX   = (`PAD_MUX_REG_PATH.a_14_mux_sel.q == PAD_MUX_GROUP_A_14_SEL_UART2_UART_TX);
        assign alt_1_pad_periphs_a_15_pad_mux_sel_GPS1_UART2_RX   = (`PAD_MUX_REG_PATH.a_15_mux_sel.q == PAD_MUX_GROUP_A_15_SEL_UART2_UART_RX);
        assign alt_1_pad_periphs_a_16_pad_mux_sel_GPS1_I2C5_SCL   = (`PAD_MUX_REG_PATH.a_16_mux_sel.q == PAD_MUX_GROUP_A_16_SEL_I2C5_I2C_SCL);
        assign alt_1_pad_periphs_a_17_pad_mux_sel_GPS1_I2C5_SDA   = (`PAD_MUX_REG_PATH.a_17_mux_sel.q == PAD_MUX_GROUP_A_17_SEL_I2C5_I2C_SDA);
        assign alt_1_pad_periphs_a_18_pad_mux_sel_CAM0_CPI0_CLK   = (`PAD_MUX_REG_PATH.a_18_mux_sel.q == PAD_MUX_GROUP_A_18_SEL_CAM0_CAM_PCLK);
        assign alt_1_pad_periphs_a_19_pad_mux_sel_CAM0_CPI0_VSYNC = (`PAD_MUX_REG_PATH.a_19_mux_sel.q == PAD_MUX_GROUP_A_19_SEL_CAM0_CAM_VSYNC);
        assign alt_1_pad_periphs_a_20_pad_mux_sel_CAM0_CPI0_HSYNC = (`PAD_MUX_REG_PATH.a_20_mux_sel.q == PAD_MUX_GROUP_A_20_SEL_CAM0_CAM_HSYNC);
        assign alt_1_pad_periphs_a_21_pad_mux_sel_CAM0_CPI0_DAT0  = (`PAD_MUX_REG_PATH.a_21_mux_sel.q == PAD_MUX_GROUP_A_21_SEL_CAM0_CAM_DATA0_I);
        assign alt_1_pad_periphs_a_22_pad_mux_sel_CAM0_CPI0_DAT1  = (`PAD_MUX_REG_PATH.a_22_mux_sel.q == PAD_MUX_GROUP_A_22_SEL_CAM0_CAM_DATA1_I);
        assign alt_1_pad_periphs_a_23_pad_mux_sel_CAM0_CPI0_DAT2  = (`PAD_MUX_REG_PATH.a_23_mux_sel.q == PAD_MUX_GROUP_A_23_SEL_CAM0_CAM_DATA2_I);
        assign alt_1_pad_periphs_a_24_pad_mux_sel_CAM0_CPI0_DAT3  = (`PAD_MUX_REG_PATH.a_24_mux_sel.q == PAD_MUX_GROUP_A_24_SEL_CAM0_CAM_DATA3_I);
        assign alt_1_pad_periphs_a_25_pad_mux_sel_CAM0_CPI0_DAT4  = (`PAD_MUX_REG_PATH.a_25_mux_sel.q == PAD_MUX_GROUP_A_25_SEL_CAM0_CAM_DATA4_I);
        assign alt_1_pad_periphs_a_26_pad_mux_sel_CAM0_CPI0_DAT5  = (`PAD_MUX_REG_PATH.a_26_mux_sel.q == PAD_MUX_GROUP_A_26_SEL_CAM0_CAM_DATA5_I);
        assign alt_1_pad_periphs_a_27_pad_mux_sel_CAM0_CPI0_DAT6  = (`PAD_MUX_REG_PATH.a_27_mux_sel.q == PAD_MUX_GROUP_A_27_SEL_CAM0_CAM_DATA6_I);
        assign alt_1_pad_periphs_a_28_pad_mux_sel_CAM0_CPI0_DAT7  = (`PAD_MUX_REG_PATH.a_28_mux_sel.q == PAD_MUX_GROUP_A_28_SEL_CAM0_CAM_DATA7_I);
        assign alt_1_pad_periphs_a_29_pad_mux_sel_FLL_SOC         = (`PAD_MUX_REG_PATH.a_29_mux_sel.q == PAD_MUX_GROUP_A_29_SEL_FLL_SOC_CLK_SOC);
        assign alt_2_pad_periphs_a_00_pad_mux_sel_CAN0_TX            = (`PAD_MUX_REG_PATH.a_00_mux_sel.q == PAD_MUX_GROUP_A_00_SEL_CAN0_CAN_TX);
        assign alt_2_pad_periphs_a_01_pad_mux_sel_CAN0_RX            = (`PAD_MUX_REG_PATH.a_01_mux_sel.q == PAD_MUX_GROUP_A_01_SEL_CAN0_CAN_RX);
        assign alt_2_pad_periphs_a_02_pad_mux_sel_CAN1_TX            = (`PAD_MUX_REG_PATH.a_02_mux_sel.q == PAD_MUX_GROUP_A_02_SEL_CAN1_CAN_TX);
        assign alt_2_pad_periphs_a_03_pad_mux_sel_CAN1_RX            = (`PAD_MUX_REG_PATH.a_03_mux_sel.q == PAD_MUX_GROUP_A_03_SEL_CAN1_CAN_RX);
        assign alt_2_pad_periphs_a_04_pad_mux_sel_FLL_SOC            = (`PAD_MUX_REG_PATH.a_04_mux_sel.q == PAD_MUX_GROUP_A_04_SEL_FLL_SOC_CLK_SOC);
        assign alt_2_pad_periphs_a_05_pad_mux_sel_IO_USART1_TX       = (`PAD_MUX_REG_PATH.a_05_mux_sel.q == PAD_MUX_GROUP_A_05_SEL_USART1_UART_TX);
        assign alt_2_pad_periphs_a_06_pad_mux_sel_IO_USART1_RX       = (`PAD_MUX_REG_PATH.a_06_mux_sel.q == PAD_MUX_GROUP_A_06_SEL_USART1_UART_RX);
        assign alt_2_pad_periphs_a_07_pad_mux_sel_IO_USART1_RTS      = (`PAD_MUX_REG_PATH.a_07_mux_sel.q == PAD_MUX_GROUP_A_07_SEL_USART1_UART_RTS);
        assign alt_2_pad_periphs_a_08_pad_mux_sel_IO_USART1_CTS      = (`PAD_MUX_REG_PATH.a_08_mux_sel.q == PAD_MUX_GROUP_A_08_SEL_USART1_UART_CTS);
        assign alt_2_pad_periphs_a_09_pad_mux_sel_WIRELESS_SDIO1_D0  = (`PAD_MUX_REG_PATH.a_09_mux_sel.q == PAD_MUX_GROUP_A_09_SEL_SDIO1_SDIO_DATA0);
        assign alt_2_pad_periphs_a_10_pad_mux_sel_WIRELESS_SDIO1_D1  = (`PAD_MUX_REG_PATH.a_10_mux_sel.q == PAD_MUX_GROUP_A_10_SEL_SDIO1_SDIO_DATA1);
        assign alt_2_pad_periphs_a_11_pad_mux_sel_WIRELESS_SDIO1_D2  = (`PAD_MUX_REG_PATH.a_11_mux_sel.q == PAD_MUX_GROUP_A_11_SEL_SDIO1_SDIO_DATA2);
        assign alt_2_pad_periphs_a_12_pad_mux_sel_WIRELESS_SDIO1_D3  = (`PAD_MUX_REG_PATH.a_12_mux_sel.q == PAD_MUX_GROUP_A_12_SEL_SDIO1_SDIO_DATA3);
        assign alt_2_pad_periphs_a_13_pad_mux_sel_WIRELESS_SDIO1_CLK = (`PAD_MUX_REG_PATH.a_13_mux_sel.q == PAD_MUX_GROUP_A_13_SEL_SDIO1_SDIO_CLK);
        assign alt_2_pad_periphs_a_14_pad_mux_sel_WIRELESS_SDIO1_CMD = (`PAD_MUX_REG_PATH.a_14_mux_sel.q == PAD_MUX_GROUP_A_14_SEL_SDIO1_SDIO_CMD);
        assign alt_2_pad_periphs_a_15_pad_mux_sel_ETH_RST            = (`PAD_MUX_REG_PATH.a_15_mux_sel.q == PAD_MUX_GROUP_A_15_SEL_ETH_ETH_RST);
        assign alt_2_pad_periphs_a_16_pad_mux_sel_ETH_RXCK           = (`PAD_MUX_REG_PATH.a_16_mux_sel.q == PAD_MUX_GROUP_A_16_SEL_ETH_ETH_RXCK);
        assign alt_2_pad_periphs_a_17_pad_mux_sel_ETH_RXCTL          = (`PAD_MUX_REG_PATH.a_17_mux_sel.q == PAD_MUX_GROUP_A_17_SEL_ETH_ETH_RXCTL);
        assign alt_2_pad_periphs_a_18_pad_mux_sel_ETH_RXD0           = (`PAD_MUX_REG_PATH.a_18_mux_sel.q == PAD_MUX_GROUP_A_18_SEL_ETH_ETH_RXD0);
        assign alt_2_pad_periphs_a_19_pad_mux_sel_ETH_RXD1           = (`PAD_MUX_REG_PATH.a_19_mux_sel.q == PAD_MUX_GROUP_A_19_SEL_ETH_ETH_RXD1);
        assign alt_2_pad_periphs_a_20_pad_mux_sel_ETH_RXD2           = (`PAD_MUX_REG_PATH.a_20_mux_sel.q == PAD_MUX_GROUP_A_20_SEL_ETH_ETH_RXD2);
        assign alt_2_pad_periphs_a_21_pad_mux_sel_ETH_RXD3           = (`PAD_MUX_REG_PATH.a_21_mux_sel.q == PAD_MUX_GROUP_A_21_SEL_ETH_ETH_RXD3);
        assign alt_2_pad_periphs_a_22_pad_mux_sel_ETH_TXCK           = (`PAD_MUX_REG_PATH.a_22_mux_sel.q == PAD_MUX_GROUP_A_22_SEL_ETH_ETH_TXCK);
        assign alt_2_pad_periphs_a_23_pad_mux_sel_ETH_TXCTL          = (`PAD_MUX_REG_PATH.a_23_mux_sel.q == PAD_MUX_GROUP_A_23_SEL_ETH_ETH_TXCTL);
        assign alt_2_pad_periphs_a_24_pad_mux_sel_ETH_TXD0           = (`PAD_MUX_REG_PATH.a_24_mux_sel.q == PAD_MUX_GROUP_A_24_SEL_ETH_ETH_TXD0);
        assign alt_2_pad_periphs_a_25_pad_mux_sel_ETH_TXD1           = (`PAD_MUX_REG_PATH.a_25_mux_sel.q == PAD_MUX_GROUP_A_25_SEL_ETH_ETH_TXD1);
        assign alt_2_pad_periphs_a_26_pad_mux_sel_ETH_TXD2           = (`PAD_MUX_REG_PATH.a_26_mux_sel.q == PAD_MUX_GROUP_A_26_SEL_ETH_ETH_TXD2);
        assign alt_2_pad_periphs_a_27_pad_mux_sel_ETH_TXD3           = (`PAD_MUX_REG_PATH.a_27_mux_sel.q == PAD_MUX_GROUP_A_27_SEL_ETH_ETH_TXD3);
        assign alt_2_pad_periphs_a_28_pad_mux_sel_ETH_MDIO           = (`PAD_MUX_REG_PATH.a_28_mux_sel.q == PAD_MUX_GROUP_A_28_SEL_ETH_ETH_MDIO);
        assign alt_2_pad_periphs_a_29_pad_mux_sel_ETH_MDC            = (`PAD_MUX_REG_PATH.a_29_mux_sel.q == PAD_MUX_GROUP_A_29_SEL_ETH_ETH_MDC);
        assign alt_3_pad_periphs_a_00_pad_mux_sel_IO_GPIO00 = (`PAD_MUX_REG_PATH.a_00_mux_sel.q == PAD_MUX_GROUP_A_00_SEL_GPIO_B_GPIO0);
        assign alt_3_pad_periphs_a_01_pad_mux_sel_IO_GPIO01 = (`PAD_MUX_REG_PATH.a_01_mux_sel.q == PAD_MUX_GROUP_A_01_SEL_GPIO_B_GPIO1);
        assign alt_3_pad_periphs_a_02_pad_mux_sel_IO_GPIO02 = (`PAD_MUX_REG_PATH.a_02_mux_sel.q == PAD_MUX_GROUP_A_02_SEL_GPIO_B_GPIO2);
        assign alt_3_pad_periphs_a_03_pad_mux_sel_IO_GPIO03 = (`PAD_MUX_REG_PATH.a_03_mux_sel.q == PAD_MUX_GROUP_A_03_SEL_GPIO_B_GPIO3);
        assign alt_3_pad_periphs_a_04_pad_mux_sel_IO_GPIO04 = (`PAD_MUX_REG_PATH.a_04_mux_sel.q == PAD_MUX_GROUP_A_04_SEL_GPIO_B_GPIO4);
        assign alt_3_pad_periphs_a_05_pad_mux_sel_IO_GPIO05 = (`PAD_MUX_REG_PATH.a_05_mux_sel.q == PAD_MUX_GROUP_A_05_SEL_GPIO_B_GPIO5);
        assign alt_3_pad_periphs_a_06_pad_mux_sel_IO_GPIO06 = (`PAD_MUX_REG_PATH.a_06_mux_sel.q == PAD_MUX_GROUP_A_06_SEL_GPIO_B_GPIO6);
        assign alt_3_pad_periphs_a_07_pad_mux_sel_IO_GPIO07 = (`PAD_MUX_REG_PATH.a_07_mux_sel.q == PAD_MUX_GROUP_A_07_SEL_GPIO_B_GPIO7);
        assign alt_3_pad_periphs_a_08_pad_mux_sel_IO_GPIO08 = (`PAD_MUX_REG_PATH.a_08_mux_sel.q == PAD_MUX_GROUP_A_08_SEL_GPIO_B_GPIO8);
        assign alt_3_pad_periphs_a_09_pad_mux_sel_IO_GPIO09 = (`PAD_MUX_REG_PATH.a_09_mux_sel.q == PAD_MUX_GROUP_A_09_SEL_GPIO_B_GPIO9);
        assign alt_3_pad_periphs_a_10_pad_mux_sel_IO_GPIO10 = (`PAD_MUX_REG_PATH.a_10_mux_sel.q == PAD_MUX_GROUP_A_10_SEL_GPIO_B_GPIO10);
        assign alt_3_pad_periphs_a_11_pad_mux_sel_IO_GPIO11 = (`PAD_MUX_REG_PATH.a_11_mux_sel.q == PAD_MUX_GROUP_A_11_SEL_GPIO_B_GPIO11);
        assign alt_3_pad_periphs_a_12_pad_mux_sel_IO_GPIO12 = (`PAD_MUX_REG_PATH.a_12_mux_sel.q == PAD_MUX_GROUP_A_12_SEL_GPIO_B_GPIO12);
        assign alt_3_pad_periphs_a_13_pad_mux_sel_IO_GPIO13 = (`PAD_MUX_REG_PATH.a_13_mux_sel.q == PAD_MUX_GROUP_A_13_SEL_GPIO_B_GPIO13);
        assign alt_3_pad_periphs_a_14_pad_mux_sel_IO_GPIO14 = (`PAD_MUX_REG_PATH.a_14_mux_sel.q == PAD_MUX_GROUP_A_14_SEL_GPIO_B_GPIO14);
        assign alt_3_pad_periphs_a_15_pad_mux_sel_IO_GPIO15 = (`PAD_MUX_REG_PATH.a_15_mux_sel.q == PAD_MUX_GROUP_A_15_SEL_GPIO_B_GPIO15);
        assign alt_3_pad_periphs_a_16_pad_mux_sel_IO_GPIO16 = (`PAD_MUX_REG_PATH.a_16_mux_sel.q == PAD_MUX_GROUP_A_16_SEL_GPIO_B_GPIO16);
        assign alt_3_pad_periphs_a_17_pad_mux_sel_IO_GPIO17 = (`PAD_MUX_REG_PATH.a_17_mux_sel.q == PAD_MUX_GROUP_A_17_SEL_GPIO_B_GPIO17);
        assign alt_3_pad_periphs_a_18_pad_mux_sel_IO_GPIO18 = (`PAD_MUX_REG_PATH.a_18_mux_sel.q == PAD_MUX_GROUP_A_18_SEL_GPIO_B_GPIO18);
        assign alt_3_pad_periphs_a_19_pad_mux_sel_IO_GPIO19 = (`PAD_MUX_REG_PATH.a_19_mux_sel.q == PAD_MUX_GROUP_A_19_SEL_GPIO_B_GPIO19);
        assign alt_3_pad_periphs_a_20_pad_mux_sel_IO_GPIO20 = (`PAD_MUX_REG_PATH.a_20_mux_sel.q == PAD_MUX_GROUP_A_20_SEL_GPIO_B_GPIO20);
        assign alt_3_pad_periphs_a_21_pad_mux_sel_IO_GPIO21 = (`PAD_MUX_REG_PATH.a_21_mux_sel.q == PAD_MUX_GROUP_A_21_SEL_GPIO_B_GPIO21);
        assign alt_3_pad_periphs_a_22_pad_mux_sel_IO_GPIO22 = (`PAD_MUX_REG_PATH.a_22_mux_sel.q == PAD_MUX_GROUP_A_22_SEL_GPIO_B_GPIO22);
        assign alt_3_pad_periphs_a_23_pad_mux_sel_IO_GPIO23 = (`PAD_MUX_REG_PATH.a_23_mux_sel.q == PAD_MUX_GROUP_A_23_SEL_GPIO_B_GPIO23);
        assign alt_3_pad_periphs_a_24_pad_mux_sel_IO_GPIO24 = (`PAD_MUX_REG_PATH.a_24_mux_sel.q == PAD_MUX_GROUP_A_24_SEL_GPIO_B_GPIO24);
        assign alt_3_pad_periphs_a_25_pad_mux_sel_IO_GPIO25 = (`PAD_MUX_REG_PATH.a_25_mux_sel.q == PAD_MUX_GROUP_A_25_SEL_GPIO_B_GPIO25);
        assign alt_3_pad_periphs_a_26_pad_mux_sel_IO_GPIO26 = (`PAD_MUX_REG_PATH.a_26_mux_sel.q == PAD_MUX_GROUP_A_26_SEL_GPIO_B_GPIO26);
        assign alt_3_pad_periphs_a_27_pad_mux_sel_IO_GPIO27 = (`PAD_MUX_REG_PATH.a_27_mux_sel.q == PAD_MUX_GROUP_A_27_SEL_GPIO_B_GPIO27);
        assign alt_3_pad_periphs_a_28_pad_mux_sel_IO_GPIO28 = (`PAD_MUX_REG_PATH.a_28_mux_sel.q == PAD_MUX_GROUP_A_28_SEL_GPIO_B_GPIO28);
        assign alt_3_pad_periphs_a_29_pad_mux_sel_IO_GPIO29 = (`PAD_MUX_REG_PATH.a_29_mux_sel.q == PAD_MUX_GROUP_A_29_SEL_GPIO_B_GPIO29);
        assign alt_0_pad_periphs_b_00_pad_mux_sel_TLM1_USART0_TX  = (`PAD_MUX_REG_PATH.b_00_mux_sel.q == PAD_MUX_GROUP_B_00_SEL_USART0_UART_TX);
        assign alt_0_pad_periphs_b_01_pad_mux_sel_TLM1_USART0_RX  = (`PAD_MUX_REG_PATH.b_01_mux_sel.q == PAD_MUX_GROUP_B_01_SEL_USART0_UART_RX);
        assign alt_0_pad_periphs_b_02_pad_mux_sel_TLM1_USART0_RTS = (`PAD_MUX_REG_PATH.b_02_mux_sel.q == PAD_MUX_GROUP_B_02_SEL_USART0_UART_RTS);
        assign alt_0_pad_periphs_b_03_pad_mux_sel_TLM1_USART0_CTS = (`PAD_MUX_REG_PATH.b_03_mux_sel.q == PAD_MUX_GROUP_B_03_SEL_USART0_UART_CTS);
        assign alt_0_pad_periphs_b_04_pad_mux_sel_ADC0_SPI4_SCK   = (`PAD_MUX_REG_PATH.b_04_mux_sel.q == PAD_MUX_GROUP_B_04_SEL_SPI4_SPI_SCK);
        assign alt_0_pad_periphs_b_05_pad_mux_sel_ADC0_SPI4_CS    = (`PAD_MUX_REG_PATH.b_05_mux_sel.q == PAD_MUX_GROUP_B_05_SEL_SPI4_SPI_CS0);
        assign alt_0_pad_periphs_b_06_pad_mux_sel_ADC0_SPI4_MISO  = (`PAD_MUX_REG_PATH.b_06_mux_sel.q == PAD_MUX_GROUP_B_06_SEL_SPI4_SPI_MISO);
        assign alt_0_pad_periphs_b_07_pad_mux_sel_ADC0_SPI4_MOSI  = (`PAD_MUX_REG_PATH.b_07_mux_sel.q == PAD_MUX_GROUP_B_07_SEL_SPI4_SPI_MOSI);
        assign alt_0_pad_periphs_b_08_pad_mux_sel_PMIC_I2C2_SCL   = (`PAD_MUX_REG_PATH.b_08_mux_sel.q == PAD_MUX_GROUP_B_08_SEL_I2C2_I2C_SCL);
        assign alt_0_pad_periphs_b_09_pad_mux_sel_PMIC_I2C2_SDA   = (`PAD_MUX_REG_PATH.b_09_mux_sel.q == PAD_MUX_GROUP_B_09_SEL_I2C2_I2C_SDA);
        assign alt_0_pad_periphs_b_10_pad_mux_sel_EXT1_SPI7_SCK   = (`PAD_MUX_REG_PATH.b_10_mux_sel.q == PAD_MUX_GROUP_B_10_SEL_SPI7_SPI_SCK);
        assign alt_0_pad_periphs_b_11_pad_mux_sel_EXT1_SPI7_MISO  = (`PAD_MUX_REG_PATH.b_11_mux_sel.q == PAD_MUX_GROUP_B_11_SEL_SPI7_SPI_MISO);
        assign alt_0_pad_periphs_b_12_pad_mux_sel_EXT1_SPI7_MOSI  = (`PAD_MUX_REG_PATH.b_12_mux_sel.q == PAD_MUX_GROUP_B_12_SEL_SPI7_SPI_MOSI);
        assign alt_0_pad_periphs_b_13_pad_mux_sel_EXT1_SPI7_CS0   = (`PAD_MUX_REG_PATH.b_13_mux_sel.q == PAD_MUX_GROUP_B_13_SEL_SPI7_SPI_CS0);
        assign alt_0_pad_periphs_b_14_pad_mux_sel_EXT1_SPI7_CS1   = (`PAD_MUX_REG_PATH.b_14_mux_sel.q == PAD_MUX_GROUP_B_14_SEL_SPI7_SPI_CS1);
        assign alt_0_pad_periphs_b_15_pad_mux_sel_EXT2_I2C4_SCL   = (`PAD_MUX_REG_PATH.b_15_mux_sel.q == PAD_MUX_GROUP_B_15_SEL_I2C4_I2C_SCL);
        assign alt_0_pad_periphs_b_16_pad_mux_sel_EXT2_I2C4_SDA   = (`PAD_MUX_REG_PATH.b_16_mux_sel.q == PAD_MUX_GROUP_B_16_SEL_I2C4_I2C_SDA);
        assign alt_0_pad_periphs_b_17_pad_mux_sel_EXT3_UART1_TX   = (`PAD_MUX_REG_PATH.b_17_mux_sel.q == PAD_MUX_GROUP_B_17_SEL_UART1_UART_TX);
        assign alt_0_pad_periphs_b_18_pad_mux_sel_EXT3_UART1_RX   = (`PAD_MUX_REG_PATH.b_18_mux_sel.q == PAD_MUX_GROUP_B_18_SEL_UART1_UART_RX);
        assign alt_0_pad_periphs_b_19_pad_mux_sel_IO_USART1_TX    = (`PAD_MUX_REG_PATH.b_19_mux_sel.q == PAD_MUX_GROUP_B_19_SEL_USART1_UART_TX);
        assign alt_0_pad_periphs_b_20_pad_mux_sel_IO_USART1_RX    = (`PAD_MUX_REG_PATH.b_20_mux_sel.q == PAD_MUX_GROUP_B_20_SEL_USART1_UART_RX);
        assign alt_0_pad_periphs_b_21_pad_mux_sel_IO_USART1_RTS   = (`PAD_MUX_REG_PATH.b_21_mux_sel.q == PAD_MUX_GROUP_B_21_SEL_USART1_UART_RTS);
        assign alt_0_pad_periphs_b_22_pad_mux_sel_IO_USART1_CTS   = (`PAD_MUX_REG_PATH.b_22_mux_sel.q == PAD_MUX_GROUP_B_22_SEL_USART1_UART_CTS);
        assign alt_0_pad_periphs_b_23_pad_mux_sel_ETH_RST         = (`PAD_MUX_REG_PATH.b_23_mux_sel.q == PAD_MUX_GROUP_B_23_SEL_ETH_ETH_RST);
        assign alt_0_pad_periphs_b_24_pad_mux_sel_ETH_RXCK        = (`PAD_MUX_REG_PATH.b_24_mux_sel.q == PAD_MUX_GROUP_B_24_SEL_ETH_ETH_RXCK);
        assign alt_0_pad_periphs_b_25_pad_mux_sel_ETH_RXCTL       = (`PAD_MUX_REG_PATH.b_25_mux_sel.q == PAD_MUX_GROUP_B_25_SEL_ETH_ETH_RXCTL);
        assign alt_0_pad_periphs_b_26_pad_mux_sel_ETH_RXD0        = (`PAD_MUX_REG_PATH.b_26_mux_sel.q == PAD_MUX_GROUP_B_26_SEL_ETH_ETH_RXD0);
        assign alt_0_pad_periphs_b_27_pad_mux_sel_ETH_RXD1        = (`PAD_MUX_REG_PATH.b_27_mux_sel.q == PAD_MUX_GROUP_B_27_SEL_ETH_ETH_RXD1);
        assign alt_0_pad_periphs_b_28_pad_mux_sel_ETH_RXD2        = (`PAD_MUX_REG_PATH.b_28_mux_sel.q == PAD_MUX_GROUP_B_28_SEL_ETH_ETH_RXD2);
        assign alt_0_pad_periphs_b_29_pad_mux_sel_ETH_RXD3        = (`PAD_MUX_REG_PATH.b_29_mux_sel.q == PAD_MUX_GROUP_B_29_SEL_ETH_ETH_RXD3);
        assign alt_0_pad_periphs_b_30_pad_mux_sel_ETH_TXCK        = (`PAD_MUX_REG_PATH.b_30_mux_sel.q == PAD_MUX_GROUP_B_30_SEL_ETH_ETH_TXCK);
        assign alt_0_pad_periphs_b_31_pad_mux_sel_ETH_TXCTL       = (`PAD_MUX_REG_PATH.b_31_mux_sel.q == PAD_MUX_GROUP_B_31_SEL_ETH_ETH_TXCTL);
        assign alt_0_pad_periphs_b_32_pad_mux_sel_ETH_TXD0        = (`PAD_MUX_REG_PATH.b_32_mux_sel.q == PAD_MUX_GROUP_B_32_SEL_ETH_ETH_TXD0);
        assign alt_0_pad_periphs_b_33_pad_mux_sel_ETH_TXD1        = (`PAD_MUX_REG_PATH.b_33_mux_sel.q == PAD_MUX_GROUP_B_33_SEL_ETH_ETH_TXD1);
        assign alt_0_pad_periphs_b_34_pad_mux_sel_ETH_TXD2        = (`PAD_MUX_REG_PATH.b_34_mux_sel.q == PAD_MUX_GROUP_B_34_SEL_ETH_ETH_TXD2);
        assign alt_0_pad_periphs_b_35_pad_mux_sel_ETH_TXD3        = (`PAD_MUX_REG_PATH.b_35_mux_sel.q == PAD_MUX_GROUP_B_35_SEL_ETH_ETH_TXD3);
        assign alt_0_pad_periphs_b_36_pad_mux_sel_ETH_MDIO        = (`PAD_MUX_REG_PATH.b_36_mux_sel.q == PAD_MUX_GROUP_B_36_SEL_ETH_ETH_MDIO);
        assign alt_0_pad_periphs_b_37_pad_mux_sel_ETH_MDC         = (`PAD_MUX_REG_PATH.b_37_mux_sel.q == PAD_MUX_GROUP_B_37_SEL_ETH_ETH_MDC);
        assign alt_0_pad_periphs_b_38_pad_mux_sel_USB1_SPI10_SCK  = (`PAD_MUX_REG_PATH.b_38_mux_sel.q == PAD_MUX_GROUP_B_38_SEL_SPI10_SPI_SCK);
        assign alt_0_pad_periphs_b_39_pad_mux_sel_USB1_SPI10_CS   = (`PAD_MUX_REG_PATH.b_39_mux_sel.q == PAD_MUX_GROUP_B_39_SEL_SPI10_SPI_CS0);
        assign alt_0_pad_periphs_b_40_pad_mux_sel_USB1_SPI10_MISO = (`PAD_MUX_REG_PATH.b_40_mux_sel.q == PAD_MUX_GROUP_B_40_SEL_SPI10_SPI_MISO);
        assign alt_0_pad_periphs_b_41_pad_mux_sel_USB1_SPI10_MOSI = (`PAD_MUX_REG_PATH.b_41_mux_sel.q == PAD_MUX_GROUP_B_41_SEL_SPI10_SPI_MOSI);
        assign alt_0_pad_periphs_b_42_pad_mux_sel_CAN0_TX         = (`PAD_MUX_REG_PATH.b_42_mux_sel.q == PAD_MUX_GROUP_B_42_SEL_CAN0_CAN_TX);
        assign alt_0_pad_periphs_b_43_pad_mux_sel_CAN0_RX         = (`PAD_MUX_REG_PATH.b_43_mux_sel.q == PAD_MUX_GROUP_B_43_SEL_CAN0_CAN_RX);
        assign alt_0_pad_periphs_b_44_pad_mux_sel_PWM0_CHANNEL1   = (`PAD_MUX_REG_PATH.b_44_mux_sel.q == PAD_MUX_GROUP_B_44_SEL_PWM1_PWM0);
        assign alt_0_pad_periphs_b_45_pad_mux_sel_PWM1_CHANNEL1   = (`PAD_MUX_REG_PATH.b_45_mux_sel.q == PAD_MUX_GROUP_B_45_SEL_PWM1_PWM1);
        assign alt_0_pad_periphs_b_46_pad_mux_sel_PWM2_CHANNEL1   = (`PAD_MUX_REG_PATH.b_46_mux_sel.q == PAD_MUX_GROUP_B_46_SEL_PWM1_PWM2);
        assign alt_0_pad_periphs_b_47_pad_mux_sel_PWM3_CHANNEL1   = (`PAD_MUX_REG_PATH.b_47_mux_sel.q == PAD_MUX_GROUP_B_47_SEL_PWM1_PWM3);
        assign alt_1_pad_periphs_b_00_pad_mux_sel_WIRELESS_SDIO1_D0  = (`PAD_MUX_REG_PATH.b_00_mux_sel.q == PAD_MUX_GROUP_B_00_SEL_SDIO1_SDIO_DATA0);
        assign alt_1_pad_periphs_b_01_pad_mux_sel_WIRELESS_SDIO1_D1  = (`PAD_MUX_REG_PATH.b_01_mux_sel.q == PAD_MUX_GROUP_B_01_SEL_SDIO1_SDIO_DATA1);
        assign alt_1_pad_periphs_b_02_pad_mux_sel_WIRELESS_SDIO1_D2  = (`PAD_MUX_REG_PATH.b_02_mux_sel.q == PAD_MUX_GROUP_B_02_SEL_SDIO1_SDIO_DATA2);
        assign alt_1_pad_periphs_b_03_pad_mux_sel_WIRELESS_SDIO1_D3  = (`PAD_MUX_REG_PATH.b_03_mux_sel.q == PAD_MUX_GROUP_B_03_SEL_SDIO1_SDIO_DATA3);
        assign alt_1_pad_periphs_b_04_pad_mux_sel_WIRELESS_SDIO1_CLK = (`PAD_MUX_REG_PATH.b_04_mux_sel.q == PAD_MUX_GROUP_B_04_SEL_SDIO1_SDIO_CLK);
        assign alt_1_pad_periphs_b_05_pad_mux_sel_WIRELESS_SDIO1_CMD = (`PAD_MUX_REG_PATH.b_05_mux_sel.q == PAD_MUX_GROUP_B_05_SEL_SDIO1_SDIO_CMD);
        assign alt_1_pad_periphs_b_06_pad_mux_sel_IMU1_SPI0_SCK      = (`PAD_MUX_REG_PATH.b_06_mux_sel.q == PAD_MUX_GROUP_B_06_SEL_SPI0_SPI_SCK);
        assign alt_1_pad_periphs_b_07_pad_mux_sel_IMU1_SPI0_CS       = (`PAD_MUX_REG_PATH.b_07_mux_sel.q == PAD_MUX_GROUP_B_07_SEL_SPI0_SPI_CS0);
        assign alt_1_pad_periphs_b_08_pad_mux_sel_IMU1_SPI0_MISO     = (`PAD_MUX_REG_PATH.b_08_mux_sel.q == PAD_MUX_GROUP_B_08_SEL_SPI0_SPI_MISO);
        assign alt_1_pad_periphs_b_09_pad_mux_sel_IMU1_SPI0_MOSI     = (`PAD_MUX_REG_PATH.b_09_mux_sel.q == PAD_MUX_GROUP_B_09_SEL_SPI0_SPI_MOSI);
        assign alt_1_pad_periphs_b_10_pad_mux_sel_TLM1_USART0_TX     = (`PAD_MUX_REG_PATH.b_10_mux_sel.q == PAD_MUX_GROUP_B_10_SEL_USART0_UART_TX);
        assign alt_1_pad_periphs_b_11_pad_mux_sel_TLM1_USART0_RX     = (`PAD_MUX_REG_PATH.b_11_mux_sel.q == PAD_MUX_GROUP_B_11_SEL_USART0_UART_RX);
        assign alt_1_pad_periphs_b_12_pad_mux_sel_TLM1_USART0_RTS    = (`PAD_MUX_REG_PATH.b_12_mux_sel.q == PAD_MUX_GROUP_B_12_SEL_USART0_UART_RTS);
        assign alt_1_pad_periphs_b_13_pad_mux_sel_TLM1_USART0_CTS    = (`PAD_MUX_REG_PATH.b_13_mux_sel.q == PAD_MUX_GROUP_B_13_SEL_USART0_UART_CTS);
        assign alt_1_pad_periphs_b_14_pad_mux_sel_ADC0_SPI4_SCK      = (`PAD_MUX_REG_PATH.b_14_mux_sel.q == PAD_MUX_GROUP_B_14_SEL_SPI4_SPI_SCK);
        assign alt_1_pad_periphs_b_15_pad_mux_sel_ADC0_SPI4_CS       = (`PAD_MUX_REG_PATH.b_15_mux_sel.q == PAD_MUX_GROUP_B_15_SEL_SPI4_SPI_CS0);
        assign alt_1_pad_periphs_b_16_pad_mux_sel_ADC0_SPI4_MISO     = (`PAD_MUX_REG_PATH.b_16_mux_sel.q == PAD_MUX_GROUP_B_16_SEL_SPI4_SPI_MISO);
        assign alt_1_pad_periphs_b_17_pad_mux_sel_ADC0_SPI4_MOSI     = (`PAD_MUX_REG_PATH.b_17_mux_sel.q == PAD_MUX_GROUP_B_17_SEL_SPI4_SPI_MOSI);
        assign alt_1_pad_periphs_b_18_pad_mux_sel_FRAM_SPI2_SCK      = (`PAD_MUX_REG_PATH.b_18_mux_sel.q == PAD_MUX_GROUP_B_18_SEL_SPI2_SPI_SCK);
        assign alt_1_pad_periphs_b_19_pad_mux_sel_FRAM_SPI2_CS       = (`PAD_MUX_REG_PATH.b_19_mux_sel.q == PAD_MUX_GROUP_B_19_SEL_SPI2_SPI_CS0);
        assign alt_1_pad_periphs_b_20_pad_mux_sel_FRAM_SPI2_MISO     = (`PAD_MUX_REG_PATH.b_20_mux_sel.q == PAD_MUX_GROUP_B_20_SEL_SPI2_SPI_MISO);
        assign alt_1_pad_periphs_b_21_pad_mux_sel_FRAM_SPI2_MOSI     = (`PAD_MUX_REG_PATH.b_21_mux_sel.q == PAD_MUX_GROUP_B_21_SEL_SPI2_SPI_MOSI);
        assign alt_1_pad_periphs_b_22_pad_mux_sel_ADIO1_SPI3_SCK     = (`PAD_MUX_REG_PATH.b_22_mux_sel.q == PAD_MUX_GROUP_B_22_SEL_SPI3_SPI_SCK);
        assign alt_1_pad_periphs_b_23_pad_mux_sel_ADIO1_SPI3_CS      = (`PAD_MUX_REG_PATH.b_23_mux_sel.q == PAD_MUX_GROUP_B_23_SEL_SPI3_SPI_CS0);
        assign alt_1_pad_periphs_b_24_pad_mux_sel_ADIO1_SPI3_MISO    = (`PAD_MUX_REG_PATH.b_24_mux_sel.q == PAD_MUX_GROUP_B_24_SEL_SPI3_SPI_MISO);
        assign alt_1_pad_periphs_b_25_pad_mux_sel_ADIO1_SPI3_MOSI    = (`PAD_MUX_REG_PATH.b_25_mux_sel.q == PAD_MUX_GROUP_B_25_SEL_SPI3_SPI_MOSI);
        assign alt_1_pad_periphs_b_26_pad_mux_sel_MAG_SPI1_SCK       = (`PAD_MUX_REG_PATH.b_26_mux_sel.q == PAD_MUX_GROUP_B_26_SEL_SPI1_SPI_SCK);
        assign alt_1_pad_periphs_b_27_pad_mux_sel_MAG_SPI1_CS        = (`PAD_MUX_REG_PATH.b_27_mux_sel.q == PAD_MUX_GROUP_B_27_SEL_SPI1_SPI_CS0);
        assign alt_1_pad_periphs_b_28_pad_mux_sel_MAG_SPI1_MISO      = (`PAD_MUX_REG_PATH.b_28_mux_sel.q == PAD_MUX_GROUP_B_28_SEL_SPI1_SPI_MISO);
        assign alt_1_pad_periphs_b_29_pad_mux_sel_MAG_SPI1_MOSI      = (`PAD_MUX_REG_PATH.b_29_mux_sel.q == PAD_MUX_GROUP_B_29_SEL_SPI1_SPI_MOSI);
        assign alt_1_pad_periphs_b_30_pad_mux_sel_CAN1_TX            = (`PAD_MUX_REG_PATH.b_30_mux_sel.q == PAD_MUX_GROUP_B_30_SEL_CAN1_CAN_TX);
        assign alt_1_pad_periphs_b_31_pad_mux_sel_CAN1_RX            = (`PAD_MUX_REG_PATH.b_31_mux_sel.q == PAD_MUX_GROUP_B_31_SEL_CAN1_CAN_RX);
        assign alt_1_pad_periphs_b_32_pad_mux_sel_PWM0_CHANNEL1      = (`PAD_MUX_REG_PATH.b_32_mux_sel.q == PAD_MUX_GROUP_B_32_SEL_PWM1_PWM0);
        assign alt_1_pad_periphs_b_33_pad_mux_sel_PWM1_CHANNEL1      = (`PAD_MUX_REG_PATH.b_33_mux_sel.q == PAD_MUX_GROUP_B_33_SEL_PWM1_PWM1);
        assign alt_1_pad_periphs_b_34_pad_mux_sel_PWM2_CHANNEL1      = (`PAD_MUX_REG_PATH.b_34_mux_sel.q == PAD_MUX_GROUP_B_34_SEL_PWM1_PWM2);
        assign alt_1_pad_periphs_b_35_pad_mux_sel_PWM3_CHANNEL1      = (`PAD_MUX_REG_PATH.b_35_mux_sel.q == PAD_MUX_GROUP_B_35_SEL_PWM1_PWM3);
        assign alt_1_pad_periphs_b_36_pad_mux_sel_CAM1_CPI1_CLK      = (`PAD_MUX_REG_PATH.b_36_mux_sel.q == PAD_MUX_GROUP_B_36_SEL_CAM1_CAM_PCLK);
        assign alt_1_pad_periphs_b_37_pad_mux_sel_CAM1_CPI1_VSYNC    = (`PAD_MUX_REG_PATH.b_37_mux_sel.q == PAD_MUX_GROUP_B_37_SEL_CAM1_CAM_VSYNC);
        assign alt_1_pad_periphs_b_38_pad_mux_sel_CAM1_CPI1_HSYNC    = (`PAD_MUX_REG_PATH.b_38_mux_sel.q == PAD_MUX_GROUP_B_38_SEL_CAM1_CAM_HSYNC);
        assign alt_1_pad_periphs_b_39_pad_mux_sel_CAM1_CPI1_DAT0     = (`PAD_MUX_REG_PATH.b_39_mux_sel.q == PAD_MUX_GROUP_B_39_SEL_CAM1_CAM_DATA0_I);
        assign alt_1_pad_periphs_b_40_pad_mux_sel_CAM1_CPI1_DAT1     = (`PAD_MUX_REG_PATH.b_40_mux_sel.q == PAD_MUX_GROUP_B_40_SEL_CAM1_CAM_DATA1_I);
        assign alt_1_pad_periphs_b_41_pad_mux_sel_CAM1_CPI1_DAT2     = (`PAD_MUX_REG_PATH.b_41_mux_sel.q == PAD_MUX_GROUP_B_41_SEL_CAM1_CAM_DATA2_I);
        assign alt_1_pad_periphs_b_42_pad_mux_sel_CAM1_CPI1_DAT3     = (`PAD_MUX_REG_PATH.b_42_mux_sel.q == PAD_MUX_GROUP_B_42_SEL_CAM1_CAM_DATA3_I);
        assign alt_1_pad_periphs_b_43_pad_mux_sel_CAM1_CPI1_DAT4     = (`PAD_MUX_REG_PATH.b_43_mux_sel.q == PAD_MUX_GROUP_B_43_SEL_CAM1_CAM_DATA4_I);
        assign alt_1_pad_periphs_b_44_pad_mux_sel_CAM1_CPI1_DAT5     = (`PAD_MUX_REG_PATH.b_44_mux_sel.q == PAD_MUX_GROUP_B_44_SEL_CAM1_CAM_DATA5_I);
        assign alt_1_pad_periphs_b_45_pad_mux_sel_CAM1_CPI1_DAT6     = (`PAD_MUX_REG_PATH.b_45_mux_sel.q == PAD_MUX_GROUP_B_45_SEL_CAM1_CAM_DATA6_I);
        assign alt_1_pad_periphs_b_46_pad_mux_sel_CAM1_CPI1_DAT7     = (`PAD_MUX_REG_PATH.b_46_mux_sel.q == PAD_MUX_GROUP_B_46_SEL_CAM1_CAM_DATA7_I);
        assign alt_1_pad_periphs_b_47_pad_mux_sel_FLL_CVA6           = (`PAD_MUX_REG_PATH.b_47_mux_sel.q == PAD_MUX_GROUP_B_47_SEL_FLL_CVA6_CLK_CVA6);
        assign alt_2_pad_periphs_b_00_pad_mux_sel_IO_GPIO00 = (`PAD_MUX_REG_PATH.b_00_mux_sel.q == PAD_MUX_GROUP_B_00_SEL_GPIO_B_GPIO0);
        assign alt_2_pad_periphs_b_01_pad_mux_sel_IO_GPIO01 = (`PAD_MUX_REG_PATH.b_01_mux_sel.q == PAD_MUX_GROUP_B_01_SEL_GPIO_B_GPIO1);
        assign alt_2_pad_periphs_b_02_pad_mux_sel_IO_GPIO02 = (`PAD_MUX_REG_PATH.b_02_mux_sel.q == PAD_MUX_GROUP_B_02_SEL_GPIO_B_GPIO2);
        assign alt_2_pad_periphs_b_03_pad_mux_sel_IO_GPIO03 = (`PAD_MUX_REG_PATH.b_03_mux_sel.q == PAD_MUX_GROUP_B_03_SEL_GPIO_B_GPIO3);
        assign alt_2_pad_periphs_b_04_pad_mux_sel_IO_GPIO04 = (`PAD_MUX_REG_PATH.b_04_mux_sel.q == PAD_MUX_GROUP_B_04_SEL_GPIO_B_GPIO4);
        assign alt_2_pad_periphs_b_05_pad_mux_sel_IO_GPIO05 = (`PAD_MUX_REG_PATH.b_05_mux_sel.q == PAD_MUX_GROUP_B_05_SEL_GPIO_B_GPIO5);
        assign alt_2_pad_periphs_b_06_pad_mux_sel_IO_GPIO06 = (`PAD_MUX_REG_PATH.b_06_mux_sel.q == PAD_MUX_GROUP_B_06_SEL_GPIO_B_GPIO6);
        assign alt_2_pad_periphs_b_07_pad_mux_sel_IO_GPIO07 = (`PAD_MUX_REG_PATH.b_07_mux_sel.q == PAD_MUX_GROUP_B_07_SEL_GPIO_B_GPIO7);
        assign alt_2_pad_periphs_b_08_pad_mux_sel_IO_GPIO08 = (`PAD_MUX_REG_PATH.b_08_mux_sel.q == PAD_MUX_GROUP_B_08_SEL_GPIO_B_GPIO8);
        assign alt_2_pad_periphs_b_09_pad_mux_sel_IO_GPIO09 = (`PAD_MUX_REG_PATH.b_09_mux_sel.q == PAD_MUX_GROUP_B_09_SEL_GPIO_B_GPIO9);
        assign alt_2_pad_periphs_b_10_pad_mux_sel_IO_GPIO10 = (`PAD_MUX_REG_PATH.b_10_mux_sel.q == PAD_MUX_GROUP_B_10_SEL_GPIO_B_GPIO10);
        assign alt_2_pad_periphs_b_11_pad_mux_sel_IO_GPIO11 = (`PAD_MUX_REG_PATH.b_11_mux_sel.q == PAD_MUX_GROUP_B_11_SEL_GPIO_B_GPIO11);
        assign alt_2_pad_periphs_b_12_pad_mux_sel_IO_GPIO12 = (`PAD_MUX_REG_PATH.b_12_mux_sel.q == PAD_MUX_GROUP_B_12_SEL_GPIO_B_GPIO12);
        assign alt_2_pad_periphs_b_13_pad_mux_sel_IO_GPIO13 = (`PAD_MUX_REG_PATH.b_13_mux_sel.q == PAD_MUX_GROUP_B_13_SEL_GPIO_B_GPIO13);
        assign alt_2_pad_periphs_b_14_pad_mux_sel_IO_GPIO14 = (`PAD_MUX_REG_PATH.b_14_mux_sel.q == PAD_MUX_GROUP_B_14_SEL_GPIO_B_GPIO14);
        assign alt_2_pad_periphs_b_15_pad_mux_sel_IO_GPIO15 = (`PAD_MUX_REG_PATH.b_15_mux_sel.q == PAD_MUX_GROUP_B_15_SEL_GPIO_B_GPIO15);
        assign alt_2_pad_periphs_b_16_pad_mux_sel_IO_GPIO16 = (`PAD_MUX_REG_PATH.b_16_mux_sel.q == PAD_MUX_GROUP_B_16_SEL_GPIO_B_GPIO16);
        assign alt_2_pad_periphs_b_17_pad_mux_sel_IO_GPIO17 = (`PAD_MUX_REG_PATH.b_17_mux_sel.q == PAD_MUX_GROUP_B_17_SEL_GPIO_B_GPIO17);
        assign alt_2_pad_periphs_b_18_pad_mux_sel_IO_GPIO18 = (`PAD_MUX_REG_PATH.b_18_mux_sel.q == PAD_MUX_GROUP_B_18_SEL_GPIO_B_GPIO18);
        assign alt_2_pad_periphs_b_19_pad_mux_sel_IO_GPIO19 = (`PAD_MUX_REG_PATH.b_19_mux_sel.q == PAD_MUX_GROUP_B_19_SEL_GPIO_B_GPIO19);
        assign alt_2_pad_periphs_b_20_pad_mux_sel_IO_GPIO20 = (`PAD_MUX_REG_PATH.b_20_mux_sel.q == PAD_MUX_GROUP_B_20_SEL_GPIO_B_GPIO20);
        assign alt_2_pad_periphs_b_21_pad_mux_sel_IO_GPIO21 = (`PAD_MUX_REG_PATH.b_21_mux_sel.q == PAD_MUX_GROUP_B_21_SEL_GPIO_B_GPIO21);
        assign alt_2_pad_periphs_b_22_pad_mux_sel_IO_GPIO22 = (`PAD_MUX_REG_PATH.b_22_mux_sel.q == PAD_MUX_GROUP_B_22_SEL_GPIO_B_GPIO22);
        assign alt_2_pad_periphs_b_23_pad_mux_sel_IO_GPIO23 = (`PAD_MUX_REG_PATH.b_23_mux_sel.q == PAD_MUX_GROUP_B_23_SEL_GPIO_B_GPIO23);
        assign alt_2_pad_periphs_b_24_pad_mux_sel_IO_GPIO24 = (`PAD_MUX_REG_PATH.b_24_mux_sel.q == PAD_MUX_GROUP_B_24_SEL_GPIO_B_GPIO24);
        assign alt_2_pad_periphs_b_25_pad_mux_sel_IO_GPIO25 = (`PAD_MUX_REG_PATH.b_25_mux_sel.q == PAD_MUX_GROUP_B_25_SEL_GPIO_B_GPIO25);
        assign alt_2_pad_periphs_b_26_pad_mux_sel_IO_GPIO26 = (`PAD_MUX_REG_PATH.b_26_mux_sel.q == PAD_MUX_GROUP_B_26_SEL_GPIO_B_GPIO26);
        assign alt_2_pad_periphs_b_27_pad_mux_sel_IO_GPIO27 = (`PAD_MUX_REG_PATH.b_27_mux_sel.q == PAD_MUX_GROUP_B_27_SEL_GPIO_B_GPIO27);
        assign alt_2_pad_periphs_b_28_pad_mux_sel_IO_GPIO28 = (`PAD_MUX_REG_PATH.b_28_mux_sel.q == PAD_MUX_GROUP_B_28_SEL_GPIO_B_GPIO28);
        assign alt_2_pad_periphs_b_29_pad_mux_sel_IO_GPIO29 = (`PAD_MUX_REG_PATH.b_29_mux_sel.q == PAD_MUX_GROUP_B_29_SEL_GPIO_B_GPIO29);
        assign alt_2_pad_periphs_b_30_pad_mux_sel_IO_GPIO30 = (`PAD_MUX_REG_PATH.b_30_mux_sel.q == PAD_MUX_GROUP_B_30_SEL_GPIO_B_GPIO30);
        assign alt_2_pad_periphs_b_31_pad_mux_sel_IO_GPIO31 = (`PAD_MUX_REG_PATH.b_31_mux_sel.q == PAD_MUX_GROUP_B_31_SEL_GPIO_B_GPIO31);
        assign alt_2_pad_periphs_b_32_pad_mux_sel_IO_GPIO32 = (`PAD_MUX_REG_PATH.b_32_mux_sel.q == PAD_MUX_GROUP_B_32_SEL_GPIO_B_GPIO32);
        assign alt_2_pad_periphs_b_33_pad_mux_sel_IO_GPIO33 = (`PAD_MUX_REG_PATH.b_33_mux_sel.q == PAD_MUX_GROUP_B_33_SEL_GPIO_B_GPIO33);
        assign alt_2_pad_periphs_b_34_pad_mux_sel_IO_GPIO34 = (`PAD_MUX_REG_PATH.b_34_mux_sel.q == PAD_MUX_GROUP_B_34_SEL_GPIO_B_GPIO34);
        assign alt_2_pad_periphs_b_35_pad_mux_sel_IO_GPIO35 = (`PAD_MUX_REG_PATH.b_35_mux_sel.q == PAD_MUX_GROUP_B_35_SEL_GPIO_B_GPIO35);
        assign alt_2_pad_periphs_b_36_pad_mux_sel_IO_GPIO36 = (`PAD_MUX_REG_PATH.b_36_mux_sel.q == PAD_MUX_GROUP_B_36_SEL_GPIO_B_GPIO36);
        assign alt_2_pad_periphs_b_37_pad_mux_sel_IO_GPIO37 = (`PAD_MUX_REG_PATH.b_37_mux_sel.q == PAD_MUX_GROUP_B_37_SEL_GPIO_B_GPIO37);
        assign alt_2_pad_periphs_b_38_pad_mux_sel_IO_GPIO38 = (`PAD_MUX_REG_PATH.b_38_mux_sel.q == PAD_MUX_GROUP_B_38_SEL_GPIO_B_GPIO38);
        assign alt_2_pad_periphs_b_39_pad_mux_sel_IO_GPIO39 = (`PAD_MUX_REG_PATH.b_39_mux_sel.q == PAD_MUX_GROUP_B_39_SEL_GPIO_B_GPIO39);
        assign alt_2_pad_periphs_b_40_pad_mux_sel_IO_GPIO40 = (`PAD_MUX_REG_PATH.b_40_mux_sel.q == PAD_MUX_GROUP_B_40_SEL_GPIO_B_GPIO40);
        assign alt_2_pad_periphs_b_41_pad_mux_sel_IO_GPIO41 = (`PAD_MUX_REG_PATH.b_41_mux_sel.q == PAD_MUX_GROUP_B_41_SEL_GPIO_B_GPIO41);
        assign alt_2_pad_periphs_b_42_pad_mux_sel_IO_GPIO42 = (`PAD_MUX_REG_PATH.b_42_mux_sel.q == PAD_MUX_GROUP_B_42_SEL_GPIO_B_GPIO42);
        assign alt_2_pad_periphs_b_43_pad_mux_sel_IO_GPIO43 = (`PAD_MUX_REG_PATH.b_43_mux_sel.q == PAD_MUX_GROUP_B_43_SEL_GPIO_B_GPIO43);
        assign alt_2_pad_periphs_b_44_pad_mux_sel_IO_GPIO44 = (`PAD_MUX_REG_PATH.b_44_mux_sel.q == PAD_MUX_GROUP_B_44_SEL_GPIO_B_GPIO44);
        assign alt_2_pad_periphs_b_45_pad_mux_sel_IO_GPIO45 = (`PAD_MUX_REG_PATH.b_45_mux_sel.q == PAD_MUX_GROUP_B_45_SEL_GPIO_B_GPIO45);
        assign alt_2_pad_periphs_b_46_pad_mux_sel_IO_GPIO46 = (`PAD_MUX_REG_PATH.b_46_mux_sel.q == PAD_MUX_GROUP_B_46_SEL_GPIO_B_GPIO46);
        assign alt_2_pad_periphs_b_47_pad_mux_sel_IO_GPIO47 = (`PAD_MUX_REG_PATH.b_47_mux_sel.q == PAD_MUX_GROUP_B_47_SEL_GPIO_B_GPIO47);
        assign alt_3_pad_periphs_b_00_pad_mux_sel_GPS2_UART0_TX   = (`PAD_MUX_REG_PATH.b_00_mux_sel.q == PAD_MUX_GROUP_B_00_SEL_UART0_UART_TX);
        assign alt_3_pad_periphs_b_01_pad_mux_sel_GPS2_UART0_RX   = (`PAD_MUX_REG_PATH.b_01_mux_sel.q == PAD_MUX_GROUP_B_01_SEL_UART0_UART_RX);
        assign alt_3_pad_periphs_b_02_pad_mux_sel_GPS2_I2C1_SCL   = (`PAD_MUX_REG_PATH.b_02_mux_sel.q == PAD_MUX_GROUP_B_02_SEL_I2C1_I2C_SCL);
        assign alt_3_pad_periphs_b_03_pad_mux_sel_GPS2_I2C1_SDA   = (`PAD_MUX_REG_PATH.b_03_mux_sel.q == PAD_MUX_GROUP_B_03_SEL_I2C1_I2C_SDA);
        assign alt_3_pad_periphs_b_04_pad_mux_sel_IMU2_SPI5_SCK   = (`PAD_MUX_REG_PATH.b_04_mux_sel.q == PAD_MUX_GROUP_B_04_SEL_SPI5_SPI_SCK);
        assign alt_3_pad_periphs_b_05_pad_mux_sel_IMU2_SPI5_CS    = (`PAD_MUX_REG_PATH.b_05_mux_sel.q == PAD_MUX_GROUP_B_05_SEL_SPI5_SPI_CS0);
        assign alt_3_pad_periphs_b_06_pad_mux_sel_IMU2_SPI5_MISO  = (`PAD_MUX_REG_PATH.b_06_mux_sel.q == PAD_MUX_GROUP_B_06_SEL_SPI5_SPI_MISO);
        assign alt_3_pad_periphs_b_07_pad_mux_sel_IMU2_SPI5_MOSI  = (`PAD_MUX_REG_PATH.b_07_mux_sel.q == PAD_MUX_GROUP_B_07_SEL_SPI5_SPI_MOSI);
        assign alt_3_pad_periphs_b_08_pad_mux_sel_BARO2_I2C3_SCL  = (`PAD_MUX_REG_PATH.b_08_mux_sel.q == PAD_MUX_GROUP_B_08_SEL_I2C3_I2C_SCL);
        assign alt_3_pad_periphs_b_09_pad_mux_sel_BARO2_I2C3_SDA  = (`PAD_MUX_REG_PATH.b_09_mux_sel.q == PAD_MUX_GROUP_B_09_SEL_I2C3_I2C_SDA);
        assign alt_3_pad_periphs_b_10_pad_mux_sel_IMU3_SPI6_SCK   = (`PAD_MUX_REG_PATH.b_10_mux_sel.q == PAD_MUX_GROUP_B_10_SEL_SPI6_SPI_SCK);
        assign alt_3_pad_periphs_b_11_pad_mux_sel_IMU3_SPI6_CS    = (`PAD_MUX_REG_PATH.b_11_mux_sel.q == PAD_MUX_GROUP_B_11_SEL_SPI6_SPI_CS0);
        assign alt_3_pad_periphs_b_12_pad_mux_sel_IMU3_SPI6_MISO  = (`PAD_MUX_REG_PATH.b_12_mux_sel.q == PAD_MUX_GROUP_B_12_SEL_SPI6_SPI_MISO);
        assign alt_3_pad_periphs_b_13_pad_mux_sel_IMU3_SPI6_MOSI  = (`PAD_MUX_REG_PATH.b_13_mux_sel.q == PAD_MUX_GROUP_B_13_SEL_SPI6_SPI_MOSI);
        assign alt_3_pad_periphs_b_14_pad_mux_sel_TLM2_USART2_TX  = (`PAD_MUX_REG_PATH.b_14_mux_sel.q == PAD_MUX_GROUP_B_14_SEL_USART2_UART_TX);
        assign alt_3_pad_periphs_b_15_pad_mux_sel_TLM2_USART2_RX  = (`PAD_MUX_REG_PATH.b_15_mux_sel.q == PAD_MUX_GROUP_B_15_SEL_USART2_UART_RX);
        assign alt_3_pad_periphs_b_16_pad_mux_sel_TLM2_USART2_RTS = (`PAD_MUX_REG_PATH.b_16_mux_sel.q == PAD_MUX_GROUP_B_16_SEL_USART2_UART_RTS);
        assign alt_3_pad_periphs_b_17_pad_mux_sel_TLM2_USART2_CTS = (`PAD_MUX_REG_PATH.b_17_mux_sel.q == PAD_MUX_GROUP_B_17_SEL_USART2_UART_CTS);
        assign alt_3_pad_periphs_b_18_pad_mux_sel_TLM3_USART3_TX  = (`PAD_MUX_REG_PATH.b_18_mux_sel.q == PAD_MUX_GROUP_B_18_SEL_USART3_UART_TX);
        assign alt_3_pad_periphs_b_19_pad_mux_sel_TLM3_USART3_RX  = (`PAD_MUX_REG_PATH.b_19_mux_sel.q == PAD_MUX_GROUP_B_19_SEL_USART3_UART_RX);
        assign alt_3_pad_periphs_b_20_pad_mux_sel_TLM3_USART3_RTS = (`PAD_MUX_REG_PATH.b_20_mux_sel.q == PAD_MUX_GROUP_B_20_SEL_USART3_UART_RTS);
        assign alt_3_pad_periphs_b_21_pad_mux_sel_TLM3_USART3_CTS = (`PAD_MUX_REG_PATH.b_21_mux_sel.q == PAD_MUX_GROUP_B_21_SEL_USART3_UART_CTS);
        assign alt_3_pad_periphs_b_22_pad_mux_sel_CAN0_SPI8_SCK   = (`PAD_MUX_REG_PATH.b_22_mux_sel.q == PAD_MUX_GROUP_B_22_SEL_SPI8_SPI_SCK);
        assign alt_3_pad_periphs_b_23_pad_mux_sel_CAN0_SPI8_CS    = (`PAD_MUX_REG_PATH.b_23_mux_sel.q == PAD_MUX_GROUP_B_23_SEL_SPI8_SPI_CS0);
        assign alt_3_pad_periphs_b_24_pad_mux_sel_CAN0_SPI8_MISO  = (`PAD_MUX_REG_PATH.b_24_mux_sel.q == PAD_MUX_GROUP_B_24_SEL_SPI8_SPI_MISO);
        assign alt_3_pad_periphs_b_25_pad_mux_sel_CAN0_SPI8_MOSI  = (`PAD_MUX_REG_PATH.b_25_mux_sel.q == PAD_MUX_GROUP_B_25_SEL_SPI8_SPI_MOSI);
        assign alt_3_pad_periphs_b_26_pad_mux_sel_CAN1_SPI9_SCK   = (`PAD_MUX_REG_PATH.b_26_mux_sel.q == PAD_MUX_GROUP_B_26_SEL_SPI9_SPI_SCK);
        assign alt_3_pad_periphs_b_27_pad_mux_sel_CAN1_SPI9_CS    = (`PAD_MUX_REG_PATH.b_27_mux_sel.q == PAD_MUX_GROUP_B_27_SEL_SPI9_SPI_CS0);
        assign alt_3_pad_periphs_b_28_pad_mux_sel_CAN1_SPI9_MISO  = (`PAD_MUX_REG_PATH.b_28_mux_sel.q == PAD_MUX_GROUP_B_28_SEL_SPI9_SPI_MISO);
        assign alt_3_pad_periphs_b_29_pad_mux_sel_CAN1_SPI9_MOSI  = (`PAD_MUX_REG_PATH.b_29_mux_sel.q == PAD_MUX_GROUP_B_29_SEL_SPI9_SPI_MOSI);
        assign alt_3_pad_periphs_b_30_pad_mux_sel_USB1_SPI10_SCK  = (`PAD_MUX_REG_PATH.b_30_mux_sel.q == PAD_MUX_GROUP_B_30_SEL_SPI10_SPI_SCK);
        assign alt_3_pad_periphs_b_31_pad_mux_sel_USB1_SPI10_CS   = (`PAD_MUX_REG_PATH.b_31_mux_sel.q == PAD_MUX_GROUP_B_31_SEL_SPI10_SPI_CS0);
        assign alt_3_pad_periphs_b_32_pad_mux_sel_USB1_SPI10_MISO = (`PAD_MUX_REG_PATH.b_32_mux_sel.q == PAD_MUX_GROUP_B_32_SEL_SPI10_SPI_MISO);
        assign alt_3_pad_periphs_b_33_pad_mux_sel_USB1_SPI10_MOSI = (`PAD_MUX_REG_PATH.b_33_mux_sel.q == PAD_MUX_GROUP_B_33_SEL_SPI10_SPI_MOSI);
        assign alt_3_pad_periphs_b_34_pad_mux_sel_IO_GPIO34       = (`PAD_MUX_REG_PATH.b_34_mux_sel.q == PAD_MUX_GROUP_B_34_SEL_GPIO_B_GPIO34);
        assign alt_3_pad_periphs_b_35_pad_mux_sel_IO_GPIO35       = (`PAD_MUX_REG_PATH.b_35_mux_sel.q == PAD_MUX_GROUP_B_35_SEL_GPIO_B_GPIO35);
        assign alt_3_pad_periphs_b_36_pad_mux_sel_IO_GPIO36       = (`PAD_MUX_REG_PATH.b_36_mux_sel.q == PAD_MUX_GROUP_B_36_SEL_GPIO_B_GPIO36);
        assign alt_3_pad_periphs_b_37_pad_mux_sel_IO_GPIO37       = (`PAD_MUX_REG_PATH.b_37_mux_sel.q == PAD_MUX_GROUP_B_37_SEL_GPIO_B_GPIO37);
        assign alt_3_pad_periphs_b_38_pad_mux_sel_IO_GPIO38       = (`PAD_MUX_REG_PATH.b_38_mux_sel.q == PAD_MUX_GROUP_B_38_SEL_GPIO_B_GPIO38);
        assign alt_3_pad_periphs_b_39_pad_mux_sel_IO_GPIO39       = (`PAD_MUX_REG_PATH.b_39_mux_sel.q == PAD_MUX_GROUP_B_39_SEL_GPIO_B_GPIO39);
        assign alt_3_pad_periphs_b_40_pad_mux_sel_IO_GPIO40       = (`PAD_MUX_REG_PATH.b_40_mux_sel.q == PAD_MUX_GROUP_B_40_SEL_GPIO_B_GPIO40);
        assign alt_3_pad_periphs_b_41_pad_mux_sel_IO_GPIO41       = (`PAD_MUX_REG_PATH.b_41_mux_sel.q == PAD_MUX_GROUP_B_41_SEL_GPIO_B_GPIO41);
        assign alt_3_pad_periphs_b_42_pad_mux_sel_IO_GPIO42       = (`PAD_MUX_REG_PATH.b_42_mux_sel.q == PAD_MUX_GROUP_B_42_SEL_GPIO_B_GPIO42);
        assign alt_3_pad_periphs_b_43_pad_mux_sel_IO_GPIO43       = (`PAD_MUX_REG_PATH.b_43_mux_sel.q == PAD_MUX_GROUP_B_43_SEL_GPIO_B_GPIO43);
        assign alt_3_pad_periphs_b_44_pad_mux_sel_IO_GPIO44       = (`PAD_MUX_REG_PATH.b_44_mux_sel.q == PAD_MUX_GROUP_B_44_SEL_GPIO_B_GPIO44);
        assign alt_3_pad_periphs_b_45_pad_mux_sel_IO_GPIO45       = (`PAD_MUX_REG_PATH.b_45_mux_sel.q == PAD_MUX_GROUP_B_45_SEL_GPIO_B_GPIO45);
        assign alt_3_pad_periphs_b_46_pad_mux_sel_IO_GPIO46       = (`PAD_MUX_REG_PATH.b_46_mux_sel.q == PAD_MUX_GROUP_B_46_SEL_GPIO_B_GPIO46);
        assign alt_3_pad_periphs_b_47_pad_mux_sel_IO_GPIO47       = (`PAD_MUX_REG_PATH.b_47_mux_sel.q == PAD_MUX_GROUP_B_47_SEL_GPIO_B_GPIO47);
      `else // !`ifndef SIMPLE_PADFRAME
        assign alt_0_simple_pad_periphs_00_mux_sel_spi0_cs   = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_00_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_00_SEL_SPI0_SPI_CS0);
        assign alt_0_simple_pad_periphs_01_mux_sel_spi0_ck   = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_01_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_01_SEL_SPI0_SPI_SCK);
        assign alt_0_simple_pad_periphs_02_mux_sel_spi0_so   = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_02_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_02_SEL_SPI0_SPI_MISO);
        assign alt_0_simple_pad_periphs_03_mux_sel_spi0_si   = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_03_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_03_SEL_SPI0_SPI_MOSI);
        assign alt_0_simple_pad_periphs_04_mux_sel_i2c0_scl  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_04_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_04_SEL_I2C0_I2C_SCL);
        assign alt_0_simple_pad_periphs_05_mux_sel_i2c0_sda  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_05_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_05_SEL_I2C0_I2C_SDA);
        assign alt_0_simple_pad_periphs_06_mux_sel_uart0_tx  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_06_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_06_SEL_UART0_UART_TX);
        assign alt_0_simple_pad_periphs_07_mux_sel_uart0_rx  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_07_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_07_SEL_UART0_UART_RX);
        assign alt_0_simple_pad_periphs_08_mux_sel_sdio0_d1  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_08_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_08_SEL_SDIO0_SDIO_DATA0);
        assign alt_0_simple_pad_periphs_09_mux_sel_sdio0_d2  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_09_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_09_SEL_SDIO0_SDIO_DATA1);
        assign alt_0_simple_pad_periphs_10_mux_sel_sdio0_d3  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_10_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_10_SEL_SDIO0_SDIO_DATA2);
        assign alt_0_simple_pad_periphs_11_mux_sel_sdio0_d4  = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_11_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_11_SEL_SDIO0_SDIO_DATA3);
        assign alt_0_simple_pad_periphs_12_mux_sel_sdio0_clk = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_12_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_12_SEL_SDIO0_SDIO_CLK);
        assign alt_0_simple_pad_periphs_13_mux_sel_sdio0_cmd = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_13_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_13_SEL_SDIO0_SDIO_CMD);
        assign alt_1_simple_pad_periphs_00_mux_sel_gpio00 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_00_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_00_SEL_GPIO_B_GPIO0);
        assign alt_1_simple_pad_periphs_01_mux_sel_gpio01 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_01_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_01_SEL_GPIO_B_GPIO1);
        assign alt_1_simple_pad_periphs_02_mux_sel_gpio02 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_02_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_02_SEL_GPIO_B_GPIO2);
        assign alt_1_simple_pad_periphs_03_mux_sel_gpio03 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_03_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_03_SEL_GPIO_B_GPIO3);
        assign alt_1_simple_pad_periphs_04_mux_sel_gpio04 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_04_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_04_SEL_GPIO_B_GPIO4);
        assign alt_1_simple_pad_periphs_05_mux_sel_gpio05 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_05_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_05_SEL_GPIO_B_GPIO5);
        assign alt_1_simple_pad_periphs_06_mux_sel_gpio06 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_06_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_06_SEL_GPIO_B_GPIO6);
        assign alt_1_simple_pad_periphs_07_mux_sel_gpio07 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_07_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_07_SEL_GPIO_B_GPIO7);
        assign alt_1_simple_pad_periphs_08_mux_sel_gpio08 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_08_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_08_SEL_GPIO_B_GPIO8);
        assign alt_1_simple_pad_periphs_09_mux_sel_gpio09 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_09_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_09_SEL_GPIO_B_GPIO9);
        assign alt_1_simple_pad_periphs_10_mux_sel_gpio10 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_10_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_10_SEL_GPIO_B_GPIO10);
        assign alt_1_simple_pad_periphs_11_mux_sel_gpio11 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_11_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_11_SEL_GPIO_B_GPIO11);
        assign alt_1_simple_pad_periphs_12_mux_sel_gpio12 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_12_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_12_SEL_GPIO_B_GPIO12);
        assign alt_1_simple_pad_periphs_13_mux_sel_gpio13 = (`SIMPLE_PAD_MUX_REG_PATH.pad_gpio_b_13_mux_sel.q == PAD_MUX_GROUP_PAD_GPIO_B_13_SEL_GPIO_B_GPIO13);
      `endif
    `endif
  `endif
  //**************************************************
  // VIP MUX SEL END
  //**************************************************

  //**************************************************
  // VIP MUXING BEGINNING
  //**************************************************
  `ifndef TARGET_POST_SYNTH_SIM_TOP
    `ifndef FPGA_EMUL
      `ifndef SIMPLE_PADFRAME
        tranif1 alt_0_a_00_pad_CORE_UART_TX    (pad_periphs_a_00_pad, alt_0_pad_periphs_a_00_pad_CORE_UART_TX   , alt_0_pad_periphs_a_00_pad_mux_sel_CORE_UART_TX   );
        tranif1 alt_0_a_01_pad_CORE_UART_RX    (pad_periphs_a_01_pad, alt_0_pad_periphs_a_01_pad_CORE_UART_RX   , alt_0_pad_periphs_a_01_pad_mux_sel_CORE_UART_RX   );
        tranif1 alt_0_a_02_pad_SDIO0_D1        (pad_periphs_a_02_pad, alt_0_pad_periphs_a_02_pad_SDIO0_D1       , alt_0_pad_periphs_a_02_pad_mux_sel_SDIO0_D1       );
        tranif1 alt_0_a_03_pad_SDIO0_D2        (pad_periphs_a_03_pad, alt_0_pad_periphs_a_03_pad_SDIO0_D2       , alt_0_pad_periphs_a_03_pad_mux_sel_SDIO0_D2       );
        tranif1 alt_0_a_04_pad_SDIO0_D3        (pad_periphs_a_04_pad, alt_0_pad_periphs_a_04_pad_SDIO0_D3       , alt_0_pad_periphs_a_04_pad_mux_sel_SDIO0_D3       );
        tranif1 alt_0_a_05_pad_SDIO0_D4        (pad_periphs_a_05_pad, alt_0_pad_periphs_a_05_pad_SDIO0_D4       , alt_0_pad_periphs_a_05_pad_mux_sel_SDIO0_D4       );
        tranif1 alt_0_a_06_pad_SDIO0_CLK       (pad_periphs_a_06_pad, alt_0_pad_periphs_a_06_pad_SDIO0_CLK      , alt_0_pad_periphs_a_06_pad_mux_sel_SDIO0_CLK      );
        tranif1 alt_0_a_07_pad_SDIO0_CMD       (pad_periphs_a_07_pad, alt_0_pad_periphs_a_07_pad_SDIO0_CMD      , alt_0_pad_periphs_a_07_pad_mux_sel_SDIO0_CMD      );
        tranif1 alt_0_a_08_pad_PWM0_CHANNEL0   (pad_periphs_a_08_pad, alt_0_pad_periphs_a_08_pad_PWM0_CHANNEL0  , alt_0_pad_periphs_a_08_pad_mux_sel_PWM0_CHANNEL0  );
        tranif1 alt_0_a_09_pad_PWM1_CHANNEL0   (pad_periphs_a_09_pad, alt_0_pad_periphs_a_09_pad_PWM1_CHANNEL0  , alt_0_pad_periphs_a_09_pad_mux_sel_PWM1_CHANNEL0  );
        tranif1 alt_0_a_10_pad_PWM2_CHANNEL0   (pad_periphs_a_10_pad, alt_0_pad_periphs_a_10_pad_PWM2_CHANNEL0  , alt_0_pad_periphs_a_10_pad_mux_sel_PWM2_CHANNEL0  );
        tranif1 alt_0_a_11_pad_PWM3_CHANNEL0   (pad_periphs_a_11_pad, alt_0_pad_periphs_a_11_pad_PWM3_CHANNEL0  , alt_0_pad_periphs_a_11_pad_mux_sel_PWM3_CHANNEL0  );
        tranif1 alt_0_a_12_pad_BARO1_I2C0_SCL  (pad_periphs_a_12_pad, alt_0_pad_periphs_a_12_pad_BARO1_I2C0_SCL , alt_0_pad_periphs_a_12_pad_mux_sel_BARO1_I2C0_SCL );
        tranif1 alt_0_a_13_pad_BARO1_I2C0_SDA  (pad_periphs_a_13_pad, alt_0_pad_periphs_a_13_pad_BARO1_I2C0_SDA , alt_0_pad_periphs_a_13_pad_mux_sel_BARO1_I2C0_SDA );
        tranif1 alt_0_a_14_pad_IMU1_SPI0_SCK   (pad_periphs_a_14_pad, alt_0_pad_periphs_a_14_pad_IMU1_SPI0_SCK  , alt_0_pad_periphs_a_14_pad_mux_sel_IMU1_SPI0_SCK  );
        tranif1 alt_0_a_15_pad_IMU1_SPI0_CS    (pad_periphs_a_15_pad, alt_0_pad_periphs_a_15_pad_IMU1_SPI0_CS   , alt_0_pad_periphs_a_15_pad_mux_sel_IMU1_SPI0_CS   );
        tranif1 alt_0_a_16_pad_IMU1_SPI0_MISO  (pad_periphs_a_16_pad, alt_0_pad_periphs_a_16_pad_IMU1_SPI0_MISO , alt_0_pad_periphs_a_16_pad_mux_sel_IMU1_SPI0_MISO );
        tranif1 alt_0_a_17_pad_IMU1_SPI0_MOSI  (pad_periphs_a_17_pad, alt_0_pad_periphs_a_17_pad_IMU1_SPI0_MOSI , alt_0_pad_periphs_a_17_pad_mux_sel_IMU1_SPI0_MOSI );
        tranif1 alt_0_a_18_pad_FRAM_SPI2_SCK   (pad_periphs_a_18_pad, alt_0_pad_periphs_a_18_pad_FRAM_SPI2_SCK  , alt_0_pad_periphs_a_18_pad_mux_sel_FRAM_SPI2_SCK  );
        tranif1 alt_0_a_19_pad_FRAM_SPI2_CS    (pad_periphs_a_19_pad, alt_0_pad_periphs_a_19_pad_FRAM_SPI2_CS   , alt_0_pad_periphs_a_19_pad_mux_sel_FRAM_SPI2_CS   );
        tranif1 alt_0_a_20_pad_FRAM_SPI2_MISO  (pad_periphs_a_20_pad, alt_0_pad_periphs_a_20_pad_FRAM_SPI2_MISO , alt_0_pad_periphs_a_20_pad_mux_sel_FRAM_SPI2_MISO );
        tranif1 alt_0_a_21_pad_FRAM_SPI2_MOSI  (pad_periphs_a_21_pad, alt_0_pad_periphs_a_21_pad_FRAM_SPI2_MOSI , alt_0_pad_periphs_a_21_pad_mux_sel_FRAM_SPI2_MOSI );
        tranif1 alt_0_a_22_pad_ADIO1_SPI3_SCK  (pad_periphs_a_22_pad, alt_0_pad_periphs_a_22_pad_ADIO1_SPI3_SCK , alt_0_pad_periphs_a_22_pad_mux_sel_ADIO1_SPI3_SCK );
        tranif1 alt_0_a_23_pad_ADIO1_SPI3_CS   (pad_periphs_a_23_pad, alt_0_pad_periphs_a_23_pad_ADIO1_SPI3_CS  , alt_0_pad_periphs_a_23_pad_mux_sel_ADIO1_SPI3_CS  );
        tranif1 alt_0_a_24_pad_ADIO1_SPI3_MISO (pad_periphs_a_24_pad, alt_0_pad_periphs_a_24_pad_ADIO1_SPI3_MISO, alt_0_pad_periphs_a_24_pad_mux_sel_ADIO1_SPI3_MISO);
        tranif1 alt_0_a_25_pad_ADIO1_SPI3_MOSI (pad_periphs_a_25_pad, alt_0_pad_periphs_a_25_pad_ADIO1_SPI3_MOSI, alt_0_pad_periphs_a_25_pad_mux_sel_ADIO1_SPI3_MOSI);
        tranif1 alt_0_a_26_pad_GPS2_UART0_TX   (pad_periphs_a_26_pad, alt_0_pad_periphs_a_26_pad_GPS2_UART0_TX  , alt_0_pad_periphs_a_26_pad_mux_sel_GPS2_UART0_TX  );
        tranif1 alt_0_a_27_pad_GPS2_UART0_RX   (pad_periphs_a_27_pad, alt_0_pad_periphs_a_27_pad_GPS2_UART0_RX  , alt_0_pad_periphs_a_27_pad_mux_sel_GPS2_UART0_RX  );
        tranif1 alt_0_a_28_pad_GPS2_I2C1_SCL   (pad_periphs_a_28_pad, alt_0_pad_periphs_a_28_pad_GPS2_I2C1_SCL  , alt_0_pad_periphs_a_28_pad_mux_sel_GPS2_I2C1_SCL  );
        tranif1 alt_0_a_29_pad_GPS2_I2C1_SDA   (pad_periphs_a_29_pad, alt_0_pad_periphs_a_29_pad_GPS2_I2C1_SDA  , alt_0_pad_periphs_a_29_pad_mux_sel_GPS2_I2C1_SDA  );
        tranif1 alt_1_a_00_pad_CORE_UART_TX    (pad_periphs_a_00_pad, alt_1_pad_periphs_a_00_pad_CORE_UART_TX   , alt_1_pad_periphs_a_00_pad_mux_sel_CORE_UART_TX   );
        tranif1 alt_1_a_01_pad_CORE_UART_RX    (pad_periphs_a_01_pad, alt_1_pad_periphs_a_01_pad_CORE_UART_RX   , alt_1_pad_periphs_a_01_pad_mux_sel_CORE_UART_RX   );
        tranif1 alt_1_a_02_pad_LINUX_QSPI_SCK  (pad_periphs_a_02_pad, alt_1_pad_periphs_a_02_pad_LINUX_QSPI_SCK , alt_1_pad_periphs_a_02_pad_mux_sel_LINUX_QSPI_SCK );
        tranif1 alt_1_a_03_pad_LINUX_QSPI_CSN  (pad_periphs_a_03_pad, alt_1_pad_periphs_a_03_pad_LINUX_QSPI_CSN , alt_1_pad_periphs_a_03_pad_mux_sel_LINUX_QSPI_CSN );
        tranif1 alt_1_a_04_pad_LINUX_QSPI_IO0  (pad_periphs_a_04_pad, alt_1_pad_periphs_a_04_pad_LINUX_QSPI_IO0 , alt_1_pad_periphs_a_04_pad_mux_sel_LINUX_QSPI_IO0 );
        tranif1 alt_1_a_05_pad_LINUX_QSPI_IO1  (pad_periphs_a_05_pad, alt_1_pad_periphs_a_05_pad_LINUX_QSPI_IO1 , alt_1_pad_periphs_a_05_pad_mux_sel_LINUX_QSPI_IO1 );
        tranif1 alt_1_a_06_pad_LINUX_QSPI_IO2  (pad_periphs_a_06_pad, alt_1_pad_periphs_a_06_pad_LINUX_QSPI_IO2 , alt_1_pad_periphs_a_06_pad_mux_sel_LINUX_QSPI_IO2 );
        tranif1 alt_1_a_07_pad_LINUX_QSPI_IO3  (pad_periphs_a_07_pad, alt_1_pad_periphs_a_07_pad_LINUX_QSPI_IO3 , alt_1_pad_periphs_a_07_pad_mux_sel_LINUX_QSPI_IO3 );
        tranif1 alt_1_a_08_pad_BARO1_I2C0_SCL  (pad_periphs_a_08_pad, alt_1_pad_periphs_a_08_pad_BARO1_I2C0_SCL , alt_1_pad_periphs_a_08_pad_mux_sel_BARO1_I2C0_SCL );
        tranif1 alt_1_a_09_pad_BARO1_I2C0_SDA  (pad_periphs_a_09_pad, alt_1_pad_periphs_a_09_pad_BARO1_I2C0_SDA , alt_1_pad_periphs_a_09_pad_mux_sel_BARO1_I2C0_SDA );
        tranif1 alt_1_a_10_pad_PWM0_CHANNEL0   (pad_periphs_a_10_pad, alt_1_pad_periphs_a_10_pad_PWM0_CHANNEL0  , alt_1_pad_periphs_a_10_pad_mux_sel_PWM0_CHANNEL0  );
        tranif1 alt_1_a_11_pad_PWM1_CHANNEL0   (pad_periphs_a_11_pad, alt_1_pad_periphs_a_11_pad_PWM1_CHANNEL0  , alt_1_pad_periphs_a_11_pad_mux_sel_PWM1_CHANNEL0  );
        tranif1 alt_1_a_12_pad_PWM2_CHANNEL0   (pad_periphs_a_12_pad, alt_1_pad_periphs_a_12_pad_PWM2_CHANNEL0  , alt_1_pad_periphs_a_12_pad_mux_sel_PWM2_CHANNEL0  );
        tranif1 alt_1_a_13_pad_PWM3_CHANNEL0   (pad_periphs_a_13_pad, alt_1_pad_periphs_a_13_pad_PWM3_CHANNEL0  , alt_1_pad_periphs_a_13_pad_mux_sel_PWM3_CHANNEL0  );
        tranif1 alt_1_a_14_pad_GPS1_UART2_TX   (pad_periphs_a_14_pad, alt_1_pad_periphs_a_14_pad_GPS1_UART2_TX  , alt_1_pad_periphs_a_14_pad_mux_sel_GPS1_UART2_TX  );
        tranif1 alt_1_a_15_pad_GPS1_UART2_RX   (pad_periphs_a_15_pad, alt_1_pad_periphs_a_15_pad_GPS1_UART2_RX  , alt_1_pad_periphs_a_15_pad_mux_sel_GPS1_UART2_RX  );
        tranif1 alt_1_a_16_pad_GPS1_I2C5_SCL   (pad_periphs_a_16_pad, alt_1_pad_periphs_a_16_pad_GPS1_I2C5_SCL  , alt_1_pad_periphs_a_16_pad_mux_sel_GPS1_I2C5_SCL  );
        tranif1 alt_1_a_17_pad_GPS1_I2C5_SDA   (pad_periphs_a_17_pad, alt_1_pad_periphs_a_17_pad_GPS1_I2C5_SDA  , alt_1_pad_periphs_a_17_pad_mux_sel_GPS1_I2C5_SDA  );
        tranif1 alt_1_a_18_pad_CAM0_CPI0_CLK   (pad_periphs_a_18_pad, alt_1_pad_periphs_a_18_pad_CAM0_CPI0_CLK  , alt_1_pad_periphs_a_18_pad_mux_sel_CAM0_CPI0_CLK  );
        tranif1 alt_1_a_19_pad_CAM0_CPI0_VSYNC (pad_periphs_a_19_pad, alt_1_pad_periphs_a_19_pad_CAM0_CPI0_VSYNC, alt_1_pad_periphs_a_19_pad_mux_sel_CAM0_CPI0_VSYNC);
        tranif1 alt_1_a_20_pad_CAM0_CPI0_HSYNC (pad_periphs_a_20_pad, alt_1_pad_periphs_a_20_pad_CAM0_CPI0_HSYNC, alt_1_pad_periphs_a_20_pad_mux_sel_CAM0_CPI0_HSYNC);
        tranif1 alt_1_a_21_pad_CAM0_CPI0_DAT0  (pad_periphs_a_21_pad, alt_1_pad_periphs_a_21_pad_CAM0_CPI0_DAT0 , alt_1_pad_periphs_a_21_pad_mux_sel_CAM0_CPI0_DAT0 );
        tranif1 alt_1_a_22_pad_CAM0_CPI0_DAT1  (pad_periphs_a_22_pad, alt_1_pad_periphs_a_22_pad_CAM0_CPI0_DAT1 , alt_1_pad_periphs_a_22_pad_mux_sel_CAM0_CPI0_DAT1 );
        tranif1 alt_1_a_23_pad_CAM0_CPI0_DAT2  (pad_periphs_a_23_pad, alt_1_pad_periphs_a_23_pad_CAM0_CPI0_DAT2 , alt_1_pad_periphs_a_23_pad_mux_sel_CAM0_CPI0_DAT2 );
        tranif1 alt_1_a_24_pad_CAM0_CPI0_DAT3  (pad_periphs_a_24_pad, alt_1_pad_periphs_a_24_pad_CAM0_CPI0_DAT3 , alt_1_pad_periphs_a_24_pad_mux_sel_CAM0_CPI0_DAT3 );
        tranif1 alt_1_a_25_pad_CAM0_CPI0_DAT4  (pad_periphs_a_25_pad, alt_1_pad_periphs_a_25_pad_CAM0_CPI0_DAT4 , alt_1_pad_periphs_a_25_pad_mux_sel_CAM0_CPI0_DAT4 );
        tranif1 alt_1_a_26_pad_CAM0_CPI0_DAT5  (pad_periphs_a_26_pad, alt_1_pad_periphs_a_26_pad_CAM0_CPI0_DAT5 , alt_1_pad_periphs_a_26_pad_mux_sel_CAM0_CPI0_DAT5 );
        tranif1 alt_1_a_27_pad_CAM0_CPI0_DAT6  (pad_periphs_a_27_pad, alt_1_pad_periphs_a_27_pad_CAM0_CPI0_DAT6 , alt_1_pad_periphs_a_27_pad_mux_sel_CAM0_CPI0_DAT6 );
        tranif1 alt_1_a_28_pad_CAM0_CPI0_DAT7  (pad_periphs_a_28_pad, alt_1_pad_periphs_a_28_pad_CAM0_CPI0_DAT7 , alt_1_pad_periphs_a_28_pad_mux_sel_CAM0_CPI0_DAT7 );
        tranif1 alt_1_a_29_pad_FLL_SOC         (pad_periphs_a_29_pad, alt_1_pad_periphs_a_29_pad_FLL_SOC        , alt_1_pad_periphs_a_29_pad_mux_sel_FLL_SOC        );
        tranif1 alt_2_a_00_pad_CAN0_TX            (pad_periphs_a_00_pad, alt_2_pad_periphs_a_00_pad_CAN0_TX           , alt_2_pad_periphs_a_00_pad_mux_sel_CAN0_TX           );
        tranif1 alt_2_a_01_pad_CAN0_RX            (pad_periphs_a_01_pad, alt_2_pad_periphs_a_01_pad_CAN0_RX           , alt_2_pad_periphs_a_01_pad_mux_sel_CAN0_RX           );
        tranif1 alt_2_a_02_pad_CAN1_TX            (pad_periphs_a_02_pad, alt_2_pad_periphs_a_02_pad_CAN1_TX           , alt_2_pad_periphs_a_02_pad_mux_sel_CAN1_TX           );
        tranif1 alt_2_a_03_pad_CAN1_RX            (pad_periphs_a_03_pad, alt_2_pad_periphs_a_03_pad_CAN1_RX           , alt_2_pad_periphs_a_03_pad_mux_sel_CAN1_RX           );
        tranif1 alt_2_a_04_pad_FLL_SOC            (pad_periphs_a_04_pad, alt_2_pad_periphs_a_04_pad_FLL_SOC           , alt_2_pad_periphs_a_04_pad_mux_sel_FLL_SOC           );
        tranif1 alt_2_a_05_pad_IO_USART1_TX       (pad_periphs_a_05_pad, alt_2_pad_periphs_a_05_pad_IO_USART1_TX      , alt_2_pad_periphs_a_05_pad_mux_sel_IO_USART1_TX      );
        tranif1 alt_2_a_06_pad_IO_USART1_RX       (pad_periphs_a_06_pad, alt_2_pad_periphs_a_06_pad_IO_USART1_RX      , alt_2_pad_periphs_a_06_pad_mux_sel_IO_USART1_RX      );
        tranif1 alt_2_a_07_pad_IO_USART1_RTS      (pad_periphs_a_07_pad, alt_2_pad_periphs_a_07_pad_IO_USART1_RTS     , alt_2_pad_periphs_a_07_pad_mux_sel_IO_USART1_RTS     );
        tranif1 alt_2_a_08_pad_IO_USART1_CTS      (pad_periphs_a_08_pad, alt_2_pad_periphs_a_08_pad_IO_USART1_CTS     , alt_2_pad_periphs_a_08_pad_mux_sel_IO_USART1_CTS     );
        tranif1 alt_2_a_09_pad_WIRELESS_SDIO1_D0  (pad_periphs_a_09_pad, alt_2_pad_periphs_a_09_pad_WIRELESS_SDIO1_D0 , alt_2_pad_periphs_a_09_pad_mux_sel_WIRELESS_SDIO1_D0 );
        tranif1 alt_2_a_10_pad_WIRELESS_SDIO1_D1  (pad_periphs_a_10_pad, alt_2_pad_periphs_a_10_pad_WIRELESS_SDIO1_D1 , alt_2_pad_periphs_a_10_pad_mux_sel_WIRELESS_SDIO1_D1 );
        tranif1 alt_2_a_11_pad_WIRELESS_SDIO1_D2  (pad_periphs_a_11_pad, alt_2_pad_periphs_a_11_pad_WIRELESS_SDIO1_D2 , alt_2_pad_periphs_a_11_pad_mux_sel_WIRELESS_SDIO1_D2 );
        tranif1 alt_2_a_12_pad_WIRELESS_SDIO1_D3  (pad_periphs_a_12_pad, alt_2_pad_periphs_a_12_pad_WIRELESS_SDIO1_D3 , alt_2_pad_periphs_a_12_pad_mux_sel_WIRELESS_SDIO1_D3 );
        tranif1 alt_2_a_13_pad_WIRELESS_SDIO1_CLK (pad_periphs_a_13_pad, alt_2_pad_periphs_a_13_pad_WIRELESS_SDIO1_CLK, alt_2_pad_periphs_a_13_pad_mux_sel_WIRELESS_SDIO1_CLK);
        tranif1 alt_2_a_14_pad_WIRELESS_SDIO1_CMD (pad_periphs_a_14_pad, alt_2_pad_periphs_a_14_pad_WIRELESS_SDIO1_CMD, alt_2_pad_periphs_a_14_pad_mux_sel_WIRELESS_SDIO1_CMD);
        tranif1 alt_2_a_15_pad_ETH_RST            (pad_periphs_a_15_pad, alt_2_pad_periphs_a_15_pad_ETH_RST           , alt_2_pad_periphs_a_15_pad_mux_sel_ETH_RST           );
        tranif1 alt_2_a_16_pad_ETH_RXCK           (pad_periphs_a_16_pad, alt_2_pad_periphs_a_16_pad_ETH_RXCK          , alt_2_pad_periphs_a_16_pad_mux_sel_ETH_RXCK          );
        tranif1 alt_2_a_17_pad_ETH_RXCTL          (pad_periphs_a_17_pad, alt_2_pad_periphs_a_17_pad_ETH_RXCTL         , alt_2_pad_periphs_a_17_pad_mux_sel_ETH_RXCTL         );
        tranif1 alt_2_a_18_pad_ETH_RXD0           (pad_periphs_a_18_pad, alt_2_pad_periphs_a_18_pad_ETH_RXD0          , alt_2_pad_periphs_a_18_pad_mux_sel_ETH_RXD0          );
        tranif1 alt_2_a_19_pad_ETH_RXD1           (pad_periphs_a_19_pad, alt_2_pad_periphs_a_19_pad_ETH_RXD1          , alt_2_pad_periphs_a_19_pad_mux_sel_ETH_RXD1          );
        tranif1 alt_2_a_20_pad_ETH_RXD2           (pad_periphs_a_20_pad, alt_2_pad_periphs_a_20_pad_ETH_RXD2          , alt_2_pad_periphs_a_20_pad_mux_sel_ETH_RXD2          );
        tranif1 alt_2_a_21_pad_ETH_RXD3           (pad_periphs_a_21_pad, alt_2_pad_periphs_a_21_pad_ETH_RXD3          , alt_2_pad_periphs_a_21_pad_mux_sel_ETH_RXD3          );
        tranif1 alt_2_a_22_pad_ETH_TXCK           (pad_periphs_a_22_pad, alt_2_pad_periphs_a_22_pad_ETH_TXCK          , alt_2_pad_periphs_a_22_pad_mux_sel_ETH_TXCK          );
        tranif1 alt_2_a_23_pad_ETH_TXCTL          (pad_periphs_a_23_pad, alt_2_pad_periphs_a_23_pad_ETH_TXCTL         , alt_2_pad_periphs_a_23_pad_mux_sel_ETH_TXCTL         );
        tranif1 alt_2_a_24_pad_ETH_TXD0           (pad_periphs_a_24_pad, alt_2_pad_periphs_a_24_pad_ETH_TXD0          , alt_2_pad_periphs_a_24_pad_mux_sel_ETH_TXD0          );
        tranif1 alt_2_a_25_pad_ETH_TXD1           (pad_periphs_a_25_pad, alt_2_pad_periphs_a_25_pad_ETH_TXD1          , alt_2_pad_periphs_a_25_pad_mux_sel_ETH_TXD1          );
        tranif1 alt_2_a_26_pad_ETH_TXD2           (pad_periphs_a_26_pad, alt_2_pad_periphs_a_26_pad_ETH_TXD2          , alt_2_pad_periphs_a_26_pad_mux_sel_ETH_TXD2          );
        tranif1 alt_2_a_27_pad_ETH_TXD3           (pad_periphs_a_27_pad, alt_2_pad_periphs_a_27_pad_ETH_TXD3          , alt_2_pad_periphs_a_27_pad_mux_sel_ETH_TXD3          );
        tranif1 alt_2_a_28_pad_ETH_MDIO           (pad_periphs_a_28_pad, alt_2_pad_periphs_a_28_pad_ETH_MDIO          , alt_2_pad_periphs_a_28_pad_mux_sel_ETH_MDIO          );
        tranif1 alt_2_a_29_pad_ETH_MDC            (pad_periphs_a_29_pad, alt_2_pad_periphs_a_29_pad_ETH_MDC           , alt_2_pad_periphs_a_29_pad_mux_sel_ETH_MDC           );
        tranif1 alt_3_a_00_pad_IO_GPIO00 (pad_periphs_a_00_pad, alt_3_pad_periphs_a_00_pad_IO_GPIO00, alt_3_pad_periphs_a_00_pad_mux_sel_IO_GPIO00);
        tranif1 alt_3_a_01_pad_IO_GPIO01 (pad_periphs_a_01_pad, alt_3_pad_periphs_a_01_pad_IO_GPIO01, alt_3_pad_periphs_a_01_pad_mux_sel_IO_GPIO01);
        tranif1 alt_3_a_02_pad_IO_GPIO02 (pad_periphs_a_02_pad, alt_3_pad_periphs_a_02_pad_IO_GPIO02, alt_3_pad_periphs_a_02_pad_mux_sel_IO_GPIO02);
        tranif1 alt_3_a_03_pad_IO_GPIO03 (pad_periphs_a_03_pad, alt_3_pad_periphs_a_03_pad_IO_GPIO03, alt_3_pad_periphs_a_03_pad_mux_sel_IO_GPIO03);
        tranif1 alt_3_a_04_pad_IO_GPIO04 (pad_periphs_a_04_pad, alt_3_pad_periphs_a_04_pad_IO_GPIO04, alt_3_pad_periphs_a_04_pad_mux_sel_IO_GPIO04);
        tranif1 alt_3_a_05_pad_IO_GPIO05 (pad_periphs_a_05_pad, alt_3_pad_periphs_a_05_pad_IO_GPIO05, alt_3_pad_periphs_a_05_pad_mux_sel_IO_GPIO05);
        tranif1 alt_3_a_06_pad_IO_GPIO06 (pad_periphs_a_06_pad, alt_3_pad_periphs_a_06_pad_IO_GPIO06, alt_3_pad_periphs_a_06_pad_mux_sel_IO_GPIO06);
        tranif1 alt_3_a_07_pad_IO_GPIO07 (pad_periphs_a_07_pad, alt_3_pad_periphs_a_07_pad_IO_GPIO07, alt_3_pad_periphs_a_07_pad_mux_sel_IO_GPIO07);
        tranif1 alt_3_a_08_pad_IO_GPIO08 (pad_periphs_a_08_pad, alt_3_pad_periphs_a_08_pad_IO_GPIO08, alt_3_pad_periphs_a_08_pad_mux_sel_IO_GPIO08);
        tranif1 alt_3_a_09_pad_IO_GPIO09 (pad_periphs_a_09_pad, alt_3_pad_periphs_a_09_pad_IO_GPIO09, alt_3_pad_periphs_a_09_pad_mux_sel_IO_GPIO09);
        tranif1 alt_3_a_10_pad_IO_GPIO10 (pad_periphs_a_10_pad, alt_3_pad_periphs_a_10_pad_IO_GPIO10, alt_3_pad_periphs_a_10_pad_mux_sel_IO_GPIO10);
        tranif1 alt_3_a_11_pad_IO_GPIO11 (pad_periphs_a_11_pad, alt_3_pad_periphs_a_11_pad_IO_GPIO11, alt_3_pad_periphs_a_11_pad_mux_sel_IO_GPIO11);
        tranif1 alt_3_a_12_pad_IO_GPIO12 (pad_periphs_a_12_pad, alt_3_pad_periphs_a_12_pad_IO_GPIO12, alt_3_pad_periphs_a_12_pad_mux_sel_IO_GPIO12);
        tranif1 alt_3_a_13_pad_IO_GPIO13 (pad_periphs_a_13_pad, alt_3_pad_periphs_a_13_pad_IO_GPIO13, alt_3_pad_periphs_a_13_pad_mux_sel_IO_GPIO13);
        tranif1 alt_3_a_14_pad_IO_GPIO14 (pad_periphs_a_14_pad, alt_3_pad_periphs_a_14_pad_IO_GPIO14, alt_3_pad_periphs_a_14_pad_mux_sel_IO_GPIO14);
        tranif1 alt_3_a_15_pad_IO_GPIO15 (pad_periphs_a_15_pad, alt_3_pad_periphs_a_15_pad_IO_GPIO15, alt_3_pad_periphs_a_15_pad_mux_sel_IO_GPIO15);
        tranif1 alt_3_a_16_pad_IO_GPIO16 (pad_periphs_a_16_pad, alt_3_pad_periphs_a_16_pad_IO_GPIO16, alt_3_pad_periphs_a_16_pad_mux_sel_IO_GPIO16);
        tranif1 alt_3_a_17_pad_IO_GPIO17 (pad_periphs_a_17_pad, alt_3_pad_periphs_a_17_pad_IO_GPIO17, alt_3_pad_periphs_a_17_pad_mux_sel_IO_GPIO17);
        tranif1 alt_3_a_18_pad_IO_GPIO18 (pad_periphs_a_18_pad, alt_3_pad_periphs_a_18_pad_IO_GPIO18, alt_3_pad_periphs_a_18_pad_mux_sel_IO_GPIO18);
        tranif1 alt_3_a_19_pad_IO_GPIO19 (pad_periphs_a_19_pad, alt_3_pad_periphs_a_19_pad_IO_GPIO19, alt_3_pad_periphs_a_19_pad_mux_sel_IO_GPIO19);
        tranif1 alt_3_a_20_pad_IO_GPIO20 (pad_periphs_a_20_pad, alt_3_pad_periphs_a_20_pad_IO_GPIO20, alt_3_pad_periphs_a_20_pad_mux_sel_IO_GPIO20);
        tranif1 alt_3_a_21_pad_IO_GPIO21 (pad_periphs_a_21_pad, alt_3_pad_periphs_a_21_pad_IO_GPIO21, alt_3_pad_periphs_a_21_pad_mux_sel_IO_GPIO21);
        tranif1 alt_3_a_22_pad_IO_GPIO22 (pad_periphs_a_22_pad, alt_3_pad_periphs_a_22_pad_IO_GPIO22, alt_3_pad_periphs_a_22_pad_mux_sel_IO_GPIO22);
        tranif1 alt_3_a_23_pad_IO_GPIO23 (pad_periphs_a_23_pad, alt_3_pad_periphs_a_23_pad_IO_GPIO23, alt_3_pad_periphs_a_23_pad_mux_sel_IO_GPIO23);
        tranif1 alt_3_a_24_pad_IO_GPIO24 (pad_periphs_a_24_pad, alt_3_pad_periphs_a_24_pad_IO_GPIO24, alt_3_pad_periphs_a_24_pad_mux_sel_IO_GPIO24);
        tranif1 alt_3_a_25_pad_IO_GPIO25 (pad_periphs_a_25_pad, alt_3_pad_periphs_a_25_pad_IO_GPIO25, alt_3_pad_periphs_a_25_pad_mux_sel_IO_GPIO25);
        tranif1 alt_3_a_26_pad_IO_GPIO26 (pad_periphs_a_26_pad, alt_3_pad_periphs_a_26_pad_IO_GPIO26, alt_3_pad_periphs_a_26_pad_mux_sel_IO_GPIO26);
        tranif1 alt_3_a_27_pad_IO_GPIO27 (pad_periphs_a_27_pad, alt_3_pad_periphs_a_27_pad_IO_GPIO27, alt_3_pad_periphs_a_27_pad_mux_sel_IO_GPIO27);
        tranif1 alt_3_a_28_pad_IO_GPIO28 (pad_periphs_a_28_pad, alt_3_pad_periphs_a_28_pad_IO_GPIO28, alt_3_pad_periphs_a_28_pad_mux_sel_IO_GPIO28);
        tranif1 alt_3_a_29_pad_IO_GPIO29 (pad_periphs_a_29_pad, alt_3_pad_periphs_a_29_pad_IO_GPIO29, alt_3_pad_periphs_a_29_pad_mux_sel_IO_GPIO29);
        tranif1 alt_0_b_00_pad_TLM1_USART0_TX  (pad_periphs_b_00_pad, alt_0_pad_periphs_b_00_pad_TLM1_USART0_TX , alt_0_pad_periphs_b_00_pad_mux_sel_TLM1_USART0_TX );
        tranif1 alt_0_b_01_pad_TLM1_USART0_RX  (pad_periphs_b_01_pad, alt_0_pad_periphs_b_01_pad_TLM1_USART0_RX , alt_0_pad_periphs_b_01_pad_mux_sel_TLM1_USART0_RX );
        tranif1 alt_0_b_02_pad_TLM1_USART0_RTS (pad_periphs_b_02_pad, alt_0_pad_periphs_b_02_pad_TLM1_USART0_RTS, alt_0_pad_periphs_b_02_pad_mux_sel_TLM1_USART0_RTS);
        tranif1 alt_0_b_03_pad_TLM1_USART0_CTS (pad_periphs_b_03_pad, alt_0_pad_periphs_b_03_pad_TLM1_USART0_CTS, alt_0_pad_periphs_b_03_pad_mux_sel_TLM1_USART0_CTS);
        tranif1 alt_0_b_04_pad_ADC0_SPI4_SCK   (pad_periphs_b_04_pad, alt_0_pad_periphs_b_04_pad_ADC0_SPI4_SCK  , alt_0_pad_periphs_b_04_pad_mux_sel_ADC0_SPI4_SCK  );
        tranif1 alt_0_b_05_pad_ADC0_SPI4_CS    (pad_periphs_b_05_pad, alt_0_pad_periphs_b_05_pad_ADC0_SPI4_CS   , alt_0_pad_periphs_b_05_pad_mux_sel_ADC0_SPI4_CS   );
        tranif1 alt_0_b_06_pad_ADC0_SPI4_MISO  (pad_periphs_b_06_pad, alt_0_pad_periphs_b_06_pad_ADC0_SPI4_MISO , alt_0_pad_periphs_b_06_pad_mux_sel_ADC0_SPI4_MISO );
        tranif1 alt_0_b_07_pad_ADC0_SPI4_MOSI  (pad_periphs_b_07_pad, alt_0_pad_periphs_b_07_pad_ADC0_SPI4_MOSI , alt_0_pad_periphs_b_07_pad_mux_sel_ADC0_SPI4_MOSI );
        tranif1 alt_0_b_08_pad_PMIC_I2C2_SCL   (pad_periphs_b_08_pad, alt_0_pad_periphs_b_08_pad_PMIC_I2C2_SCL  , alt_0_pad_periphs_b_08_pad_mux_sel_PMIC_I2C2_SCL  );
        tranif1 alt_0_b_09_pad_PMIC_I2C2_SDA   (pad_periphs_b_09_pad, alt_0_pad_periphs_b_09_pad_PMIC_I2C2_SDA  , alt_0_pad_periphs_b_09_pad_mux_sel_PMIC_I2C2_SDA  );
        tranif1 alt_0_b_10_pad_EXT1_SPI7_SCK   (pad_periphs_b_10_pad, alt_0_pad_periphs_b_10_pad_EXT1_SPI7_SCK  , alt_0_pad_periphs_b_10_pad_mux_sel_EXT1_SPI7_SCK  );
        tranif1 alt_0_b_11_pad_EXT1_SPI7_MISO  (pad_periphs_b_11_pad, alt_0_pad_periphs_b_11_pad_EXT1_SPI7_MISO , alt_0_pad_periphs_b_11_pad_mux_sel_EXT1_SPI7_MISO );
        tranif1 alt_0_b_12_pad_EXT1_SPI7_MOSI  (pad_periphs_b_12_pad, alt_0_pad_periphs_b_12_pad_EXT1_SPI7_MOSI , alt_0_pad_periphs_b_12_pad_mux_sel_EXT1_SPI7_MOSI );
        tranif1 alt_0_b_13_pad_EXT1_SPI7_CS0   (pad_periphs_b_13_pad, alt_0_pad_periphs_b_13_pad_EXT1_SPI7_CS0  , alt_0_pad_periphs_b_13_pad_mux_sel_EXT1_SPI7_CS0  );
        tranif1 alt_0_b_14_pad_EXT1_SPI7_CS1   (pad_periphs_b_14_pad, alt_0_pad_periphs_b_14_pad_EXT1_SPI7_CS1  , alt_0_pad_periphs_b_14_pad_mux_sel_EXT1_SPI7_CS1  );
        tranif1 alt_0_b_15_pad_EXT2_I2C4_SCL   (pad_periphs_b_15_pad, alt_0_pad_periphs_b_15_pad_EXT2_I2C4_SCL  , alt_0_pad_periphs_b_15_pad_mux_sel_EXT2_I2C4_SCL  );
        tranif1 alt_0_b_16_pad_EXT2_I2C4_SDA   (pad_periphs_b_16_pad, alt_0_pad_periphs_b_16_pad_EXT2_I2C4_SDA  , alt_0_pad_periphs_b_16_pad_mux_sel_EXT2_I2C4_SDA  );
        tranif1 alt_0_b_17_pad_EXT3_UART1_TX   (pad_periphs_b_17_pad, alt_0_pad_periphs_b_17_pad_EXT3_UART1_TX  , alt_0_pad_periphs_b_17_pad_mux_sel_EXT3_UART1_TX  );
        tranif1 alt_0_b_18_pad_EXT3_UART1_RX   (pad_periphs_b_18_pad, alt_0_pad_periphs_b_18_pad_EXT3_UART1_RX  , alt_0_pad_periphs_b_18_pad_mux_sel_EXT3_UART1_RX  );
        tranif1 alt_0_b_19_pad_IO_USART1_TX    (pad_periphs_b_19_pad, alt_0_pad_periphs_b_19_pad_IO_USART1_TX   , alt_0_pad_periphs_b_19_pad_mux_sel_IO_USART1_TX   );
        tranif1 alt_0_b_20_pad_IO_USART1_RX    (pad_periphs_b_20_pad, alt_0_pad_periphs_b_20_pad_IO_USART1_RX   , alt_0_pad_periphs_b_20_pad_mux_sel_IO_USART1_RX   );
        tranif1 alt_0_b_21_pad_IO_USART1_RTS   (pad_periphs_b_21_pad, alt_0_pad_periphs_b_21_pad_IO_USART1_RTS  , alt_0_pad_periphs_b_21_pad_mux_sel_IO_USART1_RTS  );
        tranif1 alt_0_b_22_pad_IO_USART1_CTS   (pad_periphs_b_22_pad, alt_0_pad_periphs_b_22_pad_IO_USART1_CTS  , alt_0_pad_periphs_b_22_pad_mux_sel_IO_USART1_CTS  );
        tranif1 alt_0_b_23_pad_ETH_RST         (pad_periphs_b_23_pad, alt_0_pad_periphs_b_23_pad_ETH_RST        , alt_0_pad_periphs_b_23_pad_mux_sel_ETH_RST        );
        tranif1 alt_0_b_24_pad_ETH_RXCK        (pad_periphs_b_24_pad, alt_0_pad_periphs_b_24_pad_ETH_RXCK       , alt_0_pad_periphs_b_24_pad_mux_sel_ETH_RXCK       );
        tranif1 alt_0_b_25_pad_ETH_RXCTL       (pad_periphs_b_25_pad, alt_0_pad_periphs_b_25_pad_ETH_RXCTL      , alt_0_pad_periphs_b_25_pad_mux_sel_ETH_RXCTL      );
        tranif1 alt_0_b_26_pad_ETH_RXD0        (pad_periphs_b_26_pad, alt_0_pad_periphs_b_26_pad_ETH_RXD0       , alt_0_pad_periphs_b_26_pad_mux_sel_ETH_RXD0       );
        tranif1 alt_0_b_27_pad_ETH_RXD1        (pad_periphs_b_27_pad, alt_0_pad_periphs_b_27_pad_ETH_RXD1       , alt_0_pad_periphs_b_27_pad_mux_sel_ETH_RXD1       );
        tranif1 alt_0_b_28_pad_ETH_RXD2        (pad_periphs_b_28_pad, alt_0_pad_periphs_b_28_pad_ETH_RXD2       , alt_0_pad_periphs_b_28_pad_mux_sel_ETH_RXD2       );
        tranif1 alt_0_b_29_pad_ETH_RXD3        (pad_periphs_b_29_pad, alt_0_pad_periphs_b_29_pad_ETH_RXD3       , alt_0_pad_periphs_b_29_pad_mux_sel_ETH_RXD3       );
        tranif1 alt_0_b_30_pad_ETH_TXCK        (pad_periphs_b_30_pad, alt_0_pad_periphs_b_30_pad_ETH_TXCK       , alt_0_pad_periphs_b_30_pad_mux_sel_ETH_TXCK       );
        tranif1 alt_0_b_31_pad_ETH_TXCTL       (pad_periphs_b_31_pad, alt_0_pad_periphs_b_31_pad_ETH_TXCTL      , alt_0_pad_periphs_b_31_pad_mux_sel_ETH_TXCTL      );
        tranif1 alt_0_b_32_pad_ETH_TXD0        (pad_periphs_b_32_pad, alt_0_pad_periphs_b_32_pad_ETH_TXD0       , alt_0_pad_periphs_b_32_pad_mux_sel_ETH_TXD0       );
        tranif1 alt_0_b_33_pad_ETH_TXD1        (pad_periphs_b_33_pad, alt_0_pad_periphs_b_33_pad_ETH_TXD1       , alt_0_pad_periphs_b_33_pad_mux_sel_ETH_TXD1       );
        tranif1 alt_0_b_34_pad_ETH_TXD2        (pad_periphs_b_34_pad, alt_0_pad_periphs_b_34_pad_ETH_TXD2       , alt_0_pad_periphs_b_34_pad_mux_sel_ETH_TXD2       );
        tranif1 alt_0_b_35_pad_ETH_TXD3        (pad_periphs_b_35_pad, alt_0_pad_periphs_b_35_pad_ETH_TXD3       , alt_0_pad_periphs_b_35_pad_mux_sel_ETH_TXD3       );
        tranif1 alt_0_b_36_pad_ETH_MDIO        (pad_periphs_b_36_pad, alt_0_pad_periphs_b_36_pad_ETH_MDIO       , alt_0_pad_periphs_b_36_pad_mux_sel_ETH_MDIO       );
        tranif1 alt_0_b_37_pad_ETH_MDC         (pad_periphs_b_37_pad, alt_0_pad_periphs_b_37_pad_ETH_MDC        , alt_0_pad_periphs_b_37_pad_mux_sel_ETH_MDC        );
        tranif1 alt_0_b_38_pad_USB1_SPI10_SCK  (pad_periphs_b_38_pad, alt_0_pad_periphs_b_38_pad_USB1_SPI10_SCK , alt_0_pad_periphs_b_38_pad_mux_sel_USB1_SPI10_SCK );
        tranif1 alt_0_b_39_pad_USB1_SPI10_CS   (pad_periphs_b_39_pad, alt_0_pad_periphs_b_39_pad_USB1_SPI10_CS  , alt_0_pad_periphs_b_39_pad_mux_sel_USB1_SPI10_CS  );
        tranif1 alt_0_b_40_pad_USB1_SPI10_MISO (pad_periphs_b_40_pad, alt_0_pad_periphs_b_40_pad_USB1_SPI10_MISO, alt_0_pad_periphs_b_40_pad_mux_sel_USB1_SPI10_MISO);
        tranif1 alt_0_b_41_pad_USB1_SPI10_MOSI (pad_periphs_b_41_pad, alt_0_pad_periphs_b_41_pad_USB1_SPI10_MOSI, alt_0_pad_periphs_b_41_pad_mux_sel_USB1_SPI10_MOSI);
        tranif1 alt_0_b_42_pad_CAN0_TX         (pad_periphs_b_42_pad, alt_0_pad_periphs_b_42_pad_CAN0_TX        , alt_0_pad_periphs_b_42_pad_mux_sel_CAN0_TX        );
        tranif1 alt_0_b_43_pad_CAN0_RX         (pad_periphs_b_43_pad, alt_0_pad_periphs_b_43_pad_CAN0_RX        , alt_0_pad_periphs_b_43_pad_mux_sel_CAN0_RX        );
        tranif1 alt_0_b_44_pad_PWM0_CHANNEL1   (pad_periphs_b_44_pad, alt_0_pad_periphs_b_44_pad_PWM0_CHANNEL1  , alt_0_pad_periphs_b_44_pad_mux_sel_PWM0_CHANNEL1  );
        tranif1 alt_0_b_45_pad_PWM1_CHANNEL1   (pad_periphs_b_45_pad, alt_0_pad_periphs_b_45_pad_PWM1_CHANNEL1  , alt_0_pad_periphs_b_45_pad_mux_sel_PWM1_CHANNEL1  );
        tranif1 alt_0_b_46_pad_PWM2_CHANNEL1   (pad_periphs_b_46_pad, alt_0_pad_periphs_b_46_pad_PWM2_CHANNEL1  , alt_0_pad_periphs_b_46_pad_mux_sel_PWM2_CHANNEL1  );
        tranif1 alt_0_b_47_pad_PWM3_CHANNEL1   (pad_periphs_b_47_pad, alt_0_pad_periphs_b_47_pad_PWM3_CHANNEL1  , alt_0_pad_periphs_b_47_pad_mux_sel_PWM3_CHANNEL1  );
        tranif1 alt_1_b_00_pad_WIRELESS_SDIO1_D0  (pad_periphs_b_00_pad, alt_1_pad_periphs_b_00_pad_WIRELESS_SDIO1_D0 , alt_1_pad_periphs_b_00_pad_mux_sel_WIRELESS_SDIO1_D0 );
        tranif1 alt_1_b_01_pad_WIRELESS_SDIO1_D1  (pad_periphs_b_01_pad, alt_1_pad_periphs_b_01_pad_WIRELESS_SDIO1_D1 , alt_1_pad_periphs_b_01_pad_mux_sel_WIRELESS_SDIO1_D1 );
        tranif1 alt_1_b_02_pad_WIRELESS_SDIO1_D2  (pad_periphs_b_02_pad, alt_1_pad_periphs_b_02_pad_WIRELESS_SDIO1_D2 , alt_1_pad_periphs_b_02_pad_mux_sel_WIRELESS_SDIO1_D2 );
        tranif1 alt_1_b_03_pad_WIRELESS_SDIO1_D3  (pad_periphs_b_03_pad, alt_1_pad_periphs_b_03_pad_WIRELESS_SDIO1_D3 , alt_1_pad_periphs_b_03_pad_mux_sel_WIRELESS_SDIO1_D3 );
        tranif1 alt_1_b_04_pad_WIRELESS_SDIO1_CLK (pad_periphs_b_04_pad, alt_1_pad_periphs_b_04_pad_WIRELESS_SDIO1_CLK, alt_1_pad_periphs_b_04_pad_mux_sel_WIRELESS_SDIO1_CLK);
        tranif1 alt_1_b_05_pad_WIRELESS_SDIO1_CMD (pad_periphs_b_05_pad, alt_1_pad_periphs_b_05_pad_WIRELESS_SDIO1_CMD, alt_1_pad_periphs_b_05_pad_mux_sel_WIRELESS_SDIO1_CMD);
        tranif1 alt_1_b_06_pad_IMU1_SPI0_SCK      (pad_periphs_b_06_pad, alt_1_pad_periphs_b_06_pad_IMU1_SPI0_SCK     , alt_1_pad_periphs_b_06_pad_mux_sel_IMU1_SPI0_SCK     );
        tranif1 alt_1_b_07_pad_IMU1_SPI0_CS       (pad_periphs_b_07_pad, alt_1_pad_periphs_b_07_pad_IMU1_SPI0_CS      , alt_1_pad_periphs_b_07_pad_mux_sel_IMU1_SPI0_CS      );
        tranif1 alt_1_b_08_pad_IMU1_SPI0_MISO     (pad_periphs_b_08_pad, alt_1_pad_periphs_b_08_pad_IMU1_SPI0_MISO    , alt_1_pad_periphs_b_08_pad_mux_sel_IMU1_SPI0_MISO    );
        tranif1 alt_1_b_09_pad_IMU1_SPI0_MOSI     (pad_periphs_b_09_pad, alt_1_pad_periphs_b_09_pad_IMU1_SPI0_MOSI    , alt_1_pad_periphs_b_09_pad_mux_sel_IMU1_SPI0_MOSI    );
        tranif1 alt_1_b_10_pad_TLM1_USART0_TX     (pad_periphs_b_10_pad, alt_1_pad_periphs_b_10_pad_TLM1_USART0_TX    , alt_1_pad_periphs_b_10_pad_mux_sel_TLM1_USART0_TX    );
        tranif1 alt_1_b_11_pad_TLM1_USART0_RX     (pad_periphs_b_11_pad, alt_1_pad_periphs_b_11_pad_TLM1_USART0_RX    , alt_1_pad_periphs_b_11_pad_mux_sel_TLM1_USART0_RX    );
        tranif1 alt_1_b_12_pad_TLM1_USART0_RTS    (pad_periphs_b_12_pad, alt_1_pad_periphs_b_12_pad_TLM1_USART0_RTS   , alt_1_pad_periphs_b_12_pad_mux_sel_TLM1_USART0_RTS   );
        tranif1 alt_1_b_13_pad_TLM1_USART0_CTS    (pad_periphs_b_13_pad, alt_1_pad_periphs_b_13_pad_TLM1_USART0_CTS   , alt_1_pad_periphs_b_13_pad_mux_sel_TLM1_USART0_CTS   );
        tranif1 alt_1_b_14_pad_ADC0_SPI4_SCK      (pad_periphs_b_14_pad, alt_1_pad_periphs_b_14_pad_ADC0_SPI4_SCK     , alt_1_pad_periphs_b_14_pad_mux_sel_ADC0_SPI4_SCK     );
        tranif1 alt_1_b_15_pad_ADC0_SPI4_CS       (pad_periphs_b_15_pad, alt_1_pad_periphs_b_15_pad_ADC0_SPI4_CS      , alt_1_pad_periphs_b_15_pad_mux_sel_ADC0_SPI4_CS      );
        tranif1 alt_1_b_16_pad_ADC0_SPI4_MISO     (pad_periphs_b_16_pad, alt_1_pad_periphs_b_16_pad_ADC0_SPI4_MISO    , alt_1_pad_periphs_b_16_pad_mux_sel_ADC0_SPI4_MISO    );
        tranif1 alt_1_b_17_pad_ADC0_SPI4_MOSI     (pad_periphs_b_17_pad, alt_1_pad_periphs_b_17_pad_ADC0_SPI4_MOSI    , alt_1_pad_periphs_b_17_pad_mux_sel_ADC0_SPI4_MOSI    );
        tranif1 alt_1_b_18_pad_FRAM_SPI2_SCK      (pad_periphs_b_18_pad, alt_1_pad_periphs_b_18_pad_FRAM_SPI2_SCK     , alt_1_pad_periphs_b_18_pad_mux_sel_FRAM_SPI2_SCK     );
        tranif1 alt_1_b_19_pad_FRAM_SPI2_CS       (pad_periphs_b_19_pad, alt_1_pad_periphs_b_19_pad_FRAM_SPI2_CS      , alt_1_pad_periphs_b_19_pad_mux_sel_FRAM_SPI2_CS      );
        tranif1 alt_1_b_20_pad_FRAM_SPI2_MISO     (pad_periphs_b_20_pad, alt_1_pad_periphs_b_20_pad_FRAM_SPI2_MISO    , alt_1_pad_periphs_b_20_pad_mux_sel_FRAM_SPI2_MISO    );
        tranif1 alt_1_b_21_pad_FRAM_SPI2_MOSI     (pad_periphs_b_21_pad, alt_1_pad_periphs_b_21_pad_FRAM_SPI2_MOSI    , alt_1_pad_periphs_b_21_pad_mux_sel_FRAM_SPI2_MOSI    );
        tranif1 alt_1_b_22_pad_ADIO1_SPI3_SCK     (pad_periphs_b_22_pad, alt_1_pad_periphs_b_22_pad_ADIO1_SPI3_SCK    , alt_1_pad_periphs_b_22_pad_mux_sel_ADIO1_SPI3_SCK    );
        tranif1 alt_1_b_23_pad_ADIO1_SPI3_CS      (pad_periphs_b_23_pad, alt_1_pad_periphs_b_23_pad_ADIO1_SPI3_CS     , alt_1_pad_periphs_b_23_pad_mux_sel_ADIO1_SPI3_CS     );
        tranif1 alt_1_b_24_pad_ADIO1_SPI3_MISO    (pad_periphs_b_24_pad, alt_1_pad_periphs_b_24_pad_ADIO1_SPI3_MISO   , alt_1_pad_periphs_b_24_pad_mux_sel_ADIO1_SPI3_MISO   );
        tranif1 alt_1_b_25_pad_ADIO1_SPI3_MOSI    (pad_periphs_b_25_pad, alt_1_pad_periphs_b_25_pad_ADIO1_SPI3_MOSI   , alt_1_pad_periphs_b_25_pad_mux_sel_ADIO1_SPI3_MOSI   );
        tranif1 alt_1_b_26_pad_MAG_SPI1_SCK       (pad_periphs_b_26_pad, alt_1_pad_periphs_b_26_pad_MAG_SPI1_SCK      , alt_1_pad_periphs_b_26_pad_mux_sel_MAG_SPI1_SCK      );
        tranif1 alt_1_b_27_pad_MAG_SPI1_CS        (pad_periphs_b_27_pad, alt_1_pad_periphs_b_27_pad_MAG_SPI1_CS       , alt_1_pad_periphs_b_27_pad_mux_sel_MAG_SPI1_CS       );
        tranif1 alt_1_b_28_pad_MAG_SPI1_MISO      (pad_periphs_b_28_pad, alt_1_pad_periphs_b_28_pad_MAG_SPI1_MISO     , alt_1_pad_periphs_b_28_pad_mux_sel_MAG_SPI1_MISO     );
        tranif1 alt_1_b_29_pad_MAG_SPI1_MOSI      (pad_periphs_b_29_pad, alt_1_pad_periphs_b_29_pad_MAG_SPI1_MOSI     , alt_1_pad_periphs_b_29_pad_mux_sel_MAG_SPI1_MOSI     );
        tranif1 alt_1_b_30_pad_CAN1_TX            (pad_periphs_b_30_pad, alt_1_pad_periphs_b_30_pad_CAN1_TX           , alt_1_pad_periphs_b_30_pad_mux_sel_CAN1_TX           );
        tranif1 alt_1_b_31_pad_CAN1_RX            (pad_periphs_b_31_pad, alt_1_pad_periphs_b_31_pad_CAN1_RX           , alt_1_pad_periphs_b_31_pad_mux_sel_CAN1_RX           );
        tranif1 alt_1_b_32_pad_PWM0_CHANNEL1      (pad_periphs_b_32_pad, alt_1_pad_periphs_b_32_pad_PWM0_CHANNEL1     , alt_1_pad_periphs_b_32_pad_mux_sel_PWM0_CHANNEL1     );
        tranif1 alt_1_b_33_pad_PWM1_CHANNEL1      (pad_periphs_b_33_pad, alt_1_pad_periphs_b_33_pad_PWM1_CHANNEL1     , alt_1_pad_periphs_b_33_pad_mux_sel_PWM1_CHANNEL1     );
        tranif1 alt_1_b_34_pad_PWM2_CHANNEL1      (pad_periphs_b_34_pad, alt_1_pad_periphs_b_34_pad_PWM2_CHANNEL1     , alt_1_pad_periphs_b_34_pad_mux_sel_PWM2_CHANNEL1     );
        tranif1 alt_1_b_35_pad_PWM3_CHANNEL1      (pad_periphs_b_35_pad, alt_1_pad_periphs_b_35_pad_PWM3_CHANNEL1     , alt_1_pad_periphs_b_35_pad_mux_sel_PWM3_CHANNEL1     );
        tranif1 alt_1_b_36_pad_CAM1_CPI1_CLK      (pad_periphs_b_36_pad, alt_1_pad_periphs_b_36_pad_CAM1_CPI1_CLK     , alt_1_pad_periphs_b_36_pad_mux_sel_CAM1_CPI1_CLK     );
        tranif1 alt_1_b_37_pad_CAM1_CPI1_VSYNC    (pad_periphs_b_37_pad, alt_1_pad_periphs_b_37_pad_CAM1_CPI1_VSYNC   , alt_1_pad_periphs_b_37_pad_mux_sel_CAM1_CPI1_VSYNC   );
        tranif1 alt_1_b_38_pad_CAM1_CPI1_HSYNC    (pad_periphs_b_38_pad, alt_1_pad_periphs_b_38_pad_CAM1_CPI1_HSYNC   , alt_1_pad_periphs_b_38_pad_mux_sel_CAM1_CPI1_HSYNC   );
        tranif1 alt_1_b_39_pad_CAM1_CPI1_DAT0     (pad_periphs_b_39_pad, alt_1_pad_periphs_b_39_pad_CAM1_CPI1_DAT0    , alt_1_pad_periphs_b_39_pad_mux_sel_CAM1_CPI1_DAT0    );
        tranif1 alt_1_b_40_pad_CAM1_CPI1_DAT1     (pad_periphs_b_40_pad, alt_1_pad_periphs_b_40_pad_CAM1_CPI1_DAT1    , alt_1_pad_periphs_b_40_pad_mux_sel_CAM1_CPI1_DAT1    );
        tranif1 alt_1_b_41_pad_CAM1_CPI1_DAT2     (pad_periphs_b_41_pad, alt_1_pad_periphs_b_41_pad_CAM1_CPI1_DAT2    , alt_1_pad_periphs_b_41_pad_mux_sel_CAM1_CPI1_DAT2    );
        tranif1 alt_1_b_42_pad_CAM1_CPI1_DAT3     (pad_periphs_b_42_pad, alt_1_pad_periphs_b_42_pad_CAM1_CPI1_DAT3    , alt_1_pad_periphs_b_42_pad_mux_sel_CAM1_CPI1_DAT3    );
        tranif1 alt_1_b_43_pad_CAM1_CPI1_DAT4     (pad_periphs_b_43_pad, alt_1_pad_periphs_b_43_pad_CAM1_CPI1_DAT4    , alt_1_pad_periphs_b_43_pad_mux_sel_CAM1_CPI1_DAT4    );
        tranif1 alt_1_b_44_pad_CAM1_CPI1_DAT5     (pad_periphs_b_44_pad, alt_1_pad_periphs_b_44_pad_CAM1_CPI1_DAT5    , alt_1_pad_periphs_b_44_pad_mux_sel_CAM1_CPI1_DAT5    );
        tranif1 alt_1_b_45_pad_CAM1_CPI1_DAT6     (pad_periphs_b_45_pad, alt_1_pad_periphs_b_45_pad_CAM1_CPI1_DAT6    , alt_1_pad_periphs_b_45_pad_mux_sel_CAM1_CPI1_DAT6    );
        tranif1 alt_1_b_46_pad_CAM1_CPI1_DAT7     (pad_periphs_b_46_pad, alt_1_pad_periphs_b_46_pad_CAM1_CPI1_DAT7    , alt_1_pad_periphs_b_46_pad_mux_sel_CAM1_CPI1_DAT7    );
        tranif1 alt_1_b_47_pad_FLL_CVA6           (pad_periphs_b_47_pad, alt_1_pad_periphs_b_47_pad_FLL_CVA6          , alt_1_pad_periphs_b_47_pad_mux_sel_FLL_CVA6          );
        tranif1 alt_2_b_00_pad_IO_GPIO00 (pad_periphs_b_00_pad, alt_2_pad_periphs_b_00_pad_IO_GPIO00, alt_2_pad_periphs_b_00_pad_mux_sel_IO_GPIO00);
        tranif1 alt_2_b_01_pad_IO_GPIO01 (pad_periphs_b_01_pad, alt_2_pad_periphs_b_01_pad_IO_GPIO01, alt_2_pad_periphs_b_01_pad_mux_sel_IO_GPIO01);
        tranif1 alt_2_b_02_pad_IO_GPIO02 (pad_periphs_b_02_pad, alt_2_pad_periphs_b_02_pad_IO_GPIO02, alt_2_pad_periphs_b_02_pad_mux_sel_IO_GPIO02);
        tranif1 alt_2_b_03_pad_IO_GPIO03 (pad_periphs_b_03_pad, alt_2_pad_periphs_b_03_pad_IO_GPIO03, alt_2_pad_periphs_b_03_pad_mux_sel_IO_GPIO03);
        tranif1 alt_2_b_04_pad_IO_GPIO04 (pad_periphs_b_04_pad, alt_2_pad_periphs_b_04_pad_IO_GPIO04, alt_2_pad_periphs_b_04_pad_mux_sel_IO_GPIO04);
        tranif1 alt_2_b_05_pad_IO_GPIO05 (pad_periphs_b_05_pad, alt_2_pad_periphs_b_05_pad_IO_GPIO05, alt_2_pad_periphs_b_05_pad_mux_sel_IO_GPIO05);
        tranif1 alt_2_b_06_pad_IO_GPIO06 (pad_periphs_b_06_pad, alt_2_pad_periphs_b_06_pad_IO_GPIO06, alt_2_pad_periphs_b_06_pad_mux_sel_IO_GPIO06);
        tranif1 alt_2_b_07_pad_IO_GPIO07 (pad_periphs_b_07_pad, alt_2_pad_periphs_b_07_pad_IO_GPIO07, alt_2_pad_periphs_b_07_pad_mux_sel_IO_GPIO07);
        tranif1 alt_2_b_08_pad_IO_GPIO08 (pad_periphs_b_08_pad, alt_2_pad_periphs_b_08_pad_IO_GPIO08, alt_2_pad_periphs_b_08_pad_mux_sel_IO_GPIO08);
        tranif1 alt_2_b_09_pad_IO_GPIO09 (pad_periphs_b_09_pad, alt_2_pad_periphs_b_09_pad_IO_GPIO09, alt_2_pad_periphs_b_09_pad_mux_sel_IO_GPIO09);
        tranif1 alt_2_b_10_pad_IO_GPIO10 (pad_periphs_b_10_pad, alt_2_pad_periphs_b_10_pad_IO_GPIO10, alt_2_pad_periphs_b_10_pad_mux_sel_IO_GPIO10);
        tranif1 alt_2_b_11_pad_IO_GPIO11 (pad_periphs_b_11_pad, alt_2_pad_periphs_b_11_pad_IO_GPIO11, alt_2_pad_periphs_b_11_pad_mux_sel_IO_GPIO11);
        tranif1 alt_2_b_12_pad_IO_GPIO12 (pad_periphs_b_12_pad, alt_2_pad_periphs_b_12_pad_IO_GPIO12, alt_2_pad_periphs_b_12_pad_mux_sel_IO_GPIO12);
        tranif1 alt_2_b_13_pad_IO_GPIO13 (pad_periphs_b_13_pad, alt_2_pad_periphs_b_13_pad_IO_GPIO13, alt_2_pad_periphs_b_13_pad_mux_sel_IO_GPIO13);
        tranif1 alt_2_b_14_pad_IO_GPIO14 (pad_periphs_b_14_pad, alt_2_pad_periphs_b_14_pad_IO_GPIO14, alt_2_pad_periphs_b_14_pad_mux_sel_IO_GPIO14);
        tranif1 alt_2_b_15_pad_IO_GPIO15 (pad_periphs_b_15_pad, alt_2_pad_periphs_b_15_pad_IO_GPIO15, alt_2_pad_periphs_b_15_pad_mux_sel_IO_GPIO15);
        tranif1 alt_2_b_16_pad_IO_GPIO16 (pad_periphs_b_16_pad, alt_2_pad_periphs_b_16_pad_IO_GPIO16, alt_2_pad_periphs_b_16_pad_mux_sel_IO_GPIO16);
        tranif1 alt_2_b_17_pad_IO_GPIO17 (pad_periphs_b_17_pad, alt_2_pad_periphs_b_17_pad_IO_GPIO17, alt_2_pad_periphs_b_17_pad_mux_sel_IO_GPIO17);
        tranif1 alt_2_b_18_pad_IO_GPIO18 (pad_periphs_b_18_pad, alt_2_pad_periphs_b_18_pad_IO_GPIO18, alt_2_pad_periphs_b_18_pad_mux_sel_IO_GPIO18);
        tranif1 alt_2_b_19_pad_IO_GPIO19 (pad_periphs_b_19_pad, alt_2_pad_periphs_b_19_pad_IO_GPIO19, alt_2_pad_periphs_b_19_pad_mux_sel_IO_GPIO19);
        tranif1 alt_2_b_20_pad_IO_GPIO20 (pad_periphs_b_20_pad, alt_2_pad_periphs_b_20_pad_IO_GPIO20, alt_2_pad_periphs_b_20_pad_mux_sel_IO_GPIO20);
        tranif1 alt_2_b_21_pad_IO_GPIO21 (pad_periphs_b_21_pad, alt_2_pad_periphs_b_21_pad_IO_GPIO21, alt_2_pad_periphs_b_21_pad_mux_sel_IO_GPIO21);
        tranif1 alt_2_b_22_pad_IO_GPIO22 (pad_periphs_b_22_pad, alt_2_pad_periphs_b_22_pad_IO_GPIO22, alt_2_pad_periphs_b_22_pad_mux_sel_IO_GPIO22);
        tranif1 alt_2_b_23_pad_IO_GPIO23 (pad_periphs_b_23_pad, alt_2_pad_periphs_b_23_pad_IO_GPIO23, alt_2_pad_periphs_b_23_pad_mux_sel_IO_GPIO23);
        tranif1 alt_2_b_24_pad_IO_GPIO24 (pad_periphs_b_24_pad, alt_2_pad_periphs_b_24_pad_IO_GPIO24, alt_2_pad_periphs_b_24_pad_mux_sel_IO_GPIO24);
        tranif1 alt_2_b_25_pad_IO_GPIO25 (pad_periphs_b_25_pad, alt_2_pad_periphs_b_25_pad_IO_GPIO25, alt_2_pad_periphs_b_25_pad_mux_sel_IO_GPIO25);
        tranif1 alt_2_b_26_pad_IO_GPIO26 (pad_periphs_b_26_pad, alt_2_pad_periphs_b_26_pad_IO_GPIO26, alt_2_pad_periphs_b_26_pad_mux_sel_IO_GPIO26);
        tranif1 alt_2_b_27_pad_IO_GPIO27 (pad_periphs_b_27_pad, alt_2_pad_periphs_b_27_pad_IO_GPIO27, alt_2_pad_periphs_b_27_pad_mux_sel_IO_GPIO27);
        tranif1 alt_2_b_28_pad_IO_GPIO28 (pad_periphs_b_28_pad, alt_2_pad_periphs_b_28_pad_IO_GPIO28, alt_2_pad_periphs_b_28_pad_mux_sel_IO_GPIO28);
        tranif1 alt_2_b_29_pad_IO_GPIO29 (pad_periphs_b_29_pad, alt_2_pad_periphs_b_29_pad_IO_GPIO29, alt_2_pad_periphs_b_29_pad_mux_sel_IO_GPIO29);
        tranif1 alt_2_b_30_pad_IO_GPIO30 (pad_periphs_b_30_pad, alt_2_pad_periphs_b_30_pad_IO_GPIO30, alt_2_pad_periphs_b_30_pad_mux_sel_IO_GPIO30);
        tranif1 alt_2_b_31_pad_IO_GPIO31 (pad_periphs_b_31_pad, alt_2_pad_periphs_b_31_pad_IO_GPIO31, alt_2_pad_periphs_b_31_pad_mux_sel_IO_GPIO31);
        tranif1 alt_2_b_32_pad_IO_GPIO32 (pad_periphs_b_32_pad, alt_2_pad_periphs_b_32_pad_IO_GPIO32, alt_2_pad_periphs_b_32_pad_mux_sel_IO_GPIO32);
        tranif1 alt_2_b_33_pad_IO_GPIO33 (pad_periphs_b_33_pad, alt_2_pad_periphs_b_33_pad_IO_GPIO33, alt_2_pad_periphs_b_33_pad_mux_sel_IO_GPIO33);
        tranif1 alt_2_b_34_pad_IO_GPIO34 (pad_periphs_b_34_pad, alt_2_pad_periphs_b_34_pad_IO_GPIO34, alt_2_pad_periphs_b_34_pad_mux_sel_IO_GPIO34);
        tranif1 alt_2_b_35_pad_IO_GPIO35 (pad_periphs_b_35_pad, alt_2_pad_periphs_b_35_pad_IO_GPIO35, alt_2_pad_periphs_b_35_pad_mux_sel_IO_GPIO35);
        tranif1 alt_2_b_36_pad_IO_GPIO36 (pad_periphs_b_36_pad, alt_2_pad_periphs_b_36_pad_IO_GPIO36, alt_2_pad_periphs_b_36_pad_mux_sel_IO_GPIO36);
        tranif1 alt_2_b_37_pad_IO_GPIO37 (pad_periphs_b_37_pad, alt_2_pad_periphs_b_37_pad_IO_GPIO37, alt_2_pad_periphs_b_37_pad_mux_sel_IO_GPIO37);
        tranif1 alt_2_b_38_pad_IO_GPIO38 (pad_periphs_b_38_pad, alt_2_pad_periphs_b_38_pad_IO_GPIO38, alt_2_pad_periphs_b_38_pad_mux_sel_IO_GPIO38);
        tranif1 alt_2_b_39_pad_IO_GPIO39 (pad_periphs_b_39_pad, alt_2_pad_periphs_b_39_pad_IO_GPIO39, alt_2_pad_periphs_b_39_pad_mux_sel_IO_GPIO39);
        tranif1 alt_2_b_40_pad_IO_GPIO40 (pad_periphs_b_40_pad, alt_2_pad_periphs_b_40_pad_IO_GPIO40, alt_2_pad_periphs_b_40_pad_mux_sel_IO_GPIO40);
        tranif1 alt_2_b_41_pad_IO_GPIO41 (pad_periphs_b_41_pad, alt_2_pad_periphs_b_41_pad_IO_GPIO41, alt_2_pad_periphs_b_41_pad_mux_sel_IO_GPIO41);
        tranif1 alt_2_b_42_pad_IO_GPIO42 (pad_periphs_b_42_pad, alt_2_pad_periphs_b_42_pad_IO_GPIO42, alt_2_pad_periphs_b_42_pad_mux_sel_IO_GPIO42);
        tranif1 alt_2_b_43_pad_IO_GPIO43 (pad_periphs_b_43_pad, alt_2_pad_periphs_b_43_pad_IO_GPIO43, alt_2_pad_periphs_b_43_pad_mux_sel_IO_GPIO43);
        tranif1 alt_2_b_44_pad_IO_GPIO44 (pad_periphs_b_44_pad, alt_2_pad_periphs_b_44_pad_IO_GPIO44, alt_2_pad_periphs_b_44_pad_mux_sel_IO_GPIO44);
        tranif1 alt_2_b_45_pad_IO_GPIO45 (pad_periphs_b_45_pad, alt_2_pad_periphs_b_45_pad_IO_GPIO45, alt_2_pad_periphs_b_45_pad_mux_sel_IO_GPIO45);
        tranif1 alt_2_b_46_pad_IO_GPIO46 (pad_periphs_b_46_pad, alt_2_pad_periphs_b_46_pad_IO_GPIO46, alt_2_pad_periphs_b_46_pad_mux_sel_IO_GPIO46);
        tranif1 alt_2_b_47_pad_IO_GPIO47 (pad_periphs_b_47_pad, alt_2_pad_periphs_b_47_pad_IO_GPIO47, alt_2_pad_periphs_b_47_pad_mux_sel_IO_GPIO47);
        tranif1 alt_3_b_00_pad_GPS2_UART0_TX   (pad_periphs_b_00_pad, alt_3_pad_periphs_b_00_pad_GPS2_UART0_TX  , alt_3_pad_periphs_b_00_pad_mux_sel_GPS2_UART0_TX  );
        tranif1 alt_3_b_01_pad_GPS2_UART0_RX   (pad_periphs_b_01_pad, alt_3_pad_periphs_b_01_pad_GPS2_UART0_RX  , alt_3_pad_periphs_b_01_pad_mux_sel_GPS2_UART0_RX  );
        tranif1 alt_3_b_02_pad_GPS2_I2C1_SCL   (pad_periphs_b_02_pad, alt_3_pad_periphs_b_02_pad_GPS2_I2C1_SCL  , alt_3_pad_periphs_b_02_pad_mux_sel_GPS2_I2C1_SCL  );
        tranif1 alt_3_b_03_pad_GPS2_I2C1_SDA   (pad_periphs_b_03_pad, alt_3_pad_periphs_b_03_pad_GPS2_I2C1_SDA  , alt_3_pad_periphs_b_03_pad_mux_sel_GPS2_I2C1_SDA  );
        tranif1 alt_3_b_04_pad_IMU2_SPI5_SCK   (pad_periphs_b_04_pad, alt_3_pad_periphs_b_04_pad_IMU2_SPI5_SCK  , alt_3_pad_periphs_b_04_pad_mux_sel_IMU2_SPI5_SCK  );
        tranif1 alt_3_b_05_pad_IMU2_SPI5_CS    (pad_periphs_b_05_pad, alt_3_pad_periphs_b_05_pad_IMU2_SPI5_CS   , alt_3_pad_periphs_b_05_pad_mux_sel_IMU2_SPI5_CS   );
        tranif1 alt_3_b_06_pad_IMU2_SPI5_MISO  (pad_periphs_b_06_pad, alt_3_pad_periphs_b_06_pad_IMU2_SPI5_MISO , alt_3_pad_periphs_b_06_pad_mux_sel_IMU2_SPI5_MISO );
        tranif1 alt_3_b_07_pad_IMU2_SPI5_MOSI  (pad_periphs_b_07_pad, alt_3_pad_periphs_b_07_pad_IMU2_SPI5_MOSI , alt_3_pad_periphs_b_07_pad_mux_sel_IMU2_SPI5_MOSI );
        tranif1 alt_3_b_08_pad_BARO2_I2C3_SCL  (pad_periphs_b_08_pad, alt_3_pad_periphs_b_08_pad_BARO2_I2C3_SCL , alt_3_pad_periphs_b_08_pad_mux_sel_BARO2_I2C3_SCL );
        tranif1 alt_3_b_09_pad_BARO2_I2C3_SDA  (pad_periphs_b_09_pad, alt_3_pad_periphs_b_09_pad_BARO2_I2C3_SDA , alt_3_pad_periphs_b_09_pad_mux_sel_BARO2_I2C3_SDA );
        tranif1 alt_3_b_10_pad_IMU3_SPI6_SCK   (pad_periphs_b_10_pad, alt_3_pad_periphs_b_10_pad_IMU3_SPI6_SCK  , alt_3_pad_periphs_b_10_pad_mux_sel_IMU3_SPI6_SCK  );
        tranif1 alt_3_b_11_pad_IMU3_SPI6_CS    (pad_periphs_b_11_pad, alt_3_pad_periphs_b_11_pad_IMU3_SPI6_CS   , alt_3_pad_periphs_b_11_pad_mux_sel_IMU3_SPI6_CS   );
        tranif1 alt_3_b_12_pad_IMU3_SPI6_MISO  (pad_periphs_b_12_pad, alt_3_pad_periphs_b_12_pad_IMU3_SPI6_MISO , alt_3_pad_periphs_b_12_pad_mux_sel_IMU3_SPI6_MISO );
        tranif1 alt_3_b_13_pad_IMU3_SPI6_MOSI  (pad_periphs_b_13_pad, alt_3_pad_periphs_b_13_pad_IMU3_SPI6_MOSI , alt_3_pad_periphs_b_13_pad_mux_sel_IMU3_SPI6_MOSI );
        tranif1 alt_3_b_14_pad_TLM2_USART2_TX  (pad_periphs_b_14_pad, alt_3_pad_periphs_b_14_pad_TLM2_USART2_TX , alt_3_pad_periphs_b_14_pad_mux_sel_TLM2_USART2_TX );
        tranif1 alt_3_b_15_pad_TLM2_USART2_RX  (pad_periphs_b_15_pad, alt_3_pad_periphs_b_15_pad_TLM2_USART2_RX , alt_3_pad_periphs_b_15_pad_mux_sel_TLM2_USART2_RX );
        tranif1 alt_3_b_16_pad_TLM2_USART2_RTS (pad_periphs_b_16_pad, alt_3_pad_periphs_b_16_pad_TLM2_USART2_RTS, alt_3_pad_periphs_b_16_pad_mux_sel_TLM2_USART2_RTS);
        tranif1 alt_3_b_17_pad_TLM2_USART2_CTS (pad_periphs_b_17_pad, alt_3_pad_periphs_b_17_pad_TLM2_USART2_CTS, alt_3_pad_periphs_b_17_pad_mux_sel_TLM2_USART2_CTS);
        tranif1 alt_3_b_18_pad_TLM3_USART3_TX  (pad_periphs_b_18_pad, alt_3_pad_periphs_b_18_pad_TLM3_USART3_TX , alt_3_pad_periphs_b_18_pad_mux_sel_TLM3_USART3_TX );
        tranif1 alt_3_b_19_pad_TLM3_USART3_RX  (pad_periphs_b_19_pad, alt_3_pad_periphs_b_19_pad_TLM3_USART3_RX , alt_3_pad_periphs_b_19_pad_mux_sel_TLM3_USART3_RX );
        tranif1 alt_3_b_20_pad_TLM3_USART3_RTS (pad_periphs_b_20_pad, alt_3_pad_periphs_b_20_pad_TLM3_USART3_RTS, alt_3_pad_periphs_b_20_pad_mux_sel_TLM3_USART3_RTS);
        tranif1 alt_3_b_21_pad_TLM3_USART3_CTS (pad_periphs_b_21_pad, alt_3_pad_periphs_b_21_pad_TLM3_USART3_CTS, alt_3_pad_periphs_b_21_pad_mux_sel_TLM3_USART3_CTS);
        tranif1 alt_3_b_22_pad_CAN0_SPI8_SCK   (pad_periphs_b_22_pad, alt_3_pad_periphs_b_22_pad_CAN0_SPI8_SCK  , alt_3_pad_periphs_b_22_pad_mux_sel_CAN0_SPI8_SCK  );
        tranif1 alt_3_b_23_pad_CAN0_SPI8_CS    (pad_periphs_b_23_pad, alt_3_pad_periphs_b_23_pad_CAN0_SPI8_CS   , alt_3_pad_periphs_b_23_pad_mux_sel_CAN0_SPI8_CS   );
        tranif1 alt_3_b_24_pad_CAN0_SPI8_MISO  (pad_periphs_b_24_pad, alt_3_pad_periphs_b_24_pad_CAN0_SPI8_MISO , alt_3_pad_periphs_b_24_pad_mux_sel_CAN0_SPI8_MISO );
        tranif1 alt_3_b_25_pad_CAN0_SPI8_MOSI  (pad_periphs_b_25_pad, alt_3_pad_periphs_b_25_pad_CAN0_SPI8_MOSI , alt_3_pad_periphs_b_25_pad_mux_sel_CAN0_SPI8_MOSI );
        tranif1 alt_3_b_26_pad_CAN1_SPI9_SCK   (pad_periphs_b_26_pad, alt_3_pad_periphs_b_26_pad_CAN1_SPI9_SCK  , alt_3_pad_periphs_b_26_pad_mux_sel_CAN1_SPI9_SCK  );
        tranif1 alt_3_b_27_pad_CAN1_SPI9_CS    (pad_periphs_b_27_pad, alt_3_pad_periphs_b_27_pad_CAN1_SPI9_CS   , alt_3_pad_periphs_b_27_pad_mux_sel_CAN1_SPI9_CS   );
        tranif1 alt_3_b_28_pad_CAN1_SPI9_MISO  (pad_periphs_b_28_pad, alt_3_pad_periphs_b_28_pad_CAN1_SPI9_MISO , alt_3_pad_periphs_b_28_pad_mux_sel_CAN1_SPI9_MISO );
        tranif1 alt_3_b_29_pad_CAN1_SPI9_MOSI  (pad_periphs_b_29_pad, alt_3_pad_periphs_b_29_pad_CAN1_SPI9_MOSI , alt_3_pad_periphs_b_29_pad_mux_sel_CAN1_SPI9_MOSI );
        tranif1 alt_3_b_30_pad_USB1_SPI10_SCK  (pad_periphs_b_30_pad, alt_3_pad_periphs_b_30_pad_USB1_SPI10_SCK , alt_3_pad_periphs_b_30_pad_mux_sel_USB1_SPI10_SCK );
        tranif1 alt_3_b_31_pad_USB1_SPI10_CS   (pad_periphs_b_31_pad, alt_3_pad_periphs_b_31_pad_USB1_SPI10_CS  , alt_3_pad_periphs_b_31_pad_mux_sel_USB1_SPI10_CS  );
        tranif1 alt_3_b_32_pad_USB1_SPI10_MISO (pad_periphs_b_32_pad, alt_3_pad_periphs_b_32_pad_USB1_SPI10_MISO, alt_3_pad_periphs_b_32_pad_mux_sel_USB1_SPI10_MISO);
        tranif1 alt_3_b_33_pad_USB1_SPI10_MOSI (pad_periphs_b_33_pad, alt_3_pad_periphs_b_33_pad_USB1_SPI10_MOSI, alt_3_pad_periphs_b_33_pad_mux_sel_USB1_SPI10_MOSI);
        tranif1 alt_3_b_34_pad_IO_GPIO34       (pad_periphs_b_34_pad, alt_3_pad_periphs_b_34_pad_IO_GPIO34      , alt_3_pad_periphs_b_34_pad_mux_sel_IO_GPIO34      );
        tranif1 alt_3_b_35_pad_IO_GPIO35       (pad_periphs_b_35_pad, alt_3_pad_periphs_b_35_pad_IO_GPIO35      , alt_3_pad_periphs_b_35_pad_mux_sel_IO_GPIO35      );
        tranif1 alt_3_b_36_pad_IO_GPIO36       (pad_periphs_b_36_pad, alt_3_pad_periphs_b_36_pad_IO_GPIO36      , alt_3_pad_periphs_b_36_pad_mux_sel_IO_GPIO36      );
        tranif1 alt_3_b_37_pad_IO_GPIO37       (pad_periphs_b_37_pad, alt_3_pad_periphs_b_37_pad_IO_GPIO37      , alt_3_pad_periphs_b_37_pad_mux_sel_IO_GPIO37      );
        tranif1 alt_3_b_38_pad_IO_GPIO38       (pad_periphs_b_38_pad, alt_3_pad_periphs_b_38_pad_IO_GPIO38      , alt_3_pad_periphs_b_38_pad_mux_sel_IO_GPIO38      );
        tranif1 alt_3_b_39_pad_IO_GPIO39       (pad_periphs_b_39_pad, alt_3_pad_periphs_b_39_pad_IO_GPIO39      , alt_3_pad_periphs_b_39_pad_mux_sel_IO_GPIO39      );
        tranif1 alt_3_b_40_pad_IO_GPIO40       (pad_periphs_b_40_pad, alt_3_pad_periphs_b_40_pad_IO_GPIO40      , alt_3_pad_periphs_b_40_pad_mux_sel_IO_GPIO40      );
        tranif1 alt_3_b_41_pad_IO_GPIO41       (pad_periphs_b_41_pad, alt_3_pad_periphs_b_41_pad_IO_GPIO41      , alt_3_pad_periphs_b_41_pad_mux_sel_IO_GPIO41      );
        tranif1 alt_3_b_42_pad_IO_GPIO42       (pad_periphs_b_42_pad, alt_3_pad_periphs_b_42_pad_IO_GPIO42      , alt_3_pad_periphs_b_42_pad_mux_sel_IO_GPIO42      );
        tranif1 alt_3_b_43_pad_IO_GPIO43       (pad_periphs_b_43_pad, alt_3_pad_periphs_b_43_pad_IO_GPIO43      , alt_3_pad_periphs_b_43_pad_mux_sel_IO_GPIO43      );
        tranif1 alt_3_b_44_pad_IO_GPIO44       (pad_periphs_b_44_pad, alt_3_pad_periphs_b_44_pad_IO_GPIO44      , alt_3_pad_periphs_b_44_pad_mux_sel_IO_GPIO44      );
        tranif1 alt_3_b_45_pad_IO_GPIO45       (pad_periphs_b_45_pad, alt_3_pad_periphs_b_45_pad_IO_GPIO45      , alt_3_pad_periphs_b_45_pad_mux_sel_IO_GPIO45      );
        tranif1 alt_3_b_46_pad_IO_GPIO46       (pad_periphs_b_46_pad, alt_3_pad_periphs_b_46_pad_IO_GPIO46      , alt_3_pad_periphs_b_46_pad_mux_sel_IO_GPIO46      );
        tranif1 alt_3_b_47_pad_IO_GPIO47       (pad_periphs_b_47_pad, alt_3_pad_periphs_b_47_pad_IO_GPIO47      , alt_3_pad_periphs_b_47_pad_mux_sel_IO_GPIO47      );
      `else // !`ifndef SIMPLE_PADFRAME
        tranif1 alt_0_simple_pad_00_spi0_cs   (pad_periphs_a_00_pad, alt_0_simple_pad_periphs_00_spi0_cs  , alt_0_simple_pad_periphs_00_mux_sel_spi0_cs  );
        tranif1 alt_0_simple_pad_01_spi0_ck   (pad_periphs_a_01_pad, alt_0_simple_pad_periphs_01_spi0_ck  , alt_0_simple_pad_periphs_01_mux_sel_spi0_ck  );
        tranif1 alt_0_simple_pad_02_spi0_so   (pad_periphs_a_02_pad, alt_0_simple_pad_periphs_02_spi0_so  , alt_0_simple_pad_periphs_02_mux_sel_spi0_so  );
        tranif1 alt_0_simple_pad_03_spi0_si   (pad_periphs_a_03_pad, alt_0_simple_pad_periphs_03_spi0_si  , alt_0_simple_pad_periphs_03_mux_sel_spi0_si  );
        tranif1 alt_0_simple_pad_04_i2c0_scl  (pad_periphs_a_04_pad, alt_0_simple_pad_periphs_04_i2c0_scl , alt_0_simple_pad_periphs_04_mux_sel_i2c0_scl );
        tranif1 alt_0_simple_pad_05_i2c0_sda  (pad_periphs_a_05_pad, alt_0_simple_pad_periphs_05_i2c0_sda , alt_0_simple_pad_periphs_05_mux_sel_i2c0_sda );
        tranif1 alt_0_simple_pad_06_uart0_tx  (pad_periphs_a_06_pad, alt_0_simple_pad_periphs_06_uart0_tx , alt_0_simple_pad_periphs_06_mux_sel_uart0_tx );
        tranif1 alt_0_simple_pad_07_uart0_rx  (pad_periphs_a_07_pad, alt_0_simple_pad_periphs_07_uart0_rx , alt_0_simple_pad_periphs_07_mux_sel_uart0_rx );
        tranif1 alt_0_simple_pad_08_sdio0_d1  (pad_periphs_a_08_pad, alt_0_simple_pad_periphs_08_sdio0_d1 , alt_0_simple_pad_periphs_08_mux_sel_sdio0_d1 );
        tranif1 alt_0_simple_pad_09_sdio0_d2  (pad_periphs_a_09_pad, alt_0_simple_pad_periphs_09_sdio0_d2 , alt_0_simple_pad_periphs_09_mux_sel_sdio0_d2 );
        tranif1 alt_0_simple_pad_10_sdio0_d3  (pad_periphs_a_10_pad, alt_0_simple_pad_periphs_10_sdio0_d3 , alt_0_simple_pad_periphs_10_mux_sel_sdio0_d3 );
        tranif1 alt_0_simple_pad_11_sdio0_d4  (pad_periphs_a_11_pad, alt_0_simple_pad_periphs_11_sdio0_d4 , alt_0_simple_pad_periphs_11_mux_sel_sdio0_d4 );
        tranif1 alt_0_simple_pad_12_sdio0_clk (pad_periphs_a_12_pad, alt_0_simple_pad_periphs_12_sdio0_clk, alt_0_simple_pad_periphs_12_mux_sel_sdio0_clk);
        tranif1 alt_0_simple_pad_13_sdio0_cmd (pad_periphs_a_13_pad, alt_0_simple_pad_periphs_13_sdio0_cmd, alt_0_simple_pad_periphs_13_mux_sel_sdio0_cmd);
        tranif1 alt_1_simple_pad_00_gpio00 (pad_periphs_a_00_pad, alt_1_simple_pad_periphs_00_gpio00, alt_1_simple_pad_periphs_00_mux_sel_gpio00);
        tranif1 alt_1_simple_pad_01_gpio01 (pad_periphs_a_01_pad, alt_1_simple_pad_periphs_01_gpio01, alt_1_simple_pad_periphs_01_mux_sel_gpio01);
        tranif1 alt_1_simple_pad_02_gpio02 (pad_periphs_a_02_pad, alt_1_simple_pad_periphs_02_gpio02, alt_1_simple_pad_periphs_02_mux_sel_gpio02);
        tranif1 alt_1_simple_pad_03_gpio03 (pad_periphs_a_03_pad, alt_1_simple_pad_periphs_03_gpio03, alt_1_simple_pad_periphs_03_mux_sel_gpio03);
        tranif1 alt_1_simple_pad_04_gpio04 (pad_periphs_a_04_pad, alt_1_simple_pad_periphs_04_gpio04, alt_1_simple_pad_periphs_04_mux_sel_gpio04);
        tranif1 alt_1_simple_pad_05_gpio05 (pad_periphs_a_05_pad, alt_1_simple_pad_periphs_05_gpio05, alt_1_simple_pad_periphs_05_mux_sel_gpio05);
        tranif1 alt_1_simple_pad_06_gpio06 (pad_periphs_a_06_pad, alt_1_simple_pad_periphs_06_gpio06, alt_1_simple_pad_periphs_06_mux_sel_gpio06);
        tranif1 alt_1_simple_pad_07_gpio07 (pad_periphs_a_07_pad, alt_1_simple_pad_periphs_07_gpio07, alt_1_simple_pad_periphs_07_mux_sel_gpio07);
        tranif1 alt_1_simple_pad_08_gpio08 (pad_periphs_a_08_pad, alt_1_simple_pad_periphs_08_gpio08, alt_1_simple_pad_periphs_08_mux_sel_gpio08);
        tranif1 alt_1_simple_pad_09_gpio09 (pad_periphs_a_09_pad, alt_1_simple_pad_periphs_09_gpio09, alt_1_simple_pad_periphs_09_mux_sel_gpio09);
        tranif1 alt_1_simple_pad_10_gpio10 (pad_periphs_a_10_pad, alt_1_simple_pad_periphs_10_gpio10, alt_1_simple_pad_periphs_10_mux_sel_gpio10);
        tranif1 alt_1_simple_pad_11_gpio11 (pad_periphs_a_11_pad, alt_1_simple_pad_periphs_11_gpio11, alt_1_simple_pad_periphs_11_mux_sel_gpio11);
        tranif1 alt_1_simple_pad_12_gpio12 (pad_periphs_a_12_pad, alt_1_simple_pad_periphs_12_gpio12, alt_1_simple_pad_periphs_12_mux_sel_gpio12);
        tranif1 alt_1_simple_pad_13_gpio13 (pad_periphs_a_13_pad, alt_1_simple_pad_periphs_13_gpio13, alt_1_simple_pad_periphs_13_mux_sel_gpio13);
      `endif
    `endif
  `endif
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
     if(USE_S25FS256S_MODEL == 1) begin : opentitan_spi_flash
      // configure the OT_QSPI1 pads, non muxed
      s25fs256s #(
        .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
        .UserPreload   ( 0 )
      ) i_ot_qspi_flash_csn0 (
        .SI       ( pad_periphs_ot_spi_02_pad ),
        .SO       ( pad_periphs_ot_spi_03_pad ),
        .SCK      ( pad_periphs_ot_spi_00_pad ),
        .CSNeg    ( pad_periphs_ot_spi_01_pad ),
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

        repeat(50)
            @(posedge rtc_i);
        #20ns
        @(negedge rtc_i);
        rst_ni = 1'b1;
        repeat(50)
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
    logic [63:0] to_host;

    dm::sbcs_t sbcs;

    if ( $value$plusargs ("CORE_ID=%d", cid));
      $display("Core ID: %d", cid);

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


      // Wait the FLL to generate the clock
      $display("Waiting the FLL clock before initiating the debug module...");
      repeat(10)
      @(posedge clk_i);
      jtag_init(cid);

      if(PRELOAD_HYPERRAM==0) begin
        // Load cluster code
        if(cluster_binary!="none")
          jtag_elf_load(cluster_binary, binary_entry, cid);
        if(binary!="none") begin
          $display("Load binary...");
          // Load host code
          jtag_elf_load(binary, binary_entry, cid);
          $display("Wakeup Core..");
          jtag_elf_run(binary_entry, cid);
          $display("Wait EOC...");
          jtag_wait_for_eoc ( TOHOST );
        end
      end else begin

        $display("Preload at %x - Sanity write/read at 0x1C000000", LINKER_ENTRY);
        addr = 32'h1c000000;
        jtag_write_reg (addr, {32'hdeadcaca, 32'habbaabba});
        binary_entry={32'h00000000,LINKER_ENTRY};
        #(REFClockPeriod);
        $display("Wakeup here at %x!!", binary_entry);
        jtag_ariane_wakeup( LINKER_ENTRY, cid );
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
  task automatic jtag_init(input bit cid);
    jtag_idcode_t idcode;
    dm::dmcontrol_t dmcontrol = '{dmactive: 1, hartsello:cid, default: '0};
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
  task automatic jtag_elf_load(input string binary, output doub_bt binary_entry, input bit cid );
    dm::dmstatus_t status;
    // Halt hart i
    jtag_write(dm::DMControl, dm::dmcontrol_t'{haltreq: 1, hartsello:cid, dmactive: 1, default: '0});
    do jtag_dbg.read_dmi_exp_backoff(dm::DMStatus, status);
    while (~status.allhalted);
    $display("[JTAG] Halted hart %d", cid);
    // Preload binary
    jtag_elf_preload(binary, binary_entry);
  endtask

  // Run a binary
  task automatic jtag_elf_run(input doub_bt binary_entry, input bit cid);
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
    jtag_write(dm::DMControl, dm::dmcontrol_t'{resumereq: 1, dmactive: 1, hartsello: cid, default: '0});
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
 `ifdef TARGET_ASIC
    jtag_poll_bit0(tohost, exit_code, 10);
 `else
    jtag_poll_bit0(tohost, exit_code, 800);
 `endif

    exit_code >>= 1;
    if (exit_code) $error("[JTAG] FAILED: return code %0d", exit_code);
    else $display("[JTAG] SUCCESS");
    $finish;
  endtask

  task jtag_ariane_wakeup;
    input logic [31:0] start_addr;
    input bit          cid;
    logic [31:0] dm_status;

    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    $info("======== Waking up Ariane using JTAG ========");
    // Initialize the dm module again, otherwise it will not work
    jtag_init(cid);
    // Write PC to Data0 and Data1
    jtag_write(dm::Data0, start_addr);

    jtag_write(dm::Data1, 32'h0000_0000);

    // Halt Req
    jtag_write(dm::DMControl, dm::dmcontrol_t'{haltreq: 1, hartsello:cid, dmactive: 1, default: '0});

    // Wait for CVA6 to be halted
    do jtag_dbg.read_dmi_exp_backoff(dm::DMStatus, dm_status);
    while (!dm_status[8]);

    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    jtag_write(dm::DMControl,  dm::dmcontrol_t'{hartsello:cid, dmactive: 1, default: '0});

    // Register Access Abstract Command
    jtag_write(dm::Command, {8'h0,1'b0,3'h3,1'b0,1'b0,1'b1,1'b1,4'h0,dm::CSR_DPC});

    // Resume req. Exiting from debug mode CVA6 will jump at the DPC address.
    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    jtag_write(dm::DMControl,  dm::dmcontrol_t'{resumereq:1, hartsello:cid, dmactive: 1, default: '0});
    jtag_write(dm::DMControl,  dm::dmcontrol_t'{hartsello:cid, dmactive: 1, default: '0});

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

     if(!$value$plusargs("OT_FLASH=%s", ot_flash)) begin
        ot_flash="none";
        $display("OT_FLASH: %s", ot_flash);
     end
     if(!$value$plusargs("BOOTMODE=%d", boot_mode)) begin
        boot_mode=0;
        $display("BOOTMODE: %d", boot_mode);
     end
     if(!$value$plusargs("OT_SRAM=%s", ot_sram)) begin
        ot_sram="none";
        $display("Loading to SRAM: %s", ot_sram);
     end
     case(boot_mode)
         0:begin
           bootmode = 1'b0;
           riscv_ibex_dbg.reset_master();
           if (ot_sram != "none") begin
                repeat(50)
                  @(posedge rtc_i);
                debug_secd_module_init();
                load_secd_binary(ot_sram);
                jtag_secd_data_preload();
                jtag_secd_wakeup(32'h e0000080); //preload the flashif
                jtag_secd_wait_eoc();
           end
         end
         1:begin
           bootmode = 1'b1;
           riscv_ibex_dbg.reset_master();
           spih_norflash_ot_preload(ot_flash);
           repeat(50)
             @(posedge rtc_i);
           jtag_secd_wait_eoc();
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

  task automatic spih_norflash_ot_preload(string image);
    // We overlay the entire memory with an alternating pattern
    for (int k = 0; k < $size(opentitan_spi_flash.i_ot_qspi_flash_csn0.Mem); ++k)
        opentitan_spi_flash.i_ot_qspi_flash_csn0.Mem[k] = 'h9a;
    // We load an image into chip 0 only if it exists
    if (image != "")
      $readmemh(image, opentitan_spi_flash.i_ot_qspi_flash_csn0.Mem);
  endtask

  task jtag_secd_wait_eoc;
    automatic dm_ot::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };
    logic [31:0] retval;
    logic [31:0] to_host_addr;
    to_host_addr = 32'h c11c0018;

    // Initialize the dm module again, otherwise it will not work
    debug_secd_module_init();
    sbcs.sbreadonaddr = 1;
    sbcs.sbautoincrement = 0;
    riscv_ibex_dbg.write_dmi(dm_ot::SBCS, sbcs);
    do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs);
    while (sbcs.sbbusy);

    riscv_ibex_dbg.write_dmi(dm_ot::SBAddress0, to_host_addr); // tohost address
    riscv_ibex_dbg.wait_idle(10);
    do begin
	     do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs);
	     while (sbcs.sbbusy);
       riscv_ibex_dbg.write_dmi(dm_ot::SBAddress0, to_host_addr); // tohost address
	     do riscv_ibex_dbg.read_dmi(dm_ot::SBCS, sbcs);
	     while (sbcs.sbbusy);
       riscv_ibex_dbg.read_dmi(dm_ot::SBData0, retval);
       # 400ns;
    end while (~retval[0]);

    if (retval != 32'h00000001) $error("[JTAG] FAILED: return code %0d", retval);
    else $display("[JTAG] SUCCESS");

    $finish;

  endtask // jtag_read_eoc

endmodule // ariane_tb

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
// Author: Luca Valente, University of Bologna
// Date: 18.06.2021
// Description: AlSaqr platform, it holds host_domain and cluster

`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

`ifndef FPGA_EMUL
  `ifndef SIMPLE_PADFRAME
      `include "alsaqr_periph_padframe/assign.svh"
    `else
      `include "alsaqr_periph_fpga_padframe/assign.svh"
  `endif
`else
  `include "alsaqr_periph_fpga_padframe/assign.svh"
`endif

`include "axi/typedef.svh"
`include "axi/assign.svh"
`include "cluster_bus_defines.sv"
`include "pulp_soc_defines.sv"

module al_saqr
  import axi_pkg::xbar_cfg_t;
  import apb_soc_pkg::NUM_GPIO;
  import udma_subsystem_pkg::*;
  import gpio_pkg::*;
  import ariane_soc::*;

  `ifndef FPGA_EMUL
    `ifndef SIMPLE_PADFRAME
        import pkg_alsaqr_periph_padframe::*;
      `else
        import pkg_alsaqr_periph_fpga_padframe::*;
      `endif
  `else
      import pkg_alsaqr_periph_fpga_padframe::*;
  `endif

  import ariane_soc::HyperbusNumPhys;
  import ariane_soc::NumChipsPerHyperbus;
#(
  parameter int unsigned AXI_USER_WIDTH    = 1,
  parameter int unsigned AXI_ADDRESS_WIDTH = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 64,
`ifdef DROMAJO
  parameter bit          InclSimDTM        = 1'b0,
`else
  parameter bit          InclSimDTM        = 1'b1,
`endif
  parameter int unsigned NUM_WORDS         = 2**25,         // memory size
  parameter bit          StallRandomOutput = 1'b0,
  parameter bit          StallRandomInput  = 1'b0,
  parameter bit          JtagEnable        = 1'b1
) (
  inout logic         rtc_i,
  inout logic         rst_ni,
  inout logic         bypass_clk_i,

`ifdef XILINX_DDR
  AXI_BUS.Master      axi_ddr_master,
`endif

  // HYPERBUS
  `ifndef XILINX_DDR
  inout  [HyperbusNumPhys-1:0][NumChipsPerHyperbus-1:0] pad_hyper_csn,
  inout  [HyperbusNumPhys-1:0]                          pad_hyper_ck,
  inout  [HyperbusNumPhys-1:0]                          pad_hyper_ckn,
  inout  [HyperbusNumPhys-1:0]                          pad_hyper_rwds,
  inout  [HyperbusNumPhys-1:0]                          pad_hyper_reset,
  inout  [HyperbusNumPhys-1:0][7:0]                     pad_hyper_dq,
  `endif

 `ifndef EXCLUDE_PADFRAME
  inout wire logic    pad_periphs_a_00_pad,
  inout wire logic    pad_periphs_a_01_pad,
  inout wire logic    pad_periphs_a_02_pad,
  inout wire logic    pad_periphs_a_03_pad,
  inout wire logic    pad_periphs_a_04_pad,
  inout wire logic    pad_periphs_a_05_pad,
  inout wire logic    pad_periphs_a_06_pad,
  inout wire logic    pad_periphs_a_07_pad,
  inout wire logic    pad_periphs_a_08_pad,
  inout wire logic    pad_periphs_a_09_pad,
  inout wire logic    pad_periphs_a_10_pad,
  inout wire logic    pad_periphs_a_11_pad,
  inout wire logic    pad_periphs_a_12_pad,
  inout wire logic    pad_periphs_a_13_pad,
  inout wire logic    pad_periphs_a_14_pad,
  inout wire logic    pad_periphs_a_15_pad,
  inout wire logic    pad_periphs_a_16_pad,

  `ifndef FPGA_EMUL
    `ifndef SIMPLE_PADFRAME
        inout wire logic    pad_periphs_a_17_pad,
        inout wire logic    pad_periphs_a_18_pad,
        inout wire logic    pad_periphs_a_19_pad,
        inout wire logic    pad_periphs_a_20_pad,
        inout wire logic    pad_periphs_a_21_pad,
        inout wire logic    pad_periphs_a_22_pad,
        inout wire logic    pad_periphs_a_23_pad,
        inout wire logic    pad_periphs_a_24_pad,
        inout wire logic    pad_periphs_a_25_pad,
        inout wire logic    pad_periphs_a_26_pad,
        inout wire logic    pad_periphs_a_27_pad,
        inout wire logic    pad_periphs_a_28_pad,
        inout wire logic    pad_periphs_a_29_pad,

        inout wire logic    pad_periphs_b_00_pad,
        inout wire logic    pad_periphs_b_01_pad,
        inout wire logic    pad_periphs_b_02_pad,
        inout wire logic    pad_periphs_b_03_pad,
        inout wire logic    pad_periphs_b_04_pad,
        inout wire logic    pad_periphs_b_05_pad,
        inout wire logic    pad_periphs_b_06_pad,
        inout wire logic    pad_periphs_b_07_pad,
        inout wire logic    pad_periphs_b_08_pad,
        inout wire logic    pad_periphs_b_09_pad,
        inout wire logic    pad_periphs_b_10_pad,
        inout wire logic    pad_periphs_b_11_pad,
        inout wire logic    pad_periphs_b_12_pad,
        inout wire logic    pad_periphs_b_13_pad,
        inout wire logic    pad_periphs_b_14_pad,
        inout wire logic    pad_periphs_b_15_pad,
        inout wire logic    pad_periphs_b_16_pad,
        inout wire logic    pad_periphs_b_17_pad,
        inout wire logic    pad_periphs_b_18_pad,
        inout wire logic    pad_periphs_b_19_pad,
        inout wire logic    pad_periphs_b_20_pad,
        inout wire logic    pad_periphs_b_21_pad,
        inout wire logic    pad_periphs_b_22_pad,
        inout wire logic    pad_periphs_b_23_pad,
        inout wire logic    pad_periphs_b_24_pad,
        inout wire logic    pad_periphs_b_25_pad,
        inout wire logic    pad_periphs_b_26_pad,
        inout wire logic    pad_periphs_b_27_pad,
        inout wire logic    pad_periphs_b_28_pad,
        inout wire logic    pad_periphs_b_29_pad,
        inout wire logic    pad_periphs_b_30_pad,
        inout wire logic    pad_periphs_b_31_pad,
        inout wire logic    pad_periphs_b_32_pad,
        inout wire logic    pad_periphs_b_33_pad,
        inout wire logic    pad_periphs_b_34_pad,
        inout wire logic    pad_periphs_b_35_pad,
        inout wire logic    pad_periphs_b_36_pad,
        inout wire logic    pad_periphs_b_37_pad,
        inout wire logic    pad_periphs_b_38_pad,
        inout wire logic    pad_periphs_b_39_pad,
        inout wire logic    pad_periphs_b_40_pad,
        inout wire logic    pad_periphs_b_41_pad,
        inout wire logic    pad_periphs_b_42_pad,
        inout wire logic    pad_periphs_b_43_pad,
        inout wire logic    pad_periphs_b_44_pad,
        inout wire logic    pad_periphs_b_45_pad,
        inout wire logic    pad_periphs_b_46_pad,
        inout wire logic    pad_periphs_b_47_pad,

        inout wire logic    pad_periphs_ot_spi_00_pad,
        inout wire logic    pad_periphs_ot_spi_01_pad,
        inout wire logic    pad_periphs_ot_spi_02_pad,
        inout wire logic    pad_periphs_ot_spi_03_pad,
      `endif
    `endif
 `else
   input  logic fpga_pad_uart_rx_i,
   output logic fpga_pad_uart_tx_o,
 `endif
 `ifdef ETH2FMC_NO_PADFRAME
  output wire       eth_rst_n,
  input  wire       eth_rxck ,
  input  wire       eth_rxctl,
  input  wire [3:0] eth_rxd  ,
  output wire       eth_txck ,
  output wire       eth_txctl,
  output wire [3:0] eth_txd  ,
  inout  wire       eth_mdio ,
  output logic      eth_mdc  ,
 `endif
  // JTAG
  inout wire          jtag_TCK,
  inout wire          jtag_TMS,
  inout wire          jtag_TDI,
  inout wire          jtag_TRSTn,
  inout wire          jtag_TDO_data,

  inout wire          jtag_ot_TCK,
  inout wire          jtag_ot_TMS,
  inout wire          jtag_ot_TDI,
  inout wire          jtag_ot_TRSTn,
  inout wire          jtag_ot_TDO_data,
  // Boot Select
  inout wire          pad_bootmode
);
  import lc_ctrl_pkg::*;
  import edn_pkg::*;
  import top_earlgrey_pkg::*;

  localparam int unsigned AsyncAxiOutAwWidth    = secure_subsystem_synth_pkg::SynthAsyncAxiOutAwWidth;
  localparam int unsigned AsyncAxiOutWWidth     = secure_subsystem_synth_pkg::SynthAsyncAxiOutWWidth;
  localparam int unsigned AsyncAxiOutBWidth     = secure_subsystem_synth_pkg::SynthAsyncAxiOutBWidth;
  localparam int unsigned AsyncAxiOutArWidth    = secure_subsystem_synth_pkg::SynthAsyncAxiOutArWidth;
  localparam int unsigned AsyncAxiOutRWidth     = secure_subsystem_synth_pkg::SynthAsyncAxiOutRWidth;
  localparam int unsigned LogDepth              = secure_subsystem_synth_pkg::SynthLogDepth;

  localparam type         axi_secd_aw_chan_t     = secure_subsystem_synth_pkg::synth_axi_out_aw_chan_t;
  localparam type         axi_secd_w_chan_t      = secure_subsystem_synth_pkg::synth_axi_out_w_chan_t;
  localparam type         axi_secd_b_chan_t      = secure_subsystem_synth_pkg::synth_axi_out_b_chan_t;
  localparam type         axi_secd_ar_chan_t     = secure_subsystem_synth_pkg::synth_axi_out_ar_chan_t;
  localparam type         axi_secd_r_chan_t      = secure_subsystem_synth_pkg::synth_axi_out_r_chan_t;
  localparam type         axi_secd_req_t         = secure_subsystem_synth_pkg::synth_axi_out_req_t;
  localparam type         axi_secd_resp_t        = secure_subsystem_synth_pkg::synth_axi_out_resp_t;

  // AXILITE parameters
  localparam int unsigned AXI_LITE_AW       = 32;
  localparam int unsigned AXI_LITE_DW       = 32;

  logic                        s_rst_ni;
  logic                        s_jtag_TCK;
  logic                        s_jtag_TDI;
  logic                        s_jtag_TDO;
  logic                        s_jtag_TMS;
  logic                        s_jtag_TRSTn;
  logic                        s_rtc_i;
  logic                        s_bypass_clk;


  logic [AsyncAxiOutAwWidth-1:0] async_axi_ot_out_aw_data_o;
  logic             [LogDepth:0] async_axi_ot_out_aw_wptr_o;
  logic             [LogDepth:0] async_axi_ot_out_aw_rptr_i;
  logic [ AsyncAxiOutWWidth-1:0] async_axi_ot_out_w_data_o;
  logic             [LogDepth:0] async_axi_ot_out_w_wptr_o;
  logic             [LogDepth:0] async_axi_ot_out_w_rptr_i;
  logic [ AsyncAxiOutBWidth-1:0] async_axi_ot_out_b_data_i;
  logic             [LogDepth:0] async_axi_ot_out_b_wptr_i;
  logic             [LogDepth:0] async_axi_ot_out_b_rptr_o;
  logic [AsyncAxiOutArWidth-1:0] async_axi_ot_out_ar_data_o;
  logic             [LogDepth:0] async_axi_ot_out_ar_wptr_o;
  logic             [LogDepth:0] async_axi_ot_out_ar_rptr_i;
  logic [ AsyncAxiOutRWidth-1:0] async_axi_ot_out_r_data_i;
  logic             [LogDepth:0] async_axi_ot_out_r_wptr_i;
  logic             [LogDepth:0] async_axi_ot_out_r_rptr_o;

  logic                          s_jtag_ot_TCK;
  logic                          s_jtag_ot_TDI;
  logic                          s_jtag_ot_TDO;
  logic                          s_jtag_ot_TMS;
  logic                          s_jtag_ot_TRSTn;

  logic                          doorbell_irq;

  logic                          bootmode_o;
  logic [1:0]                    bootmode_i;

  logic [3:0]                    spi_ot_sd_i;
  logic [3:0]                    spi_ot_sd_o;
  logic [3:0]                    spi_ot_sd_en;

  logic s_soc_clk  ;
  logic s_soc_rst_n;
  logic s_cluster_clk  ;
  logic s_cluster_rst_n;
  logic clk_opentitan_o;

  logic s_h2c_mailbox_irq;

  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) soc_to_cluster_axi_bus();
  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) tlb_to_cluster_axi_bus();
  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) cluster_to_tlb_axi_bus();
  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) tlb_to_soc_axi_bus();
  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH               ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH                  ),
     .AXI_ID_WIDTH   ( ariane_soc::SocToClusterIdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH                  )
  ) serialized_soc_to_cluster_axi_bus();
  AXI_BUS_ASYNC_GRAY #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH               ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH                  ),
     .AXI_ID_WIDTH   ( ariane_soc::SocToClusterIdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH                  ),
     .LOG_DEPTH      ( 3                               )
  ) async_soc_to_cluster_axi_bus();
  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) cluster_to_soc_axi_bus();
  AXI_BUS_ASYNC_GRAY #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
     .LOG_DEPTH      ( 3                        )
  ) async_cluster_to_soc_axi_bus();

  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) cluster_cfg_axi_lite_bus();

  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_LITE_DW              ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) c2h_tlb_cfg_axi_bus_32();

  AXI_BUS_ASYNC_GRAY #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
     .LOG_DEPTH      ( 3                        )
  ) async_cfg_axi_bus();

  AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_ADDRESS_WIDTH),
    .AXI_DATA_WIDTH (AXI_LITE_DW)
  ) c2h_tlb_cfg();

  logic s_dma_pe_evt_ack;
  logic s_dma_pe_evt_valid;

  logic s_cluster_eoc;
  logic s_cluster_eoc_sync;

  uart_to_pad_t  s_cva6_uart_tx;
  pad_to_uart_t  s_cva6_uart_rx;

  pad_to_hyper_t [HyperbusNumPhys-1:0] s_pad_to_hyper;
  hyper_to_pad_t [HyperbusNumPhys-1:0] s_hyper_to_pad;

  qspi_to_pad_t [N_SPI-1:0] s_spi_to_pad;
  pad_to_qspi_t [N_SPI-1:0] s_pad_to_spi;

  qspi_to_pad_t [N_QSPI-1:0] s_qspi_to_pad;
  pad_to_qspi_t [N_QSPI-1:0] s_pad_to_qspi;

  i2c_to_pad_t [N_I2C-1:0] s_i2c_to_pad;
  pad_to_i2c_t [N_I2C-1:0] s_pad_to_i2c;

  pad_to_cam_t [N_CAM-1:0] s_pad_to_cam;

  uart_to_pad_t [N_UART-1:0] s_uart_to_pad;
  pad_to_uart_t [N_UART-1:0] s_pad_to_uart;

  pad_to_usart_t [N_USART-1:0] s_pad_to_usart;
  usart_to_pad_t [N_USART-1:0] s_usart_to_pad;

  sdio_to_pad_t [N_SDIO-1:0] s_sdio_to_pad;
  pad_to_sdio_t [N_SDIO-1:0] s_pad_to_sdio;

  can_to_pad_t [N_CAN-1 : 0] s_can_to_pad;
  pad_to_can_t [N_CAN-1 : 0] s_pad_to_can;

  pwm_nano_to_pad_t [1:0] s_pwm_nano_to_pad;
  pwm_to_pad_t s_pwm_to_pad;

  eth_to_pad_t s_eth_to_pad;
  pad_to_eth_t s_pad_to_eth;

  fll_to_pad_t    s_fll_to_pad;

  // PWM 0-3 CHANNEL0
  assign s_pwm_nano_to_pad[0].pwm0_o = s_pwm_to_pad.pwm0_o;
  assign s_pwm_nano_to_pad[0].pwm1_o = s_pwm_to_pad.pwm1_o;
  assign s_pwm_nano_to_pad[0].pwm2_o = s_pwm_to_pad.pwm2_o;
  assign s_pwm_nano_to_pad[0].pwm3_o = s_pwm_to_pad.pwm3_o;

  // PWM 4-7 CHANNEL0
  assign s_pwm_nano_to_pad[1].pwm0_o = s_pwm_to_pad.pwm4_o;
  assign s_pwm_nano_to_pad[1].pwm1_o = s_pwm_to_pad.pwm5_o;
  assign s_pwm_nano_to_pad[1].pwm2_o = s_pwm_to_pad.pwm6_o;
  assign s_pwm_nano_to_pad[1].pwm3_o = s_pwm_to_pad.pwm7_o;

  gpio_to_pad_t s_gpio_b_to_pad;
  pad_to_gpio_t s_pad_to_gpio_b;

  qspi_to_pad_ot_t                    s_ot_spi_to_pad;
  pad_to_qspi_ot_t                    s_pad_to_ot_spi;

  port_signals_pad2soc_t              s_port_signals_pad2soc;
  port_signals_soc2pad_t              s_port_signals_soc2pad;

  axi_secd_req_t                      ot_axi_req;
  axi_secd_resp_t                     ot_axi_rsp;

  jtag_ot_pkg::jtag_req_t             jtag_ibex_i;
  jtag_ot_pkg::jtag_rsp_t             jtag_ibex_o;

  assign bootmode_i             = { 1'b0 , bootmode_o };
  assign jtag_ibex_i.tck        = s_jtag_ot_TCK;
  assign jtag_ibex_i.trst_n     = s_jtag_ot_TRSTn;
  assign jtag_ibex_i.tms        = s_jtag_ot_TMS;
  assign jtag_ibex_i.tdi        = s_jtag_ot_TDI;
  assign s_jtag_ot_TDO          = jtag_ibex_o.tdo;

  assign s_ot_spi_to_pad.sd0_oen_o =  ~spi_ot_sd_en[0];
  assign s_ot_spi_to_pad.sd1_oen_o =  ~spi_ot_sd_en[1];

  assign s_ot_spi_to_pad.sd0_o =  spi_ot_sd_o[0];
  assign s_ot_spi_to_pad.sd1_o =  spi_ot_sd_o[1];

  assign spi_ot_sd_i[0] = s_pad_to_ot_spi.sd0_i;
  assign spi_ot_sd_i[1] = s_pad_to_ot_spi.sd1_i;
  assign spi_ot_sd_i[2] = '0;
  assign spi_ot_sd_i[3] = '0;

  localparam RegAw  = 32;
  localparam RegDw  = 32;

  typedef logic [RegAw-1:0]   reg_addr_t;
  typedef logic [RegDw-1:0]   reg_data_t;
  typedef logic [RegDw/8-1:0] reg_strb_t;

  `REG_BUS_TYPEDEF_REQ(reg_req_t, reg_addr_t, reg_data_t, reg_strb_t)
  `REG_BUS_TYPEDEF_RSP(reg_rsp_t, reg_data_t)

  reg_req_t   reg_req;
  reg_rsp_t   reg_rsp;

   REG_BUS #(
        .ADDR_WIDTH( RegAw ),
        .DATA_WIDTH( RegDw )
    ) i_padframecfg_rbus (
        .clk_i (s_soc_clk)
    );

   sync i_cluster_eoc_sync (
         .clk_i    ( s_soc_clk          ),
         .rst_ni   ( s_soc_rst_n        ),
         .serial_i ( s_cluster_eoc      ),
         .serial_o ( s_cluster_eoc_sync )
         );

    host_domain #(
        .NUM_WORDS         ( NUM_WORDS  ),
        .InclSimDTM        ( 1'b1       ),
        .StallRandomOutput ( 1'b1       ),
        .StallRandomInput  ( 1'b1       ),
        .NUM_GPIO          ( NUM_GPIO   ),
        .JtagEnable        ( JtagEnable ),
        .axi_req_t         ( tlul2axi_pkg::mst_req_t ),
        .axi_rsp_t         ( tlul2axi_pkg::mst_rsp_t )
    ) i_host_domain (
      .rst_ni(s_rst_ni),
      .rtc_i(s_rtc_i),
      .bypass_clk_i(s_bypass_clk),
      .jtag_TCK               ( s_jtag_TCK                      ),
      .jtag_TMS               ( s_jtag_TMS                      ),
      .jtag_TDI               ( s_jtag_TDI                      ),
      .jtag_TRSTn             ( s_jtag_TRSTn                    ),
      .jtag_TDO_data          ( s_jtag_TDO                      ),
      .jtag_TDO_driven        (                                 ),
`ifdef XILINX_DDR
      .axi_ddr_master         ( axi_ddr_master                  ),
`endif
      .cluster_axi_master     ( soc_to_cluster_axi_bus          ),
      .cluster_lite_slave     ( cluster_cfg_axi_lite_bus        ),
      .dma_pe_evt_ack_o       ( s_dma_pe_evt_ack                ),
      .dma_pe_evt_valid_i     ( s_dma_pe_evt_valid              ),
      .h2c_irq_o              ( s_h2c_mailbox_irq               ),
      .cluster_eoc_i          ( s_cluster_eoc_sync              ),
      .cluster_axi_slave      ( tlb_to_soc_axi_bus              ),
      .c2h_tlb_cfg_lite_master( c2h_tlb_cfg                     ),
      .soc_clk_o              ( s_soc_clk                       ),
      .soc_rst_no             ( s_soc_rst_n                     ),
      .rstn_cluster_sync_o    ( s_cluster_rst_n                 ),
      .cluster_en_sa_boot_o   ( s_cluster_en_sa_boot            ),
      .cluster_fetch_en_o     ( s_cluster_fetch_en              ),
      .clk_cluster_o          ( s_cluster_clk                   ),

      .clk_opentitan_o        ( clk_opentitan_o                 ),

      .padframecfg_reg_master ( i_padframecfg_rbus              ),

      .spi_to_pad             ( s_spi_to_pad                    ),
      .pad_to_spi             ( s_pad_to_spi                    ),

      .qspi_to_pad            ( s_qspi_to_pad                   ),
      .pad_to_qspi            ( s_pad_to_qspi                   ),

      .i2c_to_pad             ( s_i2c_to_pad                    ),
      .pad_to_i2c             ( s_pad_to_i2c                    ),

  	  .pad_to_cam             ( s_pad_to_cam                    ),

      .uart_to_pad            ( s_uart_to_pad                   ),
      .pad_to_uart            ( s_pad_to_uart                   ),

      .usart_to_pad           ( s_usart_to_pad                  ),
      .pad_to_usart           ( s_pad_to_usart                  ),

      .sdio_to_pad            ( s_sdio_to_pad                   ),
      .pad_to_sdio            ( s_pad_to_sdio                   ),

      .gpio_to_pad            ( s_gpio_b_to_pad                 ),
      .pad_to_gpio            ( s_pad_to_gpio_b                 ),

      .eth_to_pad             ( s_eth_to_pad                    ),
      .pad_to_eth             ( s_pad_to_eth                    ),

      .can_to_pad             ( s_can_to_pad                    ),
      .pad_to_can             ( s_pad_to_can                    ),

      .cva6_uart_rx_i         ( s_cva6_uart_rx                  ),
      .cva6_uart_tx_o         ( s_cva6_uart_tx                  ),

       `ifndef XILINX_DDR
       .pad_hyper_csn,
       .pad_hyper_ck,
       .pad_hyper_ckn,
       .pad_hyper_rwds,
       .pad_hyper_reset,
       .pad_hyper_dq,
       `endif

      .pwm_to_pad             ( s_pwm_to_pad                    ),
      .fll_to_pad             ( s_fll_to_pad                    ),

      .ot_axi_req             ( ot_axi_req                      ),
      .ot_axi_rsp             ( ot_axi_rsp                      ),

      .doorbell_irq_o         ( doorbell_irq                    )
    );

   pad_frame #()
    i_pad_frame
      (
      .ref_clk_o        ( s_rtc_i          ),
      .bypass_o         ( s_bypass_clk     ),
      .rstn_o           ( s_rst_ni         ),
      .jtag_tck_o       ( s_jtag_TCK       ),
      .jtag_tdi_o       ( s_jtag_TDI       ),
      .jtag_tdo_i       ( s_jtag_TDO       ),
      .jtag_tms_o       ( s_jtag_TMS       ),
      .jtag_trst_o      ( s_jtag_TRSTn     ),

      .pad_reset_n      ( rst_ni           ),
      .pad_jtag_tck     ( jtag_TCK         ),
      .pad_jtag_tdi     ( jtag_TDI         ),
      .pad_jtag_tdo     ( jtag_TDO_data    ),
      .pad_jtag_tms     ( jtag_TMS         ),
      .pad_jtag_trst    ( jtag_TRSTn       ),
      .pad_bypass       ( bypass_clk_i     ),
      .pad_xtal_in      ( rtc_i            ),

      // SECD JTAG signals
      .jtag_tck_ot_o    ( s_jtag_ot_TCK    ),
      .jtag_tdi_ot_o    ( s_jtag_ot_TDI    ),
      .jtag_tdo_ot_i    ( s_jtag_ot_TDO    ),
      .jtag_tms_ot_o    ( s_jtag_ot_TMS    ),
      .jtag_trst_ot_o   ( s_jtag_ot_TRSTn  ),

      // SECD Bootmode signal
      .bootmode_o       ( bootmode_o       ),

      // SECD JTAG pads
      .pad_jtag_ot_tck  ( jtag_ot_TCK      ),
      .pad_jtag_ot_tdi  ( jtag_ot_TDI      ),
      .pad_jtag_ot_tdo  ( jtag_ot_TDO_data ),
      .pad_jtag_ot_tms  ( jtag_ot_TMS      ),
      .pad_jtag_ot_trst ( jtag_ot_TRSTn    ),

      // SECD Bootmode pad
      .pad_bootmode     ( pad_bootmode     )
     );

  `ifndef EXCLUDE_ROT

   axi_cdc_dst #(
      .SyncStages ( ariane_soc::CdcSyncStages ),
      .LogDepth   ( LogDepth                  ),
      .aw_chan_t  ( axi_secd_aw_chan_t        ),
      .w_chan_t   ( axi_secd_w_chan_t         ),
      .b_chan_t   ( axi_secd_b_chan_t         ),
      .ar_chan_t  ( axi_secd_ar_chan_t        ),
      .r_chan_t   ( axi_secd_r_chan_t         ),
      .axi_req_t  ( axi_secd_req_t            ),
      .axi_resp_t ( axi_secd_resp_t           )
   ) i_cdc_ot2host (
      .async_data_slave_aw_data_i( async_axi_ot_out_aw_data_o ),
      .async_data_slave_aw_wptr_i( async_axi_ot_out_aw_wptr_o ),
      .async_data_slave_aw_rptr_o( async_axi_ot_out_aw_rptr_i ),
      .async_data_slave_w_data_i ( async_axi_ot_out_w_data_o  ),
      .async_data_slave_w_wptr_i ( async_axi_ot_out_w_wptr_o  ),
      .async_data_slave_w_rptr_o ( async_axi_ot_out_w_rptr_i  ),
      .async_data_slave_b_data_o ( async_axi_ot_out_b_data_i  ),
      .async_data_slave_b_wptr_o ( async_axi_ot_out_b_wptr_i  ),
      .async_data_slave_b_rptr_i ( async_axi_ot_out_b_rptr_o  ),
      .async_data_slave_ar_data_i( async_axi_ot_out_ar_data_o ),
      .async_data_slave_ar_wptr_i( async_axi_ot_out_ar_wptr_o ),
      .async_data_slave_ar_rptr_o( async_axi_ot_out_ar_rptr_i ),
      .async_data_slave_r_data_o ( async_axi_ot_out_r_data_i  ),
      .async_data_slave_r_wptr_o ( async_axi_ot_out_r_wptr_i  ),
      .async_data_slave_r_rptr_i ( async_axi_ot_out_r_rptr_o  ),
      .dst_clk_i                 ( s_soc_clk  ),
      .dst_rst_ni                ( s_rst_ni   ),
      .dst_req_o                 ( ot_axi_req ),
      .dst_resp_i                ( ot_axi_rsp )
   );

   secure_subsystem_synth_wrap i_RoT_wrap (
     .clk_i            ( clk_opentitan_o    ),
     .clk_ref_i        ( clk_opentitan_o    ),
     .rst_ni           ( s_rst_ni           ),
     .pwr_on_rst_ni    ( s_rst_ni           ),
     .fetch_en_i       ( '0                 ),
     .bootmode_i       ( bootmode_i         ),
     .test_enable_i    ( '0                 ),
     .irq_ibex_i       ( doorbell_irq       ),
   // JTAG port
     .jtag_tck_i       ( jtag_ibex_i.tck    ),
     .jtag_tms_i       ( jtag_ibex_i.tms    ),
     .jtag_trst_n_i    ( jtag_ibex_i.trst_n ),
     .jtag_tdi_i       ( jtag_ibex_i.tdi    ),
     .jtag_tdo_o       ( jtag_ibex_o.tdo    ),
     .jtag_tdo_oe_o    (                    ),
   // GPIOs
     .gpio_0_o         (               ),
     .gpio_0_i         ( '0            ),
     .gpio_0_oe_o      (               ),
     .gpio_1_o         (               ),
     .gpio_1_i         ( '0            ),
     .gpio_1_oe_o      (               ),
   // axi isolated - not implemented
     .axi_isolate_i    ( 1'b0          ),
     .axi_isolated_o   (               ),
   // Uart - not implemented
     .ibex_uart_rx_i   ( '0            ),
     .ibex_uart_tx_o   (               ),
   // SPI host
     .spi_host_SCK_o    ( s_ot_spi_to_pad.clk_o  ),
     .spi_host_SCK_en_o (                         ),
     .spi_host_CSB_o    ( s_ot_spi_to_pad.csn0_o ),
     .spi_host_CSB_en_o (                         ),
     .spi_host_SD_o     ( spi_ot_sd_o             ),
     .spi_host_SD_i     ( spi_ot_sd_i             ),
     .spi_host_SD_en_o  ( spi_ot_sd_en            ),
   // Asynch axi port
     .async_axi_out_aw_data_o ( async_axi_ot_out_aw_data_o ),
     .async_axi_out_aw_wptr_o ( async_axi_ot_out_aw_wptr_o ),
     .async_axi_out_aw_rptr_i ( async_axi_ot_out_aw_rptr_i ),
     .async_axi_out_w_data_o  ( async_axi_ot_out_w_data_o  ),
     .async_axi_out_w_wptr_o  ( async_axi_ot_out_w_wptr_o  ),
     .async_axi_out_w_rptr_i  ( async_axi_ot_out_w_rptr_i  ),
     .async_axi_out_b_data_i  ( async_axi_ot_out_b_data_i  ),
     .async_axi_out_b_wptr_i  ( async_axi_ot_out_b_wptr_i  ),
     .async_axi_out_b_rptr_o  ( async_axi_ot_out_b_rptr_o  ),
     .async_axi_out_ar_data_o ( async_axi_ot_out_ar_data_o ),
     .async_axi_out_ar_wptr_o ( async_axi_ot_out_ar_wptr_o ),
     .async_axi_out_ar_rptr_i ( async_axi_ot_out_ar_rptr_i ),
     .async_axi_out_r_data_i  ( async_axi_ot_out_r_data_i  ),
     .async_axi_out_r_wptr_i  ( async_axi_ot_out_r_wptr_i  ),
     .async_axi_out_r_rptr_o  ( async_axi_ot_out_r_rptr_o  )
   );
  `else // !`ifndef EXCLUDE_ROT

   assign ot_axi_req.aw.id = 'h0;
   assign ot_axi_req.aw.addr = 'h0;
   assign ot_axi_req.aw.len = 'h0;
   assign ot_axi_req.aw.size = 'h0;
   assign ot_axi_req.aw.burst = 'h0;
   assign ot_axi_req.aw.lock = 'h0;
   assign ot_axi_req.aw.cache = 'h0;
   assign ot_axi_req.aw.prot = 'h0;
   assign ot_axi_req.aw.qos = 'h0;
   assign ot_axi_req.aw.region = 'h0;
   assign ot_axi_req.aw.atop = 'h0;
   assign ot_axi_req.aw.user = 'h0;
   assign ot_axi_req.aw_valid = 'h0;
   assign ot_axi_req.w.data = 'h0;
   assign ot_axi_req.w.strb = 'h0;
   assign ot_axi_req.w.last = 'h0;
   assign ot_axi_req.w.user = 'h0;
   assign ot_axi_req.w_valid = 'h0;
   assign ot_axi_req.b_ready = 1'b1;
   assign ot_axi_req.ar.id = 'h0;
   assign ot_axi_req.ar.addr = 'h0;
   assign ot_axi_req.ar.len = 'h0;
   assign ot_axi_req.ar.size = 'h0;
   assign ot_axi_req.ar.burst = 'h0;
   assign ot_axi_req.ar.lock = 'h0;
   assign ot_axi_req.ar.cache = 'h0;
   assign ot_axi_req.ar.prot = 'h0;
   assign ot_axi_req.ar.qos = 'h0;
   assign ot_axi_req.ar.region = 'h0;
   assign ot_axi_req.ar.user = 'h0;
   assign ot_axi_req.ar_valid = 'h0;
   assign ot_axi_req.r_ready = 1'b1;

   assign jtag_ibex_o.tdo = 1'b0;
  `endif // !`ifndef EXCLUDE_ROT

  `ifndef EXCLUDE_CLUSTER

   axi_serializer_intf #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
     .MAX_READ_TXNS  ( ariane_soc::NrSlaves     ),
     .MAX_WRITE_TXNS ( ariane_soc::NrSlaves     )
      ) (
        .clk_i  ( s_soc_clk                         ),
        .rst_ni ( s_soc_rst_n                       ),
        .slv    ( soc_to_cluster_axi_bus            ),
        .mst    ( serialized_soc_to_cluster_axi_bus )
      );

   axi_cdc_src_intf   #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH               ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH                  ),
     .AXI_ID_WIDTH   ( ariane_soc::SocToClusterIdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH                  ),
     .LOG_DEPTH      ( 3                               ),
     .SYNC_STAGES    ( ariane_soc::CdcSyncStages       )
     ) soc_to_cluster_src_cdc_fifo_i
       (
       .src_clk_i  ( s_soc_clk                         ),
       .src_rst_ni ( s_cluster_rst_n                   ),
       .src        ( serialized_soc_to_cluster_axi_bus ),
       .dst        ( async_soc_to_cluster_axi_bus      )
       );

   axi_cdc_dst_intf   #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH         ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH            ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth       ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH            ),
     .LOG_DEPTH      ( 3                         ),
     .SYNC_STAGES    ( ariane_soc::CdcSyncStages )
     ) cluster_to_soc_dst_cdc_fifo_i (
       .dst_clk_i  ( s_soc_clk                    ),
       .dst_rst_ni ( s_cluster_rst_n              ),
       .src        ( async_cluster_to_soc_axi_bus ),
       .dst        ( cluster_to_tlb_axi_bus       )
       );

   axi_cdc_dst_intf      #(
     .AXI_ADDR_WIDTH      ( AXI_ADDRESS_WIDTH         ),
     .AXI_DATA_WIDTH      ( AXI_DATA_WIDTH            ),
     .AXI_ID_WIDTH        ( ariane_soc::IdWidth       ),
     .AXI_USER_WIDTH      ( AXI_USER_WIDTH            ),
     .LOG_DEPTH           ( 3                         ),
     .SYNC_STAGES         ( ariane_soc::CdcSyncStages )
     ) cfg_dst_cdc_fifo_i (
       .dst_clk_i         ( s_soc_clk                ),
       .dst_rst_ni        ( s_cluster_rst_n          ),
       .src               ( async_cfg_axi_bus        ),
       .dst               ( cluster_cfg_axi_lite_bus )
       );

    pulp_cluster
    `ifdef CHANGE_CLUSTER_PARAMETERS
    #(
        .NB_CORES                     ( `NB_CORES                       ),
        .NB_HWPE_PORTS                ( 9                               ),
        .NB_DMAS                      ( `NB_DMAS                        ),
        .HWPE_PRESENT                 ( `REDMULE                        ),
        .TCDM_SIZE                    ( 256*1024                        ),
        .NB_TCDM_BANKS                ( 16                              ),
        .SET_ASSOCIATIVE              ( 4                               ),
        .CACHE_LINE                   ( 1                               ),
        .CACHE_SIZE                   ( 4096                            ),
        .ICACHE_DATA_WIDTH            ( 128                             ),
        .L0_BUFFER_FEATURE            ( "DISABLED"                      ),
        .MULTICAST_FEATURE            ( "DISABLED"                      ),
        .SHARED_ICACHE                ( "ENABLED"                       ),
        .DIRECT_MAPPED_FEATURE        ( "DISABLED"                      ),
        .L2_SIZE                      ( 512*1024                        ),
        .ROM_BOOT_ADDR                ( 32'h1A000000                    ),
        .BOOT_ADDR                    ( 32'h1C000000                    ),
        .INSTR_RDATA_WIDTH            ( 32                              ),
        .CLUST_FPU                    ( `CLUST_FPU                      ),
        .CLUST_FP_DIVSQRT             ( `CLUST_FP_DIVSQRT               ),
        .CLUST_SHARED_FP              ( `CLUST_SHARED_FP                ),
        .CLUST_SHARED_FP_DIVSQRT      ( `CLUST_SHARED_FP_DIVSQRT        ),
        .AXI_ADDR_WIDTH               ( AXI_ADDRESS_WIDTH               ),
        .AXI_DATA_IN_WIDTH            ( AXI_DATA_WIDTH                  ),
        .AXI_DATA_OUT_WIDTH           ( AXI_DATA_WIDTH                  ),
        .AXI_USER_WIDTH               ( AXI_USER_WIDTH                  ),
        .AXI_ID_IN_WIDTH              ( ariane_soc::SocToClusterIdWidth ),
        .AXI_ID_OUT_WIDTH             ( ariane_soc::IdWidth             ),
        .SYNC_STAGES                  ( ariane_soc::CdcSyncStages       ),
        .LOG_DEPTH                    ( 3                               ),
        .DATA_WIDTH                   ( 32                              ),
        .ADDR_WIDTH                   ( 32                              ),
        .LOG_CLUSTER                  ( 3                               ),
        .PE_ROUTING_LSB               ( 10                              ),
        .EVNT_WIDTH                   ( 8                               )
    )
   `endif
    cluster_i
    (
        .clk_i                           ( s_cluster_clk                        ),
        .rst_ni                          ( s_cluster_rst_n                      ),
        .ref_clk_i                       ( s_rtc_i                              ),

        .pmu_mem_pwdn_i                  ( 1'b0                                 ),

        .base_addr_i                     ( '0                                   ),

        .dma_pe_evt_ack_i                ( s_dma_pe_evt_ack                     ),
        .dma_pe_evt_valid_o              ( s_dma_pe_evt_valid                   ),

        .dma_pe_irq_ack_i                ( 1'b1                                 ),
        .dma_pe_irq_valid_o              (                                      ),

        .dbg_irq_valid_i                 ( '0                                   ),

        .host_mailbox_irq_i              ( s_h2c_mailbox_irq                    ),

        .pf_evt_ack_i                    ( 1'b1                                 ),
        .pf_evt_valid_o                  (                                      ),

        .async_cluster_events_wptr_i     ( '0                                   ),
        .async_cluster_events_rptr_o     (                                      ),
        .async_cluster_events_data_i     ( '0                                   ),

        .en_sa_boot_i                    ( s_cluster_en_sa_boot                 ),
        .test_mode_i                     ( 1'b0                                 ),
        .fetch_en_i                      ( s_cluster_fetch_en                   ),
        .eoc_o                           ( s_cluster_eoc                        ),
        .busy_o                          (                                      ),
        .cluster_id_i                    ( 6'b000000                            ),

        .async_data_master_aw_wptr_o     ( async_cluster_to_soc_axi_bus.aw_wptr ),
        .async_data_master_aw_rptr_i     ( async_cluster_to_soc_axi_bus.aw_rptr ),
        .async_data_master_aw_data_o     ( async_cluster_to_soc_axi_bus.aw_data ),
        .async_data_master_ar_wptr_o     ( async_cluster_to_soc_axi_bus.ar_wptr ),
        .async_data_master_ar_rptr_i     ( async_cluster_to_soc_axi_bus.ar_rptr ),
        .async_data_master_ar_data_o     ( async_cluster_to_soc_axi_bus.ar_data ),
        .async_data_master_w_data_o      ( async_cluster_to_soc_axi_bus.w_data  ),
        .async_data_master_w_wptr_o      ( async_cluster_to_soc_axi_bus.w_wptr  ),
        .async_data_master_w_rptr_i      ( async_cluster_to_soc_axi_bus.w_rptr  ),
        .async_data_master_r_wptr_i      ( async_cluster_to_soc_axi_bus.r_wptr  ),
        .async_data_master_r_rptr_o      ( async_cluster_to_soc_axi_bus.r_rptr  ),
        .async_data_master_r_data_i      ( async_cluster_to_soc_axi_bus.r_data  ),
        .async_data_master_b_wptr_i      ( async_cluster_to_soc_axi_bus.b_wptr  ),
        .async_data_master_b_rptr_o      ( async_cluster_to_soc_axi_bus.b_rptr  ),
        .async_data_master_b_data_i      ( async_cluster_to_soc_axi_bus.b_data  ),

        .async_cfg_master_aw_wptr_o      ( async_cfg_axi_bus.aw_wptr            ),
        .async_cfg_master_aw_rptr_i      ( async_cfg_axi_bus.aw_rptr            ),
        .async_cfg_master_aw_data_o      ( async_cfg_axi_bus.aw_data            ),
        .async_cfg_master_ar_wptr_o      ( async_cfg_axi_bus.ar_wptr            ),
        .async_cfg_master_ar_rptr_i      ( async_cfg_axi_bus.ar_rptr            ),
        .async_cfg_master_ar_data_o      ( async_cfg_axi_bus.ar_data            ),
        .async_cfg_master_w_data_o       ( async_cfg_axi_bus.w_data             ),
        .async_cfg_master_w_wptr_o       ( async_cfg_axi_bus.w_wptr             ),
        .async_cfg_master_w_rptr_i       ( async_cfg_axi_bus.w_rptr             ),
        .async_cfg_master_r_wptr_i       ( async_cfg_axi_bus.r_wptr             ),
        .async_cfg_master_r_rptr_o       ( async_cfg_axi_bus.r_rptr             ),
        .async_cfg_master_r_data_i       ( async_cfg_axi_bus.r_data             ),
        .async_cfg_master_b_wptr_i       ( async_cfg_axi_bus.b_wptr             ),
        .async_cfg_master_b_rptr_o       ( async_cfg_axi_bus.b_rptr             ),
        .async_cfg_master_b_data_i       ( async_cfg_axi_bus.b_data             ),

        .async_data_slave_aw_wptr_i      ( async_soc_to_cluster_axi_bus.aw_wptr ),
        .async_data_slave_aw_rptr_o      ( async_soc_to_cluster_axi_bus.aw_rptr ),
        .async_data_slave_aw_data_i      ( async_soc_to_cluster_axi_bus.aw_data ),
        .async_data_slave_ar_wptr_i      ( async_soc_to_cluster_axi_bus.ar_wptr ),
        .async_data_slave_ar_rptr_o      ( async_soc_to_cluster_axi_bus.ar_rptr ),
        .async_data_slave_ar_data_i      ( async_soc_to_cluster_axi_bus.ar_data ),
        .async_data_slave_w_data_i       ( async_soc_to_cluster_axi_bus.w_data  ),
        .async_data_slave_w_wptr_i       ( async_soc_to_cluster_axi_bus.w_wptr  ),
        .async_data_slave_w_rptr_o       ( async_soc_to_cluster_axi_bus.w_rptr  ),
        .async_data_slave_r_wptr_o       ( async_soc_to_cluster_axi_bus.r_wptr  ),
        .async_data_slave_r_rptr_i       ( async_soc_to_cluster_axi_bus.r_rptr  ),
        .async_data_slave_r_data_o       ( async_soc_to_cluster_axi_bus.r_data  ),
        .async_data_slave_b_wptr_o       ( async_soc_to_cluster_axi_bus.b_wptr  ),
        .async_data_slave_b_rptr_i       ( async_soc_to_cluster_axi_bus.b_rptr  ),
        .async_data_slave_b_data_o       ( async_soc_to_cluster_axi_bus.b_data  )
   );
  `else // !`ifndef EXCLUDE_CLUSTER

     assign cluster_cfg_axi_lite_bus.aw_id = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_addr = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_len = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_size = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_burst = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_lock = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_cache = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_prot = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_qos = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_region = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_atop = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_user = 'h0;
     assign cluster_cfg_axi_lite_bus.aw_valid = 'h0;
     assign cluster_cfg_axi_lite_bus.w_data = 'h0;
     assign cluster_cfg_axi_lite_bus.w_strb = 'h0;
     assign cluster_cfg_axi_lite_bus.w_last = 'h0;
     assign cluster_cfg_axi_lite_bus.w_user = 'h0;
     assign cluster_cfg_axi_lite_bus.w_valid = 'h0;
     assign cluster_cfg_axi_lite_bus.b_ready = 1'b1;
     assign cluster_cfg_axi_lite_bus.ar_id = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_addr = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_len = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_size = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_burst = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_lock = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_cache = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_prot = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_qos = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_region = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_user = 'h0;
     assign cluster_cfg_axi_lite_bus.ar_valid = 'h0;
     assign cluster_cfg_axi_lite_bus.r_ready = 1'b1;

     assign cluster_to_tlb_axi_bus.aw_id = 'h0;
     assign cluster_to_tlb_axi_bus.aw_addr = 'h0;
     assign cluster_to_tlb_axi_bus.aw_len = 'h0;
     assign cluster_to_tlb_axi_bus.aw_size = 'h0;
     assign cluster_to_tlb_axi_bus.aw_burst = 'h0;
     assign cluster_to_tlb_axi_bus.aw_lock = 'h0;
     assign cluster_to_tlb_axi_bus.aw_cache = 'h0;
     assign cluster_to_tlb_axi_bus.aw_prot = 'h0;
     assign cluster_to_tlb_axi_bus.aw_qos = 'h0;
     assign cluster_to_tlb_axi_bus.aw_region = 'h0;
     assign cluster_to_tlb_axi_bus.aw_atop = 'h0;
     assign cluster_to_tlb_axi_bus.aw_user = 'h0;
     assign cluster_to_tlb_axi_bus.aw_valid = 'h0;
     assign cluster_to_tlb_axi_bus.w_data = 'h0;
     assign cluster_to_tlb_axi_bus.w_strb = 'h0;
     assign cluster_to_tlb_axi_bus.w_last = 'h0;
     assign cluster_to_tlb_axi_bus.w_user = 'h0;
     assign cluster_to_tlb_axi_bus.w_valid = 'h0;
     assign cluster_to_tlb_axi_bus.b_ready = 1'b1;
     assign cluster_to_tlb_axi_bus.ar_id = 'h0;
     assign cluster_to_tlb_axi_bus.ar_addr = 'h0;
     assign cluster_to_tlb_axi_bus.ar_len = 'h0;
     assign cluster_to_tlb_axi_bus.ar_size = 'h0;
     assign cluster_to_tlb_axi_bus.ar_burst = 'h0;
     assign cluster_to_tlb_axi_bus.ar_lock = 'h0;
     assign cluster_to_tlb_axi_bus.ar_cache = 'h0;
     assign cluster_to_tlb_axi_bus.ar_prot = 'h0;
     assign cluster_to_tlb_axi_bus.ar_qos = 'h0;
     assign cluster_to_tlb_axi_bus.ar_region = 'h0;
     assign cluster_to_tlb_axi_bus.ar_user = 'h0;
     assign cluster_to_tlb_axi_bus.ar_valid = 'h0;
     assign cluster_to_tlb_axi_bus.r_ready = 1'b1;

     ariane_axi_soc::req_slv_t    fake_cluster_s_req;
     ariane_axi_soc::resp_slv_t   fake_cluster_s_resp;

     `AXI_ASSIGN_TO_REQ(fake_cluster_s_req,tlb_to_cluster_axi_bus)
     `AXI_ASSIGN_FROM_RESP(tlb_to_cluster_axi_bus,fake_cluster_s_resp)

     axi_err_slv #(
       .AxiIdWidth ( ariane_soc::IdWidth        ),
       .axi_req_t  ( ariane_axi_soc::req_slv_t  ),
       .axi_resp_t ( ariane_axi_soc::resp_slv_t ),
       .RespWidth  ( 32'd64                     ),
       .RespData   ( 64'hdeadbeefdeadbeef       ),
       .ATOPs      ( 1'b0                       ),
       .MaxTrans   ( 1                          )
       ) clusternotimplemented (
         .clk_i      ( s_soc_clk           ),
         .rst_ni     ( s_soc_rst_n         ),
         .slv_req_i  ( fake_cluster_s_req  ),
         .slv_resp_o ( fake_cluster_s_resp )
         );
   `endif // !`ifndef EXCLUDE_CLUSTER

  localparam int unsigned ENTRIES = 32;

   axi_tlb_intf #(
     .AXI_SLV_PORT_ADDR_WIDTH ( AXI_ADDRESS_WIDTH      ),
     .AXI_MST_PORT_ADDR_WIDTH ( AXI_ADDRESS_WIDTH      ),
     .AXI_DATA_WIDTH          ( AXI_DATA_WIDTH         ),
     .AXI_ID_WIDTH            ( ariane_soc::IdWidth    ),
     .AXI_USER_WIDTH          ( AXI_USER_WIDTH         ),
     .AXI_SLV_PORT_MAX_TXNS   ( 8                      ),
     .CFG_AXI_ADDR_WIDTH      ( AXI_LITE_AW            ),
     .CFG_AXI_DATA_WIDTH      ( AXI_LITE_DW            ),
     .L1_NUM_ENTRIES          ( ENTRIES                ),
     .L1_CUT_AX               ( 1                      )
   ) i_c2h_tlb                (
     .clk_i                   ( s_soc_clk              ),
     .rst_ni                  ( s_soc_rst_n            ),
     .test_en_i               ( 1'b0                   ),
     .slv                     ( cluster_to_tlb_axi_bus ),
     .mst                     ( tlb_to_soc_axi_bus     ),
     .cfg                     ( c2h_tlb_cfg            )
   );

  `REG_BUS_ASSIGN_TO_REQ(reg_req,i_padframecfg_rbus)
  `REG_BUS_ASSIGN_FROM_RSP(i_padframecfg_rbus,reg_rsp)

  `ifdef EXCLUDE_PADFRAME
   assign reg_rsp.ready = 1'b1;
   assign reg_rsp.rdata = 32'hdeaddead;
   assign reg_rsp.error = 1'b0;
   assign s_cva6_uart_rx = fpga_pad_uart_rx_i;
   assign fpga_pad_uart_tx_o = s_cva6_uart_tx;
   `ifdef ETH2FMC_NO_PADFRAME
   assign s_pad_to_eth.eth_md_i    = eth_mdio;
   assign s_pad_to_eth.eth_rxck_i  = eth_rxck;
   assign s_pad_to_eth.eth_rxctl_i = eth_rxctl;
   assign s_pad_to_eth.eth_rxd0_i  = eth_rxd[0];
   assign s_pad_to_eth.eth_rxd1_i  = eth_rxd[1];
   assign s_pad_to_eth.eth_rxd2_i  = eth_rxd[2];
   assign s_pad_to_eth.eth_rxd3_i  = eth_rxd[3];
   assign eth_mdio   = s_eth_to_pad.eth_md_o;
   assign eth_mdc    = s_eth_to_pad.eth_mdc_o;
   assign eth_rstn   = s_eth_to_pad.eth_rstn_o;
   assign eth_txck   = s_eth_to_pad.eth_txck_o;
   assign eth_txctl  = s_eth_to_pad.eth_txctl_o;
   assign eth_txd[0] = s_eth_to_pad.eth_txd0_o;
   assign eth_txd[1] = s_eth_to_pad.eth_txd1_o;
   assign eth_txd[2] = s_eth_to_pad.eth_txd2_o;
   assign eth_txd[3] = s_eth_to_pad.eth_txd3_o;
   `endif
  `else

   `ifdef SIMPLE_PADFRAME
      alsaqr_periph_fpga_padframe #(
              .AW     ( 32        ),
              .DW     ( 32        ),
              .req_t  ( reg_req_t ),
              .resp_t ( reg_rsp_t )
              )
     i_alsaqr_periph_fpga_padframe
       (
        .clk_i          ( s_soc_clk   ),
        .rst_ni         ( s_soc_rst_n ),

        .port_signals_pad2soc(s_port_signals_pad2soc),
        .port_signals_soc2pad(s_port_signals_soc2pad),

        .pad_periphs_pad_gpio_b_00_pad(pad_periphs_a_00_pad),
        .pad_periphs_pad_gpio_b_01_pad(pad_periphs_a_01_pad),
        .pad_periphs_pad_gpio_b_02_pad(pad_periphs_a_02_pad),
        .pad_periphs_pad_gpio_b_03_pad(pad_periphs_a_03_pad),
        .pad_periphs_pad_gpio_b_04_pad(pad_periphs_a_04_pad),
        .pad_periphs_pad_gpio_b_05_pad(pad_periphs_a_05_pad),
        .pad_periphs_pad_gpio_b_06_pad(pad_periphs_a_06_pad),
        .pad_periphs_pad_gpio_b_07_pad(pad_periphs_a_07_pad),
        .pad_periphs_pad_gpio_b_08_pad(pad_periphs_a_08_pad),
        .pad_periphs_pad_gpio_b_09_pad(pad_periphs_a_09_pad),
        .pad_periphs_pad_gpio_b_10_pad(pad_periphs_a_10_pad),
        .pad_periphs_pad_gpio_b_11_pad(pad_periphs_a_11_pad),
        .pad_periphs_pad_gpio_b_12_pad(pad_periphs_a_12_pad),
        .pad_periphs_pad_gpio_b_13_pad(pad_periphs_a_13_pad),
        .pad_periphs_pad_gpio_b_14_pad(pad_periphs_a_14_pad),
        .pad_periphs_cva6_uart_00_pad(pad_periphs_a_15_pad),
        .pad_periphs_cva6_uart_01_pad(pad_periphs_a_16_pad),

        .config_req_i   ( reg_req     ),
        .config_rsp_o   ( reg_rsp     )
        );

     // SPI0
     `ASSIGN_PERIPHS_SPI0_PAD2SOC(s_pad_to_spi[0],s_port_signals_pad2soc.periphs.spi0)
     `ASSIGN_PERIPHS_SPI0_SOC2PAD(s_port_signals_soc2pad.periphs.spi0,s_spi_to_pad[0])
     // SDIO0
     `ASSIGN_PERIPHS_SDIO0_PAD2SOC(s_pad_to_sdio[0],s_port_signals_pad2soc.periphs.sdio0)
     `ASSIGN_PERIPHS_SDIO0_SOC2PAD(s_port_signals_soc2pad.periphs.sdio0,s_sdio_to_pad[0])
     // UART0
     `ASSIGN_PERIPHS_UART0_PAD2SOC(s_pad_to_uart[0],s_port_signals_pad2soc.periphs.uart0)
     `ASSIGN_PERIPHS_UART0_SOC2PAD(s_port_signals_soc2pad.periphs.uart0,s_uart_to_pad[0])
     // I2C0
     `ASSIGN_PERIPHS_I2C0_PAD2SOC(s_pad_to_i2c[0],s_port_signals_pad2soc.periphs.i2c0)
     `ASSIGN_PERIPHS_I2C0_SOC2PAD(s_port_signals_soc2pad.periphs.i2c0,s_i2c_to_pad[0])
     // Debug Core UART
     `ASSIGN_PERIPHS_UART_CORE_PAD2SOC(s_cva6_uart_rx,s_port_signals_pad2soc.periphs.uart_core)
     `ASSIGN_PERIPHS_UART_CORE_SOC2PAD(s_port_signals_soc2pad.periphs.uart_core,s_cva6_uart_tx)
     // OT SPI
     `ASSIGN_PERIPHS_SPI_OT_PAD2SOC(s_pad_to_ot_spi,s_port_signals_pad2soc.periphs.spi_ot)
     `ASSIGN_PERIPHS_SPI_OT_SOC2PAD(s_port_signals_soc2pad.periphs.spi_ot,s_ot_spi_to_pad)
     // GPIOs
     `ASSIGN_PERIPHS_GPIO_B_PAD2SOC(s_pad_to_gpio_b,s_port_signals_pad2soc.periphs.gpio_b)
     `ASSIGN_PERIPHS_GPIO_B_SOC2PAD(s_port_signals_soc2pad.periphs.gpio_b,s_gpio_b_to_pad)
     // PWMs
     `ASSIGN_PERIPHS_PWM0_SOC2PAD(s_port_signals_soc2pad.periphs.pwm0,s_pwm_nano_to_pad[0])
     `ASSIGN_PERIPHS_PWM1_SOC2PAD(s_port_signals_soc2pad.periphs.pwm1,s_pwm_nano_to_pad[1])
     //ETHERNET
     `ASSIGN_PERIPHS_ETH_PAD2SOC(s_pad_to_eth,s_port_signals_pad2soc.periphs.eth)
     `ASSIGN_PERIPHS_ETH_SOC2PAD(s_port_signals_soc2pad.periphs.eth,s_eth_to_pad)
   `else // !`ifdef SIMPLE_PADFRAME
    `ifndef FPGA_EMUL

       alsaqr_periph_padframe #(
                .AW     ( 32        ),
                .DW     ( 32        ),
                .req_t  ( reg_req_t ),
                .resp_t ( reg_rsp_t )
                )
       i_alsaqr_periph_padframe
         (
          .clk_i          ( s_soc_clk   ),
          .rst_ni         ( s_soc_rst_n ),

          .port_signals_pad2soc(s_port_signals_pad2soc),
          .port_signals_soc2pad(s_port_signals_soc2pad),

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

          .config_req_i   ( reg_req     ),
          .config_rsp_o   ( reg_rsp     )
          );
          // SPIs
          `ASSIGN_PERIPHS_SPI0_PAD2SOC(s_pad_to_spi[0],s_port_signals_pad2soc.periphs.spi0)
          `ASSIGN_PERIPHS_SPI0_SOC2PAD(s_port_signals_soc2pad.periphs.spi0,s_spi_to_pad[0])

          `ASSIGN_PERIPHS_SPI1_PAD2SOC(s_pad_to_spi[1],s_port_signals_pad2soc.periphs.spi1)
          `ASSIGN_PERIPHS_SPI1_SOC2PAD(s_port_signals_soc2pad.periphs.spi1,s_spi_to_pad[1])

          `ASSIGN_PERIPHS_SPI2_PAD2SOC(s_pad_to_spi[2],s_port_signals_pad2soc.periphs.spi2)
          `ASSIGN_PERIPHS_SPI2_SOC2PAD(s_port_signals_soc2pad.periphs.spi2,s_spi_to_pad[2])

          `ASSIGN_PERIPHS_SPI3_PAD2SOC(s_pad_to_spi[3],s_port_signals_pad2soc.periphs.spi3)
          `ASSIGN_PERIPHS_SPI3_SOC2PAD(s_port_signals_soc2pad.periphs.spi3,s_spi_to_pad[3])

          `ASSIGN_PERIPHS_SPI4_PAD2SOC(s_pad_to_spi[4],s_port_signals_pad2soc.periphs.spi4)
          `ASSIGN_PERIPHS_SPI4_SOC2PAD(s_port_signals_soc2pad.periphs.spi4,s_spi_to_pad[4])

          `ASSIGN_PERIPHS_SPI5_PAD2SOC(s_pad_to_spi[5],s_port_signals_pad2soc.periphs.spi5)
          `ASSIGN_PERIPHS_SPI5_SOC2PAD(s_port_signals_soc2pad.periphs.spi5,s_spi_to_pad[5])

          `ASSIGN_PERIPHS_SPI6_PAD2SOC(s_pad_to_spi[6],s_port_signals_pad2soc.periphs.spi6)
          `ASSIGN_PERIPHS_SPI6_SOC2PAD(s_port_signals_soc2pad.periphs.spi6,s_spi_to_pad[6])

          `ASSIGN_PERIPHS_SPI7_PAD2SOC(s_pad_to_spi[7],s_port_signals_pad2soc.periphs.spi7)
          `ASSIGN_PERIPHS_SPI7_SOC2PAD(s_port_signals_soc2pad.periphs.spi7,s_spi_to_pad[7])

          `ASSIGN_PERIPHS_SPI8_PAD2SOC(s_pad_to_spi[8],s_port_signals_pad2soc.periphs.spi8)
          `ASSIGN_PERIPHS_SPI8_SOC2PAD(s_port_signals_soc2pad.periphs.spi8,s_spi_to_pad[8])

          `ASSIGN_PERIPHS_SPI9_PAD2SOC(s_pad_to_spi[9],s_port_signals_pad2soc.periphs.spi9)
          `ASSIGN_PERIPHS_SPI9_SOC2PAD(s_port_signals_soc2pad.periphs.spi9,s_spi_to_pad[9])

          `ASSIGN_PERIPHS_SPI10_PAD2SOC(s_pad_to_spi[10],s_port_signals_pad2soc.periphs.spi10)
          `ASSIGN_PERIPHS_SPI10_SOC2PAD(s_port_signals_soc2pad.periphs.spi10,s_spi_to_pad[10])

          // LINUX QSPI
          `ASSIGN_PERIPHS_QSPI_LINUX_PAD2SOC(s_pad_to_qspi[0],s_port_signals_pad2soc.periphs.qspi_linux)
          `ASSIGN_PERIPHS_QSPI_LINUX_SOC2PAD(s_port_signals_soc2pad.periphs.qspi_linux,s_qspi_to_pad[0])

          // OT SPI
          `ASSIGN_PERIPHS_SPI_OT_PAD2SOC(s_pad_to_ot_spi,s_port_signals_pad2soc.periphs.spi_ot)
          `ASSIGN_PERIPHS_SPI_OT_SOC2PAD(s_port_signals_soc2pad.periphs.spi_ot,s_ot_spi_to_pad)

          // I2Cs
          `ASSIGN_PERIPHS_I2C0_PAD2SOC(s_pad_to_i2c[0],s_port_signals_pad2soc.periphs.i2c0)
          `ASSIGN_PERIPHS_I2C0_SOC2PAD(s_port_signals_soc2pad.periphs.i2c0,s_i2c_to_pad[0])

          `ASSIGN_PERIPHS_I2C1_PAD2SOC(s_pad_to_i2c[1],s_port_signals_pad2soc.periphs.i2c1)
          `ASSIGN_PERIPHS_I2C1_SOC2PAD(s_port_signals_soc2pad.periphs.i2c1,s_i2c_to_pad[1])

          `ASSIGN_PERIPHS_I2C2_PAD2SOC(s_pad_to_i2c[2],s_port_signals_pad2soc.periphs.i2c2)
          `ASSIGN_PERIPHS_I2C2_SOC2PAD(s_port_signals_soc2pad.periphs.i2c2,s_i2c_to_pad[2])

          `ASSIGN_PERIPHS_I2C3_PAD2SOC(s_pad_to_i2c[3],s_port_signals_pad2soc.periphs.i2c3)
          `ASSIGN_PERIPHS_I2C3_SOC2PAD(s_port_signals_soc2pad.periphs.i2c3,s_i2c_to_pad[3])

          `ASSIGN_PERIPHS_I2C4_PAD2SOC(s_pad_to_i2c[4],s_port_signals_pad2soc.periphs.i2c4)
          `ASSIGN_PERIPHS_I2C4_SOC2PAD(s_port_signals_soc2pad.periphs.i2c4,s_i2c_to_pad[4])

          `ASSIGN_PERIPHS_I2C5_PAD2SOC(s_pad_to_i2c[5],s_port_signals_pad2soc.periphs.i2c5)
          `ASSIGN_PERIPHS_I2C5_SOC2PAD(s_port_signals_soc2pad.periphs.i2c5,s_i2c_to_pad[5])

          // Debug Core UART
          `ASSIGN_PERIPHS_UART_CORE_PAD2SOC(s_cva6_uart_rx,s_port_signals_pad2soc.periphs.uart_core)
          `ASSIGN_PERIPHS_UART_CORE_SOC2PAD(s_port_signals_soc2pad.periphs.uart_core,s_cva6_uart_tx)

          // UARTs
          `ASSIGN_PERIPHS_UART0_PAD2SOC(s_pad_to_uart[0],s_port_signals_pad2soc.periphs.uart0)
          `ASSIGN_PERIPHS_UART0_SOC2PAD(s_port_signals_soc2pad.periphs.uart0,s_uart_to_pad[0])

          `ASSIGN_PERIPHS_UART1_PAD2SOC(s_pad_to_uart[1],s_port_signals_pad2soc.periphs.uart1)
          `ASSIGN_PERIPHS_UART1_SOC2PAD(s_port_signals_soc2pad.periphs.uart1,s_uart_to_pad[1])

          `ASSIGN_PERIPHS_UART2_PAD2SOC(s_pad_to_uart[2],s_port_signals_pad2soc.periphs.uart2)
          `ASSIGN_PERIPHS_UART2_SOC2PAD(s_port_signals_soc2pad.periphs.uart2,s_uart_to_pad[2])

          // USARTs
          `ASSIGN_PERIPHS_USART0_PAD2SOC(s_pad_to_usart[0],s_port_signals_pad2soc.periphs.usart0)
          `ASSIGN_PERIPHS_USART0_SOC2PAD(s_port_signals_soc2pad.periphs.usart0,s_usart_to_pad[0])

          `ASSIGN_PERIPHS_USART1_PAD2SOC(s_pad_to_usart[1],s_port_signals_pad2soc.periphs.usart1)
          `ASSIGN_PERIPHS_USART1_SOC2PAD(s_port_signals_soc2pad.periphs.usart1,s_usart_to_pad[1])

          `ASSIGN_PERIPHS_USART2_PAD2SOC(s_pad_to_usart[2],s_port_signals_pad2soc.periphs.usart2)
          `ASSIGN_PERIPHS_USART2_SOC2PAD(s_port_signals_soc2pad.periphs.usart2,s_usart_to_pad[2])

          `ASSIGN_PERIPHS_USART3_PAD2SOC(s_pad_to_usart[3],s_port_signals_pad2soc.periphs.usart3)
          `ASSIGN_PERIPHS_USART3_SOC2PAD(s_port_signals_soc2pad.periphs.usart3,s_usart_to_pad[3])

          // GPIOs
          `ASSIGN_PERIPHS_GPIO_B_PAD2SOC(s_pad_to_gpio_b,s_port_signals_pad2soc.periphs.gpio_b)
          `ASSIGN_PERIPHS_GPIO_B_SOC2PAD(s_port_signals_soc2pad.periphs.gpio_b,s_gpio_b_to_pad)

          // PWMs
          `ASSIGN_PERIPHS_PWM0_SOC2PAD(s_port_signals_soc2pad.periphs.pwm0,s_pwm_nano_to_pad[0])
          `ASSIGN_PERIPHS_PWM1_SOC2PAD(s_port_signals_soc2pad.periphs.pwm1,s_pwm_nano_to_pad[1])

          // CANs
          `ASSIGN_PERIPHS_CAN0_PAD2SOC(s_pad_to_can[0],s_port_signals_pad2soc.periphs.can0)
          `ASSIGN_PERIPHS_CAN0_SOC2PAD(s_port_signals_soc2pad.periphs.can0,s_can_to_pad[0])

          `ASSIGN_PERIPHS_CAN0_PAD2SOC(s_pad_to_can[1],s_port_signals_pad2soc.periphs.can1)
          `ASSIGN_PERIPHS_CAN0_SOC2PAD(s_port_signals_soc2pad.periphs.can1,s_can_to_pad[1])

          // CAMs
          `ASSIGN_PERIPHS_CAM0_PAD2SOC(s_pad_to_cam[0],s_port_signals_pad2soc.periphs.cam0)

          `ASSIGN_PERIPHS_CAM1_PAD2SOC(s_pad_to_cam[1],s_port_signals_pad2soc.periphs.cam1)

          // SDIOs
          `ASSIGN_PERIPHS_SDIO0_PAD2SOC(s_pad_to_sdio[0],s_port_signals_pad2soc.periphs.sdio0)
          `ASSIGN_PERIPHS_SDIO0_SOC2PAD(s_port_signals_soc2pad.periphs.sdio0,s_sdio_to_pad[0])

          `ASSIGN_PERIPHS_SDIO1_PAD2SOC(s_pad_to_sdio[1],s_port_signals_pad2soc.periphs.sdio1)
          `ASSIGN_PERIPHS_SDIO1_SOC2PAD(s_port_signals_soc2pad.periphs.sdio1,s_sdio_to_pad[1])

          //ETHERNET
          `ASSIGN_PERIPHS_ETH_PAD2SOC(s_pad_to_eth,s_port_signals_pad2soc.periphs.eth)
          `ASSIGN_PERIPHS_ETH_SOC2PAD(s_port_signals_soc2pad.periphs.eth,s_eth_to_pad)

          //FLL OUT
          `ASSIGN_PERIPHS_FLL_SOC_SOC2PAD(s_port_signals_soc2pad.periphs.fll_soc,s_fll_to_pad)
          `ASSIGN_PERIPHS_FLL_CVA6_SOC2PAD(s_port_signals_soc2pad.periphs.fll_cva6,s_fll_to_pad)

    `else // !`ifndef FPGA_EMUL
           assign reg_rsp.ready = 1'b1;
           assign reg_rsp.rdata = 32'hdeaddead;
           assign reg_rsp.error = 1'b0;
           assign s_cva6_uart_rx = fpga_pad_uart_rx_i;
           assign fpga_pad_uart_tx_o = s_cva6_uart_tx;
    `endif // !`ifndef FPGA_EMUL
   `endif // !`ifdef SIMPLE_PADFRAME
  `endif // !`ifdef EXCLUDE_PADFRAME

endmodule

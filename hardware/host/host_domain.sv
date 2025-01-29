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
// Date: 19.03.2017
// Description: Test-harness for Ariane
//              Instantiates an AXI-Bus and memories

`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"
`include "axi/assign.svh"
`include "axi/typedef.svh"
`include "common_cells/registers.svh"
`define APMU_IOPMP
`define APMU_IP

module host_domain
  import axi_pkg::xbar_cfg_t;
  import ariane_soc::HyperbusNumPhys;
  import ariane_soc::NumChipsPerHyperbus;
  import apb_soc_pkg::NUM_ADV_TIMER;
  import ariane_soc::*;
  import udma_subsystem_pkg::*;
  import gpio_pkg::*;
  `ifndef FPGA_EMUL
    `ifndef SIMPLE_PADFRAME
        import pkg_alsaqr_periph_padframe::*;
      `else
        import pkg_alsaqr_periph_fpga_padframe::*;
      `endif
  `else
      import pkg_alsaqr_periph_fpga_padframe::*;
  `endif
  import axi_llc_pkg::events_t;
#(
  parameter int unsigned AXI_USER_WIDTH    = 1,
  parameter int unsigned AXI_ADDRESS_WIDTH = 64,
  parameter int unsigned AXI_DATA_WIDTH    = 64,
  // AXILITE parameters
  parameter int unsigned AXI_LITE_AW       = 32,
  parameter int unsigned AXI_LITE_DW       = 32,
`ifdef DROMAJO
  parameter bit          InclSimDTM        = 1'b0,
`else
  parameter bit          InclSimDTM        = 1'b1,
`endif
  parameter int unsigned NUM_WORDS         = 2**25,         // memory size
  parameter bit          StallRandomOutput = 1'b0,
  parameter bit          StallRandomInput  = 1'b0,
  parameter bit          JtagEnable        = 1'b1,
  parameter int unsigned CAM_DATA_WIDTH    = 8,
  parameter int unsigned NUM_GPIO          = 64,
  parameter type         axi_req_t         = logic,
  parameter type         axi_rsp_t         = logic
) (
  input logic                 rtc_i,
  input logic                 rst_ni,
  input logic                 bypass_clk_i,
  output logic                soc_clk_o,
  output logic                soc_rst_no,
  output logic                clk_cluster_o,
  output logic                clk_opentitan_o,
  output logic                rstn_cluster_sync_o,
  output logic                cluster_en_sa_boot_o,
  output logic                cluster_fetch_en_o,
  output logic                dma_pe_evt_ack_o,
  input  logic                dma_pe_evt_valid_i,
  input  logic                cluster_eoc_i,
  output logic                h2c_irq_o,
  REG_BUS.out                 padframecfg_reg_master,
  // CVA6 DEBUG UART
  input logic                 cva6_uart_rx_i,
  output logic                cva6_uart_tx_o,

  // JTAG
  input logic                 jtag_TCK,
  input logic                 jtag_TMS,
  input logic                 jtag_TDI,
  input logic                 jtag_TRSTn,
  output logic                jtag_TDO_data,
  output logic                jtag_TDO_driven,

  `ifdef XILINX_DDR
  AXI_BUS.Master              axi_ddr_master,
  `endif
  // SoC to cluster AXI
  AXI_BUS.Master              cluster_axi_master,
  AXI_BUS.Slave               cluster_axi_slave,
  AXI_BUS.Slave               cluster_lite_slave,
  // TLB Config
  AXI_LITE.Master             c2h_tlb_cfg_lite_master,
  // SPIM
  output                      qspi_to_pad_t [N_SPI-1:0] spi_to_pad,
  input                       pad_to_qspi_t [N_SPI-1:0] pad_to_spi,

  // QSPIM
  output                      qspi_to_pad_t [N_QSPI-1:0] qspi_to_pad,
  input                       pad_to_qspi_t [N_QSPI-1:0] pad_to_qspi,

  // I2C
  output                      i2c_to_pad_t [N_I2C-1:0] i2c_to_pad,
  input                       pad_to_i2c_t [N_I2C-1:0] pad_to_i2c,

  // CAM
  input                       pad_to_cam_t [N_CAM-1:0] pad_to_cam,

  // UART
  input                       pad_to_uart_t [N_UART-1:0] pad_to_uart,
  output                      uart_to_pad_t [N_UART-1:0] uart_to_pad,

  // USART
  input                       pad_to_usart_t [N_USART-1:0] pad_to_usart,
  output                      usart_to_pad_t [N_USART-1:0] usart_to_pad,

  // SDIO
  output                      sdio_to_pad_t [N_SDIO-1:0] sdio_to_pad,
  input                       pad_to_sdio_t [N_SDIO-1:0] pad_to_sdio,

  //CAN
  output                      can_to_pad_t [N_CAN-1 : 0] can_to_pad,
  input                       pad_to_can_t [N_CAN-1 : 0] pad_to_can,

  //ETHERNET
  output                      eth_to_pad_t eth_to_pad,
  input                       pad_to_eth_t pad_to_eth,

  `ifdef ETH2FMC_NO_PADFRAME
  input logic                   clk_200MHz,
  input logic                   clk_125MHz,
  input logic                   clk_125MHz90,
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

  output                      pwm_to_pad_t pwm_to_pad,

  // FLL output
  output                      fll_to_pad_t    fll_to_pad,

  output gpio_to_pad_t        gpio_to_pad,
  input  pad_to_gpio_t        pad_to_gpio,

  // OpenTitan axi master
  input  axi_req_t            ot_axi_req,
  output axi_rsp_t            ot_axi_rsp,

  // SCMI mailbox interrupt to Ibex
  output  logic               doorbell_irq_o,
  output  logic               cfi_req_irq_o,
    // Logic locking registers
  output logic [127:0]        cluster_lock_xor_key_o
);


   ariane_axi_soc::req_slv_t  axi_cpu_req;
   ariane_axi_soc::resp_slv_t axi_cpu_res;

   ariane_axi_soc::req_slv_mem_t  axi_mem_req;
   ariane_axi_soc::resp_slv_mem_t axi_mem_res;

   ariane_axi_soc::req_lite_t  axi_llc_cfg_req;
   ariane_axi_soc::resp_lite_t axi_llc_cfg_res;

   ariane_axi_soc::req_lite_t  axi_lite_snooper_req;
   ariane_axi_soc::resp_lite_t axi_lite_snooper_rsp;

   // rule definitions
   typedef struct packed {
     int unsigned             idx;
     ariane_axi_soc::addr_t   start_addr;
     ariane_axi_soc::addr_t   end_addr;
   } rule_full_t;

   // When changing these parameters, change the L2 size accordingly in ariane_soc_pkg
   localparam NB_L2_BANKS = 8;
   localparam L2_BANK_SIZE = 1024; // 2^10 words (32 bits)

   localparam L2_BANK_ADDR_WIDTH = $clog2(L2_BANK_SIZE);
   localparam L2_MEM_ADDR_WIDTH = $clog2(L2_BANK_SIZE * NB_L2_BANKS) - $clog2(NB_L2_BANKS);
   localparam L2_DATA_WIDTH = 32 ; // Do not change

   localparam AXI64_2_TCDM32_N_PORTS = 4; // Do not change, to achieve full bandwith from 64 bit AXI and 32 bit tcdm we need 4 ports!
                                          // It is hardcoded in the axi2tcdm_wrap module.

   localparam NB_UDMA_TCDM_CHANNEL = 2;

   localparam AXI_LITE_DATA_WIDTH = 32;

   `ifdef APMU_IP
    localparam int unsigned APMU_NUM_COUNTER = 8;
  `else
    localparam int unsigned APMU_NUM_COUNTER = 0;
  `endif

   // parameters for the LLC
   localparam NUM_WAYS   = 32'd8;
   localparam NUM_LINES  = 32'd256;
   localparam NUM_BLOCKS = 32'd8;

   logic                                 s_clk_cva6;
   logic                                 s_rstn_cva6_sync;
   logic                                 s_soc_clk;
   logic                                 s_synch_soc_rst;
   logic                                 s_synch_global_rst;
   logic                                 s_rstn_cluster_sync;
   logic                                 s_dm_rst;
   logic                                 ndmreset_n;
   logic [31*4-1:0]                      s_udma_events;
   logic                                 s_dma_pe_evt;
   logic [N_CAN-1:0]                     s_can_irq;
   logic [NUM_ADV_TIMER-1 : 0]           s_pwm_irq;
   logic                                 s_c2h_irq;
   logic [NUM_GPIO-1:0]                  s_gpio_irq;

   logic                                 s_llc_read_hit_cache;
   logic                                 s_llc_read_miss_cache;
   logic                                 s_llc_write_hit_cache;
   logic                                 s_llc_write_miss_cache;

   logic[31:0]                           s_llc_cache_addr_start;
   logic[31:0]                           s_llc_cache_addr_end;
   logic[31:0]                           s_llc_spm_addr_start;

   logic                                 s_eth_clk_200MHz_i;
   logic                                 s_eth_clk_i;
   logic                                 s_eth_phy_tx_clk_i;

   logic                                 iopmp_irq;

   axi_llc_pkg::events_t llc_events;

   logic completion_irq_o;

   logic [127:0] iommu_lock_xor_key;
   logic [127:0] iopmp_lock_xor_key;
   logic [127:0] aia_lock_xor_key;

   assign   soc_clk_o  = s_soc_clk;
   assign   soc_rst_no = s_synch_soc_rst;
   assign   rstn_cluster_sync_o = s_rstn_cluster_sync;

  `ifdef ETH2FMC_NO_PADFRAME
     assign   s_eth_clk_200MHz_i = clk_200MHz;
     assign   s_eth_phy_tx_clk_i = clk_125MHz;
     assign   s_eth_clk_i        = clk_125MHz90;
  `else
     assign   s_eth_clk_200MHz_i = s_soc_clk ;
     clk_gen_hyper i_clk_gen_ethernet (
          .clk_i    ( s_periph_clk                ),
          .rst_ni   ( s_synch_soc_rst             ),
          .clk0_o   ( s_eth_phy_tx_clk_i          ),
          .clk90_o  ( s_eth_clk_i                 ),
          .clk180_o (                             ),
          .clk270_o (                             )
      );
  `endif

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) l2_axi_bus();

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) apb_axi_bus();

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) hyper_axi_bus();

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) host_lite_bus ();

   //uDMA -> XBAR
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) udma_rx_l3_axi_bus();

   //uDMA -> XBAR
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) udma_tx_l3_axi_bus();

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH          ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH             ),
     `ifdef EXCLUDE_LLC
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave   ),
     `else
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave+1 ),
     `endif
     .AXI_USER_WIDTH ( AXI_USER_WIDTH             )
   ) mem_axi_bus ();

   AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH          ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH             ),
    `ifdef EXCLUDE_LLC
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave   ),
    `else
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave+1 ),
    `endif
    .AXI_USER_WIDTH ( AXI_USER_WIDTH             )
   ) mem_axi_bus_spu_o_bus();

   AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_LITE_AW),
    .AXI_DATA_WIDTH (AXI_LITE_DW)
   ) llc_cfg_bus();

   AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_LITE_AW),
    .AXI_DATA_WIDTH (AXI_LITE_DW)
   ) axi_lite_pmu_32();

   AXI_LITE #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH    )
   ) axi_lite_pmu_64();

  // APMU - Debug Request
   ariane_axi_soc::req_lite_t  pmu_master_req;
   ariane_axi_soc::resp_lite_t pmu_master_res;

   // APMU Configuration Signals
   ariane_axi_soc::req_lite_t  axi_lite_pmu_cfg_req;
   ariane_axi_soc::resp_lite_t axi_lite_pmu_cfg_res;

   logic  [APMU_NUM_COUNTER-1:0] pmu_intr_o;
   pmu_pkg::pmu_event_t [ariane_soc::NumCVA6:0] spu_o;


   XBAR_TCDM_BUS axi_bridge_2_interconnect[AXI64_2_TCDM32_N_PORTS]();
   XBAR_TCDM_BUS udma_2_tcdm_channels[NB_UDMA_TCDM_CHANNEL]();


  `ifdef XILINX_DDR
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH           ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH              ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave +1 ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH              )
   ) dummyaxibus();
   assign dummyaxibus.aw_valid  = 1'b0;
   assign dummyaxibus.ar_valid  = 1'b0;
   assign dummyaxibus.w_valid   = 1'b0;


   `AXI_ASSIGN(axi_ddr_master,mem_axi_bus)
  `endif

  `ifdef EXCLUDE_LLC
   `AXI_ASSIGN(mem_axi_bus,hyper_axi_bus)

   logic r_valid_d, r_valid_q;
   logic b_valid_d, b_valid_q;

   assign llc_cfg_bus.aw_ready = 1'b1;
   assign llc_cfg_bus.w_ready  = 1'b1;
   assign llc_cfg_bus.b_valid  = b_valid_q;
   assign llc_cfg_bus.b_resp   = 2'b0;
   assign llc_cfg_bus.ar_ready = 1'b1;
   assign llc_cfg_bus.r_data   = 32'hdeadf000;
   assign llc_cfg_bus.r_valid  = r_valid_q;

   assign s_llc_read_hit_cache   = 1'b0;
   assign s_llc_read_miss_cache  = 1'b0;
   assign s_llc_write_hit_cache  = 1'b0;
   assign s_llc_write_miss_cache = 1'b0;

   always_comb begin
      r_valid_d = r_valid_q;
      if(!r_valid_q && llc_cfg_bus.ar_valid)
        r_valid_d = 1'b1;
      else if(r_valid_q && llc_cfg_bus.r_ready)
        r_valid_d = 1'b0;
   end
   `FFARN(r_valid_q, r_valid_d, '0, s_soc_clk, s_synch_soc_rst)

   always_comb begin
      b_valid_d = b_valid_q;
      if(!b_valid_q && llc_cfg_bus.w_valid)
        b_valid_d = 1'b1;
      else if(b_valid_q && llc_cfg_bus.b_ready)
        b_valid_d = 1'b0;
   end
   `FFARN(b_valid_q, b_valid_d, '0, s_soc_clk, s_synch_soc_rst)

  `else

   `AXI_ASSIGN_TO_REQ(axi_cpu_req,hyper_axi_bus)
   `AXI_ASSIGN_FROM_RESP(hyper_axi_bus,axi_cpu_res)
   `ifdef APMU_IP
    // Converts request packets to AXI Bus signals.
    `AXI_ASSIGN_FROM_REQ( mem_axi_bus_spu_o_bus, axi_mem_req )
    `AXI_ASSIGN_TO_RESP( axi_mem_res, mem_axi_bus_spu_o_bus )
  `else
    // Converts request packets to AXI Bus signals.
    `AXI_ASSIGN_FROM_REQ( mem_axi_bus, axi_mem_req )
    `AXI_ASSIGN_TO_RESP( axi_mem_res, mem_axi_bus )
  `endif
   `AXI_LITE_ASSIGN_TO_REQ(axi_llc_cfg_req,llc_cfg_bus)
   `AXI_LITE_ASSIGN_FROM_RESP(llc_cfg_bus,axi_llc_cfg_res)

    axi_llc_top #(
      .SetAssociativity ( ariane_soc::LLC_SET_ASSOC      ),
      .NumLines         ( ariane_soc::LLC_NUM_LINES      ),
      .NumBlocks        ( ariane_soc::LLC_NUM_BLOCKS     ),
      .AxiIdWidth       ( ariane_soc::IdWidthSlave       ),
      .AxiAddrWidth     ( AXI_ADDRESS_WIDTH              ),
      .AxiDataWidth     ( AXI_DATA_WIDTH                 ),
      .AxiUserWidth     ( AXI_USER_WIDTH                 ),
      .AxiLiteAddrWidth ( AXI_LITE_AW                    ),
      .AxiLiteDataWidth ( AXI_LITE_DW                    ),
      .slv_req_t        ( ariane_axi_soc::req_slv_t      ),
      .slv_resp_t       ( ariane_axi_soc::resp_slv_t     ),
      .mst_req_t        ( ariane_axi_soc::req_slv_mem_t  ),
      .mst_resp_t       ( ariane_axi_soc::resp_slv_mem_t ),
      .lite_req_t       ( ariane_axi_soc::req_lite_t     ),
      .lite_resp_t      ( ariane_axi_soc::resp_lite_t    ),
      .rule_full_t      ( rule_full_t                    )
    ) i_axi_llc (
      .clk_i               ( s_soc_clk                                                                           ),
      .rst_ni              ( s_synch_soc_rst                                                                     ),
      .test_i              ( 1'b0                                                                                ),
      .slv_req_i           ( axi_cpu_req                                                                         ),
      .slv_resp_o          ( axi_cpu_res                                                                         ),
      .mst_req_o           ( axi_mem_req                                                                         ),
      .mst_resp_i          ( axi_mem_res                                                                         ),
      .conf_req_i          ( axi_llc_cfg_req                                                                     ),
      .conf_resp_o         ( axi_llc_cfg_res                                                                     ),
      .cached_start_addr_i ( {{(AXI_ADDRESS_WIDTH-$bits(s_llc_cache_addr_start)){1'b0}}, s_llc_cache_addr_start} ),
      .cached_end_addr_i   ( {{(AXI_ADDRESS_WIDTH-$bits(s_llc_cache_addr_end)){1'b0}}  , s_llc_cache_addr_end  } ),
      .spm_start_addr_i    ( {{(AXI_ADDRESS_WIDTH-$bits(s_llc_spm_addr_start)){1'b0}}  , s_llc_spm_addr_start  } ),
      .axi_llc_events_o    ( llc_events                                                                          )
    );

   assign s_llc_read_hit_cache = llc_events.hit_read_cache.active;
   assign s_llc_read_miss_cache = llc_events.miss_read_cache.active;
   assign s_llc_write_hit_cache = llc_events.hit_write_cache.active;
   assign s_llc_write_miss_cache = llc_events.miss_write_cache.active;

  `endif

   AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_LITE_AW),
    .AXI_DATA_WIDTH (AXI_LITE_DW)
   ) apmu_cfg_lite_bus();

   // AXI Bus: XBAR <=> AXI Cut (IOPMP Configuration Port)
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) iopmp_cp_cut ();

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) iopmp_cfg (); //to cva6_subsytem's inputs

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
   ) iopmp_mst (); //to cva6_subsytem's inputs

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
   ) iopmp_mst_cut (); //to cva6_subsytem's inputs

   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
   ) axi_iopmp_rp ();

   AXI_BUS_EXT #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
   ) axi_iopmp_rp_ext ();

   ariane_axi_soc::req_ext_t axi_iopmp_rp_ext_req;
   ariane_axi_soc::resp_t axi_iopmp_rp_ext_rsp;

   ariane_axi_soc::req_t  axi_iopmp_ip_req;
   ariane_axi_soc::resp_t axi_iopmp_ip_rsp;

   ariane_axi_soc::req_slv_t  axi_iopmp_cp_req;
   ariane_axi_soc::resp_slv_t axi_iopmp_cp_rsp;

  `REG_BUS_TYPEDEF_ALL(iopmp_reg, ariane_axi_soc::addr_t, ariane_axi_soc::data_t, ariane_axi_soc::strb_t)

  `ifdef APMU_IOPMP

  `AXI_ASSIGN_TO_REQ(axi_iopmp_cp_req, iopmp_cp_cut)
  `AXI_ASSIGN_FROM_RESP(iopmp_cp_cut, axi_iopmp_cp_rsp)

  `AXI_ASSIGN_FROM_REQ(iopmp_mst,axi_iopmp_ip_req)
  `AXI_ASSIGN_TO_RESP(axi_iopmp_ip_rsp, iopmp_mst)

  `AXI_LITE_ASSIGN_FROM_REQ(axi_lite_pmu_32,pmu_master_req)
  `AXI_LITE_ASSIGN_TO_RESP(pmu_master_res, axi_lite_pmu_32)

   // Manually assign extended signals

  `AXI_ASSIGN(axi_iopmp_rp_ext,axi_iopmp_rp)

  `AXI_ASSIGN_TO_REQ(axi_iopmp_rp_ext_req, axi_iopmp_rp_ext)
  `AXI_ASSIGN_FROM_RESP(axi_iopmp_rp_ext, axi_iopmp_rp_ext_rsp)

   assign axi_iopmp_rp_ext_req.aw.stream_id    = 24'd1;
   assign axi_iopmp_rp_ext_req.aw.ss_id_valid  = '0;
   assign axi_iopmp_rp_ext_req.aw.substream_id = '0;
   assign axi_iopmp_rp_ext_req.aw.nsaid        = 4'd1;

   assign axi_iopmp_rp_ext_req.ar.stream_id    = 24'd1;
   assign axi_iopmp_rp_ext_req.ar.ss_id_valid  = '0;
   assign axi_iopmp_rp_ext_req.ar.substream_id = '0;
   assign axi_iopmp_rp_ext_req.ar.nsaid        = 4'd1;

  `else // !`ifdef APMU_IOPMP

   `AXI_ASSIGN(iopmp_mst, axi_iopmp_rp)
   `AXI_LITE_ASSIGN_FROM_REQ(axi_lite_pmu_32,pmu_master_req)
   `AXI_LITE_ASSIGN_TO_RESP(pmu_master_res, axi_lite_pmu_32)

  `endif

  `ifdef APMU_IP
   localparam N_ADDR_RULES = 2;
   ariane_soc::addr_map_rule_t [N_ADDR_RULES-1:0]   spu_mem_addr_map;
   assign spu_mem_addr_map[0] = '{
         idx: 0,
         start_addr: ariane_soc::DebugBase,
         end_addr:   ariane_soc::HYAXIBase
   };

   assign spu_mem_addr_map[1] = '{
         idx: 1,
         start_addr: ariane_soc::HYAXIBase,
         end_addr:   ariane_soc::HYAXIBase + ariane_soc::HYAXILength
   };

   axi_spu_top #(
     // Static configuration parameters of the cache.
     .SetAssociativity   ( ariane_soc::LLC_SET_ASSOC   ),
     .NumLines           ( ariane_soc::LLC_NUM_LINES   ),
     .NumBlocks          ( ariane_soc::LLC_NUM_BLOCKS  ),
     // AXI4 Specifications
     .IdWidthMasters     ( ariane_soc::IdWidth         ),
     .IdWidthSlaves      ( ariane_soc::IdWidthSlave    ),
     .AddrWidth          ( AXI_ADDRESS_WIDTH           ),
     .DataWidth          ( AXI_DATA_WIDTH              ),
     // Address Indexing
     .addr_rule_t        ( ariane_soc::addr_map_rule_t ),
     .N_ADDR_RULES       ( N_ADDR_RULES                ),
     // FIFO and CAM Parameters
     .CAM_DEPTH          ( 17                          ),
     .FIFO_DEPTH         (  8                          )
   ) i_spu_llc_mem (
     .clk_i              ( s_soc_clk                   ),
     .rst_ni             ( s_synch_soc_rst             ),
     .addr_map_i         ( spu_mem_addr_map            ),
     .spu_slv            ( mem_axi_bus_spu_o_bus       ),
     .spu_mst            ( mem_axi_bus                 ),
     .e_out              ( spu_o[ariane_soc::NumCVA6]  )
   );

   // AXI Cut for IOPMP Configuration Port
   axi_cut_intf #(
     .ADDR_WIDTH ( AXI_ADDRESS_WIDTH         ),
     .DATA_WIDTH ( AXI_DATA_WIDTH            ),
     .ID_WIDTH   ( ariane_soc::IdWidthSlave  ),
     .USER_WIDTH ( AXI_USER_WIDTH             )
   ) axi_iopmp_cp_cut (
     .clk_i  ( s_soc_clk       ),
     .rst_ni ( s_synch_soc_rst ),
     .in     ( iopmp_cfg       ),
     .out    ( iopmp_cp_cut    )
   );

   // AXI Cut for IOPMP Initiator Port
   axi_cut_intf #(
     .ADDR_WIDTH ( AXI_ADDRESS_WIDTH         ),
     .DATA_WIDTH ( AXI_DATA_WIDTH            ),
     .ID_WIDTH   ( ariane_soc::IdWidth       ),
     .USER_WIDTH ( AXI_USER_WIDTH             )
   ) axi_iopmp_ip_cut (
     .clk_i  ( s_soc_clk       ),
     .rst_ni ( s_synch_soc_rst ),
     .in     ( iopmp_mst       ),
     .out    ( iopmp_mst_cut   )
   );

   riscv_iopmp #(
     // AXI specific parameters
     .ADDR_WIDTH			   ( AXI_ADDRESS_WIDTH        ),
     .DATA_WIDTH			   ( AXI_DATA_WIDTH				    ),
     .ID_WIDTH			     ( ariane_soc::IdWidth	    ),
     .ID_SLV_WIDTH		   ( ariane_soc::IdWidthSlave ),
     .USER_WIDTH			   ( AXI_USER_WIDTH				    ),

     // AXI request/response
     .axi_req_nsaid_t    ( ariane_axi_soc::req_ext_t  ),
     .axi_req_t			     ( ariane_axi_soc::req_t	    ),
     .axi_rsp_t			     ( ariane_axi_soc::resp_t	    ),
     .axi_req_slv_t		   ( ariane_axi_soc::req_slv_t  ),
     .axi_rsp_slv_t		   ( ariane_axi_soc::resp_slv_t ),
     // AXI channel structs
     .axi_aw_chan_t      ( ariane_axi_soc::aw_chan_t  ),
     .axi_w_chan_t       ( ariane_axi_soc::w_chan_t	  ),
     .axi_b_chan_t       ( ariane_axi_soc::b_chan_t	  ),
     .axi_ar_chan_t      ( ariane_axi_soc::ar_chan_t  ),
     .axi_r_chan_t       ( ariane_axi_soc::r_chan_t	  ),

     // Register Interface parameters
     .reg_req_t		       ( iopmp_reg_req_t   ),
     .reg_rsp_t		       ( iopmp_reg_rsp_t   ),

     // Implementation specific
     .NUMBER_MDS         ( 16                ),
     .NUMBER_ENTRIES     ( 32                ),
     .NUMBER_MASTERS     ( 1                 )
   ) i_riscv_iopmp (
     .clk_i				       ( s_soc_clk             ),
     .rst_ni				     ( s_synch_soc_rst			 ),

     // AXI Config Slave port
     .control_req_i      ( axi_iopmp_cp_req      ),
     .control_rsp_o      ( axi_iopmp_cp_rsp      ),

     // AXI Bus Slave port
     .receiver_req_i     ( axi_iopmp_rp_ext_req  ),
     .receiver_rsp_o     ( axi_iopmp_rp_ext_rsp  ),

     // AXI Bus Master port
     .initiator_req_o    ( axi_iopmp_ip_req      ),
     .initiator_rsp_i    ( axi_iopmp_ip_rsp      ),

     .wsi_wire_o         ( iopmp_irq             ),
     .iopmp_lock_xor_key_i ( iopmp_lock_xor_key )
   );

   axi_lite_dw_converter_intf #(
     .AXI_ADDR_WIDTH          ( AXI_ADDRESS_WIDTH        ),
     .AXI_SLV_PORT_DATA_WIDTH ( AXI_LITE_DATA_WIDTH      ),
     .AXI_MST_PORT_DATA_WIDTH ( AXI_DATA_WIDTH           )
   ) axi_dw_conv_snooper (
     .clk_i  ( s_soc_clk        ),
     .rst_ni ( s_synch_soc_rst  ),
     .slv    ( axi_lite_pmu_32  ),
     .mst    ( axi_lite_pmu_64  )
   );

   axi_lite_to_axi_intf #(
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH   )
   ) axi_lite_to_axi_pmu (
     // Slave AXI LITE port
     .in              ( axi_lite_pmu_64 ),
     .slv_aw_cache_i  ( '0              ),
     .slv_ar_cache_i  ( '0              ),
     .out             ( axi_iopmp_rp    )
   );

   // The PMU only works with 32-bit AXI4-Lite port.
   pmu_top #(
     .NUM_PORT         ( 3                              ),
     .NUM_COUNTER      ( APMU_NUM_COUNTER               ),
     .ISPM_NUM_WORDS   ( 128                            ),
     .DSPM_NUM_WORDS   ( 1024                           ),
     // APMU Addresses and SPM configuration
     .MEMORY_BASE_ADDR ( ariane_soc::L2SPMBase          ),
     .MEMORY_LENGTH    ( ariane_soc::L2SPMBase + ariane_soc::L2SPMLength        ),
     .req_lite_t       ( ariane_axi_soc::req_lite_t     ),
     .resp_lite_t      ( ariane_axi_soc::resp_lite_t    ),
     .aw_chan_lite_t   ( ariane_axi_soc::aw_chan_lite_t ),
     .w_chan_lite_t    ( ariane_axi_soc::w_chan_lite_t  ),
     .b_chan_lite_t    ( ariane_axi_soc::b_chan_lite_t  ),
     .ar_chan_lite_t   ( ariane_axi_soc::ar_chan_lite_t ),
     .r_chan_lite_t    ( ariane_axi_soc::r_chan_lite_t  )
   ) i_pmu_top (
     .clk_i            ( s_soc_clk                      ),
     .rst_ni           ( s_synch_soc_rst                ),
     .port_i           ( spu_o                          ),
     .conf_req_i       ( axi_lite_pmu_cfg_req           ),
     .conf_resp_o      ( axi_lite_pmu_cfg_res           ),
     .master_req_o     ( pmu_master_req                 ),
     .master_resp_i    ( pmu_master_res                 ),
     .intr_o           ( pmu_intr_o                     )
   );

  `AXI_LITE_ASSIGN_TO_REQ( axi_lite_pmu_cfg_req, apmu_cfg_lite_bus    )
  `AXI_LITE_ASSIGN_FROM_RESP( apmu_cfg_lite_bus, axi_lite_pmu_cfg_res )
  `endif

   cva6_subsystem # (
        .NUM_WORDS         ( NUM_WORDS      ),
        .AXI_USER_WIDTH    ( AXI_USER_WIDTH ),
        .APMU_NUM_COUNTER  ( APMU_NUM_COUNTER ),
        .InclSimDTM        ( 1'b1           ),
        .StallRandomOutput ( 1'b1           ),
        .StallRandomInput  ( 1'b1           ),
        .JtagEnable        ( JtagEnable     ),
        .axi_req_t         ( axi_req_t      ),
        .axi_rsp_t         ( axi_rsp_t      )
   ) i_cva6_subsystem (
        .clk_i(s_soc_clk),
        .rst_ni(s_synch_global_rst),
        .cva6_clk_i(s_clk_cva6),
        .cva6_rst_ni(s_rstn_cva6_sync),
        .rtc_i,
        .jtag_TCK,
        .jtag_TMS,
        .jtag_TDI,
        .jtag_TRSTn,
        .jtag_TDO_data,
        .jtag_TDO_driven,
        .ot_axi_req,
        .ot_axi_rsp,
        .irq_mbox_i           ( completion_irq_o     ),
        .snoop_trigger_irq_o  ( cfi_req_irq_o        ),
        .sync_rst_ni          ( s_synch_soc_rst      ),
        .udma_events_i        ( s_udma_events        ),
        .cluster_eoc_i        ( cluster_eoc_i        ),
        .c2h_irq_i            ( s_c2h_irq            ),
        .can_irq_i            ( s_can_irq            ),
        .pwm_irq_i            ( s_pwm_irq            ),
        .gpio_irq_i           ( s_gpio_irq           ),
        .cl_dma_pe_evt_i      ( s_dma_pe_evt         ),
        .dm_rst_o             ( s_dm_rst             ),
        .l2_axi_master        ( l2_axi_bus           ),
        .apb_axi_master       ( apb_axi_bus          ),
        .hyper_axi_master     ( hyper_axi_bus        ),
        .pmu_axi_slave        ( iopmp_mst_cut        ),
        .iopmp_axi_master     ( iopmp_cfg            ),

        //Ethernet
        .eth_clk_i            ( s_eth_clk_i          ), // 125 MHz 90
        .eth_phy_tx_clk_i     ( s_eth_phy_tx_clk_i   ), // 125 MHz 0
        .eth_clk_200MHz_i     ( s_eth_clk_200MHz_i   ),
        .eth_to_pad           ( eth_to_pad           ),
        .pad_to_eth           ( pad_to_eth           ),

        .cluster_axi_master   ( cluster_axi_master   ),
        .cluster_axi_slave    ( cluster_axi_slave    ),

        .udma_rx_l3_axi_slave ( udma_rx_l3_axi_bus   ),
        .udma_tx_l3_axi_slave ( udma_tx_l3_axi_bus   ),

        // EVU 
        .spu_core_o           ( spu_o[ 0+:ariane_soc::NumCVA6 ]),
        // APMU
        .pmu_intr_i           ( pmu_intr_o           ),
        .iopmp_irq_i          ( iopmp_irq            ),

        .cva6_uart_rx_i       ( cva6_uart_rx_i       ),
        .cva6_uart_tx_o       ( cva6_uart_tx_o       ),
        .axi_lite_master      ( host_lite_bus        ),
        .axi_lite_snoop_req_i ( axi_lite_snooper_req ),
        .axi_lite_snoop_rsp_o ( axi_lite_snooper_rsp ),

        .iommu_lock_xor_key_i ( iommu_lock_xor_key   ),
        .aia_lock_xor_key_i   ( aia_lock_xor_key     )
    );

   axi2tcdm_wrap #(
      .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
      .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
      .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        )
   ) i_axi2mem_l2 (
      .clk_i       ( s_soc_clk                 ),
      .rst_ni      ( s_synch_soc_rst           ),
      .test_en_i   ( test_en                   ),
      .axi_slave   ( l2_axi_bus                ),
      .tcdm_master ( axi_bridge_2_interconnect ),
      .busy_o      (                           )
   );


   l2_subsystem #(
      .NB_L2_BANKS        ( NB_L2_BANKS              ),
      .L2_BANK_SIZE       ( L2_BANK_SIZE             ),
      .L2_BANK_ADDR_WIDTH ( L2_BANK_ADDR_WIDTH       ),
      .L2_DATA_WIDTH      ( L2_DATA_WIDTH            )
     ) i_l2_subsystem   (
      .clk_i                     ( s_soc_clk                 ),
      .rst_ni                    ( s_synch_soc_rst           ),
      .axi_bridge_2_interconnect ( axi_bridge_2_interconnect ),
      .udma_tcdm_channels        ( udma_2_tcdm_channels      )
     );

    edge_propagator_rx ep_dma_pe_evt_i (
        .clk_i   ( s_soc_clk               ),
        .rstn_i  ( s_rstn_cluster_sync     ),
        .valid_o ( s_dma_pe_evt            ),
        .ack_o   ( dma_pe_evt_ack_o        ),
        .valid_i ( dma_pe_evt_valid_i      )
    );

   apb_subsystem #(
       .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
       .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
       .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
       .NUM_GPIO       ( NUM_GPIO                 ),
     `ifdef TARGET_SYNTHESIS
       .InclUART       ( 1'b1                     )
     `else
       .InclUART       ( 1'b0                     )
     `endif
     ) i_apb_subsystem (
      .clk_i                  ( s_soc_clk                      ),
      .rtc_i                  ( rtc_i                          ),
      .rst_ni                 ( rst_ni                         ),
      .bypass_clk_i           ( bypass_clk_i                   ),
      .rst_dm_i               ( s_dm_rst                       ),
      .clk_cva6_o             ( s_clk_cva6                     ),
      .clk_soc_o              ( s_soc_clk                      ),
      .s_clk_per_o            ( s_periph_clk                   ),
      .clk_opentitan_o        ( clk_opentitan_o                ),
      .rstn_soc_sync_o        ( s_synch_soc_rst                ),
      .rstn_global_sync_o     ( s_synch_global_rst             ),
      .rstn_cva6_sync_o       ( s_rstn_cva6_sync               ),
      .rstn_cluster_sync_o    ( s_rstn_cluster_sync            ),
      .clk_cluster_o          ( clk_cluster_o                  ),
      .cluster_en_sa_boot_o   ( cluster_en_sa_boot_o           ),
      .cluster_fetch_en_o     ( cluster_fetch_en_o             ),
      .llc_cache_addr_start_o ( s_llc_cache_addr_start         ),
      .llc_cache_addr_end_o   ( s_llc_cache_addr_end           ),
      .llc_spm_addr_start_o   ( s_llc_spm_addr_start           ),
      .llc_read_hit_cache_i   ( s_llc_read_hit_cache           ),
      .llc_read_miss_cache_i  ( s_llc_read_miss_cache          ),
      .llc_write_hit_cache_i  ( s_llc_write_hit_cache          ),
      .llc_write_miss_cache_i ( s_llc_write_miss_cache         ),

      `ifdef XILINX_DDR
      .hyper_axi_bus_slave    ( dummyaxibus                    ),
      `else
      .hyper_axi_bus_slave    ( mem_axi_bus                    ),
      `endif
      .axi_apb_slave          ( apb_axi_bus                    ),
      .udma_tcdm_channels     ( udma_2_tcdm_channels           ),
      .udma_rx_l3_axi_master  ( udma_rx_l3_axi_bus             ),
      .udma_tx_l3_axi_master  ( udma_tx_l3_axi_bus             ),

      .padframecfg_reg_master ( padframecfg_reg_master         ),

      .events_o               ( s_udma_events                  ),
      .can_irq_o              ( s_can_irq                      ),
      .pwm_irq_o              ( s_pwm_irq                      ),
      .gpio_irq_o             ( s_gpio_irq                     ),
      .spi_to_pad             ( spi_to_pad                     ),
      .pad_to_spi             ( pad_to_spi                     ),
      .qspi_to_pad            ( qspi_to_pad                    ),
      .pad_to_qspi            ( pad_to_qspi                    ),
      .i2c_to_pad             ( i2c_to_pad                     ),
      .pad_to_i2c             ( pad_to_i2c                     ),
  	  .pad_to_cam             ( pad_to_cam                     ),
      .uart_to_pad            ( uart_to_pad                    ),
      .pad_to_uart            ( pad_to_uart                    ),
      .usart_to_pad           ( usart_to_pad                   ),
      .pad_to_usart           ( pad_to_usart                   ),
      .sdio_to_pad            ( sdio_to_pad                    ),
      .pad_to_sdio            ( pad_to_sdio                    ),
      .pwm_to_pad             ( pwm_to_pad                     ),
      .can_to_pad             ( can_to_pad                     ),
      .pad_to_can             ( pad_to_can                     ),

      `ifndef XILINX_DDR
      .pad_hyper_csn,
      .pad_hyper_ck,
      .pad_hyper_ckn,
      .pad_hyper_rwds,
      .pad_hyper_reset,
      .pad_hyper_dq,
      `endif

      .fll_to_pad             ( fll_to_pad                     ),
      .gpio_to_pad            ( gpio_to_pad                    ),
      .pad_to_gpio            ( pad_to_gpio                    ),

      .cluster_lock_xor_key_o ( cluster_lock_xor_key_o         ),
      .iopmp_lock_xor_key_o   ( iopmp_lock_xor_key             ),
      .iommu_lock_xor_key_o   ( iommu_lock_xor_key             ),
      .aia_lock_xor_key_o     ( aia_lock_xor_key               )

      );


   axi_lite_subsystem #(
       .AXI_USER_WIDTH      ( AXI_USER_WIDTH    ),
       .AXI_ADDR_WIDTH      ( AXI_ADDRESS_WIDTH ),
       .AXI_DATA_WIDTH      ( AXI_DATA_WIDTH    ),
       .AXI_LITE_ADDR_WIDTH ( AXI_LITE_AW       ),
       .AXI_LITE_DATA_WIDTH ( AXI_LITE_DW       )
   ) i_axi_lite_subsystem (
       .clk_i                  ( s_soc_clk               ),
       .rst_ni                 ( rst_ni                  ),
       .host_axi_lite_slave    ( host_lite_bus           ),
       .cluster_axi_lite_slave ( cluster_lite_slave      ),
       .c2h_tlb_cfg_master     ( c2h_tlb_cfg_lite_master ),
       .llc_cfg_master         ( llc_cfg_bus             ),
       // APMU
       .apmu_cfg_master        ( apmu_cfg_lite_bus       ),
       .h2c_irq_o              ( h2c_irq_o               ),
       .c2h_irq_o              ( s_c2h_irq               ),
       .axi_lite_snoop_req_o   ( axi_lite_snooper_req    ),
       .axi_lite_snoop_rsp_i   ( axi_lite_snooper_rsp    ),
       .doorbell_irq_o,
       .completion_irq_o
   );

endmodule

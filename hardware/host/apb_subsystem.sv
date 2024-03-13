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

`include "axi/assign.svh"
`include "axi/typedef.svh"
`include "axi/typedef.svh"
`include "tcdm_macros.sv"

module apb_subsystem
  import apb_soc_pkg::*;
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
  import ariane_soc::HyperbusNumPhys;
  import ariane_soc::NumChipsPerHyperbus;
#(
    parameter int unsigned AXI_USER_WIDTH = 1,
    parameter int unsigned AXI_ADDR_WIDTH = 64,
    parameter int unsigned AXI_DATA_WIDTH = 64,
    parameter int unsigned CAM_DATA_WIDTH = 8,
    parameter int unsigned NUM_GPIO       = 64,
    parameter bit InclUART = 1
) (
    input logic                 clk_i,
    input logic                 rst_ni,
    input logic                 bypass_clk_i,
    input logic                 rtc_i,
    input logic                 rst_dm_i,
    output logic                rstn_soc_sync_o,
    output logic                rstn_cva6_sync_o,
    output logic                rstn_global_sync_o,
    output logic                clk_cva6_o,
    output logic                clk_soc_o,
    output logic                s_clk_per_o,
    output logic                clk_cluster_o,
    output logic                clk_opentitan_o,
    output logic                rstn_cluster_sync_o,
    output logic                cluster_en_sa_boot_o,
    output logic                cluster_fetch_en_o,
    output logic[31:0]          llc_cache_addr_start_o,
    output logic[31:0]          llc_cache_addr_end_o,
    output logic[31:0]          llc_spm_addr_start_o,
    input logic                 llc_read_hit_cache_i,
    input logic                 llc_read_miss_cache_i,
    input logic                 llc_write_hit_cache_i,
    input logic                 llc_write_miss_cache_i,

    AXI_BUS.Slave               axi_apb_slave,
    AXI_BUS.Slave               hyper_axi_bus_slave,
    XBAR_TCDM_BUS.Master        udma_tcdm_channels[1:0],

    AXI_BUS.Master              udma_rx_l3_axi_master,
    AXI_BUS.Master              udma_tx_l3_axi_master,

    REG_BUS.out                 padframecfg_reg_master,

    output logic [31*4-1:0]     events_o,
    output logic                [N_CAN-1 : 0] can_irq_o,

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

    // HYPERBUS
    `ifndef XILINX_DDR
    inout  [HyperbusNumPhys-1:0][NumChipsPerHyperbus-1:0] pad_hyper_csn,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_ck,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_ckn,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_rwds,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_reset,
    inout  [HyperbusNumPhys-1:0][7:0]                     pad_hyper_dq,
    `endif

    // GPIOs
    output                      gpio_to_pad_t gpio_to_pad,
    input                       pad_to_gpio_t pad_to_gpio,

    //CAN
    output                      can_to_pad_t [N_CAN-1 : 0] can_to_pad,
    input                       pad_to_can_t [N_CAN-1 : 0] pad_to_can,

    //IRQ request of CH0 and CH1 from NUM_ADV_TIMER
    //output logic                [NUM_ADV_TIMER-1 : 0] pwm_irq_o,
    //output                      pwm_to_pad_t pwm_to_pad

    // FLL output
    output                      fll_to_pad_t fll_to_pad
);

   logic                                s_rstn_soc_sync;
   logic                                s_rstn_cluster_sync;
   logic                                s_cluster_ctrl_rstn;

   logic [1:0]                          ot_clk_sel_o;
   logic [31:0]                         ot_clk_div_q_o;
   logic                                ot_clk_div_qe_o;
   logic                                ot_clk_gate_en_o;

   logic                                [63:0] can_timestamp;

   assign rstn_soc_sync_o = s_rstn_soc_sync;
   assign rstn_cluster_sync_o = s_rstn_cluster_sync && s_cluster_ctrl_rstn;

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_peripheral_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_udma_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_gpio_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_fll_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_hyaxicfg_master_bus ();
/*
   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_advtimer_master_bus [NUM_ADV_TIMER-1:0]();
*/
   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_padframe_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_can0_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_can1_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_socctrl_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_uart_master_bus();

   FLL_BUS fll_master_bus(
                .clk_i(s_soc_clk)
    );

   REG_BUS #(
        .ADDR_WIDTH( 32 ),
        .DATA_WIDTH( 32 )
    ) i_hyaxicfg_rbus(
        .clk_i (s_soc_clk)
    );

    //uDMA -> XBAR
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) udma_rx_l3_axi_master_cut();

   //uDMA -> XBAR
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
   ) udma_tx_l3_axi_master_cut();


   axi2apb_wrap #(
         .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH           ),
         .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
         .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
         .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
         .APB_ADDR_WIDTH ( 32                       ),
         .APB_DATA_WIDTH ( 32                       )
         )(
           .clk_i      ( clk_soc_o                  ),
           .rst_ni     ( s_rstn_soc_sync            ),
           .test_en_i  ( 1'b0                       ),

           .axi_slave  ( axi_apb_slave              ),
           .apb_master ( apb_peripheral_master_bus  )
         );

   periph_bus_wrap per_bus_wrap (
    .clk_i(clk_soc_o),
    .rst_ni(s_rstn_soc_sync),
    .apb_slave(apb_peripheral_master_bus),
    .udma_master(apb_udma_master_bus),
    .gpio_master(apb_gpio_master_bus),
    .fll_master(apb_fll_master_bus),
    .hyaxicfg_master(apb_hyaxicfg_master_bus),
   // .advtimer_master(apb_advtimer_master_bus),
    .padframe_master(apb_padframe_master_bus),
    .apb_can0_master (apb_can0_master_bus),
    .apb_can1_master (apb_can1_master_bus),
    .socctrl_master(apb_socctrl_master_bus),
    .apb_uart_master(apb_uart_master_bus)
    );

   // CLUSTER UART - FPGA ONLY
   if (InclUART) begin : gen_uart
    `ifdef TARGET_FPGA
         apb_uart i_apb_uart1 (
           .CLK     ( clk_i                          ),
           .RSTN    ( rst_ni                         ),
           .PSEL    ( apb_uart_master_bus.psel       ),
           .PENABLE ( apb_uart_master_bus.penable    ),
           .PWRITE  ( apb_uart_master_bus.pwrite     ),
           .PADDR   ( apb_uart_master_bus.paddr[4:2] ),
           .PWDATA  ( apb_uart_master_bus.pwdata     ),
           .PRDATA  ( apb_uart_master_bus.prdata     ),
           .PREADY  ( apb_uart_master_bus.pready     ),
           .PSLVERR ( apb_uart_master_bus.pslverr    ),
           .INT     (                                ),
           .OUT1N   (                                ), // keep open
           .OUT2N   (                                ), // keep open
           .RTSN    (                                ), // no flow control
           .DTRN    (                                ), // no flow control
           .CTSN    ( 1'b0                           ),
           .DSRN    ( 1'b0                           ),
           .DCDN    ( 1'b0                           ),
           .RIN     ( 1'b0                           ),
           .SIN     ( 1'b0                           ),
           .SOUT    (                                )
         );
     `endif
   end else begin
     /* pragma translate_off */
     mock_uart #( .UART_IDX (1) ) i_mock_uart1 (
         .clk_i     ( clk_i                       ),
         .rst_ni    ( rst_ni                      ),
         .penable_i ( apb_uart_master_bus.penable ),
         .pwrite_i  ( apb_uart_master_bus.pwrite  ),
         .paddr_i   ( apb_uart_master_bus.paddr   ),
         .psel_i    ( apb_uart_master_bus.psel    ),
         .pwdata_i  ( apb_uart_master_bus.pwdata  ),
         .prdata_o  ( apb_uart_master_bus.prdata  ),
         .pready_o  ( apb_uart_master_bus.pready  ),
         .pslverr_o ( apb_uart_master_bus.pslverr )
     );
     /* pragma translate_on */
   end

   logic [udma_subsystem_pkg::APB_ADDR_WIDTH - 1:0]                        apb_udma_address;

   XBAR_TCDM_BUS udma_2_tcdm_to_axi_channels[2]();
   XBAR_TCDM_BUS udma_2_tcdm_master_channels[2]();

   logic                       L2_ro_wen;
   logic                       L2_ro_req;
   logic                       L2_ro_gnt;
   logic [31:0]                L2_ro_addr;
   logic [L2_DATA_WIDTH/8-1:0] L2_ro_be;
   logic [L2_DATA_WIDTH-1:0]   L2_ro_wdata;
   logic                       L2_ro_rvalid;
   logic [L2_DATA_WIDTH-1:0]   L2_ro_rdata;

   logic                       L2_wo_wen;
   logic                       L2_wo_req;
   logic                       L2_wo_gnt;
   logic [31:0]                L2_wo_addr;
   logic [L2_DATA_WIDTH-1:0]   L2_wo_wdata;
   logic [L2_DATA_WIDTH/8-1:0] L2_wo_be;
   logic                       L2_wo_rvalid;
   logic [L2_DATA_WIDTH-1:0]   L2_wo_rdata;

   assign apb_udma_address = apb_udma_master_bus.paddr;

   udma_subsystem i_udma_subsystem
     (

         .events_o        ( events_o                      ),

         .event_valid_i   ( '0                            ),
         .event_data_i    ( '0                            ),
         .event_ready_o   (                               ),

         .dft_test_mode_i ( 1'b0                          ),
         .dft_cg_enable_i ( 1'b0                          ),

         .sys_clk_i       ( clk_soc_o                     ),
         .sys_resetn_i    ( s_rstn_soc_sync               ),

         .periph_clk_i    ( s_clk_per_o                   ),

         .hyper_axi_bus_slave ( hyper_axi_bus_slave       ),
         .hyper_reg_cfg_slave ( i_hyaxicfg_rbus           ),

         .L2_ro_wen_o     ( udma_2_tcdm_master_channels[0].wen     ),
         .L2_ro_req_o     ( udma_2_tcdm_master_channels[0].req     ),
         .L2_ro_gnt_i     ( udma_2_tcdm_master_channels[0].gnt     ),
         .L2_ro_addr_o    ( udma_2_tcdm_master_channels[0].add     ),
         .L2_ro_be_o      ( udma_2_tcdm_master_channels[0].be      ),
         .L2_ro_wdata_o   ( udma_2_tcdm_master_channels[0].wdata   ),
         .L2_ro_rvalid_i  ( udma_2_tcdm_master_channels[0].r_valid ),
         .L2_ro_rdata_i   ( udma_2_tcdm_master_channels[0].r_rdata ),

         .L2_wo_wen_o     ( udma_2_tcdm_master_channels[1].wen      ),
         .L2_wo_req_o     ( udma_2_tcdm_master_channels[1].req      ),
         .L2_wo_gnt_i     ( udma_2_tcdm_master_channels[1].gnt      ),
         .L2_wo_addr_o    ( udma_2_tcdm_master_channels[1].add      ),
         .L2_wo_wdata_o   ( udma_2_tcdm_master_channels[1].wdata    ),
         .L2_wo_be_o      ( udma_2_tcdm_master_channels[1].be       ),
         .L2_wo_rvalid_i  ( udma_2_tcdm_master_channels[1].r_valid  ),
         .L2_wo_rdata_i   ( udma_2_tcdm_master_channels[1].r_rdata  ),

         .udma_apb_paddr  ( apb_udma_address               ),
         .udma_apb_pwdata ( apb_udma_master_bus.pwdata     ),
         .udma_apb_pwrite ( apb_udma_master_bus.pwrite     ),
         .udma_apb_psel   ( apb_udma_master_bus.psel       ),
         .udma_apb_penable( apb_udma_master_bus.penable    ),
         .udma_apb_prdata ( apb_udma_master_bus.prdata     ),
         .udma_apb_pready ( apb_udma_master_bus.pready     ),
         .udma_apb_pslverr( apb_udma_master_bus.pslverr    ),

         `ifndef XILINX_DDR
         .pad_hyper_csn,
         .pad_hyper_ck,
         .pad_hyper_ckn,
         .pad_hyper_rwds,
         .pad_hyper_reset,
         .pad_hyper_dq,
         `endif

         .spi_to_pad      ( spi_to_pad                     ),
         .pad_to_spi      ( pad_to_spi                     ),
         .qspi_to_pad     ( qspi_to_pad                    ),
         .pad_to_qspi     ( pad_to_qspi                    ),
         .i2c_to_pad      ( i2c_to_pad                     ),
         .pad_to_i2c      ( pad_to_i2c                     ),
  	     .pad_to_cam      ( pad_to_cam                     ),
         .uart_to_pad     ( uart_to_pad                    ),
         .pad_to_uart     ( pad_to_uart                    ),
         .usart_to_pad    ( usart_to_pad                   ),
         .pad_to_usart    ( pad_to_usart                   ),
         .sdio_to_pad     ( sdio_to_pad                    ),
         .pad_to_sdio     ( pad_to_sdio                    )
    );

    ///
    localparam NR_RULES_L2_DEMUX = 2;

    apb_soc_pkg::addr_map_rule_t [NR_RULES_L2_DEMUX-1:0] addr_space_contiguous_tx = '{
        '{ idx: 0 , start_addr: ariane_soc::L2SPMBase , end_addr: ( ariane_soc::L2SPMBase + ariane_soc::L2SPMLength )} ,
        '{ idx: 1 , start_addr: ariane_soc::HYAXIBase , end_addr: ( ariane_soc::HYAXIBase + ariane_soc::HYAXILength )} };

    apb_soc_pkg::addr_map_rule_t [NR_RULES_L2_DEMUX-1:0] addr_space_contiguous_rx = '{
        '{ idx: 0 , start_addr: ariane_soc::L2SPMBase , end_addr: ( ariane_soc::L2SPMBase + ariane_soc::L2SPMLength )} ,
        '{ idx: 1 , start_addr: ariane_soc::HYAXIBase , end_addr: ( ariane_soc::HYAXIBase + ariane_soc::HYAXILength )} };


    //////////////////////
    // L2 Demultiplexer //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // For every master, transactions are multiplexed between 2 different target slaves.                             //
    // The first slave port routes to the TCDM port of L2, the second slave port routes to the axi crossbar L3       //
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

    XBAR_TCDM_BUS slave_ports_rx[2]();
    XBAR_TCDM_BUS slave_ports_tx[2]();

    `TCDM_ASSIGN_INTF(udma_2_tcdm_to_axi_channels[0],slave_ports_tx[1])
    `TCDM_ASSIGN_INTF(udma_tcdm_channels[0], slave_ports_tx[0])

    tcdm_demux #(
        .NR_OUTPUTS( NR_RULES_L2_DEMUX ),
        .NR_ADDR_MAP_RULES( NR_RULES_L2_DEMUX )
    ) i_l2_demux_tx(
        .clk_i,
        .rst_ni,
        .test_en_i ( 1'b0   ),
        .addr_map_rules( addr_space_contiguous_tx ),
        .master_port(udma_2_tcdm_master_channels[0]),
        .slave_ports(slave_ports_tx)
    );

    `TCDM_ASSIGN_INTF( udma_2_tcdm_to_axi_channels[1], slave_ports_rx[1])
    `TCDM_ASSIGN_INTF( udma_tcdm_channels[1], slave_ports_rx[0])

    tcdm_demux #(
        .NR_OUTPUTS( NR_RULES_L2_DEMUX ),
        .NR_ADDR_MAP_RULES( NR_RULES_L2_DEMUX )
    ) i_l2_demux_rx(
        .clk_i,
        .rst_ni,
        .test_en_i ( 1'b0   ),
        .addr_map_rules( addr_space_contiguous_rx ),
        .master_port(udma_2_tcdm_master_channels[1]),
        .slave_ports(slave_ports_rx)
    );

    //read from MEM
    lint_2_axi #(
        .ADDR_WIDTH       ( 32                  ),
        .DATA_WIDTH       ( AXI_DATA_WIDTH      ),
        .BE_WIDTH         ( 4                   ),
        .USER_WIDTH       ( AXI_USER_WIDTH      ),
        .AXI_ID_WIDTH     ( ariane_soc::IdWidth ),
        .REGISTERED_GRANT ( "FALSE"             )  // "TRUE"|"FALSE"
    ) i_udma_tx_tcdm_2_axi (
        // Clock and Reset
        .clk_i,
        .rst_ni,
        // TCDM BUS
        .data_req_i    ( udma_2_tcdm_to_axi_channels[0].req ),
        .data_addr_i   ( udma_2_tcdm_to_axi_channels[0].add ),
        .data_we_i     ( ~udma_2_tcdm_to_axi_channels[0].wen  ),
        .data_wdata_i  ( udma_2_tcdm_to_axi_channels[0].wdata ),
        .data_be_i     ( udma_2_tcdm_to_axi_channels[0].be ),
        .data_aux_i    ('0              ), // We don't need this signal
        .data_ID_i     ('0              ), // We don't need this signal
        .data_gnt_o    ( udma_2_tcdm_to_axi_channels[0].gnt     ),

        .data_rvalid_o ( udma_2_tcdm_to_axi_channels[0].r_valid ),
        .data_rdata_o  ( udma_2_tcdm_to_axi_channels[0].r_rdata ),
        .data_ropc_o   ( udma_2_tcdm_to_axi_channels[0].r_opc   ),
        .data_raux_o   (                ), // We don't need this signal
        .data_rID_o    (                ), // We don't need this signal
        // ---------------------------------------------------------
        // AXI TARG Port Declarations ------------------------------
        // ---------------------------------------------------------
        //AXI write address bus -------------- // USED// -----------
        .aw_id_o       ( udma_tx_l3_axi_master_cut.aw_id             ),
        .aw_addr_o     ( udma_tx_l3_axi_master_cut.aw_addr[31:0]     ),
        .aw_len_o      ( udma_tx_l3_axi_master_cut.aw_len            ),
        .aw_size_o     ( udma_tx_l3_axi_master_cut.aw_size           ),
        .aw_burst_o    ( udma_tx_l3_axi_master_cut.aw_burst          ),
        .aw_lock_o     ( udma_tx_l3_axi_master_cut.aw_lock           ),
        .aw_cache_o    ( udma_tx_l3_axi_master_cut.aw_cache          ),
        .aw_prot_o     ( udma_tx_l3_axi_master_cut.aw_prot           ),
        .aw_region_o   ( udma_tx_l3_axi_master_cut.aw_region         ),
        .aw_user_o     ( udma_tx_l3_axi_master_cut.aw_user           ),
        .aw_qos_o      ( udma_tx_l3_axi_master_cut.aw_qos            ),
        .aw_valid_o    ( udma_tx_l3_axi_master_cut.aw_valid          ),
        .aw_ready_i    ( udma_tx_l3_axi_master_cut.aw_ready          ),
        // ---------------------------------------------------------

        //AXI write data bus -------------- // USED// --------------
        .w_data_o      ( udma_tx_l3_axi_master_cut.w_data            ),
        .w_strb_o      ( udma_tx_l3_axi_master_cut.w_strb            ),
        .w_last_o      ( udma_tx_l3_axi_master_cut.w_last            ),
        .w_user_o      ( udma_tx_l3_axi_master_cut.w_user            ),
        .w_valid_o     ( udma_tx_l3_axi_master_cut.w_valid           ),
        .w_ready_i     ( udma_tx_l3_axi_master_cut.w_ready           ),
        // ---------------------------------------------------------

        //AXI write response bus -------------- // USED// ----------
        .b_id_i        ( udma_tx_l3_axi_master_cut.b_id              ),
        .b_resp_i      ( udma_tx_l3_axi_master_cut.b_resp            ),
        .b_valid_i     ( udma_tx_l3_axi_master_cut.b_valid           ),
        .b_user_i      ( udma_tx_l3_axi_master_cut.b_user            ),
        .b_ready_o     ( udma_tx_l3_axi_master_cut.b_ready           ),
        // ---------------------------------------------------------

        //AXI read address bus -------------------------------------
        .ar_id_o       ( udma_tx_l3_axi_master_cut.ar_id             ),
        .ar_addr_o     ( udma_tx_l3_axi_master_cut.ar_addr[31:0]     ),
        .ar_len_o      ( udma_tx_l3_axi_master_cut.ar_len            ),
        .ar_size_o     ( udma_tx_l3_axi_master_cut.ar_size           ),
        .ar_burst_o    ( udma_tx_l3_axi_master_cut.ar_burst          ),
        .ar_lock_o     ( udma_tx_l3_axi_master_cut.ar_lock           ),
        .ar_cache_o    ( udma_tx_l3_axi_master_cut.ar_cache          ),
        .ar_prot_o     ( udma_tx_l3_axi_master_cut.ar_prot           ),
        .ar_region_o   ( udma_tx_l3_axi_master_cut.ar_region         ),
        .ar_user_o     ( udma_tx_l3_axi_master_cut.ar_user           ),
        .ar_qos_o      ( udma_tx_l3_axi_master_cut.ar_qos            ),
        .ar_valid_o    ( udma_tx_l3_axi_master_cut.ar_valid          ),
        .ar_ready_i    ( udma_tx_l3_axi_master_cut.ar_ready          ),
        // ---------------------------------------------------------

        //AXI read data bus ----------------------------------------
        .r_id_i        ( udma_tx_l3_axi_master_cut.r_id              ),
        //.r_data_i      ( udma_tx_l3_axi_master_cut.r_data[31:0]      ),
        .r_data_i      ( udma_tx_l3_axi_master_cut.r_data      ),
        .r_resp_i      ( udma_tx_l3_axi_master_cut.r_resp            ),
        .r_last_i      ( udma_tx_l3_axi_master_cut.r_last            ),
        .r_user_i      ( udma_tx_l3_axi_master_cut.r_user            ),
        .r_valid_i     ( udma_tx_l3_axi_master_cut.r_valid           ),
        .r_ready_o     ( udma_tx_l3_axi_master_cut.r_ready           )
        // ---------------------------------------------------------
    );

    assign udma_tx_l3_axi_master_cut.aw_atop = '0;
    assign udma_tx_l3_axi_master_cut.aw_addr [AXI_ADDR_WIDTH-1:32] = 'h0;
    assign udma_tx_l3_axi_master_cut.ar_addr [AXI_ADDR_WIDTH-1:32] = 'h0;

    axi_cut_intf #(
        .BYPASS     ( 1'b0                ),
        .ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
        .DATA_WIDTH ( AXI_DATA_WIDTH      ),
        .ID_WIDTH   ( ariane_soc::IdWidth ),
        .USER_WIDTH ( AXI_USER_WIDTH      )
    )  i_udma_tx_l3_axi_master_cut (
        .clk_i  ( clk_i                     ),
        .rst_ni ( rst_ni                    ),
        .in     ( udma_tx_l3_axi_master_cut ),
        .out    ( udma_tx_l3_axi_master     )
    );

    //WRITE TO MEM
    lint_2_axi #(
        .ADDR_WIDTH       ( 32                  ),
        .DATA_WIDTH       ( AXI_DATA_WIDTH      ),
        .BE_WIDTH         ( 4                   ),
        .USER_WIDTH       ( AXI_USER_WIDTH      ),
        .AXI_ID_WIDTH     ( ariane_soc::IdWidth ),
        .REGISTERED_GRANT ( "FALSE"             )  // "TRUE"|"FALSE"
    ) i_udma_rx_tcdm_2_axi (
        // Clock and Reset
        .clk_i,
        .rst_ni,
        // TCDM BUS
        .data_req_i    ( udma_2_tcdm_to_axi_channels[1].req ),
        .data_addr_i   ( udma_2_tcdm_to_axi_channels[1].add ),
        .data_we_i     ( ~udma_2_tcdm_to_axi_channels[1].wen  ),
        .data_wdata_i  ( udma_2_tcdm_to_axi_channels[1].wdata ),
        .data_be_i     ( udma_2_tcdm_to_axi_channels[1].be ),
        .data_aux_i    ('0              ), // We don't need this signal
        .data_ID_i     ('0              ), // We don't need this signal

        .data_gnt_o    ( udma_2_tcdm_to_axi_channels[1].gnt     ),
        .data_rvalid_o ( udma_2_tcdm_to_axi_channels[1].r_valid ),
        .data_rdata_o  ( udma_2_tcdm_to_axi_channels[1].r_rdata ),
        .data_ropc_o   ( udma_2_tcdm_to_axi_channels[1].r_opc   ),
        .data_raux_o   (                ), // We don'1 need this signal
        .data_rID_o    (                ), // We don'1 need this signal
        // ---------------------------------------------------------
        // AXI TARG Port Declarations ------------------------------
        // ---------------------------------------------------------
        //AXI write address bus -------------- // USED// -----------
        .aw_id_o       ( udma_rx_l3_axi_master_cut.aw_id             ),
        .aw_addr_o     ( udma_rx_l3_axi_master_cut.aw_addr[31:0]     ),
        .aw_len_o      ( udma_rx_l3_axi_master_cut.aw_len            ),
        .aw_size_o     ( udma_rx_l3_axi_master_cut.aw_size           ),
        .aw_burst_o    ( udma_rx_l3_axi_master_cut.aw_burst          ),
        .aw_lock_o     ( udma_rx_l3_axi_master_cut.aw_lock           ),
        .aw_cache_o    ( udma_rx_l3_axi_master_cut.aw_cache          ),
        .aw_prot_o     ( udma_rx_l3_axi_master_cut.aw_prot           ),
        .aw_region_o   ( udma_rx_l3_axi_master_cut.aw_region         ),
        .aw_user_o     ( udma_rx_l3_axi_master_cut.aw_user           ),
        .aw_qos_o      ( udma_rx_l3_axi_master_cut.aw_qos            ),
        .aw_valid_o    ( udma_rx_l3_axi_master_cut.aw_valid          ),
        .aw_ready_i    ( udma_rx_l3_axi_master_cut.aw_ready          ),
        // ---------------------------------------------------------

        //AXI write data bus -------------- // USED// --------------
        .w_data_o      ( udma_rx_l3_axi_master_cut.w_data            ),
        .w_strb_o      ( udma_rx_l3_axi_master_cut.w_strb            ),
        .w_last_o      ( udma_rx_l3_axi_master_cut.w_last            ),
        .w_user_o      ( udma_rx_l3_axi_master_cut.w_user            ),
        .w_valid_o     ( udma_rx_l3_axi_master_cut.w_valid           ),
        .w_ready_i     ( udma_rx_l3_axi_master_cut.w_ready           ),
        // ---------------------------------------------------------

        //AXI write response bus -------------- // USED// ----------
        .b_id_i        ( udma_rx_l3_axi_master_cut.b_id              ),
        .b_resp_i      ( udma_rx_l3_axi_master_cut.b_resp            ),
        .b_valid_i     ( udma_rx_l3_axi_master_cut.b_valid           ),
        .b_user_i      ( udma_rx_l3_axi_master_cut.b_user            ),
        .b_ready_o     ( udma_rx_l3_axi_master_cut.b_ready           ),
        // ---------------------------------------------------------

        //AXI read address bus -------------------------------------
        .ar_id_o       ( udma_rx_l3_axi_master_cut.ar_id             ),
        .ar_addr_o     ( udma_rx_l3_axi_master_cut.ar_addr[31:0]     ),
        .ar_len_o      ( udma_rx_l3_axi_master_cut.ar_len            ),
        .ar_size_o     ( udma_rx_l3_axi_master_cut.ar_size           ),
        .ar_burst_o    ( udma_rx_l3_axi_master_cut.ar_burst          ),
        .ar_lock_o     ( udma_rx_l3_axi_master_cut.ar_lock           ),
        .ar_cache_o    ( udma_rx_l3_axi_master_cut.ar_cache          ),
        .ar_prot_o     ( udma_rx_l3_axi_master_cut.ar_prot           ),
        .ar_region_o   ( udma_rx_l3_axi_master_cut.ar_region         ),
        .ar_user_o     ( udma_rx_l3_axi_master_cut.ar_user           ),
        .ar_qos_o      ( udma_rx_l3_axi_master_cut.ar_qos            ),
        .ar_valid_o    ( udma_rx_l3_axi_master_cut.ar_valid          ),
        .ar_ready_i    ( udma_rx_l3_axi_master_cut.ar_ready          ),
        // ---------------------------------------------------------

        //AXI read data bus ----------------------------------------
        .r_id_i        ( udma_rx_l3_axi_master_cut.r_id              ),
        .r_data_i      ( udma_rx_l3_axi_master_cut.r_data            ),
        .r_resp_i      ( udma_rx_l3_axi_master_cut.r_resp            ),
        .r_last_i      ( udma_rx_l3_axi_master_cut.r_last            ),
        .r_user_i      ( udma_rx_l3_axi_master_cut.r_user            ),
        .r_valid_i     ( udma_rx_l3_axi_master_cut.r_valid           ),
        .r_ready_o     ( udma_rx_l3_axi_master_cut.r_ready           )
        // ---------------------------------------------------------
    );

    assign udma_rx_l3_axi_master_cut.aw_atop = '0;
    assign udma_rx_l3_axi_master_cut.aw_addr [AXI_ADDR_WIDTH-1:32] = 'h0;
    assign udma_rx_l3_axi_master_cut.ar_addr [AXI_ADDR_WIDTH-1:32] = 'h0;

    axi_cut_intf #(
        .BYPASS     ( 1'b0                ),
        .ADDR_WIDTH ( AXI_ADDR_WIDTH      ),
        .DATA_WIDTH ( AXI_DATA_WIDTH      ),
        .ID_WIDTH   ( ariane_soc::IdWidth ),
        .USER_WIDTH ( AXI_USER_WIDTH      )
    )  i_udma_rx_l3_axi_master_cut (
        .clk_i  ( clk_i                     ),
        .rst_ni ( rst_ni                    ),
        .in     ( udma_rx_l3_axi_master_cut ),
        .out    ( udma_rx_l3_axi_master     )
    );

    logic [63:0] s_gpio_sync;
    logic [NUM_GPIO-1:0] s_gpio_in;
    logic [NUM_GPIO-1:0] s_gpio_out;
    logic [NUM_GPIO-1:0] s_gpio_dir;


    apb_gpio #(
        .APB_ADDR_WIDTH (32),
        .PAD_NUM        (NUM_GPIO),
        .NBIT_PADCFG    (4) // we actually use padrick for pads' configuration
    ) i_apb_gpio (
        .HCLK            ( clk_soc_o                   ),
        .HRESETn         ( s_rstn_soc_sync             ),

        .dft_cg_enable_i ( 1'b0                        ),

        .PADDR           ( apb_gpio_master_bus.paddr   ),
        .PWDATA          ( apb_gpio_master_bus.pwdata  ),
        .PWRITE          ( apb_gpio_master_bus.pwrite  ),
        .PSEL            ( apb_gpio_master_bus.psel    ),
        .PENABLE         ( apb_gpio_master_bus.penable ),
        .PRDATA          ( apb_gpio_master_bus.prdata  ),
        .PREADY          ( apb_gpio_master_bus.pready  ),
        .PSLVERR         ( apb_gpio_master_bus.pslverr ),

        .gpio_in_sync    ( s_gpio_sync                 ),

        .gpio_in         ( s_gpio_in                   ),
        .gpio_out        ( s_gpio_out                  ),
        .gpio_dir        ( s_gpio_dir                  ),
        .gpio_padcfg     (                             ),
        .interrupt       (                             )
    );

    gpio2padframe #(
     .NUM_GPIO       ( NUM_GPIO  )
    ) i_apb_gpio_wrap (
        .gpio_in         ( s_gpio_in   ),
        .gpio_out        ( s_gpio_out  ),
        .gpio_dir        ( s_gpio_dir  ),

        .gpio_to_pad     ( gpio_to_pad ),
        .pad_to_gpio     ( pad_to_gpio )
    );

   `ifdef GF22_FLL
     apb_to_fll #(
         .APB_ADDR_WIDTH (32)
     ) i_apb_fll (
        .clk_i    ( clk_soc_o          ),
        .rst_ni   ( s_rstn_soc_sync    ),
        .apb      ( apb_fll_master_bus ),
        .fll_intf ( fll_master_bus     )
     );
   `else
     assign apb_fll_master_bus.pready  = 1'b1;
     assign apb_fll_master_bus.prdata  = 32'hdeadcaca;
     assign apb_fll_master_bus.pslverr = 1'b0;
     assign fll_master_bus.req = 1'b0;
     assign fll_master_bus.web = 1'b0;
     assign fll_master_bus.wdata = '0;
     assign fll_master_bus.addr  = '0;
   `endif

    alsaqr_clk_rst_gen i_alsaqr_clk_rst_gen
      (
        .ref_clk_i          ( rtc_i               ),
        .rstn_glob_i        ( rst_ni              ),
        .rst_dm_i           ( rst_dm_i            ),
        .test_clk_i         ( 1'b0                ),
        .test_mode_i        ( 1'b0                ),
        .sel_fll_clk_i      ( bypass_clk_i        ),
        .shift_enable_i     ( 1'b0                ),
        .fll_intf           ( fll_master_bus      ),
        .rstn_soc_sync_o    ( s_rstn_soc_sync     ),
        .rstn_cva6_sync_o   ( rstn_cva6_sync_o    ),
        .rstn_global_sync_o ( rstn_global_sync_o  ),
        .rstn_cluster_sync_o( s_rstn_cluster_sync ),
        .ot_clk_sel_i       ( ot_clk_sel_o        ),
        .ot_clk_div_q_i     ( ot_clk_div_q_o      ),
        .ot_clk_div_qe_i    ( ot_clk_div_qe_o     ),
        .ot_clk_gate_en_i   ( ot_clk_gate_en_o    ),
        .clk_cva6_o         ( clk_cva6_o          ),
        .clk_soc_o          ( clk_soc_o           ),
        .clk_per_o          ( s_clk_per_o         ),
        .clk_cluster_o      ( clk_cluster_o       ),
        .clk_opentitan_o    ( clk_opentitan_o     )
       );

    // Here is the FLL output to the PADFRAME
    assign  fll_to_pad.clk_cva6_o = clk_cva6_o;
    assign  fll_to_pad.clk_soc_o  = clk_soc_o;

    apb_to_reg i_apb_to_hyaxicfg
    (
     .clk_i     ( clk_soc_o       ),
     .rst_ni    ( s_rstn_soc_sync ),

     .penable_i ( apb_hyaxicfg_master_bus.penable ),
     .pwrite_i  ( apb_hyaxicfg_master_bus.pwrite  ),
     .paddr_i   ( apb_hyaxicfg_master_bus.paddr   ),
     .psel_i    ( apb_hyaxicfg_master_bus.psel    ),
     .pwdata_i  ( apb_hyaxicfg_master_bus.pwdata  ),
     .prdata_o  ( apb_hyaxicfg_master_bus.prdata  ),
     .pready_o  ( apb_hyaxicfg_master_bus.pready  ),
     .pslverr_o ( apb_hyaxicfg_master_bus.pslverr ),

     .reg_o     ( i_hyaxicfg_rbus                 )
    );
/*
   logic [apb_soc_pkg::NUM_ADV_TIMER-1:0][3:0]   pwm_ch0_o;
   logic [apb_soc_pkg::NUM_ADV_TIMER-1:0][3:0]   pwm_evt_o;

    generate
        for (genvar i=0; i< apb_soc_pkg::NUM_ADV_TIMER; i++) begin : adv_timer_gen
            apb_adv_timer #(
                .APB_ADDR_WIDTH ( 32             ),
                .EXTSIG_NUM     ( 64             )
            ) i_apb_adv_timer (
                .HCLK            ( s_clk_per_o             ),
                .HRESETn         ( s_rstn_soc_sync         ),

                .dft_cg_enable_i ( 1'b0                    ),

                .PADDR           ( apb_advtimer_master_bus[i].paddr   ),
                .PWDATA          ( apb_advtimer_master_bus[i].pwdata  ),
                .PWRITE          ( apb_advtimer_master_bus[i].pwrite  ),
                .PSEL            ( apb_advtimer_master_bus[i].psel    ),
                .PENABLE         ( apb_advtimer_master_bus[i].penable ),
                .PRDATA          ( apb_advtimer_master_bus[i].prdata  ),
                .PREADY          ( apb_advtimer_master_bus[i].pready  ),
                .PSLVERR         ( apb_advtimer_master_bus[i].pslverr ),

                .low_speed_clk_i ( rtc_i                   ),
                .ext_sig_i       ( s_gpio_sync             ),

                .events_o        ( pwm_evt_o[i]            ),

                .ch_0_o          ( pwm_ch0_o[i]            ),
                .ch_1_o          (                         ),
                .ch_2_o          (                         ),
                .ch_3_o          (                         )
            );
        end
    endgenerate

   // PWM 0-8 output from CHANNEL 0
   assign pwm_to_pad.pwm0_o = pwm_ch0_o[0][0];
   assign pwm_to_pad.pwm1_o = pwm_ch0_o[1][0];
   assign pwm_to_pad.pwm2_o = pwm_ch0_o[2][0];
   assign pwm_to_pad.pwm3_o = pwm_ch0_o[3][0];
   assign pwm_to_pad.pwm4_o = pwm_ch0_o[4][0];
   assign pwm_to_pad.pwm5_o = pwm_ch0_o[5][0];
   assign pwm_to_pad.pwm6_o = pwm_ch0_o[6][0];
   assign pwm_to_pad.pwm7_o = pwm_ch0_o[7][0];

   // PWM 0-8 event output from CHANNEL 0
   assign pwm_irq_o[0] = pwm_evt_o[0][0];
   assign pwm_irq_o[1] = pwm_evt_o[1][0];
   assign pwm_irq_o[2] = pwm_evt_o[2][0];
   assign pwm_irq_o[3] = pwm_evt_o[3][0];
   assign pwm_irq_o[4] = pwm_evt_o[4][0];
   assign pwm_irq_o[5] = pwm_evt_o[5][0];
   assign pwm_irq_o[6] = pwm_evt_o[6][0];
   assign pwm_irq_o[7] = pwm_evt_o[7][0];
*/
   apb_to_reg i_apb_to_padframecfg
     (
      .clk_i     ( clk_soc_o       ),
      .rst_ni    ( s_rstn_soc_sync ),

      .penable_i ( apb_padframe_master_bus.penable ),
      .pwrite_i  ( apb_padframe_master_bus.pwrite  ),
      .paddr_i   ( apb_padframe_master_bus.paddr   ),
      .psel_i    ( apb_padframe_master_bus.psel    ),
      .pwdata_i  ( apb_padframe_master_bus.pwdata  ),
      .prdata_o  ( apb_padframe_master_bus.prdata  ),
      .pready_o  ( apb_padframe_master_bus.pready  ),
      .pslverr_o ( apb_padframe_master_bus.pslverr ),

      .reg_o     ( padframecfg_reg_master          )
     );

     assign can_timestamp = '1;

     //set to minimal configuration
     can_top_apb #(
        .rx_buffer_size      ( 32 ),
        .txt_buffer_count    ( 2  ),
        .target_technology   ( 0  ) // 0 for ASIC or 1 for FPGA
      ) i_apb_to_can (
      .aclk             ( clk_soc_o                   ),
      .arstn            ( s_rstn_soc_sync             ),

      .scan_enable      ( 1'b0                        ),
      .res_n_out        (                             ),
      .irq              ( can_irq_o[0]                ),
      .CAN_tx           ( can_to_pad[0].tx_o          ),
      .CAN_rx           ( pad_to_can[0].rx_i          ),
      .timestamp        ( can_timestamp               ),

      .s_apb_paddr      ( apb_can0_master_bus.paddr   ),
      .s_apb_penable    ( apb_can0_master_bus.penable ),
      .s_apb_pprot      ( 3'b000                      ),
      .s_apb_prdata     ( apb_can0_master_bus.prdata  ),
      .s_apb_pready     ( apb_can0_master_bus.pready  ),
      .s_apb_psel       ( apb_can0_master_bus.psel    ),
      .s_apb_pslverr    ( apb_can0_master_bus.pslverr ),
      .s_apb_pstrb      ( 4'b1111                     ),
      .s_apb_pwdata     ( apb_can0_master_bus.pwdata  ),
      .s_apb_pwrite     ( apb_can0_master_bus.pwrite  )
      );

      //set to minimal configuration
     can_top_apb #(
        .rx_buffer_size      ( 32 ),
        .txt_buffer_count    ( 2  ),
        .target_technology   ( 0  ) // 0 for ASIC or 1 for FPGA
      ) i_apb_to_can1 (
      .aclk             ( clk_soc_o                   ),
      .arstn            ( s_rstn_soc_sync             ),

      .scan_enable      ( 1'b0                        ),
      .res_n_out        (                             ),
      .irq              ( can_irq_o[1]                ),
      .CAN_tx           ( can_to_pad[1].tx_o          ),
      .CAN_rx           ( pad_to_can[1].rx_i          ),
      .timestamp        ( can_timestamp               ),

      .s_apb_paddr      ( apb_can1_master_bus.paddr   ),
      .s_apb_penable    ( apb_can1_master_bus.penable ),
      .s_apb_pprot      ( 3'b000                      ),
      .s_apb_prdata     ( apb_can1_master_bus.prdata  ),
      .s_apb_pready     ( apb_can1_master_bus.pready  ),
      .s_apb_psel       ( apb_can1_master_bus.psel    ),
      .s_apb_pslverr    ( apb_can1_master_bus.pslverr ),
      .s_apb_pstrb      ( 4'b1111                     ),
      .s_apb_pwdata     ( apb_can1_master_bus.pwdata  ),
      .s_apb_pwrite     ( apb_can1_master_bus.pwrite  )
      );


  apb_soc_control i_apb_soc_control
  (
    .clk_i (clk_soc_o),
    .rst_ni (s_rstn_soc_sync),
    .apb_slave (apb_socctrl_master_bus),
    .cluster_ctrl_rstn_o (s_cluster_ctrl_rstn),
    .cluster_en_sa_boot_o (cluster_en_sa_boot_o),
    .cluster_fetch_en_o (cluster_fetch_en_o),
    .llc_cache_addr_start_o (llc_cache_addr_start_o),
    .llc_cache_addr_end_o (llc_cache_addr_end_o),
    .llc_spm_addr_start_o (llc_spm_addr_start_o),
    .ot_clk_sel_o ( ot_clk_sel_o ),
    .ot_clk_div_q_o ( ot_clk_div_q_o ),
    .ot_clk_div_qe_o  ( ot_clk_div_qe_o ),
    .ot_clk_gate_en_o ( ot_clk_gate_en_o ),
    .llc_read_hit_cache_i(llc_read_hit_cache_i),
    .llc_read_miss_cache_i(llc_read_miss_cache_i),
    .llc_write_hit_cache_i(llc_write_hit_cache_i),
    .llc_write_miss_cache_i(llc_write_miss_cache_i),
    .xor_locking_blk_0(  ),
    .xor_locking_blk_1(  )
   );


endmodule

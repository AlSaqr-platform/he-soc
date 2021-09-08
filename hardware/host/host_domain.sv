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

module host_domain 
  import axi_pkg::xbar_cfg_t;
  import udma_subsystem_pkg::*;   
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
  parameter bit          JtagEnable        = 1'b1,
  parameter int unsigned CAM_DATA_WIDTH    = 8,
  parameter int unsigned NUM_GPIO          = 64
) (
  input logic                 rtc_i,
  input logic                 rst_ni,
  output logic                soc_clk_o,
  output logic                soc_rst_no,
  output logic                clk_cluster_o,
  output logic                rstn_cluster_sync_o,

  REG_BUS.out                 padframecfg_reg_master,
  // CVA6 DEBUG UART
  input logic                 cva6_uart_rx_i,
  output logic                cva6_uart_tx_o, 

  // FROM SimDTM
  input logic                 dmi_req_valid,
  output logic                dmi_req_ready,
  input logic [ 6:0]          dmi_req_bits_addr,
  input logic [ 1:0]          dmi_req_bits_op,
  input logic [31:0]          dmi_req_bits_data,
  output logic                dmi_resp_valid,
  input logic                 dmi_resp_ready,
  output logic [ 1:0]         dmi_resp_bits_resp,
  output logic [31:0]         dmi_resp_bits_data,

  // JTAG
  input logic                 jtag_TCK,
  input logic                 jtag_TMS,
  input logic                 jtag_TDI,
  input logic                 jtag_TRSTn,
  output logic                jtag_TDO_data,
  output logic                jtag_TDO_driven,
                              
  // SoC to cluster AXI
  AXI_BUS.Master              cluster_axi_master,
  AXI_BUS.Slave               cluster_axi_slave,
  // SPIM
  output                      qspi_to_pad_t [N_SPI-1:0] qspi_to_pad,
  input                       pad_to_qspi_t [N_SPI-1:0] pad_to_qspi,
    
  // I2C
  output                      i2c_to_pad_t [N_I2C-1:0] i2c_to_pad,
  input                       pad_to_i2c_t [N_I2C-1:0] pad_to_i2c,
   
  // CAM
  input                       pad_to_cam_t [N_CAM-1:0] pad_to_cam,
    
  // UART
  input                       pad_to_uart_t [N_UART-1:0] pad_to_uart,
  output                      uart_to_pad_t [N_UART-1:0] uart_to_pad,
    
  // SDIO
  output                      sdio_to_pad_t [N_SDIO-1:0] sdio_to_pad,
  input                       pad_to_sdio_t [N_SDIO-1:0] pad_to_sdio,
 
  // HYPERBUS
  output                      hyper_to_pad_t hyper_to_pad,
  input                       pad_to_hyper_t pad_to_hyper,

  output                      pwm_to_pad_t pwm_to_pad,

  // GPIOs
  input logic [NUM_GPIO-1:0]  gpio_in,
  output logic [NUM_GPIO-1:0] gpio_out,
  output logic [NUM_GPIO-1:0] gpio_dir,

  // PHY interface
  output logic [1:0]          axi_hyper_cs_no,
  output logic                axi_hyper_ck_o,
  output logic                axi_hyper_ck_no,
  output logic                axi_hyper_rwds_o,
  input logic                 axi_hyper_rwds_i,
  output logic                axi_hyper_rwds_oe_o,
  input logic [7:0]           axi_hyper_dq_i,
  output logic [7:0]          axi_hyper_dq_o,
  output logic                axi_hyper_dq_oe_o, 
  output logic                axi_hyper_reset_no
);

   // When changing these parameters, change the L2 size accordingly in ariane_soc_pkg
   localparam NB_L2_BANKS = 8;
   localparam L2_BANK_SIZE = 32768; // 2^15 words (32 bits)

   localparam L2_BANK_ADDR_WIDTH = $clog2(L2_BANK_SIZE);
   localparam L2_MEM_ADDR_WIDTH = $clog2(L2_BANK_SIZE * NB_L2_BANKS) - $clog2(NB_L2_BANKS); 
   localparam L2_DATA_WIDTH = 32 ; // Do not change

   localparam AXI64_2_TCDM32_N_PORTS = 4; // Do not change, to achieve full bandwith from 64 bit AXI and 32 bit tcdm we need 4 ports!
                                          // It is hardcoded in the axi2tcdm_wrap module.

   localparam NB_UDMA_TCDM_CHANNEL = 2;

   localparam RegAw  = 32;
   localparam RegDw  = 32;
   
   logic                                 s_soc_clk;
   logic                                 s_synch_soc_rst;
   logic                                 s_synch_global_rst;
   logic                                 s_dm_rst;
   logic                                 ndmreset_n;
   logic [32*4-1:0]                      s_udma_events;

   logic                                 phy_clk;
   logic                                 phy_clk_90;
   
 
   typedef logic [RegAw-1:0]   reg_addr_t;
   typedef logic [RegDw-1:0]   reg_data_t;
   typedef logic [RegDw/8-1:0] reg_strb_t;

   assign   soc_clk_o  = s_soc_clk;
   assign   soc_rst_no = s_synch_soc_rst;
   
   `REG_BUS_TYPEDEF_REQ(reg_req_t, reg_addr_t, reg_data_t, reg_strb_t)
   `REG_BUS_TYPEDEF_RSP(reg_rsp_t, reg_data_t)
 
   reg_req_t   reg_req;
   reg_rsp_t   reg_rsp;

   ariane_axi_soc::req_slv_t    axi_hyper_req;
   ariane_axi_soc::resp_slv_t   axi_hyper_rsp;

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
   
   XBAR_TCDM_BUS axi_bridge_2_interconnect[AXI64_2_TCDM32_N_PORTS]();
   XBAR_TCDM_BUS udma_2_tcdm_channels[NB_UDMA_TCDM_CHANNEL]();
  
   REG_BUS #(
        .ADDR_WIDTH( RegAw ),
        .DATA_WIDTH( RegDw )
    ) i_hyaxicfg_rbus (
        .clk_i (s_soc_clk)
    ); 
 
   cva6_subsytem # (
        .NUM_WORDS         ( NUM_WORDS  ),
        .InclSimDTM        ( 1'b1       ),
        .StallRandomOutput ( 1'b1       ),
        .StallRandomInput  ( 1'b1       ),
        .JtagEnable        ( JtagEnable )
   ) i_cva_subsystem (
        .clk_i(s_soc_clk),
        .rst_ni(s_synch_global_rst),
        .rtc_i,
        .dmi_req_valid,
        .dmi_req_ready,
        .dmi_req_bits_addr,
        .dmi_req_bits_op,
        .dmi_req_bits_data,
        .dmi_resp_valid,
        .dmi_resp_ready,
        .dmi_resp_bits_resp,
        .dmi_resp_bits_data,                      
        .jtag_TCK,
        .jtag_TMS,
        .jtag_TDI,
        .jtag_TRSTn,
        .jtag_TDO_data,
        .jtag_TDO_driven,
        .sync_rst_ni          ( s_synch_soc_rst      ),
        .udma_events_i        ( s_udma_events        ),
        .dm_rst_o             ( s_dm_rst             ),
        .l2_axi_master        ( l2_axi_bus           ),
        .apb_axi_master       ( apb_axi_bus          ),
        .hyper_axi_master     ( hyper_axi_bus        ),
        .cluster_axi_master   ( cluster_axi_master   ),
        .cluster_axi_slave    ( cluster_axi_slave    ),
        .cva6_uart_rx_i       ( cva6_uart_rx_i       ),
        .cva6_uart_tx_o       ( cva6_uart_tx_o       )
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


   apb_subsystem #(
       .L2_ADDR_WIDTH  ( L2_MEM_ADDR_WIDTH        ),
       .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
       .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
       .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
       .NUM_GPIO       ( NUM_GPIO                 )
     ) i_apb_subsystem (
      .clk_i                  ( s_soc_clk                      ),
      .rtc_i                  ( rtc_i                          ),
      .rst_ni                 ( rst_ni                         ),
      .rst_dm_i               ( s_dm_rst                       ),
      .clk_soc_o              ( s_soc_clk                      ),
      .rstn_soc_sync_o        ( s_synch_soc_rst                ),
      .rstn_global_sync_o     ( s_synch_global_rst             ),
      .rstn_cluster_sync_o    ( rstn_cluster_sync_o            ),
      .clk_cluster_o          ( clk_cluster_o                  ),                 
      .axi_apb_slave          ( apb_axi_bus                    ),
      .hyaxicfg_reg_master    ( i_hyaxicfg_rbus                ),
      .udma_tcdm_channels     ( udma_2_tcdm_channels           ),
      .padframecfg_reg_master ( padframecfg_reg_master         ),

      .events_o               ( s_udma_events                  ),

      .qspi_to_pad            ( qspi_to_pad                    ),
      .pad_to_qspi            ( pad_to_qspi                    ),
      .i2c_to_pad             ( i2c_to_pad                     ),
      .pad_to_i2c             ( pad_to_i2c                     ),
  	  .pad_to_cam             ( pad_to_cam                     ),
      .pad_to_uart            ( pad_to_uart                    ),
      .uart_to_pad            ( uart_to_pad                    ),
      .sdio_to_pad            ( sdio_to_pad                    ),
      .pad_to_sdio            ( pad_to_sdio                    ),
      .hyper_to_pad           ( hyper_to_pad                   ),
      .pad_to_hyper           ( pad_to_hyper                   ),
      .pwm_to_pad             ( pwm_to_pad                     ),
                        
      .gpio_in                ( gpio_in                        ),
      .gpio_out               ( gpio_out                       ),
      .gpio_dir               ( gpio_dir                       )

      );
                     
  `REG_BUS_ASSIGN_TO_REQ(reg_req,i_hyaxicfg_rbus)
  `REG_BUS_ASSIGN_FROM_RSP(i_hyaxicfg_rbus,reg_rsp)
    
  `AXI_ASSIGN_TO_REQ(axi_hyper_req,hyper_axi_bus)
  `AXI_ASSIGN_FROM_RESP(hyper_axi_bus,axi_hyper_rsp)

`ifdef FPGA_EMUL
(* DONT_TOUCH = "TRUE" *)   clk_gen_hyper i_clk_gen_hyper (
`else
          clk_gen_hyper i_clk_gen_hyper (                                                           
`endif
          .clk_i    ( s_soc_clk       ),
          .rst_ni   ( s_synch_soc_rst ),
          .clk0_o   ( phy_clk         ),
          .clk90_o  ( phy_clk_90      ),
          .clk180_o (                 ),
          .clk270_o (                 )
          );
   
    hyperbus #(
         .NumChips       ( 2                           ),
         .AxiAddrWidth   ( AXI_ADDRESS_WIDTH           ),
         .AxiDataWidth   ( AXI_DATA_WIDTH              ),
         .AxiIdWidth     ( ariane_soc::IdWidthSlave    ),
         .axi_req_t      ( ariane_axi_soc::req_slv_t   ),
         .axi_rsp_t      ( ariane_axi_soc::resp_slv_t  ),
         .axi_w_chan_t   ( ariane_axi_soc::w_chan_t    ),
         .RegAddrWidth   ( RegAw                       ),
         .RegDataWidth   ( RegDw                       ),
         .reg_req_t      ( reg_req_t                   ),
         .reg_rsp_t      ( reg_rsp_t                   ),
         .axi_rule_t     ( ariane_soc::addr_map_rule_t ),
         .RxFifoLogDepth ( 4                           ),
         .TxFifoLogDepth ( 4                           ),
         .RstChipBase    ( ariane_soc::HYAXIBase       ),  // Base address for all chips
         .RstChipSpace   ( ariane_soc::HYAXILength     )   // 8 MB
     ) axi_hyperbus (
         .clk_phy_i              ( phy_clk               ),
         .clk_phy_i_90           ( phy_clk_90            ),
         .rst_phy_ni             ( s_synch_soc_rst       ),
         .clk_sys_i              ( s_soc_clk             ),
         .rst_sys_ni             ( s_synch_soc_rst       ),
         .test_mode_i            ( '0                    ),
         .axi_req_i              ( axi_hyper_req         ),
         .axi_rsp_o              ( axi_hyper_rsp         ),
         .reg_req_i              ( reg_req               ),
         .reg_rsp_o              ( reg_rsp               ),
         .hyper_cs_no            ( axi_hyper_cs_no       ),
         .hyper_ck_o             ( axi_hyper_ck_o        ),
         .hyper_ck_no            ( axi_hyper_ck_no       ),
         .hyper_rwds_o           ( axi_hyper_rwds_o      ),
         .hyper_rwds_i           ( axi_hyper_rwds_i      ),
         .hyper_rwds_oe_o        ( axi_hyper_rwds_oe_o   ),
         .hyper_dq_i             ( axi_hyper_dq_i        ),
         .hyper_dq_o             ( axi_hyper_dq_o        ),
         .hyper_dq_oe_o          ( axi_hyper_dq_oe_o     ),
         .hyper_reset_no         ( axi_hyper_reset_no    )
     );
 
 
endmodule

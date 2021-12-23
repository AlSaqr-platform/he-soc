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
`include "alsaqr_periph_padframe/assign.svh"
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
  import pkg_alsaqr_periph_padframe::*; 
  import ariane_soc::HyperbusNumPhys;
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

  inout wire [7:0]    pad_hyper0_dq ,
  inout wire          pad_hyper0_ck ,
  inout wire          pad_hyper0_ckn ,
  inout wire [1:0]    pad_hyper0_csn ,
  inout wire          pad_hyper0_rwds ,
  inout wire          pad_hyper0_reset ,

  inout wire [7:0]    pad_hyper1_dq ,
  inout wire          pad_hyper1_ck ,
  inout wire          pad_hyper1_ckn ,
  inout wire [1:0]    pad_hyper1_csn ,
  inout wire          pad_hyper1_rwds ,
  inout wire          pad_hyper1_reset ,

  inout wire logic    pad_periphs_pad_gpio_b_00_pad,
  inout wire logic    pad_periphs_pad_gpio_b_01_pad,
  inout wire logic    pad_periphs_pad_gpio_b_02_pad,
  inout wire logic    pad_periphs_pad_gpio_b_03_pad,
  inout wire logic    pad_periphs_pad_gpio_b_04_pad,
  inout wire logic    pad_periphs_pad_gpio_b_05_pad,
  inout wire logic    pad_periphs_pad_gpio_b_06_pad,
  inout wire logic    pad_periphs_pad_gpio_b_07_pad,
  inout wire logic    pad_periphs_pad_gpio_b_08_pad,
  inout wire logic    pad_periphs_pad_gpio_b_09_pad,
  inout wire logic    pad_periphs_pad_gpio_b_10_pad,
  inout wire logic    pad_periphs_pad_gpio_b_11_pad,
  inout wire logic    pad_periphs_pad_gpio_b_12_pad,
  inout wire logic    pad_periphs_pad_gpio_b_13_pad,
  inout wire logic    pad_periphs_pad_gpio_b_14_pad,
  inout wire logic    pad_periphs_pad_gpio_b_15_pad,
  inout wire logic    pad_periphs_pad_gpio_b_16_pad,
  inout wire logic    pad_periphs_pad_gpio_b_17_pad,
  inout wire logic    pad_periphs_pad_gpio_b_18_pad,
  inout wire logic    pad_periphs_pad_gpio_b_19_pad,
  inout wire logic    pad_periphs_pad_gpio_b_20_pad,
  inout wire logic    pad_periphs_pad_gpio_b_21_pad,
  inout wire logic    pad_periphs_pad_gpio_b_22_pad,
  inout wire logic    pad_periphs_pad_gpio_b_23_pad,
  inout wire logic    pad_periphs_pad_gpio_b_24_pad,
  inout wire logic    pad_periphs_pad_gpio_b_25_pad,
  inout wire logic    pad_periphs_pad_gpio_b_26_pad,
  inout wire logic    pad_periphs_pad_gpio_b_27_pad,
  inout wire logic    pad_periphs_pad_gpio_b_28_pad,
  inout wire logic    pad_periphs_pad_gpio_b_29_pad,
  inout wire logic    pad_periphs_pad_gpio_b_30_pad,
  inout wire logic    pad_periphs_pad_gpio_b_31_pad,
  inout wire logic    pad_periphs_pad_gpio_b_32_pad,
  inout wire logic    pad_periphs_pad_gpio_b_33_pad,
  inout wire logic    pad_periphs_pad_gpio_b_34_pad,
  inout wire logic    pad_periphs_pad_gpio_b_35_pad,
  inout wire logic    pad_periphs_pad_gpio_b_36_pad,
  inout wire logic    pad_periphs_pad_gpio_b_37_pad,
  inout wire logic    pad_periphs_pad_gpio_b_38_pad,
  inout wire logic    pad_periphs_pad_gpio_b_39_pad,
  inout wire logic    pad_periphs_pad_gpio_b_40_pad,
  inout wire logic    pad_periphs_pad_gpio_b_41_pad,
  inout wire logic    pad_periphs_pad_gpio_b_42_pad,
  inout wire logic    pad_periphs_pad_gpio_b_43_pad,
  inout wire logic    pad_periphs_pad_gpio_b_44_pad,
  inout wire logic    pad_periphs_pad_gpio_b_45_pad,
  inout wire logic    pad_periphs_pad_gpio_b_46_pad,
  inout wire logic    pad_periphs_pad_gpio_b_47_pad,
  inout wire logic    pad_periphs_pad_gpio_b_48_pad,
  inout wire logic    pad_periphs_pad_gpio_b_49_pad,
  inout wire logic    pad_periphs_pad_gpio_b_50_pad,
  inout wire logic    pad_periphs_pad_gpio_b_51_pad,
  inout wire logic    pad_periphs_pad_gpio_b_52_pad,
  inout wire logic    pad_periphs_pad_gpio_b_53_pad,
  inout wire logic    pad_periphs_pad_gpio_b_54_pad,
  inout wire logic    pad_periphs_pad_gpio_b_55_pad,
  inout wire logic    pad_periphs_pad_gpio_b_56_pad,
  inout wire logic    pad_periphs_pad_gpio_b_57_pad,
  inout wire logic    pad_periphs_pad_gpio_b_58_pad,
  inout wire logic    pad_periphs_pad_gpio_b_59_pad,
  inout wire logic    pad_periphs_pad_gpio_b_60_pad,
  inout wire logic    pad_periphs_pad_gpio_b_61_pad,

  inout wire logic    pad_periphs_pad_gpio_c_00_pad,
  inout wire logic    pad_periphs_pad_gpio_c_01_pad,
  inout wire logic    pad_periphs_pad_gpio_c_02_pad,
  inout wire logic    pad_periphs_pad_gpio_c_03_pad,

  inout wire logic    pad_periphs_pad_gpio_d_00_pad,
  inout wire logic    pad_periphs_pad_gpio_d_01_pad,
  inout wire logic    pad_periphs_pad_gpio_d_02_pad,
  inout wire logic    pad_periphs_pad_gpio_d_03_pad,
  inout wire logic    pad_periphs_pad_gpio_d_04_pad,
  inout wire logic    pad_periphs_pad_gpio_d_05_pad,
  inout wire logic    pad_periphs_pad_gpio_d_06_pad,
  inout wire logic    pad_periphs_pad_gpio_d_07_pad,
  inout wire logic    pad_periphs_pad_gpio_d_08_pad,
  inout wire logic    pad_periphs_pad_gpio_d_09_pad,
  inout wire logic    pad_periphs_pad_gpio_d_10_pad,

  inout wire logic    pad_periphs_pad_gpio_e_00_pad,
  inout wire logic    pad_periphs_pad_gpio_e_01_pad,
  inout wire logic    pad_periphs_pad_gpio_e_02_pad,
  inout wire logic    pad_periphs_pad_gpio_e_03_pad,
  inout wire logic    pad_periphs_pad_gpio_e_04_pad,
  inout wire logic    pad_periphs_pad_gpio_e_05_pad,
  inout wire logic    pad_periphs_pad_gpio_e_06_pad,
  inout wire logic    pad_periphs_pad_gpio_e_07_pad,
  inout wire logic    pad_periphs_pad_gpio_e_08_pad,
  inout wire logic    pad_periphs_pad_gpio_e_09_pad,
  inout wire logic    pad_periphs_pad_gpio_e_10_pad,
  inout wire logic    pad_periphs_pad_gpio_e_11_pad,
  inout wire logic    pad_periphs_pad_gpio_e_12_pad,

  inout wire logic    pad_periphs_pad_gpio_f_00_pad,
  inout wire logic    pad_periphs_pad_gpio_f_01_pad,
  inout wire logic    pad_periphs_pad_gpio_f_02_pad,
  inout wire logic    pad_periphs_pad_gpio_f_03_pad,
  inout wire logic    pad_periphs_pad_gpio_f_04_pad,
  inout wire logic    pad_periphs_pad_gpio_f_05_pad,
  inout wire logic    pad_periphs_pad_gpio_f_06_pad,
  inout wire logic    pad_periphs_pad_gpio_f_07_pad,
  inout wire logic    pad_periphs_pad_gpio_f_08_pad,
  inout wire logic    pad_periphs_pad_gpio_f_09_pad,
  inout wire logic    pad_periphs_pad_gpio_f_10_pad,
  inout wire logic    pad_periphs_pad_gpio_f_11_pad,
  inout wire logic    pad_periphs_pad_gpio_f_12_pad,
  inout wire logic    pad_periphs_pad_gpio_f_13_pad,
  inout wire logic    pad_periphs_pad_gpio_f_14_pad,
  inout wire logic    pad_periphs_pad_gpio_f_15_pad,
  inout wire logic    pad_periphs_pad_gpio_f_16_pad,
  inout wire logic    pad_periphs_pad_gpio_f_17_pad,
  inout wire logic    pad_periphs_pad_gpio_f_18_pad,
  inout wire logic    pad_periphs_pad_gpio_f_19_pad,
  inout wire logic    pad_periphs_pad_gpio_f_20_pad,
  inout wire logic    pad_periphs_pad_gpio_f_21_pad,
  inout wire logic    pad_periphs_pad_gpio_f_22_pad,
  inout wire logic    pad_periphs_pad_gpio_f_23_pad,
  inout wire logic    pad_periphs_pad_gpio_f_24_pad,
  inout wire logic    pad_periphs_pad_gpio_f_25_pad,

  inout wire logic    pad_periphs_pad_gpio_pwm0_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm1_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm2_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm3_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm4_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm5_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm6_pad,
  inout wire logic    pad_periphs_pad_gpio_pwm7_pad,

  // CVA6 DEBUG UART
  inout wire          logic cva6_uart_rx_i,
  inout wire          logic cva6_uart_tx_o,
  // FROM SimDTM
`ifndef TARGET_SYNTHESIS
  input logic         dmi_req_valid,
  output logic        dmi_req_ready,
  input logic [ 6:0]  dmi_req_bits_addr,
  input logic [ 1:0]  dmi_req_bits_op,
  input logic [31:0]  dmi_req_bits_data,
  output logic        dmi_resp_valid,
  input logic         dmi_resp_ready,
  output logic [ 1:0] dmi_resp_bits_resp,
  output logic [31:0] dmi_resp_bits_data, 
`endif
  // JTAG
  inout wire          jtag_TCK,
  inout wire          jtag_TMS,
  inout wire          jtag_TDI,
  inout wire          jtag_TRSTn,
  inout wire          jtag_TDO_data,
  inout wire          jtag_TDO_driven

);
  // AXILITE parameters
  localparam int unsigned AXI_LITE_AW       = 32;
  localparam int unsigned AXI_LITE_DW       = 32;

  logic [NUM_GPIO-1:0]         s_gpio_pad_in;
  logic [NUM_GPIO-1:0]         s_gpio_pad_out;
  logic [NUM_GPIO-1:0]         s_gpio_pad_dir;

  logic                        s_rst_ni;
  logic                        s_jtag_TCK;
  logic                        s_jtag_TDI;
  logic                        s_jtag_TDO;
  logic                        s_jtag_TMS;
  logic                        s_jtag_TRSTn;
  logic                        s_rtc_i;
  logic                        s_bypass_clk;
   

  logic s_soc_clk  ;
  logic s_soc_rst_n; 
  logic s_cluster_clk  ;
  logic s_cluster_rst_n;


  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) soc_to_tlb_axi_bus();
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
  ) c2h_tlb_cfg_axi_bus_64();

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
    .AXI_ADDR_WIDTH (AXI_LITE_AW),
    .AXI_DATA_WIDTH (AXI_LITE_DW)
  ) h2c_tlb_cfg();
   
  AXI_LITE #(
    .AXI_ADDR_WIDTH    ( AXI_LITE_AW ),
    .AXI_DATA_WIDTH    ( AXI_LITE_DW )
  ) tlb_cfg_lite_master();

  AXI_LITE #(
    .AXI_ADDR_WIDTH  ( AXI_LITE_AW ),
    .AXI_DATA_WIDTH  ( AXI_LITE_DW )
  ) c2h_tlb_cfg_lite ();

  AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_ADDRESS_WIDTH),
    .AXI_DATA_WIDTH (AXI_LITE_DW)
  ) c2h_tlb_cfg();

  logic s_cva6_uart_rx_i;
  logic s_cva6_uart_tx_o;

  logic s_dma_pe_evt_ack;
  logic s_dma_pe_evt_valid;
   
  pad_to_hyper_t [HyperbusNumPhys-1:0] s_pad_to_hyper;
  hyper_to_pad_t [HyperbusNumPhys-1:0] s_hyper_to_pad;

  qspi_to_pad_t [N_SPI-1:0] s_qspi_to_pad;
  pad_to_qspi_t [N_SPI-1:0] s_pad_to_qspi;
  
  i2c_to_pad_t [N_I2C-1:0] s_i2c_to_pad;
  pad_to_i2c_t [N_I2C-1:0] s_pad_to_i2c;
  
  pad_to_cam_t [N_CAM-1:0] s_pad_to_cam;
 
  pad_to_uart_t [N_UART-1:0] s_pad_to_uart;
  uart_to_pad_t [N_UART-1:0] s_uart_to_pad;
  
  sdio_to_pad_t [N_SDIO-1:0] s_sdio_to_pad;
  pad_to_sdio_t [N_SDIO-1:0] s_pad_to_sdio;
  
  pwm_to_pad_t s_pwm_to_pad;

  pad_to_ser_link s_pad_to_serial_link;
  ser_link_to_pad s_serial_link_to_pad;

  gpio_to_pad_t s_gpio_b_to_pad;
  pad_to_gpio_t s_pad_to_gpio_b;
   
  port_signals_pad2soc_t              s_port_signals_pad2soc;
  port_signals_soc2pad_t              s_port_signals_soc2pad;
      
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
      
    host_domain #(
        .NUM_WORDS         ( NUM_WORDS  ),
        .InclSimDTM        ( 1'b1       ),
        .StallRandomOutput ( 1'b1       ),
        .StallRandomInput  ( 1'b1       ),
        .NUM_GPIO          ( NUM_GPIO   ),
        .JtagEnable        ( JtagEnable )
    ) i_host_domain (
      .rst_ni(s_rst_ni),
      .rtc_i(s_rtc_i),
      .bypass_clk_i(s_bypass_clk),
`ifndef TARGET_SYNTHESIS
      .dmi_req_valid,
      .dmi_req_ready,
      .dmi_req_bits_addr,
      .dmi_req_bits_op,
      .dmi_req_bits_data,
      .dmi_resp_valid,
      .dmi_resp_ready,
      .dmi_resp_bits_resp,
      .dmi_resp_bits_data, 
`else                                                                         
      .dmi_req_valid        ( '0 ), 
      .dmi_req_ready        (    ),
      .dmi_req_bits_addr    ( '0 ),
      .dmi_req_bits_op      ( '0 ),
      .dmi_req_bits_data    ( '0 ),
      .dmi_resp_valid       (    ),
      .dmi_resp_ready       ( '0 ),
      .dmi_resp_bits_resp   (    ),
      .dmi_resp_bits_data   (    ), 
`endif
      .jtag_TCK               ( s_jtag_TCK                      ),
      .jtag_TMS               ( s_jtag_TMS                      ),
      .jtag_TDI               ( s_jtag_TDI                      ),
      .jtag_TRSTn             ( s_jtag_TRSTn                    ),
      .jtag_TDO_data          ( s_jtag_TDO                      ),
      .jtag_TDO_driven        (                                 ),
      .cluster_axi_master     ( soc_to_tlb_axi_bus              ),
      .dma_pe_evt_ack_o       ( s_dma_pe_evt_ack                ),
      .dma_pe_evt_valid_i     ( s_dma_pe_evt_valid              ),
      .cluster_axi_slave      ( tlb_to_soc_axi_bus              ),
      .tlb_cfg_lite_master    ( tlb_cfg_lite_master             ),
      .soc_clk_o              ( s_soc_clk                       ),
      .soc_rst_no             ( s_soc_rst_n                     ),
      .rstn_cluster_sync_o    ( s_cluster_rst_n                 ),
      .cluster_en_sa_boot_o   ( s_cluster_en_sa_boot            ),
      .cluster_fetch_en_o     ( s_cluster_fetch_en              ),
      .clk_cluster_o          ( s_cluster_clk                   ),                 
      .padframecfg_reg_master ( i_padframecfg_rbus              ),
      
      .hyper_to_pad           ( s_hyper_to_pad                  ),
      .pad_to_hyper           ( s_pad_to_hyper                  ),    

      .qspi_to_pad            ( s_qspi_to_pad                   ),
      .pad_to_qspi            ( s_pad_to_qspi                   ),

      .i2c_to_pad             ( s_i2c_to_pad                    ),
      .pad_to_i2c             ( s_pad_to_i2c                    ),

  	  .pad_to_cam             ( s_pad_to_cam                    ),

      .pad_to_uart            ( s_pad_to_uart                   ),
      .uart_to_pad            ( s_uart_to_pad                   ),

      .sdio_to_pad            ( s_sdio_to_pad                   ),
      .pad_to_sdio            ( s_pad_to_sdio                   ),

      .serial_link_to_pad     ( s_serial_link_to_pad             ),
      .pad_to_serial_link     ( s_pad_to_serial_link             ),                     

      .gpio_to_pad            ( s_gpio_b_to_pad                  ),
      .pad_to_gpio            ( s_pad_to_gpio_b                  ),

      .cva6_uart_rx_i         ( s_cva6_uart_rx_i                 ),
      .cva6_uart_tx_o         ( s_cva6_uart_tx_o                 ),

      .pwm_to_pad             ( s_pwm_to_pad                     )
    );
   
   pad_frame #()
    i_pad_frame
      (       

      .pad_to_hyper           ( s_pad_to_hyper             ),
      .hyper_to_pad           ( s_hyper_to_pad             ),
              
      .pad_hyper0_dq ,
      .pad_hyper0_ck ,
      .pad_hyper0_ckn ,
      .pad_hyper0_csn ,
      .pad_hyper0_rwds ,
      .pad_hyper0_reset ,
      
      
      .pad_hyper1_dq ,
      .pad_hyper1_ck ,
      .pad_hyper1_ckn ,
      .pad_hyper1_csn ,
      .pad_hyper1_rwds ,
      .pad_hyper1_reset ,

      .cva6_uart_rx           ( s_cva6_uart_rx_i           ),
      .cva6_uart_tx           ( s_cva6_uart_tx_o           ),
      .pad_cva6_uart_tx       ( cva6_uart_tx_o             ),
      .pad_cva6_uart_rx       ( cva6_uart_rx_i             ),

              
      .ref_clk_o              ( s_rtc_i                    ),
      .bypass_o               ( s_bypass_clk               ),
      .rstn_o                 ( s_rst_ni                   ),
      .jtag_tck_o             ( s_jtag_TCK                 ),
      .jtag_tdi_o             ( s_jtag_TDI                 ),
      .jtag_tdo_i             ( s_jtag_TDO                 ),
      .jtag_tms_o             ( s_jtag_TMS                 ),
      .jtag_trst_o            ( s_jtag_TRSTn               ),
      
      .pad_reset_n            ( rst_ni                     ),
      .pad_jtag_tck           ( jtag_TCK                   ),
      .pad_jtag_tdi           ( jtag_TDI                   ),
      .pad_jtag_tdo           ( jtag_TDO_data              ),
      .pad_jtag_tms           ( jtag_TMS                   ),
      .pad_jtag_trst          ( jtag_TRSTn                 ),
      .pad_bypass             ( bypass_clk_i               ),
      .pad_xtal_in            ( rtc_i                      )
     );

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
        .slv    ( tlb_to_cluster_axi_bus            ),
        .mst    ( serialized_soc_to_cluster_axi_bus )
      );

   axi_cdc_src_intf   #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH               ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH                  ),
     .AXI_ID_WIDTH   ( ariane_soc::SocToClusterIdWidth ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH                  ),
     .LOG_DEPTH      ( 3                               )
     ) soc_to_cluster_src_cdc_fifo_i 
       (
       .src_clk_i  ( s_soc_clk                         ),
       .src_rst_ni ( s_soc_rst_n                       ),
       .src        ( serialized_soc_to_cluster_axi_bus ),
       .dst        ( async_soc_to_cluster_axi_bus      )
       );
   
   axi_cdc_dst_intf   #(
     .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidth      ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
     .LOG_DEPTH      ( 3                        )
     ) cluster_to_soc_dst_cdc_fifo_i (
       .dst_clk_i  ( s_soc_clk                    ),
       .dst_rst_ni ( s_soc_rst_n                  ),
       .src        ( async_cluster_to_soc_axi_bus ),
       .dst        ( cluster_to_tlb_axi_bus       )
       );

   axi_cdc_dst_intf      #(
     .AXI_ADDR_WIDTH      ( AXI_ADDRESS_WIDTH      ),
     .AXI_DATA_WIDTH      ( AXI_DATA_WIDTH         ),
     .AXI_ID_WIDTH        ( ariane_soc::IdWidth    ),
     .AXI_USER_WIDTH      ( AXI_USER_WIDTH         ),
     .LOG_DEPTH           ( 3                      )
     ) cfg_dst_cdc_fifo_i (                        
       .dst_clk_i         ( s_soc_clk              ),
       .dst_rst_ni        ( s_soc_rst_n            ),
       .src               ( async_cfg_axi_bus      ),
       .dst               ( c2h_tlb_cfg_axi_bus_64 )
       );

   axi_dw_converter_intf #(
     .AXI_ID_WIDTH             ( ariane_soc::IdWidthSlave ),
     .AXI_ADDR_WIDTH           ( AXI_ADDRESS_WIDTH        ),
     .AXI_SLV_PORT_DATA_WIDTH  ( AXI_DATA_WIDTH           ),
     .AXI_MST_PORT_DATA_WIDTH  ( AXI_LITE_DW              ),
     .AXI_USER_WIDTH           ( AXI_USER_WIDTH           ),
     .AXI_MAX_READS            ( 1                        )
   ) i_dwc_tlb_cfg (
     .clk_i        ( s_soc_clk              ),
     .rst_ni       ( s_synch_soc_rst        ),
     .slv          ( c2h_tlb_cfg_axi_bus_64 ),
     .mst          ( c2h_tlb_cfg_axi_bus_32 )
   );

   axi_to_axi_lite_intf #(
     .AXI_ADDR_WIDTH     ( AXI_ADDRESS_WIDTH      ),
     .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH         ),
     .AXI_ID_WIDTH       ( ariane_soc::IdWidth    ),
     .AXI_USER_WIDTH     ( AXI_USER_WIDTH         ),
     .AXI_MAX_WRITE_TXNS ( 1                      ),
     .AXI_MAX_READ_TXNS  ( 1                      ),
     .FALL_THROUGH       ( 0                      )
   ) i_axi2lite_tlb_cfg  (                        
     .clk_i              ( s_soc_clk              ),
     .rst_ni             ( s_soc_rst_n            ),
     .testmode_i         ( 1'b0                   ),
     .slv                ( c2h_tlb_cfg_axi_bus_32 ),
     .mst                ( c2h_tlb_cfg_lite       )
   );
   
    pulp_cluster
//    #(
//        .NB_CORES                     ( `NB_CORES                       ),
//        .NB_HWPE_PORTS                ( 4                               ),
//        .NB_DMAS                      ( `NB_DMAS                        ),
//        .HWPE_PRESENT                 ( 0                               ),
//        .TCDM_SIZE                    ( 256*1024                        ),
//        .NB_TCDM_BANKS                ( 16                              ),
//        .SET_ASSOCIATIVE              ( 4                               ),
//        .CACHE_LINE                   ( 1                               ),
//        .CACHE_SIZE                   ( 4096                            ),
//        .ICACHE_DATA_WIDTH            ( 128                             ),
//        .L0_BUFFER_FEATURE            ( "DISABLED"                      ),
//        .MULTICAST_FEATURE            ( "DISABLED"                      ),
//        .SHARED_ICACHE                ( "ENABLED"                       ),
//        .DIRECT_MAPPED_FEATURE        ( "DISABLED"                      ),
//        .L2_SIZE                      ( ariane_soc::L2SPMLength         ),
//        .ROM_BOOT_ADDR                ( 32'h1A000000                    ),
//        .BOOT_ADDR                    ( 32'hC0000000                    ),
//        .INSTR_RDATA_WIDTH            ( 32                              ),
//        .CLUST_FPU                    ( `CLUST_FPU                      ),
//        .CLUST_FP_DIVSQRT             ( `CLUST_FP_DIVSQRT               ),
//        .CLUST_SHARED_FP              ( `CLUST_SHARED_FP                ),
//        .CLUST_SHARED_FP_DIVSQRT      ( `CLUST_SHARED_FP_DIVSQRT        ),
//        .AXI_ADDR_WIDTH               ( AXI_ADDRESS_WIDTH               ),
//        .AXI_DATA_IN_WIDTH            ( AXI_DATA_WIDTH                  ),
//        .AXI_DATA_OUT_WIDTH           ( AXI_DATA_WIDTH                  ),
//        .AXI_USER_WIDTH               ( AXI_USER_WIDTH                  ),
//        .AXI_ID_IN_WIDTH              ( ariane_soc::SocToClusterIdWidth ),
//        .AXI_ID_OUT_WIDTH             ( ariane_soc::IdWidth             ),
//        .LOG_DEPTH                    ( 3                               ),
//        .DATA_WIDTH                   ( 32                              ),
//        .ADDR_WIDTH                   ( 32                              ),
//        .LOG_CLUSTER                  ( 3                               ),
//        .PE_ROUTING_LSB               ( 10                              ),
//        .EVNT_WIDTH                   ( 8                               )
//    )    
    cluster_i
    (
        .clk_i                        ( s_cluster_clk                ),
        .rst_ni                       ( s_cluster_rst_n              ),
        .ref_clk_i                    ( s_rtc_i                      ),

        .pmu_mem_pwdn_i               ( 1'b0                         ),
        
        .base_addr_i                  ( '0                           ),
       
        .dma_pe_evt_ack_i             ( s_dma_pe_evt_ack             ),
        .dma_pe_evt_valid_o           ( s_dma_pe_evt_valid           ),

        .dma_pe_irq_ack_i             ( 1'b1                         ),
        .dma_pe_irq_valid_o           (                              ),

        .dbg_irq_valid_i              ( '0                           ),

        .pf_evt_ack_i                 ( 1'b1                         ),
        .pf_evt_valid_o               (                              ),

        .async_cluster_events_wptr_i  ( '0  ),
        .async_cluster_events_rptr_o  (     ),
        .async_cluster_events_data_i  ( '0  ),

        .en_sa_boot_i                 ( s_cluster_en_sa_boot         ),
        .test_mode_i                  ( 1'b0                         ),
        .fetch_en_i                   ( s_cluster_fetch_en           ),
        .eoc_o                        (                              ),
        .busy_o                       (                              ),
        .cluster_id_i                 ( 6'b000000                    ),

        .async_data_master_aw_wptr_o  ( async_cluster_to_soc_axi_bus.aw_wptr  ),
        .async_data_master_aw_rptr_i  ( async_cluster_to_soc_axi_bus.aw_rptr  ),
        .async_data_master_aw_data_o  ( async_cluster_to_soc_axi_bus.aw_data  ),
        .async_data_master_ar_wptr_o  ( async_cluster_to_soc_axi_bus.ar_wptr  ),
        .async_data_master_ar_rptr_i  ( async_cluster_to_soc_axi_bus.ar_rptr  ),
        .async_data_master_ar_data_o  ( async_cluster_to_soc_axi_bus.ar_data  ),
        .async_data_master_w_data_o   ( async_cluster_to_soc_axi_bus.w_data   ),
        .async_data_master_w_wptr_o   ( async_cluster_to_soc_axi_bus.w_wptr   ),
        .async_data_master_w_rptr_i   ( async_cluster_to_soc_axi_bus.w_rptr   ),
        .async_data_master_r_wptr_i   ( async_cluster_to_soc_axi_bus.r_wptr   ),
        .async_data_master_r_rptr_o   ( async_cluster_to_soc_axi_bus.r_rptr   ),
        .async_data_master_r_data_i   ( async_cluster_to_soc_axi_bus.r_data   ),
        .async_data_master_b_wptr_i   ( async_cluster_to_soc_axi_bus.b_wptr   ),
        .async_data_master_b_rptr_o   ( async_cluster_to_soc_axi_bus.b_rptr   ),
        .async_data_master_b_data_i   ( async_cluster_to_soc_axi_bus.b_data   ),

        .async_cfg_master_aw_wptr_o   ( async_cfg_axi_bus.aw_wptr             ),
        .async_cfg_master_aw_rptr_i   ( async_cfg_axi_bus.aw_rptr             ),
        .async_cfg_master_aw_data_o   ( async_cfg_axi_bus.aw_data             ),
        .async_cfg_master_ar_wptr_o   ( async_cfg_axi_bus.ar_wptr             ),
        .async_cfg_master_ar_rptr_i   ( async_cfg_axi_bus.ar_rptr             ),
        .async_cfg_master_ar_data_o   ( async_cfg_axi_bus.ar_data             ),
        .async_cfg_master_w_data_o    ( async_cfg_axi_bus.w_data              ),
        .async_cfg_master_w_wptr_o    ( async_cfg_axi_bus.w_wptr              ),
        .async_cfg_master_w_rptr_i    ( async_cfg_axi_bus.w_rptr              ),
        .async_cfg_master_r_wptr_i    ( async_cfg_axi_bus.r_wptr              ),
        .async_cfg_master_r_rptr_o    ( async_cfg_axi_bus.r_rptr              ),
        .async_cfg_master_r_data_i    ( async_cfg_axi_bus.r_data              ),
        .async_cfg_master_b_wptr_i    ( async_cfg_axi_bus.b_wptr              ),
        .async_cfg_master_b_rptr_o    ( async_cfg_axi_bus.b_rptr              ),
        .async_cfg_master_b_data_i    ( async_cfg_axi_bus.b_data              ),
     
        .async_data_slave_aw_wptr_i   ( async_soc_to_cluster_axi_bus.aw_wptr  ),
        .async_data_slave_aw_rptr_o   ( async_soc_to_cluster_axi_bus.aw_rptr  ),
        .async_data_slave_aw_data_i   ( async_soc_to_cluster_axi_bus.aw_data  ),
        .async_data_slave_ar_wptr_i   ( async_soc_to_cluster_axi_bus.ar_wptr  ),
        .async_data_slave_ar_rptr_o   ( async_soc_to_cluster_axi_bus.ar_rptr  ),
        .async_data_slave_ar_data_i   ( async_soc_to_cluster_axi_bus.ar_data  ),
        .async_data_slave_w_data_i    ( async_soc_to_cluster_axi_bus.w_data   ),
        .async_data_slave_w_wptr_i    ( async_soc_to_cluster_axi_bus.w_wptr   ),
        .async_data_slave_w_rptr_o    ( async_soc_to_cluster_axi_bus.w_rptr   ),
        .async_data_slave_r_wptr_o    ( async_soc_to_cluster_axi_bus.r_wptr   ),
        .async_data_slave_r_rptr_i    ( async_soc_to_cluster_axi_bus.r_rptr   ),
        .async_data_slave_r_data_o    ( async_soc_to_cluster_axi_bus.r_data   ),
        .async_data_slave_b_wptr_o    ( async_soc_to_cluster_axi_bus.b_wptr   ),
        .async_data_slave_b_rptr_i    ( async_soc_to_cluster_axi_bus.b_rptr   ),
        .async_data_slave_b_data_o    ( async_soc_to_cluster_axi_bus.b_data   )
   );

  /**************************************************************************************************/
  /*                                      BEGIN AXI TLBs REGION                                     */
  /**************************************************************************************************/
  localparam int unsigned N_CLUSTERS = 1;
  localparam int unsigned ENTRIES = 32;

  typedef logic [AXI_ADDRESS_WIDTH-1:0       ] addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0          ] data_t;
  typedef logic [(AXI_DATA_WIDTH/8)-1:0      ] strb_t;
  typedef logic [AXI_USER_WIDTH-1:0          ] id_usr_t;
  typedef logic [ariane_soc::IdWidthSlave-1:0] id_slv_t;
  // AXI-Lite Interface Types
  typedef logic [AXI_LITE_AW-1:0]   lite_addr_t;
  typedef logic [AXI_LITE_DW-1:0]   lite_data_t;
  typedef logic [AXI_LITE_DW/8-1:0] lite_strb_t;

  `AXI_TYPEDEF_AW_CHAN_T ( aw_chan_t,  addr_t,    id_slv_t, id_usr_t  )
  `AXI_TYPEDEF_W_CHAN_T  ( w_chan_t,   data_t,    strb_t,   id_usr_t  )
  `AXI_TYPEDEF_B_CHAN_T  ( b_chan_t,   id_slv_t,  id_usr_t            )
  `AXI_TYPEDEF_AR_CHAN_T ( ar_chan_t,  addr_t,    id_slv_t, id_usr_t  )
  `AXI_TYPEDEF_R_CHAN_T  ( r_chan_t,   data_t,    id_slv_t, id_usr_t  )
  `AXI_TYPEDEF_REQ_T     ( axi_req_t,  aw_chan_t, w_chan_t, ar_chan_t )
  `AXI_TYPEDEF_RESP_T    ( axi_resp_t, b_chan_t,  r_chan_t            )

  // Passed as parameters to the axi_lite_xbar
  `AXI_LITE_TYPEDEF_AW_CHAN_T ( aw_chan_lite_t , lite_addr_t                                   )
  `AXI_LITE_TYPEDEF_W_CHAN_T  ( w_chan_lite_t  , lite_data_t   , lite_strb_t                   )
  `AXI_LITE_TYPEDEF_B_CHAN_T  ( b_chan_lite_t                                                  )
  `AXI_LITE_TYPEDEF_AR_CHAN_T ( ar_chan_lite_t , lite_addr_t                                   )
  `AXI_LITE_TYPEDEF_R_CHAN_T  ( r_chan_lite_t  , lite_data_t                                   )
  `AXI_LITE_TYPEDEF_REQ_T     ( axi_lite_req_t , aw_chan_lite_t, w_chan_lite_t, ar_chan_lite_t )
  `AXI_LITE_TYPEDEF_RESP_T    ( axi_lite_resp_t, b_chan_lite_t , r_chan_lite_t                 )

  axi_lite_req_t  h2c_tlb_cfg_req,
                  c2h_tlb_cfg_req,
                  h2c_tlb_cfg_lite_req,
                  c2h_tlb_cfg_lite_req;
   
  axi_lite_resp_t h2c_tlb_cfg_resp,
                  c2h_tlb_cfg_resp,
                  h2c_tlb_cfg_lite_resp,
                  c2h_tlb_cfg_lite_resp;

  localparam axi_pkg::xbar_cfg_t FromHostTlbCfgXbarCfg = '{
    NoSlvPorts:  2,
    NoMstPorts:  2,
    MaxMstTrans: 1,
    MaxSlvTrans: 1,
    FallThrough: 0,
    LatencyMode: axi_pkg::CUT_SLV_AX,
    AxiIdWidthSlvPorts: 1,
    AxiIdUsedSlvPorts: 1, 
    UniqueIds   : 0,
    AxiAddrWidth: AXI_LITE_AW,
    AxiDataWidth: AXI_LITE_DW,
    NoAddrRules: 2
  };

  typedef axi_pkg::xbar_rule_32_t tlb_cfg_xbar_rule_t;
  initial assert (AXI_LITE_AW == 32)
    else $fatal(1, "Change `tlb_cfg_xbar_rule_t` for address width other than 32 bit!");
  localparam tlb_cfg_xbar_rule_t [FromHostTlbCfgXbarCfg.NoAddrRules-1:0]
      FromHostTlbCfgXbarAddrMap = '{
    '{idx: 32'd1, start_addr: 32'h5000_1000, end_addr: 32'h5000_2000},
    '{idx: 32'd0, start_addr: 32'h5000_0000, end_addr: 32'h5000_1000}
  };

  `AXI_LITE_ASSIGN_TO_REQ    ( h2c_tlb_cfg_lite_req, tlb_cfg_lite_master   )
  `AXI_LITE_ASSIGN_FROM_RESP ( tlb_cfg_lite_master , h2c_tlb_cfg_lite_resp )

  `AXI_LITE_ASSIGN_TO_REQ    ( c2h_tlb_cfg_lite_req, c2h_tlb_cfg_lite      )
  `AXI_LITE_ASSIGN_FROM_RESP ( c2h_tlb_cfg_lite    , c2h_tlb_cfg_lite_resp )

  axi_lite_xbar #(
     .Cfg                   ( FromHostTlbCfgXbarCfg ),
     .aw_chan_t             ( aw_chan_lite_t        ),
     .w_chan_t              ( w_chan_lite_t         ),
     .b_chan_t              ( b_chan_lite_t         ),
     .ar_chan_t             ( ar_chan_lite_t        ),
     .r_chan_t              ( r_chan_lite_t         ),
     .req_t                 ( axi_lite_req_t        ),
     .resp_t                ( axi_lite_resp_t       ),
     .rule_t                ( tlb_cfg_xbar_rule_t   )
   ) i_tlb_cfg_xbar         (
     .clk_i                 ( s_soc_clk                                      ),
     .rst_ni                ( s_soc_rst_n                                    ),
     .test_i                ( 1'b0                                           ),
     .slv_ports_req_i       ( {c2h_tlb_cfg_lite_req , h2c_tlb_cfg_lite_req } ), 
     .slv_ports_resp_o      ( {c2h_tlb_cfg_lite_resp, h2c_tlb_cfg_lite_resp} ), 
     .mst_ports_req_o       ( {c2h_tlb_cfg_req ,      h2c_tlb_cfg_req }      ),
     .mst_ports_resp_i      ( {c2h_tlb_cfg_resp,      h2c_tlb_cfg_resp}      ),
     .addr_map_i            ( FromHostTlbCfgXbarAddrMap                      ),
     .en_default_mst_port_i ( {1'b0, 1'b0}                                   ),
     .default_mst_port_i    ( {1'b0, 1'b0}                                   )
   );

  `AXI_LITE_ASSIGN_FROM_REQ ( h2c_tlb_cfg     , h2c_tlb_cfg_req )
  `AXI_LITE_ASSIGN_TO_RESP  ( h2c_tlb_cfg_resp, h2c_tlb_cfg     )

  axi_tlb_intf #(
    .AXI_SLV_PORT_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_MST_PORT_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH          ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH            ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH          ( AXI_USER_WIDTH           ),
    .AXI_SLV_PORT_MAX_TXNS   ( 1                        ), 
    .CFG_AXI_ADDR_WIDTH      ( AXI_LITE_AW              ),
    .CFG_AXI_DATA_WIDTH      ( AXI_LITE_DW              ),
    .L1_NUM_ENTRIES          ( ENTRIES                  ), 
    .L1_CUT_AX               ( 1                        )
  ) i_h2c_tlb                (
    .clk_i                   ( s_soc_clk                ),
    .rst_ni                  ( s_soc_rst_n              ),
    .test_en_i               ( 1'b0                     ),
    .slv                     ( soc_to_tlb_axi_bus       ),
    .mst                     ( tlb_to_cluster_axi_bus   ),
    .cfg                     ( h2c_tlb_cfg              )
  ); 

   `AXI_LITE_ASSIGN_FROM_REQ ( c2h_tlb_cfg     , c2h_tlb_cfg_req )
   `AXI_LITE_ASSIGN_TO_RESP  ( c2h_tlb_cfg_resp, c2h_tlb_cfg     )
   
   axi_tlb_intf #(
     .AXI_SLV_PORT_ADDR_WIDTH ( AXI_ADDRESS_WIDTH      ),
     .AXI_MST_PORT_ADDR_WIDTH ( AXI_ADDRESS_WIDTH      ),
     .AXI_DATA_WIDTH          ( AXI_DATA_WIDTH         ),
     .AXI_ID_WIDTH            ( ariane_soc::IdWidth    ),
     .AXI_USER_WIDTH          ( AXI_USER_WIDTH         ),
     .AXI_SLV_PORT_MAX_TXNS   ( 1                      ), 
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
  
  /**************************************************************************************************/
  /*                                       END AXI TLB REGION                                       */
  /**************************************************************************************************/
  `REG_BUS_ASSIGN_TO_REQ(reg_req,i_padframecfg_rbus)
  `REG_BUS_ASSIGN_FROM_RSP(i_padframecfg_rbus,reg_rsp)

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
      .pad_periphs_pad_gpio_b_14_pad(pad_periphs_pad_gpio_b_14_pad),
      .pad_periphs_pad_gpio_b_15_pad(pad_periphs_pad_gpio_b_15_pad),
      .pad_periphs_pad_gpio_b_16_pad(pad_periphs_pad_gpio_b_16_pad),
      .pad_periphs_pad_gpio_b_17_pad(pad_periphs_pad_gpio_b_17_pad),
      .pad_periphs_pad_gpio_b_18_pad(pad_periphs_pad_gpio_b_18_pad),
      .pad_periphs_pad_gpio_b_19_pad(pad_periphs_pad_gpio_b_19_pad),
      .pad_periphs_pad_gpio_b_20_pad(pad_periphs_pad_gpio_b_20_pad),
      .pad_periphs_pad_gpio_b_21_pad(pad_periphs_pad_gpio_b_21_pad),
      .pad_periphs_pad_gpio_b_22_pad(pad_periphs_pad_gpio_b_22_pad),
      .pad_periphs_pad_gpio_b_23_pad(pad_periphs_pad_gpio_b_23_pad),
      .pad_periphs_pad_gpio_b_24_pad(pad_periphs_pad_gpio_b_24_pad),
      .pad_periphs_pad_gpio_b_25_pad(pad_periphs_pad_gpio_b_25_pad),
      .pad_periphs_pad_gpio_b_26_pad(pad_periphs_pad_gpio_b_26_pad),
      .pad_periphs_pad_gpio_b_27_pad(pad_periphs_pad_gpio_b_27_pad),
      .pad_periphs_pad_gpio_b_28_pad(pad_periphs_pad_gpio_b_28_pad),
      .pad_periphs_pad_gpio_b_29_pad(pad_periphs_pad_gpio_b_29_pad), 
      .pad_periphs_pad_gpio_b_30_pad(pad_periphs_pad_gpio_b_30_pad),
      .pad_periphs_pad_gpio_b_31_pad(pad_periphs_pad_gpio_b_31_pad),
      .pad_periphs_pad_gpio_b_32_pad(pad_periphs_pad_gpio_b_32_pad),
      .pad_periphs_pad_gpio_b_33_pad(pad_periphs_pad_gpio_b_33_pad),
      .pad_periphs_pad_gpio_b_34_pad(pad_periphs_pad_gpio_b_34_pad),
      .pad_periphs_pad_gpio_b_35_pad(pad_periphs_pad_gpio_b_35_pad),
      .pad_periphs_pad_gpio_b_36_pad(pad_periphs_pad_gpio_b_36_pad),
      .pad_periphs_pad_gpio_b_37_pad(pad_periphs_pad_gpio_b_37_pad),
      .pad_periphs_pad_gpio_b_38_pad(pad_periphs_pad_gpio_b_38_pad),
      .pad_periphs_pad_gpio_b_39_pad(pad_periphs_pad_gpio_b_39_pad),
      .pad_periphs_pad_gpio_b_40_pad(pad_periphs_pad_gpio_b_40_pad),
      .pad_periphs_pad_gpio_b_41_pad(pad_periphs_pad_gpio_b_41_pad),
      .pad_periphs_pad_gpio_b_42_pad(pad_periphs_pad_gpio_b_42_pad),
      .pad_periphs_pad_gpio_b_43_pad(pad_periphs_pad_gpio_b_43_pad),
      .pad_periphs_pad_gpio_b_44_pad(pad_periphs_pad_gpio_b_44_pad),
      .pad_periphs_pad_gpio_b_45_pad(pad_periphs_pad_gpio_b_45_pad),
      .pad_periphs_pad_gpio_b_46_pad(pad_periphs_pad_gpio_b_46_pad),
      .pad_periphs_pad_gpio_b_47_pad(pad_periphs_pad_gpio_b_47_pad),
      .pad_periphs_pad_gpio_b_48_pad(pad_periphs_pad_gpio_b_48_pad),
      .pad_periphs_pad_gpio_b_49_pad(pad_periphs_pad_gpio_b_49_pad),
      .pad_periphs_pad_gpio_b_50_pad(pad_periphs_pad_gpio_b_50_pad),
      .pad_periphs_pad_gpio_b_51_pad(pad_periphs_pad_gpio_b_51_pad),
      .pad_periphs_pad_gpio_b_52_pad(pad_periphs_pad_gpio_b_52_pad),
      .pad_periphs_pad_gpio_b_53_pad(pad_periphs_pad_gpio_b_53_pad),
      .pad_periphs_pad_gpio_b_54_pad(pad_periphs_pad_gpio_b_54_pad),
      .pad_periphs_pad_gpio_b_55_pad(pad_periphs_pad_gpio_b_55_pad),
      .pad_periphs_pad_gpio_b_56_pad(pad_periphs_pad_gpio_b_56_pad),
      .pad_periphs_pad_gpio_b_57_pad(pad_periphs_pad_gpio_b_57_pad),
      .pad_periphs_pad_gpio_b_58_pad(pad_periphs_pad_gpio_b_58_pad),
      .pad_periphs_pad_gpio_b_59_pad(pad_periphs_pad_gpio_b_59_pad),
      .pad_periphs_pad_gpio_b_60_pad(pad_periphs_pad_gpio_b_60_pad),
      .pad_periphs_pad_gpio_b_61_pad(pad_periphs_pad_gpio_b_61_pad),
      
      .pad_periphs_pad_gpio_c_00_pad(pad_periphs_pad_gpio_c_00_pad),
      .pad_periphs_pad_gpio_c_01_pad(pad_periphs_pad_gpio_c_01_pad),
      .pad_periphs_pad_gpio_c_02_pad(pad_periphs_pad_gpio_c_02_pad),
      .pad_periphs_pad_gpio_c_03_pad(pad_periphs_pad_gpio_c_03_pad),

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

      .pad_periphs_pad_gpio_e_00_pad(pad_periphs_pad_gpio_e_00_pad),
      .pad_periphs_pad_gpio_e_01_pad(pad_periphs_pad_gpio_e_01_pad),
      .pad_periphs_pad_gpio_e_02_pad(pad_periphs_pad_gpio_e_02_pad),
      .pad_periphs_pad_gpio_e_03_pad(pad_periphs_pad_gpio_e_03_pad),
      .pad_periphs_pad_gpio_e_04_pad(pad_periphs_pad_gpio_e_04_pad),
      .pad_periphs_pad_gpio_e_05_pad(pad_periphs_pad_gpio_e_05_pad),
      .pad_periphs_pad_gpio_e_06_pad(pad_periphs_pad_gpio_e_06_pad),
      .pad_periphs_pad_gpio_e_07_pad(pad_periphs_pad_gpio_e_07_pad),
      .pad_periphs_pad_gpio_e_08_pad(pad_periphs_pad_gpio_e_08_pad),
      .pad_periphs_pad_gpio_e_09_pad(pad_periphs_pad_gpio_e_09_pad),
      .pad_periphs_pad_gpio_e_10_pad(pad_periphs_pad_gpio_e_10_pad),
      .pad_periphs_pad_gpio_e_11_pad(pad_periphs_pad_gpio_e_11_pad),
      .pad_periphs_pad_gpio_e_12_pad(pad_periphs_pad_gpio_e_12_pad),
      
      .pad_periphs_pad_gpio_f_00_pad(pad_periphs_pad_gpio_f_00_pad),
      .pad_periphs_pad_gpio_f_01_pad(pad_periphs_pad_gpio_f_01_pad),
      .pad_periphs_pad_gpio_f_02_pad(pad_periphs_pad_gpio_f_02_pad),
      .pad_periphs_pad_gpio_f_03_pad(pad_periphs_pad_gpio_f_03_pad),
      .pad_periphs_pad_gpio_f_04_pad(pad_periphs_pad_gpio_f_04_pad),
      .pad_periphs_pad_gpio_f_05_pad(pad_periphs_pad_gpio_f_05_pad),
      .pad_periphs_pad_gpio_f_06_pad(pad_periphs_pad_gpio_f_06_pad),
      .pad_periphs_pad_gpio_f_07_pad(pad_periphs_pad_gpio_f_07_pad),
      .pad_periphs_pad_gpio_f_08_pad(pad_periphs_pad_gpio_f_08_pad),
      .pad_periphs_pad_gpio_f_09_pad(pad_periphs_pad_gpio_f_09_pad),
      .pad_periphs_pad_gpio_f_10_pad(pad_periphs_pad_gpio_f_10_pad),
      .pad_periphs_pad_gpio_f_11_pad(pad_periphs_pad_gpio_f_11_pad),
      .pad_periphs_pad_gpio_f_12_pad(pad_periphs_pad_gpio_f_12_pad),
      .pad_periphs_pad_gpio_f_13_pad(pad_periphs_pad_gpio_f_13_pad),
      .pad_periphs_pad_gpio_f_14_pad(pad_periphs_pad_gpio_f_14_pad),
      .pad_periphs_pad_gpio_f_15_pad(pad_periphs_pad_gpio_f_15_pad),
      .pad_periphs_pad_gpio_f_16_pad(pad_periphs_pad_gpio_f_16_pad),
      .pad_periphs_pad_gpio_f_17_pad(pad_periphs_pad_gpio_f_17_pad),
      .pad_periphs_pad_gpio_f_18_pad(pad_periphs_pad_gpio_f_18_pad),
      .pad_periphs_pad_gpio_f_19_pad(pad_periphs_pad_gpio_f_19_pad),
      .pad_periphs_pad_gpio_f_20_pad(pad_periphs_pad_gpio_f_20_pad),
      .pad_periphs_pad_gpio_f_21_pad(pad_periphs_pad_gpio_f_21_pad),
      .pad_periphs_pad_gpio_f_22_pad(pad_periphs_pad_gpio_f_22_pad),
      .pad_periphs_pad_gpio_f_23_pad(pad_periphs_pad_gpio_f_23_pad),
      .pad_periphs_pad_gpio_f_24_pad(pad_periphs_pad_gpio_f_24_pad),
      .pad_periphs_pad_gpio_f_25_pad(pad_periphs_pad_gpio_f_25_pad),
      
      .pad_periphs_pad_gpio_pwm0_pad(pad_periphs_pad_gpio_pwm0_pad),
      .pad_periphs_pad_gpio_pwm1_pad(pad_periphs_pad_gpio_pwm1_pad),
      .pad_periphs_pad_gpio_pwm2_pad(pad_periphs_pad_gpio_pwm2_pad),
      .pad_periphs_pad_gpio_pwm3_pad(pad_periphs_pad_gpio_pwm3_pad),
      .pad_periphs_pad_gpio_pwm4_pad(pad_periphs_pad_gpio_pwm4_pad),
      .pad_periphs_pad_gpio_pwm5_pad(pad_periphs_pad_gpio_pwm5_pad),
      .pad_periphs_pad_gpio_pwm6_pad(pad_periphs_pad_gpio_pwm6_pad),
      .pad_periphs_pad_gpio_pwm7_pad(pad_periphs_pad_gpio_pwm7_pad),

      .config_req_i   ( reg_req     ),
      .config_rsp_o   ( reg_rsp     )      
      );
  
   `ASSIGN_PERIPHS_SPI0_PAD2SOC(s_pad_to_qspi[0],s_port_signals_pad2soc.periphs.spi0)
   `ASSIGN_PERIPHS_SPI0_SOC2PAD(s_port_signals_soc2pad.periphs.spi0,s_qspi_to_pad[0])

   `ASSIGN_PERIPHS_SPI1_PAD2SOC(s_pad_to_qspi[1],s_port_signals_pad2soc.periphs.spi1)
   `ASSIGN_PERIPHS_SPI1_SOC2PAD(s_port_signals_soc2pad.periphs.spi1,s_qspi_to_pad[1])

   `ASSIGN_PERIPHS_SPI2_PAD2SOC(s_pad_to_qspi[2],s_port_signals_pad2soc.periphs.spi2)
   `ASSIGN_PERIPHS_SPI2_SOC2PAD(s_port_signals_soc2pad.periphs.spi2,s_qspi_to_pad[2])

   `ASSIGN_PERIPHS_SPI3_PAD2SOC(s_pad_to_qspi[3],s_port_signals_pad2soc.periphs.spi3)
   `ASSIGN_PERIPHS_SPI3_SOC2PAD(s_port_signals_soc2pad.periphs.spi3,s_qspi_to_pad[3])

   `ASSIGN_PERIPHS_SPI4_PAD2SOC(s_pad_to_qspi[4],s_port_signals_pad2soc.periphs.spi4)
   `ASSIGN_PERIPHS_SPI4_SOC2PAD(s_port_signals_soc2pad.periphs.spi4,s_qspi_to_pad[4])

   `ASSIGN_PERIPHS_SPI5_PAD2SOC(s_pad_to_qspi[5],s_port_signals_pad2soc.periphs.spi5)
   `ASSIGN_PERIPHS_SPI5_SOC2PAD(s_port_signals_soc2pad.periphs.spi5,s_qspi_to_pad[5])  

   `ASSIGN_PERIPHS_SPI6_PAD2SOC(s_pad_to_qspi[6],s_port_signals_pad2soc.periphs.spi6)
   `ASSIGN_PERIPHS_SPI6_SOC2PAD(s_port_signals_soc2pad.periphs.spi6,s_qspi_to_pad[6])
   
   `ASSIGN_PERIPHS_QSPI_PAD2SOC(s_pad_to_qspi[11],s_port_signals_pad2soc.periphs.qspi)
   `ASSIGN_PERIPHS_QSPI_SOC2PAD(s_port_signals_soc2pad.periphs.qspi,s_qspi_to_pad[11])

   `ASSIGN_PERIPHS_SDIO0_PAD2SOC(s_pad_to_sdio[0],s_port_signals_pad2soc.periphs.sdio0)
   `ASSIGN_PERIPHS_SDIO0_SOC2PAD(s_port_signals_soc2pad.periphs.sdio0,s_sdio_to_pad[0])

   `ASSIGN_PERIPHS_UART0_PAD2SOC(s_pad_to_uart[0],s_port_signals_pad2soc.periphs.uart0)
   `ASSIGN_PERIPHS_UART0_SOC2PAD(s_port_signals_soc2pad.periphs.uart0,s_uart_to_pad[0])

   `ASSIGN_PERIPHS_UART1_PAD2SOC(s_pad_to_uart[1],s_port_signals_pad2soc.periphs.uart1)
   `ASSIGN_PERIPHS_UART1_SOC2PAD(s_port_signals_soc2pad.periphs.uart1,s_uart_to_pad[1])
   
   `ASSIGN_PERIPHS_UART2_PAD2SOC(s_pad_to_uart[2],s_port_signals_pad2soc.periphs.uart2)
   `ASSIGN_PERIPHS_UART2_SOC2PAD(s_port_signals_soc2pad.periphs.uart2,s_uart_to_pad[2])
   
   `ASSIGN_PERIPHS_UART3_PAD2SOC(s_pad_to_uart[3],s_port_signals_pad2soc.periphs.uart3)
   `ASSIGN_PERIPHS_UART3_SOC2PAD(s_port_signals_soc2pad.periphs.uart3,s_uart_to_pad[3])
  
   `ASSIGN_PERIPHS_UART4_PAD2SOC(s_pad_to_uart[4],s_port_signals_pad2soc.periphs.uart4)
   `ASSIGN_PERIPHS_UART4_SOC2PAD(s_port_signals_soc2pad.periphs.uart4,s_uart_to_pad[4])   

   `ASSIGN_PERIPHS_I2C0_PAD2SOC(s_pad_to_i2c[0],s_port_signals_pad2soc.periphs.i2c0)
   `ASSIGN_PERIPHS_I2C0_SOC2PAD(s_port_signals_soc2pad.periphs.i2c0,s_i2c_to_pad[0])

   `ASSIGN_PERIPHS_I2C4_PAD2SOC(s_pad_to_i2c[4],s_port_signals_pad2soc.periphs.i2c4)
   `ASSIGN_PERIPHS_I2C4_SOC2PAD(s_port_signals_soc2pad.periphs.i2c4,s_i2c_to_pad[4])

   `ASSIGN_PERIPHS_I2C5_PAD2SOC(s_pad_to_i2c[5],s_port_signals_pad2soc.periphs.i2c5)
   `ASSIGN_PERIPHS_I2C5_SOC2PAD(s_port_signals_soc2pad.periphs.i2c5,s_i2c_to_pad[5])

   `ASSIGN_PERIPHS_GPIO_B_PAD2SOC(s_pad_to_gpio_b,s_port_signals_pad2soc.periphs.gpio_b)
   `ASSIGN_PERIPHS_GPIO_B_SOC2PAD(s_port_signals_soc2pad.periphs.gpio_b,s_gpio_b_to_pad)

   `ASSIGN_PERIPHS_PWM_SOC2PAD(s_port_signals_soc2pad.periphs.pwm,s_pwm_to_pad)

   `ASSIGN_PERIPHS_SPI7_PAD2SOC(s_pad_to_qspi[7],s_port_signals_pad2soc.periphs.spi7)
   `ASSIGN_PERIPHS_SPI7_SOC2PAD(s_port_signals_soc2pad.periphs.spi7,s_qspi_to_pad[7])

   //CAN0

   //CAN1

   `ASSIGN_PERIPHS_I2C1_PAD2SOC(s_pad_to_i2c[1],s_port_signals_pad2soc.periphs.i2c1)
   `ASSIGN_PERIPHS_I2C1_SOC2PAD(s_port_signals_soc2pad.periphs.i2c1,s_i2c_to_pad[1])

   `ASSIGN_PERIPHS_I2C2_PAD2SOC(s_pad_to_i2c[2],s_port_signals_pad2soc.periphs.i2c2)
   `ASSIGN_PERIPHS_I2C2_SOC2PAD(s_port_signals_soc2pad.periphs.i2c2,s_i2c_to_pad[2])

   `ASSIGN_PERIPHS_I2C3_PAD2SOC(s_pad_to_i2c[3],s_port_signals_pad2soc.periphs.i2c3)
   `ASSIGN_PERIPHS_I2C3_SOC2PAD(s_port_signals_soc2pad.periphs.i2c3,s_i2c_to_pad[3])

   `ASSIGN_PERIPHS_CAM0_PAD2SOC(s_pad_to_cam[0],s_port_signals_pad2soc.periphs.cam0)

   `ASSIGN_PERIPHS_UART7_PAD2SOC(s_pad_to_uart[7],s_port_signals_pad2soc.periphs.uart7)
   `ASSIGN_PERIPHS_UART7_SOC2PAD(s_port_signals_soc2pad.periphs.uart7,s_uart_to_pad[7])

   `ASSIGN_PERIPHS_CAM1_PAD2SOC(s_pad_to_cam[1],s_port_signals_pad2soc.periphs.cam1)
      
   `ASSIGN_PERIPHS_SPI8_PAD2SOC(s_pad_to_qspi[8],s_port_signals_pad2soc.periphs.spi8)
   `ASSIGN_PERIPHS_SPI8_SOC2PAD(s_port_signals_soc2pad.periphs.spi8,s_qspi_to_pad[8])
   
   `ASSIGN_PERIPHS_SPI9_PAD2SOC(s_pad_to_qspi[9],s_port_signals_pad2soc.periphs.spi9)
   `ASSIGN_PERIPHS_SPI9_SOC2PAD(s_port_signals_soc2pad.periphs.spi9,s_qspi_to_pad[9])

   `ASSIGN_PERIPHS_SPI10_PAD2SOC(s_pad_to_qspi[10],s_port_signals_pad2soc.periphs.spi10)
   `ASSIGN_PERIPHS_SPI10_SOC2PAD(s_port_signals_soc2pad.periphs.spi10,s_qspi_to_pad[10])

   //ETH0

   `ASSIGN_PERIPHS_SDIO1_PAD2SOC(s_pad_to_sdio[1],s_port_signals_pad2soc.periphs.sdio1)
   `ASSIGN_PERIPHS_SDIO1_SOC2PAD(s_port_signals_soc2pad.periphs.sdio1,s_sdio_to_pad[1])

   `ASSIGN_PERIPHS_UART5_PAD2SOC(s_pad_to_uart[5],s_port_signals_pad2soc.periphs.uart5)
   `ASSIGN_PERIPHS_UART5_SOC2PAD(s_port_signals_soc2pad.periphs.uart5,s_uart_to_pad[5])
  
   `ASSIGN_PERIPHS_UART6_PAD2SOC(s_pad_to_uart[6],s_port_signals_pad2soc.periphs.uart6)
   `ASSIGN_PERIPHS_UART6_SOC2PAD(s_port_signals_soc2pad.periphs.uart6,s_uart_to_pad[6])

   //SERIAL LINK
   `ASSIGN_PERIPHS_DDR_LINK_PAD2SOC(s_pad_to_serial_link,s_port_signals_pad2soc.periphs.ddr_link)
   `ASSIGN_PERIPHS_DDR_LINK_SOC2PAD(s_port_signals_soc2pad.periphs.ddr_link,s_serial_link_to_pad)

  `endif   



   
endmodule

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

module apb_subsystem
  import apb_soc_pkg::*;
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
    input logic                 apb_uart_rx_i,
    output logic                apb_uart_tx_o,
    output logic                rstn_soc_sync_o,
    output logic                rstn_cva6_sync_o,
    output logic                rstn_global_sync_o,
    output logic                clk_cva6_o,
    output logic                clk_soc_o,
    output logic                clk_cluster_o,
    output logic                rstn_cluster_sync_o,
    output logic                cluster_en_sa_boot_o,
    output logic                cluster_fetch_en_o,
    input logic                 llc_read_hit_cache_i,
    input logic                 llc_read_miss_cache_i,
    input logic                 llc_write_hit_cache_i,
    input logic                 llc_write_miss_cache_i, 
  
    AXI_BUS.Slave               axi_apb_slave,
    AXI_BUS.Slave               hyper_axi_bus_slave,
    XBAR_TCDM_BUS.Master        udma_tcdm_channels[1:0],
    
    REG_BUS.out                 padframecfg_reg_master,
    REG_BUS.out                 serial_linkcfg_reg_master,

    output logic [31*4-1:0]     events_o,
    output logic                [N_CAN-1 : 0] can_irq_o,

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

    output                      pwm_to_pad_t pwm_to_pad
);

   logic                                s_clk_per;
   logic                                s_rstn_soc_sync;
   logic                                s_rstn_cluster_sync;
   logic                                s_cluster_ctrl_rstn;

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

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_advtimer_master_bus();
   
   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_padframe_master_bus();

   APB  #(
               .ADDR_WIDTH(32),
               .DATA_WIDTH(32)
   ) apb_serial_link_master_bus();

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

   periph_bus_wrap #(
                     )(
    .clk_i(clk_soc_o),
    .rst_ni(s_rstn_soc_sync),
    .apb_slave(apb_peripheral_master_bus),
    .udma_master(apb_udma_master_bus),
    .gpio_master(apb_gpio_master_bus),
    .fll_master(apb_fll_master_bus),
    .hyaxicfg_master(apb_hyaxicfg_master_bus),
    .advtimer_master(apb_advtimer_master_bus),
    .padframe_master(apb_padframe_master_bus),
    .serial_link_master (apb_serial_link_master_bus),
    .apb_can0_master (apb_can0_master_bus),
    .apb_can1_master (apb_can1_master_bus),
    .socctrl_master(apb_socctrl_master_bus),
    .apb_uart_master(apb_uart_master_bus)
    );

   if (InclUART) begin : gen_uart
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
       .SIN     ( apb_uart_rx_i                  ),
       .SOUT    ( apb_uart_tx_o                  )
     );
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

   assign apb_udma_address = apb_udma_master_bus.paddr ;
                            
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
                                                          
         .periph_clk_i    ( s_clk_per                     ),

         .hyper_axi_bus_slave ( hyper_axi_bus_slave       ),
         .hyper_reg_cfg_slave ( i_hyaxicfg_rbus           ),

         .L2_ro_wen_o     ( udma_tcdm_channels[0].wen     ),
         .L2_ro_req_o     ( udma_tcdm_channels[0].req     ),
         .L2_ro_gnt_i     ( udma_tcdm_channels[0].gnt     ),
         .L2_ro_addr_o    ( udma_tcdm_channels[0].add     ),
         .L2_ro_be_o      ( udma_tcdm_channels[0].be      ),
         .L2_ro_wdata_o   ( udma_tcdm_channels[0].wdata   ),
         .L2_ro_rvalid_i  ( udma_tcdm_channels[0].r_valid ),
         .L2_ro_rdata_i   ( udma_tcdm_channels[0].r_rdata ),

         .L2_wo_wen_o     ( udma_tcdm_channels[1].wen      ),
         .L2_wo_req_o     ( udma_tcdm_channels[1].req      ),
         .L2_wo_gnt_i     ( udma_tcdm_channels[1].gnt      ),
         .L2_wo_addr_o    ( udma_tcdm_channels[1].add      ),
         .L2_wo_wdata_o   ( udma_tcdm_channels[1].wdata    ),
         .L2_wo_be_o      ( udma_tcdm_channels[1].be       ),
         .L2_wo_rvalid_i  ( udma_tcdm_channels[1].r_valid  ),
         .L2_wo_rdata_i   ( udma_tcdm_channels[1].r_rdata  ),

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

         .qspi_to_pad     ( qspi_to_pad                    ),
         .pad_to_qspi     ( pad_to_qspi                    ),
         .i2c_to_pad      ( i2c_to_pad                     ),
         .pad_to_i2c      ( pad_to_i2c                     ),
  	     .pad_to_cam      ( pad_to_cam                     ),
         .pad_to_uart     ( pad_to_uart                    ),
         .uart_to_pad     ( uart_to_pad                    ),
         .sdio_to_pad     ( sdio_to_pad                    ),
         .pad_to_sdio     ( pad_to_sdio                    )
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
        .clk_cva6_o         ( clk_cva6_o          ),
        .clk_soc_o          ( clk_soc_o           ),
        .clk_per_o          ( s_clk_per           ),
        .clk_cluster_o      ( clk_cluster_o       )                 
       );

   
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
   
   logic [3:0]   pwm0_o;
   logic [3:0]   pwm1_o;
   
    apb_adv_timer #(
        .APB_ADDR_WIDTH ( 32             ),
        .EXTSIG_NUM     ( 64             )
    ) i_apb_adv_timer0 (
        .HCLK            ( s_clk_per               ),
        .HRESETn         ( s_rstn_soc_sync         ),

        .dft_cg_enable_i ( 1'b0                    ),

        .PADDR           ( apb_advtimer_master_bus.paddr   ),
        .PWDATA          ( apb_advtimer_master_bus.pwdata  ),
        .PWRITE          ( apb_advtimer_master_bus.pwrite  ),
        .PSEL            ( apb_advtimer_master_bus.psel    ),
        .PENABLE         ( apb_advtimer_master_bus.penable ),
        .PRDATA          ( apb_advtimer_master_bus.prdata  ),
        .PREADY          ( apb_advtimer_master_bus.pready  ),
        .PSLVERR         ( apb_advtimer_master_bus.pslverr ),

        .low_speed_clk_i ( rtc_i                   ),
        .ext_sig_i       ( s_gpio_sync             ),

        .events_o        (                         ),

        .ch_0_o          ( pwm0_o                  ),
        .ch_1_o          ( pwm1_o                  ),
        .ch_2_o          (                         ),
        .ch_3_o          (                         )
    );

   assign pwm_to_pad.pwm0_o = pwm0_o[0];
   assign pwm_to_pad.pwm1_o = pwm0_o[1];
   assign pwm_to_pad.pwm2_o = pwm0_o[2];
   assign pwm_to_pad.pwm3_o = pwm0_o[3];
   assign pwm_to_pad.pwm4_o = pwm1_o[0];
   assign pwm_to_pad.pwm5_o = pwm1_o[1];
   assign pwm_to_pad.pwm6_o = pwm1_o[2];
   assign pwm_to_pad.pwm7_o = pwm1_o[3];
   

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

    apb_to_reg i_apb_to_serial_link_cfg
     (
      .clk_i     ( clk_soc_o       ),
      .rst_ni    ( s_rstn_soc_sync ),
 
      .penable_i ( apb_serial_link_master_bus.penable ),
      .pwrite_i  ( apb_serial_link_master_bus.pwrite  ),
      .paddr_i   ( apb_serial_link_master_bus.paddr   ),
      .psel_i    ( apb_serial_link_master_bus.psel    ),
      .pwdata_i  ( apb_serial_link_master_bus.pwdata  ),
      .prdata_o  ( apb_serial_link_master_bus.prdata  ),
      .pready_o  ( apb_serial_link_master_bus.pready  ),
      .pslverr_o ( apb_serial_link_master_bus.pslverr ),

      .reg_o     ( serial_linkcfg_reg_master          )
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
    .llc_read_hit_cache_i(llc_read_hit_cache_i),
    .llc_read_miss_cache_i(llc_read_miss_cache_i), 
    .llc_write_hit_cache_i(llc_write_hit_cache_i),
    .llc_write_miss_cache_i(llc_write_miss_cache_i)
   );
   

endmodule

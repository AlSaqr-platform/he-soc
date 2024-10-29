// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Xilinx Peripehrals

`include "register_interface/assign.svh"
`include "register_interface/typedef.svh"
`include "axi/assign.svh"
`include "axi/typedef.svh"
`define APMU_IP

module ariane_peripherals
    import udma_subsystem_pkg::N_CAN;
    import apb_soc_pkg::NUM_ADV_TIMER;
    import ariane_soc::*;
#(
    parameter  int NumCVA6      = -1,
    parameter  int AxiAddrWidth = -1,
    parameter  int AxiDataWidth = -1,
    parameter  int AxiIdWidth   = -1,
    parameter  int AxiUserWidth = 1,
    parameter  int APMU_NUM_COUNTER = 0,
    parameter  bit InclUART     = 1,
    parameter  bit InclSPI      = 0,
    parameter  bit InclEthernet = 1,
    parameter  bit InclGPIO     = 0,
    parameter  bit InclTimer    = 1,
    parameter  bit InclSDMA     = 0,
    parameter  bit InclIOMMU    = 0,
    parameter  bit InclMDMA     = 0,
    parameter  bit InclIOPMP    = 0
) (
    input  logic                                              clk_i            , // Clock
    input  logic                                              rst_ni           , // Asynchronous reset active low
    AXI_BUS.Slave                                             plic             ,
    AXI_BUS.Slave                                             uart             ,
    AXI_BUS.Slave                                             spi              ,
    AXI_BUS.Slave                                             timer            ,
    AXI_BUS.Slave                                             eth_config       ,
    AXI_BUS.Master                                            eth_idma         ,

    // IOMMU
    AXI_BUS.Slave                                             sdma_cfg         ,
    AXI_BUS.Master                                            iommu_comp       ,
    AXI_BUS.Master                                            iommu_ds         ,
    AXI_BUS.Slave                                             iommu_cfg        ,

    // IOPMP
    AXI_BUS.Slave                                             mdma_cfg         ,
    AXI_BUS.Master                                            iopmp_init       ,
    AXI_BUS.Slave                                             iopmp_cfg        ,

    // IMSIC
    AXI_BUS.Slave                                             imsic            ,
    input  imsic_pkg::csr_channel_to_imsic_t   [NumCVA6-1:0]  imsic_csr_i      ,
    output imsic_pkg::csr_channel_from_imsic_t [NumCVA6-1:0]  imsic_csr_o      ,
    output logic [NumCVA6-1:0][ariane_soc::NrIntpFiles-1:0]   irq_o            ,
    input  logic [31*4-1:0]                                   udma_evt_i       ,
    input  logic                                              c2h_irq_i        ,
    input  logic [NUM_GPIO-1:0]                               gpio_irq_i       ,
    input  logic                                              cluster_eoc_i    ,
    input  logic [N_CAN-1:0]                                  can_irq_i        ,
    input  logic [NUM_ADV_TIMER-1:0]                          pwm_irq_i        ,
    input  logic                                              cl_dma_pe_evt_i  ,

    // APMU
    input  logic [APMU_NUM_COUNTER-1:0]   pmu_intr_i,

    // output logic [NumCVA6-1:0][1:0]       irq_o,

    // UART
    input  logic                                              rx_i             ,
    output logic                                              tx_o             ,

    // Ethernet
    input  logic                                              eth_clk_i        , // 125 MHz quadrature
    input  logic                                              eth_phy_tx_clk_i , // 125 MHz in-phase
    input  logic                                              eth_clk_200MHz_i ,

    output eth_to_pad_t                                       eth_to_pad       ,
    input  pad_to_eth_t                                       pad_to_eth       ,

    input logic                                               iopmp_irq_i      ,

    // SCMI mailbox interrupt to CVA6
    input  logic                                              irq_mbox_i         ,
    input  logic                                              cfi_watermark_irq_i,
    input  logic                                              cfi_trigger_irq_i  ,

    // Logic locking Keys
    input logic [127:0]                                       iommu_lock_xor_key_i,
    input logic [127:0]                                       aia_lock_xor_key_i

);

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth   ),
    .AXI_DATA_WIDTH ( AxiDataWidth   ),
    .AXI_ID_WIDTH   ( AxiIdWidth     ),
    .AXI_USER_WIDTH ( AxiUserWidth   )
  ) spi_cut();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth   ),
    .AXI_DATA_WIDTH ( 32             ),
    .AXI_ID_WIDTH   ( AxiIdWidth     ),
    .AXI_USER_WIDTH ( AxiUserWidth   )
  ) spi_cut32();

  AXI_LITE #(
    .AXI_ADDR_WIDTH ( 7  ),
    .AXI_DATA_WIDTH ( 32 )
  ) spi_lite();

    // ---------------
    // 1. IRQC
    // ---------------
    logic [ariane_soc::NumSources-1:0] irq_sources;

    assign irq_sources[7]                            = c2h_irq_i;
    assign irq_sources[8]                            = cluster_eoc_i;
    assign irq_sources[9]                            = irq_mbox_i;
    assign irq_sources[10]                           = '0;// reserved for future use;
    assign irq_sources[11]                           = cfi_trigger_irq_i;
    assign irq_sources[12]                           = cfi_watermark_irq_i;
    assign irq_sources[13]                           = iopmp_irq_i;
    assign irq_sources[14]                           = '0; // reserved for future use
    assign irq_sources[138:15]                       = udma_evt_i[123:0];
    assign irq_sources[139]                          = cl_dma_pe_evt_i;
    assign irq_sources[140]                          = can_irq_i[0];
    assign irq_sources[141]                          = can_irq_i[1];

    // Interrupt CH0 from 8 APB TIMERS
    assign irq_sources[142]                          = pwm_irq_i[0];
    assign irq_sources[143]                          = pwm_irq_i[1];
    assign irq_sources[144]                          = pwm_irq_i[2];
    assign irq_sources[145]                          = pwm_irq_i[3];
    assign irq_sources[146]                          = pwm_irq_i[4];
    assign irq_sources[147]                          = pwm_irq_i[5];
    assign irq_sources[148]                          = pwm_irq_i[6];
    assign irq_sources[149]                          = pwm_irq_i[7];

    `ifdef APMU_IP
    assign irq_sources[155+APMU_NUM_COUNTER-1:155]                     = pmu_intr_i;
    assign irq_sources[ariane_soc::NumSources-1:155+APMU_NUM_COUNTER]  = '0;
    // assign irq_le[150+APMU_NUM_COUNTER-1:150]	                        = {APMU_NUM_COUNTER{1'b1}};
    // assign irq_le[ariane_soc::NumSources-1:150+APMU_NUM_COUNTER]       = '0; 
  `else
    assign irq_sources[ariane_soc::NumSources-1:155]                  = '0;
    // assign irq_le[ariane_soc::NumSources-1:150]                       = '0;
  `endif

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : irq_assignment
            assign irq_sources[155 + APMU_NUM_COUNTER + i] = gpio_irq_i[i];
        end
    endgenerate

    assign irq_sources[ariane_soc::NumSources-1:155 + APMU_NUM_COUNTER + 64] = '0;

    ////////////////////////////////////////////////////////////////////
    /// Global Ideia
    ////////////////////////////////////////////////////////////////////
    /// XBar <==> AXI Cut <==> AXI2APB <==> APB2Reg <==> APLIC
    ////////////////////////////////////////////////////////////////////
    /////////////// XBar <==> AXI Cut
    ////////////////////////////////////////////////////////////////////
    AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth  ),
    .AXI_DATA_WIDTH ( AxiDataWidth  ),
    .AXI_ID_WIDTH   ( AxiIdWidth    ),
    .AXI_USER_WIDTH ( AxiUserWidth  )
    ) aplic_cfg_cut ();

    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth    ),
      .DATA_WIDTH ( AxiDataWidth    ),
      .ID_WIDTH   ( AxiIdWidth      ),
      .USER_WIDTH ( AxiUserWidth    )
    ) axi_aplic_cfg_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( plic    ),
      .out    ( aplic_cfg_cut )
    );

    ariane_axi_soc::req_slv_t  aplic_cfg_req;
    ariane_axi_soc::resp_slv_t aplic_cfg_rsp;

    `AXI_ASSIGN_TO_REQ(aplic_cfg_req, aplic_cfg_cut)
    `AXI_ASSIGN_FROM_RESP(aplic_cfg_cut, aplic_cfg_rsp)

    ////////////////////////////////////////////////////////////////////
    ////////////////  AXI Cut <==> AXI2APB
    ////////////////////////////////////////////////////////////////////
    REG_BUS #(
        .ADDR_WIDTH ( 32 ),
        .DATA_WIDTH ( 32 )
    ) reg_bus (clk_i);

    logic         plic_penable;
    logic         plic_pwrite;
    logic [31:0]  plic_paddr;
    logic         plic_psel;
    logic [31:0]  plic_pwdata;
    logic [31:0]  plic_prdata;
    logic         plic_pready;
    logic         plic_pslverr;

    axi2apb_64_32 #(
        .AXI4_ADDRESS_WIDTH ( AxiAddrWidth  ),
        .AXI4_RDATA_WIDTH   ( AxiDataWidth  ),
        .AXI4_WDATA_WIDTH   ( AxiDataWidth  ),
        .AXI4_ID_WIDTH      ( AxiIdWidth    ),
        .AXI4_USER_WIDTH    ( AxiUserWidth  ),
        .BUFF_DEPTH_SLAVE   ( 2             ),
        .APB_ADDR_WIDTH     ( 32            )
    ) i_axi2apb_64_32_plic (
        .ACLK      ( clk_i          ),
        .ARESETn   ( rst_ni         ),
        .test_en_i ( 1'b0           ),
        // AW
        .AWID_i    ( aplic_cfg_req.aw.id     ),
        .AWADDR_i  ( aplic_cfg_req.aw.addr   ),
        .AWLEN_i   ( aplic_cfg_req.aw.len    ),
        .AWSIZE_i  ( aplic_cfg_req.aw.size   ),
        .AWBURST_i ( aplic_cfg_req.aw.burst  ),
        .AWLOCK_i  ( aplic_cfg_req.aw.lock   ),
        .AWCACHE_i ( aplic_cfg_req.aw.cache  ),
        .AWPROT_i  ( aplic_cfg_req.aw.prot   ),
        .AWREGION_i( aplic_cfg_req.aw.region ),
        .AWUSER_i  ( aplic_cfg_req.aw.user   ),
        .AWQOS_i   ( aplic_cfg_req.aw.qos    ),
        .AWVALID_i ( aplic_cfg_req.aw_valid  ),
        .AWREADY_o ( aplic_cfg_rsp.aw_ready ),
        // W
        .WDATA_i   ( aplic_cfg_req.w.data    ),
        .WSTRB_i   ( aplic_cfg_req.w.strb    ),
        .WLAST_i   ( aplic_cfg_req.w.last    ),
        .WUSER_i   ( aplic_cfg_req.w.user    ),
        .WVALID_i  ( aplic_cfg_req.w_valid   ),
        .WREADY_o  ( aplic_cfg_rsp.w_ready  ),
        // B
        .BID_o     ( aplic_cfg_rsp.b.id     ),
        .BRESP_o   ( aplic_cfg_rsp.b.resp   ),
        .BUSER_o   ( aplic_cfg_rsp.b.user   ),
        .BVALID_o  ( aplic_cfg_rsp.b_valid  ),
        .BREADY_i  ( aplic_cfg_req.b_ready   ),
        // AR
        .ARID_i    ( aplic_cfg_req.ar.id     ),
        .ARADDR_i  ( aplic_cfg_req.ar.addr   ),
        .ARLEN_i   ( aplic_cfg_req.ar.len    ),
        .ARSIZE_i  ( aplic_cfg_req.ar.size   ),
        .ARBURST_i ( aplic_cfg_req.ar.burst  ),
        .ARLOCK_i  ( aplic_cfg_req.ar.lock   ),
        .ARCACHE_i ( aplic_cfg_req.ar.cache  ),
        .ARPROT_i  ( aplic_cfg_req.ar.prot   ),
        .ARREGION_i( aplic_cfg_req.ar.region ),
        .ARUSER_i  ( aplic_cfg_req.ar.user   ),
        .ARQOS_i   ( aplic_cfg_req.ar.qos    ),
        .ARVALID_i ( aplic_cfg_req.ar_valid  ),
        .ARREADY_o ( aplic_cfg_rsp.ar_ready ),
        // R
        .RID_o     ( aplic_cfg_rsp.r.id     ),
        .RDATA_o   ( aplic_cfg_rsp.r.data   ),
        .RRESP_o   ( aplic_cfg_rsp.r.resp   ),
        .RLAST_o   ( aplic_cfg_rsp.r.last   ),
        .RUSER_o   ( aplic_cfg_rsp.r.user   ),
        .RVALID_o  ( aplic_cfg_rsp.r_valid  ),
        .RREADY_i  ( aplic_cfg_req.r_ready   ),
        // APB IF
        .PENABLE   ( plic_penable   ),
        .PWRITE    ( plic_pwrite    ),
        .PADDR     ( plic_paddr     ),
        .PSEL      ( plic_psel      ),
        .PWDATA    ( plic_pwdata    ),
        .PRDATA    ( plic_prdata    ),
        .PREADY    ( plic_pready    ),
        .PSLVERR   ( plic_pslverr   )
    );

    ////////////////////////////////////////////////////////////////////
    ////////////////  AXI2APB <==> APB2Reg
    ////////////////////////////////////////////////////////////////////
    apb_to_reg i_apb_to_reg (
        .clk_i     ( clk_i        ),
        .rst_ni    ( rst_ni       ),
        .penable_i ( plic_penable ),
        .pwrite_i  ( plic_pwrite  ),
        .paddr_i   ( plic_paddr   ),
        .psel_i    ( plic_psel    ),
        .pwdata_i  ( plic_pwdata  ),
        .prdata_o  ( plic_prdata  ),
        .pready_o  ( plic_pready  ),
        .pslverr_o ( plic_pslverr ),
        .reg_o     ( reg_bus      )
    );

    // name, addr_t, data_t, strb_t
    `REG_BUS_TYPEDEF_ALL(aplic_reg, ariane_axi_soc::addr_t, logic[31:0], logic[3:0])
    aplic_reg_req_t aplic_regmap_req_o;
    aplic_reg_rsp_t aplic_regmap_resp_i;

    // assign REG_BUS.out to (req_t, rsp_t) pair
    `REG_BUS_ASSIGN_TO_REQ(aplic_regmap_req_o, reg_bus)
    `REG_BUS_ASSIGN_FROM_RSP(reg_bus, aplic_regmap_resp_i)
    ////////////////////////////////////////////////////////////////////

    ////////////////////////////////////////////////////////////////////
    ////////////////  IMSIC (XBAR <==> AIA)
    ////////////////////////////////////////////////////////////////////
    ariane_axi_soc::req_slv_t    lite_msi_req;
    ariane_axi_soc::resp_slv_t   lite_msi_resp;

    `AXI_ASSIGN_TO_REQ(lite_msi_req, imsic)
    `AXI_ASSIGN_FROM_RESP(imsic, lite_msi_resp)
    ////////////////////////////////////////////////////////////////////

    localparam imsic_protocol_pkg::protocol_cfg_t ImsicProtocolCfg = '{
        AXI_ADDR_WIDTH: AxiAddrWidth,
        AXI_DATA_WIDTH: AxiDataWidth,
        AXI_ID_WIDTH:   AxiIdWidth
    };

    for (genvar i = 0; i < imsic_pkg::DefaultImsicCfg.NrHarts; i++) begin
        assign irq_o[i] = imsic_csr_o[i].Xeip_targets;
    end

    aplic_top #(
        .AplicCfg       ( aplic_pkg::DefaultAplicCfg        ),
        .ImsicCfg       ( imsic_pkg::DefaultImsicCfg        ),
        .ProtocolCfg    ( ImsicProtocolCfg                  ),
        .reg_req_t      ( aplic_reg_req_t                   ),
        .reg_rsp_t      ( aplic_reg_rsp_t                   ),
        .axi_req_t      ( ariane_axi_soc::req_slv_t         ),
        .axi_resp_t     ( ariane_axi_soc::resp_slv_t        )
    ) aplic_top_embedded_i (
        .i_clk          ( clk_i                             ),
        .ni_rst         ( rst_ni                            ),
        .i_irq_sources  ( {irq_sources[ariane_soc::NumSources-2:0], 1'b0}),
        .i_req_cfg      ( aplic_regmap_req_o                ),
        .o_resp_cfg     ( aplic_regmap_resp_i               ),
        .i_imsic_csr    ( imsic_csr_i                       ),
        .o_imsic_csr    ( imsic_csr_o                       ),
        .i_imsic_req    ( lite_msi_req                      ),
        .o_imsic_resp   ( lite_msi_resp                     ),
        .aia_lock_xor_key_i
    );

    // ---------------
    // 2. UART
    // ---------------
    logic         uart_penable;
    logic         uart_pwrite;
    logic [31:0]  uart_paddr;
    logic         uart_psel;
    logic [31:0]  uart_pwdata;
    logic [31:0]  uart_prdata;
    logic         uart_pready;
    logic         uart_pslverr;

    axi2apb_64_32 #(
        .AXI4_ADDRESS_WIDTH ( AxiAddrWidth ),
        .AXI4_RDATA_WIDTH   ( AxiDataWidth ),
        .AXI4_WDATA_WIDTH   ( AxiDataWidth ),
        .AXI4_ID_WIDTH      ( AxiIdWidth   ),
        .AXI4_USER_WIDTH    ( AxiUserWidth ),
        .BUFF_DEPTH_SLAVE   ( 2            ),
        .APB_ADDR_WIDTH     ( 32           )
    ) i_axi2apb_64_32_uart (
        .ACLK      ( clk_i          ),
        .ARESETn   ( rst_ni         ),
        .test_en_i ( 1'b0           ),
        .AWID_i    ( uart.aw_id     ),
        .AWADDR_i  ( uart.aw_addr   ),
        .AWLEN_i   ( uart.aw_len    ),
        .AWSIZE_i  ( uart.aw_size   ),
        .AWBURST_i ( uart.aw_burst  ),
        .AWLOCK_i  ( uart.aw_lock   ),
        .AWCACHE_i ( uart.aw_cache  ),
        .AWPROT_i  ( uart.aw_prot   ),
        .AWREGION_i( uart.aw_region ),
        .AWUSER_i  ( uart.aw_user   ),
        .AWQOS_i   ( uart.aw_qos    ),
        .AWVALID_i ( uart.aw_valid  ),
        .AWREADY_o ( uart.aw_ready  ),
        .WDATA_i   ( uart.w_data    ),
        .WSTRB_i   ( uart.w_strb    ),
        .WLAST_i   ( uart.w_last    ),
        .WUSER_i   ( uart.w_user    ),
        .WVALID_i  ( uart.w_valid   ),
        .WREADY_o  ( uart.w_ready   ),
        .BID_o     ( uart.b_id      ),
        .BRESP_o   ( uart.b_resp    ),
        .BVALID_o  ( uart.b_valid   ),
        .BUSER_o   ( uart.b_user    ),
        .BREADY_i  ( uart.b_ready   ),
        .ARID_i    ( uart.ar_id     ),
        .ARADDR_i  ( uart.ar_addr   ),
        .ARLEN_i   ( uart.ar_len    ),
        .ARSIZE_i  ( uart.ar_size   ),
        .ARBURST_i ( uart.ar_burst  ),
        .ARLOCK_i  ( uart.ar_lock   ),
        .ARCACHE_i ( uart.ar_cache  ),
        .ARPROT_i  ( uart.ar_prot   ),
        .ARREGION_i( uart.ar_region ),
        .ARUSER_i  ( uart.ar_user   ),
        .ARQOS_i   ( uart.ar_qos    ),
        .ARVALID_i ( uart.ar_valid  ),
        .ARREADY_o ( uart.ar_ready  ),
        .RID_o     ( uart.r_id      ),
        .RDATA_o   ( uart.r_data    ),
        .RRESP_o   ( uart.r_resp    ),
        .RLAST_o   ( uart.r_last    ),
        .RUSER_o   ( uart.r_user    ),
        .RVALID_o  ( uart.r_valid   ),
        .RREADY_i  ( uart.r_ready   ),
        .PENABLE   ( uart_penable   ),
        .PWRITE    ( uart_pwrite    ),
        .PADDR     ( uart_paddr     ),
        .PSEL      ( uart_psel      ),
        .PWDATA    ( uart_pwdata    ),
        .PRDATA    ( uart_prdata    ),
        .PREADY    ( uart_pready    ),
        .PSLVERR   ( uart_pslverr   )
    );

    // CORE UART
    if (InclUART) begin : gen_uart
        apb_uart i_apb_uart0 (
            .CLK     ( clk_i           ),
            .RSTN    ( rst_ni          ),
            .PSEL    ( uart_psel       ),
            .PENABLE ( uart_penable    ),
            .PWRITE  ( uart_pwrite     ),
            .PADDR   ( uart_paddr[4:2] ),
            .PWDATA  ( uart_pwdata     ),
            .PRDATA  ( uart_prdata     ),
            .PREADY  ( uart_pready     ),
            .PSLVERR ( uart_pslverr    ),
            .INT     ( irq_sources[1]  ),
            .OUT1N   (                 ), // keep open
            .OUT2N   (                 ), // keep open
            .RTSN    (                 ), // no flow control
            .DTRN    (                 ), // no flow control
            .CTSN    ( 1'b0            ),
            .DSRN    ( 1'b0            ),
            .DCDN    ( 1'b0            ),
            .RIN     ( 1'b0            ),
            .SIN     ( rx_i            ),
            .SOUT    ( tx_o            )
        );
    end else begin
        assign irq_sources[1] = 1'b0;
        /* pragma translate_off */
        mock_uart i_mock_uart0 (
            .clk_i     ( clk_i        ),
            .rst_ni    ( rst_ni       ),
            .penable_i ( uart_penable ),
            .pwrite_i  ( uart_pwrite  ),
            .paddr_i   ( uart_paddr   ),
            .psel_i    ( uart_psel    ),
            .pwdata_i  ( uart_pwdata  ),
            .prdata_o  ( uart_prdata  ),
            .pready_o  ( uart_pready  ),
            .pslverr_o ( uart_pslverr )
        );
        /* pragma translate_on */
    end

    // ---------------
    // 3. SPI
    // ---------------
    if (InclSPI) begin : gen_spi

         axi_cut_intf #(
           .ADDR_WIDTH ( AxiAddrWidth   ),
           .DATA_WIDTH ( AxiDataWidth   ),
           .ID_WIDTH   ( AxiIdWidth     ),
           .USER_WIDTH ( AxiUserWidth   )
           ) axi_spi_cut(
              .clk_i  ( clk_i   ),
              .rst_ni ( rst_ni  ),
              .in     ( spi     ),
              .out    ( spi_cut )
              );

         axi_dw_converter_intf #(
           .AXI_ADDR_WIDTH          ( AxiAddrWidth   ),
           .AXI_ID_WIDTH            ( AxiIdWidth     ),
           .AXI_USER_WIDTH          ( AxiUserWidth   ),
           .AXI_MAX_READS           ( 1              ),
           .AXI_SLV_PORT_DATA_WIDTH ( AxiDataWidth   ),
           .AXI_MST_PORT_DATA_WIDTH ( 32             )
           ) axi_spi_dw_converter (
              .clk_i  ( clk_i     ),
              .rst_ni ( rst_ni    ),
              .slv    ( spi_cut   ),
              .mst    ( spi_cut32 )
              );

         axi_to_axi_lite_intf #(
           .AXI_ADDR_WIDTH     ( 7            ),
           .AXI_DATA_WIDTH     ( 32           ),
           .AXI_ID_WIDTH       ( AxiIdWidth   ),
           .AXI_USER_WIDTH     ( AxiUserWidth ),
           .AXI_MAX_READ_TXNS  ( 1            ),
           .AXI_MAX_WRITE_TXNS ( 1            )
           ) axi2axilite_spi (
               .clk_i      ( clk_i     ),
               .rst_ni     ( rst_ni    ),
               .testmode_i ( 1'b0      ),
               .slv        ( spi_cut32 ),
               .mst        ( spi_lite  )
               );

         xilinx_qspi axi_quad_spi_0(
           .ext_spi_clk   ( clk_i             ),
           .s_axi_aclk    ( clk_i             ),
           .s_axi_aresetn ( rst_ni            ),
           .s_axi_awaddr  ( spi_lite.aw_addr  ),
           .s_axi_awvalid ( spi_lite.aw_valid ),
           .s_axi_awready ( spi_lite.aw_ready ),
           .s_axi_wdata   ( spi_lite.w_data   ),
           .s_axi_wstrb   ( spi_lite.w_strb   ),
           .s_axi_wvalid  ( spi_lite.w_valid  ),
           .s_axi_wready  ( spi_lite.w_ready  ),
           .s_axi_bresp   ( spi_lite.b_resp   ),
           .s_axi_bvalid  ( spi_lite.b_valid  ),
           .s_axi_bready  ( spi_lite.b_ready  ),
           .s_axi_araddr  ( spi_lite.ar_addr  ),
           .s_axi_arvalid ( spi_lite.ar_valid ),
           .s_axi_arready ( spi_lite.ar_ready ),
           .s_axi_rdata   ( spi_lite.r_data   ),
           .s_axi_rresp   ( spi_lite.r_resp   ),
           .s_axi_rvalid  ( spi_lite.r_valid  ),
           .s_axi_rready  ( spi_lite.r_ready  ),
           .cfgclk        (                   ),
           .cfgmclk       (                   ),
           .eos           (                   ),
           .preq          (                   ),
           .gsr           ( 1'b0              ),
           .gts           ( 1'b1              ),
           .keyclearb     ( 1'b1              ),
           .usrcclkts     ( 1'b0              ),
           .usrdoneo      ( 1'b1              ),
           .usrdonets     ( 1'b1              ),
           .ip2intc_irpt  ( irq_sources[0]    )
          );


    end else begin
        assign spi_clk_o = 1'b0;
        assign spi_mosi = 1'b0;
        assign spi_ss = 1'b0;

        assign irq_sources [0] = 1'b0;
        assign spi.aw_ready = 1'b1;
        assign spi.ar_ready = 1'b1;
        assign spi.w_ready = 1'b1;

        assign spi.b_valid = spi.aw_valid;
        assign spi.b_id = spi.aw_id;
        assign spi.b_resp = axi_pkg::RESP_SLVERR;
        assign spi.b_user = '0;

        assign spi.r_valid = spi.ar_valid;
        assign spi.r_resp = axi_pkg::RESP_SLVERR;
        assign spi.r_data = 'hdeadbeef;
        assign spi.r_last = 1'b1;
    end


    // ---------------
    // 4. Ethernet
    // ---------------
    if (InclEthernet) begin
        logic [3:0]                eth_txd, eth_rxd;
        logic                      eth_txck, eth_rxck;
        logic                      eth_txctl, eth_rxctl;
        logic                      eth_rstn;
        logic                      eth_md_i, eth_md_o, eth_md_oe, eth_mdc;

        // should move to a configuration file
        localparam int unsigned NumAxInFlight    = 32'd9;
        localparam int unsigned BufferDepth      = 32'd3;
        localparam int unsigned TFLenWidth       = 32'd32;
        localparam int unsigned MemSysDepth      = 32'd0;
        localparam int unsigned RejectZeroTransfers = 32'd1;
        localparam int unsigned TxFifoLogDepth   = 32'd5;
        localparam int unsigned RxFifoLogDepth   = 32'd4;

        /// Register interface parameters
        localparam int unsigned RegBusDw   = 32;
        localparam int unsigned RegBusAw   = 32;
        localparam int unsigned RegBusStrb = RegBusDw/8;

        /// Regsiter bus typedefs
        typedef logic [RegBusAw-1:0]   reg_bus_addr_t;
        typedef logic [RegBusDw-1:0]   reg_bus_data_t;
        typedef logic [RegBusStrb-1:0]  reg_bus_strb_t;

        `REG_BUS_TYPEDEF_ALL(reg_bus, reg_bus_addr_t, reg_bus_data_t, reg_bus_strb_t)

        ariane_axi_soc::req_t axi_req_i;
        ariane_axi_soc::req_slv_t axi_req_o;
        ariane_axi_soc::resp_slv_t axi_rsp_i;
        ariane_axi_soc::resp_t axi_rsp_o;
        reg_bus_req_t reg_req;
        reg_bus_rsp_t reg_rsp;

        `AXI_ASSIGN_TO_REQ(axi_req_i, eth_config )
        `AXI_ASSIGN_FROM_RESP(eth_config,axi_rsp_o)

        `AXI_ASSIGN_FROM_REQ( eth_idma,axi_req_o  )
        `AXI_ASSIGN_TO_RESP( axi_rsp_i, eth_idma )

        assign eth_rxd[3] = pad_to_eth.eth_rxd3_i;
        assign eth_rxd[2] = pad_to_eth.eth_rxd2_i;
        assign eth_rxd[1] = pad_to_eth.eth_rxd1_i;
        assign eth_rxd[0] = pad_to_eth.eth_rxd0_i;
        assign eth_rxck   = pad_to_eth.eth_rxck_i;
        assign eth_rxctl  = pad_to_eth.eth_rxctl_i;
        assign eth_md_i   = pad_to_eth.eth_md_i;

        assign eth_to_pad.eth_txd3_o = eth_txd[3];
        assign eth_to_pad.eth_txd2_o = eth_txd[2];
        assign eth_to_pad.eth_txd1_o = eth_txd[1];
        assign eth_to_pad.eth_txd0_o = eth_txd[0];
        assign eth_to_pad.eth_md_oe  = eth_md_oe;
        assign eth_to_pad.eth_md_o   = eth_md_o;
        assign eth_to_pad.eth_mdc_o  = eth_mdc;
        assign eth_to_pad.eth_txck_o = eth_txck;
        assign eth_to_pad.eth_txctl_o = eth_txctl;
        assign eth_to_pad.eth_rstn_o = eth_rstn;

        axi_to_reg_v2 #(
            .AxiAddrWidth ( AxiAddrWidth           ),
            .AxiDataWidth ( AxiDataWidth           ),
            .AxiIdWidth   ( AxiIdWidth             ),
            .AxiUserWidth ( AxiUserWidth           ),
            .RegDataWidth ( 32                     ),
            .axi_req_t    ( ariane_axi_soc::req_t  ),
            .axi_rsp_t    ( ariane_axi_soc::resp_t ),
            .reg_req_t    ( reg_bus_req_t          ),
            .reg_rsp_t    ( reg_bus_rsp_t          )
        ) i_axi_to_reg (
            .clk_i       ( clk_i       ),
            .rst_ni      ( rst_ni      ),
            .axi_req_i   ( axi_req_i   ),
            .axi_rsp_o   ( axi_rsp_o   ),
            .reg_req_o   ( reg_req     ),
            .reg_rsp_i   ( reg_rsp     ),
            .reg_id_o    (             ),
            .busy_o      (             )
        );

        eth_idma_wrap#(
          .DataWidth           ( AxiDataWidth           ),
          .AddrWidth           ( AxiAddrWidth           ),
          .UserWidth           ( AxiUserWidth           ),
          .AxiIdWidth          ( AxiIdWidth             ),
          .NumAxInFlight       ( NumAxInFlight          ),
          .BufferDepth         ( BufferDepth            ),
          .TFLenWidth          ( TFLenWidth             ),
          .MemSysDepth         ( MemSysDepth            ),
          .RejectZeroTransfers ( RejectZeroTransfers    ),
          .TxFifoLogDepth      ( TxFifoLogDepth         ),
          .RxFifoLogDepth      ( RxFifoLogDepth         ),
          .axi_req_t           ( ariane_axi_soc::req_slv_t  ),
          .axi_rsp_t           ( ariane_axi_soc::resp_slv_t ),
          .reg_req_t           ( reg_bus_req_t          ),
          .reg_rsp_t           ( reg_bus_rsp_t          )
        ) i_ethernet (
          .clk_i,
          .rst_ni,
          .eth_clk125_i        ( eth_clk_i              ), // 125MHz in-phase
          .eth_clk125q_i       ( eth_phy_tx_clk_i       ), // 125 MHz with 90 phase shift
          .eth_clk200_i        ( '0                     ),
          .phy_rx_clk_i        ( eth_rxck               ),
          .phy_rxd_i           ( eth_rxd                ),
          .phy_rx_ctl_i        ( eth_rxctl              ),
          .phy_tx_clk_o        ( eth_txck               ),
          .phy_txd_o           ( eth_txd                ),
          .phy_tx_ctl_o        ( eth_txctl              ),
          .phy_resetn_o        ( eth_rstn               ),
          .phy_intn_i          ( 1'b1                   ),
          .phy_pme_i           ( 1'b1                   ),
          .phy_mdio_i          ( eth_md_i               ),
          .phy_mdio_o          ( eth_md_o               ),
          .phy_mdio_oe         ( eth_md_oe              ),
          .phy_mdc_o           ( eth_mdc                ),
          .testmode_i          ( 1'b0                   ),
          .axi_req_o           ( axi_req_o              ),
          .axi_rsp_i           ( axi_rsp_i              ),
          .reg_req_i           ( reg_req                ),
          .reg_rsp_o           ( reg_rsp                ),
          .eth_rx_irq_o        ( irq_sources[2]         )
        );
    end else begin

        ariane_axi_soc::req_t axi_req_i;
        ariane_axi_soc::resp_t axi_rsp_o;
        ariane_axi_soc::req_slv_t axi_req_o;
        ariane_axi_soc::resp_slv_t axi_rsp_i;

        `AXI_ASSIGN_FROM_REQ( eth_idma,axi_req_o  )
        `AXI_ASSIGN_TO_RESP( axi_rsp_i, eth_idma )
        `AXI_ASSIGN_TO_REQ(axi_req_i, eth_config )
        `AXI_ASSIGN_FROM_RESP(eth_config,axi_rsp_o)

        assign eth_to_pad.eth_txd3_o  = '0;
        assign eth_to_pad.eth_txd2_o  = '0;
        assign eth_to_pad.eth_txd1_o  = '0;
        assign eth_to_pad.eth_txd0_o  = '0;
        assign eth_to_pad.eth_md_oe   = '0;
        assign eth_to_pad.eth_md_o    = '0;
        assign eth_to_pad.eth_mdc_o   = '0;
        assign eth_to_pad.eth_txck_o  = '0;
        assign eth_to_pad.eth_txctl_o = '0;
        assign eth_to_pad.eth_rstn_o  = '0;
        assign irq_sources [2] = 1'b0;
        assign axi_req_o = '0;
        assign eth_txck  = '0;
        assign eth_txd   = '0;
        assign eth_txctl = '0;
        assign eth_rstn  = '0;
        assign eth_md_o  = '0;
        assign eth_md_oe = '0;
        assign eth_mdc   = '0;

        axi_err_slv #(
        .AxiIdWidth ( ariane_soc::IdWidth    ),
        .axi_req_t  ( ariane_axi_soc::req_t  ),
        .axi_resp_t ( ariane_axi_soc::resp_t ),
        .RespWidth  ( 32'd64                     ),
        .RespData   ( 64'hdeadbeefdeadbeef       ),
        .ATOPs      ( 1'b0                       ),
        .MaxTrans   ( 1                          )
        ) eth_not_implemented (
          .clk_i,
          .rst_ni,
          .slv_req_i  ( axi_req_i           ),
          .slv_resp_o ( axi_rsp_o           )
        );
    end

    // ---------------
    // 5. Timer
    // ---------------
    if (InclTimer) begin : gen_timer
        logic         timer_penable;
        logic         timer_pwrite;
        logic [31:0]  timer_paddr;
        logic         timer_psel;
        logic [31:0]  timer_pwdata;
        logic [31:0]  timer_prdata;
        logic         timer_pready;
        logic         timer_pslverr;

        axi2apb_64_32 #(
            .AXI4_ADDRESS_WIDTH ( AxiAddrWidth ),
            .AXI4_RDATA_WIDTH   ( AxiDataWidth ),
            .AXI4_WDATA_WIDTH   ( AxiDataWidth ),
            .AXI4_ID_WIDTH      ( AxiIdWidth   ),
            .AXI4_USER_WIDTH    ( AxiUserWidth ),
            .BUFF_DEPTH_SLAVE   ( 2            ),
            .APB_ADDR_WIDTH     ( 32           )
        ) i_axi2apb_64_32_timer (
            .ACLK      ( clk_i           ),
            .ARESETn   ( rst_ni          ),
            .test_en_i ( 1'b0            ),
            .AWID_i    ( timer.aw_id     ),
            .AWADDR_i  ( timer.aw_addr   ),
            .AWLEN_i   ( timer.aw_len    ),
            .AWSIZE_i  ( timer.aw_size   ),
            .AWBURST_i ( timer.aw_burst  ),
            .AWLOCK_i  ( timer.aw_lock   ),
            .AWCACHE_i ( timer.aw_cache  ),
            .AWPROT_i  ( timer.aw_prot   ),
            .AWREGION_i( timer.aw_region ),
            .AWUSER_i  ( timer.aw_user   ),
            .AWQOS_i   ( timer.aw_qos    ),
            .AWVALID_i ( timer.aw_valid  ),
            .AWREADY_o ( timer.aw_ready  ),
            .WDATA_i   ( timer.w_data    ),
            .WSTRB_i   ( timer.w_strb    ),
            .WLAST_i   ( timer.w_last    ),
            .WUSER_i   ( timer.w_user    ),
            .WVALID_i  ( timer.w_valid   ),
            .WREADY_o  ( timer.w_ready   ),
            .BID_o     ( timer.b_id      ),
            .BRESP_o   ( timer.b_resp    ),
            .BVALID_o  ( timer.b_valid   ),
            .BUSER_o   ( timer.b_user    ),
            .BREADY_i  ( timer.b_ready   ),
            .ARID_i    ( timer.ar_id     ),
            .ARADDR_i  ( timer.ar_addr   ),
            .ARLEN_i   ( timer.ar_len    ),
            .ARSIZE_i  ( timer.ar_size   ),
            .ARBURST_i ( timer.ar_burst  ),
            .ARLOCK_i  ( timer.ar_lock   ),
            .ARCACHE_i ( timer.ar_cache  ),
            .ARPROT_i  ( timer.ar_prot   ),
            .ARREGION_i( timer.ar_region ),
            .ARUSER_i  ( timer.ar_user   ),
            .ARQOS_i   ( timer.ar_qos    ),
            .ARVALID_i ( timer.ar_valid  ),
            .ARREADY_o ( timer.ar_ready  ),
            .RID_o     ( timer.r_id      ),
            .RDATA_o   ( timer.r_data    ),
            .RRESP_o   ( timer.r_resp    ),
            .RLAST_o   ( timer.r_last    ),
            .RUSER_o   ( timer.r_user    ),
            .RVALID_o  ( timer.r_valid   ),
            .RREADY_i  ( timer.r_ready   ),
            .PENABLE   ( timer_penable   ),
            .PWRITE    ( timer_pwrite    ),
            .PADDR     ( timer_paddr     ),
            .PSEL      ( timer_psel      ),
            .PWDATA    ( timer_pwdata    ),
            .PRDATA    ( timer_prdata    ),
            .PREADY    ( timer_pready    ),
            .PSLVERR   ( timer_pslverr   )
        );

        apb_timer #(
                .APB_ADDR_WIDTH ( 32 ),
                .TIMER_CNT      ( 2  )
        ) i_timer (
            .HCLK    ( clk_i            ),
            .HRESETn ( rst_ni           ),
            .PSEL    ( timer_psel       ),
            .PENABLE ( timer_penable    ),
            .PWRITE  ( timer_pwrite     ),
            .PADDR   ( timer_paddr      ),
            .PWDATA  ( timer_pwdata     ),
            .PRDATA  ( timer_prdata     ),
            .PREADY  ( timer_pready     ),
            .PSLVERR ( timer_pslverr    ),
            .irq_o   ( irq_sources[6:3] )
        );
    end

    // -----------------------
    // 6. S-mode DMA & IOMMU
    // -----------------------

    // AXI Bus: S-mode iDMA Master <=> IOMMU TR IF
    ariane_axi_soc::req_ext_t   axi_iommu_tr_req;
    ariane_axi_soc::resp_t      axi_iommu_tr_rsp;

    // AXI Bus: XBAR <=> AXI Cut (S-mode iDMA Programming Interface)
    AXI_BUS #(
      .AXI_ADDR_WIDTH ( AxiAddrWidth             ),
      .AXI_DATA_WIDTH ( AxiDataWidth             ),
      .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
      .AXI_USER_WIDTH ( AxiUserWidth             )
    ) sdma_cfg_cut ();

    // AXI Cut for S-mode iDMA Programming Interface
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth              ),
      .DATA_WIDTH ( AxiDataWidth              ),
      .ID_WIDTH   ( ariane_soc::IdWidthSlave  ),
      .USER_WIDTH ( AxiUserWidth              )
    ) axi_sdma_cfg_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( sdma_cfg ),
      .out    ( sdma_cfg_cut )
    );

    // AXI Bus: XBAR <=> AXI Cut (IOMMU Programming Interface)
    AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth             ),
    .AXI_DATA_WIDTH ( AxiDataWidth             ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AxiUserWidth             )
    ) iommu_cfg_cut ();

    // AXI Cut for IOMMU Programming Interface
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth              ),
      .DATA_WIDTH ( AxiDataWidth              ),
      .ID_WIDTH   ( ariane_soc::IdWidthSlave  ),
      .USER_WIDTH ( AxiUserWidth              )
    ) axi_iommu_cfg_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( iommu_cfg ),
      .out    ( iommu_cfg_cut )
    );

    // AXI Bus: AXI Cut <=> IOMMU Programming Interface
    ariane_axi_soc::req_slv_t  axi_iommu_cfg_req;
    ariane_axi_soc::resp_slv_t axi_iommu_cfg_rsp;
    `AXI_ASSIGN_TO_REQ(axi_iommu_cfg_req, iommu_cfg_cut)
    `AXI_ASSIGN_FROM_RESP(iommu_cfg_cut, axi_iommu_cfg_rsp)

    // AXI Bus: IOMMU Data Structure IF <=> AXI Cut
    AXI_BUS #(
      .AXI_ADDR_WIDTH ( AxiAddrWidth        ),
      .AXI_DATA_WIDTH ( AxiDataWidth        ),
      .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
      .AXI_USER_WIDTH ( AxiUserWidth        )
    ) iommu_ds_cut ();

    // AXI Cut for IOMMU Data Structure Interface
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth   ),
      .DATA_WIDTH ( AxiDataWidth   ),
      .ID_WIDTH   ( ariane_soc::IdWidth ),
      .USER_WIDTH ( AxiUserWidth   )
    ) axi_iommu_ds_master_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( iommu_ds_cut ),
      .out    ( iommu_ds )
    );

    // AXI Bus: IOMMU Completion IF <=> AXI Cut
    AXI_BUS #(
      .AXI_ADDR_WIDTH ( AxiAddrWidth        ),
      .AXI_DATA_WIDTH ( AxiDataWidth        ),
      .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
      .AXI_USER_WIDTH ( AxiUserWidth        )
    ) iommu_comp_cut ();

    // AXI Cut for IOMMU Completion Interface
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth   ),
      .DATA_WIDTH ( AxiDataWidth   ),
      .ID_WIDTH   ( ariane_soc::IdWidth ),
      .USER_WIDTH ( AxiUserWidth   )
    ) axi_iommu_comp_master_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( iommu_comp_cut ),
      .out    ( iommu_comp )
    );

    // -----------------
    // 6.1. S-mode DMA
    // -----------------
    if (InclSDMA) begin : gen_sdma

      // AXI Bus: S-mode iDMA Master <=> IOMMU TR IF
      AXI_BUS_EXT #(
          .AXI_ADDR_WIDTH ( AxiAddrWidth          ),
          .AXI_DATA_WIDTH ( AxiDataWidth          ),
          .AXI_ID_WIDTH   ( ariane_soc::IdWidth   ),
          .AXI_USER_WIDTH ( AxiUserWidth          )
      ) axi_sdma_master ();

      // Conversion from SV interface to req/resp structs
      `AXI_ASSIGN_TO_REQ(axi_iommu_tr_req, axi_sdma_master)
      `AXI_ASSIGN_FROM_RESP(axi_sdma_master, axi_iommu_tr_rsp)

      // Manually assign IOMMU-specific signals
      // AW
      assign axi_iommu_tr_req.aw.stream_id    = axi_sdma_master.aw_stream_id;
      assign axi_iommu_tr_req.aw.ss_id_valid  = axi_sdma_master.aw_ss_id_valid;
      assign axi_iommu_tr_req.aw.substream_id = axi_sdma_master.aw_substream_id;
      assign axi_iommu_tr_req.aw.nsaid        = axi_sdma_master.aw_nsaid;
      // AR
      assign axi_iommu_tr_req.ar.stream_id    = axi_sdma_master.ar_stream_id;
      assign axi_iommu_tr_req.ar.ss_id_valid  = axi_sdma_master.ar_ss_id_valid;
      assign axi_iommu_tr_req.ar.substream_id = axi_sdma_master.ar_substream_id;
      assign axi_iommu_tr_req.ar.nsaid        = axi_sdma_master.ar_nsaid;

      // S-mode iDMA
      dma_core_wrap_intf #(
        .AXI_ADDR_WIDTH     ( AxiAddrWidth               ),
        .AXI_DATA_WIDTH     ( AxiDataWidth               ),
        .AXI_USER_WIDTH     ( AxiUserWidth               ),
        .AXI_ID_WIDTH       ( ariane_soc::IdWidth        ),
        .AXI_SLV_ID_WIDTH   ( ariane_soc::IdWidthSlave   ),
        .JOB_FIFO_DEPTH     ( 2                          ),
        .NUM_AX_IN_FLIGHT   ( 2                          ),
        .MEM_SYS_DEPTH      ( 0                          ),
        .BUFFER_DEPTH       ( 3                          ),
        .RAW_COUPLING_AVAIL ( 1                          ),
        .IS_TWO_D           ( 0                          ),

        .STREAM_ID          ( 24'd10          ),
        .NSAID              ( 4'd0            ),
        .AxID               ( 5'd0            )
      ) i_sdma (
        .clk_i      		    ( clk_i           ),
        .rst_ni     		    ( rst_ni          ),
        .testmode_i 		    ( 1'b0            ),
        // slave port
        .axi_slave  		    ( sdma_cfg_cut    ),
        // master port
        .axi_master 		    ( axi_sdma_master )
		  );
    end : gen_sdma

	  // --------------
    //  No S-mode DMA
    // --------------
	  //
	  // When no S-mode DMA is included, IOMMU TR AXI Bus request xVALID/xREADY wires are set to zero
	  // AXI transactions directed to the S-mode DMA config port are responded with error.
    else begin : gen_sdma_disabled

	    // AXI Bus: AXI Cut <=> S-mode DMA Error Slave
	    ariane_axi_soc::req_slv_t axi_sdma_cfg_req;
	    ariane_axi_soc::resp_slv_t axi_sdma_cfg_rsp;
	    `AXI_ASSIGN_TO_REQ(axi_sdma_cfg_req, sdma_cfg_cut)
	    `AXI_ASSIGN_FROM_RESP(sdma_cfg_cut, axi_sdma_cfg_rsp)

      // S-mode iDMA Error Slave
      axi_err_slv #(
        .AxiIdWidth ( ariane_soc::IdWidthSlave   ),
        .axi_req_t  ( ariane_axi_soc::req_slv_t  ),
        .axi_resp_t ( ariane_axi_soc::resp_slv_t )
      ) i_sdma_err_slv (
        .clk_i      ( clk_i    				  ),
        .rst_ni     ( rst_ni   				  ),
        .slv_req_i  ( axi_sdma_cfg_req  ),
        .slv_resp_o ( axi_sdma_cfg_rsp  ),
        .test_i     ( 1'b0     				  )
      );

	    // Set TR IF request wires to a known state
	    assign axi_iommu_tr_req.ar_valid    = 1'b0;
      assign axi_iommu_tr_req.aw_valid    = 1'b0;
      assign axi_iommu_tr_req.w_valid     = 1'b0;
      assign axi_iommu_tr_req.b_ready     = 1'b0;
      assign axi_iommu_tr_req.r_ready     = 1'b0;
    end : gen_sdma_disabled

    // -----------
    // 6.2. IOMMU
    // -----------
    if (InclIOMMU) begin : gen_iommu

      // AXI Bus: IOMMU Data Structure IF <=> AXI Cut
      // Conversion from SV interface to req/resp structs
      ariane_axi_soc::req_t  axi_iommu_ds_req;
      ariane_axi_soc::resp_t axi_iommu_ds_rsp;
      `AXI_ASSIGN_FROM_REQ(iommu_ds_cut, axi_iommu_ds_req)
      `AXI_ASSIGN_TO_RESP(axi_iommu_ds_rsp, iommu_ds_cut)

      // AXI Bus: IOMMU Completion IF <=> AXI Cut
      // Conversion from SV interface to req/resp structs
      ariane_axi_soc::req_t  axi_iommu_comp_req;
      ariane_axi_soc::resp_t axi_iommu_comp_rsp;
      `AXI_ASSIGN_FROM_REQ(iommu_comp_cut, axi_iommu_comp_req)
      `AXI_ASSIGN_TO_RESP(axi_iommu_comp_rsp, iommu_comp_cut)

      // IOMMU Memory-mapped Register IF types
      // name, addr_t, data_t, strb_t
      `REG_BUS_TYPEDEF_ALL(iommu_reg, logic[31:0], logic[31:0], logic[3:0])

      riscv_iommu #(
        .IOTLB_ENTRIES  ( 8	    				),
        .DDTC_ENTRIES		( 4							),
        .PDTC_ENTRIES		( 4							),
        .MRIFC_ENTRIES	( 4							),

        .MSITrans			  ( rv_iommu::MSI_FLAT_MRIF	    ),
        .InclPC         ( 1'b0						            ),
        .InclBC         ( 1'b1                        ),
        .InclDBG			  ( 1'b1						            ),

        .IGS            ( rv_iommu::BOTH              ),
        .N_INT_VEC      ( 4                           ),
        .N_IOHPMCTR     ( 8                           ),

        .ADDR_WIDTH			( AxiAddrWidth				        ),
        .DATA_WIDTH			( AxiDataWidth				        ),
        .ID_WIDTH			  ( ariane_soc::IdWidth		      ),
        .ID_SLV_WIDTH		( ariane_soc::IdWidthSlave	  ),
        .USER_WIDTH			( AxiUserWidth				        ),
        .aw_chan_t			( ariane_axi_soc::aw_chan_t   ),
        .w_chan_t			  ( ariane_axi_soc::w_chan_t	  ),
        .b_chan_t			  ( ariane_axi_soc::b_chan_t	  ),
        .ar_chan_t			( ariane_axi_soc::ar_chan_t   ),
        .r_chan_t			  ( ariane_axi_soc::r_chan_t	  ),
        .axi_req_t			( ariane_axi_soc::req_t		    ),
        .axi_rsp_t			( ariane_axi_soc::resp_t	    ),
        .axi_req_slv_t	( ariane_axi_soc::req_slv_t	  ),
        .axi_rsp_slv_t	( ariane_axi_soc::resp_slv_t  ),
        .axi_req_iommu_t( ariane_axi_soc::req_ext_t   ),
        .reg_req_t		  ( iommu_reg_req_t			        ),
        .reg_rsp_t		  ( iommu_reg_rsp_t			        )
      ) i_riscv_iommu (

        .clk_i				    ( clk_i						        ),
        .rst_ni				    ( rst_ni					        ),

        // Translation Request Interface (Slave)
        .dev_tr_req_i		  ( axi_iommu_tr_req		    ),
        .dev_tr_resp_o		( axi_iommu_tr_rsp		    ),

        // Translation Completion Interface (Master)
        .dev_comp_resp_i	( axi_iommu_comp_rsp	    ),
        .dev_comp_req_o		( axi_iommu_comp_req	    ),

        // Implicit Memory Accesses Interface (Master)
        .ds_resp_i			  ( axi_iommu_ds_rsp		    ),
        .ds_req_o			    ( axi_iommu_ds_req		    ),

        // Programming Interface (Slave)
        .prog_req_i			  ( axi_iommu_cfg_req		    ),
        .prog_resp_o		  ( axi_iommu_cfg_rsp		    ),

        .wsi_wires_o      ( irq_sources[153:150]    ),

        .iommu_lock_xor_key_i
      );

    // ----------
    //  No IOMMU
    // ----------
    //
    // When the IOMMU is not included, translation requests are bypassed directly to the XBAR.
    // AXI transactions performed to the IOMMU programmming IF are responded with error.
    // All Data Structure IF request xVALID/xREADY wires are set to zero.
    end else begin : gen_iommu_disabled

      axi_err_slv #(
          .AxiIdWidth   ( ariane_soc::IdWidthSlave   ),
          .axi_req_t    ( ariane_axi_soc::req_slv_t  ),
          .axi_resp_t   ( ariane_axi_soc::resp_slv_t )
      ) i_iommu_err_slv (
          .clk_i        ( clk_i             ),
          .rst_ni       ( rst_ni            ),
          .test_i       ( 1'b0              ),
          .slv_req_i    ( axi_iommu_cfg_req ),
          .slv_resp_o   ( axi_iommu_cfg_rsp )
      );

      // Connect directly the device to the System Interconnect
      // S-mode iDMA Master IF <=> IOMMU Completion IF AXI Cut
      `AXI_ASSIGN_FROM_REQ(iommu_comp_cut, axi_iommu_tr_req)
      `AXI_ASSIGN_TO_RESP(axi_iommu_tr_rsp, iommu_comp_cut)

		  // Set Data Structures IF request xVALID/xREADY wires to a known state
      assign iommu_ds_cut.aw_valid  = 1'b0;
      assign iommu_ds_cut.w_valid   = 1'b0;
      assign iommu_ds_cut.b_ready   = 1'b0;
      assign iommu_ds_cut.ar_valid  = 1'b0;
      assign iommu_ds_cut.r_ready   = 1'b0;

      assign irq_sources[153:150] = '0;
    end

    // -----------------------
    // 7. M-mode DMA & IOPMP
    // -----------------------

    // AXI Bus: M-mode iDMA Master <=> IOPMP Receiver Port
    ariane_axi_soc::req_ext_t   axi_iopmp_rp_req;
    ariane_axi_soc::resp_t      axi_iopmp_rp_rsp;

    // AXI Bus: AXI Cut <=> M-mode iDMA Programming Interface
    AXI_BUS #(
      .AXI_ADDR_WIDTH ( AxiAddrWidth             ),
      .AXI_DATA_WIDTH ( AxiDataWidth             ),
      .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
      .AXI_USER_WIDTH ( AxiUserWidth             )
    ) mdma_cfg_cut ();

    // AXI Cut for M-mode iDMA Programming Interface
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth              ),
      .DATA_WIDTH ( AxiDataWidth              ),
      .ID_WIDTH   ( ariane_soc::IdWidthSlave  ),
      .USER_WIDTH ( AxiUserWidth              )
    ) axi_mdma_cfg_cut(
      .clk_i  ( clk_i        ),
      .rst_ni ( rst_ni       ),
      .in     ( mdma_cfg     ),
      .out    ( mdma_cfg_cut )
    );

    // AXI Bus: XBAR <=> AXI Cut (IOPMP Configuration Port)
    AXI_BUS #(
    .AXI_ADDR_WIDTH ( AxiAddrWidth             ),
    .AXI_DATA_WIDTH ( AxiDataWidth             ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AxiUserWidth             )
    ) iopmp_cp_cut ();

    // AXI Cut for IOPMP Configuration Port
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth              ),
      .DATA_WIDTH ( AxiDataWidth              ),
      .ID_WIDTH   ( ariane_soc::IdWidthSlave  ),
      .USER_WIDTH ( AxiUserWidth              )
    ) axi_iopmp_cp_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( iopmp_cfg ),
      .out    ( iopmp_cp_cut )
    );

    // AXI Bus: AXI Cut <=> IOPMP Configuration Port
    ariane_axi_soc::req_slv_t  axi_iopmp_cp_req;
    ariane_axi_soc::resp_slv_t axi_iopmp_cp_rsp;
    `AXI_ASSIGN_TO_REQ(axi_iopmp_cp_req, iopmp_cp_cut)
    `AXI_ASSIGN_FROM_RESP(iopmp_cp_cut, axi_iopmp_cp_rsp)

    // AXI Bus: IOPMP Initiator Port <=> AXI Cut
    AXI_BUS #(
      .AXI_ADDR_WIDTH ( AxiAddrWidth        ),
      .AXI_DATA_WIDTH ( AxiDataWidth        ),
      .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
      .AXI_USER_WIDTH ( AxiUserWidth        )
    ) iopmp_ip_cut ();

    // AXI Cut for IOPMP Initiator Port
    axi_cut_intf #(
      .ADDR_WIDTH ( AxiAddrWidth   ),
      .DATA_WIDTH ( AxiDataWidth   ),
      .ID_WIDTH   ( ariane_soc::IdWidth ),
      .USER_WIDTH ( AxiUserWidth   )
    ) axi_iopmp_ip_master_cut(
      .clk_i  ( clk_i   ),
      .rst_ni ( rst_ni  ),
      .in     ( iopmp_ip_cut ),
      .out    ( iopmp_init )
    );

    // -----------------
    // 7.1. M-mode DMA
    // -----------------
    if (InclMDMA) begin : gen_mdma

      // AXI Bus: M-mode iDMA Master <=> IOPMP Receiver Port
      AXI_BUS_EXT #(
        .AXI_ADDR_WIDTH ( AxiAddrWidth          ),
        .AXI_DATA_WIDTH ( AxiDataWidth          ),
        .AXI_ID_WIDTH   ( ariane_soc::IdWidth   ),
        .AXI_USER_WIDTH ( AxiUserWidth          )
      ) axi_mdma_master ();

      // Conversion from SV interface to req/resp structs
      `AXI_ASSIGN_TO_REQ(axi_iopmp_rp_req, axi_mdma_master)
      `AXI_ASSIGN_FROM_RESP(axi_mdma_master, axi_iopmp_rp_rsp)

      // Manually assign extended signals
      // AW
      assign axi_iopmp_rp_req.aw.stream_id    = axi_mdma_master.aw_stream_id;
      assign axi_iopmp_rp_req.aw.ss_id_valid  = axi_mdma_master.aw_ss_id_valid;
      assign axi_iopmp_rp_req.aw.substream_id = axi_mdma_master.aw_substream_id;
      assign axi_iopmp_rp_req.aw.nsaid        = axi_mdma_master.aw_nsaid;
      // AR
      assign axi_iopmp_rp_req.ar.stream_id    = axi_mdma_master.ar_stream_id;
      assign axi_iopmp_rp_req.ar.ss_id_valid  = axi_mdma_master.ar_ss_id_valid;
      assign axi_iopmp_rp_req.ar.substream_id = axi_mdma_master.ar_substream_id;
      assign axi_iopmp_rp_req.ar.nsaid        = axi_mdma_master.ar_nsaid;

      // M-mode iDMA
      dma_core_wrap_intf #(
        .AXI_ADDR_WIDTH     ( AxiAddrWidth               ),
        .AXI_DATA_WIDTH     ( AxiDataWidth               ),
        .AXI_USER_WIDTH     ( AxiUserWidth               ),
        .AXI_ID_WIDTH       ( ariane_soc::IdWidth        ),
        .AXI_SLV_ID_WIDTH   ( ariane_soc::IdWidthSlave   ),
        .JOB_FIFO_DEPTH     ( 2                          ),
        .NUM_AX_IN_FLIGHT   ( 2                          ),
        .MEM_SYS_DEPTH      ( 0                          ),
        .BUFFER_DEPTH       ( 3                          ),
        .RAW_COUPLING_AVAIL ( 1                          ),
        .IS_TWO_D           ( 0                          ),

        .STREAM_ID          ( 24'd1           ),
        .NSAID              ( 4'd0            ),
        .AxID               ( 5'd0            )
      ) i_mdma (
        .clk_i      		    ( clk_i           ),
        .rst_ni     		    ( rst_ni          ),
        .testmode_i 		    ( 1'b0            ),
        // slave port
        .axi_slave  		    ( mdma_cfg_cut    ),
        // master port
        .axi_master 		    ( axi_mdma_master )
		  );
    end

	  // ---------------
    //  No M-mode DMA
    // ---------------
	  //
	  // When no DMA engine is included, IOPMP Receiver Port xVALID/xREADY wires are set to zero
	  // AXI transactions directed to the DMA Programming Interface are responded with error.
    else begin : gen_mdma_disabled

	    // AXI Bus: AXI Cut <=> M-mode iDMA Error Slave
	    ariane_axi_soc::req_slv_t axi_mdma_cfg_req;
	    ariane_axi_soc::resp_slv_t axi_mdma_cfg_rsp;
	    `AXI_ASSIGN_TO_REQ(axi_mdma_cfg_req, mdma_cfg_cut)
	    `AXI_ASSIGN_FROM_RESP(mdma_cfg_cut, axi_mdma_cfg_rsp)

      // M-mode iDMA Error Slave
      axi_err_slv #(
        .AxiIdWidth ( ariane_soc::IdWidthSlave   ),
        .axi_req_t  ( ariane_axi_soc::req_slv_t  ),
        .axi_resp_t ( ariane_axi_soc::resp_slv_t )
      ) i_mdma_err_slv (
        .clk_i      ( clk_i    				  ),
        .rst_ni     ( rst_ni   				  ),
        .slv_req_i  ( axi_mdma_cfg_req  ),
        .slv_resp_o ( axi_mdma_cfg_rsp  ),
        .test_i     ( 1'b0     				  )
      );

	    // Set Receiver Port request wires to a known state
	    assign axi_iopmp_rp_req.ar_valid    = 1'b0;
      assign axi_iopmp_rp_req.aw_valid    = 1'b0;
      assign axi_iopmp_rp_req.w_valid     = 1'b0;
      assign axi_iopmp_rp_req.b_ready     = 1'b0;
      assign axi_iopmp_rp_req.r_ready     = 1'b0;
    end : gen_mdma_disabled

    // ------------
    //  7.2. IOPMP
    // ------------
    if (InclIOPMP) begin : gen_iopmp

      // AXI Bus: IOPMP Initiator Port <=> AXI Cut
      // Conversion from SV interface to req/resp structs
      ariane_axi_soc::req_t       axi_iopmp_ip_req;
      ariane_axi_soc::resp_t      axi_iopmp_ip_rsp;
      `AXI_ASSIGN_FROM_REQ(iopmp_ip_cut, axi_iopmp_ip_req)
      `AXI_ASSIGN_TO_RESP(axi_iopmp_ip_rsp, iopmp_ip_cut)

      // Memory-mapped Register IF types
      // name, addr_t, data_t, strb_t
      `REG_BUS_TYPEDEF_ALL(iopmp_reg, ariane_axi_soc::addr_t, ariane_axi_soc::data_t, ariane_axi_soc::strb_t)

      riscv_iopmp #(
        // AXI specific parameters
        .ADDR_WIDTH			        ( AxiAddrWidth				     ),
        .DATA_WIDTH			        ( AxiDataWidth				     ),
        .ID_WIDTH			          ( ariane_soc::IdWidth	     ),
        .ID_SLV_WIDTH		        ( ariane_soc::IdWidthSlave ),
        .USER_WIDTH			        ( AxiUserWidth				     ),

        // AXI request/response
        .axi_req_nsaid_t        ( ariane_axi_soc::req_ext_t   ),
        .axi_req_t			        ( ariane_axi_soc::req_t	      ),
        .axi_rsp_t			        ( ariane_axi_soc::resp_t	    ),
        .axi_req_slv_t		      ( ariane_axi_soc::req_slv_t	  ),
        .axi_rsp_slv_t		      ( ariane_axi_soc::resp_slv_t  ),
        // AXI channel structs
        .axi_aw_chan_t          ( ariane_axi_soc::aw_chan_t       ),
        .axi_w_chan_t           ( ariane_axi_soc::w_chan_t	      ),
        .axi_b_chan_t           ( ariane_axi_soc::b_chan_t	      ),
        .axi_ar_chan_t          ( ariane_axi_soc::ar_chan_t       ),
        .axi_r_chan_t           ( ariane_axi_soc::r_chan_t	      ),

        // Register Interface parameters
        .reg_req_t		          ( iopmp_reg_req_t ),
        .reg_rsp_t		          ( iopmp_reg_rsp_t ),

        // Implementation specific
        .NUMBER_MDS             ( 16 ),
        .NUMBER_ENTRIES         ( 32 ),
        .NUMBER_MASTERS         ( 1  )
    ) i_riscv_iopmp (
        .clk_i				      ( clk_i						  ),
        .rst_ni				      ( rst_ni					  ),

        // AXI Config Slave port
        .control_req_i      ( axi_iopmp_cp_req  ),
        .control_rsp_o      ( axi_iopmp_cp_rsp  ),

        // AXI Bus Slave port
        .receiver_req_i     ( axi_iopmp_rp_req  ),
        .receiver_rsp_o     ( axi_iopmp_rp_rsp  ),

        // AXI Bus Master port
        .initiator_req_o    ( axi_iopmp_ip_req  ),
        .initiator_rsp_i    ( axi_iopmp_ip_rsp  ),

        .wsi_wire_o         ( irq_sources[154]  ),

        .iopmp_lock_xor_key_i ( '0              )
    );

    // ----------
    //  No IOPMP
    // ----------
    //
    // When the IOPMP is not included, transactions are bypassed directly to the XBAR.
    // AXI transactions performed to the IOPMP Configuration Port are responded with error.
    end else begin : gen_iopmp_disabled

      // IOPMP Error Slave
      axi_err_slv #(
          .AxiIdWidth   ( ariane_soc::IdWidthSlave   ),
          .axi_req_t    ( ariane_axi_soc::req_slv_t  ),
          .axi_resp_t   ( ariane_axi_soc::resp_slv_t )
      ) i_iopmp_err_slv (
          .clk_i        ( clk_i             ),
          .rst_ni       ( rst_ni            ),
          .test_i       ( 1'b0              ),
          .slv_req_i    ( axi_iopmp_cp_req  ),
          .slv_resp_o   ( axi_iopmp_cp_rsp  )
      );

      // Connect directly the device to the System Interconnect
      // M-mode iDMA Master IF <=> IOPMP Initiator Port AXI Cut
      `AXI_ASSIGN_FROM_REQ(iopmp_ip_cut, axi_iopmp_rp_req)
      `AXI_ASSIGN_TO_RESP(axi_iopmp_rp_rsp, iopmp_ip_cut)

      assign irq_sources[154] = '0;
    end

endmodule

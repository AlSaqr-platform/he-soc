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

module cva6_subsytem 
  import axi_pkg::xbar_cfg_t;
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
  input  logic            clk_i,
  input  logic            rtc_i,
  input  logic            rst_ni,
  input  logic            sync_rst_ni,
  output logic            dm_rst_o,
  input  logic [31*4-1:0] udma_events_i,
  input  logic            cl_dma_pe_evt_i,
  input  logic            dmi_req_valid,
  output logic            dmi_req_ready,
  input  logic [ 6:0]     dmi_req_bits_addr,
  input  logic [ 1:0]     dmi_req_bits_op,
  input  logic [31:0]     dmi_req_bits_data,
  output logic            dmi_resp_valid,
  input  logic            dmi_resp_ready,
  output logic [ 1:0]     dmi_resp_bits_resp,
  output logic [31:0]     dmi_resp_bits_data,
  // JTAG
  input  logic            jtag_TCK,
  input  logic            jtag_TMS,
  input  logic            jtag_TDI,
  input  logic            jtag_TRSTn,
  output logic            jtag_TDO_data,
  output logic            jtag_TDO_driven,
  // CVA6 DEBUG UART
  input  logic            cva6_uart_rx_i,
  output logic            cva6_uart_tx_o,   
  AXI_BUS.Master          l2_axi_master,
  AXI_BUS.Master          apb_axi_master,
  AXI_BUS.Master          hyper_axi_master,
  AXI_BUS.Master          cluster_axi_master,
  AXI_BUS.Slave           cluster_axi_slave
);
     // disable test-enable
  logic        test_en;
  logic        ndmreset;
  logic        ndmreset_n;
  logic        debug_req_core;
  
  logic        jtag_enable;
  logic        init_done;

  logic        debug_req_valid;
  logic        debug_req_ready;
  logic        debug_resp_valid;
  logic        debug_resp_ready;

  logic        jtag_req_valid;
  logic [6:0]  jtag_req_bits_addr;
  logic [1:0]  jtag_req_bits_op;
  logic [31:0] jtag_req_bits_data;
  logic        jtag_resp_ready;
  logic        jtag_resp_valid;

  dm::dmi_req_t  jtag_dmi_req;
  dm::dmi_req_t  dmi_req;

  dm::dmi_req_t  debug_req;
  dm::dmi_resp_t debug_resp;

  assign test_en = 1'b0;
  assign jtag_enable = JtagEnable;
   
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
  ) slave[ariane_soc::NrSlaves-1:0]();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) master[ariane_soc::NB_PERIPHERALS-1:0]();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) hyper_axi_master_cut();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) cluster_axi_master_cut();

   
  assign ndmreset_n = sync_rst_ni;
   
  // ---------------
  // Debug
  // ---------------
  assign init_done = rst_ni;
   
  initial begin
    if (riscv::XLEN != 32 & riscv::XLEN != 64) $error("XLEN different from 32 and 64");
  end

  // debug if MUX
  assign debug_req_valid     = (jtag_enable) ? jtag_req_valid     : dmi_req_valid;
  assign debug_resp_ready    = (jtag_enable) ? jtag_resp_ready    : dmi_resp_ready;
  assign debug_req           = (jtag_enable) ? jtag_dmi_req       : dmi_req;
  assign jtag_resp_valid     = (jtag_enable) ? debug_resp_valid   : 1'b0;
  assign dmi_resp_valid      = (jtag_enable) ? 1'b0               : debug_resp_valid;

  dmi_jtag  #(
    .IdcodeValue ( 32'h20001001)
    ) i_dmi_jtag (
    .clk_i            ( clk_i           ),
    .rst_ni           ( rst_ni          ),
    .testmode_i       ( test_en         ),
    .dmi_req_o        ( jtag_dmi_req    ),
    .dmi_req_valid_o  ( jtag_req_valid  ),
    .dmi_req_ready_i  ( debug_req_ready ),
    .dmi_resp_i       ( debug_resp      ),
    .dmi_resp_ready_o ( jtag_resp_ready ),
    .dmi_resp_valid_i ( jtag_resp_valid ),
    .dmi_rst_no       (                 ), // not connected
    .tck_i            ( jtag_TCK        ),
    .tms_i            ( jtag_TMS        ),
    .trst_ni          ( jtag_TRSTn      ),
    .td_i             ( jtag_TDI        ),
    .td_o             ( jtag_TDO_data   ),
    .tdo_oe_o         ( jtag_TDO_driven )
  );

  assign dmi_req_ready = debug_req_ready ;    
  assign dmi_req.addr = dmi_req_bits_addr;
  assign dmi_req.data = dmi_req_bits_data;
  // SiFive's SimDTM Module
  // Converts to DPI calls
  assign dmi_req.op = dm::dtm_op_e'(dmi_req_bits_op);

  assign dmi_resp_bits_data = debug_resp.data;
  assign dmi_resp_bits_resp = debug_resp.resp;

  // this delay window allows the core to read and execute init code
  // from the bootrom before the first debug request can interrupt
  // core. this is needed in cases where an fsbl is involved that
  // expects a0 and a1 to be initialized with the hart id and a
  // pointer to the dev tree, respectively.
  localparam int unsigned DmiDelCycles = 500;

  logic debug_req_core_ungtd;
  int dmi_del_cnt_d, dmi_del_cnt_q;

  assign dmi_del_cnt_d  = (dmi_del_cnt_q) ? dmi_del_cnt_q - 1 : 0;
  assign debug_req_core = (dmi_del_cnt_q) ? 1'b0 : debug_req_core_ungtd;

  always_ff @(posedge clk_i or negedge rst_ni) begin : p_dmi_del_cnt
    if(!rst_ni) begin
      dmi_del_cnt_q <= DmiDelCycles;
    end else begin
      dmi_del_cnt_q <= dmi_del_cnt_d;
    end
  end

  ariane_axi_soc::req_t    dm_axi_m_req;
  ariane_axi_soc::resp_t   dm_axi_m_resp;

  logic                dm_slave_req;
  logic                dm_slave_we;
  logic [64-1:0]       dm_slave_addr;
  logic [64/8-1:0]     dm_slave_be;
  logic [64-1:0]       dm_slave_wdata;
  logic [64-1:0]       dm_slave_rdata;

  logic                dm_master_req;
  logic [64-1:0]       dm_master_add;
  logic                dm_master_we;
  logic [64-1:0]       dm_master_wdata;
  logic [64/8-1:0]     dm_master_be;
  logic                dm_master_gnt;
  logic                dm_master_r_valid;
  logic [64-1:0]       dm_master_r_rdata;

  // debug module
  dm_top #(
    .NrHarts              ( 1                           ),
    .BusWidth             ( AXI_DATA_WIDTH              ),
    .SelectableHarts      ( 1'b1                        )
  ) i_dm_top (
    .clk_i                ( clk_i                       ),
    .rst_ni               ( rst_ni                      ), // PoR
    .testmode_i           ( test_en                     ),
    .ndmreset_o           ( dm_rst_o                    ),
    .dmactive_o           (                             ), // active debug session
    .debug_req_o          ( debug_req_core_ungtd        ),
    .unavailable_i        ( '0                          ),
    .hartinfo_i           ( {ariane_pkg::DebugHartInfo} ),
    .slave_req_i          ( dm_slave_req                ),
    .slave_we_i           ( dm_slave_we                 ),
    .slave_addr_i         ( dm_slave_addr               ),
    .slave_be_i           ( dm_slave_be                 ),
    .slave_wdata_i        ( dm_slave_wdata              ),
    .slave_rdata_o        ( dm_slave_rdata              ),
    .master_req_o         ( dm_master_req               ),
    .master_add_o         ( dm_master_add               ),
    .master_we_o          ( dm_master_we                ),
    .master_wdata_o       ( dm_master_wdata             ),
    .master_be_o          ( dm_master_be                ),
    .master_gnt_i         ( dm_master_gnt               ),
    .master_r_valid_i     ( dm_master_r_valid           ),
    .master_r_rdata_i     ( dm_master_r_rdata           ),
    .dmi_rst_ni           ( rst_ni                      ),
    .dmi_req_valid_i      ( debug_req_valid             ),
    .dmi_req_ready_o      ( debug_req_ready             ),
    .dmi_req_i            ( debug_req                   ),
    .dmi_resp_valid_o     ( debug_resp_valid            ),
    .dmi_resp_ready_i     ( debug_resp_ready            ),
    .dmi_resp_o           ( debug_resp                  )
  );


  axi2mem #(
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) i_dm_axi2mem (
    .clk_i      ( clk_i                     ),
    .rst_ni     ( rst_ni                    ),
    .slave      ( master[ariane_soc::Debug] ),
    .req_o      ( dm_slave_req              ),
    .we_o       ( dm_slave_we               ),
    .addr_o     ( dm_slave_addr             ),
    .be_o       ( dm_slave_be               ),
    .data_o     ( dm_slave_wdata            ),
    .data_i     ( dm_slave_rdata            )
  );

  `AXI_ASSIGN_FROM_REQ(slave[1],dm_axi_m_req)
  `AXI_ASSIGN_TO_RESP(dm_axi_m_resp,slave[1])

   
  axi_adapter #(
    .DATA_WIDTH            ( AXI_DATA_WIDTH            ),
    .AXI_ID_WIDTH          ( ariane_soc::IdWidth       )
  ) i_dm_axi_master (
    .clk_i                 ( clk_i                     ),
    .rst_ni                ( rst_ni                    ),
    .req_i                 ( dm_master_req             ),
    .type_i                ( ariane_axi::SINGLE_REQ    ),
    .gnt_o                 ( dm_master_gnt             ),
    .gnt_id_o              (                           ),
    .addr_i                ( dm_master_add             ),
    .we_i                  ( dm_master_we              ),
    .wdata_i               ( dm_master_wdata           ),
    .be_i                  ( dm_master_be              ),
    .size_i                ( 2'b11                     ), // always do 64bit here and use byte enables to gate
    .id_i                  ( '0                        ),
    .valid_o               ( dm_master_r_valid         ),
    .rdata_o               ( dm_master_r_rdata         ),
    .id_o                  (                           ),
    .critical_word_o       (                           ),
    .critical_word_valid_o (                           ),
    .axi_req_o             ( dm_axi_m_req              ),
    .axi_resp_i            ( dm_axi_m_resp             )
  );


  // ---------------
  // ROM
  // ---------------
  logic                         rom_req;
  logic [AXI_ADDRESS_WIDTH-1:0] rom_addr;
  logic [AXI_DATA_WIDTH-1:0]    rom_rdata;

  axi2mem #(
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) i_axi2rom (
    .clk_i  ( clk_i                   ),
    .rst_ni ( ndmreset_n              ),
    .slave  ( master[ariane_soc::ROM] ),
    .req_o  ( rom_req                 ),
    .we_o   (                         ),
    .addr_o ( rom_addr                ),
    .be_o   (                         ),
    .data_o (                         ),
    .data_i ( rom_rdata               )
  );

`ifdef DROMAJO
  dromajo_bootrom i_bootrom (
    .clk_i      ( clk_i     ),
    .req_i      ( rom_req   ),
    .addr_i     ( rom_addr  ),
    .rdata_o    ( rom_rdata )
  );
`else
  bootrom i_bootrom (
    .clk_i      ( clk_i     ),
    .req_i      ( rom_req   ),
 `ifdef FPGA_EMUL
    .rst        ( ndmreset_n),
 `endif                   
    .addr_i     ( rom_addr  ),
    .rdata_o    ( rom_rdata )
  );
`endif

  // ---------------
  // AXI L2 Slave
  // ---------------

  `AXI_ASSIGN(l2_axi_master,master[ariane_soc::L2SPM])

  // ---------------
  // AXI APB Slave
  // ---------------

  `AXI_ASSIGN(apb_axi_master,master[ariane_soc::APB_SLVS])


  // ---------------
  // AXI hyperbus Slave 
  // ---------------

  axi_cut_intf #(
    .BYPASS     ( 1'b0                     ),
    .ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .USER_WIDTH ( AXI_USER_WIDTH           )
  ) riscvatomics2axihyper_cut (
    .clk_i,
    .rst_ni ( ndmreset_n                ),
    .in     ( hyper_axi_master_cut      ),
    .out    ( hyper_axi_master          )
  );
                 
  axi_riscv_atomics_wrap #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           ),
    .AXI_MAX_WRITE_TXNS ( 1  ),
    .RISCV_WORD_WIDTH   ( 64 )
  ) i_axi_riscv_atomics0 (
    .clk_i,
    .rst_ni ( ndmreset_n                ),
    .slv    ( master[ariane_soc::HYAXI] ),
    .mst    ( hyper_axi_master_cut      )
  );
   
  // ---------------
  // AXI CLUSTER Slave
  // ---------------

  `AXI_ASSIGN(cluster_axi_master_cut,master[ariane_soc::Cluster])

  axi_cut_intf #(
    .BYPASS     ( 1'b0                     ),
    .ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .USER_WIDTH ( AXI_USER_WIDTH           )
  ) soc2cluster_cut (
    .clk_i,
    .rst_ni ( ndmreset_n                ),
    .in     ( cluster_axi_master_cut    ),
    .out    ( cluster_axi_master        )
  );
   
  // ---------------
  // AXI CLUSTER Master
  // ---------------
  `AXI_ASSIGN(slave[2],cluster_axi_slave)
   
  // ---------------
  // AXI Xbar
  // ---------------
  localparam xbar_cfg_t AXI_XBAR_CFG = '{
                                         NoSlvPorts: ariane_soc::NrSlaves,
                                         NoMstPorts: ariane_soc::NB_PERIPHERALS,
                                         MaxMstTrans: ariane_soc::NB_PERIPHERALS,
                                         MaxSlvTrans: ariane_soc::NrSlaves,
                                         FallThrough: 1'b0,        
                                         LatencyMode: axi_pkg::NO_LATENCY, // If you cut anything, you might want to remove the soc2cluster_cut.
                                         AxiIdWidthSlvPorts: ariane_soc::IdWidth,
                                         AxiIdUsedSlvPorts: ariane_soc::IdWidth,
                                         UniqueIds: 1'b0,
                                         AxiAddrWidth: AXI_ADDRESS_WIDTH,
                                         AxiDataWidth: AXI_DATA_WIDTH,
                                         NoAddrRules: ariane_soc::NB_PERIPHERALS
                                         };

  ariane_soc::addr_map_rule_t [ariane_soc::NB_PERIPHERALS-1:0] addr_map;

 assign addr_map[ariane_soc::Debug] = '{
    idx:  ariane_soc::Debug,
    start_addr: ariane_soc::DebugBase,
    end_addr:   ariane_soc::DebugBase    + ariane_soc::DebugLength  
  };
  assign addr_map[ariane_soc::ROM] = '{ 
    idx:  ariane_soc::ROM,
    start_addr: ariane_soc::ROMBase,
    end_addr:   ariane_soc::ROMBase      + ariane_soc::ROMLength  
  };
  assign addr_map[ariane_soc::UART] = '{ 
    idx:  ariane_soc::UART,
    start_addr: ariane_soc::UARTBase,
    end_addr:   ariane_soc::UARTBase     + ariane_soc::UARTLength  
  };
  assign addr_map[ariane_soc::CLINT] = '{ 
    idx:  ariane_soc::CLINT,
    start_addr: ariane_soc::CLINTBase,
    end_addr:   ariane_soc::CLINTBase    + ariane_soc::CLINTLength  
  };
  assign addr_map[ariane_soc::PLIC] = '{
    idx:  ariane_soc::PLIC,
    start_addr: ariane_soc::PLICBase,
    end_addr:   ariane_soc::PLICBase     + ariane_soc::PLICLength  
  };
  assign addr_map[ariane_soc::Cluster] = '{
    idx:  ariane_soc::Cluster,
    start_addr: ariane_soc::ClusterBase,
    end_addr:   ariane_soc::ClusterBase     + ariane_soc::ClusterLength  
  };
  assign addr_map[ariane_soc::L2SPM] = '{ 
    idx:  ariane_soc::L2SPM,
    start_addr: ariane_soc::L2SPMBase,
    end_addr:   ariane_soc::L2SPMBase     + ariane_soc::L2SPMLength  
  };
  assign addr_map[ariane_soc::APB_SLVS] = '{ 
    idx:  ariane_soc::APB_SLVS,
    start_addr: ariane_soc::APB_SLVSBase,
    end_addr:   ariane_soc::APB_SLVSBase     + ariane_soc::APB_SLVSLength  
  };
  assign addr_map[ariane_soc::Timer] = '{ 
    idx:  ariane_soc::Timer,
    start_addr: ariane_soc::TimerBase,
    end_addr:   ariane_soc::TimerBase    + ariane_soc::TimerLength  
  };
  assign addr_map[ariane_soc::SPI] = '{
    idx:  ariane_soc::SPI,
    start_addr: ariane_soc::SPIBase,
    end_addr:   ariane_soc::SPIBase      + ariane_soc::SPILength  
  };
  assign addr_map[ariane_soc::Ethernet] = '{ 
    idx:  ariane_soc::Ethernet,
    start_addr: ariane_soc::EthernetBase,
    end_addr:   ariane_soc::EthernetBase + ariane_soc::EthernetLength  
  };
  assign addr_map[ariane_soc::HYAXI] = '{ 
    idx:  ariane_soc::HYAXI,
    start_addr: ariane_soc::HYAXIBase,
    end_addr:   ariane_soc::HYAXIBase     + ariane_soc::HYAXILength  
  }; 

  axi_xbar_intf #(
    .AXI_USER_WIDTH         ( AXI_USER_WIDTH                        ),
    .Cfg                    ( AXI_XBAR_CFG                          ),
    .rule_t                 ( ariane_soc::addr_map_rule_t           )
  ) i_xbar (
    .clk_i                  (clk_i),
    .rst_ni                 (ndmreset_n),
    .test_i                 (1'b0),
    .slv_ports              (slave),
    .mst_ports              (master),
    .addr_map_i             (addr_map),
    .en_default_mst_port_i  ('0), // disable default master port for all slave ports
    .default_mst_port_i     ('0)
  );
   
  // ---------------
  // CLINT
  // ---------------
  logic ipi;
  logic timer_irq;

  ariane_axi_soc::req_slv_t    axi_clint_req;
  ariane_axi_soc::resp_slv_t   axi_clint_resp;

  clint #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .NR_CORES       ( 1                        )
  ) i_clint (
    .clk_i       ( clk_i          ),
    .rst_ni      ( ndmreset_n     ),
    .testmode_i  ( test_en        ),
    .axi_req_i   ( axi_clint_req  ),
    .axi_resp_o  ( axi_clint_resp ),
    .rtc_i       ( rtc_i          ),
    .timer_irq_o ( timer_irq      ),
    .ipi_o       ( ipi            )
  );


  `AXI_ASSIGN_TO_REQ(axi_clint_req,master[ariane_soc::CLINT])
  `AXI_ASSIGN_FROM_RESP(master[ariane_soc::CLINT],axi_clint_resp)

  // ---------------
  // Peripherals
  // ---------------
  logic tx, rx;
  logic [1:0] irqs;

  ariane_peripherals #(
    .AxiAddrWidth ( AXI_ADDRESS_WIDTH        ),
    .AxiDataWidth ( AXI_DATA_WIDTH           ),
    .AxiIdWidth   ( ariane_soc::IdWidthSlave ),
`ifndef VERILATOR
  // disable UART when using Spike, as we need to rely on the mockuart
  `ifdef SPIKE_TANDEM
    .InclUART     ( 1'b0                     ),
  `else
    .InclUART     ( 1'b1                     ),
  `endif
`else
    .InclUART     ( 1'b0                     ),
`endif
    .InclSPI      ( 1'b0                     ),
    .InclEthernet ( 1'b0                     )
  ) i_ariane_peripherals (
    .clk_i           ( clk_i                        ),
    .rst_ni          ( ndmreset_n                   ),
    .plic            ( master[ariane_soc::PLIC]     ),
    .uart            ( master[ariane_soc::UART]     ),
    .spi             ( master[ariane_soc::SPI]      ),
    .ethernet        ( master[ariane_soc::Ethernet] ),
    .timer           ( master[ariane_soc::Timer]    ),
    .udma_evt_i      ( udma_events_i                ),
    .cl_dma_pe_evt_i ( cl_dma_pe_evt_i              ),
    .irq_o           ( irqs                         ),
    .rx_i            ( cva6_uart_rx_i               ),
    .tx_o            ( cva6_uart_tx_o               ),
    .eth_txck        ( ),
    .eth_rxck        ( ),
    .eth_rxctl       ( ),
    .eth_rxd         ( ),
    .eth_rst_n       ( ),
    .eth_tx_en       ( ),
    .eth_txd         ( ),
    .phy_mdio        ( ),
    .eth_mdc         ( ),
    .mdio            ( ),
    .mdc             ( ),
    .spi_clk_o       ( ),
    .spi_mosi        ( ),
    .spi_miso        ( ),
    .spi_ss          ( )
  );


  // ---------------
  // Core
  // ---------------
  ariane_axi_soc::req_t    axi_ariane_req;
  ariane_axi_soc::resp_t   axi_ariane_resp;

  ariane #(
    .ArianeCfg  ( ariane_soc::ArianeSocCfg )
  ) i_ariane (
    .clk_i                ( clk_i               ),
    .rst_ni               ( ndmreset_n          ),
    .boot_addr_i          ( ariane_soc::ROMBase ), // start fetching from ROM
    .hart_id_i            ( '0                  ),
    .irq_i                ( irqs                ),
    .ipi_i                ( ipi                 ),
    .time_irq_i           ( timer_irq           ),
// Disable Debug when simulating with Spike
`ifdef SPIKE_TANDEM
    .debug_req_i          ( 1'b0                ),
`else
    .debug_req_i          ( debug_req_core      ),
`endif
    .axi_req_o            ( axi_ariane_req      ),
    .axi_resp_i           ( axi_ariane_resp     )
  );

  axi_master_connect i_axi_master_connect_ariane (
    .axi_req_i(axi_ariane_req),
    .axi_resp_o(axi_ariane_resp),
    .master(slave[0])
  );

  // -------------
  // Simulation Helper Functions
  // -------------
  // check for response errors
  always_ff @(posedge clk_i) begin : p_assert
    if (axi_ariane_req.r_ready &&
      axi_ariane_resp.r_valid &&
      axi_ariane_resp.r.resp inside {axi_pkg::RESP_DECERR, axi_pkg::RESP_SLVERR}) begin
      $warning("R Response Errored");
    end
    if (axi_ariane_req.b_ready &&
      axi_ariane_resp.b_valid &&
      axi_ariane_resp.b.resp inside {axi_pkg::RESP_DECERR, axi_pkg::RESP_SLVERR}) begin
      $warning("B Response Errored");
    end
  end

`ifdef AXI_SVA
  // AXI 4 Assertion IP integration - You will need to get your own copy of this IP if you want
  // to use it
  Axi4PC #(
    .DATA_WIDTH(ariane_axi_soc::DataWidth),
    .WID_WIDTH(ariane_soc::IdWidthSlave),
    .RID_WIDTH(ariane_soc::IdWidthSlave),
    .AWUSER_WIDTH(ariane_axi_soc::UserWidth),
    .WUSER_WIDTH(ariane_axi_soc::UserWidth),
    .BUSER_WIDTH(ariane_axi_soc::UserWidth),
    .ARUSER_WIDTH(ariane_axi_soc::UserWidth),
    .RUSER_WIDTH(ariane_axi_soc::UserWidth),
    .ADDR_WIDTH(ariane_axi_soc::AddrWidth)
  ) i_Axi4PC (
    .ACLK(clk_i),
    .ARESETn(ndmreset_n),
    .AWID(dram.aw_id),
    .AWADDR(dram.aw_addr),
    .AWLEN(dram.aw_len),
    .AWSIZE(dram.aw_size),
    .AWBURST(dram.aw_burst),
    .AWLOCK(dram.aw_lock),
    .AWCACHE(dram.aw_cache),
    .AWPROT(dram.aw_prot),
    .AWQOS(dram.aw_qos),
    .AWREGION(dram.aw_region),
    .AWUSER(dram.aw_user),
    .AWVALID(dram.aw_valid),
    .AWREADY(dram.aw_ready),
    .WLAST(dram.w_last),
    .WDATA(dram.w_data),
    .WSTRB(dram.w_strb),
    .WUSER(dram.w_user),
    .WVALID(dram.w_valid),
    .WREADY(dram.w_ready),
    .BID(dram.b_id),
    .BRESP(dram.b_resp),
    .BUSER(dram.b_user),
    .BVALID(dram.b_valid),
    .BREADY(dram.b_ready),
    .ARID(dram.ar_id),
    .ARADDR(dram.ar_addr),
    .ARLEN(dram.ar_len),
    .ARSIZE(dram.ar_size),
    .ARBURST(dram.ar_burst),
    .ARLOCK(dram.ar_lock),
    .ARCACHE(dram.ar_cache),
    .ARPROT(dram.ar_prot),
    .ARQOS(dram.ar_qos),
    .ARREGION(dram.ar_region),
    .ARUSER(dram.ar_user),
    .ARVALID(dram.ar_valid),
    .ARREADY(dram.ar_ready),
    .RID(dram.r_id),
    .RLAST(dram.r_last),
    .RDATA(dram.r_data),
    .RRESP(dram.r_resp),
    .RUSER(dram.r_user),
    .RVALID(dram.r_valid),
    .RREADY(dram.r_ready),
    .CACTIVE('0),
    .CSYSREQ('0),
    .CSYSACK('0)
  );
`endif
endmodule

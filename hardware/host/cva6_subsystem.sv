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
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

module cva6_subsystem
  import axi_pkg::xbar_cfg_t;
  import apb_soc_pkg::NUM_ADV_TIMER;
  import ariane_soc::*;
  import udma_subsystem_pkg::N_CAN;
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
  parameter type         axi_req_t         = logic,
  parameter type         axi_rsp_t         = logic
) (
  input  logic             clk_i,
  input  logic             rtc_i,
  input  logic             rst_ni,
  input  logic             sync_rst_ni,
  input  logic             cva6_clk_i,
  input  logic             cva6_rst_ni,
  output logic             dm_rst_o,
  input  logic [31*4-1:0]  udma_events_i,
  input  logic             c2h_irq_i,
  input  logic             cluster_eoc_i,
  input  logic [N_CAN-1:0] can_irq_i,
  input  logic [NUM_ADV_TIMER-1 : 0] pwm_irq_i,
  input  logic             cl_dma_pe_evt_i,
  // JTAG
  input  logic             jtag_TCK,
  input  logic             jtag_TMS,
  input  logic             jtag_TDI,
  input  logic             jtag_TRSTn,
  output logic             jtag_TDO_data,
  output logic             jtag_TDO_driven,

  // CVA6 DEBUG UART
  input  logic            cva6_uart_rx_i,
  output logic            cva6_uart_tx_o,

  AXI_BUS.Master          axi_lite_master,
  AXI_BUS.Master          l2_axi_master,
  AXI_BUS.Master          apb_axi_master,
  AXI_BUS.Master          hyper_axi_master,
  AXI_BUS.Master          cluster_axi_master,
  AXI_BUS.Slave           cluster_axi_slave,
  AXI_BUS.Slave           udma_rx_l3_axi_slave,
  AXI_BUS.Slave           udma_tx_l3_axi_slave,

  //ETHERNET
  input  logic            eth_clk_i       , // 125 MHz 0
  input  logic            eth_phy_tx_clk_i, // 125 MHz 90
  input  logic            eth_clk_200MHz_i,

  output eth_to_pad_t     eth_to_pad,
  input  pad_to_eth_t     pad_to_eth,

  // OpenTitan axi master
  input  axi_req_t        ot_axi_req,
  output axi_rsp_t        ot_axi_rsp,

  // SCMI mailbox interrupt to CVA6
  input  logic            irq_mbox_i
);
     // disable test-enable
  logic        test_en;
  logic        ndmreset;
  logic        ndmreset_n;
  logic        [ariane_soc::NumCVA6-1:0] debug_req_core;

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

  dm::dmi_req_t  debug_req;
  dm::dmi_resp_t debug_resp;

  assign test_en = 1'b0;
  assign jtag_enable = JtagEnable;

  AXI_BUS_ASYNC_GRAY #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH      ),
    .LOG_DEPTH      ( 1                   )
  ) cva6_axi_master_dst();

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
  ) hyper_axi_master_redirect();

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
  assign debug_req_valid     = jtag_req_valid;
  assign debug_resp_ready    = jtag_resp_ready;
  assign debug_req           = jtag_dmi_req;
  assign jtag_resp_valid     = debug_resp_valid;

  dmi_jtag  #(
    .IdcodeValue ( ariane_soc::DbgIdCode)
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


  // this delay window allows the core to read and execute init code
  // from the bootrom before the first debug request can interrupt
  // core. this is needed in cases where an fsbl is involved that
  // expects a0 and a1 to be initialized with the hart id and a
  // pointer to the dev tree, respectively.
  localparam int unsigned DmiDelCycles = 500;

  logic [ariane_soc::NumCVA6-1:0] debug_req_core_ungtd;
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

  dm::hartinfo_t [ariane_soc::NumCVA6-1:0] host_hart_info;
  assign host_hart_info = {ariane_soc::NumCVA6{ariane_pkg::DebugHartInfo}};

  // debug module
  dm_top #(
    .NrHarts              ( ariane_soc::NumCVA6         ),
    .BusWidth             ( AXI_DATA_WIDTH              )
  ) i_dm_top (
    .clk_i                ( clk_i                       ),
    .rst_ni               ( rst_ni                      ), // PoR
    .testmode_i           ( test_en                     ),
    .ndmreset_o           ( dm_rst_o                    ),
    .dmactive_o           (                             ), // active debug session
    .debug_req_o          ( debug_req_core_ungtd        ),
    .unavailable_i        ( '0                          ),
    .hartinfo_i           ( host_hart_info              ),
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
    .master_r_other_err_i ( '0                          ),
    .master_r_err_i       ( '0                          ),
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
    .AXI_ADDR_WIDTH        ( AXI_ADDRESS_WIDTH         ),
    .AXI_DATA_WIDTH        ( AXI_DATA_WIDTH            ),
    .AXI_ID_WIDTH          ( ariane_soc::IdWidth       ),
    .axi_req_t             ( ariane_axi_soc::req_t     ),
    .axi_rsp_t             ( ariane_axi_soc::resp_t    )
  ) i_dm_axi_master (
    .clk_i                 ( clk_i                     ),
    .rst_ni                ( rst_ni                    ),
    .req_i                 ( dm_master_req             ),
    .type_i                ( ariane_axi::SINGLE_REQ    ),
    .trans_type_i          ( ace_pkg::READ_SHARED      ),
    .amo_i                 ( ariane_pkg::AMO_NONE      ),
    .busy_o                (                           ),
    .gnt_o                 ( dm_master_gnt             ),
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
    .dirty_o               (                           ),
    .shared_o              (                           ),
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

  axi_riscv_atomics_wrap #(
    .AXI_ADDR_WIDTH     ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH       ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH           ),
    .AXI_MAX_READ_TXNS  ( 8                        ),
    .AXI_MAX_WRITE_TXNS ( 8                        ),
    .RISCV_WORD_WIDTH   ( 64                       )
  ) i_axi_riscv_atomicsl2 (
    .clk_i,
    .rst_ni ( ndmreset_n                ),
    .slv    ( master[ariane_soc::L2SPM] ),
    .mst    ( l2_axi_master             )
  );

  // ---------------
  // AXI APB Slave
  // ---------------

  `AXI_ASSIGN(apb_axi_master,master[ariane_soc::APB_SLVS])


  // ---------------
  // AXI OpenTitan Master
  // ---------------

  `AXI_ASSIGN_FROM_REQ(slave[3], ot_axi_req)
  `AXI_ASSIGN_TO_RESP (ot_axi_rsp, slave[3])

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
    .out    ( hyper_axi_master_redirect )
  );

  `ifdef L3_TCSRAM
  l3_onchip_subsystem # (
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
    ) l3_tcsram (
                                    .clk_i ( clk_i                     ),
                                    .rst_ni( ndmreset_n                ),
                                    .slv   ( hyper_axi_master_redirect )
                                    );
   assign hyper_axi_master.aw_valid = 1'b0;
   assign hyper_axi_master.ar_valid = 1'b0;
   assign hyper_axi_master.w_valid  = 1'b0;
  `else // !`ifdef L3_TCSRAM
    `AXI_ASSIGN(hyper_axi_master,hyper_axi_master_redirect);
  `endif



  axi_riscv_atomics_wrap #(
    .AXI_ADDR_WIDTH     ( AXI_ADDRESS_WIDTH        ),
    .AXI_DATA_WIDTH     ( AXI_DATA_WIDTH           ),
    .AXI_ID_WIDTH       ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH           ),
    .AXI_MAX_READ_TXNS  ( 8                        ),
    .AXI_MAX_WRITE_TXNS ( 8                        ),
    .RISCV_WORD_WIDTH   ( 64                       )
  ) i_axi_riscv_atomicsl3 (
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
  // AXI uDMA TX L3 Master (READ ONLY from MEM)
  // ---------------
  `AXI_ASSIGN(slave[4],udma_tx_l3_axi_slave)

  // ---------------
  // AXI uDMA RX L3 Master (WRITE ONLY to MEM)
  // ---------------
  `AXI_ASSIGN(slave[5],udma_rx_l3_axi_slave)

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
                                         PipelineStages: 32'd0,
                                         AxiIdWidthSlvPorts: ariane_soc::IdWidth,
                                         AxiIdUsedSlvPorts: ariane_soc::IdWidth,
                                         UniqueIds: 1'b0,
                                         AxiAddrWidth: AXI_ADDRESS_WIDTH,
                                         AxiDataWidth: AXI_DATA_WIDTH,
                                         NoAddrRules: ariane_soc::NB_PERIPHERALS + 1
                                         };

  ariane_soc::addr_map_rule_t [ariane_soc::NB_PERIPHERALS:0] addr_map; // One extra for the LLCSPM

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

  assign addr_map[ariane_soc::UART] = '{
    idx:  ariane_soc::UART,
    start_addr: ariane_soc::UARTBase,
    end_addr:   ariane_soc::UARTBase     + ariane_soc::UARTLength
  };

  assign addr_map[ariane_soc::DMA_CFG] = '{ 
    idx:        ariane_soc::DMA_CFG,
    start_addr: ariane_soc::DMABase,
    end_addr:   ariane_soc::DMABase + ariane_soc::DMALength
  };

  assign addr_map[ariane_soc::IOPMP_CFG] = '{
    idx:        ariane_soc::IOPMP_CFG,
    start_addr: ariane_soc::IOPMPBase,
    end_addr:   ariane_soc::IOPMPBase + ariane_soc::IOPMPLength
  };

  assign addr_map[ariane_soc::AXILiteDom] = '{
    idx:  ariane_soc::AXILiteDom,
    start_addr: ariane_soc::AXILiteBase,
    end_addr:   ariane_soc::AXILiteBase + ariane_soc::AXILiteLength
  };

  assign addr_map[ariane_soc::HYAXI] = '{
    idx:  ariane_soc::HYAXI,
    start_addr: ariane_soc::HYAXIBase,
    end_addr:   ariane_soc::HYAXIBase     + ariane_soc::HYAXILength
  };

  assign addr_map[ariane_soc::HYAXI+1] = '{
    idx:  ariane_soc::HYAXI,
    start_addr: ariane_soc::LLCSPMBase,
    end_addr:   ariane_soc::LLCSPMBase     + ariane_soc::LLCSPMLength
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

  // --------------------
  // AXI Lite Slave
  // --------------------

  `AXI_ASSIGN(axi_lite_master, master[ariane_soc::AXILiteDom])

  // ---------------
  // CLINT
  // ---------------
  // divide clock by two
  logic [ariane_soc::NumCVA6-1:0] ipi;
  logic [ariane_soc::NumCVA6-1:0] timer_irq;
  logic rtc_clint;

  ariane_axi_soc::req_slv_t    axi_clint_req;
  ariane_axi_soc::resp_slv_t   axi_clint_resp;

  always_ff @(posedge rtc_i or negedge ndmreset_n) begin
    if (~ndmreset_n) begin
      rtc_clint <= 0;
    end else begin
      rtc_clint <= rtc_clint ^ 1'b1;
    end
  end

  clint #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH          ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH             ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave   ),
    .NR_CORES       ( ariane_soc::NumCVA6        ),
    .axi_req_slv_t  ( ariane_axi_soc::req_slv_t  ),
    .axi_rsp_slv_t  ( ariane_axi_soc::resp_slv_t )
  ) i_clint (
    .clk_i       ( clk_i          ),
    .rst_ni      ( ndmreset_n     ),
    .testmode_i  ( test_en        ),
    .axi_req_i   ( axi_clint_req  ),
    .axi_resp_o  ( axi_clint_resp ),
    .rtc_i       ( rtc_clint      ),
    .timer_irq_o ( timer_irq      ),
    .ipi_o       ( ipi            )
  );


  `AXI_ASSIGN_TO_REQ(axi_clint_req,master[ariane_soc::CLINT])
  `AXI_ASSIGN_FROM_RESP(master[ariane_soc::CLINT],axi_clint_resp)

  // ---------------
  // Peripherals
  // ---------------
  logic tx, rx;
  logic [ariane_soc::NumCVA6-1:0][1:0] irqs;

  ariane_peripherals #(
    .NumCVA6      ( ariane_soc::NumCVA6      ),
    .AxiAddrWidth ( AXI_ADDRESS_WIDTH        ),
    .AxiDataWidth ( AXI_DATA_WIDTH           ),
    .AxiIdWidth   ( ariane_soc::IdWidthSlave ),
`ifdef TARGET_SYNTHESIS
    .InclUART     ( 1'b1                     ),
`else
    .InclUART     ( 1'b0                     ),
`endif
`ifdef TARGET_FPGA
    .InclSPI      ( 1'b1                     ),
`else
    .InclSPI      ( 1'b0                     ),
`endif
    .InclEthernet ( 1'b1                     ),
    .InclDMA      ( 1'b1                     ),
    .InclIOPMP    ( 1'b1                     )
  ) i_ariane_peripherals (
    .clk_i           ( clk_i                        ),
    .rst_ni          ( ndmreset_n                   ),
    .plic            ( master[ariane_soc::PLIC]     ),
    .uart            ( master[ariane_soc::UART]     ),
    .spi             ( master[ariane_soc::SPI]      ),
    .ethernet        ( master[ariane_soc::Ethernet] ),
    .timer           ( master[ariane_soc::Timer]    ),
    .dma_cfg         ( master[ariane_soc::DMA_CFG]  ),
    .iopmp_init      ( slave[6]                     ),
    .iopmp_cfg       ( master[ariane_soc::IOPMP_CFG]),
    .udma_evt_i      ( udma_events_i                ),
    .cluster_eoc_i   ( cluster_eoc_i                ),
    .c2h_irq_i       ( c2h_irq_i                    ),
    .can_irq_i       ( can_irq_i                    ),
    .pwm_irq_i       ( pwm_irq_i                    ),
    .cl_dma_pe_evt_i ( cl_dma_pe_evt_i              ),
    .irq_o           ( irqs                         ),
    .rx_i            ( cva6_uart_rx_i               ),
    .tx_o            ( cva6_uart_tx_o               ),

    .eth_clk_i        ( eth_clk_i                   ),
    .eth_phy_tx_clk_i ( eth_phy_tx_clk_i            ),
    .eth_clk_200MHz_i ( eth_clk_200MHz_i            ),

    .eth_to_pad       ( eth_to_pad                  ),
    .pad_to_eth       ( pad_to_eth                  ),

    .irq_mbox_i
  );

  // ---------------
  // Core
  // ---------------

  cva6_synth_wrap i_ariane_wrap (
    .clk_i                ( cva6_clk_i                  ),
    .rst_ni               ( cva6_rst_ni                 ),
    .boot_addr_i          ( ariane_soc::ROMBase         ), // start fetching from ROM
    .irq_i                ( irqs                        ), // async signal
    .ipi_i                ( ipi                         ), // async signal
    .time_irq_i           ( timer_irq                   ), // async signal
    .debug_req_i          ( debug_req_core              ), // async signal
    .data_master_aw_wptr_o( cva6_axi_master_dst.aw_wptr ),
    .data_master_aw_data_o( cva6_axi_master_dst.aw_data ),
    .data_master_aw_rptr_i( cva6_axi_master_dst.aw_rptr ),
    .data_master_ar_wptr_o( cva6_axi_master_dst.ar_wptr ),
    .data_master_ar_data_o( cva6_axi_master_dst.ar_data ),
    .data_master_ar_rptr_i( cva6_axi_master_dst.ar_rptr ),
    .data_master_w_wptr_o ( cva6_axi_master_dst.w_wptr  ),
    .data_master_w_data_o ( cva6_axi_master_dst.w_data  ),
    .data_master_w_rptr_i ( cva6_axi_master_dst.w_rptr  ),
    .data_master_r_wptr_i ( cva6_axi_master_dst.r_wptr  ),
    .data_master_r_data_i ( cva6_axi_master_dst.r_data  ),
    .data_master_r_rptr_o ( cva6_axi_master_dst.r_rptr  ),
    .data_master_b_wptr_i ( cva6_axi_master_dst.b_wptr  ),
    .data_master_b_data_i ( cva6_axi_master_dst.b_data  ),
    .data_master_b_rptr_o ( cva6_axi_master_dst.b_rptr  )
  );

  axi_cdc_dst_intf #(
    .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH         ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH            ),
    .AXI_ID_WIDTH   ( ariane_soc::IdWidth       ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH            ),
    .LOG_DEPTH      ( 1                         ),
    .SYNC_STAGES    ( ariane_soc::CdcSyncStages )
    ) cva6_to_xbar (
      .src(cva6_axi_master_dst),
      .dst_clk_i(clk_i),
      .dst_rst_ni(ndmreset_n),
      .dst(slave[0])
      );

endmodule

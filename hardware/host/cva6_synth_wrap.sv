// Copyright 2017-2019 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Luca Valente
// Date: 13.01.2021
// Description: Ariane synth wrapper

`include "ace/typedef.svh"
`include "ace/assign.svh"
`define APMU_IP

module cva6_synth_wrap
 import ariane_pkg::*;
 import ariane_soc::*;
 import ariane_ace_soc::ar_chan_t;
 import ariane_ace_soc::aw_chan_t;
 import ariane_ace_soc::req_t;
 import ariane_ace_soc::resp_t;
 import ariane_axi_soc::*;
 import snoop_pkg::*;
 import cv64a6_imafdch_wb_sv39_alsaqr_pkg::*;
 import ace_pkg::ccu_cfg_t; #(

  localparam AXI_ID_WIDTH       = 5,
  localparam AXI_ADDR_WIDTH     = 64,
  localparam AXI_USER_WIDTH     = ariane_axi_soc::UserWidth,
  localparam AXI_DATA_WIDTH     = 64,
  localparam AXI_STRB_WIDTH     = AXI_ADDR_WIDTH/8,
  localparam LOG_DEPTH          = 1,

  localparam AW_WIDTH           = AXI_ID_WIDTH+AXI_ADDR_WIDTH+AXI_USER_WIDTH+$bits(axi_pkg::len_t)+$bits(axi_pkg::size_t)+$bits(axi_pkg::burst_t)+$bits(axi_pkg::cache_t)+$bits(axi_pkg::prot_t)+$bits(axi_pkg::qos_t)+$bits(axi_pkg::region_t)+$bits(axi_pkg::atop_t)+1,
  localparam W_WIDTH            = AXI_USER_WIDTH+AXI_STRB_WIDTH+AXI_DATA_WIDTH+1,
  localparam R_WIDTH            = AXI_ID_WIDTH+AXI_DATA_WIDTH+AXI_USER_WIDTH+$bits(axi_pkg::resp_t)+1,
  localparam B_WIDTH            = AXI_USER_WIDTH+AXI_ID_WIDTH+$bits(axi_pkg::resp_t),
  localparam AR_WIDTH           = AXI_ID_WIDTH+AXI_ADDR_WIDTH+AXI_USER_WIDTH+$bits(axi_pkg::len_t)+$bits(axi_pkg::size_t)+$bits(axi_pkg::burst_t)+$bits(axi_pkg::cache_t)+$bits(axi_pkg::prot_t)+$bits(axi_pkg::qos_t)+$bits(axi_pkg::region_t)+1,

  localparam ASYNC_AW_DATA_WIDTH = (2**LOG_DEPTH)*AW_WIDTH,
  localparam ASYNC_W_DATA_WIDTH  = (2**LOG_DEPTH)*W_WIDTH,
  localparam ASYNC_B_DATA_WIDTH  = (2**LOG_DEPTH)*B_WIDTH,
  localparam ASYNC_AR_DATA_WIDTH = (2**LOG_DEPTH)*AR_WIDTH,
  localparam ASYNC_R_DATA_WIDTH  = (2**LOG_DEPTH)*R_WIDTH
)  (
  input  logic                         clk_i,
  input  logic                         rst_ni,
  // Core ID, Cluster ID and boot address are considered more or less static
  input  logic [riscv::VLEN-1:0]       boot_addr_i,  // reset boot address
  // Interrupt inputs
  input  logic [ariane_soc::NumCVA6-1:0][1:0] irq_i,        // level sensitive IR lines, mip & sip (async)
  input  logic [ariane_soc::NumCVA6-1:0]      ipi_i,        // inter-processor interrupts (async)
  // Timer facilities
  input  logic [ariane_soc::NumCVA6-1:0]      time_irq_i,   // timer interrupt in (async)
  input  logic [ariane_soc::NumCVA6-1:0]      debug_req_i,  // debug request (async)

  // memory side, AXI Master
  // AXI4 MASTER
  //***************************************
  // WRITE ADDRESS CHANNEL
  output logic [LOG_DEPTH:0]                  data_master_aw_wptr_o,
  output logic [ASYNC_AW_DATA_WIDTH-1:0]      data_master_aw_data_o,
  input logic [LOG_DEPTH:0]                   data_master_aw_rptr_i,

  // READ ADDRESS CHANNEL
  output logic [LOG_DEPTH:0]                  data_master_ar_wptr_o,
  output logic [ASYNC_AR_DATA_WIDTH-1:0]      data_master_ar_data_o,
  input logic [LOG_DEPTH:0]                   data_master_ar_rptr_i,

  // WRITE DATA CHANNEL
  output logic [LOG_DEPTH:0]                  data_master_w_wptr_o,
  output logic [ASYNC_W_DATA_WIDTH-1:0]       data_master_w_data_o,
  input logic [LOG_DEPTH:0]                   data_master_w_rptr_i,

  // READ DATA CHANNEL
  input logic [LOG_DEPTH:0]                   data_master_r_wptr_i,
  input logic [ASYNC_R_DATA_WIDTH-1:0]        data_master_r_data_i,
  output logic [LOG_DEPTH:0]                  data_master_r_rptr_o,

  // WRITE RESPONSE CHANNEL
  input logic [LOG_DEPTH:0]                   data_master_b_wptr_i,
  input logic [ASYNC_B_DATA_WIDTH-1:0]        data_master_b_data_i,
  output logic [LOG_DEPTH:0]                  data_master_b_rptr_o,

  // APMU
  output pmu_pkg::pmu_event_t [ariane_soc::NumCVA6-1:0] spu_core_o

);

`ifdef APMU_IP
  ACE_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( CVA6AXIIdWidth ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) core_to_SPU[ariane_soc::NumCVA6-1:0]();

  ACE_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( CVA6AXIIdWidth ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) SPU_to_CCU[ariane_soc::NumCVA6-1:0]();
`else
  ACE_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( CVA6AXIIdWidth ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) core_to_CCU[ariane_soc::NumCVA6-1:0]();
`endif

  SNOOP_BUS  #(
    .SNOOP_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .SNOOP_DATA_WIDTH ( AXI_DATA_WIDTH )
  ) CCU_to_core[ariane_soc::NumCVA6-1:0]();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( CCUAXIIdWidth  ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) ccu_axi_master();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( CCUAXIIdWidth  ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) ccu_axi_master_cut();

  AXI_BUS #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH )
  ) cva6_axi_master();

  AXI_BUS_ASYNC_GRAY #(
    .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
    .AXI_ID_WIDTH   ( AXI_ID_WIDTH   ),
    .AXI_USER_WIDTH ( AXI_USER_WIDTH ),
    .LOG_DEPTH      ( 1    )
  ) cva6_axi_master_src();


  ariane_ace_soc::req_t [ariane_soc::NumCVA6-1:0] ace_ariane_req;
  ariane_ace_soc::resp_t [ariane_soc::NumCVA6-1:0] ace_ariane_resp;

  logic [ariane_soc::NumCVA6-1:0][1:0] hart_id;

  for (genvar i = 0; i < ariane_soc::NumCVA6 ; i++ ) begin : gen_ariane

    assign hart_id[i] = i;

    cva6 #(
      .CVA6Cfg       ( ArianeSocCfg ),
      .axi_ar_chan_t ( ariane_ace_soc::ar_chan_t ),
      .axi_aw_chan_t ( ariane_ace_soc::aw_chan_t ),
      .axi_w_chan_t  ( ariane_axi_soc::w_chan_t  ),
      .b_chan_t      ( ariane_axi_soc::b_chan_t  ),
      .r_chan_t      ( ariane_ace_soc::r_chan_t  ),
      .noc_req_t     ( ariane_ace_soc::req_t     ),
      .noc_resp_t    ( ariane_ace_soc::resp_t    )
    ) i_ariane (
      .clk_i                ( clk_i                 ),
      .rst_ni               ( rst_ni                ),
      .boot_addr_i          ( ariane_soc::ROMBase   ), // start fetching from ROM
      .hart_id_i            ( { 62'h0, hart_id[i] } ),
      .irq_i                ( irq_i[i][1:0]         ),
      .ipi_i                ( ipi_i[i]              ),
      .time_irq_i           ( time_irq_i[i]         ),
      .debug_req_i          ( debug_req_i[i]        ),
      .clic_irq_valid_i     ( '0                    ),
      .clic_irq_id_i        ( '0                    ),
      .clic_irq_level_i     ( '0                    ),
      .clic_irq_priv_i      ( riscv::PRIV_LVL_M     ),
      .clic_irq_shv_i       ( 1'b0                  ),
      .clic_irq_ready_o     (                       ),
      .clic_kill_req_i      ( 1'b0                  ),
      .clic_kill_ack_o      (                       ),
      .rvfi_probes_o        (                       ),
      .cvxif_req_o          (                       ),
      .cvxif_resp_i         ( '0                    ),
      .noc_req_o            ( ace_ariane_req[i]     ),
      .noc_resp_i           ( ace_ariane_resp[i]    )
    );

  `ifdef APMU_IP
    `ACE_ASSIGN_FROM_REQ(core_to_SPU[i], ace_ariane_req[i])
    `ACE_ASSIGN_TO_RESP(ace_ariane_resp[i], core_to_SPU[i])
  `else
    `ACE_ASSIGN_FROM_REQ(core_to_CCU[i], ace_ariane_req[i])
    `ACE_ASSIGN_TO_RESP(ace_ariane_resp[i], core_to_CCU[i])
  `endif

    `SNOOP_ASSIGN_FROM_RESP(CCU_to_core[i], ace_ariane_req[i])
    `SNOOP_ASSIGN_TO_REQ(ace_ariane_resp[i], CCU_to_core[i])

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

    spu_top #(
      // Static configuration parameters of the cache.
      .SetAssociativity   ( ariane_soc::LLC_SET_ASSOC    ),
      .NumLines           ( ariane_soc::LLC_NUM_LINES    ),
      .NumBlocks          ( ariane_soc::LLC_NUM_BLOCKS   ),
      // AXI4 Specifications
      .IdWidthMasters     ( ariane_soc::IdWidth          ),
      .IdWidthSlaves      ( ariane_soc::IdWidthSlave+ 1  ),
      .AddrWidth          ( AXI_ADDR_WIDTH               ),
      .DataWidth          ( AXI_DATA_WIDTH               ),
      // Address Indexing
      .addr_rule_t        ( ariane_soc::addr_map_rule_t  ),
      .N_ADDR_RULES       ( N_ADDR_RULES                 ),
      // FIFO and CAM Parameters
      .CAM_DEPTH          ( 17                           ),
      .FIFO_DEPTH         (  8                           )
    ) i_spu_core_llc (
      .clk_i              ( clk_i                        ),
      .rst_ni             ( rst_ni                       ),
      .addr_map_i         ( spu_mem_addr_map             ),
      .spu_slv            ( core_to_SPU[i]               ),
      .spu_mst            ( SPU_to_CCU[i]                ),
      .e_out              ( spu_core_o[i]                )
    );
    `else 
      spu_core_o[i].e_id   = '0;
      spu_core_o[i].e_info = '0;
      spu_core_o[i].s_id   = '0;
    `endif

  end // block: gen_ariane

  localparam ace_pkg::ccu_cfg_t CCU_CFG = '{
    NoSlvPorts: ariane_soc::NumCVA6,
    MaxMstTrans: 2, // Probably requires update
    MaxSlvTrans: 2, // Probably requires update
    FallThrough: 1'b0,
    LatencyMode: ace_pkg::NO_LATENCY,
    AxiIdWidthSlvPorts:CVA6AXIIdWidth,
    AxiIdUsedSlvPorts: CVA6AXIIdWidth,
    UniqueIds: 1'b1,
    AxiAddrWidth: AXI_ADDR_WIDTH,
    AxiDataWidth: AXI_DATA_WIDTH,
    AxiUserWidth: AXI_USER_WIDTH,
    DcacheLineWidth: ariane_pkg::DCACHE_LINE_WIDTH,
    DcacheIndexWidth: ariane_pkg::DCACHE_INDEX_WIDTH
  };

  ace_ccu_top_intf #(
    .Cfg            ( CCU_CFG        )
  ) i_ccu (
    .clk_i                 ( clk_i           ),
    .rst_ni                ( rst_ni          ),
    .test_i                ( 1'b0            ),
`ifdef APMU_IP
    .slv_ports             ( SPU_to_CCU      ),
`else
    .slv_ports             ( core_to_CCU     ),
`endif
    .snoop_ports           ( CCU_to_core     ),
    .mst_ports             ( ccu_axi_master_cut  )
  );

  axi_cut_intf #(
    .BYPASS     ( 1'b0           ),
    .ADDR_WIDTH ( AXI_ADDR_WIDTH ),
    .DATA_WIDTH ( AXI_DATA_WIDTH ),
    .ID_WIDTH   ( CCUAXIIdWidth  ),
    .USER_WIDTH ( AXI_USER_WIDTH )
  )  i_ccu_cut (
    .clk_i  ( clk_i                 ),
    .rst_ni ( rst_ni                ),
    .in     ( ccu_axi_master_cut    ),
    .out    ( ccu_axi_master        )
  );

  axi_id_remap_intf #(
    .AXI_SLV_PORT_ID_WIDTH     ( CCUAXIIdWidth  ),
    .AXI_SLV_PORT_MAX_UNIQ_IDS ( 4              ),
    .AXI_MAX_TXNS_PER_ID       ( 1              ),
    .AXI_MST_PORT_ID_WIDTH     ( AXI_ID_WIDTH   ),
    .AXI_ADDR_WIDTH            ( AXI_ADDR_WIDTH ),
    .AXI_DATA_WIDTH            ( AXI_DATA_WIDTH ),
    .AXI_USER_WIDTH            ( AXI_USER_WIDTH )
  ) i_axi_id_remapper (
      .clk_i  ( clk_i           ),
      .rst_ni ( rst_ni          ),
      .slv    ( ccu_axi_master  ),
      .mst    ( cva6_axi_master )
  );

   axi_cdc_src_intf #(
     .AXI_ID_WIDTH   ( AXI_ID_WIDTH   ),
     .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH ),
     .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH ),
     .LOG_DEPTH      ( 1              )
   ) cva6tosocdomainfifo (
       .src_clk_i  ( clk_i               ),
       .src_rst_ni ( rst_ni              ),
       .src        ( cva6_axi_master     ),
       .dst        ( cva6_axi_master_src )
   );

   assign data_master_aw_wptr_o = cva6_axi_master_src.aw_wptr;
   assign data_master_aw_data_o = cva6_axi_master_src.aw_data;
   assign cva6_axi_master_src.aw_rptr = data_master_aw_rptr_i ;

   assign data_master_ar_wptr_o = cva6_axi_master_src.ar_wptr;
   assign data_master_ar_data_o = cva6_axi_master_src.ar_data;
   assign cva6_axi_master_src.ar_rptr = data_master_ar_rptr_i ;

   assign data_master_w_wptr_o = cva6_axi_master_src.w_wptr;
   assign data_master_w_data_o = cva6_axi_master_src.w_data;
   assign cva6_axi_master_src.w_rptr = data_master_w_rptr_i ;

   assign cva6_axi_master_src.r_wptr = data_master_r_wptr_i;
   assign cva6_axi_master_src.r_data = data_master_r_data_i;
   assign data_master_r_rptr_o = cva6_axi_master_src.r_rptr;

   assign cva6_axi_master_src.b_wptr = data_master_b_wptr_i;
   assign cva6_axi_master_src.b_data = data_master_b_data_i;
   assign data_master_b_rptr_o = cva6_axi_master_src.b_rptr;

  // -------------
  // Simulation Helper Functions
  // -------------
  // check for response errors
  always_ff @(posedge clk_i) begin : p_assert
    if (cva6_axi_master.r_ready &&
      cva6_axi_master.r_valid &&
      cva6_axi_master.r_resp inside {axi_pkg::RESP_DECERR, axi_pkg::RESP_SLVERR}) begin
      $warning("R Response Errored");
    end
    if (cva6_axi_master.b_ready &&
      cva6_axi_master.b_valid &&
      cva6_axi_master.b_resp inside {axi_pkg::RESP_DECERR, axi_pkg::RESP_SLVERR}) begin
      $warning("B Response Errored");
    end
  end

endmodule // cva6_synth_wrap

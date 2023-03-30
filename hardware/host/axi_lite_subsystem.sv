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

module axi_lite_subsystem
  import ariane_soc::IdWidthSlave;
  import axi_pkg::*;
#( 
    parameter int unsigned AXI_USER_WIDTH = 1,
    parameter int unsigned AXI_ADDR_WIDTH = 64,
    parameter int unsigned AXI_DATA_WIDTH = 64,
    parameter int unsigned AXI_LITE_ADDR_WIDTH = 32,
    parameter int unsigned AXI_LITE_DATA_WIDTH = 32
) (
    input logic      clk_i,
    input logic      rst_ni,
   
    AXI_BUS.Slave    host_axi_lite_slave,
    AXI_BUS.Slave    cluster_axi_lite_slave,
   
    AXI_LITE.Master  c2h_tlb_cfg_master,
    AXI_LITE.Master  llc_cfg_master,

    output logic     h2c_irq_o,
    output logic     c2h_irq_o,

    output logic     doorbell_irq_o,
    output logic     completion_irq_o
);

   logic             s_c2h_irq;
   
   ariane_axi_soc::req_lite_t llc_cfg_req,     
                              h2c_tlb_cfg_req, 
                              c2h_tlb_cfg_req, 
                              host_lite_req,   
                              cluster_lite_req,
                              h2cmailbox_lite_req,
                              c2hmailbox_lite_req,
                              axi_mbox_req;
     
   ariane_axi_soc::resp_lite_t llc_cfg_resp,     
                               h2c_tlb_cfg_resp, 
                               c2h_tlb_cfg_resp, 
                               host_lite_resp,   
                               cluster_lite_resp,
                               h2cmailbox_lite_resp,
                               c2hmailbox_lite_resp,
                               axi_mbox_rsp;
   

  AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_LITE_ADDR_WIDTH),
    .AXI_DATA_WIDTH (AXI_LITE_DATA_WIDTH)
  ) cluster_axi_lite_xbar_master();
   
  AXI_LITE #(
    .AXI_ADDR_WIDTH (AXI_LITE_ADDR_WIDTH),
    .AXI_DATA_WIDTH (AXI_LITE_DATA_WIDTH)
  ) host_axi_lite_xbar_master();

  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH           ),
     .AXI_DATA_WIDTH ( AXI_LITE_DATA_WIDTH      ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) host_axi_lite_32 ();
   
  AXI_BUS #(
     .AXI_ADDR_WIDTH ( AXI_ADDR_WIDTH           ),
     .AXI_DATA_WIDTH ( AXI_LITE_DATA_WIDTH      ),
     .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
     .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
  ) cluster_axi_lite_32 ();

  axi_dw_converter_intf #(
    .AXI_ID_WIDTH             ( ariane_soc::IdWidthSlave ),
    .AXI_ADDR_WIDTH           ( AXI_ADDR_WIDTH           ),
    .AXI_SLV_PORT_DATA_WIDTH  ( AXI_DATA_WIDTH           ),
    .AXI_MST_PORT_DATA_WIDTH  ( AXI_LITE_DATA_WIDTH      ),
    .AXI_USER_WIDTH           ( AXI_USER_WIDTH           ),
    .AXI_MAX_READS            ( 1                        )
  ) i_dwc_host (
    .clk_i        ( clk_i               ),
    .rst_ni       ( rst_ni              ),
    .slv          ( host_axi_lite_slave ),
    .mst          ( host_axi_lite_32    )
  );

  axi_to_axi_lite_intf #(
    .AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH           ),
    .AXI_DATA_WIDTH     ( AXI_LITE_DATA_WIDTH      ),
    .AXI_ID_WIDTH       ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH           ),
    .AXI_MAX_WRITE_TXNS ( 1                        ),
    .AXI_MAX_READ_TXNS  ( 1                        ),
    .FALL_THROUGH       ( 1'b0                     )
  ) i_axi_to_axi_lite_host (
    .clk_i       ( clk_i                     ),
    .rst_ni      ( rst_ni                    ),
    .testmode_i  ( 1'b0                      ),
    .slv         ( host_axi_lite_32          ),
    .mst         ( host_axi_lite_xbar_master )
  );

  axi_dw_converter_intf #(
    .AXI_ID_WIDTH             ( ariane_soc::IdWidthSlave ),
    .AXI_ADDR_WIDTH           ( AXI_ADDR_WIDTH           ),
    .AXI_SLV_PORT_DATA_WIDTH  ( AXI_DATA_WIDTH           ),
    .AXI_MST_PORT_DATA_WIDTH  ( AXI_LITE_DATA_WIDTH      ),
    .AXI_USER_WIDTH           ( AXI_USER_WIDTH           ),
    .AXI_MAX_READS            ( 1                        )
  ) i_dwc_cluster (
    .clk_i        ( clk_i                  ),
    .rst_ni       ( rst_ni                 ),
    .slv          ( cluster_axi_lite_slave ),
    .mst          ( cluster_axi_lite_32    )
  );

  axi_to_axi_lite_intf #(
    .AXI_ADDR_WIDTH     ( AXI_ADDR_WIDTH           ),
    .AXI_DATA_WIDTH     ( AXI_LITE_DATA_WIDTH      ),
    .AXI_ID_WIDTH       ( ariane_soc::IdWidthSlave ),
    .AXI_USER_WIDTH     ( AXI_USER_WIDTH           ),
    .AXI_MAX_WRITE_TXNS ( 1                        ),
    .AXI_MAX_READ_TXNS  ( 1                        ),
    .FALL_THROUGH       ( 1'b0                     )
  ) i_axi_to_axi_lite_cluster (
    .clk_i       ( clk_i                        ),
    .rst_ni      ( rst_ni                       ),
    .testmode_i  ( 1'b0                         ),
    .slv         ( cluster_axi_lite_32          ),
    .mst         ( cluster_axi_lite_xbar_master )
  );
   
  `AXI_LITE_ASSIGN_TO_REQ    ( host_lite_req, host_axi_lite_xbar_master   )
  `AXI_LITE_ASSIGN_FROM_RESP ( host_axi_lite_xbar_master , host_lite_resp )

  `AXI_LITE_ASSIGN_TO_REQ    ( cluster_lite_req, cluster_axi_lite_xbar_master  )
  `AXI_LITE_ASSIGN_FROM_RESP ( cluster_axi_lite_xbar_master, cluster_lite_resp )

  `AXI_LITE_ASSIGN_FROM_REQ ( c2h_tlb_cfg_master     , c2h_tlb_cfg_req )
  `AXI_LITE_ASSIGN_TO_RESP  ( c2h_tlb_cfg_resp, c2h_tlb_cfg_master     )

  `AXI_LITE_ASSIGN_FROM_REQ ( llc_cfg_master , llc_cfg_req  )
  `AXI_LITE_ASSIGN_TO_RESP  ( llc_cfg_resp , llc_cfg_master )
   
  typedef axi_pkg::xbar_rule_32_t tlb_cfg_xbar_rule_t;

  localparam axi_pkg::xbar_cfg_t FromHostTlbCfgXbarCfg = '{
    NoSlvPorts:  2,
    NoMstPorts:  5,
    MaxMstTrans: 2,
    MaxSlvTrans: 5,
    FallThrough: 0,
    LatencyMode: axi_pkg::CUT_SLV_AX,
    PipelineStages: 32'd0,
    AxiIdWidthSlvPorts: 1,
    AxiIdUsedSlvPorts: 1, 
    UniqueIds   : 0,
    AxiAddrWidth: AXI_LITE_ADDR_WIDTH,
    AxiDataWidth: AXI_LITE_DATA_WIDTH,
    NoAddrRules: 5
  };

  localparam tlb_cfg_xbar_rule_t [FromHostTlbCfgXbarCfg.NoAddrRules-1:0]
      FromHostTlbCfgXbarAddrMap = '{
    '{idx: 32'd4, start_addr: 32'h1040_4000, end_addr: 32'h1040_5000},
    '{idx: 32'd3, start_addr: 32'h1040_3000, end_addr: 32'h1040_4000},
    '{idx: 32'd2, start_addr: 32'h1040_2000, end_addr: 32'h1040_3000},
    '{idx: 32'd1, start_addr: 32'h1040_1000, end_addr: 32'h1040_2000},
    '{idx: 32'd0, start_addr: 32'h1040_0000, end_addr: 32'h1040_1000}
  };
   
  axi_lite_xbar #(
     .Cfg                   ( FromHostTlbCfgXbarCfg          ),
     .aw_chan_t             ( ariane_axi_soc::aw_chan_lite_t ),
     .w_chan_t              ( ariane_axi_soc::w_chan_lite_t  ),
     .b_chan_t              ( ariane_axi_soc::b_chan_lite_t  ),
     .ar_chan_t             ( ariane_axi_soc::ar_chan_lite_t ),
     .r_chan_t              ( ariane_axi_soc::r_chan_lite_t  ),
     .axi_req_t             ( ariane_axi_soc::req_lite_t     ),
     .axi_resp_t            ( ariane_axi_soc::resp_lite_t    ),
     .rule_t                ( tlb_cfg_xbar_rule_t            )
   ) i_axi_lite_xbar         (
     .clk_i                 ( clk_i                                               ),
     .rst_ni                ( rst_ni                                              ),
     .test_i                ( 1'b0                                                ),
     .slv_ports_req_i       ( {cluster_lite_req , host_lite_req }                 ), 
     .slv_ports_resp_o      ( {cluster_lite_resp, host_lite_resp}                 ), 
     .mst_ports_req_o       ( { axi_mbox_req, c2hmailbox_lite_req,  h2cmailbox_lite_req,  llc_cfg_req,  c2h_tlb_cfg_req } ),
     .mst_ports_resp_i      ( { axi_mbox_rsp, c2hmailbox_lite_resp, h2cmailbox_lite_resp, llc_cfg_resp, c2h_tlb_cfg_resp } ),
     .addr_map_i            ( FromHostTlbCfgXbarAddrMap                           ),
     .en_default_mst_port_i ( {1'b0, 1'b0}                                        ),
     .default_mst_port_i    ( '0                                                  )
   );   


  axi_lite_mailbox #(
     .MailboxDepth ( 32'd8                       ),
     .IrqEdgeTrig  ( 1'b0                        ),
     .IrqActHigh   ( 1'b1                        ),
     .AxiAddrWidth ( 32'd32                      ),
     .AxiDataWidth ( 32'd32                      ),
     .req_lite_t   ( ariane_axi_soc::req_lite_t  ),
     .resp_lite_t  ( ariane_axi_soc::resp_lite_t )
     ) pulpmailbox (
       .clk_i       ( clk_i                                         ),
       .rst_ni      ( rst_ni                                        ),
       .test_i      ( 1'b0                                          ),
       .slv_reqs_i  ( { c2hmailbox_lite_req, h2cmailbox_lite_req  } ),
       .slv_resps_o ( { c2hmailbox_lite_resp,h2cmailbox_lite_resp } ),
       .irq_o       ( { s_c2h_irq, h2c_irq_o }                      ),
       .base_addr_i ( { 32'h1040_3000, 32'h1040_2000 }              )
       );

  sync_wedge i_host_mailbox_irq_sync (
              .clk_i    ( clk_i     ),
              .rst_ni   ( rst_ni    ),
              .en_i     ( 1'b1      ),
              .serial_i ( s_c2h_irq ),
              .r_edge_o ( c2h_irq_o ),
              .f_edge_o (           ),
              .serial_o (           )
              );

   axi_scmi_mailbox #(
       .axi_lite_req_t(ariane_axi_soc::req_lite_t ),
       .axi_lite_resp_t(ariane_axi_soc::resp_lite_t )
   ) i_scmi_ot_mailbox (
       .clk_i,
       .rst_ni,
       .axi_mbox_req,
       .axi_mbox_rsp,
       .doorbell_irq_o,
       .completion_irq_o
   );

  initial assert (AXI_LITE_ADDR_WIDTH == 32)
    else $fatal(1, "Change `tlb_cfg_xbar_rule_t` for address width other than 32 bit!");

endmodule

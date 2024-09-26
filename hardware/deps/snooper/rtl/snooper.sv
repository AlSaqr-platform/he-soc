// Copyright 2024 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Maicol Ciani <maicol.ciani@unibo.it> University of Bologna
// Date: 22/07/2024
// Description: Snooper module to collect and filter control-flow data from CVA6

`include "axi/typedef.svh"
`include "axi/assign.svh"
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

module snooper
   import snooper_pkg::*;
   import cfg_regs_reg_pkg::*;
   import trace_regs_reg_pkg::*;
#(
   parameter int unsigned AXI_USER_WIDTH = 1,
   parameter int unsigned AXI_ID_WIDTH = 8,
   parameter int unsigned AXI_ADDR_WIDTH = 64,
   parameter int unsigned AXI_DATA_WIDTH = 64,
   parameter int unsigned AXI_LITE_ADDR_WIDTH = 32,
   parameter int unsigned AXI_LITE_DATA_WIDTH = 32,
   parameter              type axi_aw_chan_t = logic,
   parameter              type axi_ar_chan_t = logic,
   parameter              type axi_r_chan_t = logic,
   parameter              type axi_w_chan_t = logic,
   parameter              type axi_b_chan_t = logic,
   parameter              type axi_req_t = logic,
   parameter              type axi_rsp_t = logic,
   parameter              type axi_lite_req_t = logic,
   parameter              type axi_lite_rsp_t = logic
)  (
   input  logic                 clk_i,
   input  logic                 rst_ni,
   input  axi_req_t             axi_sw_req_i,
   output axi_rsp_t             axi_sw_rsp_o,
   input  axi_lite_req_t        axi_lite_cfg_req_i,
   output axi_lite_rsp_t        axi_lite_cfg_rsp_o,
   input  trace_t               traces_i,
   output logic                 trigger_o,
   output logic                 core_select_o
);

/////////////////////////////
// Defines and Assignments //
/////////////////////////////

   localparam int unsigned NumFields = 5;
   localparam int unsigned NumBanks  = 8;
   localparam int unsigned NumWords  = 4096;
   localparam int unsigned MemAddrWidth  = 14;

   typedef logic [AXI_LITE_ADDR_WIDTH-1:0]   addr_lite_t;
   typedef logic [AXI_LITE_DATA_WIDTH-1:0]   data_lite_t;
   typedef logic [AXI_LITE_DATA_WIDTH/8-1:0] strb_lite_t;

   typedef logic [AXI_ID_WIDTH-1:0]          id_32_t;
   typedef logic [AXI_USER_WIDTH-1:0]        user_32_t;
   typedef logic [AXI_ADDR_WIDTH-1:0]        addr_32_t;
   typedef logic [AXI_LITE_DATA_WIDTH-1:0]   data_32_t;
   typedef logic [AXI_LITE_DATA_WIDTH/8-1:0] strb_32_t;

   `REG_BUS_TYPEDEF_ALL(reg, addr_lite_t, data_lite_t, strb_lite_t)
   `AXI_TYPEDEF_ALL(axi_32, addr_32_t, id_32_t, data_32_t, strb_32_t, user_32_t)

   logic [NumFields-1:0]                             buff_req;
   logic [NumFields-1:0] [MemAddrWidth-1:0 ]         buff_add;
   logic [NumFields-1:0]                             buff_wen;
   logic [NumFields-1:0] [AXI_LITE_DATA_WIDTH-1:0]   buff_wdata;
   logic [NumFields-1:0] [AXI_LITE_DATA_WIDTH/8-1:0] buff_be;
   logic [NumFields-1:0]                             buff_r_valid;
   logic [NumFields-1:0]                             buff_gnt;
   logic [NumFields-1:0] [AXI_LITE_DATA_WIDTH-1:0]   buff_r_data;

   logic                             sw_req;
   logic [MemAddrWidth-1:0]          sw_add;
   logic                             sw_wen;
   logic [AXI_LITE_DATA_WIDTH-1:0]   sw_wdata;
   logic                             sw_gnt;
   logic                             sw_r_valid;
   logic [AXI_LITE_DATA_WIDTH-1:0]   sw_r_rdata;
   logic [AXI_LITE_DATA_WIDTH/8-1:0] sw_be;

   logic snoop_en;

   logic [MemAddrWidth-1:0] cnt;
   logic [MemAddrWidth-1:0] first_valid;
   logic [MemAddrWidth-1:0] last_valid;

   reg_req_t cfg_reg_req;
   reg_rsp_t cfg_reg_rsp;

   cfg_regs_hw2reg_t cfg_hw2reg;
   cfg_regs_reg2hw_t cfg_reg2hw;

   trace_regs_hw2reg_t trace_hw2reg;
   trace_regs_reg2hw_t trace_reg2hw;

   trace_t trace_buff;

   axi_32_req_t  axi_32_sw_req, axi_req_cut;
   axi_32_resp_t axi_32_sw_rsp, axi_rsp_cut;

   assign trace_hw2reg.priv_lvl.unused.de   = 1'b1;
   assign trace_hw2reg.priv_lvl.priv_lvl.de = 1'b1;
   assign trace_hw2reg.pc_src_h.de          = 1'b1;
   assign trace_hw2reg.pc_src_l.de          = 1'b1;
   assign trace_hw2reg.pc_dst_h.de          = 1'b1;
   assign trace_hw2reg.pc_dst_l.de          = 1'b1;
   assign trace_hw2reg.metadata.de          = 1'b1;
   assign trace_hw2reg.opcode.de            = 1'b1;
   assign trace_hw2reg.valid.de             = 1'b1;

   assign trace_hw2reg.priv_lvl.unused.d    = '0;
   assign trace_hw2reg.priv_lvl.priv_lvl.d  = traces_i.priv_lvl;
   assign trace_hw2reg.pc_src_h.d           = traces_i.pc_src_h;
   assign trace_hw2reg.pc_src_l.d           = traces_i.pc_src_l;
   assign trace_hw2reg.pc_dst_h.d           = traces_i.pc_dst_h;
   assign trace_hw2reg.pc_dst_l.d           = traces_i.pc_dst_l;
   assign trace_hw2reg.metadata.d           = traces_i.metadata;
   assign trace_hw2reg.opcode.d             = traces_i.opcode;
   assign trace_hw2reg.valid.d              = traces_i.pc_v;

   assign trace_buff.priv_lvl               = riscv::priv_lvl_t'(trace_reg2hw.priv_lvl.priv_lvl.q);
   assign trace_buff.pc_src_h               = trace_reg2hw.pc_src_h.q;
   assign trace_buff.pc_src_l               = trace_reg2hw.pc_src_l.q;
   assign trace_buff.pc_dst_h               = trace_reg2hw.pc_dst_h.q;
   assign trace_buff.pc_dst_l               = trace_reg2hw.pc_dst_l.q;
   assign trace_buff.metadata               = riscv::ctr_type_t'(trace_reg2hw.metadata.q);
   assign trace_buff.opcode                 = trace_reg2hw.opcode.q;
   assign trace_buff.pc_v                   = trace_reg2hw.valid.q;

   assign cfg_hw2reg.base.de = 1'b1;
   assign cfg_hw2reg.base.d  = first_valid;

   assign cfg_hw2reg.last.de = 1'b1;
   assign cfg_hw2reg.last.d  = last_valid;

   assign cfg_hw2reg.ctrl.trace_mode.de = trigger_o;
   assign cfg_hw2reg.ctrl.trace_mode.d  = 2'b11;

   assign core_select_o = cfg_reg2hw.ctrl.core_select.q;

////////////////////
// Snooping Logic //
////////////////////

   // Buffering the input traces
   trace_regs_reg_top #(
     .reg_req_t  ( reg_req_t ),
     .reg_rsp_t  ( reg_rsp_t )
   ) u_fields_buff (
     .clk_i      ( clk_i         ),
     .rst_ni     ( rst_ni        ),
     .reg_req_i  ( '0            ),
     .reg_rsp_o  (               ),
     .reg2hw     ( trace_reg2hw  ),
     .hw2reg     ( trace_hw2reg  ),
     .devmode_i  ( 1'b0          )
   );

   // Enable the snooper to collect data only when needed
   trace_filter u_trace_filter (
      .traces_i   ( trace_buff      ),
      .config_i   ( cfg_reg2hw      ),
      .pc_valid_i ( trace_buff.pc_v ),
      .enable_o   ( snoop_en        )
   );

   snooping_engine #(
       .NumFields ( NumFields           ),
       .AddrWidth ( MemAddrWidth        ),
       .DataWidth ( AXI_LITE_DATA_WIDTH )
   ) i_snooping_engine (
       .clk_i           ( clk_i         ),
       .rst_ni          ( rst_ni        ),
       // Memory interface
       .buff_req_o      ( buff_req    ),
       .buff_add_o      ( buff_add    ),
       .buff_wen_o      ( buff_wen    ),
       .buff_wdata_o    ( buff_wdata  ),
       .buff_be_o       ( buff_be     ),
       // Control interface
       .traces_i        ( trace_buff  ),
       .config_i        ( cfg_reg2hw  ),
       .snoop_en_i      ( snoop_en    ),
       // Last valid entry
       .cnt_o           ( cnt         ),
       .first_valid_o   ( first_valid ),
       .last_valid_o    ( last_valid  )
   );

///////////////////////////
// Circular Buffer Logic //
///////////////////////////

   // Datapath width conversion
   axi_dw_converter #(
       .AxiMaxReads         ( 8                   ),
       .AxiSlvPortDataWidth ( AXI_DATA_WIDTH      ),
       .AxiMstPortDataWidth ( AXI_LITE_DATA_WIDTH ),
       .AxiAddrWidth        ( AXI_ADDR_WIDTH      ),
       .AxiIdWidth          ( AXI_ID_WIDTH        ),
       .aw_chan_t           ( axi_32_aw_chan_t    ),
       .mst_w_chan_t        ( axi_32_w_chan_t     ),
       .slv_w_chan_t        ( axi_w_chan_t        ),
       .b_chan_t            ( axi_32_b_chan_t     ),
       .ar_chan_t           ( axi_32_ar_chan_t    ),
       .mst_r_chan_t        ( axi_32_r_chan_t     ),
       .slv_r_chan_t        ( axi_r_chan_t        ),
       .axi_mst_req_t       ( axi_32_req_t        ),
       .axi_mst_resp_t      ( axi_32_resp_t       ),
       .axi_slv_req_t       ( axi_req_t           ),
       .axi_slv_resp_t      ( axi_rsp_t           )
   )  i_axi_dw_converter (
       .clk_i      ( clk_i         ),
       .rst_ni     ( rst_ni        ),
       // slave port
       .slv_req_i  ( axi_sw_req_i  ),
       .slv_resp_o ( axi_sw_rsp_o  ),
       // master port
       .mst_req_o  ( axi_32_sw_req ),
       .mst_resp_i ( axi_32_sw_rsp )
   );

   // Break comb path between DW conv and AXI2MEM
   axi_cut #(
       .aw_chan_t  ( axi_32_aw_chan_t ),
       .w_chan_t   ( axi_32_w_chan_t  ),
       .b_chan_t   ( axi_32_b_chan_t  ),
       .ar_chan_t  ( axi_32_ar_chan_t ),
       .r_chan_t   ( axi_32_r_chan_t  ),
       .axi_req_t  ( axi_32_req_t     ),
       .axi_resp_t ( axi_32_resp_t    )
   ) i_axi_cut (
       .clk_i      ( clk_i         ),
       .rst_ni     ( rst_ni        ),
       .slv_req_i  ( axi_32_sw_req ),
       .slv_resp_o ( axi_32_sw_rsp ),
       .mst_req_o  ( axi_req_cut   ),
       .mst_resp_i ( axi_rsp_cut   )
   );

   axi_to_mem #(
       .axi_req_t    ( axi_32_req_t        ),
       .axi_resp_t   ( axi_32_resp_t       ),
       .AddrWidth    ( MemAddrWidth        ),
       .DataWidth    ( AXI_LITE_DATA_WIDTH ),
       .IdWidth      ( AXI_ID_WIDTH        ),
       .NumBanks     ( 1                   ),
       .BufDepth     ( 1                   ),
       .HideStrb     ( 1'b0                ),
       .OutFifoDepth ( 1                   )
   ) i_axi_to_mem (
       .clk_i        ( clk_i         ),
       .rst_ni       ( rst_ni        ),
       .busy_o       (               ),
       .axi_req_i    ( axi_req_cut   ),
       .axi_resp_o   ( axi_rsp_cut   ),
       .mem_req_o    ( sw_req        ),
       .mem_gnt_i    ( sw_gnt        ),
       .mem_addr_o   ( sw_add        ),
       .mem_wdata_o  ( sw_wdata      ),
       .mem_strb_o   ( sw_be         ),
       .mem_atop_o   (               ),
       .mem_we_o     ( sw_wen        ),
       .mem_rvalid_i ( sw_r_valid    ),
       .mem_rdata_i  ( sw_r_rdata    )
   );

   circular_buffer  #(
       .SlvNumWords  ( NumWords            ),
       .SlvDataWidth ( AXI_LITE_DATA_WIDTH ),
       .NumSlv       ( NumBanks            ),
       .NumMst       ( NumFields + 1       ),
       .MstAddrWidth ( MemAddrWidth        )
   ) i_circular_buff (
       .clk_i     (   clk_i                       ),
       .rst_ni    (   rst_ni                      ),
       .req_i     ( { buff_req     , sw_req     } ),
       .wen_i     ( { buff_wen     , sw_wen     } ),
       .gnt_o     ( { buff_gnt     , sw_gnt     } ),
       .add_i     ( { buff_add     , sw_add     } ),
       .wdata_i   ( { buff_wdata   , sw_wdata   } ),
       .be_i      ( { buff_be      , sw_be      } ),
       .r_valid_o ( { buff_r_valid , sw_r_valid } ),
       .r_rdata_o ( { buff_r_data  , sw_r_rdata } )
   );

/////////////////////////
// Configuration Logic //
/////////////////////////

   axi_lite_to_reg #(
     .ADDR_WIDTH     ( AXI_LITE_ADDR_WIDTH ),
     .DATA_WIDTH     ( AXI_LITE_DATA_WIDTH ),
     .axi_lite_req_t ( axi_lite_req_t      ),
     .axi_lite_rsp_t ( axi_lite_rsp_t      ),
     .reg_req_t      ( reg_req_t           ),
     .reg_rsp_t      ( reg_rsp_t           )
   ) u_axi_lite_to_reg (
     .clk_i          ( clk_i              ),
     .rst_ni         ( rst_ni             ),
     .axi_lite_req_i ( axi_lite_cfg_req_i ),
     .axi_lite_rsp_o ( axi_lite_cfg_rsp_o ),
     .reg_req_o      ( cfg_reg_req        ),
     .reg_rsp_i      ( cfg_reg_rsp        )
   );

   cfg_regs_reg_top #(
     .reg_req_t  ( reg_req_t ),
     .reg_rsp_t  ( reg_rsp_t )
   ) flash_buffer (
     .clk_i      ( clk_i       ),
     .rst_ni     ( rst_ni      ),
     .reg_req_i  ( cfg_reg_req ),
     .reg_rsp_o  ( cfg_reg_rsp ),
     .reg2hw     ( cfg_reg2hw  ),
     .hw2reg     ( cfg_hw2reg  ),
     .devmode_i  ( 1'b0        )
   );

///////////////////////
// Triggering Logic  //
///////////////////////

   trigger inference_trigger (
    .traces_i ( trace_buff ),
    .config_i ( cfg_reg2hw ),
    .irq_o    ( trigger_o  )
   );

endmodule

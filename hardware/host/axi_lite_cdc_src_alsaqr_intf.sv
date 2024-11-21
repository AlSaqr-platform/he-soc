// Copyright (c) 2019-2020 ETH Zurich, University of Bologna
//
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Authors:
// - Luca Valente <luca.valente@unibo.it>
// - Andreas Kurth <akurth@iis.ee.ethz.ch>
//
// Edited:
// - Maicol Ciani <maicol.ciani@unibo.it>
//
// This has been changed for alsaqr.
// The Slave port is AXI_LITE here, not AXI_BUS.
//
//
`include "axi/assign.svh"
`include "axi/typedef.svh"

module axi_lite_cdc_src_alsaqr_intf #(
  parameter int unsigned AXI_ADDR_WIDTH = 0,
  parameter int unsigned AXI_DATA_WIDTH = 0,
  /// Depth of the FIFO crossing the clock domain, given as 2**LOG_DEPTH.
  parameter int unsigned LOG_DEPTH = 1,
  /// Number of synchronization registers to insert on the async pointers
  parameter int unsigned SYNC_STAGES = 2
) (
  // synchronous slave port - clocked by `src_clk_i`
  input  logic                src_clk_i,
  input  logic                src_rst_ni,
  AXI_LITE.Slave              src,
  // asynchronous master port
  AXI_LITE_ASYNC_GRAY.Master  dst
);

  typedef logic [AXI_ADDR_WIDTH-1:0]   addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0]   data_t;
  typedef logic [AXI_DATA_WIDTH/8-1:0] strb_t;
  `AXI_LITE_TYPEDEF_AW_CHAN_T(aw_chan_t, addr_t)
  `AXI_LITE_TYPEDEF_W_CHAN_T(w_chan_t, data_t, strb_t)
  `AXI_LITE_TYPEDEF_B_CHAN_T(b_chan_t)
  `AXI_LITE_TYPEDEF_AR_CHAN_T(ar_chan_t, addr_t)
  `AXI_LITE_TYPEDEF_R_CHAN_T(r_chan_t, data_t)
  `AXI_LITE_TYPEDEF_REQ_T(req_t, aw_chan_t, w_chan_t, ar_chan_t)
  `AXI_LITE_TYPEDEF_RESP_T(resp_t, b_chan_t, r_chan_t)

  req_t  src_req;
  resp_t src_resp;

  `AXI_LITE_ASSIGN_TO_REQ(src_req, src)
  `AXI_LITE_ASSIGN_FROM_RESP(src, src_resp)

  axi_cdc_src #(
    .aw_chan_t  ( aw_chan_t   ),
    .w_chan_t   ( w_chan_t    ),
    .b_chan_t   ( b_chan_t    ),
    .ar_chan_t  ( ar_chan_t   ),
    .r_chan_t   ( r_chan_t    ),
    .axi_req_t  ( req_t       ),
    .axi_resp_t ( resp_t      ),
    .LogDepth   ( LOG_DEPTH   ),
    .SyncStages ( SYNC_STAGES )
  ) i_axi_cdc_src (
    .src_clk_i,
    .src_rst_ni,
    .src_req_i                    ( src_req     ),
    .src_resp_o                   ( src_resp    ),
    .async_data_master_aw_data_o  ( dst.aw_data ),
    .async_data_master_aw_wptr_o  ( dst.aw_wptr ),
    .async_data_master_aw_rptr_i  ( dst.aw_rptr ),
    .async_data_master_w_data_o   ( dst.w_data  ),
    .async_data_master_w_wptr_o   ( dst.w_wptr  ),
    .async_data_master_w_rptr_i   ( dst.w_rptr  ),
    .async_data_master_b_data_i   ( dst.b_data  ),
    .async_data_master_b_wptr_i   ( dst.b_wptr  ),
    .async_data_master_b_rptr_o   ( dst.b_rptr  ),
    .async_data_master_ar_data_o  ( dst.ar_data ),
    .async_data_master_ar_wptr_o  ( dst.ar_wptr ),
    .async_data_master_ar_rptr_i  ( dst.ar_rptr ),
    .async_data_master_r_data_i   ( dst.r_data  ),
    .async_data_master_r_wptr_i   ( dst.r_wptr  ),
    .async_data_master_r_rptr_o   ( dst.r_rptr  )
  );

endmodule

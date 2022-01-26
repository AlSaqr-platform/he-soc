// Copyright 2020 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// Author: Nils Wistoff <nwistoff@iis.ee.ethz.ch>
//
// Macros for assigning flattened AXI ports to req/resp AXI structs
// Flat AXI ports are required by the Vivado IP Integrator. Vivado naming convention is followed.

`define AXI_FLATTEN_MASTER(pat, mst)        \
  assign ``pat``_awid     = mst.aw_id;     \
  assign ``pat``_awaddr   = mst.aw_addr;   \
  assign ``pat``_awlen    = mst.aw_len;    \
  assign ``pat``_awsize   = mst.aw_size;   \
  assign ``pat``_awburst  = mst.aw_burst;  \
  assign ``pat``_awlock   = mst.aw_lock;   \
  assign ``pat``_awcache  = mst.aw_cache;  \
  assign ``pat``_awprot   = mst.aw_prot;   \
  assign ``pat``_awqos    = mst.aw_qos;    \
  assign ``pat``_awregion = mst.aw_region; \
  assign ``pat``_awuser   = mst.aw_user;   \
  assign ``pat``_awvalid  = mst.aw_valid;  \
                                           \
  assign ``pat``_wvalid   = mst.w_valid;   \
  assign ``pat``_wdata    = mst.w_data;    \
  assign ``pat``_wstrb    = mst.w_strb;    \
  assign ``pat``_wlast    = mst.w_last;    \
  assign ``pat``_wuser    = mst.w_user;    \
                                           \
  assign ``pat``_bready   = mst.b_ready;   \
                                           \
  assign ``pat``_arvalid  = mst.ar_valid;  \
  assign ``pat``_arid     = mst.ar_id;     \
  assign ``pat``_araddr   = mst.ar_addr;   \
  assign ``pat``_arlen    = mst.ar_len;    \
  assign ``pat``_arsize   = mst.ar_size;   \
  assign ``pat``_arburst  = mst.ar_burst;  \
  assign ``pat``_arlock   = mst.ar_lock;   \
  assign ``pat``_arcache  = mst.ar_cache;  \
  assign ``pat``_arprot   = mst.ar_prot;   \
  assign ``pat``_arqos    = mst.ar_qos;    \
  assign ``pat``_arregion = mst.ar_region; \
  assign ``pat``_aruser   = mst.ar_user;   \
                                           \
  assign ``pat``_rready   = mst.r_ready;   \
                                                 \
  assign mst.aw_ready = ``pat``_awready;   \
  assign mst.ar_ready = ``pat``_arready;   \
  assign mst.w_ready  = ``pat``_wready;    \
                                           \
  assign mst.b_valid  = ``pat``_bvalid;    \
  assign mst.b_id     = ``pat``_bid;       \
  assign mst.b_resp   = ``pat``_bresp;     \
  assign mst.b_user   =  '0;     \
                                           \
  assign mst.r_valid  = ``pat``_rvalid;    \
  assign mst.r_id     = ``pat``_rid;       \
  assign mst.r_data   = ``pat``_rdata;     \
  assign mst.r_resp   = ``pat``_rresp;     \
  assign mst.r_last   = ``pat``_rlast;     \
  assign mst.r_user   = '0;


// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: cmp_top.v
// Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
// DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
//
// The above named program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public
// License version 2 as published by the Free Software Foundation.
//
// The above named program is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public
// License along with this work; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
//
// ========== Copyright Header End ============================================
////////////////////////////////////////////////////////

`ifndef USE_TEST_TOP // don't compile if user wants to use deprecated TOPs
`include "sys.h"
`include "iop.h"
`include "cross_module.tmp.h"
`include "ifu.tmp.h"
`include "define.tmp.h"
`include "piton_system.vh"
`include "noc_axi4_bridge_define.vh"


// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml


`ifdef PITON_DPI
import "DPI-C" function longint read_64b_call (input longint addr);
import "DPI-C" function void write_64b_call (input longint addr, input longint data);
import "DPI-C" function int drive_iob ();
import "DPI-C" function int get_cpx_word (int index);
import "DPI-C" function void report_pc (longint thread_pc);
import "DPI-C" function void init_jbus_model_call(string str, int oram);
`endif

`timescale 1ps/1ps
module cache_coherent_ariane_wrapper (
    input wire core_ref_clk,
    input wire sys_rst_n,
    // Debug
    input                                       ndmreset_i,    // non-debug module reset
    input   [`NUM_TILES-1:0]                    debug_req_i,   // async debug request
    output  [`NUM_TILES-1:0]                    unavailable_o, // communicate whether the hart is unavailable (e.g.: power down)
    // CLINT
    input   [`NUM_TILES-1:0]                    timer_irq_i,   // Timer interrupts
    input   [`NUM_TILES-1:0]                    ipi_i,         // software interrupt (a.k.a inter-process-interrupt)
    // PLIC
    input   [`NUM_TILES*2-1:0]                  irq_i,          // level sensitive IR lines, mip & sip (async)
       // AXI interface
   // Address Write Channel
   output wire [`AXI4_ID_WIDTH     -1:0]    m_axi_awid,
   output wire [`AXI4_ADDR_WIDTH   -1:0]    m_axi_awaddr,
   output wire [`AXI4_LEN_WIDTH    -1:0]    m_axi_awlen,
   output wire [`AXI4_SIZE_WIDTH   -1:0]    m_axi_awsize,
   output wire [`AXI4_BURST_WIDTH  -1:0]    m_axi_awburst,
   output wire                              m_axi_awlock,
   output wire [`AXI4_CACHE_WIDTH  -1:0]    m_axi_awcache,
   output wire [`AXI4_PROT_WIDTH   -1:0]    m_axi_awprot,
   output wire [`AXI4_QOS_WIDTH    -1:0]    m_axi_awqos,
   output wire [`AXI4_REGION_WIDTH -1:0]    m_axi_awregion,
   output wire [`AXI4_USER_WIDTH   -1:0]    m_axi_awuser,
   output wire                              m_axi_awvalid,
   input  wire                              m_axi_awready,

   // Write Data Channel
   output wire  [`AXI4_ID_WIDTH     -1:0]    m_axi_wid,
   output wire  [`AXI4_DATA_WIDTH   -1:0]    m_axi_wdata,
   output wire  [`AXI4_STRB_WIDTH   -1:0]    m_axi_wstrb,
   output wire                               m_axi_wlast,
   output wire  [`AXI4_USER_WIDTH   -1:0]    m_axi_wuser,
   output wire                               m_axi_wvalid,
   input  wire                               m_axi_wready,

   // Address Read Channel
   output wire  [`AXI4_ID_WIDTH     -1:0]    m_axi_arid,
   output wire  [`AXI4_ADDR_WIDTH   -1:0]    m_axi_araddr,
   output wire  [`AXI4_LEN_WIDTH    -1:0]    m_axi_arlen,
   output wire  [`AXI4_SIZE_WIDTH   -1:0]    m_axi_arsize,
   output wire  [`AXI4_BURST_WIDTH  -1:0]    m_axi_arburst,
   output wire                               m_axi_arlock,
   output wire  [`AXI4_CACHE_WIDTH  -1:0]    m_axi_arcache,
   output wire  [`AXI4_PROT_WIDTH   -1:0]    m_axi_arprot,
   output wire  [`AXI4_QOS_WIDTH    -1:0]    m_axi_arqos,
   output wire  [`AXI4_REGION_WIDTH -1:0]    m_axi_arregion,
   output wire  [`AXI4_USER_WIDTH   -1:0]    m_axi_aruser,
   output wire                               m_axi_arvalid,
   input  wire                               m_axi_arready,

   // Read Data Channel
   input  wire  [`AXI4_ID_WIDTH     -1:0]    m_axi_rid,
   input  wire  [`AXI4_DATA_WIDTH   -1:0]    m_axi_rdata,
   input  wire  [`AXI4_RESP_WIDTH   -1:0]    m_axi_rresp,
   input  wire                               m_axi_rlast,
   input  wire  [`AXI4_USER_WIDTH   -1:0]    m_axi_ruser,
   input  wire                               m_axi_rvalid,
   output wire                               m_axi_rready,

   // Ack Channel
   input  wire  [`AXI4_ID_WIDTH     -1:0]    m_axi_bid,
   input  wire  [`AXI4_RESP_WIDTH   -1:0]    m_axi_bresp,
   input  wire  [`AXI4_USER_WIDTH   -1:0]    m_axi_buser,
   input  wire                               m_axi_bvalid,
   output wire                               m_axi_bready
);



////////////////////////////////////////////////////////
// SYNTHESIZABLE SYSTEM
// INCLUDES CHIP 
///////////////////////////////////////////////////////

cache_coherent_ariane alsaqr_cache_coherent_ariane(

    // IO cell configs
    .slew(1'b1),
    .impsel1(1'b1),
    .impsel2(1'b1),

    // Input clocks
    .core_ref_clk(core_ref_clk),

    // Resets
    // reset is assumed to be asynchronous
    .rst_n(sys_rst_n),

    .pll_rst_n(sys_rst_n),

    // Chip-level clock enable
    .clk_en(1'b1),

    // PLL settings
    .pll_lock(pll_lock),
    .pll_bypass(1'b1),
    .pll_rangea(5'b00001),

    // Clock mux select (bypass PLL or not)
    // Double redundancy with pll_bypass
    .clk_mux_sel(2'b00),

    // Async FIFOs enable
    .async_mux(1'b0),

    // Debug
    .ndmreset_i(ndmreset_i),    // non-debug module reset
    .debug_req_i(debug_req_i),   // async debug request
    .unavailable_o(unavailable_o), // communicate whether the hart is unavailable (e.g.: power down)

    // CLINT
    .timer_irq_i(timer_irq_i),   // Timer interrupts
    .ipi_i(ipi_i),         // software interrupt (a.k.a inter-process-interrupt)

    // PLIC
    .irq_i(irq_i),          // level sensitive IR lines, mip & sip (async)

    // AXI interface
    .m_axi_awid(m_axi_awid),
    .m_axi_awaddr(m_axi_awaddr),
    .m_axi_awlen(m_axi_awlen),
    .m_axi_awsize(m_axi_awsize),
    .m_axi_awburst(m_axi_awburst),
    .m_axi_awlock(m_axi_awlock),
    .m_axi_awcache(m_axi_awcache),
    .m_axi_awprot(m_axi_awprot),
    .m_axi_awqos(m_axi_awqos),
    .m_axi_awregion(m_axi_awregion),
    .m_axi_awuser(m_axi_awuser),
    .m_axi_awvalid(m_axi_awvalid),
    .m_axi_awready(m_axi_awready),

    .m_axi_wid(m_axi_wid),
    .m_axi_wdata(m_axi_wdata),
    .m_axi_wstrb(m_axi_wstrb),
    .m_axi_wlast(m_axi_wlast),
    .m_axi_wuser(m_axi_wuser),
    .m_axi_wvalid(m_axi_wvalid),
    .m_axi_wready(m_axi_wready),

    .m_axi_arid(m_axi_arid),
    .m_axi_araddr(m_axi_araddr),
    .m_axi_arlen(m_axi_arlen),
    .m_axi_arsize(m_axi_arsize),
    .m_axi_arburst(m_axi_arburst),
    .m_axi_arlock(m_axi_arlock),
    .m_axi_arcache(m_axi_arcache),
    .m_axi_arprot(m_axi_arprot),
    .m_axi_arqos(m_axi_arqos),
    .m_axi_arregion(m_axi_arregion),
    .m_axi_aruser(m_axi_aruser),
    .m_axi_arvalid(m_axi_arvalid),
    .m_axi_arready(m_axi_arready),

    .m_axi_rid(m_axi_rid),
    .m_axi_rdata(m_axi_rdata),
    .m_axi_rresp(m_axi_rresp),
    .m_axi_rlast(m_axi_rlast),
    .m_axi_ruser(m_axi_ruser),
    .m_axi_rvalid(m_axi_rvalid),
    .m_axi_rready(m_axi_rready),

    .m_axi_bid(m_axi_bid),
    .m_axi_bresp(m_axi_bresp),
    .m_axi_buser(m_axi_buser),
    .m_axi_bvalid(m_axi_bvalid),
    .m_axi_bready(m_axi_bready)
);



endmodule // cmp_top

`endif

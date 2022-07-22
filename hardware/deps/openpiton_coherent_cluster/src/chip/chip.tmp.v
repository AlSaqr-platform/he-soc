// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: iop.v
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

`ifndef USE_TEST_TOP // useless for older TOPs
`define PITON_NO_CHIP_BRIDGE
`include "define.tmp.h"
`include "piton_system.vh"
`include "jtag.vh"

module chip(
   // Input clocks
   input                                        core_ref_clk,
   // Resets
   // reset is assumed to be asynchronous
   input                                        rst_n,

   output                                       processor_offchip_noc1_valid,
   output [`NOC_DATA_WIDTH-1:0]                 processor_offchip_noc1_data,
   input                                        processor_offchip_noc1_yummy,
   output                                       processor_offchip_noc2_valid,
   output [`NOC_DATA_WIDTH-1:0]                 processor_offchip_noc2_data,
   input                                        processor_offchip_noc2_yummy,
   output                                       processor_offchip_noc3_valid,
   output [`NOC_DATA_WIDTH-1:0]                 processor_offchip_noc3_data,
   input                                        processor_offchip_noc3_yummy,

   input                                        offchip_processor_noc1_valid,
   input  [`NOC_DATA_WIDTH-1:0]                 offchip_processor_noc1_data,
   output                                       offchip_processor_noc1_yummy,
   input                                        offchip_processor_noc2_valid,
   input  [`NOC_DATA_WIDTH-1:0]                 offchip_processor_noc2_data,
   output                                       offchip_processor_noc2_yummy,
   input                                        offchip_processor_noc3_valid,
   input  [`NOC_DATA_WIDTH-1:0]                 offchip_processor_noc3_data,
   output                                       offchip_processor_noc3_yummy,
   // Debug                                    
    input                                       ndmreset_i,    // non-debug module reset
    input   [`NUM_TILES-1:0]                    debug_req_i,   // async debug request
    output  [`NUM_TILES-1:0]                    unavailable_o, // communicate whether the hart is unavailable (e.g.: power down)
    // CLINT
    input   [`NUM_TILES-1:0]                    timer_irq_i,   // Timer interrupts
    input   [`NUM_TILES-1:0]                    ipi_i,         // software interrupt (a.k.a inter-process-interrupt)
    // PLIC
    input   [`NUM_TILES*2-1:0]                  irq_i          // level sensitive IR lines, mip & sip (async) 
);

// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml


   ///////////////////////
   // Type Declarations
   ///////////////////////

   // ORAM muxed outputs (in our case is not muxed anymore)
   reg                                          proc_oram_yummy;
   reg                                          oram_proc_valid;
   reg  [`NOC_DATA_WIDTH-1:0]                   oram_proc_data;
   reg                                          offchip_oram_yummy;
   reg                                          oram_offchip_valid;
   reg  [`NOC_DATA_WIDTH-1:0]                   oram_offchip_data;

   // ORAM Signals
   wire                                         proc_oram_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   proc_oram_data;
   wire                                         proc_oram_yummy_oram;
   wire                                         oram_proc_valid_oram;
   wire [`NOC_DATA_WIDTH-1:0]                   oram_proc_data_oram;
   wire                                         oram_proc_yummy;

   wire                                         offchip_oram_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   offchip_oram_data;
   wire                                         offchip_oram_yummy_oram;
   wire                                         oram_offchip_valid_oram;
   wire [`NOC_DATA_WIDTH-1:0]                   oram_offchip_data_oram;
   wire                                         oram_offchip_yummy;


   // Chip bridge val/rdy interface
   wire                                         chip_intf_noc1_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   chip_intf_noc1_data;
   wire                                         chip_intf_noc1_rdy;
   wire                                         chip_intf_noc2_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   chip_intf_noc2_data;
   wire                                         chip_intf_noc2_rdy;
   wire                                         chip_intf_noc3_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   chip_intf_noc3_data;
   wire                                         chip_intf_noc3_rdy;

   wire                                         intf_chip_noc1_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   intf_chip_noc1_data;
   wire                                         intf_chip_noc1_rdy;
   wire                                         intf_chip_noc2_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   intf_chip_noc2_data;
   wire                                         intf_chip_noc2_rdy;
   wire                                         intf_chip_noc3_valid;
   wire [`NOC_DATA_WIDTH-1:0]                   intf_chip_noc3_data;
   wire                                         intf_chip_noc3_rdy;

   wire tile0_jtag_ucb_val;
wire [`UCB_BUS_WIDTH-1:0] tile0_jtag_ucb_data;


   // Generate tile wiring
wire [`DATA_WIDTH-1:0] tile_0_0_out_N_noc1_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_S_noc1_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_E_noc1_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_W_noc1_data;
wire tile_0_0_out_N_noc1_valid;
wire tile_0_0_out_S_noc1_valid;
wire tile_0_0_out_E_noc1_valid;
wire tile_0_0_out_W_noc1_valid;
wire tile_0_0_out_N_noc1_yummy;
wire tile_0_0_out_S_noc1_yummy;
wire tile_0_0_out_E_noc1_yummy;
wire tile_0_0_out_W_noc1_yummy;
wire [`DATA_WIDTH-1:0] tile_0_0_out_N_noc2_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_S_noc2_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_E_noc2_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_W_noc2_data;
wire tile_0_0_out_N_noc2_valid;
wire tile_0_0_out_S_noc2_valid;
wire tile_0_0_out_E_noc2_valid;
wire tile_0_0_out_W_noc2_valid;
wire tile_0_0_out_N_noc2_yummy;
wire tile_0_0_out_S_noc2_yummy;
wire tile_0_0_out_E_noc2_yummy;
wire tile_0_0_out_W_noc2_yummy;
wire [`DATA_WIDTH-1:0] tile_0_0_out_N_noc3_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_S_noc3_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_E_noc3_data;
wire [`DATA_WIDTH-1:0] tile_0_0_out_W_noc3_data;
wire tile_0_0_out_N_noc3_valid;
wire tile_0_0_out_S_noc3_valid;
wire tile_0_0_out_E_noc3_valid;
wire tile_0_0_out_W_noc3_valid;
wire tile_0_0_out_N_noc3_yummy;
wire tile_0_0_out_S_noc3_yummy;
wire tile_0_0_out_E_noc3_yummy;
wire tile_0_0_out_W_noc3_yummy;
wire [`DATA_WIDTH-1:0] dummy_out_N_noc1_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_S_noc1_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_E_noc1_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_W_noc1_data = `DATA_WIDTH'b0;
wire dummy_out_N_noc1_valid = 1'b0;
wire dummy_out_S_noc1_valid = 1'b0;
wire dummy_out_E_noc1_valid = 1'b0;
wire dummy_out_W_noc1_valid = 1'b0;
wire dummy_out_N_noc1_yummy = 1'b0;
wire dummy_out_S_noc1_yummy = 1'b0;
wire dummy_out_E_noc1_yummy = 1'b0;
wire dummy_out_W_noc1_yummy = 1'b0;
wire [`DATA_WIDTH-1:0] dummy_out_N_noc2_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_S_noc2_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_E_noc2_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_W_noc2_data = `DATA_WIDTH'b0;
wire dummy_out_N_noc2_valid = 1'b0;
wire dummy_out_S_noc2_valid = 1'b0;
wire dummy_out_E_noc2_valid = 1'b0;
wire dummy_out_W_noc2_valid = 1'b0;
wire dummy_out_N_noc2_yummy = 1'b0;
wire dummy_out_S_noc2_yummy = 1'b0;
wire dummy_out_E_noc2_yummy = 1'b0;
wire dummy_out_W_noc2_yummy = 1'b0;
wire [`DATA_WIDTH-1:0] dummy_out_N_noc3_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_S_noc3_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_E_noc3_data = `DATA_WIDTH'b0;
wire [`DATA_WIDTH-1:0] dummy_out_W_noc3_data = `DATA_WIDTH'b0;
wire dummy_out_N_noc3_valid = 1'b0;
wire dummy_out_S_noc3_valid = 1'b0;
wire dummy_out_E_noc3_valid = 1'b0;
wire dummy_out_W_noc3_valid = 1'b0;
wire dummy_out_N_noc3_yummy = 1'b0;
wire dummy_out_S_noc3_yummy = 1'b0;
wire dummy_out_E_noc3_yummy = 1'b0;
wire dummy_out_W_noc3_yummy = 1'b0;
wire [`DATA_WIDTH-1:0] offchip_out_E_noc1_data;
wire offchip_out_E_noc1_valid;
wire offchip_out_E_noc1_yummy;
wire [`DATA_WIDTH-1:0] offchip_out_E_noc2_data;
wire offchip_out_E_noc2_valid;
wire offchip_out_E_noc2_yummy;
wire [`DATA_WIDTH-1:0] offchip_out_E_noc3_data;
wire offchip_out_E_noc3_valid;
wire offchip_out_E_noc3_yummy;

   // Connecting chip_bridge data to tiles/ORAM

assign proc_oram_valid = tile_0_0_out_W_noc2_valid;
assign proc_oram_data = tile_0_0_out_W_noc2_data;
assign oram_proc_yummy = tile_0_0_out_W_noc3_yummy;

   assign offchip_oram_valid = offchip_processor_noc3_valid;
   assign offchip_oram_data = offchip_processor_noc3_data;
   assign oram_offchip_yummy = processor_offchip_noc2_yummy;

assign processor_offchip_noc1_valid = tile_0_0_out_W_noc1_valid;
assign processor_offchip_noc1_data = tile_0_0_out_W_noc1_data;
assign offchip_processor_noc1_yummy = tile_0_0_out_W_noc1_yummy;

   assign processor_offchip_noc2_valid = oram_offchip_valid;
   assign processor_offchip_noc2_data = oram_offchip_data;

assign offchip_processor_noc2_yummy = tile_0_0_out_W_noc2_yummy;
assign processor_offchip_noc3_valid = tile_0_0_out_W_noc3_valid;
assign processor_offchip_noc3_data = tile_0_0_out_W_noc3_data;

   assign offchip_processor_noc3_yummy = offchip_oram_yummy;

assign offchip_out_E_noc1_data = offchip_processor_noc1_data;
assign offchip_out_E_noc1_valid = offchip_processor_noc1_valid;
assign offchip_out_E_noc1_yummy = processor_offchip_noc1_yummy;
assign offchip_out_E_noc2_data = offchip_processor_noc2_data;
assign offchip_out_E_noc2_valid = offchip_processor_noc2_valid;
assign offchip_out_E_noc2_yummy = proc_oram_yummy; //going to processor
assign offchip_out_E_noc3_data = oram_proc_data;
assign offchip_out_E_noc3_valid = oram_proc_valid;
assign offchip_out_E_noc3_yummy = processor_offchip_noc3_yummy;

   always @ *
   begin
     // default is bypassing
     oram_offchip_valid = proc_oram_valid;
     oram_offchip_data = proc_oram_data;
     proc_oram_yummy = oram_offchip_yummy;
     oram_proc_valid = offchip_oram_valid;
     oram_proc_data = offchip_oram_data;
     offchip_oram_yummy = oram_proc_yummy;
  end
  
   // Merge all JTAG outputs from tiles together
assign tiles_jtag_ucb_val = tile0_jtag_ucb_val;
assign tiles_jtag_ucb_data = tile0_jtag_ucb_data;


   /////////////////////////
   // Sub-module Instances
   /////////////////////////

  assign clk_muxed = core_ref_clk;

   // generate the cross bars


    // Generate tile instances

tile #(.TILE_TYPE(`ARIANE_RV64_TILE))
tile0 (
    .clk                (clk_muxed),
    .rst_n              (rst_n),
    .clk_en             ( 1'b1 ),
    .default_chipid             (14'b0),    // the first chip
    .default_coreid_x           (8'd0),
    .default_coreid_y           (8'd0),
    .flat_tileid                (`JTAG_FLATID_WIDTH'd0),
`ifdef PITON_ARIANE
    .debug_req_i         ( debug_req_i[0]   ),
    .unavailable_o       ( unavailable_o[0] ),
    .timer_irq_i         ( timer_irq_i[0]   ),
    .ipi_i               ( ipi_i[0]         ),
    .irq_i               ( irq_i[0*2 +: 2]  ),
`endif

    .dyn0_dataIn_N       ( dummy_out_S_noc1_data   ),
    .dyn0_dataIn_E       ( dummy_out_W_noc1_data   ),
    .dyn0_dataIn_W       ( offchip_out_E_noc1_data   ),
    .dyn0_dataIn_S       ( dummy_out_N_noc1_data   ),
    .dyn0_validIn_N      ( dummy_out_S_noc1_valid  ),
    .dyn0_validIn_E      ( dummy_out_W_noc1_valid  ),
    .dyn0_validIn_W      ( offchip_out_E_noc1_valid  ),
    .dyn0_validIn_S      ( dummy_out_N_noc1_valid  ),
    .dyn0_dNo_yummy      ( dummy_out_S_noc1_yummy  ),
    .dyn0_dEo_yummy      ( dummy_out_W_noc1_yummy  ),
    .dyn0_dWo_yummy      ( offchip_out_E_noc1_yummy  ),
    .dyn0_dSo_yummy      ( dummy_out_N_noc1_yummy  ),

    .dyn0_dNo            ( tile_0_0_out_N_noc1_data  ),
    .dyn0_dEo            ( tile_0_0_out_E_noc1_data  ),
    .dyn0_dWo            ( tile_0_0_out_W_noc1_data  ),
    .dyn0_dSo            ( tile_0_0_out_S_noc1_data  ),
    .dyn0_dNo_valid      ( tile_0_0_out_N_noc1_valid ),
    .dyn0_dEo_valid      ( tile_0_0_out_E_noc1_valid ),
    .dyn0_dWo_valid      ( tile_0_0_out_W_noc1_valid ),
    .dyn0_dSo_valid      ( tile_0_0_out_S_noc1_valid ),
    .dyn0_yummyOut_N     ( tile_0_0_out_N_noc1_yummy ),
    .dyn0_yummyOut_E     ( tile_0_0_out_E_noc1_yummy ),
    .dyn0_yummyOut_W     ( tile_0_0_out_W_noc1_yummy ),
    .dyn0_yummyOut_S     ( tile_0_0_out_S_noc1_yummy ),
    .dyn1_dataIn_N       ( dummy_out_S_noc2_data   ),
    .dyn1_dataIn_E       ( dummy_out_W_noc2_data   ),
    .dyn1_dataIn_W       ( offchip_out_E_noc2_data   ),
    .dyn1_dataIn_S       ( dummy_out_N_noc2_data   ),
    .dyn1_validIn_N      ( dummy_out_S_noc2_valid  ),
    .dyn1_validIn_E      ( dummy_out_W_noc2_valid  ),
    .dyn1_validIn_W      ( offchip_out_E_noc2_valid  ),
    .dyn1_validIn_S      ( dummy_out_N_noc2_valid  ),
    .dyn1_dNo_yummy      ( dummy_out_S_noc2_yummy  ),
    .dyn1_dEo_yummy      ( dummy_out_W_noc2_yummy  ),
    .dyn1_dWo_yummy      ( offchip_out_E_noc2_yummy  ),
    .dyn1_dSo_yummy      ( dummy_out_N_noc2_yummy  ),

    .dyn1_dNo            ( tile_0_0_out_N_noc2_data  ),
    .dyn1_dEo            ( tile_0_0_out_E_noc2_data  ),
    .dyn1_dWo            ( tile_0_0_out_W_noc2_data  ),
    .dyn1_dSo            ( tile_0_0_out_S_noc2_data  ),
    .dyn1_dNo_valid      ( tile_0_0_out_N_noc2_valid ),
    .dyn1_dEo_valid      ( tile_0_0_out_E_noc2_valid ),
    .dyn1_dWo_valid      ( tile_0_0_out_W_noc2_valid ),
    .dyn1_dSo_valid      ( tile_0_0_out_S_noc2_valid ),
    .dyn1_yummyOut_N     ( tile_0_0_out_N_noc2_yummy ),
    .dyn1_yummyOut_E     ( tile_0_0_out_E_noc2_yummy ),
    .dyn1_yummyOut_W     ( tile_0_0_out_W_noc2_yummy ),
    .dyn1_yummyOut_S     ( tile_0_0_out_S_noc2_yummy ),
    .dyn2_dataIn_N       ( dummy_out_S_noc3_data   ),
    .dyn2_dataIn_E       ( dummy_out_W_noc3_data   ),
    .dyn2_dataIn_W       ( offchip_out_E_noc3_data   ),
    .dyn2_dataIn_S       ( dummy_out_N_noc3_data   ),
    .dyn2_validIn_N      ( dummy_out_S_noc3_valid  ),
    .dyn2_validIn_E      ( dummy_out_W_noc3_valid  ),
    .dyn2_validIn_W      ( offchip_out_E_noc3_valid  ),
    .dyn2_validIn_S      ( dummy_out_N_noc3_valid  ),
    .dyn2_dNo_yummy      ( dummy_out_S_noc3_yummy  ),
    .dyn2_dEo_yummy      ( dummy_out_W_noc3_yummy  ),
    .dyn2_dWo_yummy      ( offchip_out_E_noc3_yummy  ),
    .dyn2_dSo_yummy      ( dummy_out_N_noc3_yummy  ),

    .dyn2_dNo            ( tile_0_0_out_N_noc3_data  ),
    .dyn2_dEo            ( tile_0_0_out_E_noc3_data  ),
    .dyn2_dWo            ( tile_0_0_out_W_noc3_data  ),
    .dyn2_dSo            ( tile_0_0_out_S_noc3_data  ),
    .dyn2_dNo_valid      ( tile_0_0_out_N_noc3_valid ),
    .dyn2_dEo_valid      ( tile_0_0_out_E_noc3_valid ),
    .dyn2_dWo_valid      ( tile_0_0_out_W_noc3_valid ),
    .dyn2_dSo_valid      ( tile_0_0_out_S_noc3_valid ),
    .dyn2_yummyOut_N     ( tile_0_0_out_N_noc3_yummy ),
    .dyn2_yummyOut_E     ( tile_0_0_out_E_noc3_yummy ),
    .dyn2_yummyOut_W     ( tile_0_0_out_W_noc3_yummy ),
    .dyn2_yummyOut_S     ( tile_0_0_out_S_noc3_yummy )
);


endmodule

`endif

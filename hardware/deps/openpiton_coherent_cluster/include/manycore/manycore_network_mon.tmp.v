// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: cmp_l15_messages_mon.v
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

`include "sys.h"
`include "iop.h"
`include "cross_module.tmp.h"


// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml
`define NUM_TILES 1


`ifndef USE_TEST_TOP // useless for older TOPs

module manycore_network_mon (
    input wire clk
    );
`ifndef DISABLE_ALL_MONITORS
`ifndef DISABLE_NETWORK_MONITOR
`ifndef MINIMAL_MONITORING
`ifndef XBAR_CONFIG
// check boundary communication
// There are two parts to the check
/* 1. check for valid signal from valid tiles to non-valid tiles
    - from leftmost tiles to left
    - topmost tiles to top
    - ... right
    - ... bottom
    The only exception is from tile 0 to off-chip
    Implementation:
        For every valid tile, check NESW. Also because the system will not to configured to fill all tiles,
            if the tile directly below or to the right is not configured then also check for error.
*/
/* 2. check for valid signal from non-valid tiles to valid tiles
    - for every non-valid tiles, if the valid signal to an adjacent valid tile is asserted, then error
*/

always @ (negedge clk)
begin
    if($test$plusargs("enable_router_mon"))
    begin
`ifdef RTL_SPARC0
    if (`CHIP.tile_0_0_out_N_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out N data: 0x%x ", $time,`CHIP.tile_0_0_out_N_noc1_data);
    end
    if (`CHIP.tile_0_0_out_S_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out S data: 0x%x ", $time,`CHIP.tile_0_0_out_S_noc1_data);
    end
    if (`CHIP.tile_0_0_out_E_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out E data: 0x%x ", $time,`CHIP.tile_0_0_out_E_noc1_data);
    end
    if (`CHIP.tile_0_0_out_W_noc1_valid)
    begin
        $display("%d: TILE0 noc1 router out W data: 0x%x ", $time,`CHIP.tile_0_0_out_W_noc1_data);
    end
    if (`CHIP.tile_0_0_out_N_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out N data: 0x%x ", $time,`CHIP.tile_0_0_out_N_noc2_data);
    end
    if (`CHIP.tile_0_0_out_S_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out S data: 0x%x ", $time,`CHIP.tile_0_0_out_S_noc2_data);
    end
    if (`CHIP.tile_0_0_out_E_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out E data: 0x%x ", $time,`CHIP.tile_0_0_out_E_noc2_data);
    end
    if (`CHIP.tile_0_0_out_W_noc2_valid)
    begin
        $display("%d: TILE0 noc2 router out W data: 0x%x ", $time,`CHIP.tile_0_0_out_W_noc2_data);
    end
    if (`CHIP.tile_0_0_out_N_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out N data: 0x%x ", $time,`CHIP.tile_0_0_out_N_noc3_data);
    end
    if (`CHIP.tile_0_0_out_S_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out S data: 0x%x ", $time,`CHIP.tile_0_0_out_S_noc3_data);
    end
    if (`CHIP.tile_0_0_out_E_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out E data: 0x%x ", $time,`CHIP.tile_0_0_out_E_noc3_data);
    end
    if (`CHIP.tile_0_0_out_W_noc3_valid)
    begin
        $display("%d: TILE0 noc3 router out W data: 0x%x ", $time,`CHIP.tile_0_0_out_W_noc3_data);
    end
`endif

    end
end

localparam ERROR_NOC1 = 2'd1;
localparam ERROR_NOC2 = 2'd2;
localparam ERROR_NOC3 = 2'd3;


reg [31:0] error_dir;
reg [31:0] error_noc;
reg [31:0] error_x;
reg [31:0] error_y;
reg boundary_err;
always @ (negedge clk)
begin
    boundary_err = 0;
    `ifdef RTL_SPARC0
boundary_err = boundary_err | `CHIP.tile_0_0_out_N_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 1;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 1;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc1_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 1;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_N_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 2;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 2;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc2_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 2;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_N_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "N";
error_noc = 3;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_S_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "S";
error_noc = 3;
error_x = 0;
error_y = 0;
end
boundary_err = boundary_err | `CHIP.tile_0_0_out_E_noc3_valid;
if (boundary_err == 1)
begin
error_dir = "E";
error_noc = 3;
error_x = 0;
error_y = 0;
end
`endif

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet out of valid bound from tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet going out of valid bound");
            end
            
boundary_err = 0;
`ifndef RTL_SPARC0

            if (boundary_err == 1)
            begin
                $display("%d : Simulation -> FAIL. network_mon: packet from invalid tile_%0d_%0d_out_%0s_noc%0d", $time, error_y, error_x, error_dir, error_noc);
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("network_mon: network_mon: packet from invalid tile");
            end
            
`endif


    // if (boundary_err == 1)
    // begin
    //     $display("%d : Simulation -> FAIL(%0s)", $time, "network_mon: packet going out of bound");
    //     repeat(5)@(posedge clk);
    //     `MONITOR_PATH.fail("network_mon: network_mon: packet going out of bound");
    // end
end
`endif
`endif
`endif
`endif // DISABLE_ALL_MONITORS
endmodule

`endif

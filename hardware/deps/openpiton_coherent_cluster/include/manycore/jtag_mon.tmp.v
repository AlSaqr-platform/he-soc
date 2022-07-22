// Modified by Princeton University on June 9th, 2015
// ========== Copyright Header Begin ==========================================
//
// OpenSPARC T1 Processor File: jtag_mon.v
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
`include "jtag.vh"

module jtag_mon (
    input wire clk
    );



// jtag ctap mon

always @ (negedge clk)
begin
    if (`JTAG_CTAP.jtag_req_val)
    begin
        $display("");
        $display($time, " JTAG CTAP mon:");
        $write("Request: ");
        case (`JTAG_CTAP.jtag_req[`JTAG_REQ_OP_MASK])
            `JTAG_REQ_OP_CLEAR_INTERRUPT:
            begin
                $write("JTAG_REQ_OP_CLEAR_INTERRUPT");
            end
            `JTAG_REQ_OP_READ_ORAM:
            begin
                $write("JTAG_REQ_OP_READ_ORAM");
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
            end
            // `JTAG_REQ_OP_CPX_INTERRUPT:
            // begin
            //     $write("JTAG_REQ_OP_CPX_INTERRUPT");
            // end
            `JTAG_REQ_OP_WRITE_CLK_EN:
            begin
                $write("JTAG_REQ_OP_WRITE_CLK_EN");
            end
            `JTAG_REQ_OP_WRITE_ORAM_CLK_EN:
            begin
                $write("JTAG_REQ_OP_WRITE_ORAM_CLK_EN");
            end
            default:
            begin
                $write("UNKNOWN CTAP REQ: %0d", `JTAG_CTAP.jtag_req[`JTAG_REQ_OP_MASK]);
                $display("");
                `ifndef VERILATOR
                repeat(5)@(posedge clk);
                `endif
                `MONITOR_PATH.fail("JTAG CTAP mon: error jtag request");
            end
        endcase
        $display("");
    end // ctap req

    if (`JTAG_CTAP.capture_ucb_data_en)
    begin
        $display("");
        $display($time, " JTAG CTAP mon:");
        $write("Received RTAP return");
        $write("Data: 0x%x", `JTAG_CTAP.rtap_packet);
        $display("");
    end // ctap ret

    if (`JTAG_CTAP.capture_oram_response)
    begin
        $display("");
        $display($time, " JTAG CTAP mon:");
        $write("Received ORAM read return");
        $write("Data: 0x%x", `JTAG_CTAP.oram_ctap_res_data);
        $display("");
    end // ctap ret

    // if (`JTAG_CTAP.capture_sram_response)
    // begin
    //     $display("");
    //     $display($time, " JTAG CTAP mon:");
    //     $write("Received ORAM SRAMs return");
    //     $write("Data: 0x%x", `JTAG_CTAP.sram_res_data);
    //     $display("");
    // end // ctap ret
end


`ifdef RTL_SPARC0

always @ (negedge clk)
begin
    if (`TILE0.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE0 mon:");
        $write("Request: ");
        case (`TILE0.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE0.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE0.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE0.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE0.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE0.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE0.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE0.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE0.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE0.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE0.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE0.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE0 REQ %0d", `TILE0.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE0 mon: error request");
            end
        endcase
        $display("");

        if (`TILE0.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE0.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE0.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE0.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE0 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE0.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE0.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE0.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE0.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE0 mon:");
    //     $write("Core stall is set to: %0d", `TILE0.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC1

always @ (negedge clk)
begin
    if (`TILE1.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE1 mon:");
        $write("Request: ");
        case (`TILE1.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE1.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE1.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE1.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE1.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE1.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE1.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE1.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE1.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE1.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE1.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE1.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE1 REQ %0d", `TILE1.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE1 mon: error request");
            end
        endcase
        $display("");

        if (`TILE1.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE1.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE1.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE1.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE1 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE1.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE1.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE1.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE1.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE1 mon:");
    //     $write("Core stall is set to: %0d", `TILE1.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC2

always @ (negedge clk)
begin
    if (`TILE2.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE2 mon:");
        $write("Request: ");
        case (`TILE2.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE2.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE2.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE2.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE2.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE2.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE2.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE2.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE2.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE2.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE2.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE2.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE2 REQ %0d", `TILE2.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE2 mon: error request");
            end
        endcase
        $display("");

        if (`TILE2.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE2.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE2.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE2.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE2 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE2.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE2.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE2.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE2.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE2 mon:");
    //     $write("Core stall is set to: %0d", `TILE2.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC3

always @ (negedge clk)
begin
    if (`TILE3.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE3 mon:");
        $write("Request: ");
        case (`TILE3.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE3.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE3.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE3.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE3.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE3.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE3.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE3.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE3.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE3.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE3.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE3.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE3 REQ %0d", `TILE3.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE3 mon: error request");
            end
        endcase
        $display("");

        if (`TILE3.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE3.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE3.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE3.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE3 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE3.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE3.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE3.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE3.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE3 mon:");
    //     $write("Core stall is set to: %0d", `TILE3.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC4

always @ (negedge clk)
begin
    if (`TILE4.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE4 mon:");
        $write("Request: ");
        case (`TILE4.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE4.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE4.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE4.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE4.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE4.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE4.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE4.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE4.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE4.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE4.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE4.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE4 REQ %0d", `TILE4.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE4 mon: error request");
            end
        endcase
        $display("");

        if (`TILE4.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE4.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE4.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE4.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE4 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE4.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE4.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE4.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE4.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE4 mon:");
    //     $write("Core stall is set to: %0d", `TILE4.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC5

always @ (negedge clk)
begin
    if (`TILE5.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE5 mon:");
        $write("Request: ");
        case (`TILE5.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE5.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE5.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE5.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE5.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE5.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE5.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE5.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE5.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE5.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE5.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE5.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE5 REQ %0d", `TILE5.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE5 mon: error request");
            end
        endcase
        $display("");

        if (`TILE5.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE5.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE5.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE5.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE5 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE5.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE5.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE5.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE5.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE5 mon:");
    //     $write("Core stall is set to: %0d", `TILE5.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC6

always @ (negedge clk)
begin
    if (`TILE6.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE6 mon:");
        $write("Request: ");
        case (`TILE6.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE6.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE6.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE6.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE6.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE6.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE6.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE6.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE6.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE6.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE6.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE6.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE6 REQ %0d", `TILE6.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE6 mon: error request");
            end
        endcase
        $display("");

        if (`TILE6.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE6.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE6.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE6.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE6 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE6.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE6.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE6.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE6.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE6 mon:");
    //     $write("Core stall is set to: %0d", `TILE6.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC7

always @ (negedge clk)
begin
    if (`TILE7.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE7 mon:");
        $write("Request: ");
        case (`TILE7.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE7.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE7.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE7.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE7.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE7.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE7.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE7.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE7.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE7.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE7.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE7.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE7 REQ %0d", `TILE7.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE7 mon: error request");
            end
        endcase
        $display("");

        if (`TILE7.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE7.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE7.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE7.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE7 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE7.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE7.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE7.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE7.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE7 mon:");
    //     $write("Core stall is set to: %0d", `TILE7.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC8

always @ (negedge clk)
begin
    if (`TILE8.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE8 mon:");
        $write("Request: ");
        case (`TILE8.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE8.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE8.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE8.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE8.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE8.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE8.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE8.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE8.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE8.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE8.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE8.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE8 REQ %0d", `TILE8.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE8 mon: error request");
            end
        endcase
        $display("");

        if (`TILE8.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE8.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE8.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE8.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE8 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE8.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE8.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE8.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE8.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE8 mon:");
    //     $write("Core stall is set to: %0d", `TILE8.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC9

always @ (negedge clk)
begin
    if (`TILE9.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE9 mon:");
        $write("Request: ");
        case (`TILE9.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE9.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE9.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE9.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE9.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE9.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE9.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE9.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE9.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE9.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE9.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE9.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE9 REQ %0d", `TILE9.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE9 mon: error request");
            end
        endcase
        $display("");

        if (`TILE9.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE9.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE9.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE9.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE9 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE9.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE9.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE9.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE9.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE9 mon:");
    //     $write("Core stall is set to: %0d", `TILE9.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC10

always @ (negedge clk)
begin
    if (`TILE10.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE10 mon:");
        $write("Request: ");
        case (`TILE10.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE10.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE10.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE10.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE10.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE10.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE10.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE10.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE10.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE10.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE10.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE10.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE10 REQ %0d", `TILE10.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE10 mon: error request");
            end
        endcase
        $display("");

        if (`TILE10.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE10.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE10.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE10.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE10 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE10.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE10.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE10.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE10.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE10 mon:");
    //     $write("Core stall is set to: %0d", `TILE10.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC11

always @ (negedge clk)
begin
    if (`TILE11.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE11 mon:");
        $write("Request: ");
        case (`TILE11.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE11.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE11.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE11.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE11.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE11.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE11.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE11.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE11.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE11.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE11.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE11.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE11 REQ %0d", `TILE11.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE11 mon: error request");
            end
        endcase
        $display("");

        if (`TILE11.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE11.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE11.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE11.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE11 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE11.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE11.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE11.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE11.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE11 mon:");
    //     $write("Core stall is set to: %0d", `TILE11.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC12

always @ (negedge clk)
begin
    if (`TILE12.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE12 mon:");
        $write("Request: ");
        case (`TILE12.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE12.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE12.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE12.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE12.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE12.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE12.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE12.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE12.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE12.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE12.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE12.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE12 REQ %0d", `TILE12.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE12 mon: error request");
            end
        endcase
        $display("");

        if (`TILE12.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE12.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE12.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE12.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE12 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE12.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE12.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE12.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE12.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE12 mon:");
    //     $write("Core stall is set to: %0d", `TILE12.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC13

always @ (negedge clk)
begin
    if (`TILE13.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE13 mon:");
        $write("Request: ");
        case (`TILE13.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE13.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE13.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE13.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE13.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE13.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE13.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE13.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE13.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE13.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE13.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE13.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE13 REQ %0d", `TILE13.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE13 mon: error request");
            end
        endcase
        $display("");

        if (`TILE13.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE13.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE13.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE13.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE13 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE13.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE13.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE13.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE13.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE13 mon:");
    //     $write("Core stall is set to: %0d", `TILE13.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC14

always @ (negedge clk)
begin
    if (`TILE14.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE14 mon:");
        $write("Request: ");
        case (`TILE14.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE14.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE14.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE14.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE14.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE14.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE14.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE14.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE14.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE14.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE14.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE14.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE14 REQ %0d", `TILE14.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE14 mon: error request");
            end
        endcase
        $display("");

        if (`TILE14.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE14.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE14.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE14.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE14 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE14.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE14.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE14.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE14.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE14 mon:");
    //     $write("Core stall is set to: %0d", `TILE14.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC15

always @ (negedge clk)
begin
    if (`TILE15.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE15 mon:");
        $write("Request: ");
        case (`TILE15.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE15.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE15.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE15.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE15.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE15.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE15.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE15.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE15.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE15.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE15.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE15.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE15 REQ %0d", `TILE15.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE15 mon: error request");
            end
        endcase
        $display("");

        if (`TILE15.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE15.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE15.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE15.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE15 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE15.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE15.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE15.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE15.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE15 mon:");
    //     $write("Core stall is set to: %0d", `TILE15.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC16

always @ (negedge clk)
begin
    if (`TILE16.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE16 mon:");
        $write("Request: ");
        case (`TILE16.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE16.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE16.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE16.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE16.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE16.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE16.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE16.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE16.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE16.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE16.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE16.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE16 REQ %0d", `TILE16.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE16 mon: error request");
            end
        endcase
        $display("");

        if (`TILE16.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE16.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE16.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE16.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE16 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE16.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE16.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE16.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE16.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE16 mon:");
    //     $write("Core stall is set to: %0d", `TILE16.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC17

always @ (negedge clk)
begin
    if (`TILE17.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE17 mon:");
        $write("Request: ");
        case (`TILE17.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE17.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE17.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE17.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE17.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE17.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE17.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE17.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE17.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE17.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE17.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE17.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE17 REQ %0d", `TILE17.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE17 mon: error request");
            end
        endcase
        $display("");

        if (`TILE17.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE17.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE17.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE17.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE17 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE17.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE17.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE17.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE17.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE17 mon:");
    //     $write("Core stall is set to: %0d", `TILE17.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC18

always @ (negedge clk)
begin
    if (`TILE18.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE18 mon:");
        $write("Request: ");
        case (`TILE18.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE18.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE18.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE18.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE18.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE18.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE18.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE18.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE18.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE18.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE18.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE18.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE18 REQ %0d", `TILE18.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE18 mon: error request");
            end
        endcase
        $display("");

        if (`TILE18.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE18.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE18.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE18.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE18 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE18.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE18.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE18.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE18.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE18 mon:");
    //     $write("Core stall is set to: %0d", `TILE18.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC19

always @ (negedge clk)
begin
    if (`TILE19.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE19 mon:");
        $write("Request: ");
        case (`TILE19.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE19.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE19.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE19.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE19.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE19.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE19.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE19.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE19.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE19.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE19.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE19.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE19 REQ %0d", `TILE19.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE19 mon: error request");
            end
        endcase
        $display("");

        if (`TILE19.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE19.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE19.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE19.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE19 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE19.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE19.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE19.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE19.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE19 mon:");
    //     $write("Core stall is set to: %0d", `TILE19.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC20

always @ (negedge clk)
begin
    if (`TILE20.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE20 mon:");
        $write("Request: ");
        case (`TILE20.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE20.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE20.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE20.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE20.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE20.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE20.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE20.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE20.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE20.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE20.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE20.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE20 REQ %0d", `TILE20.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE20 mon: error request");
            end
        endcase
        $display("");

        if (`TILE20.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE20.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE20.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE20.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE20 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE20.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE20.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE20.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE20.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE20 mon:");
    //     $write("Core stall is set to: %0d", `TILE20.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC21

always @ (negedge clk)
begin
    if (`TILE21.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE21 mon:");
        $write("Request: ");
        case (`TILE21.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE21.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE21.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE21.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE21.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE21.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE21.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE21.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE21.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE21.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE21.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE21.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE21 REQ %0d", `TILE21.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE21 mon: error request");
            end
        endcase
        $display("");

        if (`TILE21.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE21.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE21.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE21.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE21 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE21.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE21.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE21.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE21.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE21 mon:");
    //     $write("Core stall is set to: %0d", `TILE21.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC22

always @ (negedge clk)
begin
    if (`TILE22.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE22 mon:");
        $write("Request: ");
        case (`TILE22.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE22.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE22.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE22.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE22.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE22.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE22.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE22.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE22.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE22.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE22.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE22.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE22 REQ %0d", `TILE22.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE22 mon: error request");
            end
        endcase
        $display("");

        if (`TILE22.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE22.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE22.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE22.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE22 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE22.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE22.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE22.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE22.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE22 mon:");
    //     $write("Core stall is set to: %0d", `TILE22.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC23

always @ (negedge clk)
begin
    if (`TILE23.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE23 mon:");
        $write("Request: ");
        case (`TILE23.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE23.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE23.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE23.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE23.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE23.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE23.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE23.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE23.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE23.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE23.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE23.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE23 REQ %0d", `TILE23.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE23 mon: error request");
            end
        endcase
        $display("");

        if (`TILE23.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE23.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE23.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE23.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE23 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE23.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE23.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE23.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE23.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE23 mon:");
    //     $write("Core stall is set to: %0d", `TILE23.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC24

always @ (negedge clk)
begin
    if (`TILE24.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE24 mon:");
        $write("Request: ");
        case (`TILE24.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE24.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE24.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE24.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE24.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE24.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE24.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE24.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE24.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE24.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE24.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE24.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE24 REQ %0d", `TILE24.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE24 mon: error request");
            end
        endcase
        $display("");

        if (`TILE24.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE24.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE24.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE24.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE24 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE24.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE24.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE24.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE24.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE24 mon:");
    //     $write("Core stall is set to: %0d", `TILE24.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC25

always @ (negedge clk)
begin
    if (`TILE25.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE25 mon:");
        $write("Request: ");
        case (`TILE25.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE25.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE25.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE25.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE25.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE25.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE25.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE25.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE25.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE25.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE25.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE25.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE25 REQ %0d", `TILE25.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE25 mon: error request");
            end
        endcase
        $display("");

        if (`TILE25.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE25.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE25.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE25.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE25 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE25.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE25.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE25.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE25.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE25 mon:");
    //     $write("Core stall is set to: %0d", `TILE25.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC26

always @ (negedge clk)
begin
    if (`TILE26.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE26 mon:");
        $write("Request: ");
        case (`TILE26.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE26.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE26.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE26.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE26.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE26.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE26.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE26.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE26.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE26.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE26.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE26.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE26 REQ %0d", `TILE26.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE26 mon: error request");
            end
        endcase
        $display("");

        if (`TILE26.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE26.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE26.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE26.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE26 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE26.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE26.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE26.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE26.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE26 mon:");
    //     $write("Core stall is set to: %0d", `TILE26.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC27

always @ (negedge clk)
begin
    if (`TILE27.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE27 mon:");
        $write("Request: ");
        case (`TILE27.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE27.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE27.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE27.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE27.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE27.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE27.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE27.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE27.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE27.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE27.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE27.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE27 REQ %0d", `TILE27.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE27 mon: error request");
            end
        endcase
        $display("");

        if (`TILE27.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE27.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE27.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE27.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE27 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE27.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE27.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE27.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE27.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE27 mon:");
    //     $write("Core stall is set to: %0d", `TILE27.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC28

always @ (negedge clk)
begin
    if (`TILE28.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE28 mon:");
        $write("Request: ");
        case (`TILE28.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE28.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE28.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE28.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE28.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE28.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE28.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE28.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE28.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE28.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE28.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE28.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE28 REQ %0d", `TILE28.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE28 mon: error request");
            end
        endcase
        $display("");

        if (`TILE28.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE28.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE28.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE28.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE28 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE28.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE28.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE28.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE28.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE28 mon:");
    //     $write("Core stall is set to: %0d", `TILE28.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC29

always @ (negedge clk)
begin
    if (`TILE29.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE29 mon:");
        $write("Request: ");
        case (`TILE29.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE29.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE29.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE29.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE29.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE29.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE29.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE29.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE29.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE29.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE29.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE29.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE29 REQ %0d", `TILE29.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE29 mon: error request");
            end
        endcase
        $display("");

        if (`TILE29.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE29.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE29.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE29.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE29 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE29.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE29.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE29.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE29.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE29 mon:");
    //     $write("Core stall is set to: %0d", `TILE29.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC30

always @ (negedge clk)
begin
    if (`TILE30.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE30 mon:");
        $write("Request: ");
        case (`TILE30.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE30.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE30.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE30.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE30.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE30.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE30.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE30.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE30.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE30.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE30.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE30.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE30 REQ %0d", `TILE30.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE30 mon: error request");
            end
        endcase
        $display("");

        if (`TILE30.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE30.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE30.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE30.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE30 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE30.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE30.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE30.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE30.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE30 mon:");
    //     $write("Core stall is set to: %0d", `TILE30.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC31

always @ (negedge clk)
begin
    if (`TILE31.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE31 mon:");
        $write("Request: ");
        case (`TILE31.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE31.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE31.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE31.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE31.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE31.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE31.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE31.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE31.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE31.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE31.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE31.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE31 REQ %0d", `TILE31.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE31 mon: error request");
            end
        endcase
        $display("");

        if (`TILE31.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE31.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE31.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE31.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE31 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE31.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE31.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE31.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE31.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE31 mon:");
    //     $write("Core stall is set to: %0d", `TILE31.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC32

always @ (negedge clk)
begin
    if (`TILE32.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE32 mon:");
        $write("Request: ");
        case (`TILE32.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE32.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE32.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE32.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE32.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE32.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE32.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE32.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE32.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE32.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE32.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE32.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE32 REQ %0d", `TILE32.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE32 mon: error request");
            end
        endcase
        $display("");

        if (`TILE32.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE32.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE32.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE32.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE32 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE32.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE32.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE32.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE32.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE32 mon:");
    //     $write("Core stall is set to: %0d", `TILE32.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC33

always @ (negedge clk)
begin
    if (`TILE33.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE33 mon:");
        $write("Request: ");
        case (`TILE33.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE33.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE33.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE33.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE33.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE33.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE33.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE33.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE33.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE33.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE33.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE33.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE33 REQ %0d", `TILE33.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE33 mon: error request");
            end
        endcase
        $display("");

        if (`TILE33.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE33.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE33.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE33.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE33 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE33.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE33.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE33.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE33.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE33 mon:");
    //     $write("Core stall is set to: %0d", `TILE33.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC34

always @ (negedge clk)
begin
    if (`TILE34.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE34 mon:");
        $write("Request: ");
        case (`TILE34.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE34.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE34.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE34.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE34.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE34.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE34.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE34.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE34.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE34.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE34.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE34.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE34 REQ %0d", `TILE34.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE34 mon: error request");
            end
        endcase
        $display("");

        if (`TILE34.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE34.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE34.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE34.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE34 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE34.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE34.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE34.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE34.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE34 mon:");
    //     $write("Core stall is set to: %0d", `TILE34.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC35

always @ (negedge clk)
begin
    if (`TILE35.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE35 mon:");
        $write("Request: ");
        case (`TILE35.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE35.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE35.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE35.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE35.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE35.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE35.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE35.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE35.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE35.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE35.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE35.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE35 REQ %0d", `TILE35.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE35 mon: error request");
            end
        endcase
        $display("");

        if (`TILE35.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE35.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE35.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE35.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE35 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE35.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE35.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE35.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE35.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE35 mon:");
    //     $write("Core stall is set to: %0d", `TILE35.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC36

always @ (negedge clk)
begin
    if (`TILE36.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE36 mon:");
        $write("Request: ");
        case (`TILE36.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE36.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE36.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE36.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE36.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE36.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE36.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE36.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE36.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE36.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE36.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE36.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE36 REQ %0d", `TILE36.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE36 mon: error request");
            end
        endcase
        $display("");

        if (`TILE36.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE36.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE36.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE36.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE36 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE36.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE36.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE36.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE36.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE36 mon:");
    //     $write("Core stall is set to: %0d", `TILE36.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC37

always @ (negedge clk)
begin
    if (`TILE37.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE37 mon:");
        $write("Request: ");
        case (`TILE37.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE37.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE37.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE37.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE37.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE37.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE37.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE37.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE37.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE37.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE37.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE37.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE37 REQ %0d", `TILE37.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE37 mon: error request");
            end
        endcase
        $display("");

        if (`TILE37.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE37.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE37.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE37.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE37 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE37.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE37.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE37.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE37.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE37 mon:");
    //     $write("Core stall is set to: %0d", `TILE37.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC38

always @ (negedge clk)
begin
    if (`TILE38.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE38 mon:");
        $write("Request: ");
        case (`TILE38.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE38.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE38.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE38.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE38.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE38.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE38.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE38.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE38.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE38.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE38.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE38.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE38 REQ %0d", `TILE38.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE38 mon: error request");
            end
        endcase
        $display("");

        if (`TILE38.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE38.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE38.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE38.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE38 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE38.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE38.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE38.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE38.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE38 mon:");
    //     $write("Core stall is set to: %0d", `TILE38.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC39

always @ (negedge clk)
begin
    if (`TILE39.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE39 mon:");
        $write("Request: ");
        case (`TILE39.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE39.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE39.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE39.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE39.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE39.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE39.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE39.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE39.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE39.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE39.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE39.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE39 REQ %0d", `TILE39.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE39 mon: error request");
            end
        endcase
        $display("");

        if (`TILE39.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE39.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE39.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE39.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE39 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE39.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE39.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE39.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE39.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE39 mon:");
    //     $write("Core stall is set to: %0d", `TILE39.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC40

always @ (negedge clk)
begin
    if (`TILE40.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE40 mon:");
        $write("Request: ");
        case (`TILE40.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE40.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE40.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE40.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE40.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE40.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE40.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE40.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE40.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE40.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE40.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE40.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE40 REQ %0d", `TILE40.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE40 mon: error request");
            end
        endcase
        $display("");

        if (`TILE40.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE40.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE40.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE40.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE40 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE40.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE40.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE40.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE40.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE40 mon:");
    //     $write("Core stall is set to: %0d", `TILE40.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC41

always @ (negedge clk)
begin
    if (`TILE41.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE41 mon:");
        $write("Request: ");
        case (`TILE41.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE41.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE41.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE41.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE41.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE41.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE41.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE41.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE41.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE41.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE41.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE41.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE41 REQ %0d", `TILE41.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE41 mon: error request");
            end
        endcase
        $display("");

        if (`TILE41.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE41.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE41.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE41.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE41 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE41.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE41.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE41.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE41.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE41 mon:");
    //     $write("Core stall is set to: %0d", `TILE41.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC42

always @ (negedge clk)
begin
    if (`TILE42.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE42 mon:");
        $write("Request: ");
        case (`TILE42.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE42.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE42.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE42.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE42.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE42.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE42.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE42.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE42.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE42.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE42.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE42.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE42 REQ %0d", `TILE42.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE42 mon: error request");
            end
        endcase
        $display("");

        if (`TILE42.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE42.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE42.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE42.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE42 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE42.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE42.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE42.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE42.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE42 mon:");
    //     $write("Core stall is set to: %0d", `TILE42.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC43

always @ (negedge clk)
begin
    if (`TILE43.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE43 mon:");
        $write("Request: ");
        case (`TILE43.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE43.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE43.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE43.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE43.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE43.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE43.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE43.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE43.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE43.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE43.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE43.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE43 REQ %0d", `TILE43.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE43 mon: error request");
            end
        endcase
        $display("");

        if (`TILE43.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE43.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE43.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE43.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE43 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE43.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE43.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE43.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE43.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE43 mon:");
    //     $write("Core stall is set to: %0d", `TILE43.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC44

always @ (negedge clk)
begin
    if (`TILE44.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE44 mon:");
        $write("Request: ");
        case (`TILE44.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE44.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE44.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE44.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE44.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE44.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE44.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE44.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE44.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE44.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE44.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE44.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE44 REQ %0d", `TILE44.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE44 mon: error request");
            end
        endcase
        $display("");

        if (`TILE44.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE44.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE44.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE44.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE44 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE44.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE44.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE44.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE44.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE44 mon:");
    //     $write("Core stall is set to: %0d", `TILE44.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC45

always @ (negedge clk)
begin
    if (`TILE45.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE45 mon:");
        $write("Request: ");
        case (`TILE45.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE45.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE45.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE45.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE45.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE45.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE45.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE45.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE45.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE45.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE45.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE45.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE45 REQ %0d", `TILE45.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE45 mon: error request");
            end
        endcase
        $display("");

        if (`TILE45.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE45.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE45.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE45.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE45 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE45.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE45.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE45.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE45.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE45 mon:");
    //     $write("Core stall is set to: %0d", `TILE45.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC46

always @ (negedge clk)
begin
    if (`TILE46.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE46 mon:");
        $write("Request: ");
        case (`TILE46.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE46.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE46.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE46.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE46.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE46.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE46.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE46.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE46.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE46.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE46.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE46.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE46 REQ %0d", `TILE46.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE46 mon: error request");
            end
        endcase
        $display("");

        if (`TILE46.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE46.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE46.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE46.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE46 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE46.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE46.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE46.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE46.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE46 mon:");
    //     $write("Core stall is set to: %0d", `TILE46.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC47

always @ (negedge clk)
begin
    if (`TILE47.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE47 mon:");
        $write("Request: ");
        case (`TILE47.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE47.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE47.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE47.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE47.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE47.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE47.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE47.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE47.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE47.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE47.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE47.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE47 REQ %0d", `TILE47.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE47 mon: error request");
            end
        endcase
        $display("");

        if (`TILE47.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE47.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE47.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE47.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE47 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE47.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE47.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE47.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE47.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE47 mon:");
    //     $write("Core stall is set to: %0d", `TILE47.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC48

always @ (negedge clk)
begin
    if (`TILE48.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE48 mon:");
        $write("Request: ");
        case (`TILE48.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE48.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE48.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE48.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE48.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE48.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE48.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE48.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE48.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE48.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE48.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE48.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE48 REQ %0d", `TILE48.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE48 mon: error request");
            end
        endcase
        $display("");

        if (`TILE48.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE48.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE48.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE48.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE48 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE48.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE48.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE48.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE48.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE48 mon:");
    //     $write("Core stall is set to: %0d", `TILE48.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC49

always @ (negedge clk)
begin
    if (`TILE49.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE49 mon:");
        $write("Request: ");
        case (`TILE49.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE49.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE49.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE49.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE49.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE49.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE49.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE49.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE49.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE49.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE49.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE49.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE49 REQ %0d", `TILE49.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE49 mon: error request");
            end
        endcase
        $display("");

        if (`TILE49.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE49.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE49.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE49.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE49 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE49.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE49.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE49.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE49.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE49 mon:");
    //     $write("Core stall is set to: %0d", `TILE49.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC50

always @ (negedge clk)
begin
    if (`TILE50.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE50 mon:");
        $write("Request: ");
        case (`TILE50.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE50.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE50.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE50.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE50.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE50.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE50.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE50.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE50.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE50.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE50.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE50.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE50 REQ %0d", `TILE50.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE50 mon: error request");
            end
        endcase
        $display("");

        if (`TILE50.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE50.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE50.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE50.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE50 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE50.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE50.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE50.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE50.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE50 mon:");
    //     $write("Core stall is set to: %0d", `TILE50.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC51

always @ (negedge clk)
begin
    if (`TILE51.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE51 mon:");
        $write("Request: ");
        case (`TILE51.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE51.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE51.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE51.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE51.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE51.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE51.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE51.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE51.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE51.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE51.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE51.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE51 REQ %0d", `TILE51.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE51 mon: error request");
            end
        endcase
        $display("");

        if (`TILE51.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE51.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE51.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE51.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE51 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE51.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE51.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE51.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE51.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE51 mon:");
    //     $write("Core stall is set to: %0d", `TILE51.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC52

always @ (negedge clk)
begin
    if (`TILE52.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE52 mon:");
        $write("Request: ");
        case (`TILE52.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE52.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE52.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE52.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE52.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE52.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE52.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE52.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE52.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE52.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE52.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE52.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE52 REQ %0d", `TILE52.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE52 mon: error request");
            end
        endcase
        $display("");

        if (`TILE52.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE52.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE52.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE52.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE52 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE52.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE52.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE52.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE52.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE52 mon:");
    //     $write("Core stall is set to: %0d", `TILE52.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC53

always @ (negedge clk)
begin
    if (`TILE53.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE53 mon:");
        $write("Request: ");
        case (`TILE53.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE53.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE53.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE53.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE53.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE53.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE53.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE53.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE53.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE53.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE53.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE53.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE53 REQ %0d", `TILE53.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE53 mon: error request");
            end
        endcase
        $display("");

        if (`TILE53.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE53.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE53.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE53.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE53 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE53.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE53.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE53.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE53.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE53 mon:");
    //     $write("Core stall is set to: %0d", `TILE53.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC54

always @ (negedge clk)
begin
    if (`TILE54.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE54 mon:");
        $write("Request: ");
        case (`TILE54.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE54.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE54.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE54.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE54.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE54.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE54.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE54.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE54.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE54.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE54.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE54.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE54 REQ %0d", `TILE54.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE54 mon: error request");
            end
        endcase
        $display("");

        if (`TILE54.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE54.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE54.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE54.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE54 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE54.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE54.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE54.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE54.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE54 mon:");
    //     $write("Core stall is set to: %0d", `TILE54.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC55

always @ (negedge clk)
begin
    if (`TILE55.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE55 mon:");
        $write("Request: ");
        case (`TILE55.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE55.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE55.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE55.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE55.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE55.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE55.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE55.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE55.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE55.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE55.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE55.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE55 REQ %0d", `TILE55.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE55 mon: error request");
            end
        endcase
        $display("");

        if (`TILE55.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE55.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE55.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE55.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE55 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE55.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE55.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE55.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE55.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE55 mon:");
    //     $write("Core stall is set to: %0d", `TILE55.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC56

always @ (negedge clk)
begin
    if (`TILE56.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE56 mon:");
        $write("Request: ");
        case (`TILE56.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE56.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE56.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE56.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE56.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE56.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE56.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE56.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE56.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE56.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE56.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE56.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE56 REQ %0d", `TILE56.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE56 mon: error request");
            end
        endcase
        $display("");

        if (`TILE56.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE56.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE56.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE56.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE56 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE56.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE56.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE56.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE56.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE56 mon:");
    //     $write("Core stall is set to: %0d", `TILE56.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC57

always @ (negedge clk)
begin
    if (`TILE57.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE57 mon:");
        $write("Request: ");
        case (`TILE57.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE57.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE57.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE57.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE57.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE57.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE57.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE57.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE57.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE57.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE57.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE57.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE57 REQ %0d", `TILE57.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE57 mon: error request");
            end
        endcase
        $display("");

        if (`TILE57.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE57.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE57.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE57.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE57 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE57.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE57.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE57.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE57.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE57 mon:");
    //     $write("Core stall is set to: %0d", `TILE57.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC58

always @ (negedge clk)
begin
    if (`TILE58.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE58 mon:");
        $write("Request: ");
        case (`TILE58.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE58.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE58.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE58.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE58.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE58.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE58.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE58.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE58.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE58.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE58.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE58.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE58 REQ %0d", `TILE58.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE58 mon: error request");
            end
        endcase
        $display("");

        if (`TILE58.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE58.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE58.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE58.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE58 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE58.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE58.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE58.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE58.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE58 mon:");
    //     $write("Core stall is set to: %0d", `TILE58.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC59

always @ (negedge clk)
begin
    if (`TILE59.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE59 mon:");
        $write("Request: ");
        case (`TILE59.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE59.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE59.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE59.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE59.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE59.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE59.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE59.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE59.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE59.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE59.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE59.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE59 REQ %0d", `TILE59.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE59 mon: error request");
            end
        endcase
        $display("");

        if (`TILE59.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE59.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE59.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE59.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE59 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE59.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE59.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE59.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE59.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE59 mon:");
    //     $write("Core stall is set to: %0d", `TILE59.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC60

always @ (negedge clk)
begin
    if (`TILE60.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE60 mon:");
        $write("Request: ");
        case (`TILE60.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE60.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE60.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE60.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE60.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE60.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE60.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE60.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE60.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE60.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE60.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE60.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE60 REQ %0d", `TILE60.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE60 mon: error request");
            end
        endcase
        $display("");

        if (`TILE60.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE60.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE60.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE60.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE60 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE60.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE60.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE60.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE60.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE60 mon:");
    //     $write("Core stall is set to: %0d", `TILE60.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC61

always @ (negedge clk)
begin
    if (`TILE61.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE61 mon:");
        $write("Request: ");
        case (`TILE61.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE61.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE61.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE61.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE61.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE61.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE61.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE61.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE61.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE61.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE61.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE61.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE61 REQ %0d", `TILE61.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE61 mon: error request");
            end
        endcase
        $display("");

        if (`TILE61.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE61.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE61.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE61.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE61 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE61.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE61.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE61.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE61.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE61 mon:");
    //     $write("Core stall is set to: %0d", `TILE61.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC62

always @ (negedge clk)
begin
    if (`TILE62.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE62 mon:");
        $write("Request: ");
        case (`TILE62.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE62.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE62.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE62.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE62.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE62.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE62.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE62.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE62.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE62.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE62.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE62.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE62 REQ %0d", `TILE62.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE62 mon: error request");
            end
        endcase
        $display("");

        if (`TILE62.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE62.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE62.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE62.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE62 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE62.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE62.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE62.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE62.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE62 mon:");
    //     $write("Core stall is set to: %0d", `TILE62.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif


`ifdef RTL_SPARC63

always @ (negedge clk)
begin
    if (`TILE63.rtap.req_val)
    begin
        $display("");
        $display($time, " JTAG RTAP TILE63 mon:");
        $write("Request: ");
        case (`TILE63.rtap.req_op)
            `JTAG_REQ_OP_READ_SRAM:
            begin
                $write("JTAG_REQ_OP_READ_SRAM");
                $display("  TileID: %0d", `TILE63.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE63.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE63.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE63.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE63.rtap.req_address_bsel);
            end
            `JTAG_REQ_OP_WRITE_SRAM:
            begin
                $write("JTAG_REQ_OP_WRITE_SRAM");
                $display("  TileID: %0d", `TILE63.rtap.req_tileid);
                $display("  ThreadID: %0d", `TILE63.rtap.req_threadid);
                $display("  Address Index: %0d", `TILE63.rtap.req_address_index);
                $display("  Address SRAMID: %0d", `TILE63.rtap.req_address_sramid);
                $display("  Address BSEL: %0d", `TILE63.rtap.req_address_bsel);
                $display("  Wr Data: 0x%0x", `TILE63.rtap.req_data);
            end
            `JTAG_REQ_OP_READ_RTAP:
            begin
                $write("JTAG_REQ_OP_READ_RTAP");
            end
            `JTAG_REQ_OP_WRITE_RTAP:
            begin
                $write("JTAG_REQ_OP_WRITE_RTAP");
            end
            default:
            begin
                $write("UNKNOWN RTAP TILE63 REQ %0d", `TILE63.rtap.req_op);
                $display("");
                // repeat(5)@(posedge clk);
                // `MONITOR_PATH.fail("JTAG RTAP TILE63 mon: error request");
            end
        endcase
        $display("");

        if (`TILE63.rtap.req_op == `JTAG_REQ_OP_READ_RTAP || `TILE63.rtap.req_op == `JTAG_REQ_OP_WRITE_RTAP)
        begin
            case (`TILE63.rtap.req_misc)
                `JTAG_RTAP_ID_PC_REG:
                begin
                    $write("JTAG_RTAP_ID_PC_REG");
                end
                `JTAG_RTAP_ID_THREADSTATE_REG:
                begin
                    $write("JTAG_RTAP_ID_THREADSTATE_REG");
                end
                `JTAG_RTAP_ID_SHADOWSCAN_REG:
                begin
                    $write("JTAG_RTAP_ID_SHADOWSCAN_REG");
                end
                `JTAG_RTAP_ID_CPX_INTERRUPT:
                begin
                    $write("JTAG_RTAP_ID_CPX_INTERRUPT");
                end
                `JTAG_RTAP_ID_STALL_REG:
                begin
                    $write("JTAG_RTAP_ID_STALL_REG");
                end
                default:
                begin
                    $write("UNKNOWN RTAP READ/WRITE %0d", `TILE63.rtap.req_op);
                    $display("");
                    // repeat(5)@(posedge clk);
                    // `MONITOR_PATH.fail("JTAG RTAP TILE63 mon: error request");
                end
            endcase
        end
        $display("  TileID: %0d", `TILE63.rtap.req_tileid);
        $display("  ThreadID: %0d", `TILE63.rtap.req_threadid);
        $display("  Wr Data: 0x%0x", `TILE63.rtap.req_data);
        $display("");
    end // ctap req

    // if (`TILE63.rtap.core_stall_en)
    // begin
    //     $display("");
    //     $display($time, " JTAG RTAP TILE63 mon:");
    //     $write("Core stall is set to: %0d", `TILE63.rtap.core_stall_value);
    //     $display("");
    // end // ctap req
end

`endif




endmodule

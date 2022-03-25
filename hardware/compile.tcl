# This script was generated automatically by bender.
set ROOT "/scratch/aibrahim/clean/he-soc/hardware"

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/clk_rst_gen.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/rand_id_queue.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/rand_stream_mst.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/rand_synch_holdable_driver.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/rand_verif_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/sim_timeout.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/rand_synch_driver.sv" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/src/rand_stream_slv.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_verification-5d3f18d50de1a5d0/test/tb_clk_rst_gen.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/rtl/tc_sram.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/rtl/tc_clk.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/cluster_pwr_cells.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/generic_memory.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/generic_rom.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/pad_functional.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/pulp_buffer.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/pulp_pwr_cells.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/tc_pwr.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/test/tb_tc_sram.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/pulp_clock_gating_async.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/cluster_clk_cells.sv" \
    "$ROOT/.bender/git/checkouts/tech_cells_generic-3303c1c6e15120bb/src/deprecated/pulp_clk_cells.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/binary_to_gray.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cb_filter_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cc_onehot.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cdc_2phase.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cf_math_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/clk_div.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/delta_counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/ecc_pkg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/edge_propagator_tx.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/exp_backoff.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/fifo_v3.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/gray_to_binary.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/isochronous_4phase_handshake.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/isochronous_spill_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/lfsr.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/lfsr_16bit.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/lfsr_8bit.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/mv_filter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/onehot_to_bin.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/plru_tree.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/popcount.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/rr_arb_tree.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/rstgen_bypass.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/serial_deglitch.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/shift_reg.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/spill_register_flushable.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_demux.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_filter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_fork.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_intf.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_join.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_mux.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/sub_per_hash.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/sync.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/sync_wedge.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/unread.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/addr_decode.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cb_filter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cdc_fifo_2phase.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/ecc_decode.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/ecc_encode.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/edge_detect.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/lzc.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/max_counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/rstgen.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/spill_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_delay.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_fifo.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_fork_dynamic.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/cdc_fifo_gray.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/fall_through_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/id_queue.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_to_mem.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_arbiter_flushable.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_register.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_xbar.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/stream_omega_net.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/sram.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/addr_decode_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/cb_filter_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/cdc_2phase_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/cdc_fifo_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/fifo_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/graycode_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/id_queue_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/popcount_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/rr_arb_tree_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/stream_test.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/stream_register_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/stream_to_mem_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/sub_per_hash_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/isochronous_crossing_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/stream_omega_net_tb.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/test/stream_xbar_tb.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/clock_divider_counter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/find_first_one.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/generic_LFSR_8bit.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/generic_fifo.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/prioarbiter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/pulp_sync.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/pulp_sync_wedge.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/rrarbiter.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/clock_divider.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/fifo_v2.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/deprecated/fifo_v1.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/edge_propagator.sv" \
    "$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/src/edge_propagator_rx.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/defs_div_sqrt_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/iteration_div_sqrt_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/control_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/norm_div_sqrt_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/preprocess_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/nrbd_nrsc_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/div_sqrt_top_mvp.sv" \
    "$ROOT/.bender/git/checkouts/fpu_div_sqrt_mvp-b5bd423b7828a767/hdl/div_sqrt_mvp_wrapper.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_pkg.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_intf.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_atop_filter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_burst_splitter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_cdc_dst.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_cdc_src.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_cut.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_delayer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_demux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_dw_downsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_dw_upsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_id_prepend.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_isolate.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_join.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_demux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_join.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_mailbox.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_mux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_regs.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_to_apb.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_to_axi.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_modify_address.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_mux.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_serializer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_cdc.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_err_slv.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_dw_converter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_multicut.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_to_axi_lite.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_lite_xbar.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_xbar.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_sim_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/src/axi_test.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_dw_pkg.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_xbar_pkg.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_addr_test.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_atop_filter.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_cdc.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_delayer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_dw_downsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_dw_upsizer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_isolate.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_lite_mailbox.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_lite_regs.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_lite_to_apb.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_lite_to_axi.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_lite_xbar.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_modify_address.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_serializer.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_sim_mem.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_to_axi_lite.sv" \
    "$ROOT/.bender/git/checkouts/axi-f4f306610993e312/test/tb_axi_xbar.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_pkg.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_cast_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_classifier.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_divsqrt_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_fma.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_fma_multi.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_noncomp.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_opgroup_block.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_opgroup_fmt_slice.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_opgroup_multifmt_slice.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_rounding.sv" \
    "$ROOT/.bender/git/checkouts/fpnew-a28feb55d6d557a7/src/fpnew_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_single_slice.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_ar_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_aw_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_b_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_r_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_slice.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_w_buffer.sv" \
    "$ROOT/.bender/git/checkouts/axi_slice-e6f79d9e02e00e0b/src/axi_slice_wrap.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi_to_mem-524768e3a2f1ec62/cluster_riscv_defines.sv" \
    "$ROOT/.bender/git/checkouts/axi_to_mem-524768e3a2f1ec62/axi_to_mem.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/Req_Arb_Node_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/Resp_Arb_Node_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/lint_mux.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/DistributedArbitrationNetwork_Req_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/DistributedArbitrationNetwork_Resp_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/RoutingBlock_Req_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/RoutingBlock_2ch_Req_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/RoutingBlock_Resp_icache_intc.sv" \
    "$ROOT/.bender/git/checkouts/icache-intc-f54e3f9b062d7dca/icache_intc.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/include" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/include/apu_core_package.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/include/riscv_defines.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/include/riscv_tracer_defines.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/macload_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/mixed_precision_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_alu.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_alu_basic.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_alu_div.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_compressed_decoder.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_cs_registers.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_decoder.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_int_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_ex_stage.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_hwloop_controller.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_hwloop_regs.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/register_file_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_id_stage.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_if_stage.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_load_store_unit.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_mult.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_prefetch_buffer.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_prefetch_L0_buffer.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_core.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_apu_disp.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_fetch_fifo.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_L0_buffer.sv" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_pmp.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/include" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_register_file_latch.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/include" \
    "$ROOT/.bender/git/checkouts/riscv-4c4afae4226c25db/rtl/riscv_tracer.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1r_1w_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_64b_multi_port_read_32b_1row.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_multi_port_read_1row.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1r_1w_all.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1r_1w_all_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1r_1w_be.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1r_1w.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1r_1w_1row.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_128b_multi_port_read_32b.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_64b_multi_port_read_32b.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_64b_1r_32b.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_multi_port_read_be.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_1w_multi_port_read.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_2r_1w_asymm.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_2r_1w_asymm_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_2r_2w.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_3r_2w.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_3r_2w_be.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_multi_way_1w_64b_multi_port_read_32b.sv" \
    "$ROOT/.bender/git/checkouts/scm-92629277a46b0fd4/latch_scm/register_file_multi_way_1w_multi_port_read.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/src/apb_pkg.sv" \
    "$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/src/apb_intf.sv" \
    "$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/src/apb_regs.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/src/apb_test.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/test/tb_apb_regs.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi2per-efda6ef1d3f2c8e7/axi2per_req_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2per-efda6ef1d3f2c8e7/axi2per_res_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2per-efda6ef1d3f2c8e7/axi2per.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/cluster_dma-682ad8d99ed3999f/rtl/axi_dma_data_path.sv" \
    "$ROOT/.bender/git/checkouts/cluster_dma-682ad8d99ed3999f/rtl/axi_dma_data_mover.sv" \
    "$ROOT/.bender/git/checkouts/cluster_dma-682ad8d99ed3999f/rtl/axi_dma_burst_reshaper.sv" \
    "$ROOT/.bender/git/checkouts/cluster_dma-682ad8d99ed3999f/rtl/axi_dma_backend.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/common_pads-d771d63e54692a28/src/pad_alsaqr.behav.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/event_unit_core.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/hw_barrier_unit.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/hw_dispatch.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/hw_mutex_unit.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/interc_sw_evt_trig.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/periph_FIFO_id.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/soc_periph_fifo.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/event_unit_interface_mux.sv" \
    "$ROOT/.bender/git/checkouts/event_unit_flex-c49f09b5601e63cc/rtl/event_unit_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cdc_sync_rstn.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cdc_sync_signal.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cdc_edge_detect.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_digital_pkg.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_cnr.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_cfg_if.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_regfile.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_fdc.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_dlf.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_dith_gen.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_mtd.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_lock_man.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_glitchfree_clkmux.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_clock_divider_counter.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_clock_divider.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_output_stage.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/fll_digital.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/gf22_FLL_model.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cell_icg.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cell_mux2.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cell_xor2.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cell_clkmux2.sv" \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/cell_and2.sv"
}]} {return 1}

if {[catch {vcom -2008 \
    -64 -nologo -quiet -2008 -work  work -pedanticerrors \
    "$ROOT/.bender/git/checkouts/fll_behav-ef8f564ebf29dfab/FLL/DCO_Model_v1p0.vhd"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/FP_WRAP/fp_iter_divsqrt_msv_wrapper_2_STAGE.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/FP_WRAP/fpnew_wrapper.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/AddressDecoder_Resp_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/FanInPrimitive_Req_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/FanInPrimitive_Resp_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/FPU_clock_gating.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/fpu_demux.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/LFSR_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/optimal_alloc.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/RR_Flag_Req_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/AddressDecoder_Req_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/ArbitrationTree_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/RequestBlock_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/ResponseTree_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/ResponseBlock_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/XBAR_FPU.sv" \
    "$ROOT/.bender/git/checkouts/fpu_interco-0601f7c836b40a74/RTL/shared_fpu_cluster.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/CTRL_UNIT/hier_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/ram_ws_rs_data_scm.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/ram_ws_rs_tag_scm.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/RefillTracker_4.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/REP_buffer_4.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1_CACHE/pri_icache_controller.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1_CACHE/refill_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1_CACHE/register_file_1w_multi_port_read.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/CTRL_UNIT/hier_icache_ctrl_unit_wrap.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/AXI4_REFILL_Resp_Deserializer.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/share_icache_controller.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1_CACHE/register_file_1w_multi_port_read_test_wrap.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1.5_CACHE/share_icache.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/L1_CACHE/pri_icache.sv" \
    "$ROOT/.bender/git/checkouts/hier-icache-ce4339c8617ce84d/RTL/TOP/icache_hier_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/icache_private-33e01771bc0513c1/RTL/ICACHE/icache_controller_private.sv" \
    "$ROOT/.bender/git/checkouts/icache_private-33e01771bc0513c1/RTL/ICACHE/icache_bank_private.sv" \
    "$ROOT/.bender/git/checkouts/icache_private-33e01771bc0513c1/TOP/icache_top_private.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/per2axi-26522d148c0ff823/src/per2axi_busy_unit.sv" \
    "$ROOT/.bender/git/checkouts/per2axi-26522d148c0ff823/src/per2axi_req_channel.sv" \
    "$ROOT/.bender/git/checkouts/per2axi-26522d148c0ff823/src/per2axi_res_channel.sv" \
    "$ROOT/.bender/git/checkouts/per2axi-26522d148c0ff823/src/per2axi.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_intf.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/vendor/lowrisc_opentitan/src/prim_subreg_arb.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/vendor/lowrisc_opentitan/src/prim_subreg_ext.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/apb_to_reg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/axi_to_reg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/periph_to_reg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_cdc.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_demux.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_mux.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_to_mem.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_uniform.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/vendor/lowrisc_opentitan/src/prim_subreg_shadow.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/vendor/lowrisc_opentitan/src/prim_subreg.sv" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/axi_lite_to_reg.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/src/reg_test.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/timer_unit-ff7f0d29bc3535a1/rtl/timer_unit_counter.sv" \
    "$ROOT/.bender/git/checkouts/timer_unit-ff7f0d29bc3535a1/rtl/timer_unit_counter_presc.sv" \
    "$ROOT/.bender/git/checkouts/timer_unit-ff7f0d29bc3535a1/rtl/apb_timer_unit.sv" \
    "$ROOT/.bender/git/checkouts/timer_unit-ff7f0d29bc3535a1/rtl/timer_unit.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_clk_gen.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_event_counter.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_generic_fifo.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_shiftreg.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/udma_apb_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/udma_clk_div_cnt.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/udma_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/udma_dc_fifo.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/core/udma_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/core/udma_ch_addrgen.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_tx_fifo.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_tx_fifo_dc.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/io_tx_fifo_mark.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/common/udma_clkgen.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/core/udma_tx_channels.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/core/udma_stream_unit.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/core/udma_rx_channels.sv" \
    "$ROOT/.bender/git/checkouts/udma_core-6769e3a8c5740fae/rtl/core/udma_core.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/alsaqr_periph_padframe/src/pkg_alsaqr_periph_padframe.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/pkg_internal_alsaqr_periph_padframe_periphs.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/alsaqr_periph_padframe_periphs_config_reg_pkg.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/alsaqr_periph_padframe_periphs_config_reg_top.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/alsaqr_periph_padframe_periphs_pads.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/alsaqr_periph_padframe_periphs_muxer.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/alsaqr_periph_padframe_periphs.sv" \
    "$ROOT/deps/alsaqr_periph_padframe/src/alsaqr_periph_padframe.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/adv_timer_apb_if.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/comparator.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/input_stage.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/lut_4x4.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/out_filter.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/prescaler.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/timer_cntrl.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/up_down_counter.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/timer_module.sv" \
    "$ROOT/.bender/git/checkouts/apb_adv_timer-6d30e798426aee8e/rtl/apb_adv_timer.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb_fll_if-33cdab3a698790a8/src/fll_intf.sv" \
    "$ROOT/.bender/git/checkouts/apb_fll_if-33cdab3a698790a8/src/apb_to_fll.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb_fll_if-33cdab3a698790a8/test/apb_fll_tb.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb_gpio-82167632520244fc/rtl/apb_gpio.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/apb_host_control_regs/src/control_register_config_reg_pkg.sv" \
    "$ROOT/deps/apb_host_control_regs/src/control_register_config_reg_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/apb_node-d1be85a0d6609d79/src/apb_node.sv" \
    "$ROOT/.bender/git/checkouts/apb_node-d1be85a0d6609d79/src/apb_node_wrap.sv"
}]} {return 1}

if {[catch {vcom -2008 \
    -64 -nologo -quiet -2008 -work  work -pedanticerrors \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/apb_uart.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_clock_div.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_counter.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_edge_detect.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_fifo.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_input_filter.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_input_sync.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/slib_mv_filter.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/uart_baudgen.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/uart_interrupt.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/uart_receiver.vhd" \
    "/scratch/aibrahim/clean/he-soc/fpga/src/apb_uart/src/uart_transmitter.vhd"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_busy_unit.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_rd_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_tcdm_rd_if.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_tcdm_synch.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_tcdm_unit.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_tcdm_wr_if.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_trans_unit.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2mem_wr_channel.sv" \
    "$ROOT/.bender/git/checkouts/axi2tcdm-524768e3a2f1ec62/axi2tcdm.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_res_tbl.sv" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_riscv_amos_alu.sv" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_riscv_amos.sv" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_riscv_lrsc.sv" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_riscv_atomics.sv" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_riscv_lrsc_wrap.sv" \
    "$ROOT/deps/axi_riscv_atomics/src/axi_riscv_atomics_wrap.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/axi_tlb/src/axi_tlb_l1.sv" \
    "$ROOT/deps/axi_tlb/src/axi_tlb.sv"
}]} {return 1}

if {[catch {vcom -2008 \
    -64 -nologo -quiet -2008 -work  work -pedanticerrors \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/unary_ops_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/drv_stat_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_fd_register_map.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_fd_frame_format.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/id_transfer_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_constants_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_config_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_types_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/txt_buffer_fsm.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/tx_arbitrator_fsm.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/priority_decoder.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/tx_arbitrator.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/rx_buffer_pointers.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/rx_buffer_fsm.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/trigger_generator.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/synchronisation_checker.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/segment_end_detector.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_time_fsm.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_time_counters.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_time_cfg_capture.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_segment_meter.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/prescaler.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/memory_reg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/memory_bus.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/data_mux.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/cmn_reg_map_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_registers_pkg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/test_registers_reg_map.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/control_registers_reg_map.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/address_decoder.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/access_signaler.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/int_module.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/apb_ifc.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/ahb_ifc.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/range_filter.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_filter.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/frame_filters.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/sig_sync.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/shift_reg_preload.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/shift_reg_byte.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/shift_reg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/rst_sync.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/mux2.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/majority_decoder_3.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/inf_ram_wrapper.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/txt_buffer_ram.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/rx_buffer_ram.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/endian_swapper.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/dlc_decoder.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/dff_arst_ce.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/dff_arst.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/int_manager.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/clk_gate.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/txt_buffer.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/rx_buffer.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/memory_registers.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/tx_shift_reg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/trigger_mux.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/rx_shift_reg.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/retransmitt_counter.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/reintegration_counter.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/protocol_control_fsm.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/operation_control.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/fault_confinement_rules.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/fault_confinement_fsm.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/err_detector.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/err_counters.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/fault_confinement.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/crc_calc.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/control_counter.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/protocol_control.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_crc.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bus_traffic_counters.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_stuffing.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_destuffing.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_core.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/tx_data_cache.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/trv_delay_meas.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/ssp_generator.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/sample_mux.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/data_edge_detector.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bit_err_detector.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/bus_sampling.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_top_level.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_top_apb.vhd" \
    "$ROOT/.bender/git/checkouts/can_bus-b2ee71fbb4213abd/rtl/can_top_ahb.vhd"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/clint/./axi_lite_interface.sv" \
    "$ROOT/include/ariane_axi_soc_pkg.sv" \
    "$ROOT/deps/clint/./clint.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/models/generic_delay_D4_O2_3P750_1P875_CG1.behav.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/test/src/axi_to_mem.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/test/axi_channel_compare.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/test/fixture_serial_link.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/test/tb_serial_link.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/test/tb_axi_serial_link.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/src/serial_link_pkg.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/src/serial_link_delay.sv" \
    "$ROOT/.bender/git/checkouts/ddr-link-15359d33a688bda0/src/serial_link.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/models/generic_delay_D4_O1_3P750_CG0.behav.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_pkg.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_hyper_busy.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_cmd_queue.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_hyper_reg_if_common.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_hyper_reg_if_mulid.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/hyper_twd_trans_spliter.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_rxbuffer.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_txbuffer.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_hyper_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/hyper_unpack.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_cfg_outbuff.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_hyper_busy_phy.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/udma_hyper/udma_hyper.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_clk_gen.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_clock_diff_out.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_w2phy.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_phy2r.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_ddr_out.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_delay.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_trx.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_cfg_regs.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_phy.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_phy_if.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_axi.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus_async_macro.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/models/s27ks0641/s27ks0641.v" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/test/fixture_hyperbus.sv" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/test/hyperbus_tb.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/hyperbus-31b7ec6ca1f69e24/src/hyperbus.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/packages/apu_package.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/packages/pulp_cluster_package.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/tcdm_interconnect_pkg.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/interfaces/tcdm_bank_mem_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/interfaces/xbar_demux_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/interfaces/xbar_periph_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/interfaces/xbar_tcdm_bus_64.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/interfaces/xbar_tcdm_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/cluster_control_unit/cluster_control_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/axi2per_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_bus_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_clock_gate.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_event_map.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_interconnect_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_timer_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cpu_marx_if.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dmac_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/per2axi_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/per_demux_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/periph_FIFO.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/periph_demux.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/tlb_miss_queue.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/tryx_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/xne_wrap.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_dma_transfer_id_gen.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_dma_frontend_regs.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_peripherals.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/core_demux.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/cluster_dma_frontend.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/core_region.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/pulp_cluster.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/AddressDecoder_Req.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/AddressDecoder_Resp.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/FanInPrimitive_Req.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/FanInPrimitive_Resp.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/MUX2_REQ.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/TCDM_PIPE_REQ.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/TCDM_PIPE_RESP.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/TestAndSet.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/grant_mask.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/priority_Flag_Req.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/ArbitrationTree.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/ResponseTree.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/RequestBlock1CH.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/RequestBlock2CH.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/ResponseBlock.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/XBAR_TCDM.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/low_latency_interco/XBAR_TCDM_WRAPPER.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/peripheral_interco" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_PE_Req.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/MUX2_REQ_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/RR_Flag_Req_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/ArbitrationTree_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/ResponseTree_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/ResponseBlock_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/RequestBlock1CH_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/RequestBlock2CH_PE.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/peripheral_interco/XBAR_PE.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/tcdm_interconnect_pkg.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/addr_dec_resp_mux.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/amo_shim.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/xbar.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/clos_net.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/bfly_net.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_interconnect/rtl/tcdm_interconnect/tcdm_interconnect.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/include" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/HW_barrier_logic.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/event_unit_arbiter.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/event_unit_mux.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/event_unit_sm.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/interrupt_mask.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/interfaces/bbmux_config_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/interfaces/clkgate_config_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/HW_barrier.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/event_unit_input.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/event_unit/event_unit.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/interfaces/l0_ctrl_unit_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/interfaces/mp_icache_ctrl_unit_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/interfaces/mp_pf_icache_ctrl_unit_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/interfaces/pri_icache_ctrl_unit_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/interfaces/sp_icache_ctrl_unit_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/mp_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/mp_pf_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/new_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/pri_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/icache_ctrl_unit/sp_icache_ctrl_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/mmu_config_unit/interfaces/mmu_config_bus.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/mmu_config_unit/mmu_config_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/perf_counters_unit/perf_counters_unit.sv" \
    "$ROOT/.bender/git/checkouts/pulp_cluster-9a09e79cfdfc5c71/rtl/dependencies/cluster_peripherals/tcdm_pipe_unit/tcdm_pipe_unit.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/include/dm_pkg.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dmi_cdc.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dmi_jtag.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dmi_jtag_tap.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dm_csrs.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dm_mem.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dm_sba.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/src/dm_top.sv" \
    "$ROOT/.bender/git/checkouts/riscv-dbg-3456f07661f0f4c2/debug_rom/debug_rom.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/rv_plic/rtl/reg_intf_pkg.sv" \
    "$ROOT/deps/rv_plic/rtl/rv_plic_target.sv" \
    "$ROOT/deps/rv_plic/rtl/rv_plic_gateway.sv" \
    "$ROOT/deps/rv_plic/rtl/plic_regmap.sv" \
    "$ROOT/deps/rv_plic/rtl/plic_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/tcdm_interconnect_pkg.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/addr_dec_resp_mux.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/amo_shim.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/variable_latency_interconnect/addr_decoder.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/xbar.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/variable_latency_interconnect/simplex_xbar.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/clos_net.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/bfly_net.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/variable_latency_interconnect/full_duplex_xbar.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/tcdm_interconnect/tcdm_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/variable_latency_interconnect/variable_latency_bfly_net.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/variable_latency_interconnect/variable_latency_interconnect.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/FanInPrimitive_Req.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/ArbitrationTree.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/MUX2_REQ.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/AddressDecoder_Resp.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/TestAndSet.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/RequestBlock2CH.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/RequestBlock1CH.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/FanInPrimitive_Resp.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/ResponseTree.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/ResponseBlock.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/AddressDecoder_Req.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/XBAR_TCDM.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/XBAR_TCDM_WRAPPER.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/TCDM_PIPE_REQ.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/TCDM_PIPE_RESP.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/grant_mask.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco/priority_Flag_Req.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/AddressDecoder_PE_Req.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/ArbitrationTree_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/RR_Flag_Req_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/MUX2_REQ_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/RequestBlock1CH_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/RequestBlock2CH_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/ResponseBlock_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/ResponseTree_PE.sv" \
    "$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco/XBAR_PE.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/udma_camera-0e64b0e71d79204e/rtl/camera_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_camera-0e64b0e71d79204e/rtl/camera_if.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/udma_external_per-89cf13984a45121a/rtl/udma_external_per_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_external_per-89cf13984a45121a/rtl/udma_traffic_gen_rx.sv" \
    "$ROOT/.bender/git/checkouts/udma_external_per-89cf13984a45121a/rtl/udma_traffic_gen_tx.sv" \
    "$ROOT/.bender/git/checkouts/udma_external_per-89cf13984a45121a/rtl/udma_external_per_top.sv" \
    "$ROOT/.bender/git/checkouts/udma_external_per-89cf13984a45121a/rtl/udma_external_per_wrapper.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/udma_filter-bbfcb15ee4853575/rtl/udma_filter_au.sv" \
    "$ROOT/.bender/git/checkouts/udma_filter-bbfcb15ee4853575/rtl/udma_filter_bincu.sv" \
    "$ROOT/.bender/git/checkouts/udma_filter-bbfcb15ee4853575/rtl/udma_filter_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_filter-bbfcb15ee4853575/rtl/udma_filter_rx_dataout.sv" \
    "$ROOT/.bender/git/checkouts/udma_filter-bbfcb15ee4853575/rtl/udma_filter_tx_datafetch.sv" \
    "$ROOT/.bender/git/checkouts/udma_filter-bbfcb15ee4853575/rtl/udma_filter.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/udma_i2c-eb45f5c7d847fbd9/rtl" \
    "$ROOT/.bender/git/checkouts/udma_i2c-eb45f5c7d847fbd9/rtl/udma_i2c_bus_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/udma_i2c-eb45f5c7d847fbd9/rtl/udma_i2c_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_i2c-eb45f5c7d847fbd9/rtl/udma_i2c_control.sv" \
    "$ROOT/.bender/git/checkouts/udma_i2c-eb45f5c7d847fbd9/rtl/udma_i2c_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "+incdir+$ROOT/.bender/git/checkouts/udma_qspi-792c44c206cea8e6/rtl" \
    "$ROOT/.bender/git/checkouts/udma_qspi-792c44c206cea8e6/rtl/udma_spim_ctrl.sv" \
    "$ROOT/.bender/git/checkouts/udma_qspi-792c44c206cea8e6/rtl/udma_spim_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_qspi-792c44c206cea8e6/rtl/udma_spim_txrx.sv" \
    "$ROOT/.bender/git/checkouts/udma_qspi-792c44c206cea8e6/rtl/udma_spim_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/sdio_crc16.sv" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/sdio_crc7.sv" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/udma_sdio_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/sdio_txrx_cmd.sv" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/sdio_txrx_data.sv" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/sdio_txrx.sv" \
    "$ROOT/.bender/git/checkouts/udma_sdio-29731337d46920b0/rtl/udma_sdio_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/.bender/git/checkouts/udma_uart-7913db09929e0e37/rtl/udma_uart_reg_if.sv" \
    "$ROOT/.bender/git/checkouts/udma_uart-7913db09929e0e37/rtl/udma_uart_rx.sv" \
    "$ROOT/.bender/git/checkouts/udma_uart-7913db09929e0e37/rtl/udma_uart_tx.sv" \
    "$ROOT/.bender/git/checkouts/udma_uart-7913db09929e0e37/rtl/udma_uart_top.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/util/include/instr_tracer_pkg.sv" \
    "$ROOT/deps/util/./instr_tracer_if.sv" \
    "$ROOT/deps/util/./instr_tracer.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/deps/util/./axi2mem.sv" \
    "$ROOT/deps/util/./axi_master_connect.sv" \
    "$ROOT/deps/util/./axi_slave_connect.sv" \
    "$ROOT/deps/util/./axi_master_connect_rev.sv" \
    "$ROOT/deps/util/./axi_slave_connect_rev.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/include/ariane_soc_pkg.sv" \
    "$ROOT/include/apb_soc_pkg.sv" \
    "$ROOT/include/pulp_interfaces.sv" \
    "$ROOT/include/ariane_axi_soc_pkg.sv" \
    "$ROOT/include/udma_subsystem_pkg.sv" \
    "$ROOT/include/gpio_pkg.sv" \
    "$ROOT/include/tcdm_macros.sv" \
    "$ROOT/host/axi2tcdm_wrap.sv" \
    "$ROOT/host/ariane_peripherals.sv" \
    "$ROOT/host/udma_subsystem.sv" \
    "$ROOT/../fpga/src/axi2apb/src/axi2apb.sv" \
    "$ROOT/../fpga/src/axi2apb/src/axi2apb_64_32.sv" \
    "$ROOT/../fpga/src/axi2apb/src/axi2apb_wrap.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_w_buffer.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_b_buffer.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_slice_wrap.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_slice.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_single_slice.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_ar_buffer.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_r_buffer.sv" \
    "$ROOT/../fpga/src/axi_slice/src/axi_aw_buffer.sv" \
    "$ROOT/../fpga/src/apb_timer/apb_timer.sv" \
    "$ROOT/../fpga/src/apb_timer/timer.sv" \
    "$ROOT/host/periph_bus_wrap.sv" \
    "$ROOT/host/freqmeter.sv" \
    "$ROOT/host/alsaqr_clk_rst_gen.sv" \
    "$ROOT/host/apb_soc_control.sv" \
    "$ROOT/host/apb_subsystem.sv" \
    "$ROOT/host/gpio2padframe.sv" \
    "$ROOT/host/cva6_synth_wrap.sv" \
    "$ROOT/host/cva6_subsystem.sv" \
    "$ROOT/host/l2_subsystem.sv" \
    "$ROOT/host/clk_gen_hyper.sv" \
    "$ROOT/host/host_domain.sv" \
    "$ROOT/host/pad_frame.sv" \
    "$ROOT/host/al_saqr.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/tb/vip/hyperflash_model/s26ks512s.v" \
    "$ROOT/tb/vip/hyperram_model/s27ks0641.v" \
    "$ROOT/tb/vip/i2c_eeprom/24FC1025.v" \
    "$ROOT/tb/vip/spi_flash/S25fs256s/model/s25fs256s.v" \
    "$ROOT/tb/vip/camera/cam_vip.sv"
}]} {return 1}

if {[catch {vlog -incr -sv \
    +cover=bcfst+/dut -incr -64 -nologo -quiet -suppress 13262 -permissive +define+WT_DCACHE  -work  work -suppress 2583 -suppress 13314  \
    +define+TARGET_RTL \
    +define+TARGET_SIMULATION \
    +define+TARGET_TEST \
    +define+TARGET_VIP \
    +define+TARGET_VSIM \
    "+incdir+$ROOT/.bender/git/checkouts/common_cells-bca0567726f6ba41/include" \
    "+incdir+$ROOT/.bender/git/checkouts/axi-f4f306610993e312/include" \
    "+incdir+$ROOT/.bender/git/checkouts/apb-81dd8e3c317a10ef/include" \
    "+incdir+$ROOT/.bender/git/checkouts/register_interface-0f3890e8adc663c8/include" \
    "+incdir+$ROOT/deps/alsaqr_periph_padframe/include" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/low_latency_interco" \
    "+incdir+$ROOT/.bender/git/checkouts/tcdm_interconnect-470bcbc512e29d83/rtl/peripheral_interco" \
    "+incdir+$ROOT/include" \
    "$ROOT/tb/common/uart.sv" \
    "$ROOT/tb/common/SimDTM.sv" \
    "$ROOT/tb/common/SimJTAG.sv" \
    "$ROOT/../bootrom/bootrom.sv" \
    "$ROOT/tb/common/jtag_pkg.sv" \
    "$ROOT/tb/common/jtag_intf.sv" \
    "$ROOT/tb/common/mock_uart.sv" \
    "$ROOT/tb/ariane_tb.sv"
}]} {return 1}

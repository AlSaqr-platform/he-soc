start_gui
create_project alsaqr $::env(PROJECT_HOME) -part $::env(XILINX_PART)
source ./alsaqr/tcl/generated/compile.tcl
set_property top alsaqr_xilinx [current_fileset]
read_ip ./alsaqr/tcl/ips/clk_mngr/ip/xilinx_clk_mngr.xci
read_ip ./alsaqr/tcl/ips/boot_rom/ip/xilinx_rom_bank_1024x64.xci
read_ip ./alsaqr/tcl/ips/ddr/ip/ddr4_0.xci
add_files -fileset constrs_1 -norecurse "alsaqr/tcl/fmc_board_$::env(BOARD).xdc"
update_compile_order -fileset sources_1
auto_detect_xpm
read_xdc ./alsaqr/tcl/constraints.xdc
synth_design
update_compile_order -fileset sources_1
launch_runs impl_1 -to_step write_bitstream -jobs 64
wait_on_run impl_1
report_clocks
report_utilization

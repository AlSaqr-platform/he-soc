# start_gui
set outputDir reports
file mkdir $outputDir
create_project alsaqr $::env(PROJECT_HOME) -part $::env(XILINX_PART)
source ./alsaqr/tcl/generated/compile.tcl
set_property top alsaqr_xilinx [current_fileset]
read_ip ./alsaqr/tcl/ips/boot_rom/ip/xilinx_rom_bank_1024x64.xci
read_ip ./alsaqr/tcl/ips/clk_mngr/ip/xilinx_clk_mngr.xci
read_ip ./alsaqr/tcl/ips/ddr/ip/ddr4_0.xci
read_ip ./alsaqr/tcl/ips/qspi/ip/xilinx_qspi.xci
read_ip ./alsaqr/tcl/ips/rom_ot/ip/xilinx_rom_bank_8192x40.xci
read_ip ./alsaqr/tcl/ips/otp_ot/ip/xilinx_rom_bank_1024x22.xci
add_files -fileset constrs_1 -norecurse "alsaqr/tcl/fmc_board_$::env(BOARD).xdc"
set SRC_CLK_PERIOD 25
if {$::env(MAIN_MEM)=="HYPER"} {
    set SRC_CLK_PERIOD 100
    add_files -fileset constrs_1 -norecurse "alsaqr/tcl/fmc_board_hyper_$::env(BOARD).xdc"
} elseif {$::env(MAIN_MEM)=="DDR4"} {
    add_files -fileset constrs_1 -norecurse "alsaqr/tcl/ddr_$::env(BOARD).xdc"
    if {$::env(SIMPLE_PAD)=="1"} {
        add_files -fileset constrs_1 -norecurse "alsaqr/tcl/fmc_board_validation_$::env(BOARD).xdc"
    }
}
if {$::env(USE_OT)=="1"} {
    add_files -fileset constrs_1 -norecurse "alsaqr/tcl/fmc_board_opentitan_$::env(BOARD).xdc"
}
update_compile_order -fileset sources_1
auto_detect_xpm
read_xdc ./timing_constr.xdc
synth_design
update_compile_order -fileset sources_1
opt_design
place_design
report_clock_utilization -file $outputDir/clock_util.rpt
write_checkpoint -force $outputDir/post_place.dcp
report_utilization -file $outputDir/post_place_util.rpt
report_timing_summary -file $outputDir/post_place_timing_summary.rpt
route_design
report_timing_summary -file $outputDir/post_route_preopt_timing_summary.rpt
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
 puts "Found setup timing violations => running physical optimization"
 phys_opt_design
 report_timing_summary -file $outputDir/post_route_timing_summary.rpt
}
write_checkpoint -force $outputDir/post_route.dcp
report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
report_power -file $outputDir/post_route_power.rpt
report_drc -file $outputDir/post_imp_drc.rpt
write_bitstream -force $outputDir/alsaqr_xilinx.bit

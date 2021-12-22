set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

create_project ddr4_0 . -part $partNumber
set_property board_part $boardName [current_project]
create_ip -name ddr4 -vendor xilinx.com -library ip -version 2.2 -module_name ddr4_0
set_property -dict [list CONFIG.C0.DDR4_Clamshell {false} CONFIG.C0.DDR4_TimePeriod {833} CONFIG.C0.DDR4_InputClockPeriod {7998} CONFIG.C0.DDR4_CLKOUT0_DIVIDE {5} CONFIG.C0.DDR4_MemoryPart {MT40A256M16GE-083E} CONFIG.C0.DDR4_DataWidth {16} CONFIG.C0.DDR4_AxiSelection {true} CONFIG.C0.DDR4_CasWriteLatency {12} CONFIG.C0.DDR4_AxiDataWidth {128} CONFIG.C0.DDR4_AxiArbitrationScheme {ROUND_ROBIN} CONFIG.C0.DDR4_AxiAddressWidth {29} CONFIG.C0.DDR4_AxiIDWidth {7} CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {12} CONFIG.System_Clock {No_Buffer} CONFIG.C0.BANK_GROUP_WIDTH {1} CONFIG.C0.CS_WIDTH {1}] [get_ips ddr4_0]
generate_target {instantiation_template} [get_files /scratch/lvalente/ddronvcu118/project_1/project_1.srcs/sources_1/ip/ddr4_0/ddr4_0.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  ./ddr4_0.srcs/sources_1/ip/ddr4_0/ddr4_0.xci]
catch { config_ip_cache -export [get_ips -all ddr4_0] }
export_ip_user_files -of_objects [get_files ./ddr4_0.srcs/sources_1/ip/ddr4_0/ddr4_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ./ddr4_0.srcs/sources_1/ip/ddr4_0/ddr4_0.xci]
launch_runs -jobs 64 ddr4_0_synth_1
wait_on_run ddr4_0_synth_1

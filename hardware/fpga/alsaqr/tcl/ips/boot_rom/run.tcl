set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)


create_project xilinx_rom_bank_1024x64 . -part $partNumber
set_property board_part $boardName [current_project]
create_ip -name dist_mem_gen -vendor xilinx.com -library ip -version 8.0 -module_name xilinx_rom_bank_1024x64
set_property -dict [list CONFIG.depth {1024} CONFIG.data_width {64} CONFIG.memory_type {rom} CONFIG.input_options {registered} CONFIG.output_options {non_registered} CONFIG.single_port_output_clock_enable {false} CONFIG.default_data {ffffffff}] [get_ips  xilinx_rom_bank_1024x64]
exec cp boot_code.coe xilinx_rom_bank_1024x64.srcs/sources_1/ip/boot_code.coe
set_property -dict [list CONFIG.coefficient_file {../boot_code.coe}] [get_ips xilinx_rom_bank_1024x64]
generate_target all [get_files ./xilinx_rom_bank_1024x64.srcs/sources_1/ip/xilinx_rom_bank_1024x64/xilinx_rom_bank_1024x64.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./xilinx_rom_bank_1024x64.srcs/sources_1/ip/xilinx_rom_bank_1024x64/xilinx_rom_bank_1024x64.xci]
launch_run -jobs 8 xilinx_rom_bank_1024x64_synth_1
wait_on_run xilinx_rom_bank_1024x64_synth_1

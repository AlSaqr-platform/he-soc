set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)



create_project xilinx_qspi . -part $partNumber
create_ip -name axi_quad_spi -vendor xilinx.com -library ip -version 3.2 -module_name xilinx_qspi
set_property -dict [list CONFIG.C_SPI_MEMORY {2} CONFIG.C_USE_STARTUP {1} CONFIG.C_USE_STARTUP_INT {1} CONFIG.C_SPI_MODE {2} CONFIG.C_SCK_RATIO {2}] [get_ips xilinx_qspi]
generate_target {instantiation_template} [get_files ./xilinx_qspi.srcs/sources_1/ip/xilinx_qspi/xilinx_qspi.xci]
generate_target all [get_files ./xilinx_qspi/xilinx_qspi.srcs/sources_1/ip/xilinx_qspi/xilinx_qspi.xci]
catch { config_ip_cache -export [get_ips -all xilinx_qspi] }
export_ip_user_files -of_objects [get_files ./xilinx_qspi/xilinx_qspi.srcs/sources_1/ip/xilinx_qspi/xilinx_qspi.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ./xilinx_qspi.srcs/sources_1/ip/xilinx_qspi/xilinx_qspi.xci]
launch_runs -jobs 64 xilinx_qspi_synth_1
wait_on_run xilinx_qspi_synth_1

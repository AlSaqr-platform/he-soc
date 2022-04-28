set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

create_project axi_dma_0 . -part $partNumber
create_ip -name axi_dma -vendor xilinx.com -library ip -version 7.1 -module_name axi_dma_0
set_property -dict [list \
  CONFIG.c_addr_width {64} \
  CONFIG.c_include_mm2s_dre {1} \
  CONFIG.c_include_s2mm_dre {1} \
  CONFIG.c_sg_length_width {16} \
  CONFIG.c_sg_use_stsapp_length {1} \
] [get_ips axi_dma_0]
generate_target {instantiation_template} [get_files ./axi_dma_0.srcs/sources_1/ip/axi_dma_0/axi_dma_0.xci]
generate_target all [get_files  ./axi_dma_0.srcs/sources_1/ip/axi_dma_0/axi_dma_0.xci]
catch { config_ip_cache -export [get_ips -all axi_dma_0] }
export_ip_user_files -of_objects [get_files ./axi_dma_0.srcs/sources_1/ip/axi_dma_0/axi_dma_0.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ./axi_dma_0.srcs/sources_1/ip/axi_dma_0/axi_dma_0.xci]
launch_runs axi_dma_0_synth_1 -jobs 64
wait_on_run axi_dma_0_synth_1

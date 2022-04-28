set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

create_project axi_ethernet . -part $partNumber
create_ip -name axi_ethernet -vendor xilinx.com -library ip -version 7.2 -module_name axi_ethernet
set_property -dict [list \
  CONFIG.DIFFCLK_BOARD_INTERFACE {sgmii_phyclk} \
  CONFIG.ENABLE_LVDS {true} \
  CONFIG.ETHERNET_BOARD_INTERFACE {sgmii_lvds} \
  CONFIG.InstantiateBitslice0 {true} \
  CONFIG.MDIO_BOARD_INTERFACE {mdio_mdc} \
  CONFIG.PHYADDR {0} \
  CONFIG.PHYRST_BOARD_INTERFACE {Custom} \
  CONFIG.PHYRST_BOARD_INTERFACE_DUMMY_PORT {dummy_port_in} \
  CONFIG.PHY_TYPE {SGMII} \
  CONFIG.RXCSUM {Full} \
  CONFIG.TXCSUM {Full} \
  CONFIG.lvdsclkrate {625} \
  CONFIG.rxlane0_placement {DIFF_PAIR_2} \
  CONFIG.rxnibblebitslice0used {false} \
  CONFIG.txlane0_placement {DIFF_PAIR_1} \
] [get_ips axi_ethernet]
generate_target {instantiation_template} [get_files ./axi_ethernet.srcs/sources_1/ip/axi_ethernet/axi_ethernet.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  ./axi_ethernet.srcs/sources_1/ip/axi_ethernet/axi_ethernet.xci]
catch { config_ip_cache -export [get_ips -all axi_ethernet_0] }
catch { config_ip_cache -export [get_ips -all bd_5d9f_0_eth_buf_0] }
catch { config_ip_cache -export [get_ips -all bd_5d9f_0_mac_0] }
catch { config_ip_cache -export [get_ips -all bd_5d9f_0_pcs_pma_0] }
catch { config_ip_cache -export [get_ips -all bd_5d9f_0_c_shift_ram_0_0] }
catch { config_ip_cache -export [get_ips -all bd_5d9f_0_c_counter_binary_0_0] }
catch { config_ip_cache -export [get_ips -all bd_5d9f_0_util_vector_logic_0_0] }
export_ip_user_files -of_objects [get_files ./axi_ethernet.srcs/sources_1/ip/axi_ethernet/axi_ethernet.xci] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ./axi_ethernet.srcs/sources_1/ip/axi_ethernet/axi_ethernet.xci]
launch_runs axi_ethernet_synth_1 -jobs 64
wait_on_run axi_ethernet_synth_1

# REGISTER FILE MULTICYCLE PATHS
set_ideal_network [ get_ports jtag_TCK            ]
set_ideal_network [ get_ports jtag_TRSTn          ]
set_ideal_network [ get_ports rst_ni              ]
set_ideal_network [ get_ports rtc_i               ]
set_ideal_network [ get_ports bypass_clk_i        ]
set_ideal_network [ get_ports i_host_domain/jtag_TCK    ]
set_ideal_network [ get_ports i_host_domain/jtag_TRSTn  ]
set_ideal_network [ get_ports i_host_domain/rst_ni      ]
set_ideal_network [ get_ports i_host_domain/rtc_i       ]
set_ideal_network [ get_ports i_host_domain/bypass_clk_i]
#
set_dont_touch_network [ get_ports jtag_TCK            ]
set_dont_touch_network [ get_ports jtag_TRSTn          ]
set_dont_touch_network [ get_ports rst_ni              ]
set_dont_touch_network [ get_ports rtc_i               ]
set_dont_touch_network [ get_ports bypass_clk_i        ]
set_dont_touch_network [ get_ports i_host_domain/jtag_TCK    ]
set_dont_touch_network [ get_ports i_host_domain/jtag_TRSTn  ]
set_dont_touch_network [ get_ports i_host_domain/rst_ni      ]
set_dont_touch_network [ get_ports i_host_domain/rtc_i       ]
set_dont_touch_network [ get_ports i_host_domain/bypass_clk_i]

## CLOCK DOMAIN CROSSING
# those constraints gets automatically applied on all the rtl modules that require no ungrouping and that have asynch paths (e.g. in between CDCs fifos)
# attributes need to be specified directly in the RTL and "hdlin_sv_enable_rtl_attributes" must be set to true with the following 
# command <set_app_var hdlin_sv_enable_rtl_attributes true>
set_ungroup [get_designs -filter no_ungroup] false
set_ungroup [get_cells -hierarchical -filter no_ungroup] false

set_boundary_optimization [get_designs -filter no_boundary_optimization] false
set_boundary_optimization [get_cells -hierarchical -filter no_boundary_optimization] false

set_max_delay 1000 -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]
set_false_path -hold -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]

##################
## MACROS       ##
##################
set_max_delay 200 -from [get_pins i_host_domain/i_cva_subsystem/i_ariane_wrap/data_master_*_o* ] -to [get_pins i_host_domain/i_cva_subsystem/cva6_to_xbar/i_axi_cdc_dst/async_data_slave_*_i]
set_max_delay 200 -from [get_pins i_host_domain/i_cva_subsystem/cva6_to_xbar/i_axi_cdc_dst/async_data_slave_*_o] -to [get_pins i_host_domain/i_cva_subsystem/i_ariane_wrap/data_master_*_i*  ]

set_max_delay 200 -from [get_pins cluster_i/async_data_master_*_o ] -to [get_pins cluster_to_soc_dst_cdc_fifo_i/i_axi_cdc_dst/async_data_slave_*_i]
set_max_delay 200 -from [get_pins cluster_to_soc_dst_cdc_fifo_i/i_axi_cdc_dst/async_data_slave_*_i] -to [get_pins cluster_i/async_data_master_*_i ]

set_max_delay 200 -from [get_pins cluster_i/async_data_slave_*_o ] -to [get_pins soc_to_cluster_src_cdc_fifo_i/i_axi_cdc_src/async_data_master_*_i]
set_max_delay 200 -from [get_pins soc_to_cluster_src_cdc_fifo_i/i_axi_cdc_src/async_data_master_*_o] -to [get_pins cluster_i/async_data_slave_*_i ]

set_max_delay 200 -from [get_pins cluster_i/async_cfg_master_*_o ] -to [get_pins cfg_dst_cdc_fifo_i/i_axi_cdc_dst/async_data_slave_*_i]
set_max_delay 200 -from [get_pins cfg_dst_cdc_fifo_i/i_axi_cdc_dst/async_data_slave_*_i] -to [get_pins cluster_i/async_cfg_master_*_i ]

set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_data_slave*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_axi_cdc_src/async_data_master_*_i ]
set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_axi_cdc_src/async_data_master_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_data_slave*_i ] 

set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_reg_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_reg_cdc_slave_intf/async_*_i ]
set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_reg_cdc_slave_intf/async_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_reg_*_i ] 

set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_udma_reg_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/udma_channel_bind[*].i_reg_cdc_slave_intf/async_*_i ]
set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/udma_channel_bind[*].i_reg_cdc_slave_intf/async_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_udma_reg_*_i ] 

wset_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_rx_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/udma_rx_src_fifo/async_*_i ]
set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/udma_rx_src_fifo/async_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_rx_*_i ] 

set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_tx_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/udma_tx_src_fifo/async_*_i ]
set_max_delay 200 -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/udma_tx_src_fifo/async_*_o ] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/async_tx_*_i ] 

##################
### FALSE PATH ###
##################

# FALSE PATH ON CLOCK DOMAINS CROSSING
set_clock_groups -asynchronous -name GRP_REF_CLK         -group REF_CLK
set_clock_groups -asynchronous -name GRP_JTAG_CLK        -group JTAG_CLK
set_clock_groups -asynchronous -name GRP_FLL_CLUSTER_CLK -group FLL_CLUSTER_CLK
set_clock_groups -asynchronous -name GRP_FLL_SOC_CLK     -group FLL_SOC_CLK
set_clock_groups -asynchronous -name GRP_FLL_PER_CLK     -group FLL_PER_CLK
set_clock_groups -asynchronous -name GRP_CVA6_CLK        -group FLL_CVA6_CLK


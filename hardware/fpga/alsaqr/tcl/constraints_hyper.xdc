# Hyper bus
set period_hyperbus 100

# Create RWDS clock (10MHz)
create_clock -period [expr $period_hyperbus] -name rwds0_clk [get_ports FMC_hyper0_rwds]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/pad_gen[0].padinst_hyper_rwds0/iobuf_i/O] 
create_clock -period [expr $period_hyperbus] -name rwds1_clk [get_ports FMC_hyper1_rwds]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/pad_gen[1].padinst_hyper_rwds0/iobuf_i/O] 


## Create the PHY clock
create_generated_clock -name clk_phy -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 2 [get_pins i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk0_o]
create_generated_clock -name clk_phy_90 -source [get_pins  alsaqr_clk_manager/clk_out1] -edges {2 4 6} [get_pins i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk90_o]

## Inform tool that system and PHY-derived clocks are asynchronous, but may have timed arcs between them
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  alsaqr_clk_manager/clk_out1]] -group [get_clocks -of_objects [get_pins i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk90_o]] -group [get_clocks -of_objects [get_pins i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk0_o]]
set_false_path -from [get_clocks clk_phy_90] -to [get_clocks clk_phy]
set_false_path -from [get_clocks clk_phy_90] -to [get_clocks rwds0_clk]

set clk_rx_shift [expr $period_hyperbus/10]
set rwds_input_delay [expr $period_hyperbus/4]
create_generated_clock -name clk_rwds_delayed0 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports FMC_hyper0_rwds] \
	[get_ports i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o]
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed0

create_generated_clock -name clk_rwds_sample0 -invert  -divide_by 1  -source [get_ports i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample0

create_generated_clock -name clk_rwds_delayed1 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports FMC_hyper1_rwds] \
	[get_ports i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o] 
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed1

create_generated_clock -name clk_rwds_sample1 -invert  -divide_by 1  -source [get_ports i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample1

##############################
### I/O constraints        ###
##############################

set output_ports {{FMC_hyper*_dq*} FMC_hyper*_rwds}
set_output_delay [expr $period_hyperbus/2 ]          -clock clk_phy_90 [get_ports $output_ports] -max
set_output_delay [expr $period_hyperbus/-2] -clock clk_phy_90 [get_ports $output_ports] -min -add_delay
set_output_delay [expr $period_hyperbus/2 ]          -clock clk_phy_90 [get_ports $output_ports] -max -clock_fall -add_delay
set_output_delay [expr $period_hyperbus/-2] -clock clk_phy_90 [get_ports $output_ports] -min -clock_fall -add_delay

set input_ports {{FMC_hyper*_dq*} FMC_hyper_rwds*}
set_input_delay -max [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports]
set_input_delay -min [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports] -add_delay
set_input_delay -max [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports] -add_delay -clock_fall
set_input_delay -min [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports] -add_delay -clock_fall

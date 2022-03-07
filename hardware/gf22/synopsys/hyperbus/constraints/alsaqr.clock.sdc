########################################
### GENERATED CLOCK FROM CLOCK MUXES ###
########################################
set_ideal_network clk_sys_i
set_ideal_network clk_phy_i
set_ideal_network rst_sys_ni
set_ideal_network rst_phy_ni

########################################
### SET CLOCKS                       ###
########################################

if {![info exists tck_sys]} {
    set tck_sys 3000
}

if {![info exists param_dw]} {
    set param_dw 64
}

set tck_phy 3000
set num_cores 12

set max_delay_tick 1000

set delay_in_sys 0.2
set delay_out_sys 0.2

set jitter_sys 0.04
set jitter_phy 0.04
set jitter_rwds_in 0.04

set clk_rwds_ping 9470

set io_skew 50

### hyperbus goes up to 166MHz
set period_hyperbus 6000

# Set the critical range - not only consider longest path
set_critical_range 800 ${DESIGN_NAME}

# Assume we do not operate in test mode
set_case_analysis 0 [get_ports test_mode_i]

# Create the system clock
create_clock -name clk_sys -period ${tck_sys} [get_ports clk_sys_i]
set_clock_uncertainty [expr {${jitter_sys}*${tck_sys}}] clk_sys

# Create the PHY clock (then divided)
create_clock -name clk_phy -period ${tck_phy} [get_ports clk_phy_i]
set_clock_uncertainty [expr {${jitter_phy}*${tck_phy}}] clk_phy

create_generated_clock  [get_pins i_hyperbus_macro/clock_generator.ddr_clk/clk0_o] \
                        -name clk_phy_0 -source [get_ports clk_phy_i] -divide_by 2                        
set_clock_uncertainty [expr {${jitter_phy}*${tck_phy}}] clk_phy_0

create_generated_clock  [get_pins i_hyperbus_macro/clock_generator.ddr_clk/clk90_o] \
                        -name clk_phy_90 -source [get_ports clk_phy_i] -edges {2 4 6}
set_clock_uncertainty [expr {${jitter_phy}*${tck_phy}}] clk_phy_90


create_clock  [get_ports pad_hyper_rwds[0]] -name rwds0_clk -period [expr {${tck_phy}}]
set_clock_uncertainty [expr {${period_hyperbus}/2}] rwds0_clk

set clk_rx_shift 1000
set rwds_input_delay 2500
create_generated_clock -name clk_rwds_delayed0 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports pad_hyper_rwds[0]] \
	[get_ports i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed0

create_generated_clock -name clk_rwds_sample0 -invert  -divide_by 1  -source [get_ports i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample0

create_clock  [get_ports pad_hyper_rwds[1]] -name rwds1_clk -period [expr {${tck_phy}}]
set_clock_uncertainty [expr {${period_hyperbus}/2}] rwds1_clk

create_generated_clock -name clk_rwds_delayed1 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports pad_hyper_rwds[1]] \
	[get_ports i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o] 
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed1

create_generated_clock -name clk_rwds_sample1 -invert  -divide_by 1  -source [get_ports i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample1

set_clock_groups -asynchronous -group {clk_sys clk_phy_0 clk_phy_90}

##############################
### DELAY LINES            ###
##############################
set_case_analysis 1 i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[*]/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[3]
set_case_analysis 0 i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[*]/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[2]
set_case_analysis 0 i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[*]/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[1]
set_case_analysis 0 i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[*]/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[0]

##############################
### I/O constraints        ###
##############################
set_fanout_load 8 [all_outputs]

set output_ports {{pad_hyper_dq*} pad_hyper_rwds*}
set_output_delay 500           -clock clk_phy_90 [get_ports $output_ports] -max
set_output_delay [expr -1*500] -clock clk_phy_90 [get_ports $output_ports] -min -add_delay
set_output_delay 500           -clock clk_phy_90 [get_ports $output_ports] -max -clock_fall -add_delay
set_output_delay [expr -1*500] -clock clk_phy_90 [get_ports $output_ports] -min -clock_fall -add_delay

set input_ports {{pad_hyper_dq*} pad_hyper_rwds*}
set_input_delay -max [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports]
set_input_delay -min [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports] -add_delay
set_input_delay -max [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports] -add_delay -clock_fall
set_input_delay -min [expr $period_hyperbus/2] -clock clk_phy [get_ports $input_ports] -add_delay -clock_fall

set_max_delay 1000 -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]
set_false_path -hold -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]
set_false_path -setup -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]

set_false_path -from [all_fanin -to [get_nets i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks clk_phy_90]
set_false_path -from [all_fanin -to [get_nets i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks clk_phy_90]
set_false_path -from [all_fanin -to [get_nets i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks clk_phy_90]
set_false_path -from [all_fanin -to [get_nets i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks clk_phy_90]

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_hyperbus_macro/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/cfg_i*]
set_max_delay [expr $period_hyperbus] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}


########################################
### IO PINS                          ###
########################################
set_driving_cell -lib_cell SC8T_BUFX6_CSC20L  -pin Z -from_pin A [ all_inputs  ]
set_load                                                     0.1 [ all_outputs ]

set_false_path -from [all_inputs]
set_false_path -to   [all_outputs]

set output_ports {async_*_o*}
set_output_delay 500 -clock clk_sys  [get_ports $output_ports]

set input_ports {async_*_i*}
set_input_delay 500 -clock clk_sys  [get_ports $input_ports] 
set_false_path -hold -through [get_ports $input_ports] -through [get_ports $input_ports]

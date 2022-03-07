########################################
### GENERATED CLOCK FROM CLOCK MUXES ###
########################################
# SOC CLK
create_generated_clock         [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk0_o] \
     -name HYPER_CLK_PHY -source [get_pins  i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[2]] -divide_by 2

create_generated_clock         [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk90_o] \
     -name HYPER_CLK_PHY_90 -source [get_pins  i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[2]]  -edges {2 4 6}

#############################
### PAD CLOCKS DEFINITION ###
#############################
# RWDS:       200 MHz
set RWDS_C_Period                5000
set RWDS_C_Latency_Max           1000
set RWDS_C_Latency_Min           500
set RWDS_C_Uncertainty           100

# RWDS CLK
create_clock -period $RWDS_C_Period -name RWDS_CLK_0 [get_ports pad_hyper_rwds[0]]
set_clock_uncertainty   $RWDS_C_Uncertainty          [get_clocks RWDS_CLK_0]

set clk_rx_shift 1000
set rwds_input_delay 2500
create_generated_clock -name clk_rwds_delayed0 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports pad_hyper_rwds[0]] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed0

create_generated_clock -name clk_rwds_sample0 -invert  -divide_by 1  -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample0

create_clock -period $RWDS_C_Period -name RWDS_CLK_1  [get_ports pad_hyper_rwds[1]]
set_ideal_network                                     [get_ports pad_hyper_rwds[1]]

create_generated_clock -name clk_rwds_delayed1 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports pad_hyper_rwds[1]] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed1

create_generated_clock -name clk_rwds_sample1 -invert  -divide_by 1  -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample1

create_generated_clock -name HYPER0_CK_O -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk90_o] \
	-divide_by 1 [get_ports pad_hyper_ck[0]]
  
create_generated_clock -name HYPER1_CK_O -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/clock_generator.ddr_clk/clk90_o] \
	-divide_by 1 [get_ports pad_hyper_ck[1]]
  
set_clock_groups -asynchronous -group {FLL_SOC_CLK HYPER_CLK_PHY HYPER_CLK_PHY_90}

##############################
### DELAY LINES            ###
##############################
set_case_analysis 1 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[3]
set_case_analysis 0 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[2]
set_case_analysis 0 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[1]
set_case_analysis 0 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[0]

set_case_analysis 1 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[3]
set_case_analysis 0 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[2]
set_case_analysis 0 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[1]
set_case_analysis 0 i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/i_delay_rx_rwds_90/i_delay/delay_i[0]

##############################
### I/O constraints        ###
##############################

set period_hyperbus 6000
set output_ports {{pad_hyper_dq*} pad_hyper_rwds*}
set_output_delay 500           -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -max
set_output_delay [expr -1*500] -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -min -add_delay
set_output_delay 500           -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -max -clock_fall -add_delay
set_output_delay [expr -1*500] -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -min -clock_fall -add_delay

set input_ports {{pad_hyper_dq*} pad_hyper_rwds*}
set_input_delay -max 2500 -clock HYPER_CLK_PHY [get_ports $input_ports]
set_input_delay -min 2500 -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay
set_input_delay -max 2500 -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay -clock_fall
set_input_delay -min 2500 -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay -clock_fall

set_false_path -from [all_fanin -to [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[1].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks HYPER_CLK_PHY_90]

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/cfg_i*]
set_max_delay [expr $period_hyperbus] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_hyperbus_macro/i_phy/phy_wrap.phy_unroll[0].i_phy/cfg_i*]
set_max_delay [expr $period_hyperbus] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}

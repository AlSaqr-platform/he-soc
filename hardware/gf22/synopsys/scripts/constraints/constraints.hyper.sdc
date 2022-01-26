########################################
### GENERATED CLOCK FROM CLOCK MUXES ###
########################################
# SOC CLK
create_generated_clock         [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/genblk1.ddr_clk/clk0_o] \
     -name HYPER_CLK_PHY -source [get_pins  i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[2]] -divide_by 2

create_generated_clock         [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/genblk1.ddr_clk/clk90_o] \
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
create_clock -period $RWDS_C_Period -name RWDS_CLK_0 [get_ports pad_hyper0_rwds]
set_ideal_network                                    [get_ports pad_hyper0_rwds]
set_dont_touch_network                               [get_ports pad_hyper0_rwds]
set_clock_uncertainty   $RWDS_C_Uncertainty          [get_clocks RWDS_CLK_0]
set_clock_transition    100                          [get_clocks RWDS_CLK_0]
set_clock_latency -max  $RWDS_C_Latency_Max          [get_clocks RWDS_CLK_0]
set_clock_latency -min  $RWDS_C_Latency_Min          [get_clocks RWDS_CLK_0]


set clk_rx_shift 1000
set rwds_input_delay 2500
create_generated_clock -name clk_rwds_delayed0 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports pad_hyper0_rwds] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed0

create_generated_clock -name clk_rwds_sample0 -invert  -divide_by 1  -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample0


create_clock -period $RWDS_C_Period -name RWDS_CLK_1 [get_ports pad_hyper1_rwds]
set_ideal_network                                    [get_ports pad_hyper1_rwds]
set_dont_touch_network                               [get_ports pad_hyper1_rwds]
set_clock_uncertainty   $RWDS_C_Uncertainty          [get_clocks RWDS_CLK_1]
set_clock_transition    100                          [get_clocks RWDS_CLK_1]
set_clock_latency -max  $RWDS_C_Latency_Max          [get_clocks RWDS_CLK_1]
set_clock_latency -min  $RWDS_C_Latency_Min          [get_clocks RWDS_CLK_1]

set clk_rx_shift 1000
set rwds_input_delay 2500
create_generated_clock -name clk_rwds_delayed1 -edges {1 2 3} -edge_shift "$clk_rx_shift $clk_rx_shift $clk_rx_shift" \
  -source [get_ports pad_hyper0_rwds] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_delayed1

create_generated_clock -name clk_rwds_sample1 -invert  -divide_by 1  -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_delay_rx_rwds_90/out_o] \
	[get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rwds_clk_inverter/clk_o]
#setting the latency smaller than the input delay  
set_clock_latency [expr ${rwds_input_delay}] clk_rwds_sample1

create_generated_clock -name HYPER0_CK_O -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/genblk1.ddr_clk/clk90_o] \
	-divide_by 1 [get_ports pad_hyper0_ck]
  
create_generated_clock -name HYPER1_CK_O -source [get_ports i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/genblk1.ddr_clk/clk90_o] \
	-divide_by 1 [get_ports pad_hyper1_ck]
  
set_clock_groups -asynchronous -group {FLL_SOC_CLK HYPER_CLK_PHY HYPER_CLK_PHY_90}



#### HYPER 0 ######
### hyperbus goes up to 166MHz
set period_hyperbus 6000
set output_ports {{pad_hyper0_dq*} pad_hyper0_rwds}

set_output_delay 500           -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -max
set_output_delay [expr -1*500] -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -min -add_delay
set_output_delay 500           -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -max  -clock_fall -add_delay
set_output_delay [expr -1*500] -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -min -clock_fall -add_delay

set input_ports {{pad_hyper0_dq*} pad_hyper0_rwds}
set_input_delay -max [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports]
set_input_delay -min [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay
set_input_delay -max [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay -clock_fall
set_input_delay -min [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay -clock_fall

set_max_delay [expr $period_hyperbus] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/hyper_dq_oe_o] -to [get_ports pad_hyper0_dq*]
set_max_delay [expr $period_hyperbus] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/hyper_rwds_oe_o] -to [get_ports pad_hyper0_rwds]

set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks HYPER_CLK_PHY_90]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_rptr_o*}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i*}]] [expr $period_hyperbus]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_wptr_o*}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_wptr_i*}]] [expr $period_hyperbus]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_data_o*}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_data_i*}]] [expr $period_hyperbus]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/rx_rwds_clk_ena}]] \
-to [all_fanout -from [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/i_trx/rx_rwds_fifo_valid]] [expr $period_hyperbus]

set async_pins [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_cdc_fifo_tx/i_src/async*]
#set_ungroup [get_designs i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/cdc_fifo_gray*] false
#set_boundary_optimization [get_designs i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/cdc_fifo_gray*] false
set_max_delay [expr $period_hyperbus] -through ${async_pins} -through ${async_pins}
set_false_path -hold -through ${async_pins} -through ${async_pins}

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[0].i_phy/cfg_i*]
set_max_delay [expr $period_hyperbus] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}

#### HYPER 1 ######
### hyperbus goes up to 166MHz
set period_hyperbus 6000
set output_ports {{pad_hyper1_dq*} pad_hyper1_rwds}

set_output_delay 500           -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -max
set_output_delay [expr -1*500] -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -min -add_delay
set_output_delay 500           -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -max  -clock_fall -add_delay
set_output_delay [expr -1*500] -clock HYPER_CLK_PHY_90 [get_ports $output_ports] -min -clock_fall -add_delay

set input_ports {{pad_hyper1_dq*} pad_hyper1_rwds}
set_input_delay -max [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports]
set_input_delay -min [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay
set_input_delay -max [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay -clock_fall
set_input_delay -min [expr $period_hyperbus/3] -clock HYPER_CLK_PHY [get_ports $input_ports] -add_delay -clock_fall

set_max_delay [expr $period_hyperbus] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/hyper_dq_oe_o] -to [get_ports pad_hyper1_dq*]
set_max_delay [expr $period_hyperbus] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/hyper_rwds_oe_o] -to [get_ports pad_hyper1_rwds]

set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks HYPER_CLK_PHY_90]



set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_rptr_o*}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i*}]] [expr $period_hyperbus]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_wptr_o*}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_wptr_i*}]] [expr $period_hyperbus]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_data_o*}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_data_i*}]] [expr $period_hyperbus]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/rx_rwds_clk_ena}]] \
-to [all_fanout -from [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/i_trx/rx_rwds_fifo_valid]] [expr $period_hyperbus]

set async_pins [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_cdc_fifo_tx/i_src/async*]
set_max_delay [expr $period_hyperbus] -through ${async_pins} -through ${async_pins}
set_false_path -hold -through ${async_pins} -through ${async_pins}

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/genblk1.genblk1[1].i_phy/cfg_i*]
set_max_delay [expr $period_hyperbus] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}
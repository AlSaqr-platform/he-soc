########################################
### GENERATED CLOCK FROM CLOCK MUXES ###
########################################
# SOC CLK
create_generated_clock         [get_pins i_host_domain/i_clk_gen_hyper/clk0_o] \
     -name AXI_HYPER_CLK_PHY -source [get_pins  i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_fll_soc/FLLCLK] -divide_by 2

create_generated_clock         [get_pins i_host_domain/i_clk_gen_hyper/clk90_o] \
     -name AXI_HYPER_CLK_PHY_90 -source [get_pins  i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_fll_soc/FLLCLK]  -edges {2 4 6}

create_generated_clock -name HYPER_CK_O -source [get_ports i_host_domain/i_clk_gen_hyper/clk90_o] \
	-divide_by 1 [get_ports pad_axi_hyper_ck] 

set_clock_groups -asynchronous -group {AXI_HYPER_CLH_PHY HYPER_CK_O}
set_clock_groups -asynchronous -group {SOC_CLK RWDS_CLK}

#### HYPER 0 ###### 
set output_ports {{pad_axi_hyper_dq*} pad_axy_hyper_rwds0}

set_output_delay 1 -clock HYPER_CK_O [get_ports $output_ports] -max
set_output_delay [expr -1*1] -clock HYPER_CK_O [get_ports $output_ports] -min -add_delay
set_output_delay 1 -clock HYPER_CK_O [get_ports $output_ports] -max  -clock_fall -add_delay
set_output_delay [expr -1*1] -clock HYPER_CK_O [get_ports $output_ports] -min -clock_fall -add_delay

set_max_delay [expr $period_phy/2] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/phy_i/hyper_dq_oe_o] -to [get_ports pad_axi_hyper_dq*]
set_max_delay [expr $period_phy/2] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/phy_i/hyper_rwds_oe_o] -to [get_ports pad_axy_hyper_rwds0]

set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks AXI_HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks AXI_HYPER_CLK_PHY_90]


set_input_delay -max [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_axi_hyper_dq*]
set_input_delay -min [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_axi_hyper_dq*] -add_delay
set_input_delay -max [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_axi_hyper_dq*] -add_delay -clock_fall
set_input_delay -min [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_axi_hyper_dq*] -add_delay -clock_fall

set async_pins [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_cdc_fifo_tx/async*]
set_ungroup [get_designs i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/cdc_fifo_gray*] false
set_boundary_optimization [get_designs i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/cdc_fifo_gray*] false
set_max_delay [expr HYPER_CK_O] -through ${async_pins} -through ${async_pins}
set_false_path -hold -through ${async_pins} -through ${async_pins}

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/cfg_i*]
set_max_delay [expr HYPER_CK_O] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}



set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_rptr_o[*]}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i[*]}]] [expr AXI_HYPER_CLK_PHY]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i[*]/async_wptr_o[*]}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_wptr_i[*]}]] [expr AXI_HYPER_CLK_PHY]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i[*]/async_data_o[*]}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_data_i[*]}]] [expr AXI_HYPER_CLK_PHY]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/rx_rwds_clk_ena}]] \
-to [all_fanout -from [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/rx_rwds_fifo_valid]] [expr $period_phy/2]

set step_delay 50
set start_delay 500
for {set i 0} {$i < 32} {incr i +2} {
     set_max_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk0_i] [expr $start_delay + $step_delay*($i+1)]
     set_min_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk0_i] [expr $start_delay + $step_delay*($i)]
     set_max_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk1_i] [expr $start_delay + $step_delay*($i+2)]
     set_min_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[0].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk1_i] [expr $start_delay + $step_delay*($i+1)]
}

### HYPER 1 #####
set output_ports {{pad_hyper_dq*} pad_hyper_rwds0}

set_output_delay 1 -clock HYPER_CK_O [get_ports $output_ports] -max
set_output_delay [expr -1*1] -clock HYPER_CK_O [get_ports $output_ports] -min -add_delay
set_output_delay 1 -clock HYPER_CK_O [get_ports $output_ports] -max  -clock_fall -add_delay
set_output_delay [expr -1*1] -clock HYPER_CK_O [get_ports $output_ports] -min -clock_fall -add_delay

set_max_delay [expr $period_phy/2] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/phy_i/hyper_dq_oe_o] -to [get_ports pad_hyper_dq*]
set_max_delay [expr $period_phy/2] -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/phy_i/hyper_rwds_oe_o] -to [get_ports pad_hyper_rwds0]

set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q0]] -fall_to [get_clocks AXI_HYPER_CLK_PHY_90]
set_false_path -from [all_fanin -to [get_nets i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/gen_ddr_tx_data[*].i_ddr_tx_data/q1]] -fall_to [get_clocks AXI_HYPER_CLK_PHY_90]


set_input_delay -max [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_hyper_dq*]
set_input_delay -min [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_hyper_dq*] -add_delay
set_input_delay -max [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_hyper_dq*] -add_delay -clock_fall
set_input_delay -min [expr AXI_HYPER_CLK_PHY] -clock clk_phy [get_ports pad_hyper_dq*] -add_delay -clock_fall

set async_pins [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_cdc_fifo_tx/async*]
set_ungroup [get_designs i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/cdc_fifo_gray*] false
set_boundary_optimization [get_designs i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/cdc_fifo_gray*] false
set_max_delay [expr HYPER_CK_O] -through ${async_pins} -through ${async_pins}
set_false_path -hold -through ${async_pins} -through ${async_pins}

# Constrain config register false paths to PHY
set cfg_from  [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_cfg_regs/cfg_o*]
set cfg_to    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/cfg_i*]
set_max_delay [expr HYPER_CK_O] -through ${cfg_from} -through ${cfg_to}
set_false_path -hold -through ${cfg_from} -through ${cfg_to}



set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_rptr_o[*]}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i[*]}]] [expr AXI_HYPER_CLK_PHY]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i[*]/async_wptr_o[*]}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_wptr_i[*]}]] [expr AXI_HYPER_CLK_PHY]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_src/async_rptr_i[*]/async_data_o[*]}]] \
-to [all_fanout -from [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_rx_rwds_cdc_fifo/i_dst/async_data_i[*]}]] [expr AXI_HYPER_CLK_PHY]

set_max_delay -from [all_fanin -to [get_nets {i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/rx_rwds_clk_ena}]] \
-to [all_fanout -from [get_nets  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/rx_rwds_fifo_valid]] [expr $period_phy/2]

set step_delay 50
set start_delay 500
for {set i 0} {$i < 32} {incr i +2} {
     set_max_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk0_i] [expr $start_delay + $step_delay*($i+1)]
     set_min_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk0_i] [expr $start_delay + $step_delay*($i)]
     set_max_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk1_i] [expr $start_delay + $step_delay*($i+2)]
     set_min_delay -from [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/clk_i] -to [get_pins i_host_domain/i_apb_subsystem/i_udma_subsystem/i_hyper_gen[1].i_hyper/i_phy/i_trx/i_delay_rx_rwds_90/i_delay/genblk2_4__genblk1_[expr $i]__genblk1_i_clk_mux/clk1_i] [expr $start_delay + $step_delay*($i+1)]
}


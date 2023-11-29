#######################
# QSPI MASTER 0       #
#######################

# define the clocks at the peripheral output
# SPI MASTER  50MHz

set_dont_touch         [get_cells i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/clk_mux_i]
set_case_analysis 0    [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/r_clockout_mux_reg/Q]

create_generated_clock [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q] -name SPIM_CLK_0 -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 4
set_clock_groups -asynchronous -group [get_clocks SPIM_CLK_0]

#################
## SDIO        ##
#################

create_generated_clock [get_pins {i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_sdio_gen[0].i_sdio/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q}] -name SDIO_CLK_0 -source  [get_pins alsaqr_clk_manager/clk_out1] -divide_by 4
set_clock_groups -asynchronous -group [get_clocks SDIO_CLK_0]


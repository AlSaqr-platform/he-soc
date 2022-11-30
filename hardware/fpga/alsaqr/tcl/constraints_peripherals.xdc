#######################
# QSPI MASTER 0       #
#######################

# define the clocks at the peripheral output
# SPI MASTER  50MHz
set_case_analysis 0    [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/r_clockout_mux_reg/Q]
create_generated_clock [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q] -name SPIM_CLK_0 -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 4

#################
## SDIO        ##
#################

create_generated_clock [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_sdio_gen[0].i_sdio/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q] \
                       -name SDIO_CLK_0 \
                       -source [get_pins  alsaqr_clk_manager/clk_out1] \
                       -divide_by 4

set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_00_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_01_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_02_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_03_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_04_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_05_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_06_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_07_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_08_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_09_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_10_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_11_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_12_pad]
set_input_delay -min 4 [get_ports pad_periphs_pad_gpio_b_13_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_00_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_01_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_02_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_03_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_04_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_05_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_06_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_07_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_08_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_09_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_10_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_11_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_12_pad]
set_input_delay -max 8 [get_ports pad_periphs_pad_gpio_b_13_pad]

set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_00_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_01_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_02_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_03_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_04_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_05_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_06_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_07_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_08_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_09_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_10_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_11_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_12_pad]
set_output_delay -min 4 [get_ports pad_periphs_pad_gpio_b_13_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_00_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_01_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_02_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_03_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_04_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_05_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_06_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_07_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_08_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_09_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_10_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_11_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_12_pad]
set_output_delay -max 8 [get_ports pad_periphs_pad_gpio_b_13_pad]


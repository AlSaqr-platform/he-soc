#######################
# QSPI MASTER 0       #
#######################

# define the clocks at the peripheral output
# SPI MASTER  50MHz

set_dont_touch         [get_cells i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/clk_mux_i]
set_case_analysis 0    [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/r_clockout_mux_reg/Q]

create_generated_clock [get_pins  i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[0].i_spim/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q] -name SPIM_CLK_0 -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 1 

#CLK
#set_output_delay -clock SPIM_CLK_0 -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_01_pad ]
#set_output_delay -clock SPIM_CLK_0 -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_01_pad ]

#CS
set_output_delay -clock SPIM_CLK_0 -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_00_pad ]
set_output_delay -clock SPIM_CLK_0 -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_00_pad ]

#MOSI
set_output_delay -clock SPIM_CLK_0 -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_03_pad ]
set_output_delay -clock SPIM_CLK_0 -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_03_pad ]

#MISO
set_input_delay -clock SPIM_CLK_0 -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_02_pad ]
set_input_delay -clock SPIM_CLK_0 -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_02_pad ]

#################
## SDIO        ##
#################

create_generated_clock [get_pins {i_alsaqr/i_host_domain/i_apb_subsystem/i_udma_subsystem/i_sdio_gen[0].i_sdio/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q}] -name SDIO_CLK_0 -source  [get_pins alsaqr_clk_manager/clk_out1] -divide_by 1

# SDIO CLK : OUT
set_output_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_12_pad ]
set_output_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_12_pad ]

# SDIO CMD : IN/OUT
set_output_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_13_pad ]
set_output_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_13_pad ]

set_input_delay  -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_13_pad ]
set_input_delay  -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_13_pad ]

# SDIO D0-D3 : IN/OUT
set_output_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_08_pad ]
set_output_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_08_pad ]

set_input_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_08_pad ]
set_input_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_08_pad ]

set_output_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_09_pad ]
set_output_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_09_pad ]

set_input_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_09_pad ]
set_input_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_09_pad ]

set_output_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_10_pad ]
set_output_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_10_pad ]

set_input_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_10_pad ]
set_input_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_10_pad ]

set_output_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_11_pad ]
set_output_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_11_pad ]

set_input_delay -clock SDIO_CLK_0 -min 10.000 [ get_ports pad_periphs_pad_gpio_b_11_pad ]
set_input_delay -clock SDIO_CLK_0 -max 10.000 [ get_ports pad_periphs_pad_gpio_b_11_pad ]

#################
## I2C 0       ##
#################

create_clock -period 20.000 -name FPGA_CLK [get_pins alsaqr_clk_manager/clk_out1]

#SDA
set_output_delay -clock FPGA_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]
set_output_delay -clock FPGA_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]

set_input_delay -clock FPGA_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]
set_input_delay -clock FPGA_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]

set_max_delay    [ expr 20 * 0.20 ] -from  [ get_ports pad_periphs_pad_gpio_b_05_pad ]

#SCL
set_output_delay -clock FPGA_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_04_pad ]
set_output_delay -clock FPGA_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_04_pad ]

#################
## UART        ##
#################

#TX
set_output_delay -clock FPGA_ALSQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_06_pad ]
set_output_delay -clock FPGA_ALSQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_06_pad ]

#RX
set_input_delay -clock FPGA_ALSQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_07_pad ]
set_input_delay -clock FPGA_ALSQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_07_pad ]

set_max_delay    [ expr 20 * 0.50 ] -from  [ get_ports pad_periphs_pad_gpio_b_07_pad ]

####################################################################################
# Constraints from file : 'xpm_cdc_gray.tcl'
####################################################################################


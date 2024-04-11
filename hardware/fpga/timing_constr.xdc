create_clock -period 4.000 [get_ports c0_sys_clk_p]
set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets u_ibufg_sys_clk/O]

create_clock -period 6.400 [get_pins u_ddr4_0/c0_ddr4_ui_clk]

#alsaqr clock
create_clock -period ${SRC_CLK_PERIOD} -name ALSAQR_CLK  [get_pins  alsaqr_clk_manager/clk_out1]

set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  u_ddr4_0/c0_ddr4_ui_clk]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_ports c0_sys_clk_p]]
set_clock_groups -asynchronous -group [get_clocks ALSAQR_CLK]

#set_false_path -from [get_ports pad_reset]

## Bootselect
## TBD

## JTAG
create_clock -period 100.000 -name tck -waveform {0.000 50.000} [get_ports pad_jtag_tck]
set_input_jitter tck 1.000
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pad_jtag_tck_IBUF_inst/O]

# minimize routing delay
set_input_delay -clock tck -clock_fall 5.000 [get_ports pad_jtag_tdi]
set_input_delay -clock tck -clock_fall 5.000 [get_ports pad_jtag_tms]
set_output_delay -clock tck 5.000 [get_ports pad_jtag_tdo]

set_max_delay -to [get_ports pad_jtag_tdo] 20.000
set_max_delay -from [get_ports pad_jtag_tms] 20.000
set_max_delay -from [get_ports pad_jtag_tdi] 20.000

# reset signal
set_false_path -from [get_ports pad_reset]

# SPI-STARTUPE3 Ultrascale+
# Following are the SPI device parameters
set tco_max 7
set tco_min 1
set tsu 2
set th 3
set tdata_trace_delay_max 0.25
set tdata_trace_delay_min 0.25
set tclk_trace_delay_max 0.2
set tclk_trace_delay_min 0.2
create_generated_clock -name clk_sck -source [get_pins -hierarchical *axi_quad_spi_0/ext_spi_clk] [get_pins -hierarchical */CCLK] -edges {3 5 7}
set_input_delay -clock clk_sck -max [expr $tco_max + $tdata_trace_delay_max + $tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_input_delay -clock clk_sck -min [expr $tco_min + $tdata_trace_delay_min + $tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_multicycle_path 2 -setup -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]]
set_multicycle_path 1 -hold -end -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]]
set_output_delay -clock clk_sck -max [expr $tsu + $tdata_trace_delay_max -$tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_output_delay -clock clk_sck -min [expr $tdata_trace_delay_min -$th -$tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_multicycle_path 2 -setup -start -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to clk_sck
set_multicycle_path 1 -hold -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to clk_sck

set_clock_groups -asynchronous -group [get_clocks clk_sck]
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

#######################
# QSPI MASTER 0       #
#######################

#CLK
set_output_delay -clock SPIM_CLK_0 -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_01_pad ]
set_output_delay -clock SPIM_CLK_0 -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_01_pad ]

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

#SDA
set_output_delay -clock ALSAQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]
set_output_delay -clock ALSAQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]

set_input_delay -clock ALSAQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]
set_input_delay -clock ALSAQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_05_pad ]

set_max_delay    [ expr 20 * 0.20 ] -from  [ get_ports pad_periphs_pad_gpio_b_05_pad ]

#SCL
set_output_delay -clock ALSAQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_04_pad ]
set_output_delay -clock ALSAQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_04_pad ]

#################
## UART        ##
#################

#TX
set_output_delay -clock ALSAQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_06_pad ]
set_output_delay -clock ALSAQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_06_pad ]

#RX
set_input_delay -clock ALSAQR_CLK -min [ expr 20 * 0.10 ] [ get_ports pad_periphs_pad_gpio_b_07_pad ]
set_input_delay -clock ALSAQR_CLK -max [ expr 20 * 0.35 ] [ get_ports pad_periphs_pad_gpio_b_07_pad ]

set_max_delay    [ expr 20 * 0.50 ] -from  [ get_ports pad_periphs_pad_gpio_b_07_pad ]

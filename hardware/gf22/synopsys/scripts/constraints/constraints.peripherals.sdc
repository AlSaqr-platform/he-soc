#########################
## BOUNDARY CONDITIONS ##
#########################

#set PAD_LIB   IN22FDX_GPIO18_10M3S40PI_TT_0P8_1P2_25
set PAD_LIB   IN22FDX_GPIO18_10M3S40PI_SSG_0P72_1P35_M40
set DRIV_CELL IN22FDX_GPIO18_10M3S40PI_IO_H
set DRIV_PIN  PAD
set LOAD_CELL IN22FDX_GPIO18_10M3S40PI_IO_H
set LOAD_PIN  PAD

set_driving_cell  -no_design_rule -library ${PAD_LIB} -lib_cell ${DRIV_CELL} -pin ${DRIV_PIN} [all_inputs]
set_load [load_of ${PAD_LIB}/${LOAD_CELL}/${LOAD_PIN}] [all_inputs]

########
# JTAG #
########

set JTAG_OD_MIN 0.1
set JTAG_OD_MAX 0.5
set JTAG_ID_MIN 0.1
set JTAG_ID_MAX 0.5
#why?

set_false_path   -from [ get_ports jtag_TCK ]
set_false_path   -from [ get_ports jtag_TRSTn ]

set_input_delay  -min -clock JTAG_CLK [ expr $JTAG_C_Period * $JTAG_ID_MIN ]     [ get_ports jtag_TDI  ]
set_input_delay  -max -clock JTAG_CLK [ expr $JTAG_C_Period * $JTAG_ID_MAX ]     [ get_ports jtag_TDI  ]
set_output_delay -min -clock JTAG_CLK [ expr $JTAG_C_Period * $JTAG_OD_MIN/2.0 ] [ get_ports jtag_TDO_data  ] ; # HALF PATH
set_output_delay -max -clock JTAG_CLK [ expr $JTAG_C_Period * $JTAG_OD_MAX/2.0 ] [ get_ports jtag_TDO_data  ] ; # HALF PATH
set_input_delay  -min -clock JTAG_CLK [ expr $JTAG_C_Period * $JTAG_ID_MIN ]     [ get_ports jtag_TMS  ]
set_input_delay  -max -clock JTAG_CLK [ expr $JTAG_C_Period * $JTAG_ID_MAX ]     [ get_ports jtag_TMS  ]


##############
# PAD MUXING #
##############

set_max_delay 4000 -from "[get_pins i_alsaqr_periph_padframe/i_periphs/i_periphs_pads/pads_to_mux*]" -to "[get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*]"
set_max_delay 4000 -from "[get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*]" -to "[get_pins i_alsaqr_periph_padframe/i_periphs/i_periphs_pads/mux_to_pads*]"

#############
# CPI SLAVE #
#############

set CAM_CLOCK_PERIOD 20000
set CAM_ID_MIN 0.1
set CAM_ID_MAX 0.5

# switch the mux
## CAM CLK on PAD6 --> mux_sel[6] set to 46 (CPI CLK)
# connect pad in case analysis
#set pad_idx 6
#set bits [ dec2bin $PAD_MUX_GROUP_MX_GPIOB_SEL_CPI0_PCLK ]
#
#set_case_analysis [string index $bits 0] [ get_pins  kraken_padframe_i/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[0\] ]
#set_case_analysis [string index $bits 1] [ get_pins  kraken_padframe_i/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[1\] ]
#set_case_analysis [string index $bits 2] [ get_pins  kraken_padframe_i/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[2\] ]
#set_case_analysis [string index $bits 3] [ get_pins  kraken_padframe_i/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[3\] ]
#set_case_analysis [string index $bits 4] [ get_pins  kraken_padframe_i/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[4\] ]
#set_case_analysis [string index $bits 5] [ get_pins  kraken_padframe_i/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[5\] ]

# define the clock at the padframe output pclk pin, we do not consider the propagation from any input pad through the mux, which should be < 1ns
create_clock -period $CAM_CLOCK_PERIOD -name CAM_CLK [get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*clk*]
set_ideal_network                        [get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*clk*]
set_dont_touch_network                   [get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*clk*]
set_clock_uncertainty   1000             [get_clocks CAM_CLK]
set_clock_transition    200              [get_clocks CAM_CLK]
set_clock_latency -max  1000             [get_clocks CAM_CLK]
set_clock_latency -min  500              [get_clocks CAM_CLK]

set_input_delay  -min -clock CAM_CLK [ expr $CAM_CLOCK_PERIOD * $CAM_ID_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*hsync* ]
set_input_delay  -max -clock CAM_CLK [ expr $CAM_CLOCK_PERIOD * $CAM_ID_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*hsync* ]

set_input_delay  -min -clock CAM_CLK [ expr $CAM_CLOCK_PERIOD * $CAM_ID_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*vsync* ]
set_input_delay  -max -clock CAM_CLK [ expr $CAM_CLOCK_PERIOD * $CAM_ID_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*vsync* ]

set_input_delay  -min -clock CAM_CLK [ expr $CAM_CLOCK_PERIOD * $CAM_ID_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*data* ]
set_input_delay  -max -clock CAM_CLK [ expr $CAM_CLOCK_PERIOD * $CAM_ID_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*cam0*data* ]

#remove_case_analysis [ get_pins  i_alsaqr_periph_padframe/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[0\] ]
#remove_case_analysis [ get_pins  i_alsaqr_periph_padframe/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[1\] ]
#remove_case_analysis [ get_pins  i_alsaqr_periph_padframe/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[2\] ]
#remove_case_analysis [ get_pins  i_alsaqr_periph_padframe/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[3\] ]
#remove_case_analysis [ get_pins  i_alsaqr_periph_padframe/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[4\] ]
#remove_case_analysis [ get_pins  i_alsaqr_periph_padframe/i_periphs/i_periphs_muxer/i_regfile/reg2hw\[pad_gpiob_mux_sel\]\[${pad_idx}\]\[q\]\[5\] ]

#######################
# QSPI MASTER 0 - 11  #
#######################

set SPIM_CLK_DIV  5
set SPIM_CLOCK_PERIOD [expr $PER_C_Period * $SPIM_CLK_DIV]
set SPIM_OD_MIN 0.10
set SPIM_OD_MAX 0.35
set SPIM_ID_MIN 0.10
set SPIM_ID_MAX 0.20

#define the clocks at the peripheral output
# SPI MASTER  50MHz
for {set i 0} {$i < 11} {incr i} {
	set_dont_touch         [get_cells i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[${i}].i_spim/u_clockgen/clk_mux_i]
	set_case_analysis 0    [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[${i}].i_spim/u_clockgen/r_clockout_mux_reg/Q]
	create_generated_clock [get_pins  i_host_domain/i_apb_subsystem/i_udma_subsystem/i_spim_gen[${i}].i_spim/u_clockgen/i_clkdiv_cnt/clk_o_reg/Q] \
	                       -name SPIM_CLK_${i} \
	                       -source [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_fll_per/FLLCLK] \
	                       -divide_by $SPIM_CLK_DIV

   set_input_delay  -min -clock SPIM_CLK_${i} [ expr $SPIM_CLOCK_PERIOD * $SPIM_ID_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*spi${i}*sd* ]
   set_input_delay  -max -clock SPIM_CLK_${i} [ expr $SPIM_CLOCK_PERIOD * $SPIM_ID_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*spi${i}*sd* ]

   set_output_delay -min -clock SPIM_CLK_${i} [ expr $SPIM_CLOCK_PERIOD * $SPIM_OD_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*spi${i}*sd* ]
   set_output_delay -max -clock SPIM_CLK_${i} [ expr $SPIM_CLOCK_PERIOD * $SPIM_OD_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*spi${i}*sd* ]

   set_output_delay -min -clock SPIM_CLK_${i} [ expr $SPIM_CLOCK_PERIOD * $SPIM_OD_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*spi${i}*cs* ]
   set_output_delay -max -clock SPIM_CLK_${i} [ expr $SPIM_CLOCK_PERIOD * $SPIM_OD_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*spi${i}*cs* ]
}

#################
## I2C 0 - 4   ##
#################

set I2C_OD_MIN 0.10
set I2C_OD_MAX 0.35
set I2C_ID_MIN 0.10
set I2C_ID_MAX 0.20

for {set i 0} {$i < 5} {incr i} {

	set_output_delay -min -clock FLL_PER_CLK [ expr $PER_C_Period * $I2C_OD_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*i2c${i}*scl* ]
	set_output_delay -max -clock FLL_PER_CLK [ expr $PER_C_Period * $I2C_OD_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*i2c${i}*scl* ]
	set_output_delay -min -clock FLL_PER_CLK [ expr $PER_C_Period * $I2C_OD_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*i2c${i}*sda* ]
	set_output_delay -max -clock FLL_PER_CLK [ expr $PER_C_Period * $I2C_OD_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*i2c${i}*sda* ]
	set_max_delay    [ expr $PER_C_Period * $I2C_ID_MAX ] -from  [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*i2c${i}*sda* ]

}

################
## UART 0 - 7 ##
################

set UART_OD_MIN 0.10
set UART_OD_MAX 0.35
set UART_ID_MIN 0.10
set UART_ID_MAX 0.20

for {set i 0} {$i < 8} {incr i} {

	set_output_delay -min -clock FLL_PER_CLK [ expr $PER_C_Period * $UART_OD_MIN ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*uart*${i}*tx* ]
	set_output_delay -max -clock FLL_PER_CLK [ expr $PER_C_Period * $UART_OD_MAX ] [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_soc2pad*uart*${i}*tx* ]
	set_max_delay    [ expr $PER_C_Period * $UART_ID_MAX ] -from  [ get_pins i_alsaqr_periph_padframe/i_periphs/port_signals_pad2soc*uart*${i}*rx* ]

}

###############
# CVA6 UART   #
###############

set_output_delay -min -clock SOC_PER_CLK [ expr $PER_C_Period * $UART_OD_MIN ] [ get_pins i_padframe/cva6_uart_tx ]
set_output_delay -max -clock SOC_PER_CLK [ expr $PER_C_Period * $UART_OD_MAX ] [ get_pins i_padframe/cva6_uart_tx ]
set_max_delay    [ expr $PER_C_Period * $UART_ID_MAX ] -from  [ get_pins i_padframe/cva6_uart_tx ]

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

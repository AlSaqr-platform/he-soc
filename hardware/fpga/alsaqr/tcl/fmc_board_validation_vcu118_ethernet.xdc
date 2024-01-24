############################################
# PADFRAME FMC PERIPHERAL BOARD (ETHERNET) #
############################################

# Ethernet
set_property -dict {PACKAGE_PIN BA16 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_03_pad]
set_property -dict {PACKAGE_PIN BC13 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_04_pad]
set_property -dict {PACKAGE_PIN BC14 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_05_pad]
set_property -dict {PACKAGE_PIN BD15 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_06_pad]
set_property -dict {PACKAGE_PIN BA15 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_02_pad]
set_property -dict {PACKAGE_PIN BC15 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_01_pad]
set_property -dict {PACKAGE_PIN BF11 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_09_pad]
set_property -dict {PACKAGE_PIN BF12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_10_pad]
set_property -dict {PACKAGE_PIN BE12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_11_pad]
set_property -dict {PACKAGE_PIN BD12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_12_pad]
set_property -dict {PACKAGE_PIN BD11 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_08_pad]
set_property -dict {PACKAGE_PIN BE15 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_07_pad]
set_property -dict {PACKAGE_PIN BA9  IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_13_pad]
set_property -dict {PACKAGE_PIN AR13 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_14_pad]
set_property -dict {PACKAGE_PIN AY9  IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_00_pad]
create_clock -period 8.000 -name eth_rxck [get_ports pad_periphs_pad_gpio_b_01_pad]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets eth_rxck_IBUF]
set_clock_groups -asynchronous -group [get_clocks eth_rxck -include_generated_clocks]
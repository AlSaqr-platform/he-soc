#############################################################
#  _____ ____         _____      _   _   _                  #
# |_   _/ __ \       / ____|    | | | | (_)                 #
#   | || |  | |_____| (___   ___| |_| |_ _ _ __   __ _ ___  #
#   | || |  | |______\___ \ / _ \ __| __| | '_ \ / _` / __| #
#  _| || |__| |      ____) |  __/ |_| |_| | | | | (_| \__ \ #
# |_____\____/      |_____/ \___|\__|\__|_|_| |_|\__, |___/ #
#                                                 __/ |     #
#                                                |___/      #
#############################################################

## Sys clock (ok)
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVDS} [get_ports "c0_sys_clk_n"]
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVDS} [get_ports "c0_sys_clk_p"]

set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS12} [get_ports pad_reset]


## PMOD 0   --- JTAG
######################################################################
# JTAG mapping
######################################################################
set_property -dict {PACKAGE_PIN AY14 IOSTANDARD LVCMOS18} [get_ports pad_jtag_tms]
set_property -dict {PACKAGE_PIN AY15 IOSTANDARD LVCMOS18} [get_ports pad_jtag_tdi]
set_property -dict {PACKAGE_PIN AW15 IOSTANDARD LVCMOS18} [get_ports pad_jtag_tdo]
set_property -dict {PACKAGE_PIN AV15 IOSTANDARD LVCMOS18} [get_ports pad_jtag_tck]
set_property -dict {PACKAGE_PIN AV16 IOSTANDARD LVCMOS18} [get_ports pad_jtag_trst]


######################################################################
# UART mapping
######################################################################
set_property -dict {PACKAGE_PIN AW25  IOSTANDARD LVCMOS18} [get_ports pad_uart0_rx]
set_property -dict {PACKAGE_PIN BB21  IOSTANDARD LVCMOS18} [get_ports pad_uart0_tx]
set_property -dict {PACKAGE_PIN N28   IOSTANDARD LVCMOS12} [get_ports pad_uart1_rx]
set_property -dict {PACKAGE_PIN M30   IOSTANDARD LVCMOS12} [get_ports pad_uart1_tx]

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
set_property -dict {PACKAGE_PIN AY23 IOSTANDARD LVDS} [get_ports ref_clk_n]
set_property -dict {PACKAGE_PIN AY24 IOSTANDARD LVDS} [get_ports ref_clk_p]

## Reset (ok)
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


## UART
######################################################################
# UART mapping
######################################################################
set_property -dict {PACKAGE_PIN AW25  IOSTANDARD LVCMOS18} [get_ports pad_uart_rx]
set_property -dict {PACKAGE_PIN BB21  IOSTANDARD LVCMOS18} [get_ports pad_uart_tx]

####################################################################
# Hyper Bus
####################################################################

set_property -dict {PACKAGE_PIN AY13 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_csn0]
set_property -dict {PACKAGE_PIN AW13 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_csn1]
set_property -dict {PACKAGE_PIN BF10 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_ck]
set_property -dict {PACKAGE_PIN BF9  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_ckn]
set_property -dict {PACKAGE_PIN AY8  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_rwds0]
set_property -dict {PACKAGE_PIN BE14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio0]
set_property -dict {PACKAGE_PIN BF14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio1]
set_property -dict {PACKAGE_PIN BA14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio2]
set_property -dict {PACKAGE_PIN BB14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio3]
set_property -dict {PACKAGE_PIN AV9  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio4]
set_property -dict {PACKAGE_PIN AV8  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio5]
set_property -dict {PACKAGE_PIN AW11 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio6]
set_property -dict {PACKAGE_PIN AY10 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_dqio7]
set_property -dict {PACKAGE_PIN AT12 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper_reset]

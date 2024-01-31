#######################################################################
## Ibex JTAG mapping FMC
#######################################################################
set_property -dict {PACKAGE_PIN BF11 IOSTANDARD LVCMOS18} [get_ports pad_jtag_ot_tms]
set_property -dict {PACKAGE_PIN BC15 IOSTANDARD LVCMOS18} [get_ports pad_jtag_ot_tdi]
set_property -dict {PACKAGE_PIN BA9  IOSTANDARD LVCMOS18} [get_ports pad_jtag_ot_tdo]
set_property -dict {PACKAGE_PIN BA15 IOSTANDARD LVCMOS18} [get_ports pad_jtag_ot_tck]
set_property -dict {PACKAGE_PIN BC11 IOSTANDARD LVCMOS18} [get_ports pad_jtag_ot_trst]

#######################################################################
## Bootmode pad
#######################################################################
set_property -dict {PACKAGE_PIN N30 IOSTANDARD LVCMOS12} [get_ports pad_bootmode]

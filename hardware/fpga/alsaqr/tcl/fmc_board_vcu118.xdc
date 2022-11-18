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
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVDS} [get_ports c0_sys_clk_n]
set_property -dict {PACKAGE_PIN E12 IOSTANDARD LVDS} [get_ports c0_sys_clk_p]

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
set_property -dict {PACKAGE_PIN AW25  IOSTANDARD LVCMOS18} [get_ports pad_uart0_rx]
set_property -dict {PACKAGE_PIN BB21  IOSTANDARD LVCMOS18} [get_ports pad_uart0_tx]
set_property -dict {PACKAGE_PIN N28   IOSTANDARD LVCMOS12} [get_ports pad_uart1_rx]
set_property -dict {PACKAGE_PIN M30   IOSTANDARD LVCMOS12} [get_ports pad_uart1_tx]

####################################################################
#																   #
# 							Hyper Bus 0                            #
#  NB: for testing with the FMC Hyper board change this            #
#  AW8  -> BD13                                                    #
#  AM14 -> BE13                                                    #
#  BF10 -> AP12                                                    #
#  BF9  -> AR12                                                    #
#  AY8  -> AT14                                                    #
####################################################################

#set_property -dict {PACKAGE_PIN BF10 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_ck]
#set_property -dict {PACKAGE_PIN BF9 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_ckn]
#set_property -dict {PACKAGE_PIN BE14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio0]
#set_property -dict {PACKAGE_PIN BF14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio1]
#set_property -dict {PACKAGE_PIN BA14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio2]
#set_property -dict {PACKAGE_PIN BB14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio3]
#set_property -dict {PACKAGE_PIN AL14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_rwds]
#set_property -dict {PACKAGE_PIN AW8 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio4]
#set_property -dict {PACKAGE_PIN AM14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio5]
#set_property -dict {PACKAGE_PIN BB13 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio6]
#set_property -dict {PACKAGE_PIN BB12 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_dqio7]
#set_property -dict {PACKAGE_PIN AY8 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_csn1]
#set_property -dict {PACKAGE_PIN AP16 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_csn0]
#set_property -dict {PACKAGE_PIN AW7 IOSTANDARD LVCMOS18} [get_ports FMC_hyper0_reset]

####################################################################
#																   #
# 							Hyper Bus 1                            #
#  NB: for testing with the FMC Hyper board change this            #
#  BC13 -> AW13                                                    #
#  AN15 -> AY13                                                    #
#  AP15 -> AT12                                                    #
####################################################################

#set_property -dict {PACKAGE_PIN AY9 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_ck]
#set_property -dict {PACKAGE_PIN BA9 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_ckn]
#set_property -dict {PACKAGE_PIN BF15 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio0]
#set_property -dict {PACKAGE_PIN BE15 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio1]
#set_property -dict {PACKAGE_PIN BE12 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio2]
#set_property -dict {PACKAGE_PIN BD12 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio3]
#set_property -dict {PACKAGE_PIN BC14 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_rwds]
#set_property -dict {PACKAGE_PIN AV9 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio4]
#set_property -dict {PACKAGE_PIN AV8 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio5]
#set_property -dict {PACKAGE_PIN AW11 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio6]
#set_property -dict {PACKAGE_PIN AY10 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_dqio7]
#set_property -dict {PACKAGE_PIN BC13 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_csn1]
#set_property -dict {PACKAGE_PIN AN15 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_csn0]
#set_property -dict {PACKAGE_PIN AP15 IOSTANDARD LVCMOS18} [get_ports FMC_hyper1_reset]

####################### END SECTION FMC BOARD 4 HYPERRAM #####################

set_property PACKAGE_PIN BF29 [get_ports c0_init_calib_complete]
set_property IOSTANDARD LVCMOS18 [get_ports c0_init_calib_complete]



set_property PACKAGE_PIN K24 [get_ports {c0_ddr4_dq[0]}]
set_property PACKAGE_PIN J24 [get_ports {c0_ddr4_dq[1]}]
set_property PACKAGE_PIN M21 [get_ports {c0_ddr4_dq[2]}]
set_property PACKAGE_PIN L21 [get_ports {c0_ddr4_dq[3]}]
set_property PACKAGE_PIN K21 [get_ports {c0_ddr4_dq[4]}]
set_property PACKAGE_PIN J21 [get_ports {c0_ddr4_dq[5]}]
set_property PACKAGE_PIN K22 [get_ports {c0_ddr4_dq[6]}]
set_property PACKAGE_PIN J22 [get_ports {c0_ddr4_dq[7]}]
set_property PACKAGE_PIN H23 [get_ports {c0_ddr4_dq[8]}]
set_property PACKAGE_PIN H22 [get_ports {c0_ddr4_dq[9]}]
set_property PACKAGE_PIN E23 [get_ports {c0_ddr4_dq[10]}]
set_property PACKAGE_PIN E22 [get_ports {c0_ddr4_dq[11]}]
set_property PACKAGE_PIN F21 [get_ports {c0_ddr4_dq[12]}]
set_property PACKAGE_PIN E21 [get_ports {c0_ddr4_dq[13]}]
set_property PACKAGE_PIN F24 [get_ports {c0_ddr4_dq[14]}]
set_property PACKAGE_PIN F23 [get_ports {c0_ddr4_dq[15]}]



set_property PACKAGE_PIN L23 [get_ports {c0_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN G22 [get_ports {c0_ddr4_dm_dbi_n[1]}]

set_property PACKAGE_PIN C8 [get_ports {c0_ddr4_odt[0]}]

set_property PACKAGE_PIN D14 [get_ports {c0_ddr4_adr[0]}]
set_property PACKAGE_PIN B15 [get_ports {c0_ddr4_adr[1]}]
set_property PACKAGE_PIN B16 [get_ports {c0_ddr4_adr[2]}]
set_property PACKAGE_PIN C14 [get_ports {c0_ddr4_adr[3]}]
set_property PACKAGE_PIN C15 [get_ports {c0_ddr4_adr[4]}]
set_property PACKAGE_PIN A13 [get_ports {c0_ddr4_adr[5]}]
set_property PACKAGE_PIN A14 [get_ports {c0_ddr4_adr[6]}]
set_property PACKAGE_PIN A15 [get_ports {c0_ddr4_adr[7]}]
set_property PACKAGE_PIN A16 [get_ports {c0_ddr4_adr[8]}]
set_property PACKAGE_PIN B12 [get_ports {c0_ddr4_adr[9]}]
set_property PACKAGE_PIN C12 [get_ports {c0_ddr4_adr[10]}]
set_property PACKAGE_PIN B13 [get_ports {c0_ddr4_adr[11]}]
set_property PACKAGE_PIN C13 [get_ports {c0_ddr4_adr[12]}]
set_property PACKAGE_PIN D15 [get_ports {c0_ddr4_adr[13]}]

####################################################################
# DDR4
####################################################################

set_property PACKAGE_PIN BE29 [get_ports c0_data_compare_error]

set_property PACKAGE_PIN BF29 [get_ports c0_init_calib_complete]














####################################################################
# PADFRAME FMC PERIPHERAL BOARD (SPI - I2C - UART - SDIO)
####################################################################

set_property -dict {PACKAGE_PIN AP12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_00_pad]
set_property -dict {PACKAGE_PIN AN16 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_01_pad]
set_property -dict {PACKAGE_PIN AT14 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_02_pad]
set_property -dict {PACKAGE_PIN AR12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_03_pad]
set_property -dict {PACKAGE_PIN AK15 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_04_pad]
set_property -dict {PACKAGE_PIN AL15 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_05_pad]
set_property -dict {PACKAGE_PIN AW10 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_06_pad]
set_property -dict {PACKAGE_PIN AV10 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_07_pad]

set_property -dict {PACKAGE_PIN AU11 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_08_pad]
set_property -dict {PACKAGE_PIN AV11 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_09_pad]
set_property -dict {PACKAGE_PIN AT12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_10_pad]
set_property -dict {PACKAGE_PIN AU12 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_11_pad]

set_property -dict {PACKAGE_PIN AW13 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_12_pad]
set_property -dict {PACKAGE_PIN AY13 IOSTANDARD LVCMOS18} [get_ports pad_periphs_pad_gpio_b_13_pad]





set_property PACKAGE_PIN K24 [get_ports {c0_ddr4_dq[0]}]
set_property PACKAGE_PIN J24 [get_ports {c0_ddr4_dq[1]}]
set_property PACKAGE_PIN M21 [get_ports {c0_ddr4_dq[2]}]
set_property PACKAGE_PIN L21 [get_ports {c0_ddr4_dq[3]}]
set_property PACKAGE_PIN K21 [get_ports {c0_ddr4_dq[4]}]
set_property PACKAGE_PIN J21 [get_ports {c0_ddr4_dq[5]}]
set_property PACKAGE_PIN K22 [get_ports {c0_ddr4_dq[6]}]
set_property PACKAGE_PIN J22 [get_ports {c0_ddr4_dq[7]}]
set_property PACKAGE_PIN H23 [get_ports {c0_ddr4_dq[8]}]
set_property PACKAGE_PIN H22 [get_ports {c0_ddr4_dq[9]}]
set_property PACKAGE_PIN E23 [get_ports {c0_ddr4_dq[10]}]
set_property PACKAGE_PIN E22 [get_ports {c0_ddr4_dq[11]}]
set_property PACKAGE_PIN F21 [get_ports {c0_ddr4_dq[12]}]
set_property PACKAGE_PIN E21 [get_ports {c0_ddr4_dq[13]}]
set_property PACKAGE_PIN F24 [get_ports {c0_ddr4_dq[14]}]
set_property PACKAGE_PIN F23 [get_ports {c0_ddr4_dq[15]}]
set_property PACKAGE_PIN L23 [get_ports {c0_ddr4_dm_dbi_n[0]}]
set_property PACKAGE_PIN G22 [get_ports {c0_ddr4_dm_dbi_n[1]}]
set_property PACKAGE_PIN C8 [get_ports {c0_ddr4_odt[0]}]
set_property PACKAGE_PIN D14 [get_ports {c0_ddr4_adr[0]}]
set_property PACKAGE_PIN B15 [get_ports {c0_ddr4_adr[1]}]
set_property PACKAGE_PIN B16 [get_ports {c0_ddr4_adr[2]}]
set_property PACKAGE_PIN C14 [get_ports {c0_ddr4_adr[3]}]
set_property PACKAGE_PIN C15 [get_ports {c0_ddr4_adr[4]}]
set_property PACKAGE_PIN A13 [get_ports {c0_ddr4_adr[5]}]
set_property PACKAGE_PIN A14 [get_ports {c0_ddr4_adr[6]}]
set_property PACKAGE_PIN A15 [get_ports {c0_ddr4_adr[7]}]
set_property PACKAGE_PIN A16 [get_ports {c0_ddr4_adr[8]}]
set_property PACKAGE_PIN B12 [get_ports {c0_ddr4_adr[9]}]
set_property PACKAGE_PIN C12 [get_ports {c0_ddr4_adr[10]}]
set_property PACKAGE_PIN B13 [get_ports {c0_ddr4_adr[11]}]
set_property PACKAGE_PIN C13 [get_ports {c0_ddr4_adr[12]}]
set_property PACKAGE_PIN D15 [get_ports {c0_ddr4_adr[13]}]
set_property PACKAGE_PIN G15 [get_ports {c0_ddr4_ba[0]}]
set_property PACKAGE_PIN G13 [get_ports {c0_ddr4_ba[1]}]
set_property PACKAGE_PIN H13 [get_ports {c0_ddr4_bg[0]}]
set_property PACKAGE_PIN H14 [get_ports {c0_ddr4_adr[14]}]
set_property PACKAGE_PIN H15 [get_ports {c0_ddr4_adr[15]}]
set_property PACKAGE_PIN F15 [get_ports {c0_ddr4_adr[16]}]
set_property PACKAGE_PIN F13 [get_ports {c0_ddr4_cs_n[0]}]
set_property PACKAGE_PIN A10 [get_ports {c0_ddr4_cke[0]}]
set_property PACKAGE_PIN N20 [get_ports c0_ddr4_reset_n]
set_property PACKAGE_PIN E13 [get_ports c0_ddr4_act_n]
set_property PACKAGE_PIN F14 [get_ports {c0_ddr4_ck_t[0]}]
set_property PACKAGE_PIN E14 [get_ports {c0_ddr4_ck_c[0]}]
set_property PACKAGE_PIN H24 [get_ports {c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN G23 [get_ports {c0_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN M20 [get_ports {c0_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN L20 [get_ports {c0_ddr4_dqs_c[0]}]

set_property IOSTANDARD LVCMOS18 [get_ports c0_data_compare_error]
set_property IOSTANDARD LVCMOS18 [get_ports c0_init_calib_complete]

####################################################################################
# Constraints from file : 'constraints.xdc'
####################################################################################


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
#set_property -dict {PACKAGE_PIN AY23 IOSTANDARD LVDS} [get_ports ref_clk_n]
#set_property -dict {PACKAGE_PIN AY24 IOSTANDARD LVDS} [get_ports ref_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c0_sys_clk_p" ]

set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c0_sys_clk_n" ]

set_property PACKAGE_PIN BD35 [ get_ports "pad_reset" ]
set_property IOSTANDARD LVCMOS12 [ get_ports "pad_reset" ]

set_property PACKAGE_PIN AV33 [ get_ports "c0_sys_clk_p" ]
set_property PACKAGE_PIN AW33 [ get_ports "c0_sys_clk_n" ]

## Reset (ok)
#set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS12} [get_ports pad_reset]


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
# Hyper Bus 0
####################################################################

set_property -dict {PACKAGE_PIN BF10 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_ck]
set_property -dict {PACKAGE_PIN BF9  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_ckn]
set_property -dict {PACKAGE_PIN BE14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio0]
set_property -dict {PACKAGE_PIN BF14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio1]
set_property -dict {PACKAGE_PIN BA14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio2]
set_property -dict {PACKAGE_PIN BB14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio3]
set_property -dict {PACKAGE_PIN AY8  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_rwds]
set_property -dict {PACKAGE_PIN AV9  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio4]
set_property -dict {PACKAGE_PIN AV8  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio5]
set_property -dict {PACKAGE_PIN AW11 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio6]
set_property -dict {PACKAGE_PIN AY10 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_dqio7]
set_property -dict {PACKAGE_PIN AW13 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_csn1]
set_property -dict {PACKAGE_PIN AY13 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_csn0]
set_property -dict {PACKAGE_PIN AT12 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper0_reset]

####################################################################
# Hyper Bus 1
####################################################################

set_property -dict {PACKAGE_PIN AY9  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_ck]
set_property -dict {PACKAGE_PIN BA9  IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_ckn]
set_property -dict {PACKAGE_PIN BD12 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio0]
set_property -dict {PACKAGE_PIN BE12 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio1]
set_property -dict {PACKAGE_PIN BE15 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio2]
set_property -dict {PACKAGE_PIN BF15 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio3]
set_property -dict {PACKAGE_PIN BC14 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_rwds]
set_property -dict {PACKAGE_PIN BA16 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio4]
set_property -dict {PACKAGE_PIN BA15 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio5]
set_property -dict {PACKAGE_PIN BB16 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio6]
set_property -dict {PACKAGE_PIN BC16 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_dqio7]
set_property -dict {PACKAGE_PIN AW12 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_csn1]
set_property -dict {PACKAGE_PIN AY12 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_csn0]
set_property -dict {PACKAGE_PIN AU11 IOSTANDARD LVCMOS18}  [get_ports FMC_hyper1_reset]


#Pin LOC constraints for the status signals init_calib_complete and data_compare_error

#LOC constraints provided if the pins are selected for status signals

set_property PACKAGE_PIN BC40 [ get_ports "c0_init_calib_complete" ]
set_property IOSTANDARD LVCMOS12 [ get_ports "c0_init_calib_complete" ]

set_property DRIVE 8 [ get_ports "c0_init_calib_complete" ]

set_property PACKAGE_PIN BF40 [ get_ports "c0_data_compare_error" ]
set_property IOSTANDARD LVCMOS12 [ get_ports "c0_data_compare_error" ]

set_property DRIVE 8 [ get_ports "c0_data_compare_error" ]

set_property PACKAGE_PIN AL27 [ get_ports "c0_ddr4_dq[46]" ]
set_property PACKAGE_PIN AM26 [ get_ports "c0_ddr4_dq[40]" ]
set_property PACKAGE_PIN AM27 [ get_ports "c0_ddr4_dq[47]" ]
set_property PACKAGE_PIN AM28 [ get_ports "c0_ddr4_dqs_t[5]" ]
set_property PACKAGE_PIN AN26 [ get_ports "c0_ddr4_dq[41]" ]
set_property PACKAGE_PIN AN28 [ get_ports "c0_ddr4_dqs_c[5]" ]
set_property PACKAGE_PIN AN30 [ get_ports "c0_ddr4_bg[0]" ]
set_property PACKAGE_PIN AN31 [ get_ports "c0_ddr4_cs_n[0]" ]
set_property PACKAGE_PIN AP25 [ get_ports "c0_ddr4_dq[44]" ]
set_property PACKAGE_PIN AP26 [ get_ports "c0_ddr4_dq[45]" ]
set_property PACKAGE_PIN AP27 [ get_ports "c0_ddr4_dq[42]" ]
set_property PACKAGE_PIN AP28 [ get_ports "c0_ddr4_dq[43]" ]
set_property PACKAGE_PIN AP30 [ get_ports "c0_ddr4_ba[0]" ]
set_property PACKAGE_PIN AP31 [ get_ports "c0_ddr4_adr[15]" ]
set_property PACKAGE_PIN AP32 [ get_ports "c0_ddr4_adr[16]" ]
set_property PACKAGE_PIN AR25 [ get_ports "c0_ddr4_dq[38]" ]
set_property PACKAGE_PIN AR27 [ get_ports "c0_ddr4_dm_dbi_n[5]" ]
set_property PACKAGE_PIN AR29 [ get_ports "c0_ddr4_cke[0]" ]
set_property PACKAGE_PIN AR30 [ get_ports "c0_ddr4_ba[1]" ]
set_property PACKAGE_PIN AR32 [ get_ports "c0_ddr4_adr[9]" ]
set_property PACKAGE_PIN AR33 [ get_ports "c0_ddr4_adr[11]" ]
set_property PACKAGE_PIN AT25 [ get_ports "c0_ddr4_dq[39]" ]
set_property PACKAGE_PIN AT26 [ get_ports "c0_ddr4_dqs_t[4]" ]
set_property PACKAGE_PIN AT27 [ get_ports "c0_ddr4_dqs_c[4]" ]
set_property PACKAGE_PIN AT29 [ get_ports "c0_ddr4_adr[13]" ]
set_property PACKAGE_PIN AT30 [ get_ports "c0_ddr4_adr[14]" ]
set_property PACKAGE_PIN AT31 [ get_ports "c0_ddr4_adr[4]" ]
set_property PACKAGE_PIN AT32 [ get_ports "c0_ddr4_adr[10]" ]
set_property PACKAGE_PIN AT34 [ get_ports "c0_ddr4_adr[12]" ]
set_property PACKAGE_PIN AU26 [ get_ports "c0_ddr4_dq[32]" ]
set_property PACKAGE_PIN AU27 [ get_ports "c0_ddr4_dq[36]" ]
set_property PACKAGE_PIN AU28 [ get_ports "c0_ddr4_dq[37]" ]
set_property PACKAGE_PIN AU29 [ get_ports "c0_ddr4_ck_t[0]" ]
set_property PACKAGE_PIN AU31 [ get_ports "c0_ddr4_adr[6]" ]
set_property PACKAGE_PIN AU32 [ get_ports "c0_ddr4_adr[5]" ]
set_property PACKAGE_PIN AU33 [ get_ports "c0_ddr4_adr[2]" ]
set_property PACKAGE_PIN AU34 [ get_ports "c0_ddr4_adr[3]" ]
set_property PACKAGE_PIN AV26 [ get_ports "c0_ddr4_dq[33]" ]
set_property PACKAGE_PIN AV28 [ get_ports "c0_ddr4_dq[34]" ]
set_property PACKAGE_PIN AV29 [ get_ports "c0_ddr4_ck_c[0]" ]
set_property PACKAGE_PIN AV30 [ get_ports "c0_ddr4_adr[0]" ]
set_property PACKAGE_PIN AV31 [ get_ports "c0_ddr4_adr[7]" ]
set_property PACKAGE_PIN AV34 [ get_ports "c0_ddr4_adr[8]" ]
set_property PACKAGE_PIN AW26 [ get_ports "c0_ddr4_dm_dbi_n[4]" ]
set_property PACKAGE_PIN AW28 [ get_ports "c0_ddr4_dq[35]" ]
set_property PACKAGE_PIN AW30 [ get_ports "c0_ddr4_adr[1]" ]
set_property PACKAGE_PIN AW31 [ get_ports "c0_ddr4_dq[12]" ]
set_property PACKAGE_PIN AW32 [ get_ports "c0_ddr4_dq[13]" ]
set_property PACKAGE_PIN AW40 [ get_ports "c0_ddr4_dq[68]" ]
set_property PACKAGE_PIN AY27 [ get_ports "c0_ddr4_dq[28]" ]
set_property PACKAGE_PIN AY28 [ get_ports "c0_ddr4_dq[29]" ]
set_property PACKAGE_PIN AY30 [ get_ports "c0_ddr4_reset_n" ]
set_property PACKAGE_PIN AY32 [ get_ports "c0_ddr4_dq[14]" ]
set_property PACKAGE_PIN AY33 [ get_ports "c0_ddr4_dq[15]" ]
set_property PACKAGE_PIN AY34 [ get_ports "c0_ddr4_dqs_t[1]" ]
set_property PACKAGE_PIN AY37 [ get_ports "c0_ddr4_dm_dbi_n[8]" ]
set_property PACKAGE_PIN AY38 [ get_ports "c0_ddr4_dq[70]" ]
set_property PACKAGE_PIN AY39 [ get_ports "c0_ddr4_dq[71]" ]
set_property PACKAGE_PIN AY40 [ get_ports "c0_ddr4_dq[69]" ]
set_property PACKAGE_PIN BA26 [ get_ports "c0_ddr4_dqs_t[3]" ]
set_property PACKAGE_PIN BA27 [ get_ports "c0_ddr4_dq[30]" ]
set_property PACKAGE_PIN BA29 [ get_ports "c0_ddr4_dm_dbi_n[3]" ]
set_property PACKAGE_PIN BA30 [ get_ports "c0_ddr4_dq[10]" ]
set_property PACKAGE_PIN BA31 [ get_ports "c0_ddr4_dq[11]" ]
set_property PACKAGE_PIN BA32 [ get_ports "c0_ddr4_dq[8]" ]
set_property PACKAGE_PIN BA34 [ get_ports "c0_ddr4_dqs_c[1]" ]
set_property PACKAGE_PIN BA35 [ get_ports "c0_ddr4_dqs_t[8]" ]
set_property PACKAGE_PIN BA36 [ get_ports "c0_ddr4_dqs_c[8]" ]
set_property PACKAGE_PIN BA39 [ get_ports "c0_ddr4_dq[66]" ]
set_property PACKAGE_PIN BA40 [ get_ports "c0_ddr4_dq[67]" ]
set_property PACKAGE_PIN BB26 [ get_ports "c0_ddr4_dqs_c[3]" ]
set_property PACKAGE_PIN BB27 [ get_ports "c0_ddr4_dq[31]" ]
set_property PACKAGE_PIN BB28 [ get_ports "c0_ddr4_dq[26]" ]
set_property PACKAGE_PIN BB31 [ get_ports "c0_ddr4_dm_dbi_n[1]" ]
set_property PACKAGE_PIN BB32 [ get_ports "c0_ddr4_act_n" ]
set_property PACKAGE_PIN BB33 [ get_ports "c0_ddr4_dq[9]" ]
set_property PACKAGE_PIN BB36 [ get_ports "c0_ddr4_dq[64]" ]
set_property PACKAGE_PIN BB37 [ get_ports "c0_ddr4_dq[65]" ]
set_property PACKAGE_PIN BB38 [ get_ports "c0_ddr4_dq[60]" ]
set_property PACKAGE_PIN BB39 [ get_ports "c0_ddr4_dq[61]" ]
set_property PACKAGE_PIN BC25 [ get_ports "c0_ddr4_dq[24]" ]
set_property PACKAGE_PIN BC26 [ get_ports "c0_ddr4_dq[25]" ]
set_property PACKAGE_PIN BC28 [ get_ports "c0_ddr4_dq[27]" ]
set_property PACKAGE_PIN BC31 [ get_ports "c0_ddr4_dq[6]" ]
set_property PACKAGE_PIN BC33 [ get_ports "c0_ddr4_dq[4]" ]
set_property PACKAGE_PIN BC34 [ get_ports "c0_ddr4_dm_dbi_n[6]" ]
set_property PACKAGE_PIN BC35 [ get_ports "c0_ddr4_dq[50]" ]
set_property PACKAGE_PIN BC36 [ get_ports "c0_ddr4_dq[51]" ]
set_property PACKAGE_PIN BC38 [ get_ports "c0_ddr4_dq[62]" ]
set_property PACKAGE_PIN BC39 [ get_ports "c0_ddr4_dq[58]" ]
set_property PACKAGE_PIN BD25 [ get_ports "c0_ddr4_dq[22]" ]
set_property PACKAGE_PIN BD26 [ get_ports "c0_ddr4_dq[23]" ]
set_property PACKAGE_PIN BD27 [ get_ports "c0_ddr4_dq[20]" ]
set_property PACKAGE_PIN BD28 [ get_ports "c0_ddr4_dq[18]" ]
set_property PACKAGE_PIN BD30 [ get_ports "c0_ddr4_dq[0]" ]
set_property PACKAGE_PIN BD31 [ get_ports "c0_ddr4_dq[7]" ]
set_property PACKAGE_PIN BD32 [ get_ports "c0_ddr4_dq[2]" ]
set_property PACKAGE_PIN BD33 [ get_ports "c0_ddr4_dq[5]" ]
set_property PACKAGE_PIN BD36 [ get_ports "c0_ddr4_dq[52]" ]
set_property PACKAGE_PIN BD37 [ get_ports "c0_ddr4_dq[56]" ]
set_property PACKAGE_PIN BD38 [ get_ports "c0_ddr4_dq[63]" ]
set_property PACKAGE_PIN BD40 [ get_ports "c0_ddr4_dq[59]" ]
set_property PACKAGE_PIN BE25 [ get_ports "c0_ddr4_dqs_t[2]" ]
set_property PACKAGE_PIN BE27 [ get_ports "c0_ddr4_dq[21]" ]
set_property PACKAGE_PIN BE28 [ get_ports "c0_ddr4_dq[19]" ]
set_property PACKAGE_PIN BE29 [ get_ports "c0_ddr4_dm_dbi_n[2]" ]
set_property PACKAGE_PIN BE30 [ get_ports "c0_ddr4_dq[1]" ]
set_property PACKAGE_PIN BE32 [ get_ports "c0_ddr4_dm_dbi_n[0]" ]
set_property PACKAGE_PIN BE33 [ get_ports "c0_ddr4_dq[3]" ]
set_property PACKAGE_PIN BE34 [ get_ports "c0_ddr4_dq[48]" ]
set_property PACKAGE_PIN BE35 [ get_ports "c0_ddr4_dqs_t[6]" ]
set_property PACKAGE_PIN BE37 [ get_ports "c0_ddr4_dq[53]" ]
set_property PACKAGE_PIN BE38 [ get_ports "c0_ddr4_dq[57]" ]
set_property PACKAGE_PIN BE39 [ get_ports "c0_ddr4_dqs_t[7]" ]
set_property PACKAGE_PIN BE40 [ get_ports "c0_ddr4_dm_dbi_n[7]" ]
set_property PACKAGE_PIN BF25 [ get_ports "c0_ddr4_dqs_c[2]" ]
set_property PACKAGE_PIN BF26 [ get_ports "c0_ddr4_dq[16]" ]
set_property PACKAGE_PIN BF27 [ get_ports "c0_ddr4_dq[17]" ]
set_property PACKAGE_PIN BF30 [ get_ports "c0_ddr4_dqs_t[0]" ]
set_property PACKAGE_PIN BF31 [ get_ports "c0_ddr4_dqs_c[0]" ]
set_property PACKAGE_PIN BF32 [ get_ports "c0_ddr4_odt[0]" ]
set_property PACKAGE_PIN BF34 [ get_ports "c0_ddr4_dq[49]" ]
set_property PACKAGE_PIN BF35 [ get_ports "c0_ddr4_dqs_c[6]" ]
set_property PACKAGE_PIN BF36 [ get_ports "c0_ddr4_dq[54]" ]
set_property PACKAGE_PIN BF37 [ get_ports "c0_ddr4_dq[55]" ]
set_property PACKAGE_PIN BF39 [ get_ports "c0_ddr4_dqs_c[7]" ]


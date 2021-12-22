set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

if [info exists ::env(BOARD)] {
    set BOARD $::env(BOARD)
} else {
    error "BOARD is not defined. Please source the sourceme.sh file."
    exit
}
if [info exists ::env(XILINX_BOARD)] {
	set boardName  $::env(XILINX_BOARD)
}


set ipName xilinx_clk_mngr

create_project $ipName . -part $partNumber
set_property board_part $boardName [current_project]

create_ip -name clk_wiz -vendor xilinx.com -library ip -module_name $ipName
set_property -dict [list CONFIG.PRIMITIVE {MMCM} \
                        CONFIG.PRIM_IN_FREQ {250.000} \
                        CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125.000} \
                        CONFIG.CLKIN1_JITTER_PS {40.0} \
                        CONFIG.CLKOUT1_DRIVES {Buffer} \
                        CONFIG.CLKOUT2_DRIVES {Buffer} \
                        CONFIG.CLKOUT3_DRIVES {Buffer} \
                        CONFIG.CLKOUT4_DRIVES {Buffer} \
                        CONFIG.CLKOUT5_DRIVES {Buffer} \
                        CONFIG.CLKOUT6_DRIVES {Buffer} \
                        CONFIG.CLKOUT7_DRIVES {Buffer} \
                        CONFIG.FEEDBACK_SOURCE {FDBK_AUTO} \
                        CONFIG.USE_LOCKED {true} \
                        CONFIG.USE_RESET {true} \
                        CONFIG.MMCM_DIVCLK_DIVIDE {2} \
                        CONFIG.MMCM_CLKFBOUT_MULT_F {9.625} \
                        CONFIG.MMCM_CLKIN1_PERIOD {4.000} \
                        CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
                        CONFIG.MMCM_COMPENSATION {AUTO} \
                        CONFIG.MMCM_CLKOUT0_DIVIDE_F {9.625} \
                        CONFIG.CLKOUT1_JITTER {106.624} \
                        CONFIG.CLKOUT1_PHASE_ERROR {85.285}\
                        CONFIG.AUTO_PRIMITIVE {BUFGCE_DIV} \
                       ] [get_ips $ipName]

generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 12 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1

set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

if [info exists ::env(BOARD)] {
    set BOARD $::env(BOARD)
} else {
    error "BOARD is not defined. Please source the sourceme.sh file."
    exit
}
if {$::env(MAIN_MEM)=="HYPER"} {
    set CLK_FREQ_MHZ 10
} elseif {$::env(MAIN_MEM)=="DDR4"} {
    if {$::env(NUM_CORES)==4} {
        set CLK_FREQ_MHZ 20
    } elseif {$::env(USE_OT)=="1"} {
        set CLK_FREQ_MHZ 25
    } else {
        set CLK_FREQ_MHZ 40
    }
}

set ipName xilinx_clk_mngr

create_project $ipName . -part $partNumber
set_property board_part $boardName [current_project]

create_ip -name clk_wiz -vendor xilinx.com -library ip -module_name $ipName

if {$::env(ETH2FMC_NO_PAD)=="1"} {
    set_property -dict [list CONFIG.PRIM_IN_FREQ {250} \
                            CONFIG.CLKOUT2_USED {true} \
                            CONFIG.CLKOUT3_USED {true} \
                            CONFIG.CLKOUT4_USED {true} \
                            CONFIG.CLKOUT1_REQUESTED_OUT_FREQ "$CLK_FREQ_MHZ" \
                            CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {125} \
                            CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {125} \
                            CONFIG.CLKOUT3_REQUESTED_PHASE {90} \
                            CONFIG.CLKOUT4_REQUESTED_OUT_FREQ {300} \
                            CONFIG.RESET_TYPE {ACTIVE_LOW} \
                            CONFIG.CLKIN1_JITTER_PS {40.0} \
                            CONFIG.MMCM_DIVCLK_DIVIDE {1} \
                            CONFIG.MMCM_CLKFBOUT_MULT_F {6.000} \
                            CONFIG.MMCM_CLKIN1_PERIOD {4.000} \
                            CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
                            CONFIG.MMCM_CLKOUT0_DIVIDE_F {30.000} \
                            CONFIG.MMCM_CLKOUT1_DIVIDE {12} \
                            CONFIG.MMCM_CLKOUT2_DIVIDE {12} \
                            CONFIG.MMCM_CLKOUT2_PHASE {90.000} \
                            CONFIG.MMCM_CLKOUT3_DIVIDE {5} \
                            CONFIG.NUM_OUT_CLKS {4} \
                            CONFIG.RESET_PORT {resetn} \
                            CONFIG.CLKOUT1_JITTER {108.355} \
                            CONFIG.CLKOUT1_PHASE_ERROR {72.667} \
                            CONFIG.CLKOUT2_JITTER {90.793} \
                            CONFIG.CLKOUT2_PHASE_ERROR {72.667} \
                            CONFIG.CLKOUT3_JITTER {90.793} \
                            CONFIG.CLKOUT3_PHASE_ERROR {72.667} \
                            CONFIG.CLKOUT4_JITTER {76.708} \
                            CONFIG.CLKOUT4_PHASE_ERROR {72.667} ] [get_ips $ipName]

} else {
    set_property -dict [list CONFIG.PRIM_IN_FREQ {250.000} \
                            CONFIG.CLKOUT1_REQUESTED_OUT_FREQ "$CLK_FREQ_MHZ" \
                            CONFIG.RESET_TYPE {ACTIVE_LOW} \
                            CONFIG.CLKIN1_JITTER_PS {40.0} \
                            CONFIG.MMCM_DIVCLK_DIVIDE {25} \
                            CONFIG.MMCM_CLKFBOUT_MULT_F {105.750} \
                            CONFIG.MMCM_CLKIN1_PERIOD {4.000} \
                            CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
                            CONFIG.MMCM_CLKOUT0_DIVIDE_F {88.125} \
                            CONFIG.RESET_PORT {resetn} \
                            CONFIG.CLKOUT1_JITTER {350.612} \
                            CONFIG.CLKOUT1_PHASE_ERROR {426.712} ] [get_ips $ipName]
}

generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 12 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1

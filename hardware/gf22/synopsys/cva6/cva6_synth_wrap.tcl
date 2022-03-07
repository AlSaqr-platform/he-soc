####################################################################
## Load SETUP 
####################################################################
sh date
sh echo "Current git version is `git rev-parse --short HEAD`"
source ../.submodules_dc_setup.setup
source ../scripts/design_setup.tcl
source ../scripts/area_report.tcl


set reAnalyzeRTL "TRUE"
set TRIAL_DIR "trial3_07_03_2022"
set DESIGN_NAME "cva6_synth_wrap"
 
####################################################################
## Environment Setup
####################################################################
suppress_message { VER-130 }
set_host_option -max_core 8
set timing_enable_through_paths true

set compile_timing_high_effort true
set_app_var hdlin_sv_enable_rtl_attributes true
set_app_var write_name_nets_same_as_ports true
set_app_var hdlin_infer_multibit default_all
set compile_clock_gating_through_hierarchy true

sh mkdir -p ${TRIAL_DIR}/unmapped
sh mkdir -p ${TRIAL_DIR}/logs
sh mkdir -p ${TRIAL_DIR}/reports
sh date > ${TRIAL_DIR}/lock_date

####################################################################
## ANALYZE THE RTL CODE or Read the GTECH 
####################################################################

if { $reAnalyzeRTL == "TRUE" } {
    file delete -force -- ./work
    source -echo -verbose ../scripts/analyze_alsaqr.tcl > ${TRIAL_DIR}/logs/analyze.log
} else {
    read_file  -format ddc  ./${TRIAL_DIR}/unmapped/${DESIGN_NAME}_chip_unmapped.ddc
}


####################################################################
## ELABORATE DUSTIN TOP LEVEL
####################################################################

elaborate ${DESIGN_NAME} -work work > ${TRIAL_DIR}/reports/d00_elaborate.log
check_design                        > ${TRIAL_DIR}/reports/d01_check_design_postElab.rpt
current_design cva6_synth_wrap
write -format verilog -hier -o ./${TRIAL_DIR}/unmapped/${DESIGN_NAME}_chip_unmapped.v
write -format ddc -hier -o ./${TRIAL_DIR}/unmapped/${DESIGN_NAME}_chip_unmapped.ddc ${DESIGN_NAME}

####################################################################
## LINK
####################################################################
link                                                      > ${TRIAL_DIR}/reports/d02_link_alsaqr.rpt

report_timing -loop -max_paths 100 > ./${TRIAL_DIR}/timing_loops.rpt

####################################################################
## DONT USE SPECIFIED CELLS
####################################################################
set_dont_use [get_lib_cells */*_A_*]
set_dont_use [get_lib_cells */*X0P5_*]
#these cells tend to leak a lot, synopsys was removing almost all of them to reduce leakage
#therefore, we do not allow it to use it in the first place
set_dont_use [get_lib_cells */*20SL*]
set_dont_use [get_lib_cells */*20L*]

####################################################################
## LINK
####################################################################
link                                                      > ${TRIAL_DIR}/reports/d03_link_alsaqr.rpt

####################################################################
## UNIQUIFY
####################################################################
after 1000
set uniquify_naming_style "alsaqr_%s_%d"
uniquify -force                                           > ${TRIAL_DIR}/reports/d04_pre_synth_uniquify.rpt

####################################################################
## SET OPERATING CONDITIONS SSG VDD=0.72V VSS=0V NO BIAS T=40 C
####################################################################
set_operating_conditions -max SSG_0P72V_0P00V_0P00V_0P00V_M40C

####################################################################
## ADD CONSTRAINTS
####################################################################
set_app_var hdlin_sv_enable_rtl_attributes true
source -echo -verbose ./constraints/alsaqr.clock.sdc             > ${TRIAL_DIR}/reports/d05_constr_clk.rpt

####################################################################
## INSERT CLK GATING CELLS
####################################################################
# clock gating
identify_clock_gating
report_clock_gating -multi_stage -nosplit > ./${TRIAL_DIR}/reports/d09_clk_gating.rpt
set_preserve_clock_gate [all_clock_gates]
set_attribute [get_cells  $CLK_GATE_CELL  ] is_clock_gating_cell true 
set_attribute [get_cells  $CLK_GATE_CELL  ] clock_gating_integrated_cell latch_posedge_precontrol 
set_clock_gating_style -minimum_bitwidth 8 -positive_edge_logic integrated:$CLK_GATE_CELL -control_point  before  -control_signal scan_enable  -max_fanout 256

report_clocks                                                       > ./${TRIAL_DIR}/reports/d10_clocks.rpt

check_design                                              > ./${TRIAL_DIR}/reports/d11_check_design_precompile.rpt
compile_ultra -no_autoungroup -timing -gate_clock 
check_design                                              > ./${TRIAL_DIR}/reports/d12_check_design_postcompile.rpt

####################################################################
## POST SYNTHESIS UNIQUIFY 
####################################################################
set uniquify_naming_style "alsaqr_%s_%d"
uniquify -force                                           > ./${TRIAL_DIR}/reports/d13_uniquify_post_synth.rpt

###################################################################
## POST SYNTHESIS DDC
####################################################################
sh mkdir -p ./${TRIAL_DIR}/mapped
write -f ddc -hierarchy  -output ./${TRIAL_DIR}/mapped/alsaqr_postsyn.ddc

####################################################################
## POST SYNTHESIS NETLIST
####################################################################
change_names -rules verilog -hier
define_name_rules fixbackslashes -allowed "A-Za-z0-9_" -first_restricted "\\" -remove_chars
change_names -rule fixbackslashes -h
sh mkdir -p ./${TRIAL_DIR}/netlists
write -format verilog -hier -o ./${TRIAL_DIR}/netlists/cva6_synth_wrap.v

####################################################################
## REPORTS
####################################################################
report_timing      -nosplit                                                                                  > ./${TRIAL_DIR}/reports/timing.rpt
report_area  -hier -nosplit                                                                                  > ./${TRIAL_DIR}/reports/area.rpt
report_resources -hierarchy                                                                                  > ./${TRIAL_DIR}/reports/dp_resource.rpt
report_clock_gating                                                                                          > ./${TRIAL_DIR}/reports/clock_gating_postsyn.rpt
report_units                                                                                                 > ./${TRIAL_DIR}/reports/units.rpt
report_timing -max_paths 10 -to FLL_CVA6_CLK                                                                 > ./${TRIAL_DIR}/reports/timing_cva6_clock.rpt

####################################################################
## WRITE OUT CONSTRAINTS
####################################################################
write_sdc   ./${TRIAL_DIR}/constraints.sdc

####################################################################
## START GUI
####################################################################
sh date
sh echo "Current git version is `git rev-parse --short HEAD`"
sh echo "Synthesis of AlSaqr has finished."
start_gui

##########################################################################
#  Design Setings
##########################################################################
set CHIP        "hyperbus_synth_wrap"
set DESIGNNAME  ${CHIP}
set reportDir  reports
set savePrefix ${DESIGNNAME}

setMultiCpuUsage -localCpu 8
source scripts/custom_report.tcl

set REPDIR reports
set OUTDIR out
set SAVEDIR save

setLibraryUnit -time 1ps
setLibraryUnit -cap  1pf


###########################
##   INITIALIZE DESIGN   ##
###########################

source  src/hyper.globals
init_design

source scripts/supplies.tcl

report_analysis_views > reports/mmmc_view.rpt
set timing_report_group_based_mode true

setNanoRouteMode -reset
setNanoRouteMode -routeBottomRoutingLayer 2
setNanoRouteMode -routeTopRoutingLayer    8

setOptMode -timeDesignCompressReports false
setOptMode -usefulSkew true
setOptMode -usefulSkewPreCTS true
setOptMode -enableDataToDataChecks true

setUsefulSkewMode -maxSkew true
source scripts/encounter_route_options_DFM.tcl
setNanoRouteMode -routeBottomRoutingLayer 2
setNanoRouteMode -routeTopRoutingLayer 7
setNanoRouteMode -routeInsertAntennaDiode true
setNanoRouteMode -drouteFixAntenna true
setStreamOutMode -SEvianames true -specifyViaName %t_%v -virtualConnection false

# Disable area optimized cells which tend to create DRC violations.
setDontUse *_A_* true

## Specify the power intent.
free_power_intent
read_power_intent -cpf src/chip.cpf
commit_power_intent
write_power_intent -cpf hyper.cpf

###########################
##   FLOORPLAN           ##
###########################

suppressMessage IMPFP-7236  ;# Die corner not on grid

set margin_x0  0
set margin_y0  0
set margin_x1  177.94
set margin_y1  1640

set pad_width  42.016
set pad_height 42.0

set core_mg    18.4

set row_width  0.64

floorPlan -site SC8T_104CPP_CMOS22FDX -b \
    $margin_x0 $margin_y0 $margin_x1 $margin_y1 \
    $pad_width $pad_height [expr $margin_x1 - $pad_width ] [expr $margin_y1 - $pad_height ] \
    $core_mg   $core_mg [expr $margin_x1 - $pad_width - $core_mg ]  [expr $margin_y1 - $core_mg ]

loadIoFile -noAdjustDieSize src/hyper.io

addIoFiller -cell {IN22FDX_GPIO18_10M19S40PI_FILL20_H IN22FDX_GPIO18_10M19S40PI_FILL10_H IN22FDX_GPIO18_10M19S40PI_FILL5_H IN22FDX_GPIO18_10M19S40PI_FILL1_H} -side right -prefix fillperi

source scripts/add_pins.tcl

set rwds_delay_phy0 i_hyperbus_macro/i_phy/phy_wrap_phy_unroll_0__i_phy/i_trx/i_delay_rx_rwds_90/i_delay
set rwds_delay_phy1 i_hyperbus_macro/i_phy/phy_wrap_phy_unroll_1__i_phy/i_trx/i_delay_rx_rwds_90/i_delay
placeInstance -fixed  $rwds_delay_phy0 [expr $margin_x1 - 90.94] [expr $core_mg + ( $row_width * 1015 )  + 4 ] R0
placeInstance -fixed  $rwds_delay_phy1 [expr $margin_x1 - 90.94] [expr $core_mg + ( $row_width * 1484 )  + 11.84] R0
addHaloToBlock -fromInstBox  $row_width $row_width $row_width $row_width $rwds_delay_phy0
addHaloToBlock -fromInstBox  $row_width $row_width $row_width $row_width $rwds_delay_phy1

saveDesign  save/1_floorplan.enc

###########################
##   POWERGRID           ##
###########################

source scripts/power.tcl

# Ensure the padring-internal signals are not routed.
setAttribute -net i_hyperbus_macro/IOPWROK_S               -skip_routing true -skip_antenna_fix true
setAttribute -net i_hyperbus_macro/PWROK_S                 -skip_routing true -skip_antenna_fix true
setAttribute -net i_hyperbus_macro/BIAS_S                  -skip_routing true -skip_antenna_fix true
setAttribute -net i_hyperbus_macro/RETC_S                  -skip_routing true -skip_antenna_fix true

##########################################################################
#  Settings: WellTaps and TIE cells
##########################################################################

source scripts/special_cell_setting.tcl
set wellTap(name) "SC8T_TAPX8_CSC20L"
set_well_tap_mode -reset
set_well_tap_mode -cell $wellTap(name) -rule $wellTap(maxdis)
#WELL TAP and ENDCAP
addWellTap -cellInterval  25 -checkerBoard
addEndCap

##########################################################################
# Placement
##########################################################################
echo "================================================================================"
echo "= Placement                                                                    ="
echo "================================================================================"

setPlaceMode -place_global_cong_effort high \
             -place_global_timing_effort medium \
             -place_global_clock_gate_aware true \
             -place_global_ignore_scan true \
             -place_global_reorder_scan false \
             -place_global_place_io_pins false \
             -place_detail_color_aware_legal true \
             -place_detail_no_filler_without_implant true

setAnalysisMode -analysisType onChipVariation -cppr both

report_clocks                    >  reports/clocks_prePlace.rpt
report_clocks -uncertainty_table >> reports/clocks_prePlace.rpt

place_opt_design -out_dir reports/hyper_02_place_opt_design
checkPlace
addTieHiLo
saveDesign save/hyper_02_placed.enc

timeDesign -preCTS -expandedViews -outDir reports/hyper_02_timedesign_preCTS

##########################################################################
# CTS
##########################################################################
echo "================================================================================"
echo "= CTS                                                                          ="
echo "================================================================================"

#You have to generete this only the first time, then modify it according to your needs
#the modified file is scripts/pulp.ccopt.tcl
#create_ccopt_clock_tree_spec -file src/create_ccopt_clock_tree_spec.innovus.spec.tcl
create_ccopt_clock_tree_spec -file src/hyper.ccopt.tcl
source src/hyper.ccopt.tcl

ccopt_design -check_prerequisites
ccopt_design -expandedViews -outDir reports/hyper_03_ccopt_design

report_ccopt_clock_trees -filename reports/cts.clock_trees.rpt
report_ccopt_skew_groups -filename reports/cts.skew_groups.rpt

saveDesign -verilog save/4_postcts.enc

##########################################################################
# CTS
##########################################################################

echo "================================================================================"
echo "= Routing                                                                      ="
echo "================================================================================"

setNanoRouteMode -quiet -routeInsertAntennaDiode true
setNanoRouteMode -quiet -routeWithSiPostRouteFix false
setNanoRouteMode -quiet -routeWithTimingDriven   true
setNanoRouteMode -quiet -routeWithSiDriven       true
setNanoRouteMode -quiet -routeWithECO            true
#setNanoRouteMode -quiet -drouteOnGridOnly true
## Prevent router modifying M1 pins shapes
setNanoRouteMode -routeWithViaInPin "1:1"
setNanoRouteMode -routeWithViaOnlyForStandardCellPin "1:1"
## limit VIAs to ongrid only for VIA01 (V1)
setNanoRouteMode -drouteOnGridOnly "via 1:1 wire 1:2"

routeDesign -globalDetail

saveDesign save/hyper_top_04_routed.enc

timeDesign       -postRoute -expandedViews -outDir reports/hyper_04_timedesign_postRoute
timeDesign -hold -postRoute -expandedViews -outDir reports/hyper_04_timedesign_postRoute

report_clocks                    >  reports/clocks_postRoute.rpt
report_clocks -uncertainty_table >> reports/clocks_postRoute.rpt

setExtractRCMode -engine postRoute
setDelayCalMode -siAware true

optDesign -setup -hold -postRoute -expandedViews -outDir reports/hyper_04_optdesign_postRoute

saveDesign save/pulp_top_04_routed_opt.enc

##########################################################################
# chip finishing
##########################################################################
echo "================================================================================"
echo "= Chip finishing                                                               ="
echo "================================================================================"

#search and repair loop to fix remaining drc violations
setNanoRouteMode -routeWithECO true
setNanoRouteMode -drouteFixAntenna true
globalDetailRoute
saveDesign save/pulp_top_preFiller.enc

#Remove the Fence, otherwise you get problem with filler cells
setFillerMode -doDRC true
setFillerMode -ecoMode true
addFiller

verify_drc
ecoRoute -fix_drc

saveDesign save/hyperbus_top_addFiller.enc

setNanoRouteMode -droutePostRouteSwapVia multiCut
routeDesign -viaOpt

#do final timing analysis
timedesign -postRoute -expandedViews       -outDir reports/hyper_05_after_drc_fix 
timedesign -postRoute -expandedViews -hold -outDir reports/hyper_05_after_drc_fix 

optDesign -setup -hold -postRoute -expandedViews -outDir reports/hyper_05optdesign

verify_drc
ecoRoute -fix_drc

timedesign -postRoute -expandedViews       -outDir reports/timing -prefix hyper_final 
timedesign -postRoute -expandedViews -hold -outDir reports/timing -prefix hyper_final 

deleteRouteBlk -all
verify_drc -report reports/hyper.drc.rpt
verifyProcessAntenna -leffile reports/hyper.antenna.lef -reportfile reports/hyper.antenna.rpt
verifyWellTap -report  reports/hyper.wellTap.rpt

deleteEmptyModule

saveDesign save/hyper_top_final.enc

source scripts/hyper_exportall.tcl

source scripts/checkdesign.tcl

set ff    [all_registers]
set mems  [all_registers -macros ]
set icgs  [filter_collection [all_registers] "is_integrated_clock_gating_cell == true"]
set regs  [remove_from_collection [all_registers -edge_triggered] $icgs]

#Create Mem Path Groups
group_path   -name Reg2Mem      -from $regs -to $mems
group_path   -name Mem2Reg      -from $mems -to $regs
group_path   -name Mem2Mem      -from $mems -to $mems

#Create FF Path Groups
group_path   -name ff2ff        -from $ff -to $ff
group_path   -name reg2ff       -from $regs -to $ff
group_path   -name ff2reg       -from $ff -to $regs


timedesign -postRoute -expandedViews       -outDir reports/timing -prefix hyper_final_pathGroup
timedesign -postRoute -expandedViews -hold -outDir reports/timing -prefix hyper_final_pathGroup


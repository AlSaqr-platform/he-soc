##########################
##   PLACEMENT GUIDES   ##
##########################

set headBox [dbFPlanBox [dbHeadFPlan]]
set coreBox [dbFPlanCoreBox [dbHeadFPlan]]

set die_x0 [dbDBUToMicrons [lindex $headBox 0]]
set die_y0 [dbDBUToMicrons [lindex $headBox 1]]
set die_x1 [dbDBUToMicrons [lindex $headBox 2]]
set die_y1 [dbDBUToMicrons [lindex $headBox 3]]

#set core_x0 [dbDBUToMicrons [lindex $coreBox 0]]
#set core_y0 [dbDBUToMicrons [lindex $coreBox 1]]
#set core_x1 [dbDBUToMicrons [lindex $coreBox 2]]
#set core_y1 [dbDBUToMicrons [lindex $coreBox 3]]
set core_x0 5
set core_y0 5
set core_x1 350
set core_y1 1595


#############################
##   PREPARATORY CLEANUP   ##
#############################

deleteFiller -prefix ENDCAP
deleteFiller -prefix WELLTAP
unplaceAllBlocks
unplaceAllGuides
unplaceAllInsts
setInstancePlacementStatus -status unplaced -allHardMacros
deletePlaceBlockage -all
deleteRouteBlk -all
deleteHaloFromBlock -allBlock
deleteRow -all
dbForEachPowerDomain [dbgHead] ptr {
    deletePowerSwitch -column -powerDomain [dbGet $ptr.name]
}

################
##   GUIDES   ##
################

set hg 0.104 ;# horizontal grid
set vg 1.28  ;# vertical grid

set row_x0 $core_x0
set row_x1 [expr $core_x0 + ceil(($core_x0-46+110-$core_x0)/$hg)*$hg]
set row_x2 [expr $core_x0 + floor(($core_x1+46-110-$core_x0)/$hg)*$hg]
set row_x3 [expr $core_x0 + floor(($core_x1-$core_x0)/$hg)*$hg]

set row_y0 $core_y0
set row_y1 [expr $core_y0 + ceil(($core_y0-46+110-$core_y0)/$vg)*$vg]
set row_y2 [expr $core_y0 + floor(($core_y1-$core_y0+46-110)/$vg)*$vg]
set row_y3 [expr $core_y0 + floor(($core_y1-$core_y0)/$vg)*$vg]

#######################
##   POWER DOMAINS   ##
#######################

set place_blks {}

set PDTOPx0 $core_x0
set PDTOPx1 350
set PDTOPy0 1550
set PDTOPy1 $core_y1


setObjFPlanPolygon Group TOP [list \
    $PDTOPx0 $PDTOPy0 \
    $PDTOPx0 $PDTOPy1 \
    $PDTOPx1 $PDTOPy1 \
    $PDTOPx1 $PDTOPy0 \
]


deleteRow -all
# SC8T_104CPP_CMOS22FDX_4V
foreach site {SC8T_104CPP_CMOS22FDX SC8T_104CPP_CMOS22FDX_2G} shift {0 0} {
    # Cluster
    createRow -site $site -polygon [list \
        $PDTOPx0 $PDTOPy0 \
        $PDTOPx0 $PDTOPy1 \
        $PDTOPx1 $PDTOPy1 \
        $PDTOPx1 $PDTOPy0 \
    ]
}

foreach site {SC8T_104CPP_CMOS22FDX SC8T_104CPP_CMOS22FDX_2G} shift {0 0} {
    # Cluster
    createRow -site $site -polygon [list \
        $PDCLUSTERx0 $PDCLUSTERy0 \
        $PDCLUSTERx0 $PDCLUSTERy1 \
        $PDCLUSTERx1 $PDCLUSTERy1 \
        $PDCLUSTERx1 $PDCLUSTERy0 \
    ]
}


#################
##   ENDCAPS   ##
#################

checkFPlan
source scripts/special_cell_setting.tcl
set wellTap(name) "SC8T_TAPZBX8_CSC28L"
set wellTap(width) [dbGet [dbGetCellByName $wellTap(name)].size_x]
set wellTap(maxdis) [expr round(50 / $wellTap(width)) * $wellTap(width)]
set_well_tap_mode -reset
set_well_tap_mode -cell $wellTap(name) -rule [expr $wellTap(maxdis)/2] -bottom_tap_cell $endCapList(bottom) -top_tap_cell $endCapList(top)

deleteFiller -prefix ENDCAP
deleteFiller -prefix WELLTAP
dbForEachPowerDomain [dbgHead] ptr {
    set pd [dbGet $ptr.name]
    puts "Adding endcaps for $pd"
    addEndCap -prefix ENDCAP -powerDomain $pd
}



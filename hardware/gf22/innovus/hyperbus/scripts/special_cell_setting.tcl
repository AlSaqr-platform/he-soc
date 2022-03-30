###########################################################################
#  Title      : Setings for special cell
#  Project    : gf 22 dz flow
##########################################################################
#  File       : special_cell_setting.tcl
#  Author     : Beat Muheim  <muheim@ee.ethz.ch>
#  Company    : Microelectronics Design Center (DZ), ETH Zurich
##########################################################################
#  Description : Is doin the seting for the row end caps, well tap, tie cells
#                and filler cels. It is not inserting it this have to be don
#                in the run script.
#  Inputs      :
#  Outputs     : ($endCap)
#                ($wellTap)
#                ($tieCell)
#                ($fillerCellList)
#  Rhesuses    :
##########################################################################
#  Copyright (c) 2016 Microelectronics Design Center, ETH Zurich
##########################################################################
# v1.0 - <muheim@ee.ethz.ch> - Wed Feb 26 12:39:34 CET 2020
#  - for the library 2020.01
#  - take out the setting of the EndCap, if it is correct in the lef innovus
#    understand it and take the correct one.
#  - put checks if the script fount the cells.
#  - rearrange
# v0.9 - <muheim@ee.ethz.ch> - Mon Dec 10 13:39:37 CET 2018
#  - adding '_CSC*' in the filler parsing to avoid that the IO filler
#    also taken.
# v0.8 - <muheim@ee.ethz.ch> - Mon Dec 10 12:07:56 CET 2018
#  - fix for the 7.5T library
# v0.7 - <muheim@ee.ethz.ch> - Thu Nov 15 12:04:05 CET 2018
#  - the roul for the set_well_tap_mode  is hafe of the tap to tap distances
# v0.6 - <muheim@ee.ethz.ch> - Tue Nov 13 12:31:46 CET 2018
#  - tap to tap distances set to 50um
#     (RX_PP_junction not over HYBRID) maximum distance to the RX_p-well_contact within the same PW <= 40
#     (RX _NP_junction over HYBRID) not over EFUSE) maximum distance to the RX _p-well_ contact) (over PW) <= 25
#       it is the antenna diod
# v0.5 - <muheim@ee.ethz.ch> - Mon Nov  5 09:35:11 CET 2018
#  - make it also runing for 7.5T library
#  - tap to tap distances set to 70um
# v0.4 - <muheim@ee.ethz.ch> - Fri Apr 20 16:45:11 CEST 2018
#  - remuve set_well_tap_mode -avoidAbutment true
# v0.3 - <muheim@ee.ethz.ch> - Fri Nov 10 13:47:30 CET 2017
#  - end cap edge, the left was with the right side cells was swapped
#  - add set_well_tap_mode -avoidAbutment true
# v0.2 - <muheim@ee.ethz.ch> - Tue Jun 20 11:19:13 CEST 2017
#  - change the end Cap from X10 to X9
# v0.1 - <muheim@ee.ethz.ch> - Fri Mar 31 10:23:12 CEST 2017
#  - this is replaseng the setings in "physical_cell-insert.tcl",
#    "tiehilo.tcl" and "fillcore-insert.tcl"
##########################################################################
# To report endcap cells (specified as 'CLASS ENDCAP' in LEF) :
#set endCapList(left)   [dbGet [dbGet -p head.libCells.subclass coreEndCapPost].name]
#set endCapList(right)  [dbGet [dbGet -p head.libCells.subclass coreEndCapPre].name]
set endCapList(left)   [dbGet [dbGet -p head.libCells.subclass coreEndCapLeftEdge].name]
set endCapList(right)  [dbGet [dbGet -p head.libCells.subclass coreEndCapRightEdge].name]
set endCapList(top)    [dbGet [dbGet -p head.libCells.subclass coreEndCapTopEdge].name]
set endCapList(bottom) [dbGet [dbGet -p head.libCells.subclass coreEndCapBottomEdge].name]
set endCapList(top:left:edge)       [dbGet [dbGet -p head.libCells.subclass coreEndCapLeftTopEdge].name]
set endCapList(top:right:edge)      [dbGet [dbGet -p head.libCells.subclass coreEndCapRightTopEdge].name]
set endCapList(bottom:left:edge)    [dbGet [dbGet -p head.libCells.subclass coreEndCapLeftBottomEdge].name]
set endCapList(bottom:right:edge)   [dbGet [dbGet -p head.libCells.subclass coreEndCapRightBottomEdge].name]
set endCapList(top:left:corner)     [dbGet [dbGet -p head.libCells.subclass coreEndCapLeftTopCorner].name]
set endCapList(top:right:corner)    [dbGet [dbGet -p head.libCells.subclass coreEndCapRightTopCorner].name]
set endCapList(bottom:left:corner)  [dbGet [dbGet -p head.libCells.subclass coreEndCapLeftBottomCorner].name]
set endCapList(bottom:right:corner) [dbGet [dbGet -p head.libCells.subclass coreEndCapRightBottomCorner].name]


# To get names of well tap cells (specified as 'CLASS CORE WELLTAP ' in LEF)
set wellTapList(name)   [dbGet [dbGet -p head.libCells.subClass coreWellTap].name]
set wellTap(maxdis) 36

# _TAPX8_  have to be externel conected.
# _TAPZBX8_ will conect  PPLUS and NPLUS to VSS
foreach type [list "CSC20SL" "CSC20L" "CSC24SL" "CSC24L" "CSC28SL" "CSC28L" "CSC32SL" "CSC32L"  "CSC36SL" "CSC36L"] {
  if {0 <= [lsearch $wellTapList(name) "*_$type"]} {set wellTap(name)  [lsearch -inline $wellTapList(name) "*_TAPZBX8_$type"]}
}


# to get names of tie high / tie low cells (specified as 'CLASS CORE TIEHIGH' or 'CLASS CORE TIELOW' in LEF), use
set tieCellList(high) [dbGet [dbGet -p head.libCells.subClass coreTieHigh].name]
set tieCellList(low)  [dbGet [dbGet -p head.libCells.subClass coreTieLow].name]

foreach hl [list high low] {
  foreach type [list "*_CSC20SL" "*_CSC20L" "*_CSC24SL" "*_CSC24L" "*_CSC28SL" "*_CSC28L" "*_CSC32SL" "*_CSC32L"  "*_CSC36SL" "*_CSC36L"] {
    if {0 <= [lsearch $tieCellList($hl) $type]} {set tieCell($hl) [lsearch -inline $tieCellList($hl) $type]}
  }
}

set tieCell(high:low) [list $tieCell(high) $tieCell(low)]



set fillerCellList(empty) {}
set fillerCellList(decoup) {}
foreach cell [dbGet -p head.libCells.name *] {
  if [string match "*_FILL*_CSC*"  [dbGet ${cell}.name]]  { lappend fillerCellList(empty)  [dbGet ${cell}.name]}
  if [string match "*_DECAP*_CSC*" [dbGet ${cell}.name]]  { lappend fillerCellList(decoup) [dbGet ${cell}.name]}
}
#set fillerCellList(decoup) { SC8T_DECAPX9_CSC20L SC8T_DECAPX8_CSC20L SC8T_DECAPX5_CSC20L SC8T_DECAPX16_CSC20L SC8T_DECAPX9_CSC20SL SC8T_DECAPX8_CSC20SL SC8T_DECAPX5_CSC20SL SC8T_DECAPX16_CSC20S}

set fillerCellList(decoup:empty) [list $fillerCellList(decoup) $fillerCellList(empty)]


#-------------------------------------------------------------------------------
# make the setings

# set End Cap Cell
if { [llength $endCapList(left)] && [llength $endCapList(right)] && [llength $endCapList(top)] && [llength $endCapList(bottom)] } {
#  setEndCapMode -reset
#  setEndCapMode \
#    -bottomEdge           $endCapList(bottom) \
#    -topEdge              $endCapList(top) \
#    -rightBottomEdge      $endCapList(bottom:right:edge) \
#    -leftBottomEdge       $endCapList(bottom:left:edge) \
#    -rightTopEdge         $endCapList(top:right:edge) \
#    -leftTopEdge          $endCapList(top:left:edge) \
#    -leftBottomCorner     $endCapList(bottom:left:corner) \
#    -leftTopCorner        $endCapList(top:left:corner) \
#    -rightBottomCorner    $endCapList(bottom:right:corner) \
#    -rightTopCorner       $endCapList(top:right:corner) \
#    -rightEdge            $endCapList(right) \
#    -leftEdge             $endCapList(left)
#    # leftEdge means 'cell that has n-well cap on its left'
#    # rightEdge means 'cell that has n-well cap on its right'
#    # I think 'corner' and 'edge' other way around then expand
} else {
  puts "ERROR: find no End Cap Cell!"
  puts ""
}


# set Well Tap Cell
if {$wellTap(name) ne ""} {
  set_well_tap_mode -reset
  set_well_tap_mode -cell $wellTap(name) -rule [expr $wellTap(maxdis) / 2] -bottom_tap_cell $endCapList(bottom)  -top_tap_cell $endCapList(top)

  #set_well_tap_mode -avoidAbutment true
  # Davide Schiavone had god expirations with this option
} else {
  puts "ERROR: find no Well Tap Cell!"
  puts ""
}


# set tiehilo mode and insert the new cells
if [llength $tieCell(high:low) ] {
  setTieHiLoMode -reset
  setTieHiLoMode -maxFanout 12 -maxDistance 250 -createHierPort true \
                 -cell $tieCell(high:low)
  # -createHierPort true - try
} else {
  puts "ERROR: find no Tie Cell!"
  puts ""
}


# set filler
if [llength $fillerCellList(decoup:empty) ] {
  setFillerMode -reset
  setFillerMode -core $fillerCellList(decoup:empty)  -distribute_implant_evenly true -ecoMode true
} else {
  puts "ERROR: find no Filler Cell!"
  puts ""
}


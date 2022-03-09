###########################################################################
#  Title      : Export all relevant design data.
#  Project    : gf 22 dz flow
##########################################################################
#  File       : exportall.tcl
#  Author     : Beat Muheim  <muheim@ee.ethz.ch>
#  Company    : Microelectronics Design Center (DZ), ETH Zurich
##########################################################################
#  Description :
#  Inputs      : $DESIGNNAME
#  Outputs     : sdc, netlist, gds
#  Rhesuses    :
##########################################################################
#  Copyright (c) 2016 Microelectronics Design Center, ETH Zurich
##########################################################################
# v1.0 - <muheim@ee.ethz.ch> - Thu Feb 27 12:38:45 CET 2020
#  - adapt for the library 2020.01
#  - remove  -includePhysicalInst, add -exportTopPGNets on saveNetlist,
#    is needed from version 2019 on that saveNetlist is creating
#    power and ground ports on the top.
#      or create the ports with
#    createPGPin VDD
#    createPGPin VSS
# v0.7 - <muheim@ee.ethz.ch> - Thu Dec 21 14:09:46 CET 2017
#  - adding to the excludeCellInstList "SC8T_CONCAVE*"
# v0.6 - <muheim@ee.ethz.ch> - Tue Dec  5 10:38:50 CET 2017
#  - the VIAs will be writen out as top structure name and lef via name
# v0.5 - <muheim@ee.ethz.ch> - Wed Nov 29 15:15:02 CET 2017
#  - Use "22FDSOI_edi2gds_colored.layermap" for the gds export map
#    inste "22FDSOI_edi2gds_multicolor.layermap"
# v0.4 - <muheim@ee.ethz.ch> - Wed Sep 13 10:44:26 CEST 2017
#  - add -virtualConnection false to setStreamOutMode
#    to avoid appending a (:) to the pin label of power ground
# v0.3 - <muheim@ee.ethz.ch> - Tue Jun 27 08:30:42 CEST 2017
#  - add WA problems withe the sdf  and following cells:
#      IN22FDX_GPIO18_10M30P_SPVDDIO_V IN22FDX_GPIO18_10M30P_SPVDDIO_H
#  - remove '-remashold' on the write_sdf again
#  - add excludeCellInstList to exclude the emty cells for the lvs
#  - cahnge the layer map file to the multicolor version
# v0.2 - <muheim@ee.ethz.ch> - Wed May 18 09:16:46 CEST 2016
#  - add filter for bond pad, add commented out, save netlist for
#    simulation withe power connections
#    add -remashold to the write_sdf
# v0.1 - <muheim@ee.ethz.ch> - Tue Jan 19 11:03:35 CET 2016
#  - copy from gf28 v0.4
##########################################################################

set OUTDIR "out"
mkdir -p $OUTDIR

# is the design name specified ???
if { [ info exists DESIGNNAME ] } {
   set NAME "$DESIGNNAME"

} else {
    set NAME "final"

}

# get the names of cells to excluding in the lvs netlist
set excludeCellInstList {}
foreach cell [dbGet -p head.libCells.name *] {
  # filler cells without no decaps
  if [string match "*_FILL*"          [dbGet ${cell}.name]]  { lappend excludeCellInstList  [dbGet ${cell}.name]}
  # pad corner
  if [string match "*_CORNER"       [dbGet ${cell}.name]]  { lappend excludeCellInstList  [dbGet ${cell}.name]}

}

foreach type [list "coreEndCapTopEdge" "coreEndCapBottomEdge" \
                   "coreEndCapLeftTopEdge" "coreEndCapRightTopEdge" "coreEndCapLeftBottomEdge" "coreEndCapRightBottomEdge" \
                   "padSpacer"] {
  lappend excludeCellInstList  {*}[dbGet [dbGet -p head.libCells.subclass $type].name]

}


# RC will be extracted, if not ready don, using the
# Integrated QRC (IQRC) engine.
#setExtractRCMode -effortLevel high


# global variable for written the sdf checks checks correctly with a triple
set_global timing_recompute_sdf_in_setuphold_mode true
# Write out SDF, take the first analysis_views from the hold and the setup list
write_sdf -precision 4 -min_period_edges posedge -recompute_parallel_arcs -nonegchecks \
          -min_view [lindex [all_hold_analysis_views]  0] \
          -typ_view [lindex [all_setup_analysis_views] 0] \
          -max_view [lindex [all_setup_analysis_views] 0] \
          out/${NAME}.sdf.gz

# write lef
write_lef_abstract ${OUTDIR}/${NAME}.lef -stripePin -portForEachStripePin


# extract lib
set_analysis_view -setup hold_view -hold hold_view
do_extract_model -view hold_view ${OUTDIR}/${NAME}_FFG_0P88.lib

set_analysis_view -setup func_view -hold func_view
do_extract_model -view func_view ${OUTDIR}/${NAME}_TT_0P80.lib

set_analysis_view -setup setup_view -hold setup_view
do_extract_model -view setup_view ${OUTDIR}/${NAME}_SSG_0P72.lib

# This netlist do not contains the filler cells, physical cells.
# This can be used for simulation (normal/with power connections)
saveNetlist out/${NAME}.v -excludeLeafCell
#saveNetlist out/${NAME}_pwr.v -excludeLeafCell -excludeCellInst $excludeCellInstList -includePowerGround

# This netlist contains the filler cells withe decaps and the power, ground and bb netts.
# This have to be used for LVS
#saveNetlist out/${NAME}_lvs.v -excludeLeafCell -excludeCellInst $excludeCellInstList -exportTopPGNets -phys
saveNetlist out/${NAME}_lvs.v -excludeLeafCell -excludeCellInst $excludeCellInstList -phys


# layout
#setStreamOutMode -SEvianames ON -specifyViaName %t_VIA -virtualConnection false
setStreamOutMode -SEvianames true -specifyViaName %t_%v -virtualConnection false

# you can set an alternative top name with -structureName
# streamOut out/${NAME}.gds.gz -structureName sem01w0
# for design with a macro merged by cockpit
#streamOut out/${NAME}.gds.gz  -mapFile ../technology/22FDSOI_edi2gds_colored.layermap -outputMacros -merge {  \
#  /usr/pack/gf-22-kgf/dz/../gf/pdk-22FDX-EXT-V1.0_2.0/ChipKit/MetrologyCells/PCI/GDSII/TGPCI_10M_2Mx_5Cx_1Jx_2Qx_LB.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_BASE_CSC20SL_FDK_RELV06R40/gds/GF22FDX_SC8T_104CPP_BASE_CSC20SL.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_BASE_CSC20L_FDK_RELV06R40/gds/GF22FDX_SC8T_104CPP_BASE_CSC20L.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_BASE_CSC24SL_FDK_RELV06R40/gds/GF22FDX_SC8T_104CPP_BASE_CSC24SL.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_BASE_CSC24L_FDK_RELV06R40/gds/GF22FDX_SC8T_104CPP_BASE_CSC24L.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_BASE_CSC28SL_FDK_RELV06R40/gds/GF22FDX_SC8T_104CPP_BASE_CSC28SL.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_BASE_CSC28L_FDK_RELV06R40/gds/GF22FDX_SC8T_104CPP_BASE_CSC28L.gds \
#  /usr/pack/gf-22-kgf/invecas//std8t/2020.01/GF22FDX_SC8T_104CPP_SHIFT_CSL_FDK_RELV03R40/gds/GF22FDX_SC8T_104CPP_SHIFT_CSL.gds \
#  /usr/pack/gf-22-kgf/invecas/io/0M19S40PI_BE/gds/IN22FDX_GPIO18_10M19S40PI.gds \
#  /usr/pack/gf-22-kgf/invecas/std/2020.01/GF22FDX_SC8T_104CPP_HPK_CSL_FDK_RELV03R40/gds/GF22FDX_SC8T_104CPP_HPK_CSL.gds \ 
#  /usr/pack/gf-22-kgf/invecas/std/2020.01/GF22FDX_SC8T_104CPP_HPK_CSSL_FDK_RELV03R40/gds/GF22FDX_SC8T_104CPP_HPK_CSSL.gds \ 
#  /usr/pack/gf-22-kgf/invecas/std/2020.01/GF22FDX_SC8T_104CPP_LPK_CSL_FDK_RELV03R30/gds/GF22FDX_SC8T_104CPP_LPK_CSL.gds \
#  /usr/pack/gf-22-kgf/invecas/std/2020.01/GF22FDX_SC8T_104CPP_LPK_CSSL_FDK_RELV03R30/gds/GF22FDX_SC8T_104CPP_LPK_CSSL.gds \
#  ../technology/gds/generic_delay_D4_O1_3P750_CG0.gds.gz \
#  }

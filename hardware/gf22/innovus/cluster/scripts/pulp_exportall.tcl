##########################################################################
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

# is the design name specified ???
if { [ info exists DESIGNNAME ] } {
   set NAME "$DESIGNNAME"
} else {
    set NAME "final"
}

extractRC

rcOut -rc_corner rccCmaxDP_125C   -spef out/pulp.rccCmaxDP_125C.spef.gz
rcOut -rc_corner rccCminDP_125C   -spef out/pulp.rccCminDP_125C.spef.gz
rcOut -rc_corner rccRCmaxDP_125C  -spef out/pulp.rccRCmaxDP_125C.spef.gz
rcOut -rc_corner rccRCminDP_125C  -spef out/pulp.rccRCminDP_125C.spef.gz

rcOut -rc_corner rccCmaxDP_M40C   -spef out/pulp.rccCmaxDP_M40C.spef.gz
rcOut -rc_corner rccCminDP_M40C   -spef out/pulp.rccCminDP_M40C.spef.gz
rcOut -rc_corner rccRCmaxDP_M40C  -spef out/pulp.rccRCmaxDP_M40C.spef.gz
rcOut -rc_corner rccRCminDP_M40C  -spef out/pulp.rccRCminDP_M40C.spef.gz

rcOut -rc_corner rccnominal_025C  -spef out/pulp.rccnominal_025C.spef.gz

# get the names of cells to ecluding in the lvs netlist
set excludeCellInstList {}
foreach cell [dbGet -p head.libCells.name *] {
  if [string match "SC8T_FILL*"          [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "*30P_FILL*"          [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "SC8T*COLCAPPX1_CSC*" [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "SC8T_COLCAPNX1_CSC*" [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "*_CONCAVEPRX9_CSC*"  [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "*_CONCAVEPLX9_CSC*"  [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "*_CONCAVENRX9_CSC*"  [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
  if [string match "*_CONCAVENLX9_CSC*"  [dbGet ${cell}.name]]  { lappend excludeCellInstList [dbGet ${cell}.name]}
}
#lappend excludeCellInstList "IN22FDX_GPIO18_10M3S30P_CORNER"

# RC will be extracted, if not ready don, using the
# Integrated QRC (IQRC) engine.
#setExtractRCMode -effortLevel high
buildTimingGraph

# global variable for written the sdf checks checks correctly with a triple
set_global timing_recompute_sdf_in_setuphold_mode true
# Write out SDF, take the first analysis_views from the hold and the setup list
write_sdf -precision 4 -min_period_edges posedge -recompute_parallel_arcs -nonegchecks \
          -min_view hold_view \
          -max_view setup_view \
          out/pulp.sdf.gz

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
saveNetlist out/${NAME}_pwr.v -excludeLeafCell -excludeCellInst $excludeCellInstList -includePowerGround

# This netlist contains all filler cells and everything.
# This have to be used for LVS
saveNetlist out/${NAME}_lvs.v -excludeLeafCell -excludeCellInst $excludeCellInstList -includePhysicalInst -phys

# layout
setStreamOutMode -SEvianames ON -specifyViaName %t_VIA -virtualConnection false

# you can set an alternative top name with -structureName
# streamOut out/${NAME}.gds.gz -structureName sem01w0
# for design with a macro merged by cockpit
streamOut out/${NAME}.gds.gz  -mapFile ../technology/22FDSOI_edi2gds_colored.layermap -outputMacros -merge {  \
  /usr/pack/gf-22-kgf/invecas/std/V05R00/GF22FDX_SC8T_104CPP_BASE_CSC20SL/gds/GF22FDX_SC8T_104CPP_BASE_CSC20SL.gds \
  /usr/pack/gf-22-kgf/invecas/std/V05R00/GF22FDX_SC8T_104CPP_BASE_CSC20L/gds/GF22FDX_SC8T_104CPP_BASE_CSC20L.gds \
  /usr/pack/gf-22-kgf/invecas/std/V05R00/GF22FDX_SC8T_104CPP_BASE_CSC24SL/gds/GF22FDX_SC8T_104CPP_BASE_CSC24SL.gds \
  /usr/pack/gf-22-kgf/invecas/std/V05R00/GF22FDX_SC8T_104CPP_BASE_CSC24L/gds/GF22FDX_SC8T_104CPP_BASE_CSC24L.gds \
  /usr/pack/gf-22-kgf/invecas/std/V05R00/GF22FDX_SC8T_104CPP_BASE_CSC28SL/gds/GF22FDX_SC8T_104CPP_BASE_CSC28SL.gds \
  /usr/pack/gf-22-kgf/invecas/std/V05R00/GF22FDX_SC8T_104CPP_BASE_CSC28L/gds/GF22FDX_SC8T_104CPP_BASE_CSC28L.gds \
  /usr/pack/gf-22-kgf/invecas/std/V02R00/GF22FDX_SC8T_104CPP_LPK_CSL/gds/GF22FDX_SC8T_104CPP_LPK_CSL.gds \
  /usr/pack/gf-22-kgf/invecas/std/V02R00/GF22FDX_SC8T_104CPP_HPK_CSL/gds/GF22FDX_SC8T_104CPP_HPK_CSL.gds \
  /usr/pack/gf-22-kgf/invecas/io/V04R30/IN22FDX_GPIO18_10M3S30P_V0430/gds/IN22FDX_GPIO18_10M3S30P_V0430.gds \
  /usr/pack/gf-22-kgf/dz/mem/gds/IN22FDX_S1D_NFRG_W04096B032M04C128.gds \
  /usr/pack/gf-22-kgf/dz/mem/gds/IN22FDX_S1D_NFRG_W02048B032M04C128.gds \
  /usr/pack/gf-22-kgf/dz/mem/gds/IN22FDX_ROMI_FRG_W02048B032M32C064_boot_code.gds \
  ../../fe/ips/gf22_FLL/deliverable/GDS/gf22_FLL.gds \
  }

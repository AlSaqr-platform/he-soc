##########################################################################
#  place RAM macros
##########################################################################

set tcdmHM0  gen_tcdm_banks_0__i_tc_sram/u__tmp432/cut_0
set tcdmHM1  gen_tcdm_banks_1__i_tc_sram/u__tmp432/cut_0
set tcdmHM2  gen_tcdm_banks_2__i_tc_sram/u__tmp432/cut_0
set tcdmHM3  gen_tcdm_banks_3__i_tc_sram/u__tmp432/cut_0
set tcdmHM4  gen_tcdm_banks_4__i_tc_sram/u__tmp432/cut_0
set tcdmHM5  gen_tcdm_banks_5__i_tc_sram/u__tmp432/cut_0
set tcdmHM6  gen_tcdm_banks_6__i_tc_sram/u__tmp432/cut_0
set tcdmHM7  gen_tcdm_banks_7__i_tc_sram/u__tmp432/cut_0
set tcdmHM8  gen_tcdm_banks_8__i_tc_sram/u__tmp432/cut_0
set tcdmHM9  gen_tcdm_banks_9__i_tc_sram/u__tmp432/cut_0
set tcdmHM10 gen_tcdm_banks_10__i_tc_sram/u__tmp432/cut_0
set tcdmHM11 gen_tcdm_banks_11__i_tc_sram/u__tmp432/cut_0
set tcdmHM12 gen_tcdm_banks_12__i_tc_sram/u__tmp432/cut_0
set tcdmHM13 gen_tcdm_banks_13__i_tc_sram/u__tmp432/cut_0
set tcdmHM14 gen_tcdm_banks_14__i_tc_sram/u__tmp432/cut_0
set tcdmHM15 gen_tcdm_banks_15__i_tc_sram/u__tmp432/cut_0

set haloBlock     2.50
set routingBlock [expr $haloBlock + 0.155]

#same for all the Inteleaved cuts
set RamSize      [dbCellDim [dbInstCellName [dbGetInstByName $tcdmHM0 ]]]

set RamSize_W [expr [lindex $RamSize 0] /1000 ]
set RamSize_H [expr [lindex $RamSize 1] /1000 ]

set sram_initX             2.22
set sram_initY             2.22
set sram_delta_y           1.65
set sram_delta_x           1.65

# TCDM


set Xleft [expr $floorW - $floorMargin - $haloBlock - $RamSize_W - 0.206 ]

set X $Xleft
set Y $sram_initY


placeInstance -fixed  $tcdmHM0 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM0

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM1 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM1

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM2 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM2

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM3 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM3

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM4 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM4

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM5 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM5

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM6 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM6

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM7 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM7

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM8 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM8

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM9 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM9

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM10 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM10

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM11 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM11

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM12 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM12

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM13 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM13

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM14 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM14

set Y [expr $Y+$RamSize_H+$sram_delta_y]
placeInstance -fixed  $tcdmHM15 $X $Y R180
addHaloToBlock -fromInstBox  $haloBlock $haloBlock $haloBlock $haloBlock $tcdmHM15

redraw

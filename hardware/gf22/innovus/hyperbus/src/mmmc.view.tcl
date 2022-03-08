#########################################################################
#  Title       : Sample to setup the MMMC view definition file.
#  Project     : gf 22 dz flow
##########################################################################
#  File        : mmmc.view.tcl
#  Author      : Beat Muheim  <muheim@ee.ethz.ch>
#  Company     : Microelectronics Design Center (DZ), ETH Zurich
##########################################################################
#  Description : 
#    There are 4 files in this fictional MMMC (multi-mode multi-corner)
#    analysis setup:
#      - src/sample/mmmc_shared.sdc        SDC file with common constraints
#      - src/sample/mmmc_functional.sdc    Functional mode constraints
#      - src/sample/mmmc_test.sdc          Test mode constraints
#                                          (also used for hold timing analysis)
#      - src/sample/mmmc.view.tcl          Sample TCL file that can be adapted
#
#    Please note these are just for reference, adapt according to your design!
#
##########################################################################
#  Copyright (c) 2016 Microelectronics Design Center, ETH Zurich
##########################################################################
# v0.3  - bm - Tue Nov 21 10:13:37 CET 2017
#  - corect mane for the update_delay_corner typical_delay
# v0.2  - bm - Fri Mar 18 08:41:33 CET 2016
#  - rename 'PD_default' to 'PD_core' amd add 'PD_pad'
# v0.1  - bm - Tue Jan 19 13:14:48 CET 2016
#  - copy from gf28 v0.4 and adapt 
##########################################################################

#################################################################
## INITIALIZATION
#################################################################

## Three delay calculation corners are defined here typical, best, worst
## the long command parses the 
create_library_set -name typical_libs \
                   -timing [ list \
            ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC20SL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC20L_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC24SL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC24L_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC28SL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC28L_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_SHIFT_CSL_TT_0P80V_0P80V_0P00V_0P00V_0P00V_25C.lib.gz \
            ../../technology/lib/GF22FDX_SC8T_104CPP_LPK_CSL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz   \
            ../../technology/lib/GF22FDX_SC8T_104CPP_LPK_CSSL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz  \
            ../../technology/lib/GF22FDX_SC8T_104CPP_HPK_CSL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz   \
            ../../technology/lib/GF22FDX_SC8T_104CPP_HPK_CSSL_TT_0P80V_0P00V_0P00V_0P00V_25C.lib.gz  \
            ../../technology/lib/IN22FDX_GPIO18_10M19S40PI_TT_0P8_1P5_85.lib \
            ../../technology/lib/generic_delay_D4_O1_3P750_CG0_TT_0P80.lib \
                            ]

create_library_set -name best_libs \
                   -timing [ list \
            ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC20SL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC20L_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC24SL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC24L_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC28SL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC28L_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_SHIFT_CSL_FFG_0P88V_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
            ../../technology/lib/GF22FDX_SC8T_104CPP_LPK_CSL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
            ../../technology/lib/GF22FDX_SC8T_104CPP_LPK_CSSL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz\
            ../../technology/lib/GF22FDX_SC8T_104CPP_HPK_CSL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz \
            ../../technology/lib/GF22FDX_SC8T_104CPP_HPK_CSSL_FFG_0P88V_0P00V_0P00V_0P00V_125C.lib.gz\
            ../../technology/lib/IN22FDX_GPIO18_10M19S40PI_FFG_0P88_1P98_125.lib \
            ../../technology/lib/generic_delay_D4_O1_3P750_CG0_FFG_0P88.lib \
                            ]
create_library_set -name worst_libs \
                   -timing [ list \
            ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC20SL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC20L_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC24SL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC24L_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC28SL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_BASE_CSC28L_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
			      ../../technology/lib/GF22FDX_SC8T_104CPP_SHIFT_CSL_SSG_0P72V_0P72V_0P00V_0P00V_0P00V_125C.lib.gz \
            ../../technology/lib/GF22FDX_SC8T_104CPP_LPK_CSL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz   \
            ../../technology/lib/GF22FDX_SC8T_104CPP_LPK_CSSL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz  \
            ../../technology/lib/GF22FDX_SC8T_104CPP_HPK_CSL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
            ../../technology/lib/GF22FDX_SC8T_104CPP_HPK_CSSL_SSG_0P72V_0P00V_0P00V_0P00V_M40C.lib.gz \
            ../../technology/lib/IN22FDX_GPIO18_10M19S40PI_SSG_0P72_1P08_M40.lib \
            ../../technology/lib/generic_delay_D4_O1_3P750_CG0_SSG_0P72.lib \
                            ]

# RC corners
create_rc_corner -name typical_rc -qx_tech_file ../../technology/qrc/qrcTechFile_nominal
create_rc_corner -name best_rc    -qx_tech_file ../../technology/qrc/qrcTechFile_FuncCminDP
create_rc_corner -name worst_rc   -qx_tech_file ../../technology/qrc/qrcTechFile_FuncCmaxDP


## Three delay corners are defined here
create_delay_corner -name typical_delay -library_set typical_libs -rc_corner typical_rc
create_delay_corner -name best_delay    -library_set best_libs    -rc_corner best_rc
create_delay_corner -name worst_delay   -library_set worst_libs   -rc_corner worst_rc

update_delay_corner -name typical_delay -library_set typical_libs -rc_corner typical_rc -power_domain PD_core
update_delay_corner -name best_delay    -library_set best_libs    -rc_corner best_rc    -power_domain PD_core
update_delay_corner -name worst_delay   -library_set worst_libs   -rc_corner worst_rc   -power_domain PD_core

update_delay_corner -name typical_delay -library_set typical_libs -rc_corner typical_rc -power_domain PD_pad
update_delay_corner -name best_delay    -library_set best_libs    -rc_corner best_rc    -power_domain PD_pad
update_delay_corner -name worst_delay   -library_set worst_libs   -rc_corner worst_rc   -power_domain PD_pad

#update_delay_corner -name typical_delay -library_set typical_libs -rc_corner typical_rc -power_domain PD_cluster
#update_delay_corner -name best_delay    -library_set best_libs    -rc_corner best_rc    -power_domain PD_cluster
#update_delay_corner -name worst_delay   -library_set worst_libs   -rc_corner worst_rc   -power_domain PD_cluster

#################################################################
## LOAD CONSTRAINTS
#################################################################

## Here the SDC files that are part of MMMC flow are defined. 
## In this fictional example we have three modes 
##  1) functional: standard mode where the chip is functioning normally,
##                 timing paths from test inputs are disabled
##  2) test      : works with a slower clock, timing paths from test 
##                 inputs are enabled
##  3) hold      : Timing mode to check hold violations covers both cases.
##
## Each of the above mode will have their own constraints defined in a 
## separate SDC file. IN addition, there is a mmmc_shared.sdc that contains
## constraints that are common between two modes. These are just examples, 
## adjust according to your own requirements
##
create_constraint_mode -name func_mode -sdc_files [list src/constraints.sdc ]   

## now we create a view that combined the MODE with the CORNER
## hence the name Multi MODE multi CORNER.
##
## This example uses three views:
##
create_analysis_view -name func_view  -delay_corner typical_delay -constraint_mode func_mode
create_analysis_view -name setup_view -delay_corner worst_delay   -constraint_mode func_mode
create_analysis_view -name hold_view  -delay_corner best_delay    -constraint_mode func_mode

#################################################################
## SET ANALYSIS VIEWS
#################################################################

## This command determines which VIEWS will be used for analysis. In this
## example we use both 'functional' and 'test_mode' when doing setup analysis
## and we use only the 'hold' view when doing hold analysis. 

set_analysis_view -setup { func_view setup_view } \
                  -hold  { hold_view }
                  
## *IMPORTANT* It is actually possible that due to the differences in modelling,
##             for some circuits it could actually be possible that hold violations
##             can occur for 'typical' or 'worst' timing. We would advise to create
##             hold views with three different delay corners, just to make sure that this
##             is not the case. 
                  
                  
## The MMMC will affect the way some of the commands are going to work:
## use:
##   timeDesign -expandedViews
## to get separate reports for each view
                  

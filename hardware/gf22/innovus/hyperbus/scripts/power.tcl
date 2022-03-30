##########################
##   RESET EVERYTHING   ##
##########################

deleteAllPowerPreroutes
deleteRouteBlk -all
editPowerVia -delete_vias true
setAddRingMode -reset
setSrouteMode -reset

setAddStripeMode -reset
setAddStripeMode \
    -use_fgc 0 \
    -skip_via_on_pin {} \
    -allow_jog none \
    -allow_nonpreferred_dir none \
    -extend_to_closest_target none \
    -stacked_via_bottom_layer M1 \
    -stacked_via_top_layer M1

setViaGenMode -reset
setViaGenMode \
    -use_fgc 0

##################
##   IO RINGS   ##
##################

addRing -nets {VDD VSS} -type core_rings -follow core -layer {top JA bottom JA left C5 right C5} -width {top 4.1 bottom 4.1 left 4.1 right 4.1} -spacing {top 1.35 bottom 1.35 left 1.35 right 1.35} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None
addRing -nets {VDD VSS} -type core_rings -follow core -layer {top C4 bottom C4 left C3 right C3} -width {top 4.1 bottom 4.1 left 4.1 right 4.1} -spacing {top 1.35 bottom 1.35 left 1.35 right 1.35} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 1 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid None

# Block routing on padframe
createRouteBlk -box [expr $margin_x1 - 42 ]  0 $margin_x1 $margin_y1 -layer all -cutLayer all

##########################################################################
#  RING PAD CONNECTION
##########################################################################

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VDD -layer JA -direction horizontal -width 1.7 -spacing 0.45 -set_to_set_distance 7 -area {120 802.4 135 845} -start_from bottom -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VSS -layer JA -direction horizontal -width 1.7 -spacing 0.45 -set_to_set_distance 7 -area {125 854 135 890} -start_from bottom -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

##########################################################################
#  VSS
##########################################################################

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VSS -layer C4 -direction horizontal -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from bottom -start 7 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VSS -layer C5 -direction vertical -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from left -start 7 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VSS -layer C2 -direction horizontal -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from bottom -start 7 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VSS -layer C3 -direction vertical -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from left -start 7 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VSS -layer C1 -direction vertical -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from left -start 7 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

##########################################################################
#  VDD
##########################################################################

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VDD -layer C4 -direction horizontal -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from bottom -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VDD -layer C5 -direction vertical -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from left -start 0 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VDD -layer C2 -direction horizontal -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from bottom -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VDD -layer C3 -direction vertical -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from left -start 0 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

setAddStripeMode -ignore_block_check false -break_at none -route_over_rows_only false -rows_without_stripes_only false -extend_to_closest_target none -stop_at_last_wire_for_area false -partial_set_thru_domain false -ignore_nondefault_domains false -trim_antenna_back_to_shape none -spacing_type edge_to_edge -spacing_from_block 0 -stripe_min_length stripe_width -stacked_via_top_layer LB -stacked_via_bottom_layer M1 -via_using_exact_crossover_size false -split_vias false -orthogonal_only true -allow_jog { padcore_ring  block_ring } -skip_via_on_pin {  standardcell } -skip_via_on_wire_shape {  noshape   }
addStripe -nets VDD -layer C1 -direction vertical -width 1.7 -spacing 0.45 -set_to_set_distance 14 -start_from left -start 0 -switch_layer_over_obs false -max_same_layer_jog_length 2 -padcore_ring_top_layer_limit LB -padcore_ring_bottom_layer_limit M1 -block_ring_top_layer_limit LB -block_ring_bottom_layer_limit M1 -use_wire_group 0 -snap_wire_center_to_grid None

##########################################################################
#  LOWER LEVELS
##########################################################################

sroute -connect { corePin } \
       -allowLayerChange 1 \
       -allowJogging 1 \
       -layerChangeRange { M1 C5 } \
       -powerDomains { PD_core } -stripeSCpinTarget none \
       -crossoverViaLayerRange { M1 C5 } \
       -nets { VDD VSS }

verifyConnectivity \
    -net  VDD  \
    -geomConnect \
    -noUnroutedNet \
    -noAntenna \
    -useVirtualConnection \
    -allPGPinPort \
    -error 100000 \
    -report $REPDIR/power.connectivity.vdds.rpt
verifyConnectivity \
    -net VSS \
    -geomConnect \
    -noUnroutedNet \
    -noAntenna \
    -useVirtualConnection \
    -allPGPinPort \
    -error 100000 \
    -report $REPDIR/power.connectivity.vss.rpt


create_constraint_mode -name func_mode \
            -sdc_files [list src/constraints/PostRoute/constraints_mode0.sdc \
                       ]

# Specify analysis views to use
set_analysis_view -setup { func_view setup_view hold_view } \
                  -hold  { func_view setup_view hold_view }
set_analysis_view -update_timing

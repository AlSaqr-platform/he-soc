# FLL0 CLOCK: 800 MHz
set CVA6_C_Period                 1250
set CVA6_C_Latency_Max            500
set CVA6_C_Latency_Min            500
set CVA6_C_Uncertainty            100

#############################
### FLL CLOCKS DEFINITION ###
#############################
create_clock -name FLL_CVA6_CLK -period      $CVA6_C_Period      [get_ports clk_i]
set_ideal_network                                                [get_ports clk_i]
set_dont_touch_network                                           [get_ports clk_i]
set_clock_uncertainty                       $CVA6_C_Uncertainty  [get_clocks FLL_CVA6_CLK]
set_clock_transition                        100                  [get_clocks FLL_CVA6_CLK]
set_clock_latency -max                      $CVA6_C_Latency_Max  [get_clocks FLL_CVA6_CLK]
set_clock_latency -min                      $CVA6_C_Latency_Min  [get_clocks FLL_CVA6_CLK]

set output_ports {data_*_o*}
set_output_delay 500 -clock FLL_CVA6_CLK  [get_ports $output_ports]

set input_ports {data_*_i*}
set_input_delay 500 -clock FLL_CVA6_CLK  [get_ports $input_ports] 
set_false_path -hold -through [get_ports $input_ports] -through [get_ports $input_ports]





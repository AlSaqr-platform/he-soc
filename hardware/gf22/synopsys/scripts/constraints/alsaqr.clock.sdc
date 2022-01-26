# REF CLOCK: 10 MHz, actually 32 KHz
set REF_C_Period                 100000.0
set REF_C_Latency_Max            1000
set REF_C_Latency_Min            500
set REF_C_Uncertainty            500

# FLL0 CLOCK: 444 MHz
set CVA6_C_Period                 2250
set CVA6_C_Latency_Max            500
set CVA6_C_Latency_Min            500
set CVA6_C_Uncertainty            100

# FLL1 CLOCK: 444 MHz
set SOC_C_Period                 2250
set SOC_C_Latency_Max            500
set SOC_C_Latency_Min            500
set SOC_C_Uncertainty            100

# FLL2 CLOCK: 320 MHz
set PER_C_Period                 3125
set PER_C_Latency_Max            500
set PER_C_Latency_Min            500
set PER_C_Uncertainty            100

# FLL3 CLOCK: 500 MHz
set CLUSTER_C_Period             2000
set CLUSTER_C_Latency_Max        500
set CLUSTER_C_Latency_Min        500
set CLUSTER_C_Uncertainty        100

# JTAG:       20 MHz
set JTAG_C_Period                50000
set JTAG_C_Latency_Max           1000
set JTAG_C_Latency_Min           500
set JTAG_C_Uncertainty           100

# RWDS:       200 MHz
set RWDS_C_Period                5000
set RWDS_C_Latency_Max           1000
set RWDS_C_Latency_Min           500
set RWDS_C_Uncertainty           100

#############################
### PAD CLOCKS DEFINITION ###
#############################

# REF CLOCK
create_clock -name REF_CLK   -period      $REF_C_Period      [get_ports rtc_i]
set_ideal_network                                            [get_ports rtc_i]
set_dont_touch_network                                       [get_ports rtc_i]
set_clock_uncertainty                     $REF_C_Uncertainty [get_clocks REF_CLK]
set_clock_transition                      100                [get_clocks REF_CLK]
set_clock_latency -max                    $REF_C_Latency_Max [get_clocks REF_CLK]
set_clock_latency -min                    $REF_C_Latency_Min [get_clocks REF_CLK]

# JTAG CLK
create_clock -period $JTAG_C_Period -name JTAG_CLK [get_ports jtag_TCK]
set_ideal_network                                  [get_ports jtag_TCK]
set_dont_touch_network                             [get_ports jtag_TCK]
set_clock_uncertainty   $JTAG_C_Uncertainty        [get_clocks JTAG_CLK]
set_clock_transition    100                        [get_clocks JTAG_CLK]
set_clock_latency -max  $JTAG_C_Latency_Max        [get_clocks JTAG_CLK]
set_clock_latency -min  $JTAG_C_Latency_Min        [get_clocks JTAG_CLK]



#############################
### FLL CLOCKS DEFINITION ###
#############################
create_clock -name FLL_CLUSTER_CLK -period  $CLUSTER_C_Period      [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[3]]
set_ideal_network                                                  [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[3]]
set_dont_touch_network                                             [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[3]]
set_clock_uncertainty                       $CLUSTER_C_Uncertainty [get_clocks FLL_CLUSTER_CLK]
set_clock_transition                        100                    [get_clocks FLL_CLUSTER_CLK]
set_clock_latency -max                      $CLUSTER_C_Latency_Max [get_clocks FLL_CLUSTER_CLK]
set_clock_latency -min                      $CLUSTER_C_Latency_Min [get_clocks FLL_CLUSTER_CLK]

create_clock -name FLL_SOC_CLK -period      $SOC_C_Period      [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[1]]
set_ideal_network                                              [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[1]]
set_dont_touch_network                                         [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[1]]
set_clock_uncertainty                       $SOC_C_Uncertainty [get_clocks FLL_SOC_CLK]
set_clock_transition                        100                [get_clocks FLL_SOC_CLK]
set_clock_latency -max                      $SOC_C_Latency_Max [get_clocks FLL_SOC_CLK]
set_clock_latency -min                      $SOC_C_Latency_Min [get_clocks FLL_SOC_CLK]

create_clock -name FLL_CVA6_CLK -period      $CVA6_C_Period      [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[0]]
set_ideal_network                                                [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[0]]
set_dont_touch_network                                           [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[0]]
set_clock_uncertainty                       $CVA6_C_Uncertainty  [get_clocks FLL_CVA6_CLK]
set_clock_transition                        100                  [get_clocks FLL_CVA6_CLK]
set_clock_latency -max                      $CVA6_C_Latency_Max  [get_clocks FLL_CVA6_CLK]
set_clock_latency -min                      $CVA6_C_Latency_Min  [get_clocks FLL_CVA6_CLK]

create_clock -name FLL_PER_CLK -period      $PER_C_Period      [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[2]]
set_ideal_network                                              [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[2]]
set_dont_touch_network                                         [get_pins i_host_domain/i_apb_subsystem/i_alsaqr_clk_rst_gen/i_gf22_fll/OUTCLK[2]]
set_clock_uncertainty                       $PER_C_Uncertainty [get_clocks FLL_PER_CLK]
set_clock_transition                        100                [get_clocks FLL_PER_CLK]
set_clock_latency -max                      $PER_C_Latency_Max [get_clocks FLL_PER_CLK]
set_clock_latency -min                      $PER_C_Latency_Min [get_clocks FLL_PER_CLK]




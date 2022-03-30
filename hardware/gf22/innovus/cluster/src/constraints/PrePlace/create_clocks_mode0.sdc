# BOUNDARY CONDITIONS

set_driving_cell -lib_cell SC8T_BUFX6_CSC20L  -pin Z -from_pin A [ all_inputs  ]
set_load                                                     0.1 [ all_outputs ]

# CLOCK

set CLK_PERIOD        2500
set REF_CLK_PERIOD    100000

create_clock -period $CLK_PERIOD -name CLUSTER_CLK [ get_ports clk_i        ]
set_clock_uncertainty   500                        [ get_clocks CLUSTER_CLK ]
set_clock_transition    200                        [ get_clocks CLUSTER_CLK ]

create_clock -period $REF_CLK_PERIOD  -name REF_CLK  [ get_ports  ref_clk_i ]
set_clock_uncertainty   500                          [ get_clocks REF_CLK   ]
set_clock_transition    200                          [ get_clocks REF_CLK   ]

set_clock_groups -asynchronous -group REF_CLK
set_clock_groups -asynchronous -group CLUSTER_CLK

# IDEAL AND DONT TOUCH NETWORKS

set_ideal_network       [get_ports  rst_ni]
set_ideal_network       [get_ports  clk_i ]
set_ideal_network       [get_ports  ref_clk_i]
set_ideal_network       [get_ports  test_mode_i]

set_ideal_network       [get_pins rstgen_i/i_rstgen_bypass/rst_no]

set_dont_touch_network  [get_ports  rst_ni]
set_dont_touch_network  [get_ports  clk_i ]
set_dont_touch_network  [get_ports  ref_clk_i]
set_dont_touch_network  [get_ports  test_mode_i]

set_dont_touch_network  [get_pins rstgen_i/i_rstgen_bypass/rst_no]

# RESET

set_false_path -through [get_pins rstgen_i/i_rstgen_bypass/rst_no]



# REGISTER FILE

set_multicycle_path 2 -setup -through [get_pins CORE_*__core_region_i/RISCV_CORE/id_stage_i/registers_i/riscv_register_file_i/mem_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins CORE_*__core_region_i/RISCV_CORE/id_stage_i/registers_i/riscv_register_file_i/mem_reg*/Q]

# ICACHE PRIVATE
# DATA BANK
set_multicycle_path 2 -setup -through [get_pins icache_top_i/PRI_ICACHE_*__i_pri_icache/u_DATA_WAY__*__DATA_BANK/register_file_1r_1w_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins icache_top_i/PRI_ICACHE_*__i_pri_icache/u_DATA_WAY__*__DATA_BANK/register_file_1r_1w_i/MemContentxDP_reg*/Q]

# TAG BANK
set_multicycle_path 2 -setup -through [get_pins icache_top_i/PRI_ICACHE_*__i_pri_icache/u_TAG_WAY__*__TAG_BANK/register_file_1w_multi_port_read_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins icache_top_i/PRI_ICACHE_*__i_pri_icache/u_TAG_WAY__*__TAG_BANK/register_file_1w_multi_port_read_i/MemContentxDP_reg*/Q]

# ICACHE SHARED
# DATA BANK
set_multicycle_path 2 -setup -through [get_pins icache_top_i/Main_Icache_*__i_main_shared_icache/DATA_RAM_WAY_*__DATA_RAM/scm_data/register_file_1r_1w_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins icache_top_i/Main_Icache_*__i_main_shared_icache/DATA_RAM_WAY_*__DATA_RAM/scm_data/register_file_1r_1w_i/MemContentxDP_reg*/Q]

# TAG BANK
set_multicycle_path 2 -setup -through [get_pins icache_top_i/Main_Icache_*__i_main_shared_icache/TAG_RAM_WAY_*__TAG_RAM/scm_tag/register_file_1r_1w_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins icache_top_i/Main_Icache_*__i_main_shared_icache/TAG_RAM_WAY_*__TAG_RAM/scm_tag/register_file_1r_1w_i/MemContentxDP_reg*/Q]

set_false_path -from [all_inputs]
set_false_path -to   [all_outputs]

set output_ports {async_data_*_o*}
set_output_delay 500 -clock CLUSTER_CLK  [get_ports $output_ports]

set input_ports {async_data_*_i*}
set_input_delay 500 -clock CLUSTER_CLK  [get_ports $input_ports] 
set_false_path -hold -through [get_ports $input_ports] -through [get_ports $input_ports]

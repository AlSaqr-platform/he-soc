# REGISTER FILE MULTICYCLE PATHS
set_ideal_network [ get_ports jtag_TCK]
set_ideal_network [ get_ports jtag_TRSTn]
set_ideal_network [ get_ports rst_ni]
set_ideal_network [ get_ports rtc_i]
#
set_dont_touch_network [ get_ports i_host_domain/jtag_TCK]
set_dont_touch_network [ get_ports i_host_domain/jtag_TRSTn]
set_dont_touch_network [ get_ports i_host_domain/rst_ni]
set_dont_touch_network [ get_ports i_host_domain/rtc_i]
#
# CLUSTER REGISTER FILE IS DONE WITH LATCHES
set_multicycle_path 2 -setup -through [get_pins cluster_i/CORE[*].core_region_i/CL_CORE.RISCV_CORE/id_stage_i/registers_i/riscv_register_file_i/mem_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins cluster_i/CORE[*].core_region_i/CL_CORE.RISCV_CORE/id_stage_i/registers_i/riscv_register_file_i/mem_reg*/Q]

# ICACHE PRIVATE
# DATA BANK
set_multicycle_path 2 -setup -through [get_pins cluster_i/icache_top_i/PRI_ICACHE[*].i_pri_icache/_DATA_WAY_[*].DATA_BANK/register_file_1r_1w_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins cluster_i/icache_top_i/PRI_ICACHE[*].i_pri_icache/_DATA_WAY_[*].DATA_BANK/register_file_1r_1w_i/MemContentxDP_reg*/Q]

# TAG BANK
set_multicycle_path 2 -setup -through [get_pins cluster_i/icache_top_i/PRI_ICACHE[*].i_pri_icache/_TAG_WAY_[*].TAG_BANK/register_file_1w_multi_port_read_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins cluster_i/icache_top_i/PRI_ICACHE[*].i_pri_icache/_TAG_WAY_[*].TAG_BANK/register_file_1w_multi_port_read_i/MemContentxDP_reg*/Q]

# ICACHE SHARED
# DATA BANK
set_multicycle_path 2 -setup -through [get_pins cluster_i/icache_top_i/Main_Icache[*].i_main_shared_icache/DATA_RAM_WAY[*].DATA_RAM/scm_data/register_file_1r_1w_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins cluster_i/icache_top_i/Main_Icache[*].i_main_shared_icache/DATA_RAM_WAY[*].DATA_RAM/scm_data/register_file_1r_1w_i/MemContentxDP_reg*/Q]

# TAG BANK
set_multicycle_path 2 -setup -through [get_pins cluster_i/icache_top_i/Main_Icache[*].i_main_shared_icache/TAG_RAM_WAY[*].TAG_RAM/scm_tag/register_file_1r_1w_i/MemContentxDP_reg*/Q]
set_multicycle_path 1 -hold  -through [get_pins cluster_i/icache_top_i/Main_Icache[*].i_main_shared_icache/TAG_RAM_WAY[*].TAG_RAM/scm_tag/register_file_1r_1w_i/MemContentxDP_reg*/Q]

## CLOCK DOMAIN CROSSING
# those constraints gets automatically applied on all the rtl modules that require no ungrouping and that have asynch paths (e.g. in between CDCs fifos)
# attributes need to be specified directly in the RTL and "hdlin_sv_enable_rtl_attributes" must be set to true with the following 
# command <set_app_var hdlin_sv_enable_rtl_attributes true>
set_ungroup [get_designs -filter no_ungroup] false
set_ungroup [get_cells -hierarchical -filter no_ungroup] false

set_boundary_optimization [get_designs -filter no_boundary_optimization] false
set_boundary_optimization [get_cells -hierarchical -filter no_boundary_optimization] false

set_max_delay 1000 -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]
set_false_path -hold -through [get_pins -hierarchical -filter async] -through [get_pins -hierarchical -filter async]

##################
### FALSE PATH ###
##################

# FALSE PATH ON CLOCK DOMAINS CROSSING
set_clock_groups -asynchronous -name GRP_REF_CLK         -group REF_CLK
set_clock_groups -asynchronous -name GRP_JTAG_CLK        -group JTAG_CLK
set_clock_groups -asynchronous -name GRP_HYPER_CLK       -group AXI_HYPER_CLK_PHY
set_clock_groups -asynchronous -name GRP_FLL_CLUSTER_CLK -group FLL_CLUSTER_CLK
set_clock_groups -asynchronous -name GRP_FLL_SOC_CLK     -group FLL_SOC_CLK
set_clock_groups -asynchronous -name GRP_FLL_PER_CLK     -group FLL_PER_CLK
set_clock_groups -asynchronous -name GRP_HYPER_90_CLK    -group AXI_HYPER_CLK_PHY
set_clock_groups -asynchronous -name GRP_RWDS_CLK        -group RWDS_CLK


create_generated_clock -name opentitan_div4_clk -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 4 [get_pins i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div4_div/gen_div.clk_int_reg/Q]
create_generated_clock -name opentitan_div2_clk -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 2 [get_pins i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div2_div/gen_div2.u_div2/q_o_reg[0]/Q]
create_generated_clock -name opentitan_spi1 -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 8 [get_pins i_alsaqr/i_RoT_wrap/u_RoT/u_spi_host0/u_spi_core/u_fsm/u_sck_flop/q_o_reg[0]/Q]

set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div4_div/gen_div.clk_int_reg/Q]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div2_div/gen_div2.u_div2/q_o_reg[0]/Q]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  i_alsaqr/i_RoT_wrap/u_RoT/u_spi_host0/u_spi_core/u_fsm/u_sck_flop/q_o_reg[0]/Q]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_no/i_BUFGMUX/I0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_no/i_BUFGMUX/I1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_no/i_BUFGMUX/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_n/i_BUFGMUX/I0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_n/i_BUFGMUX/I1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_n/i_BUFGMUX/O]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/cluster_i/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_no/i_BUFGMUX/I0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/cluster_i/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_no/i_BUFGMUX/I1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/cluster_i/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_no/i_BUFGMUX/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/cluster_i/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_n/i_BUFGMUX/I0]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/cluster_i/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_n/i_BUFGMUX/I1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_pins  i_alsaqr/i_RoT_wrap/cluster_i/rstgen_i/i_rstgen_bypass/i_tc_clk_mux2_rst_n/i_BUFGMUX/O]

## JTAG Ibex
create_clock -period 100.000 -name ot_tck -waveform {0.000 50.000} [get_ports pad_jtag_ot_tck]
set_input_jitter tck 1.000
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pad_jtag_ot_tck_IBUF_inst/O]

set_input_delay -clock ot_tck -clock_fall 5.000 [get_ports pad_jtag_ot_tdi]
set_input_delay -clock ot_tck -clock_fall 5.000 [get_ports pad_jtag_ot_tms]
set_output_delay -clock ot_tck 5.000 [get_ports pad_jtag_ot_tdo]

set_max_delay -to [get_ports pad_jtag_ot_tdo] 20.000
set_max_delay -from [get_ports pad_jtag_ot_tms] 20.000
set_max_delay -from [get_ports pad_jtag_ot_tdi] 20.000

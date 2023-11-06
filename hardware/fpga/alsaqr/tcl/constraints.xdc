create_clock -period 4.000 [get_ports c0_sys_clk_p]
set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets u_ibufg_sys_clk/O]

create_clock -period 6.400 [get_pins u_ddr4_0/c0_ddr4_ui_clk]

create_generated_clock -name opentitan_div4_clk -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 4 [get_pins i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div4_div/gen_div.clk_int_reg/Q]
create_generated_clock -name opentitan_div2_clk -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 2 [get_pins i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div2_div/gen_div2.u_div2/q_o_reg[0]/Q]

create_generated_clock -name opentitan_spi1 -source [get_pins  alsaqr_clk_manager/clk_out1] -divide_by 8 [get_pins i_alsaqr/i_RoT_wrap/u_RoT/u_spi_host0/u_spi_core/u_fsm/u_sck_flop/q_o_reg[0]/Q]

#alsaqr clock
if {$::env(MAIN_MEM)=="HYPER"} {
create_clock -period 100 -name FPGA_CLK  [get_pins  alsaqr_clk_manager/clk_out1]
} else {
create_clock -period 50 -name FPGA_CLK  [get_pins  alsaqr_clk_manager/clk_out1]
}

set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  u_ddr4_0/c0_ddr4_ui_clk]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_ports c0_sys_clk_p]] 
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  alsaqr_clk_manager/clk_out1]] 
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  u_ddr4_0/c0_ddr4_ui_clk]]

set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div4_div/gen_div.clk_int_reg/Q]]
set_clock_groups -asynchronous -group [get_clocks -of_objects [get_pins  i_alsaqr/i_RoT_wrap/u_RoT/u_clkmgr_aon/u_no_scan_io_div2_div/gen_div2.u_div2/q_o_reg[0]/Q]]

#set_false_path -from [get_ports pad_reset]

## Bootselect
## TBD

## JTAG
create_clock -period 100.000 -name tck -waveform {0.000 50.000} [get_ports pad_jtag_tck]
set_input_jitter tck 1.000
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pad_jtag_tck_IBUF_inst/O]

## JTAG Ibex
create_clock -period 100.000 -name ot_tck -waveform {0.000 50.000} [get_ports pad_jtag_ot_tck]
set_input_jitter tck 1.000
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets pad_jtag_ot_tck_IBUF_inst/O]

# minimize routing delay
set_input_delay -clock tck -clock_fall 5.000 [get_ports pad_jtag_tdi]
set_input_delay -clock tck -clock_fall 5.000 [get_ports pad_jtag_tms]
set_output_delay -clock tck 5.000 [get_ports pad_jtag_tdo]

set_input_delay -clock ot_tck -clock_fall 5.000 [get_ports pad_jtag_ot_tdi]
set_input_delay -clock ot_tck -clock_fall 5.000 [get_ports pad_jtag_ot_tms]
set_output_delay -clock ot_tck 5.000 [get_ports pad_jtag_ot_tdo]

set_max_delay -to [get_ports pad_jtag_tdo] 20.000
set_max_delay -from [get_ports pad_jtag_tms] 20.000
set_max_delay -from [get_ports pad_jtag_tdi] 20.000

set_max_delay -to [get_ports pad_jtag_ot_tdo] 20.000
set_max_delay -from [get_ports pad_jtag_ot_tms] 20.000
set_max_delay -from [get_ports pad_jtag_ot_tdi] 20.000

# reset signal
set_false_path -from [get_ports pad_reset]

# SPI-STARTUPE3 Ultrascale+
# Following are the SPI device parameters
set tco_max 7
set tco_min 1
set tsu 2
set th 3
set tdata_trace_delay_max 0.25
set tdata_trace_delay_min 0.25
set tclk_trace_delay_max 0.2
set tclk_trace_delay_min 0.2
create_generated_clock -name clk_sck -source [get_pins -hierarchical *axi_quad_spi_0/ext_spi_clk] [get_pins -hierarchical */CCLK] -edges {3 5 7}
set_input_delay -clock clk_sck -max [expr $tco_max + $tdata_trace_delay_max + $tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_input_delay -clock clk_sck -min [expr $tco_min + $tdata_trace_delay_min + $tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_IN[*]] -clock_fall;
set_multicycle_path 2 -setup -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]]
set_multicycle_path 1 -hold -end -from clk_sck -to [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]]
set_output_delay -clock clk_sck -max [expr $tsu + $tdata_trace_delay_max -$tclk_trace_delay_min] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_output_delay -clock clk_sck -min [expr $tdata_trace_delay_min -$th -$tclk_trace_delay_max] [get_pins -hierarchical *STARTUP*/DATA_OUT[*]];
set_multicycle_path 2 -setup -start -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to clk_sck
set_multicycle_path 1 -hold -from [get_clocks -of_objects [get_pins -hierarchical */ext_spi_clk]] -to clk_sck

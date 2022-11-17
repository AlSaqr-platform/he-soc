// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


module alsaqr_clk_rst_gen (
  input  logic ref_clk_i,
  input  logic test_clk_i,
  input  logic rstn_glob_i,
  input  logic rst_dm_i,

  input  logic test_mode_i,
  input  logic sel_fll_clk_i,
  input  logic shift_enable_i,
  FLL_BUS.in   fll_intf,

  output logic rstn_soc_sync_o,
  output logic rstn_cva6_sync_o,
  output logic rstn_global_sync_o,
  output logic rstn_cluster_sync_o,

  output logic clk_soc_o,
  output logic clk_cva6_o,
  output logic clk_per_o,
  output logic clk_cluster_o
);

  logic s_clk_soc;
  logic s_clk_cva6;
  logic s_clk_per;
  logic s_clk_cluster;

  logic s_clk_fll_soc;
  logic s_clk_fll_cva6;
  logic s_clk_fll_per;
  logic s_clk_fll_cluster;

  logic s_rstn_soc;

  logic s_rstn_soc_sync;
  logic s_rstn_cva6_sync;
  logic s_rst_glob_sync;
  logic s_rstn_cluster_sync;

  logic [3:0] s_clk;
 

  // currently, FLLs are not supported for FPGA emulation
  `ifndef TARGET_FPGA
    //synopsys translate_off
    freq_meter #(.FLL_NAME("SOC_FLL"    ), .MAX_SAMPLE(4096)) SOC_METER     (.clk(s_clk_fll_soc));
    freq_meter #(.FLL_NAME("PER_FLL"    ), .MAX_SAMPLE(4096)) PER_METER     (.clk(s_clk_fll_per));
    freq_meter #(.FLL_NAME("CLUSTER_FLL"), .MAX_SAMPLE(4096)) CLUSTER_METER (.clk(s_clk_fll_cluster));
    //synopsys translate_on
    `ifdef GF22_FLL
      gf22_FLL i_gf22_fll (         // Clock & reset
    `else
      fll_dummy i_gf22_fll (         // Clock & reset
    `endif
      .OUTCLK ( s_clk          ), // FLL clock outputs
      .REFCLK ( ref_clk_i      ), // Reference clock input
      .RSTB   ( rstn_glob_i    ), // Asynchronous reset (active low)
      .CFGREQ ( fll_intf.req   ), // CFG I/F access request (active high)
      .CFGACK ( fll_intf.ack   ), // CFG I/F access granted (active high)
      .CFGAD  ( fll_intf.addr  ), // CFG I/F address bus
      .CFGD   ( fll_intf.wdata ), // CFG I/F input data bus (write)
      .CFGQ   ( fll_intf.rdata ), // CFG I/F output data bus (read)
      .CFGWEB ( fll_intf.web   ), // CFG I/F write enable (active low)
      .PWD    ( 1'b0           ), // Asynchronous power down (active high)
      .RET    ( 1'b0           ), // Asynchronous retention/isolation control (active high)
      .TM     ( 1'b0           ), // Test mode (active high)
      .TE     ( 1'b0           ), // Scan enable (active high)
      .TD     ( '0             ), // Scan data input for chain 1:4
      .TQ     (                ), // Scan data output for chain 1:4
      .JTD    ( 1'b0           ), // Scan data in 5
      .JTQ    (                )  // Scan data out 5
    );

    assign s_clk_fll_cva6    = s_clk[0];
    assign s_clk_fll_soc     = s_clk[1];
    assign s_clk_fll_per     = s_clk[2];
    assign s_clk_fll_cluster = s_clk[3];
 

    tc_clk_mux2 clk_mux_fll_cva6_i (
      .clk0_i    ( s_clk_fll_cva6  ),
      .clk1_i    ( ref_clk_i       ),
      .clk_sel_i ( sel_fll_clk_i   ),
      .clk_o     ( s_clk_cva6      )
    );

    tc_clk_mux2 clk_mux_fll_soc_i (
      .clk0_i    ( s_clk_fll_soc  ),
      .clk1_i    ( ref_clk_i      ),
      .clk_sel_i ( sel_fll_clk_i  ),
      .clk_o     ( s_clk_soc      )
    );

    tc_clk_mux2 clk_mux_fll_per_i (
      .clk0_i    ( s_clk_fll_per  ),
      .clk1_i    ( ref_clk_i      ),
      .clk_sel_i ( sel_fll_clk_i  ),
      .clk_o     ( s_clk_per      )
    );

    tc_clk_mux2 clk_mux_fll_cluster_i (
      .clk0_i    ( s_clk_fll_cluster  ),
      .clk1_i    ( ref_clk_i          ),
      .clk_sel_i ( sel_fll_clk_i      ),
      .clk_o     ( s_clk_cluster      )
    );

    rstgen i_cva6_rstgen (
      .clk_i       ( s_clk_cva6               ),
      .rst_ni      ( s_rstn_soc & (~rst_dm_i) ),
      .test_mode_i ( test_mode_i              ),
      .rst_no      ( s_rstn_cva6_sync         ), //to be used by logic clocked with ref clock in AO domain
      .init_no     (                          )                    //not used
    );
 
    rstgen i_soc_rstgen (
      .clk_i       ( s_clk_soc                ),
      .rst_ni      ( s_rstn_soc & (~rst_dm_i) ),
      .test_mode_i ( test_mode_i              ),
      .rst_no      ( s_rstn_soc_sync          ), //to be used by logic clocked with ref clock in AO domain
      .init_no     (                          )                    //not used
    );

    rstgen i_soc_dm_rstgen (
      .clk_i       ( s_clk_soc                ),
      .rst_ni      ( s_rstn_soc               ),
      .test_mode_i ( test_mode_i              ),
      .rst_no      ( s_rst_glob_sync          ), //to be used by logic clocked with ref clock in AO domain
      .init_no     (                          )                    //not used
    );
 
    rstgen i_cluster_rstgen (
      .clk_i       ( s_clk_cluster            ),
      .rst_ni      ( s_rstn_soc & (~rst_dm_i) ),
      .test_mode_i ( test_mode_i              ),
      .rst_no      ( s_rstn_cluster_sync      ), //to be used by logic clocked with ref clock in AO domain
      .init_no     (                          )                    //not used
    );

  `else // !`ifndef PULP_FPGA_EMUL

    // Use FPGA dependent clock generation module for both clocks
    // For the FPGA port we remove the clock multiplexers since it doesn't make
    // much sense to clock the circuit directly with the board reference clock
    // (e.g. 200MHz for genesys2 board).

    fpga_clk_gen i_fpga_clk_gen (
      .ref_clk_i                           ,
      .rstn_glob_i                         ,
      .test_mode_i                         ,
      .shift_enable_i                      ,
      .soc_clk_o      ( s_clk_fll_soc     ),
      .per_clk_o      ( s_clk_fll_per     ),
      .cluster_clk_o  ( s_clk_fll_cluster ),
      .cva6_clk_o     ( s_clk_fll_cva6    ),
      .cfg_req_i      ( fll_intf.req      ),
      .cfg_ack_o      ( fll_intf.ack      ),
      .cfg_add_i      ( fll_intf.addr     ),
      .cfg_data_i     ( fll_intf.wdata    ),
      .cfg_r_data_o   ( fll_intf.rdata    ),
      .cfg_wrn_i      ( fll_intf.web      )
    );

    assign s_clk_soc     = s_clk_fll_soc;
    assign s_clk_cluster = s_clk_fll_cluster;
    assign s_clk_per     = s_clk_fll_per;
    assign s_clk_cva6    = s_clk_fll_cva6;

    assign s_rstn_soc_sync     = s_rstn_soc & (~rst_dm_i) ;
    assign s_rstn_cluster_sync = s_rstn_soc & (~rst_dm_i);
    assign s_rst_glob_sync     = s_rstn_soc;
    assign s_rstn_cva6_sync    = s_rstn_soc & (~rst_dm_i);
 
  `endif



  assign s_rstn_soc = rstn_glob_i;

  assign clk_cva6_o    = s_clk_cva6;
  assign clk_soc_o     = s_clk_soc;
  assign clk_per_o     = s_clk_per;
  assign clk_cluster_o = s_clk_cluster;

  assign rstn_soc_sync_o     = s_rstn_soc_sync;
  assign rstn_cva6_sync_o    = s_rstn_cva6_sync;
  assign rstn_global_sync_o  = s_rst_glob_sync;   
  assign rstn_cluster_sync_o = s_rstn_cluster_sync;

  `ifdef DO_NOT_USE_FLL
    assert property (
      @(posedge clk) (soc_fll_slave_req_i == 1'b0 && per_fll_slave_req_i == 1'b0)  ) else $display("There should be no FLL request (%t)", $time);
  `endif


endmodule

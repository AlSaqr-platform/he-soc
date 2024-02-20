// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.


module pad_frame
  import udma_subsystem_pkg::*;
    (
     output logic        ref_clk_o,
     output logic        rstn_o,
     output logic        bypass_o,
     output logic        jtag_tck_o,
     output logic        jtag_tdi_o,
     input logic         jtag_tdo_i,
     output logic        jtag_tms_o,
     output logic        jtag_trst_o,

     // Ibex JTAG and bootselect signals
     output logic        jtag_tck_ot_o,
     output logic        jtag_tdi_ot_o,
     input logic         jtag_tdo_ot_i,
     output logic        jtag_tms_ot_o,
     output logic        jtag_trst_ot_o,
     output logic        bootmode_o,

     inout wire          pad_reset_n,
     inout wire          pad_jtag_tck,
     inout wire          pad_jtag_tdi,
     inout wire          pad_jtag_tdo,
     inout wire          pad_jtag_tms,
     inout wire          pad_jtag_trst,

     `ifdef ETH2FMC_NO_PADFRAME
     inout wire          pad_eth_rstn,
     inout wire          pad_eth_rxck,
     inout wire          pad_eth_rxctl,
     inout wire          pad_eth_rxd0,
     inout wire          pad_eth_rxd1,
     inout wire          pad_eth_rxd2,
     inout wire          pad_eth_rxd3,
     inout wire          pad_eth_txck,
     inout wire          pad_eth_txctl,
     inout wire          pad_eth_txd0,
     inout wire          pad_eth_txd1,
     inout wire          pad_eth_txd2,
     inout wire          pad_eth_txd3,
     inout wire          pad_eth_mdio,
     inout wire          pad_eth_mdc,

     input  logic        eth_rstn_i,
     output logic        eth_rxck_o,
     output logic        eth_rxctl_o,
     output logic        eth_rxd0_o,
     output logic        eth_rxd1_o,
     output logic        eth_rxd2_o,
     output logic        eth_rxd3_o,
     input  logic        eth_txck_i,
     input  logic        eth_txctl_i,
     input  logic        eth_txd0_i,
     input  logic        eth_txd1_i,
     input  logic        eth_txd2_i,
     input  logic        eth_txd3_i,
     inout  logic        eth_mdio_i,
     input  logic        eth_mdc_i,
     `endif

     // Ibex JTAG and bootselect pads
     inout wire          pad_jtag_ot_tck,
     inout wire          pad_jtag_ot_tdi,
     inout wire          pad_jtag_ot_tdo,
     inout wire          pad_jtag_ot_tms,
     inout wire          pad_jtag_ot_trst,
     inout wire          pad_bootmode,

     inout wire          pad_bypass,
     inout wire          pad_xtal_in
      );

    wire PWROK_S, IOPWROK_S, BIAS_S, RETC_S;

`ifndef FPGA_EMUL

    pad_alsaqr_pu padinst_bypass_clk (.OEN( 1'b1   ), .I(            ), .O( bypass_o    ), .PAD( pad_bypass    ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_ref_clk    (.OEN( 1'b1   ), .I(            ), .O( ref_clk_o   ), .PAD( pad_xtal_in   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_reset_n    (.OEN( 1'b1   ), .I(            ), .O( rstn_o      ), .PAD( pad_reset_n   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_tck   (.OEN( 1'b1   ), .I(            ), .O( jtag_tck_o  ), .PAD( pad_jtag_tck  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_tms   (.OEN( 1'b1   ), .I(            ), .O( jtag_tms_o  ), .PAD( pad_jtag_tms  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_tdi   (.OEN( 1'b1   ), .I(            ), .O( jtag_tdi_o  ), .PAD( pad_jtag_tdi  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_trstn (.OEN( 1'b1   ), .I(            ), .O( jtag_trst_o ), .PAD( pad_jtag_trst ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pd padinst_jtag_tdo   (.OEN( 1'b0   ), .I( jtag_tdo_i ), .O(             ), .PAD( pad_jtag_tdo  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );

    // Ibex JTAG and Bootselect
    pad_alsaqr_pu padinst_jtag_ot_tck   (.OEN( 1'b1   ), .I(               ), .O( jtag_tck_ot_o  ), .PAD( pad_jtag_ot_tck  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_ot_tms   (.OEN( 1'b1   ), .I(               ), .O( jtag_tms_ot_o  ), .PAD( pad_jtag_ot_tms  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_ot_tdi   (.OEN( 1'b1   ), .I(               ), .O( jtag_tdi_ot_o  ), .PAD( pad_jtag_ot_tdi  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_ot_trstn (.OEN( 1'b1   ), .I(               ), .O( jtag_trst_ot_o ), .PAD( pad_jtag_ot_trst ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pd padinst_jtag_ot_tdo   (.OEN( 1'b0   ), .I( jtag_tdo_ot_i ), .O(                ), .PAD( pad_jtag_ot_tdo  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pd padinst_bootmode      (.OEN( 1'b1   ), .I(               ), .O( bootmode_o     ), .PAD( pad_bootmode     ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );

    `ifdef ETH2FMC_NO_PADFRAME
    pad_alsaqr_pd padinst_eth_rstn  (.OEN( 1'b0 ), .I( eth_rstn_i  ), .O(             ), .PAD( pad_eth_rstn  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_rxck  (.OEN( 1'b1 ), .I(             ), .O( eth_rxck_o  ), .PAD( pad_eth_rxck  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_rxctl (.OEN( 1'b1 ), .I(             ), .O( eth_rxctl_o ), .PAD( pad_eth_rxctl ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_rxd0  (.OEN( 1'b1 ), .I(             ), .O( eth_rxd0_o  ), .PAD( pad_eth_rxd0  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_rxd1  (.OEN( 1'b1 ), .I(             ), .O( eth_rxd1_o  ), .PAD( pad_eth_rxd1  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_rxd2  (.OEN( 1'b1 ), .I(             ), .O( eth_rxd2_o  ), .PAD( pad_eth_rxd2  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_rxd3  (.OEN( 1'b1 ), .I(             ), .O( eth_rxd3_o  ), .PAD( pad_eth_rxd3  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_txck  (.OEN( 1'b0 ), .I( eth_txck_i  ), .O(             ), .PAD( pad_eth_txck  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_txctl (.OEN( 1'b0 ), .I( eth_txctl_i ), .O(             ), .PAD( pad_eth_txctl ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_txd0  (.OEN( 1'b0 ), .I( eth_txd0_i  ), .O(             ), .PAD( pad_eth_txd0  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_txd1  (.OEN( 1'b0 ), .I( eth_txd1_i  ), .O(             ), .PAD( pad_eth_txd1  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_txd2  (.OEN( 1'b0 ), .I( eth_txd2_i  ), .O(             ), .PAD( pad_eth_txd2  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_txd3  (.OEN( 1'b0 ), .I( eth_txd3_i  ), .O(             ), .PAD( pad_eth_txd3  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_eth_mdio  (.OEN( 1'b1 ), .I(             ), .O( eth_mdio_o  ), .PAD( pad_eth_mdio  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pd padinst_eth_mdc   (.OEN( 1'b0 ), .I( eth_mdc_i   ), .O(             ), .PAD( pad_eth_mdc   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    `endif

`else
    assign ref_clk_o = pad_xtal_in;
    assign rstn_o = pad_reset_n;
    assign bypass_o = pad_bypass;
    //JTAG signals
    assign pad_jtag_tdo = jtag_tdo_i;
    assign jtag_trst_o = pad_jtag_trst;
    assign jtag_tms_o = pad_jtag_tms;
    assign jtag_tck_o = pad_jtag_tck;
    assign jtag_tdi_o = pad_jtag_tdi;
    //JTAG Ibex signals
    assign pad_jtag_ot_tdo = jtag_tdo_ot_i;
    assign jtag_trst_ot_o = pad_jtag_ot_trst;
    assign jtag_tms_ot_o = pad_jtag_ot_tms;
    assign jtag_tck_ot_o = pad_jtag_ot_tck;
    assign jtag_tdi_ot_o = pad_jtag_ot_tdi;
    //BOOTMODE
    assign bootmode_o = pad_bootmode;

    `ifdef ETH2FMC_NO_PADFRAME
    assign pad_eth_rstn   = eth_rstn_i;
    assign eth_rxck_o     = pad_eth_rxck;
    assign eth_rxctl_o    = pad_eth_rxctl;
    assign eth_rxd0_o     = pad_eth_rxd0;
    assign eth_rxd1_o     = pad_eth_rxd1;
    assign eth_rxd2_o     = pad_eth_rxd2;
    assign eth_rxd3_o     = pad_eth_rxd3;
    assign pad_eth_txck   = eth_txck_i;
    assign pad_eth_txctl  = eth_txctl_i;
    assign pad_eth_txd0   = eth_txd0_i;
    assign pad_eth_txd1   = eth_txd1_i;
    assign pad_eth_txd2   = eth_txd2_i;
    assign pad_eth_txd3   = eth_txd3_i;
    assign eth_mdio_i     = pad_eth_mdio;
    assign pad_eth_mdc    = eth_mdc_i;
    `endif
`endif // !`ifndef FPGA_EMUL

`ifdef TARGET_ASIC

   IN22FDX_GPIO18_10M19S40PI_PWRDET_TIE_V pad_frame_pwrdet ( .RETCOUT (RETC_S), .PWROKOUT (PWROK_S), .IOPWROKOUT (IOPWROK_S), .RETCIN(1'b0), .BIAS(BIAS_S) );

`endif




endmodule

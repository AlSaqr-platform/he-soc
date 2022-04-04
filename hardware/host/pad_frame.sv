// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "pad_dcdc_defines.sv"

module pad_frame
  import udma_subsystem_pkg::*;
    (
     input logic         cva6_uart_tx,
     output logic        cva6_uart_rx,
     
     inout wire          pad_cva6_uart_rx ,
     inout wire          pad_cva6_uart_tx ,

     output logic        ref_clk_o,
     output logic        rstn_o,
     output logic        bypass_o,
     output logic        jtag_tck_o,
     output logic        jtag_tdi_o,
     input logic         jtag_tdo_i,
     output logic        jtag_tms_o,
     output logic        jtag_trst_o,
     
     inout wire          pad_reset_n,
     inout wire          pad_jtag_tck,
     inout wire          pad_jtag_tdi,
     inout wire          pad_jtag_tdo,
     inout wire          pad_jtag_tms,
     inout wire          pad_jtag_trst,

     inout wire          pad_bypass,
     inout wire          pad_xtal_in,

     inout wire          gwt_b_0,
     inout wire          gwt_r250_0,
     inout wire          pad_gwt_ana0,
     inout wire          gwt_b_1,
     inout wire          gwt_r250_1,
     inout wire          pad_gwt_ana1,

     inout wire          pad_ku_dcdc_vdd,
     inout wire          pad_ku_dcdc_vref,
     inout wire          pad_ku_dcdc_vout,

     inout wire          pad_ku_dcdc_control_1,
     inout wire          pad_ku_dcdc_control_2,
     inout wire          pad_ku_dcdc_clk_ext  ,
     inout wire          pad_ku_dcdc_sel_clk  ,
     inout wire          pad_ku_dcdc_SM_ext   ,
     inout wire          pad_ku_dcdc_sel_SM   ,
     inout wire          pad_ku_dcdc_PFM_out  
     );
   
    wire PWROK_S, IOPWROK_S, BIAS_S, RETC_S;
   
    pad_alsaqr_pu padinst_uart_rx    (.OEN( 1'b1   ), .I(1'b0         ), .O(cva6_uart_rx ), .PAD(pad_cva6_uart_rx   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
    pad_alsaqr_pu padinst_uart_tx    (.OEN( 1'b0   ), .I(cva6_uart_tx ), .O(             ), .PAD(pad_cva6_uart_tx   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S) );
   
`ifndef FPGA_EMUL  

    pad_alsaqr_pu padinst_bypass_clk (.OEN( 1'b1   ), .I(            ), .O( bypass_o    ), .PAD( pad_bypass    ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );   
    pad_alsaqr_pu padinst_ref_clk    (.OEN( 1'b1   ), .I(            ), .O( ref_clk_o   ), .PAD( pad_xtal_in   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_reset_n    (.OEN( 1'b1   ), .I(            ), .O( rstn_o      ), .PAD( pad_reset_n   ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_tck   (.OEN( 1'b1   ), .I(            ), .O( jtag_tck_o  ), .PAD( pad_jtag_tck  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_tms   (.OEN( 1'b1   ), .I(            ), .O( jtag_tms_o  ), .PAD( pad_jtag_tms  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_tdi   (.OEN( 1'b1   ), .I(            ), .O( jtag_tdi_o  ), .PAD( pad_jtag_tdi  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pu padinst_jtag_trstn (.OEN( 1'b1   ), .I(            ), .O( jtag_trst_o ), .PAD( pad_jtag_trst ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
    pad_alsaqr_pd padinst_jtag_tdo   (.OEN( 1'b0   ), .I( jtag_tdo_i ), .O(             ), .PAD( pad_jtag_tdo  ), .DRV(2'b00), .SLW(1'b0), .SMT(1'b0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );

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

`endif // !`ifndef FPGA_EMUL
  
   `DECLARE_LOGIC(control_1)
   `DECLARE_LOGIC(control_2)
   `DECLARE_LOGIC(clk_ext  )
   `DECLARE_LOGIC(sel_clk  )
   `DECLARE_LOGIC(SM_ext   )
   `DECLARE_LOGIC(sel_SM   )
   `DECLARE_LOGIC(PFM_out  )

`ifdef TARGET_ASIC
   
   IN22FDX_GPIO18_10M19S40PI_PWRDET_TIE_V pad_frame_pwrdet ( .RETCOUT (RETC_S), .PWROKOUT (PWROK_S), .IOPWROKOUT (IOPWROK_S), .RETCIN(1'b0), .BIAS(BIAS_S) );

   IN22FDX_GPIO18_10M19S40PI_ANA_H gwt_test_ana0 ( .DATA_B(gwt_b_0), .DATA_R250(gwt_r250_0), .PAD(pad_gwt_ana0), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
   IN22FDX_GPIO18_10M19S40PI_ANA_H gwt_test_ana1 ( .DATA_B(gwt_b_1), .DATA_R250(gwt_r250_1), .PAD(pad_gwt_ana1), .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );

   IN22FDX_GPIO18_10M19S40PI_VCS_H ku_dcdc_vdd  (  .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
   IN22FDX_GPIO18_10M19S40PI_VCS_H ku_dcdc_vref (  .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );
   IN22FDX_GPIO18_10M19S40PI_VCS_H ku_dcdc_vout (  .PWROK(PWROK_S), .IOPWROK(IOPWROK_S), .BIAS(BIAS_S), .RETC(RETC_S)  );

   `PAD_INST(control_1)
   `PAD_INST(control_2)
   `PAD_INST(clk_ext  )
   `PAD_INST(sel_clk  )
   `PAD_INST(SM_ext   )
   `PAD_INST(sel_SM   )
   `PAD_INST(PFM_out  )
   
   khalifa_dcdc i_khalifa_dcdc (
          `CONNECT_PAD(control_1),
          `CONNECT_PAD(control_2),
          `CONNECT_PAD(clk_ext),
          `CONNECT_PAD(sel_clk),
          `CONNECT_PAD(SM_ext),
          `CONNECT_PAD(sel_SM),
          `CONNECT_PAD(PFM_out)
          );

`endif
   
endmodule

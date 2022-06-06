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
     inout wire          pad_xtal_in
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
  
   
endmodule

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
     input               hyper_to_pad_t [1:0] hyper_to_pad,
     output              pad_to_hyper_t [1:0] pad_to_hyper,
                         
     inout wire [7:0]    pad_hyper0_dq ,
     inout wire          pad_hyper0_ck ,
     inout wire          pad_hyper0_ckn ,
     inout wire [1:0]    pad_hyper0_csn ,
     inout wire          pad_hyper0_rwds ,
     inout wire          pad_hyper0_reset ,


     inout wire [7:0]    pad_hyper1_dq ,
     inout wire          pad_hyper1_ck ,
     inout wire          pad_hyper1_ckn ,
     inout wire [1:0]    pad_hyper1_csn ,
     inout wire          pad_hyper1_rwds ,
     inout wire          pad_hyper1_reset ,

     input logic         cva6_uart_tx,
     output logic        cva6_uart_rx,
     
     inout wire          pad_cva6_uart_rx ,
     inout wire          pad_cva6_uart_tx ,

     output logic        ref_clk_o,
     output logic        rstn_o,
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
     inout wire          pad_xtal_in

     );

    pad_functional_pu padinst_hyper0_csno0  (.OEN( 1'b0                     ), .I( hyper_to_pad[0].cs0n_o  ), .O(                      ), .PAD(pad_hyper0_csn[0]), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_csno1  (.OEN( 1'b0                     ), .I( hyper_to_pad[0].cs1n_o  ), .O(                      ), .PAD(pad_hyper0_csn[1]), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_ck     (.OEN( 1'b0                     ), .I( hyper_to_pad[0].ck_o    ), .O(                      ), .PAD(pad_hyper0_ck    ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_ckno   (.OEN( 1'b0                     ), .I( hyper_to_pad[0].ckn_o   ), .O(                      ), .PAD(pad_hyper0_ckn   ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_rwds0  (.OEN(~hyper_to_pad[0].rwds_oe_o), .I( hyper_to_pad[0].rwds_o  ), .O(pad_to_hyper[0].rwds_i), .PAD(pad_hyper0_rwds  ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_resetn (.OEN( 1'b0                     ), .I( hyper_to_pad[0].resetn_o), .O(                      ), .PAD(pad_hyper0_reset ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio0  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq0_o   ), .O(pad_to_hyper[0].dq0_i ), .PAD(pad_hyper0_dq[0] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio1  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq1_o   ), .O(pad_to_hyper[0].dq1_i ), .PAD(pad_hyper0_dq[1] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio2  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq2_o   ), .O(pad_to_hyper[0].dq2_i ), .PAD(pad_hyper0_dq[2] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio3  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq3_o   ), .O(pad_to_hyper[0].dq3_i ), .PAD(pad_hyper0_dq[3] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio4  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq4_o   ), .O(pad_to_hyper[0].dq4_i ), .PAD(pad_hyper0_dq[4] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio5  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq5_o   ), .O(pad_to_hyper[0].dq5_i ), .PAD(pad_hyper0_dq[5] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio6  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq6_o   ), .O(pad_to_hyper[0].dq6_i ), .PAD(pad_hyper0_dq[6] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper0_dqio7  (.OEN(~hyper_to_pad[0].dq_oe_o  ), .I( hyper_to_pad[0].dq7_o   ), .O(pad_to_hyper[0].dq7_i ), .PAD(pad_hyper0_dq[7] ), .PEN(1'b1 ) );

    pad_functional_pu padinst_hyper1_csno0  (.OEN( 1'b0                     ), .I( hyper_to_pad[1].cs0n_o  ), .O(                      ), .PAD(pad_hyper1_csn[0]), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_csno1  (.OEN( 1'b0                     ), .I( hyper_to_pad[1].cs1n_o  ), .O(                      ), .PAD(pad_hyper1_csn[1]), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_ck     (.OEN( 1'b0                     ), .I( hyper_to_pad[1].ck_o    ), .O(                      ), .PAD(pad_hyper1_ck    ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_ckno   (.OEN( 1'b0                     ), .I( hyper_to_pad[1].ckn_o   ), .O(                      ), .PAD(pad_hyper1_ckn   ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_rwds0  (.OEN(~hyper_to_pad[1].rwds_oe_o), .I( hyper_to_pad[1].rwds_o  ), .O(pad_to_hyper[1].rwds_i), .PAD(pad_hyper1_rwds  ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_resetn (.OEN( 1'b0                     ), .I( hyper_to_pad[1].resetn_o), .O(                      ), .PAD(pad_hyper1_reset ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio0  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq0_o   ), .O(pad_to_hyper[1].dq0_i ), .PAD(pad_hyper1_dq[0] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio1  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq1_o   ), .O(pad_to_hyper[1].dq1_i ), .PAD(pad_hyper1_dq[1] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio2  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq2_o   ), .O(pad_to_hyper[1].dq2_i ), .PAD(pad_hyper1_dq[2] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio3  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq3_o   ), .O(pad_to_hyper[1].dq3_i ), .PAD(pad_hyper1_dq[3] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio4  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq4_o   ), .O(pad_to_hyper[1].dq4_i ), .PAD(pad_hyper1_dq[4] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio5  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq5_o   ), .O(pad_to_hyper[1].dq5_i ), .PAD(pad_hyper1_dq[5] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio6  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq6_o   ), .O(pad_to_hyper[1].dq6_i ), .PAD(pad_hyper1_dq[6] ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper1_dqio7  (.OEN(~hyper_to_pad[1].dq_oe_o  ), .I( hyper_to_pad[1].dq7_o   ), .O(pad_to_hyper[1].dq7_i ), .PAD(pad_hyper1_dq[7] ), .PEN(1'b1 ) );
   
   
    pad_functional_pu padinst_uart_rx    (.OEN( 1'b1   ), .I(1'b0         ), .O(cva6_uart_rx ), .PAD(pad_cva6_uart_rx   ), .PEN(1'b1) );
    pad_functional_pu padinst_uart_tx    (.OEN( 1'b0   ), .I(cva6_uart_tx ), .O(             ), .PAD(pad_cva6_uart_tx   ), .PEN(1'b1) );
   
`ifndef FPGA_EMUL  

    pad_functional_pu padinst_ref_clk    (.OEN(1'b1            ), .I(                ), .O(ref_clk_o      ), .PAD(pad_xtal_in   ), .PEN(1'b1             ) );
    pad_functional_pu padinst_reset_n    (.OEN(1'b1            ), .I(                ), .O(rstn_o         ), .PAD(pad_reset_n   ), .PEN(1'b1             ) );
    pad_functional_pu padinst_jtag_tck   (.OEN(1'b1            ), .I(                ), .O(jtag_tck_o     ), .PAD(pad_jtag_tck  ), .PEN(1'b1             ) );
    pad_functional_pu padinst_jtag_tms   (.OEN(1'b1            ), .I(                ), .O(jtag_tms_o     ), .PAD(pad_jtag_tms  ), .PEN(1'b1             ) );
    pad_functional_pu padinst_jtag_tdi   (.OEN(1'b1            ), .I(                ), .O(jtag_tdi_o     ), .PAD(pad_jtag_tdi  ), .PEN(1'b1             ) );
    pad_functional_pu padinst_jtag_trstn (.OEN(1'b1            ), .I(                ), .O(jtag_trst_o    ), .PAD(pad_jtag_trst ), .PEN(1'b1             ) );
    pad_functional_pd padinst_jtag_tdo   (.OEN(1'b0            ), .I(jtag_tdo_i      ), .O(               ), .PAD(pad_jtag_tdo  ), .PEN(1'b1             ) );

`else
    assign ref_clk_o = pad_xtal_in;
    assign rstn_o = pad_reset_n;
    
    //JTAG signals
    assign pad_jtag_tdo = jtag_tdo_i;
    assign jtag_trst_o = pad_jtag_trst;
    assign jtag_tms_o = pad_jtag_tms;
    assign jtag_tck_o = pad_jtag_tck;
    assign jtag_tdi_o = pad_jtag_tdi;

`endif
   
endmodule

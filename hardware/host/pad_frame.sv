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
    (
     // HYPERBUS
     input logic [1:0]   hyper_cs_ni ,
     input logic         hyper_ck_i ,
     input logic         hyper_ck_ni ,
     input logic [1:0]   hyper_rwds_i ,
     output logic        hyper_rwds_o ,
     input logic [1:0]   hyper_rwds_oe_i ,
     output logic [15:0] hyper_dq_o ,
     input logic [15:0]  hyper_dq_i ,
     input logic [1:0]   hyper_dq_oe_i ,
     input logic         hyper_reset_ni ,

     inout wire [7:0]    pad_hyper_dq0 ,
     inout wire [7:0]    pad_hyper_dq1 ,
     inout wire          pad_hyper_ck ,
     inout wire          pad_hyper_ckn ,
     inout wire          pad_hyper_csn0 ,
     inout wire          pad_hyper_csn1 ,
     inout wire          pad_hyper_rwds0 ,
     inout wire          pad_hyper_rwds1 ,
     inout wire          pad_hyper_reset ,

     // HYPERBUS
     input logic [1:0]   axi_hyper_cs_ni ,
     input logic         axi_hyper_ck_i ,
     input logic         axi_hyper_ck_ni ,
     input logic         axi_hyper_rwds_i ,
     output logic        axi_hyper_rwds_o ,
     input logic         axi_hyper_rwds_oe_i ,
     output logic [7:0]  axi_hyper_dq_o ,
     input logic [7:0]   axi_hyper_dq_i ,
     input logic         axi_hyper_dq_oe_i ,
     input logic         axi_hyper_reset_ni ,
                         
     inout wire [7:0]    pad_axi_hyper_dq0 ,
     inout wire [7:0]    pad_axi_hyper_dq1 ,
     inout wire          pad_axi_hyper_ck ,
     inout wire          pad_axi_hyper_ckn ,
     inout wire          pad_axi_hyper_csn0 ,
     inout wire          pad_axi_hyper_csn1 ,
     inout wire          pad_axi_hyper_rwds0 ,
     inout wire          pad_axi_hyper_rwds1 ,
     inout wire          pad_axi_hyper_reset ,

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

    pad_functional_pu padinst_axi_hyper_csno0  (.OEN( 1'b0                  ), .I( axi_hyper_cs_ni[0]  ), .O(                   ), .PAD( pad_axi_hyper_csn0    ), .PEN(1'b1 ) );
    pad_functional_pu padinst_axi_hyper_csno1  (.OEN( 1'b0                  ), .I( axi_hyper_cs_ni[1]  ), .O(                   ), .PAD( pad_axi_hyper_csn1    ), .PEN(1'b1 ) );
    pad_functional_pu padinst_axi_hyper_ck     (.OEN( 1'b0                  ), .I( axi_hyper_ck_i      ), .O(                   ), .PAD( pad_axi_hyper_ck      ), .PEN(1'b1 ) );
    pad_functional_pu padinst_axi_hyper_ckno   (.OEN( 1'b0                  ), .I( axi_hyper_ck_ni     ), .O(                   ), .PAD( pad_axi_hyper_ckn     ), .PEN(1'b1 ) );
    pad_functional_pu padinst_axi_hyper_rwds0  (.OEN(~axi_hyper_rwds_oe_i   ), .I( axi_hyper_rwds_i    ), .O( axi_hyper_rwds_o  ), .PAD( pad_axi_hyper_rwds0   ), .PEN(1'b1 ) );
    pad_functional_pu padinst_axi_hyper_resetn (.OEN( 1'b0                  ), .I( axi_hyper_reset_ni  ), .O(                   ), .PAD( pad_axi_hyper_reset   ), .PEN(1'b1 ) );

    genvar k;
    generate
       for (k=0; k<8; k++) begin
                pad_functional_pu padinst_axi_hyper_dqio0  (.OEN(~axi_hyper_dq_oe_i   ), .I( axi_hyper_dq_i[k]   ), .O( axi_hyper_dq_o[k]  ), .PAD( pad_axi_hyper_dq0[k]   ), .PEN(1'b1 ) );
        end
    endgenerate
   
    pad_functional_pu padinst_uart_rx    (.OEN( 1'b1   ), .I(1'b0         ), .O(cva6_uart_rx ), .PAD(pad_cva6_uart_rx   ), .PEN(1'b1) );
    pad_functional_pu padinst_uart_tx    (.OEN( 1'b0   ), .I(cva6_uart_tx ), .O(             ), .PAD(pad_cva6_uart_tx   ), .PEN(1'b1) );
   
`ifndef FPGA_EMUL  

    //HYPER
    pad_functional_pu padinst_hyper_csno0  (.OEN( 1'b0              ), .I( hyper_cs_ni[0]     ), .O(                   ), .PAD( pad_hyper_csn0    ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper_csno1  (.OEN( 1'b0              ), .I( hyper_cs_ni[1]     ), .O(                   ), .PAD( pad_hyper_csn1    ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper_ck     (.OEN( 1'b0              ), .I( hyper_ck_i         ), .O(                   ), .PAD( pad_hyper_ck      ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper_ckno   (.OEN( 1'b0              ), .I( hyper_ck_ni        ), .O(                   ), .PAD( pad_hyper_ckn     ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper_rwds0  (.OEN(~hyper_rwds_oe_i[0]), .I( hyper_rwds_i[0]    ), .O( hyper_rwds_o      ), .PAD( pad_hyper_rwds0   ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper_rwds1  (.OEN(~hyper_rwds_oe_i[1]), .I( hyper_rwds_i[1]    ), .O(                   ), .PAD( pad_hyper_rwds1   ), .PEN(1'b1 ) );
    pad_functional_pu padinst_hyper_resetn (.OEN( 1'b0              ), .I( hyper_reset_ni     ), .O(                   ), .PAD( pad_hyper_reset   ), .PEN(1'b1 ) );

    genvar j;
    generate
       for (j=0; j<8; j++) begin
                pad_functional_pu padinst_hyper_dqio0  (.OEN(~hyper_dq_oe_i[0]   ), .I( hyper_dq_i[j]   ), .O( hyper_dq_o[j]  ), .PAD( pad_hyper_dq0[j]   ), .PEN(1'b1 ) );
        end
    endgenerate

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

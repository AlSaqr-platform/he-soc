// Copyright 2018-2021 ETH Zurich and University of Bologna.
//
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

//// Hayate Okuhara <hayate.okuhara@unibo.it>

// Description: Generates 4 phase shifted clocks out of one faster clock
module clk_gen_hyper (
    input  logic clk_i,     // input clock
    input  logic rst_ni,
    output logic clk0_o,    // have the input clock - 0deg phase shift
    output logic clk90_o,   // have the input clock - 90deg phase shift
    output logic clk180_o,  // have the input clock - 180deg phase shift
    output logic clk270_o   // have the input clock - 270deg phase shift
);

//`ifndef PULP_FPGA_EMUL
    logic r_clk0_o;
    logic r_clk90_o;
    logic r_clk180_o;
    logic r_clk270_o;

    assign clk0_o = r_clk0_o;
    assign clk90_o = r_clk90_o;
    assign clk180_o = r_clk180_o;
    assign clk270_o = r_clk270_o;

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if(~rst_ni) begin
            r_clk0_o   <= 0;
            r_clk180_o <= 1;
        end else begin
            r_clk0_o <= ~r_clk0_o;
            r_clk180_o <= r_clk90_o;
        end
    end

    always_ff @(negedge clk_i or negedge rst_ni) begin
        if (~rst_ni) begin
            r_clk90_o  <= 0;
            r_clk270_o <= 1;
        end else begin
            r_clk90_o  <= r_clk0_o;
            r_clk270_o <= r_clk180_o;
        end
    end
/*`else
   assign clk0_o = clk_i;
   assign clk90_o = clk_i;
   assign clk180_o = clk_i;
   assign clk270_o = clk_i;
`endif*/
endmodule


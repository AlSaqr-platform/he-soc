// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
`timescale 1ps/1ps

(* dont_touch = "true" *)
module gwt_test
    (
     inout wire          gwt_b_0,
     inout wire          gwt_r250_0,
     inout wire          gwt_b_1,
     inout wire          gwt_r250_1,
     input logic [31:0]  cfg_i,
     output logic [31:0] cfg_o,
     output logic        cfg_oe
     );
   initial begin
      cfg_o = '0;
      cfg_oe = 1'b1;
      #4000us;
      cfg_o=32'hdeadcaca;
      #60ns;
  end
   
endmodule

// Copyright 2024 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

module monitor_counters_t_core (
  input                  clk_i,
  input                  rst_ni,

  input  monitor_counters_t_reg_pkg::monitor_counters_t_reg2hw_t reg2hw,
  output monitor_counters_t_reg_pkg::monitor_counters_t_hw2reg_t hw2reg

);
  import monitor_counters_t_reg_pkg::*;

  monitor_counters_t_event monitor_counters_t_event (
  	.clk_i	(clk_i),
  	.rst_ni	(rst_ni),

  	.reg2hw	(reg2hw),
  	.hw2reg	(hw2reg)

   );

endmodule

//-----------------------------------------------------------------------------
// Title : FPGA CLK Gen for PULPissimo
// -----------------------------------------------------------------------------
// File : fpga_clk_gen.sv Author : Manuel Eggimann <meggimann@iis.ee.ethz.ch>
// Created : 17.05.2019
// -----------------------------------------------------------------------------
// Description : Instantiates Xilinx clocking wizard IP to generate 2 output
// clocks. Currently, the clock is not dynamicly reconfigurable and all
// configuration requests are acknowledged without any effect.
// -----------------------------------------------------------------------------
// Copyright (C) 2013-2019 ETH Zurich, University of Bologna Copyright and
// related rights are licensed under the Solderpad Hardware License, Version
// 0.51 (the "License"); you may not use this file except in compliance with the
// License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law or
// agreed to in writing, software, hardware and materials distributed under this
// License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
// OF ANY KIND, either express or implied. See the License for the specific
// language governing permissions and limitations under the License.
// -----------------------------------------------------------------------------


module fpga_clk_gen (
                     input logic         ref_clk_i,
                     input logic         rstn_glob_i,
                     input logic         test_mode_i,
                     input logic         shift_enable_i,
                     output logic        soc_clk_o,
                     output logic        per_clk_o,
                     output logic        cluster_clk_o,
                     output logic        cva6_clk_o,
                     input logic         cfg_req_i,
                     output logic        cfg_ack_o,
                     input logic [3:0]   cfg_add_i,
                     input logic [31:0]  cfg_data_i,
                     output logic [31:0] cfg_r_data_o,
                     input logic         cfg_wrn_i
                     );


  assign soc_clk_o     = ref_clk_i;
  assign cluster_clk_o = ref_clk_i;
  assign per_clk_o     = ref_clk_i;
  assign cva6_clk_o    = ref_clk_i;
   
  assign cfg_ack_o    = 1'b1; //Always acknowledge without doing anything for now
  assign cfg_r_data_o = 32'hdeadda7a;
   

endmodule : fpga_clk_gen

// Copyright 2024 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Maicol Ciani <maicol.ciani@unibo.it> University of Bologna
// Date: 30/07/2024

module trigger
   import snooper_pkg::*;
   import cfg_regs_reg_pkg::*;
(
   input  trace_t           traces_i,
   input  cfg_regs_reg2hw_t config_i,
   output logic             irq_o
);
    // Raise the interrupt if and only if one or more enabled target PCs is found in traces.
   logic [3:0] trig_en;

   assign trig_en[0] = config_i.ctrl.trig_pc_0.q &
                       ({ traces_i.pc_src_h, traces_i.pc_src_l         } ==
                        { config_i.trig_pc0_h.q, config_i.trig_pc0_l.q }) ;

   assign trig_en[1] = config_i.ctrl.trig_pc_1.q &
                       ({ traces_i.pc_src_h, traces_i.pc_src_l         } ==
                        { config_i.trig_pc1_h.q, config_i.trig_pc1_l.q }) ;

   assign trig_en[2] = config_i.ctrl.trig_pc_2.q &
                       ({ traces_i.pc_src_h, traces_i.pc_src_l         } ==
                        { config_i.trig_pc2_h.q, config_i.trig_pc2_l.q }) ;

   assign trig_en[3] = config_i.ctrl.trig_pc_3.q &
                       ({ traces_i.pc_src_h, traces_i.pc_src_l         } ==
                        { config_i.trig_pc3_h.q, config_i.trig_pc3_l.q }) ;

   assign irq_o = trig_en[0] | trig_en[1] | trig_en[2] | trig_en[3];

endmodule

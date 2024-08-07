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
// Date: 29/07/2024

module trace_filter
   import snooper_pkg::*;
   import cfg_regs_reg_pkg::*;
   import riscv::*;
(
   input  trace_t           traces_i,
   input  cfg_regs_reg2hw_t config_i,
   output logic             enable_o
);

   logic priv_lvl_en;
   logic [3:0] cfg_en;

   assign priv_lvl_en = ( config_i.ctrl.m_mode.q & ( traces_i.priv_lvl == PRIV_LVL_M )) |
                        ( config_i.ctrl.s_mode.q & ( traces_i.priv_lvl == PRIV_LVL_S )) |
                        ( config_i.ctrl.u_mode.q & ( traces_i.priv_lvl == PRIV_LVL_U ));

   assign cfg_en[0] =   config_i.ctrl.pc_range_0.q &
                        ({ config_i.range_0_base_h.q, config_i.range_0_base_l.q } <=
                         { traces_i.pc_src_h, traces_i.pc_src_l                 }) &
                        ({ traces_i.pc_src_h, traces_i.pc_src_l                 } <=
                         { config_i.range_0_last_h.q, config_i.range_0_last_l.q });

   assign cfg_en[1] =   config_i.ctrl.pc_range_1.q &
                        ({ config_i.range_1_base_h.q, config_i.range_1_base_l.q } <=
                         { traces_i.pc_src_h, traces_i.pc_src_l                 }) &
                        ({ traces_i.pc_src_h, traces_i.pc_src_l                 } <=
                         { config_i.range_1_last_h.q, config_i.range_1_last_l.q });

   assign cfg_en[2] =   config_i.ctrl.pc_range_2.q &
                        ({ config_i.range_2_base_h.q, config_i.range_2_base_l.q } <=
                         { traces_i.pc_src_h, traces_i.pc_src_l                 }) &
                        ({ traces_i.pc_src_h, traces_i.pc_src_l                 } <=
                         { config_i.range_2_last_h.q, config_i.range_2_last_l.q });

   assign cfg_en[3] =   config_i.ctrl.pc_range_3.q &
                        ({ config_i.range_3_base_h.q, config_i.range_3_base_l.q } <=
                         { traces_i.pc_src_h, traces_i.pc_src_l                 }) &
                        ({ traces_i.pc_src_h, traces_i.pc_src_l                 } <=
                         { config_i.range_3_last_h.q, config_i.range_3_last_l.q });

   assign enable_o = priv_lvl_en & ( cfg_en[0] | cfg_en[1] | cfg_en[2] | cfg_en[3] );

endmodule

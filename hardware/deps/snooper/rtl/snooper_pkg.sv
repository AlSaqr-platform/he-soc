// Copyright 2018 ETH Zurich and University of Bologna.
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

package snooper_pkg;

  typedef struct packed {
     riscv::priv_lvl_t priv_lvl;
     logic [31:0]      pc_src_h;
     logic [31:0]      pc_src_l;
     logic [31:0]      pc_dst_h;
     logic [31:0]      pc_dst_l;
     logic             pc_v;
     logic [31:0]      metadata;
     logic [31:0]      opcode;
  } trace_t;

endpackage

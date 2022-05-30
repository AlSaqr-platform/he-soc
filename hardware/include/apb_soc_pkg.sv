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
// Author: Luca Valente
// Description: Contains SoC information as constants

package apb_soc_pkg;

   typedef struct packed {
      logic [31:0] idx;
      logic [31:0] start_addr;
      logic [31:0] end_addr;
   } addr_map_rule_t;

   localparam NUM_APB_SLAVES = 11;

   localparam NUM_GPIO = 64;
   
   localparam logic [31:0] APBUARTLength  = 32'h1000;
   localparam logic [31:0] UDMALength     = 32'h22000; //4K * N_PERIPHS  (N_PERIPHS=34)
   localparam logic [31:0] GPIOSLength    = 32'h1000;
   localparam logic [31:0] FLLLength      = 32'h1000;
   localparam logic [31:0] HYAXICFGLength = 32'h1000;
   localparam logic [31:0] ADVTIMERLength = 32'h1000;
   localparam logic [31:0] PADFRAMELength = 32'h1000;
   localparam logic [31:0] SOCCTRLLength  = 32'h1000;
   localparam logic [31:0] SerLinkLength  = 32'h1000;
   localparam logic [31:0] CanLength      = 32'h1000;
   
    typedef enum logic [31:0] {
     FLLBase       = 32'h1A10_0000,
     HYAXICFGBase  = 32'h1A10_1000,
     ADVTIMERBase  = 32'h1A10_3000,
     PADFRAMEBase  = 32'h1A10_4000,
     GPIOSBase     = 32'h1A10_5000,
     SOCCTRLBase   = 32'h1A10_6000,
     SerLinkBase   = 32'h1A10_7000,
     Can0Base      = 32'h1A10_8000,
     Can1Base      = 32'h1A10_9000,
     UDMABase      = 32'h1A20_0000,
     APBUARTBase   = 32'h1A22_2000
    } soc_apb_bus_start_t;
endpackage

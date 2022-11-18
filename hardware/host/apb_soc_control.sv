// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"
`include "common_cells/registers.svh"
`include "apb_macros.sv"

module apb_soc_control
  import apb_soc_pkg::*;
  import control_register_config_reg_pkg::*; 
#(
    parameter APB_ADDR_WIDTH = 32,
    parameter APB_DATA_WIDTH = 32
) (
    input logic          clk_i,
    input logic          rst_ni,
    APB.Slave            apb_slave,
    output logic         cluster_ctrl_rstn_o,
    output logic         cluster_en_sa_boot_o,
    output logic         cluster_fetch_en_o,
    input logic          llc_read_hit_cache_i, 
    input logic          llc_read_miss_cache_i, 
    input logic          llc_write_hit_cache_i, 
    input logic          llc_write_miss_cache_i
   );
   

   localparam RegAw  = 32;
   localparam RegDw  = 32; 
   typedef logic [RegAw-1:0]   reg_addr_t;
   typedef logic [RegDw-1:0]   reg_data_t;
   typedef logic [RegDw/8-1:0] reg_strb_t;   
   `REG_BUS_TYPEDEF_REQ(reg_req_t, reg_addr_t, reg_data_t, reg_strb_t)
   `REG_BUS_TYPEDEF_RSP(reg_rsp_t, reg_data_t)
   reg_req_t   reg_req;
   reg_rsp_t   reg_rsp;
   `REG_BUS_ASSIGN_TO_REQ(reg_req,cfg_reg_master)
   `REG_BUS_ASSIGN_FROM_RSP(cfg_reg_master,reg_rsp)  
   control_register_config_reg_pkg::control_register_config_reg2hw_t reg2hw_socctrl;
   control_register_config_reg_pkg::control_register_config_hw2reg_t hw2reg_socctrl;
   
   logic [RegDw-1:0] llc_read_hit_cache_d, llc_read_hit_cache_q;
   logic [RegDw-1:0] llc_read_miss_cache_d, llc_read_miss_cache_q;
   logic [RegDw-1:0] llc_write_hit_cache_d, llc_write_hit_cache_q;
   logic [RegDw-1:0] llc_write_miss_cache_d, llc_write_miss_cache_q;

   logic             s_llc_counter_enable;
   
   always_comb begin
      llc_read_hit_cache_d = llc_read_hit_cache_q;
      llc_write_hit_cache_d = llc_write_hit_cache_q;
      llc_read_miss_cache_d = llc_read_miss_cache_q;
      llc_write_miss_cache_d = llc_write_miss_cache_q;      
      if(llc_read_hit_cache_i && s_llc_counter_enable) begin
         llc_read_hit_cache_d = llc_read_hit_cache_q + 1;
      end
      if(llc_read_miss_cache_i && s_llc_counter_enable) begin
         llc_read_miss_cache_d = llc_read_miss_cache_q + 1;
      end
      if(llc_write_hit_cache_i && s_llc_counter_enable) begin
         llc_write_hit_cache_d = llc_write_hit_cache_q + 1;
      end
      if(llc_write_miss_cache_i && s_llc_counter_enable) begin
         llc_write_miss_cache_d = llc_write_miss_cache_q + 1;
      end
   end

   `FFARN(llc_read_hit_cache_q,llc_read_hit_cache_d, '0, clk_i, rst_ni)
   `FFARN(llc_read_miss_cache_q,llc_read_miss_cache_d, '0, clk_i, rst_ni)
   `FFARN(llc_write_hit_cache_q,llc_write_hit_cache_d, '0, clk_i, rst_ni)
   `FFARN(llc_write_miss_cache_q,llc_write_miss_cache_d, '0, clk_i, rst_ni)
   
   REG_BUS #(
        .ADDR_WIDTH ( 32 ),
        .DATA_WIDTH ( 32 )
       ) cfg_reg_master (.clk_i(clk_i));
   
    apb_to_reg i_apb_to_socctrlcfg
      (
       .clk_i     ( clk_i       ),
       .rst_ni    ( rst_ni      ),
 
       .penable_i ( apb_slave.penable ),
       .pwrite_i  ( apb_slave.pwrite  ),
       .paddr_i   ( apb_slave.paddr   ),
       .psel_i    ( apb_slave.psel    ),
       .pwdata_i  ( apb_slave.pwdata  ),
       .prdata_o  ( apb_slave.prdata  ),
       .pready_o  ( apb_slave.pready  ),
       .pslverr_o ( apb_slave.pslverr ),

       .reg_o     ( cfg_reg_master    )
      );     

    control_register_config_reg_top  #(
        .reg_req_t (reg_req_t),
        .reg_rsp_t (reg_rsp_t)
    ) i_soc_ctrl (
       .clk_i      ( clk_i           ),
       .rst_ni     ( rst_ni          ),
       .reg_req_i  ( reg_req         ),
       .reg_rsp_o  ( reg_rsp         ),
       .reg2hw     ( reg2hw_socctrl  ),
       .hw2reg     ( hw2reg_socctrl  ),
       .devmode_i  ( '0              )
   );

   assign cluster_ctrl_rstn_o = reg2hw_socctrl.control_cluster.reset_n.q;
   assign cluster_en_sa_boot_o = reg2hw_socctrl.control_cluster.en_sa_boot.q;
   assign cluster_fetch_en_o = reg2hw_socctrl.control_cluster.fetch_en.q;
   assign s_llc_counter_enable = reg2hw_socctrl.enable_llc_counters.q;
 
   assign hw2reg_socctrl.llc_write_hit_cache.de = 1'b1;
   assign hw2reg_socctrl.llc_write_hit_cache.d = llc_write_hit_cache_q;
   assign hw2reg_socctrl.llc_write_miss_cache.de = 1'b1;
   assign hw2reg_socctrl.llc_write_miss_cache.d = llc_write_miss_cache_q;
   assign hw2reg_socctrl.llc_read_hit_cache.de = 1'b1;
   assign hw2reg_socctrl.llc_read_hit_cache.d = llc_read_hit_cache_q;
   assign hw2reg_socctrl.llc_read_miss_cache.de = 1'b1;
   assign hw2reg_socctrl.llc_read_miss_cache.d = llc_read_miss_cache_q;

endmodule

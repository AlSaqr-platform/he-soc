// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: 

//algrin `include "prim_assert.sv"

module htm_block
    import htm_block_reg_pkg::*;
 #(
    parameter type reg_req_t = logic,
    parameter type reg_rsp_t = logic,
    parameter int AW = 6
)
 (
  input           clk_i,
  input           rst_ni,

  // Bus Interface
  input  reg_req_t reg_req_i,
  output reg_rsp_t reg_rsp_o

  // Generic IO

  // Interrupts
);

  htm_block_reg2hw_t reg2hw;
  htm_block_hw2reg_t hw2reg;
////
//
//

htm_block_reg_top  # (
    .reg_req_t  (reg_req_t) ,
    .reg_rsp_t  (reg_rsp_t)

 )htm_block_reg_top 
 (
        .clk_i          (clk_i),
        .rst_ni         (rst_ni),
 
  	.reg_req_i	(reg_req_i),
  	.reg_rsp_o	(reg_rsp_o),
  // To HW
 
  	.reg2hw		(reg2hw), // Read
  	.hw2reg		(hw2reg), // Read

  // Config
  	.devmode_i	(1'b1) // If 1, explicit error return for unmapped register access
);

logic [0:15][31:0]      sdr_index;
logic       [31:0]      sdr_status;
logic       [31:0]      sdr_control;
logic [0:31][31:0]      sdr_reg;
logic       [5:0]	shift_counter;


sdr_module sdr_module (
        .clk_i		(clk_i),
        .rst_ni		(rst_ni),
/*
        .sdr_index 	(sdr_index),
        .sdr_status 	(sdr_status),
        .sdr_control	(sdr_control),
        .sdr_reg	(sdr_reg),
        .shift_counter	(shift_counter),
*/
	.reg2hw     	(reg2hw),
	.hw2reg     	(hw2reg)


);
/*
  monitor_counters_t_core monitor_counters_t_core (
    .clk_i	(clk_i),
    .rst_ni	(rst_ni),
    .reg2hw	(reg2hw),
    .hw2reg	(hw2reg)

  );
*/
endmodule

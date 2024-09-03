// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: UART top level wrapper file

//algrin `include "prim_assert.sv"

module monitor_counters_t
    import monitor_counters_t_reg_pkg::*;
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

  //logic [NumAlerts-1:0] alert_test, alerts;
  monitor_counters_t_reg2hw_t reg2hw;
  monitor_counters_t_hw2reg_t hw2reg;
////
//
//

monitor_counters_t_reg_top  # (
    .reg_req_t  (reg_req_t) ,
    .reg_rsp_t  (reg_rsp_t)

 )monitor_counters_t_reg_top 
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
  monitor_counters_t_core monitor_counters_t_core (
    .clk_i	(clk_i),
    .rst_ni	(rst_ni),
    .reg2hw	(reg2hw),
    .hw2reg	(hw2reg)

  );
endmodule

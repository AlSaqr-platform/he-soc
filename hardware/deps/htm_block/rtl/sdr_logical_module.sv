// Copyright Technion IIT.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// 
//


module sdr_logical_module (
	input                  	    	clk_i,
	input							rst_ni,
	input	logic 	[0:31]	[31:0]	sdr_0_reg, 
	input	logic 	[0:31]	[31:0]	sdr_1_reg, 	
	input	logic 	[0:31]	[31:0]	sdr_2_reg, 
	input	logic 	[0:31]	[31:0]	sdr_3_reg, 
	input	logic			[3:0]	sdr_logical_op_control_src_1, 			
	input	logic			[3:0]	sdr_logical_op_control_src_2, 			
	input	logic			[3:0]	sdr_logical_op_control_desination_sdr, 	
	input	logic			[3:0]	sdr_logical_op_control_logical_operation,
	output	logic 	[0:31]	[31:0]	sdr_logical_result

);

logic 	[0:31]	[31:0]	sdr_src_1_reg;
logic 	[0:31]	[31:0]	sdr_src_2_reg;
logic			[3:0]   sdr_src_1_sel;
logic			[3:0]   sdr_src_2_sel;
logic			[3:0]   sdr_logical_op_sel;

assign sdr_src_1_sel 		= sdr_logical_op_control_src_1;
assign sdr_src_2_sel 		= sdr_logical_op_control_src_2;
assign sdr_logical_op_sel	= sdr_logical_op_control_logical_operation;

always_comb	begin
	case (sdr_src_1_sel)
		4'b0000 : sdr_src_1_reg = sdr_0_reg;
		4'b0001 : sdr_src_1_reg = sdr_1_reg;
		4'b0010 : sdr_src_1_reg = sdr_2_reg;
		4'b0011 : sdr_src_1_reg = sdr_3_reg;
		default : sdr_src_1_reg = sdr_0_reg;
	endcase
end

always_comb	begin
	case (sdr_src_2_sel)
		4'b0000 : sdr_src_2_reg = sdr_0_reg;
		4'b0001 : sdr_src_2_reg = sdr_1_reg;
		4'b0010 : sdr_src_2_reg = sdr_2_reg;
		4'b0011 : sdr_src_2_reg = sdr_3_reg;
		default : sdr_src_2_reg = sdr_0_reg;

	endcase
end

always_comb	begin
	case (sdr_logical_op_sel)
		4'b0000 : sdr_logical_result = sdr_src_1_reg & sdr_src_2_reg;
		4'b0001 : sdr_logical_result = sdr_src_1_reg | sdr_src_2_reg;
		4'b0010 : sdr_logical_result = sdr_src_1_reg ^ sdr_src_2_reg;
		default : sdr_logical_result = sdr_0_reg;
	endcase
end

endmodule

// Copyright Technion IIT.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// 
//


module htm_reg_adaptor (
	input                  	    	clk_i,
	input				rst_ni,
	
	input 	logic 	[0:15]	[31:0]	sdr_0_index ,
	input	logic 	    	[31:0]	sdr_0_status ,
	output 	logic 	    	[31:0]	sdr_0_control,
	output	logic 	[0:31]	[31:0]	sdr_0_reg, 

	input 	logic 	[0:15]	[31:0]	sdr_1_index ,
	input	logic 	    	[31:0]	sdr_1_status ,
	output 	logic 	    	[31:0]	sdr_1_control,
	output	logic 	[0:31]	[31:0]	sdr_1_reg,

	input 	logic 	[0:15]	[31:0]	sdr_2_index ,
	input	logic 	    	[31:0]	sdr_2_status ,
	output 	logic 	    	[31:0]	sdr_2_control,
	output	logic 	[0:31]	[31:0]	sdr_2_reg, 

	input 	logic 	[0:15]	[31:0]	sdr_3_index ,
	input	logic 	    	[31:0]	sdr_3_status ,
	output 	logic 	    	[31:0]	sdr_3_control,
	output	logic 	[0:31]	[31:0]	sdr_3_reg,

	output	logic			[3:0]	sdr_logical_op_control_src_1, 			
	output	logic			[3:0]	sdr_logical_op_control_src_2, 			
	output	logic			[3:0]	sdr_logical_op_control_desination_sdr, 	
	output	logic			[3:0]	sdr_logical_op_control_logical_operation,


	input	logic 	[0:31]	[31:0]	sdr_logical_result, 	

  input  htm_block_reg_pkg::htm_block_reg2hw_t reg2hw,
  output htm_block_reg_pkg::htm_block_hw2reg_t hw2reg

);

  import htm_block_reg_pkg::*;


// Derive 1 clk pulse on start
/************************SDR_0*****************************************/
assign sdr_0_control = reg2hw.sdr_0_control_reg; //sdr_control_reg.start
assign hw2reg.sdr_0_control_reg.start.d = 1'b0;
assign hw2reg.sdr_0_control_reg.start.de = reg2hw.sdr_0_control_reg.start.q;

assign sdr_0_reg[0]  = reg2hw.sdr_0_0;
assign sdr_0_reg[1]  = reg2hw.sdr_0_1;
assign sdr_0_reg[2]  = reg2hw.sdr_0_2;
assign sdr_0_reg[3]  = reg2hw.sdr_0_3;
assign sdr_0_reg[4]  = reg2hw.sdr_0_4;
assign sdr_0_reg[5]  = reg2hw.sdr_0_5;
assign sdr_0_reg[6]  = reg2hw.sdr_0_6;
assign sdr_0_reg[7]  = reg2hw.sdr_0_7;
assign sdr_0_reg[8]  = reg2hw.sdr_0_8;
assign sdr_0_reg[9]  = reg2hw.sdr_0_9;
assign sdr_0_reg[10]  = reg2hw.sdr_0_10;
assign sdr_0_reg[11]  = reg2hw.sdr_0_11;

assign sdr_0_reg[12]  = reg2hw.sdr_0_12;
assign sdr_0_reg[13]  = reg2hw.sdr_0_13;
assign sdr_0_reg[14]  = reg2hw.sdr_0_14;
assign sdr_0_reg[15]  = reg2hw.sdr_0_15;
assign sdr_0_reg[16]  = reg2hw.sdr_0_16;
assign sdr_0_reg[17]  = reg2hw.sdr_0_17;
assign sdr_0_reg[18]  = reg2hw.sdr_0_18;
assign sdr_0_reg[19]  = reg2hw.sdr_0_19;
assign sdr_0_reg[20]  = reg2hw.sdr_0_20;
assign sdr_0_reg[21]  = reg2hw.sdr_0_21;
assign sdr_0_reg[22]  = reg2hw.sdr_0_22;
assign sdr_0_reg[23]  = reg2hw.sdr_0_23;

assign sdr_0_reg[24]  = reg2hw.sdr_0_24;
assign sdr_0_reg[25]  = reg2hw.sdr_0_25;
assign sdr_0_reg[26]  = reg2hw.sdr_0_26;
assign sdr_0_reg[27]  = reg2hw.sdr_0_27;
assign sdr_0_reg[28]  = reg2hw.sdr_0_28;
assign sdr_0_reg[29]  = reg2hw.sdr_0_29;
assign sdr_0_reg[30]  = reg2hw.sdr_0_30;
assign sdr_0_reg[31]  = reg2hw.sdr_0_31;

assign hw2reg.sdr_0_index_0.d = sdr_0_index[0];
assign hw2reg.sdr_0_index_0.de = 1'b1;

assign hw2reg.sdr_0_index_1.d = sdr_0_index[1];
assign hw2reg.sdr_0_index_1.de = 1'b1;

assign hw2reg.sdr_0_index_2.d = sdr_0_index[2];
assign hw2reg.sdr_0_index_2.de = 1'b1;

assign hw2reg.sdr_0_index_3.d = sdr_0_index[3];
assign hw2reg.sdr_0_index_3.de = 1'b1;

assign hw2reg.sdr_0_index_4.d = sdr_0_index[4];
assign hw2reg.sdr_0_index_4.de = 1'b1;

assign hw2reg.sdr_0_index_5.d = sdr_0_index[5];
assign hw2reg.sdr_0_index_5.de = 1'b1;

assign hw2reg.sdr_0_index_6.d = sdr_0_index[6];
assign hw2reg.sdr_0_index_6.de = 1'b1;

assign hw2reg.sdr_0_index_7.d = sdr_0_index[7];
assign hw2reg.sdr_0_index_7.de = 1'b1;

assign hw2reg.sdr_0_index_8.d = sdr_0_index[8];
assign hw2reg.sdr_0_index_8.de = 1'b1;

assign hw2reg.sdr_0_index_9.d = sdr_0_index[9];
assign hw2reg.sdr_0_index_9.de = 1'b1;

assign hw2reg.sdr_0_index_10.d = sdr_0_index[10];
assign hw2reg.sdr_0_index_10.de = 1'b1;

assign hw2reg.sdr_0_index_11.d = sdr_0_index[11];
assign hw2reg.sdr_0_index_11.de = 1'b1;

assign hw2reg.sdr_0_index_12.d = sdr_0_index[12];
assign hw2reg.sdr_0_index_12.de = 1'b1;

assign hw2reg.sdr_0_index_13.d = sdr_0_index[13];
assign hw2reg.sdr_0_index_13.de = 1'b1;

assign hw2reg.sdr_0_index_14.d = sdr_0_index[14];
assign hw2reg.sdr_0_index_14.de = 1'b1;

assign hw2reg.sdr_0_index_15.d = sdr_0_index[15];
assign hw2reg.sdr_0_index_15.de = 1'b1; 


assign hw2reg.sdr_0_status_reg.number_of_indexes.d = sdr_0_status[7:0];
assign hw2reg.sdr_0_status_reg.number_of_indexes.de = 1'b1;

assign hw2reg.sdr_0_status_reg.number_of_ones.d = sdr_0_status[24:8];
assign hw2reg.sdr_0_status_reg.number_of_ones.de = 1'b1;

assign hw2reg.sdr_0_status_reg.unused.de = 1'b0;

assign hw2reg.sdr_0_status_reg.error_indexes_gt_32.d = sdr_0_status[29];
assign hw2reg.sdr_0_status_reg.error_indexes_gt_32.de = 1'b1;

assign hw2reg.sdr_0_status_reg.error_fifo_full.d  = sdr_0_status[30];
assign hw2reg.sdr_0_status_reg.error_fifo_full.de = 1'b1;

assign hw2reg.sdr_0_status_reg.done.d = sdr_0_status[31]; 
assign hw2reg.sdr_0_status_reg.done.de = 1'b1;

/************************SDR_1*****************************************/
assign sdr_1_control = reg2hw.sdr_1_control_reg; //sdr_control_reg.start
assign hw2reg.sdr_1_control_reg.start.d = 1'b0;
assign hw2reg.sdr_1_control_reg.start.de = reg2hw.sdr_1_control_reg.start.q;

assign sdr_1_reg[0]  = reg2hw.sdr_1_0;
assign sdr_1_reg[1]  = reg2hw.sdr_1_1;
assign sdr_1_reg[2]  = reg2hw.sdr_1_2;
assign sdr_1_reg[3]  = reg2hw.sdr_1_3;
assign sdr_1_reg[4]  = reg2hw.sdr_1_4;
assign sdr_1_reg[5]  = reg2hw.sdr_1_5;
assign sdr_1_reg[6]  = reg2hw.sdr_1_6;
assign sdr_1_reg[7]  = reg2hw.sdr_1_7;
assign sdr_1_reg[8]  = reg2hw.sdr_1_8;
assign sdr_1_reg[9]  = reg2hw.sdr_1_9;
assign sdr_1_reg[10]  = reg2hw.sdr_1_10;
assign sdr_1_reg[11]  = reg2hw.sdr_1_11;

assign sdr_1_reg[12]  = reg2hw.sdr_1_12;
assign sdr_1_reg[13]  = reg2hw.sdr_1_13;
assign sdr_1_reg[14]  = reg2hw.sdr_1_14;
assign sdr_1_reg[15]  = reg2hw.sdr_1_15;
assign sdr_1_reg[16]  = reg2hw.sdr_1_16;
assign sdr_1_reg[17]  = reg2hw.sdr_1_17;
assign sdr_1_reg[18]  = reg2hw.sdr_1_18;
assign sdr_1_reg[19]  = reg2hw.sdr_1_19;
assign sdr_1_reg[20]  = reg2hw.sdr_1_20;
assign sdr_1_reg[21]  = reg2hw.sdr_1_21;
assign sdr_1_reg[22]  = reg2hw.sdr_1_22;
assign sdr_1_reg[23]  = reg2hw.sdr_1_23;

assign sdr_1_reg[24]  = reg2hw.sdr_1_24;
assign sdr_1_reg[25]  = reg2hw.sdr_1_25;
assign sdr_1_reg[26]  = reg2hw.sdr_1_26;
assign sdr_1_reg[27]  = reg2hw.sdr_1_27;
assign sdr_1_reg[28]  = reg2hw.sdr_1_28;
assign sdr_1_reg[29]  = reg2hw.sdr_1_29;
assign sdr_1_reg[30]  = reg2hw.sdr_1_30;
assign sdr_1_reg[31]  = reg2hw.sdr_1_31;

assign hw2reg.sdr_1_index_0.d = sdr_1_index[0];
assign hw2reg.sdr_1_index_0.de = 1'b1;

assign hw2reg.sdr_1_index_1.d = sdr_1_index[1];
assign hw2reg.sdr_1_index_1.de = 1'b1;

assign hw2reg.sdr_1_index_2.d = sdr_1_index[2];
assign hw2reg.sdr_1_index_2.de = 1'b1;

assign hw2reg.sdr_1_index_3.d = sdr_1_index[3];
assign hw2reg.sdr_1_index_3.de = 1'b1;

assign hw2reg.sdr_1_index_4.d = sdr_1_index[4];
assign hw2reg.sdr_1_index_4.de = 1'b1;

assign hw2reg.sdr_1_index_5.d = sdr_1_index[5];
assign hw2reg.sdr_1_index_5.de = 1'b1;

assign hw2reg.sdr_1_index_6.d = sdr_1_index[6];
assign hw2reg.sdr_1_index_6.de = 1'b1;

assign hw2reg.sdr_1_index_7.d = sdr_1_index[7];
assign hw2reg.sdr_1_index_7.de = 1'b1;

assign hw2reg.sdr_1_index_8.d = sdr_1_index[8];
assign hw2reg.sdr_1_index_8.de = 1'b1;

assign hw2reg.sdr_1_index_9.d = sdr_1_index[9];
assign hw2reg.sdr_1_index_9.de = 1'b1;

assign hw2reg.sdr_1_index_10.d = sdr_1_index[10];
assign hw2reg.sdr_1_index_10.de = 1'b1;

assign hw2reg.sdr_1_index_11.d = sdr_1_index[11];
assign hw2reg.sdr_1_index_11.de = 1'b1;

assign hw2reg.sdr_1_index_12.d = sdr_1_index[12];
assign hw2reg.sdr_1_index_12.de = 1'b1;

assign hw2reg.sdr_1_index_13.d = sdr_1_index[13];
assign hw2reg.sdr_1_index_13.de = 1'b1;

assign hw2reg.sdr_1_index_14.d = sdr_1_index[14];
assign hw2reg.sdr_1_index_14.de = 1'b1;

assign hw2reg.sdr_1_index_15.d = sdr_1_index[15];
assign hw2reg.sdr_1_index_15.de = 1'b1; 


assign hw2reg.sdr_1_status_reg.number_of_indexes.d = sdr_1_status[7:0];
assign hw2reg.sdr_1_status_reg.number_of_indexes.de = 1'b1;

assign hw2reg.sdr_1_status_reg.number_of_ones.d = sdr_1_status[24:8];
assign hw2reg.sdr_1_status_reg.number_of_ones.de = 1'b1;

assign hw2reg.sdr_1_status_reg.unused.de = 1'b0;

assign hw2reg.sdr_1_status_reg.error_indexes_gt_32.d = sdr_1_status[29];
assign hw2reg.sdr_1_status_reg.error_indexes_gt_32.de = 1'b1;

assign hw2reg.sdr_1_status_reg.error_fifo_full.d  = sdr_1_status[30];
assign hw2reg.sdr_1_status_reg.error_fifo_full.de = 1'b1;

assign hw2reg.sdr_1_status_reg.done.d = sdr_1_status[31]; 
assign hw2reg.sdr_1_status_reg.done.de = 1'b1;

/************************SDR_2*****************************************/
assign sdr_2_control = reg2hw.sdr_2_control_reg; //sdr_control_reg.start
assign hw2reg.sdr_2_control_reg.start.d = 1'b0;
assign hw2reg.sdr_2_control_reg.start.de = reg2hw.sdr_2_control_reg.start.q;

assign sdr_2_reg[0]  = reg2hw.sdr_2_0;
assign sdr_2_reg[1]  = reg2hw.sdr_2_1;
assign sdr_2_reg[2]  = reg2hw.sdr_2_2;
assign sdr_2_reg[3]  = reg2hw.sdr_2_3;
assign sdr_2_reg[4]  = reg2hw.sdr_2_4;
assign sdr_2_reg[5]  = reg2hw.sdr_2_5;
assign sdr_2_reg[6]  = reg2hw.sdr_2_6;
assign sdr_2_reg[7]  = reg2hw.sdr_2_7;
assign sdr_2_reg[8]  = reg2hw.sdr_2_8;
assign sdr_2_reg[9]  = reg2hw.sdr_2_9;
assign sdr_2_reg[10]  = reg2hw.sdr_2_10;
assign sdr_2_reg[11]  = reg2hw.sdr_2_11;

assign sdr_2_reg[12]  = reg2hw.sdr_2_12;
assign sdr_2_reg[13]  = reg2hw.sdr_2_13;
assign sdr_2_reg[14]  = reg2hw.sdr_2_14;
assign sdr_2_reg[15]  = reg2hw.sdr_2_15;
assign sdr_2_reg[16]  = reg2hw.sdr_2_16;
assign sdr_2_reg[17]  = reg2hw.sdr_2_17;
assign sdr_2_reg[18]  = reg2hw.sdr_2_18;
assign sdr_2_reg[19]  = reg2hw.sdr_2_19;
assign sdr_2_reg[20]  = reg2hw.sdr_2_20;
assign sdr_2_reg[21]  = reg2hw.sdr_2_21;
assign sdr_2_reg[22]  = reg2hw.sdr_2_22;
assign sdr_2_reg[23]  = reg2hw.sdr_2_23;

assign sdr_2_reg[24]  = reg2hw.sdr_2_24;
assign sdr_2_reg[25]  = reg2hw.sdr_2_25;
assign sdr_2_reg[26]  = reg2hw.sdr_2_26;
assign sdr_2_reg[27]  = reg2hw.sdr_2_27;
assign sdr_2_reg[28]  = reg2hw.sdr_2_28;
assign sdr_2_reg[29]  = reg2hw.sdr_2_29;
assign sdr_2_reg[30]  = reg2hw.sdr_2_30;
assign sdr_2_reg[31]  = reg2hw.sdr_2_31;

assign hw2reg.sdr_2_index_0.d = sdr_2_index[0];
assign hw2reg.sdr_2_index_0.de = 1'b1;

assign hw2reg.sdr_2_index_1.d = sdr_2_index[1];
assign hw2reg.sdr_2_index_1.de = 1'b1;

assign hw2reg.sdr_2_index_2.d = sdr_2_index[2];
assign hw2reg.sdr_2_index_2.de = 1'b1;

assign hw2reg.sdr_2_index_3.d = sdr_2_index[3];
assign hw2reg.sdr_2_index_3.de = 1'b1;

assign hw2reg.sdr_2_index_4.d = sdr_2_index[4];
assign hw2reg.sdr_2_index_4.de = 1'b1;

assign hw2reg.sdr_2_index_5.d = sdr_2_index[5];
assign hw2reg.sdr_2_index_5.de = 1'b1;

assign hw2reg.sdr_2_index_6.d = sdr_2_index[6];
assign hw2reg.sdr_2_index_6.de = 1'b1;

assign hw2reg.sdr_2_index_7.d = sdr_2_index[7];
assign hw2reg.sdr_2_index_7.de = 1'b1;

assign hw2reg.sdr_2_index_8.d = sdr_2_index[8];
assign hw2reg.sdr_2_index_8.de = 1'b1;

assign hw2reg.sdr_2_index_9.d = sdr_2_index[9];
assign hw2reg.sdr_2_index_9.de = 1'b1;

assign hw2reg.sdr_2_index_10.d = sdr_2_index[10];
assign hw2reg.sdr_2_index_10.de = 1'b1;

assign hw2reg.sdr_2_index_11.d = sdr_2_index[11];
assign hw2reg.sdr_2_index_11.de = 1'b1;

assign hw2reg.sdr_2_index_12.d = sdr_2_index[12];
assign hw2reg.sdr_2_index_12.de = 1'b1;

assign hw2reg.sdr_2_index_13.d = sdr_2_index[13];
assign hw2reg.sdr_2_index_13.de = 1'b1;

assign hw2reg.sdr_2_index_14.d = sdr_2_index[14];
assign hw2reg.sdr_2_index_14.de = 1'b1;

assign hw2reg.sdr_2_index_15.d = sdr_2_index[15];
assign hw2reg.sdr_2_index_15.de = 1'b1; 


assign hw2reg.sdr_2_status_reg.number_of_indexes.d = sdr_2_status[7:0];
assign hw2reg.sdr_2_status_reg.number_of_indexes.de = 1'b1;

assign hw2reg.sdr_2_status_reg.number_of_ones.d = sdr_2_status[24:8];
assign hw2reg.sdr_2_status_reg.number_of_ones.de = 1'b1;

assign hw2reg.sdr_2_status_reg.unused.de = 1'b0;

assign hw2reg.sdr_2_status_reg.error_indexes_gt_32.d = sdr_2_status[29];
assign hw2reg.sdr_2_status_reg.error_indexes_gt_32.de = 1'b1;

assign hw2reg.sdr_2_status_reg.error_fifo_full.d  = sdr_2_status[30];
assign hw2reg.sdr_2_status_reg.error_fifo_full.de = 1'b1;

assign hw2reg.sdr_2_status_reg.done.d = sdr_2_status[31]; 
assign hw2reg.sdr_2_status_reg.done.de = 1'b1;

/**********************SDR_3*******************************************/
assign sdr_3_control = reg2hw.sdr_3_control_reg; //sdr_control_reg.start
assign hw2reg.sdr_3_control_reg.start.d = 1'b0;
assign hw2reg.sdr_3_control_reg.start.de = reg2hw.sdr_3_control_reg.start.q;

assign sdr_3_reg[0]  = reg2hw.sdr_3_0;
assign sdr_3_reg[1]  = reg2hw.sdr_3_1;
assign sdr_3_reg[2]  = reg2hw.sdr_3_2;
assign sdr_3_reg[3]  = reg2hw.sdr_3_3;
assign sdr_3_reg[4]  = reg2hw.sdr_3_4;
assign sdr_3_reg[5]  = reg2hw.sdr_3_5;
assign sdr_3_reg[6]  = reg2hw.sdr_3_6;
assign sdr_3_reg[7]  = reg2hw.sdr_3_7;
assign sdr_3_reg[8]  = reg2hw.sdr_3_8;
assign sdr_3_reg[9]  = reg2hw.sdr_3_9;
assign sdr_3_reg[10]  = reg2hw.sdr_3_10;
assign sdr_3_reg[11]  = reg2hw.sdr_3_11;

assign sdr_3_reg[12]  = reg2hw.sdr_3_12;
assign sdr_3_reg[13]  = reg2hw.sdr_3_13;
assign sdr_3_reg[14]  = reg2hw.sdr_3_14;
assign sdr_3_reg[15]  = reg2hw.sdr_3_15;
assign sdr_3_reg[16]  = reg2hw.sdr_3_16;
assign sdr_3_reg[17]  = reg2hw.sdr_3_17;
assign sdr_3_reg[18]  = reg2hw.sdr_3_18;
assign sdr_3_reg[19]  = reg2hw.sdr_3_19;
assign sdr_3_reg[20]  = reg2hw.sdr_3_20;
assign sdr_3_reg[21]  = reg2hw.sdr_3_21;
assign sdr_3_reg[22]  = reg2hw.sdr_3_22;
assign sdr_3_reg[23]  = reg2hw.sdr_3_23;

assign sdr_3_reg[24]  = reg2hw.sdr_3_24;
assign sdr_3_reg[25]  = reg2hw.sdr_3_25;
assign sdr_3_reg[26]  = reg2hw.sdr_3_26;
assign sdr_3_reg[27]  = reg2hw.sdr_3_27;
assign sdr_3_reg[28]  = reg2hw.sdr_3_28;
assign sdr_3_reg[29]  = reg2hw.sdr_3_29;
assign sdr_3_reg[30]  = reg2hw.sdr_3_30;
assign sdr_3_reg[31]  = reg2hw.sdr_3_31;

assign hw2reg.sdr_3_index_0.d = sdr_3_index[0];
assign hw2reg.sdr_3_index_0.de = 1'b1;

assign hw2reg.sdr_3_index_1.d = sdr_3_index[1];
assign hw2reg.sdr_3_index_1.de = 1'b1;

assign hw2reg.sdr_3_index_2.d = sdr_3_index[2];
assign hw2reg.sdr_3_index_2.de = 1'b1;

assign hw2reg.sdr_3_index_3.d = sdr_3_index[3];
assign hw2reg.sdr_3_index_3.de = 1'b1;

assign hw2reg.sdr_3_index_4.d = sdr_3_index[4];
assign hw2reg.sdr_3_index_4.de = 1'b1;

assign hw2reg.sdr_3_index_5.d = sdr_3_index[5];
assign hw2reg.sdr_3_index_5.de = 1'b1;

assign hw2reg.sdr_3_index_6.d = sdr_3_index[6];
assign hw2reg.sdr_3_index_6.de = 1'b1;

assign hw2reg.sdr_3_index_7.d = sdr_3_index[7];
assign hw2reg.sdr_3_index_7.de = 1'b1;

assign hw2reg.sdr_3_index_8.d = sdr_3_index[8];
assign hw2reg.sdr_3_index_8.de = 1'b1;

assign hw2reg.sdr_3_index_9.d = sdr_3_index[9];
assign hw2reg.sdr_3_index_9.de = 1'b1;

assign hw2reg.sdr_3_index_10.d = sdr_3_index[10];
assign hw2reg.sdr_3_index_10.de = 1'b1;

assign hw2reg.sdr_3_index_11.d = sdr_3_index[11];
assign hw2reg.sdr_3_index_11.de = 1'b1;

assign hw2reg.sdr_3_index_12.d = sdr_3_index[12];
assign hw2reg.sdr_3_index_12.de = 1'b1;

assign hw2reg.sdr_3_index_13.d = sdr_3_index[13];
assign hw2reg.sdr_3_index_13.de = 1'b1;

assign hw2reg.sdr_3_index_14.d = sdr_3_index[14];
assign hw2reg.sdr_3_index_14.de = 1'b1;

assign hw2reg.sdr_3_index_15.d = sdr_3_index[15];
assign hw2reg.sdr_3_index_15.de = 1'b1; 


assign hw2reg.sdr_3_status_reg.number_of_indexes.d = sdr_3_status[7:0];
assign hw2reg.sdr_3_status_reg.number_of_indexes.de = 1'b1;

assign hw2reg.sdr_3_status_reg.number_of_ones.d = sdr_3_status[24:8];
assign hw2reg.sdr_3_status_reg.number_of_ones.de = 1'b1;

assign hw2reg.sdr_3_status_reg.unused.de = 1'b0;

assign hw2reg.sdr_3_status_reg.error_indexes_gt_32.d = sdr_3_status[29];
assign hw2reg.sdr_3_status_reg.error_indexes_gt_32.de = 1'b1;

assign hw2reg.sdr_3_status_reg.error_fifo_full.d  = sdr_3_status[30];
assign hw2reg.sdr_3_status_reg.error_fifo_full.de = 1'b1;

assign hw2reg.sdr_3_status_reg.done.d = sdr_3_status[31]; 
assign hw2reg.sdr_3_status_reg.done.de = 1'b1;

assign sdr_logical_op_control_src_1 			= reg2hw.sdr_logical_op_control_reg.sdr_src_1; //sdr_control_reg.start
assign sdr_logical_op_control_src_2 			= reg2hw.sdr_logical_op_control_reg.sdr_src_2; //sdr_control_reg.start
assign sdr_logical_op_control_desination_sdr 	= reg2hw.sdr_logical_op_control_reg.destination_sdr; //sdr_control_reg.start
assign sdr_logical_op_control_logical_operation	= reg2hw.sdr_logical_op_control_reg.bitwise_logical_operation; //sdr_control_reg.start

assign hw2reg.sdr_logical_result_0.d = sdr_logical_result[0];
assign hw2reg.sdr_logical_result_0.de = 1'b1;

assign hw2reg.sdr_logical_result_1.d = sdr_logical_result[1];
assign hw2reg.sdr_logical_result_1.de = 1'b1;

assign hw2reg.sdr_logical_result_2.d = sdr_logical_result[2];
assign hw2reg.sdr_logical_result_2.de = 1'b1;

assign hw2reg.sdr_logical_result_3.d = sdr_logical_result[3];
assign hw2reg.sdr_logical_result_3.de = 1'b1;

assign hw2reg.sdr_logical_result_4.d = sdr_logical_result[4];
assign hw2reg.sdr_logical_result_4.de = 1'b1;

assign hw2reg.sdr_logical_result_5.d = sdr_logical_result[5];
assign hw2reg.sdr_logical_result_5.de = 1'b1;

assign hw2reg.sdr_logical_result_6.d = sdr_logical_result[6];
assign hw2reg.sdr_logical_result_6.de = 1'b1;

assign hw2reg.sdr_logical_result_7.d = sdr_logical_result[7];
assign hw2reg.sdr_logical_result_7.de = 1'b1;

assign hw2reg.sdr_logical_result_8.d = sdr_logical_result[8];
assign hw2reg.sdr_logical_result_8.de = 1'b1;

assign hw2reg.sdr_logical_result_9.d = sdr_logical_result[9];
assign hw2reg.sdr_logical_result_9.de = 1'b1;

assign hw2reg.sdr_logical_result_10.d = sdr_logical_result[10];
assign hw2reg.sdr_logical_result_10.de = 1'b1;

assign hw2reg.sdr_logical_result_11.d = sdr_logical_result[11];
assign hw2reg.sdr_logical_result_11.de = 1'b1;

assign hw2reg.sdr_logical_result_12.d = sdr_logical_result[12];
assign hw2reg.sdr_logical_result_12.de = 1'b1;

assign hw2reg.sdr_logical_result_13.d = sdr_logical_result[13];
assign hw2reg.sdr_logical_result_13.de = 1'b1;

assign hw2reg.sdr_logical_result_14.d = sdr_logical_result[14];
assign hw2reg.sdr_logical_result_14.de = 1'b1;

assign hw2reg.sdr_logical_result_15.d = sdr_logical_result[15];
assign hw2reg.sdr_logical_result_15.de = 1'b1; 

endmodule

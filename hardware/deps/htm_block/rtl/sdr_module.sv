// Copyright Technion IIT.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// 
//


module sdr_module (
	input                  	    	clk_i,
	input				rst_ni,
	//output 	logic 	[0:15]	[31:0]	sdr_index ,
	//output	logic 	    	[31:0]	sdr_status ,
	//input 	logic 	    	[31:0]	sdr_control,
	//input	logic 	[0:31]	[31:0]	sdr_reg,
	//output 	logic	[5:0]		shift_counter, 

  input  htm_block_reg_pkg::htm_block_reg2hw_t reg2hw,
  output htm_block_reg_pkg::htm_block_hw2reg_t hw2reg

);

  import htm_block_reg_pkg::*;

logic 	[0:15]	[31:0]	sdr_index ;
logic 	    	[31:0]	sdr_status;
logic 	    	[31:0]	sdr_control;
logic 	[0:31]	[31:0]	sdr_reg;
logic	[5:0]		shift_counter;




logic  shift_counter_rst;
logic        [5:0]  sdr_indexes_counter; 
logic				sdr_indexes_counter_rst;
logic               sdr_indexes_counter_cnt_dn;
logic               sdr_indexes_counter_en;
int                 sdr_reg_num;
int                 sdr_reg_word_num;
logic				convert_done;

logic				shift_counter_en;
logic [31:0] [4:0]  fifo_data_in;
logic [31:0] [4:0]  fifo_rdata_o;
logic				shift_counter_cnt_dn;
logic				shift_counter_cnt_dn1;
logic [31:0]		fifo_wr;
logic [31:0]		fifo_wready_o;
logic [31:0]		fifo_rvalid_o ;
logic [31:0]		fifo_rready_i ;
logic [31:0]		fifo_full_o ;
logic				sdr_start;
logic				error;
logic				fifo_rready;
logic				fifo_rvalid;
logic				fifo_full;
logic [15:0]		sdr_index_data_in;

int ones;
int total_ones;
int ones_total_value;
int ones_sdr_reg;

// Derive 1 clk pulse on start
assign sdr_control = reg2hw.sdr_control_reg; //sdr_control_reg.start
assign hw2reg.sdr_control_reg.start.d = 1'b0;
assign hw2reg.sdr_control_reg.start.de = reg2hw.sdr_control_reg.start.q;

assign sdr_reg[0]  = reg2hw.sdr_0_0;
assign sdr_reg[1]  = reg2hw.sdr_0_1;
assign sdr_reg[2]  = reg2hw.sdr_0_2;
assign sdr_reg[3]  = reg2hw.sdr_0_3;
assign sdr_reg[4]  = reg2hw.sdr_0_4;
assign sdr_reg[5]  = reg2hw.sdr_0_5;
assign sdr_reg[6]  = reg2hw.sdr_0_6;
assign sdr_reg[7]  = reg2hw.sdr_0_7;
assign sdr_reg[8]  = reg2hw.sdr_0_8;
assign sdr_reg[9]  = reg2hw.sdr_0_9;
assign sdr_reg[10]  = reg2hw.sdr_0_10;
assign sdr_reg[11]  = reg2hw.sdr_0_11;

assign sdr_reg[12]  = reg2hw.sdr_0_12;
assign sdr_reg[13]  = reg2hw.sdr_0_13;
assign sdr_reg[14]  = reg2hw.sdr_0_14;
assign sdr_reg[15]  = reg2hw.sdr_0_15;
assign sdr_reg[16]  = reg2hw.sdr_0_16;
assign sdr_reg[17]  = reg2hw.sdr_0_17;
assign sdr_reg[18]  = reg2hw.sdr_0_18;
assign sdr_reg[19]  = reg2hw.sdr_0_19;
assign sdr_reg[20]  = reg2hw.sdr_0_20;
assign sdr_reg[21]  = reg2hw.sdr_0_21;
assign sdr_reg[22]  = reg2hw.sdr_0_22;
assign sdr_reg[23]  = reg2hw.sdr_0_23;

assign sdr_reg[24]  = reg2hw.sdr_0_24;
assign sdr_reg[25]  = reg2hw.sdr_0_25;
assign sdr_reg[26]  = reg2hw.sdr_0_26;
assign sdr_reg[27]  = reg2hw.sdr_0_27;
assign sdr_reg[28]  = reg2hw.sdr_0_28;
assign sdr_reg[29]  = reg2hw.sdr_0_29;
assign sdr_reg[30]  = reg2hw.sdr_0_30;
assign sdr_reg[31]  = reg2hw.sdr_0_31;




assign hw2reg.sdr_index_0_0.d = sdr_index[0];
assign hw2reg.sdr_index_0_0.de = 1'b1;

assign hw2reg.sdr_index_0_1.d = sdr_index[1];
assign hw2reg.sdr_index_0_1.de = 1'b1;

assign hw2reg.sdr_index_0_2.d = sdr_index[2];
assign hw2reg.sdr_index_0_2.de = 1'b1;

assign hw2reg.sdr_index_0_3.d = sdr_index[3];
assign hw2reg.sdr_index_0_3.de = 1'b1;

assign hw2reg.sdr_index_0_4.d = sdr_index[4];
assign hw2reg.sdr_index_0_4.de = 1'b1;

assign hw2reg.sdr_index_0_5.d = sdr_index[5];
assign hw2reg.sdr_index_0_5.de = 1'b1;

assign hw2reg.sdr_index_0_6.d = sdr_index[6];
assign hw2reg.sdr_index_0_6.de = 1'b1;

assign hw2reg.sdr_index_0_7.d = sdr_index[7];
assign hw2reg.sdr_index_0_7.de = 1'b1;

assign hw2reg.sdr_index_0_8.d = sdr_index[8];
assign hw2reg.sdr_index_0_8.de = 1'b1;

assign hw2reg.sdr_index_0_9.d = sdr_index[9];
assign hw2reg.sdr_index_0_9.de = 1'b1;

assign hw2reg.sdr_index_0_10.d = sdr_index[10];
assign hw2reg.sdr_index_0_10.de = 1'b1;

assign hw2reg.sdr_index_0_11.d = sdr_index[11];
assign hw2reg.sdr_index_0_11.de = 1'b1;

assign hw2reg.sdr_index_0_12.d = sdr_index[12];
assign hw2reg.sdr_index_0_12.de = 1'b1;

assign hw2reg.sdr_index_0_13.d = sdr_index[13];
assign hw2reg.sdr_index_0_13.de = 1'b1;

assign hw2reg.sdr_index_0_14.d = sdr_index[14];
assign hw2reg.sdr_index_0_14.de = 1'b1;

assign hw2reg.sdr_index_0_15.d = sdr_index[15];
assign hw2reg.sdr_index_0_15.de = 1'b1; 


assign hw2reg.sdr_status_reg.number_of_indexes.d = sdr_status[7:0];
assign hw2reg.sdr_status_reg.number_of_indexes.de = 1'b1;

assign hw2reg.sdr_status_reg.number_of_ones.d = sdr_status[24:8];
assign hw2reg.sdr_status_reg.number_of_ones.de = 1'b1;

assign hw2reg.sdr_status_reg.unused.de = 1'b0;

assign hw2reg.sdr_status_reg.error_indexes_gt_32.d = sdr_status[29];
assign hw2reg.sdr_status_reg.error_indexes_gt_32.de = 1'b1;

assign hw2reg.sdr_status_reg.error_fifo_full.d  = sdr_status[30];
assign hw2reg.sdr_status_reg.error_fifo_full.de = 1'b1;

assign hw2reg.sdr_status_reg.done.d = sdr_status[31]; 
assign hw2reg.sdr_status_reg.done.de = 1'b1;



/////**************************************
ones_count_status ones_count_status (
        .clk_i			(clk_i			),
        .rst_ni			(rst_ni			),
	.sdr_start		(shift_counter_rst	),
        .ones_total_value 	(ones_total_value	),
        .ones_sdr_reg		(ones_sdr_reg		),
        .sdr_reg		(sdr_reg		)


);


assign 		sdr_start = sdr_control[31];
assign  fifo_rvalid = |fifo_rvalid_o;
assign  fifo_full = |fifo_full_o;

sdr_control_fsm sdr_control_fsm (
	.clk_i						(clk_i						),
	.rst_ni						(rst_ni						),
	.sdr_start					(sdr_start					),
	.fifo_rready_i				(fifo_rready				),
	.shift_counter_rst			(shift_counter_rst			),
	.shift_counter_en			(shift_counter_en			),
	.shift_counter_cnt_dn		(shift_counter_cnt_dn		),
	.fifo_rvalid_o				(fifo_rvalid				),
	.sdr_indexes_counter_cnt_dn	(sdr_indexes_counter_cnt_dn	),
	.sdr_indexes_counter_rst	(sdr_indexes_counter_rst	),
	.fifo_clr_i					(fifo_clr_i					),
	.convert_done				(convert_done				),
	.error_fifo_full			(error_fifo_full			),
	.error_st					(error_st					),	
	.fifo_full					(fifo_full      			)
	
 );


sdr_counter shift_counter_module (
  .clk_i			(clk_i 					),
  .rst_ni			(rst_ni					),
  .counter_rst		(shift_counter_rst		),
  .counter_en		(shift_counter_en		),
  .counter_cnt_dn	(shift_counter_cnt_dn	),
  .counter			(shift_counter			)


);

fifo_indexes_output_prioriy_encoder fifo_indexes_output_prioriy_encoder (
	.clk_i				(clk_i				),
	.rst_ni				(rst_ni				),
	.fifo_rready		(fifo_rready		),
	.fifo_rvalid_o		(fifo_rvalid_o		),
	.fifo_rready_i		(fifo_rready_i		),
	.fifo_rdata_o		(fifo_rdata_o		),
	.sdr_index_data_in	(sdr_index_data_in	) 

);


genvar i;
generate
   for (i=0; i<32; i++) begin : g

		assign fifo_data_in[i] = (sdr_reg[i][shift_counter]) ? shift_counter : 0;
		assign fifo_wr[i] = (sdr_reg[i][shift_counter] && shift_counter_en) ? 1'b1 : 1'b0;
		
		prim_ot_fifo_sync 
		#(
		.Width(5),
		.Depth(32)
		) fifo_indexes (
		.clk_i		(clk_i),
		.rst_ni		(rst_ni),
		// synchronous clear / flush port
		.clr_i		(fifo_clr_i),
		// write port
		.wvalid_i	(fifo_wr[i]),
		.wready_o	(fifo_wready_o[i]),
		.wdata_i	(fifo_data_in[i]),
		// read port
		.rvalid_o	(fifo_rvalid_o[i] ),
		.rready_i	(fifo_rready_i[i]),
		.rdata_o	(fifo_rdata_o[i]),
		// occupancy
		.full_o		(fifo_full_o[i]),
		.depth_o	(),
		.err_o		()
		);

   end : g
endgenerate


assign sdr_indexes_counter_en = (fifo_rready_i &&  fifo_rvalid_o) ? 1'b1:1'b0;

sdr_counter sdr_indexes_counter_module (
  .clk_i			(clk_i 						),
  .rst_ni			(rst_ni						),
  .counter_rst		(sdr_indexes_counter_rst	),
  .counter_en		(sdr_indexes_counter_en		),
  .counter_cnt_dn	(sdr_indexes_counter_cnt_dn	),
  .counter			(sdr_indexes_counter		)


);
  assign sdr_status[31] = convert_done; 
  assign sdr_status[30] = error_fifo_full;
  assign sdr_status[29] = error_st;
  assign sdr_status[28:8] = ones_total_value;
  assign sdr_status[7:0] = sdr_indexes_counter;

  assign sdr_reg_num = sdr_indexes_counter/2;
  assign sdr_reg_word_num = sdr_indexes_counter%2;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
  	 sdr_index <= '{default : 132'hFFFF_FFFF};
    end else if (sdr_indexes_counter_rst ) begin
	 sdr_index <= '{default : 32'hFFFF_FFFF};
    end else if (sdr_indexes_counter_en ) begin
	 sdr_index[sdr_reg_num][(16*sdr_reg_word_num)+:16] <= sdr_index_data_in;
    end
  end
endmodule

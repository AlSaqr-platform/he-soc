// Copyright Technion IIT.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// 
//

module sdr_module (
	input                  	    clk_i,
	input						rst_ni,
	output 	logic [0:15][31:0]	sdr_index ,
	output	logic 	    [31:0]	sdr_status ,
	input 	logic 	    [31:0]	sdr_control,
	input	logic [0:31][31:0]	sdr_reg,
	output 	logic		[5:0]	shift_counter 

  //input  perfcounters_t_reg_pkg::perfcounters_t_reg2hw_t reg2hw,
  //output perfcounters_t_reg_pkg::perfcounters_t_hw2reg_t hw2reg

);
  //import perfcounters_t_reg_pkg::*;


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
ones_count_status ones_count_status (
        .clk_i			(clk_i			),
        .rst_ni			(rst_ni			),
	.sdr_start		(shift_counter_rst	),
        .ones_total_value 	(ones_total_value	),
        .ones_sdr_reg		(ones_sdr_reg		),
        .sdr_reg		(sdr_reg		)


);


assign 		sdr_start = sdr_control[0];
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

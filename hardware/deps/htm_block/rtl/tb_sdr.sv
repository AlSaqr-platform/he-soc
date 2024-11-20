// Copyright Technion IIT.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// 
//

module tb_sdr (

);



logic                  	clk_i=1'b1;;
logic			rst_ni;
logic [0:15][31:0]	sdr_index ;
logic 	    [31:0]	sdr_status ;
logic 	    [31:0]	sdr_control;

logic		[5:0]	shift_counter; 
logic	[0:31][31:0]  INDEX;

logic [31:0] sdr_status_expected;
logic	[15:0] 		INDEX_EXPECTED ;
logic	[15:0] 		INDEX_READ; 
int index_count;
int index_place ;

typedef union packed {
     logic [0:31][31:0]	sdr_reg;
     logic [1023:0] sdr_1024;
} union_type;

union_type my_sdr_union;

class packet;
	rand bit [9:0] index;
	constraint c_dist {
		index dist 	{[0:1023]:=100};
	}
endclass

class iterations;
	rand bit [47:0] num_bits;
	constraint c_dist {
		num_bits dist	{[15:25]:=90, [25:64]:= 10};
	}
endclass

packet my_packet;
iterations my_iterations;
int loop_count; 

real period = 100ns;
initial forever
   #(period/2.0) clk_i = ~clk_i;

initial begin
	rst_ni = 1'b0;
	sdr_control= 32'h0;
	#1us
	rst_ni = 1'b1;
	#1us
	sdr_control= 32'h8000_0000;
	#1us
	sdr_control= 32'h0;
	#15us
	sdr_control= 32'h8000_0000;
	#1us
	sdr_control= 32'h0;
	#20us
	sdr_control= 32'h8000_0000;
	#200ns
	sdr_control= 32'h0;
end

task compare_indexes();

	assign index_count = sdr_status_expected[7:0];
	for ( int z=0;z < index_count;z++) begin
		index_place = 16*((z)%2);
		INDEX_EXPECTED = INDEX[(z)/2][index_place+:16] ;
		INDEX_READ     = sdr_module.sdr_index[(z)/2][index_place+:16] ;

		
		if (INDEX_EXPECTED !== INDEX_READ)
			$display("****** INDEXES MISMATCH REGISTER READ [%d] = %x %x",z, INDEX_EXPECTED, INDEX_READ);
		else begin
			$display("FINAL INDEX REGISTER READ [%d] = %x",z, INDEX_READ);
			$display("INDEX EXPECTED            [%d] = %x",z, INDEX_EXPECTED);
		end
		if (sdr_module.sdr_status !== sdr_status_expected)
			$display("STATUS MISMATCH EXPECTED VS ACTUAL   = %x %x", sdr_status_expected, sdr_module.sdr_status);
	end

endtask

task total_ones_tb_print();
int ones;
int total_ones;
int index_count;
int index_place ;


        total_ones = 0;
	index_count = 0;
	for ( int z=0;z <=31;z++) begin
		$display("SDR [%d] = 32'h%8x",z, my_sdr_union.sdr_reg[z]);
		ones = 0;
		for (int y=0;y <=31;y++) begin
			ones = ones + my_sdr_union.sdr_reg[z][y];
			if (my_sdr_union.sdr_reg[z][y]) begin
				index_place = 16*(index_count%2);
				INDEX[index_count/2][index_place+:16] = y+32*z;
				index_count++;
			end
		end
		total_ones = total_ones + ones;

	end
	$display("Total ones [%d] ",total_ones);
		sdr_status_expected[31:0] = 32'h8000_0000;
		sdr_status_expected[24:8] = total_ones;
		if (total_ones <= 31 )
			sdr_status_expected[7:0] = total_ones;
		else begin
			sdr_status_expected[7:0] = 31;
			sdr_status_expected[29] = 1'b1;
		end
	$display("sdr_status_expected [%x] ",sdr_status_expected);
endtask


initial begin

	my_sdr_union.sdr_reg[0]  = { 32'h0000_FFFF};
	my_sdr_union.sdr_reg[1]  = { 32'h0};
	my_sdr_union.sdr_reg[2]  = { 32'h0};
	my_sdr_union.sdr_reg[3]  = { 32'h0};
	my_sdr_union.sdr_reg[4]  = { 32'h0};
	my_sdr_union.sdr_reg[5]  = { 32'h0};
	my_sdr_union.sdr_reg[6]  = { 32'h0};
	my_sdr_union.sdr_reg[7]  = { 32'h0};
	my_sdr_union.sdr_reg[8]  = { 32'h0};
	my_sdr_union.sdr_reg[9]  = { 32'h0};
	my_sdr_union.sdr_reg[10] = { 32'h0};
	my_sdr_union.sdr_reg[11] = { 32'h0};
	my_sdr_union.sdr_reg[12] = { 32'h0};
	my_sdr_union.sdr_reg[13] = { 32'h0};
	my_sdr_union.sdr_reg[14] = { 32'h0};
	my_sdr_union.sdr_reg[15] = { 32'h0};
	my_sdr_union.sdr_reg[16] = { 32'h0};
	my_sdr_union.sdr_reg[17] = { 32'h0};
	my_sdr_union.sdr_reg[18] = { 32'h0};
	my_sdr_union.sdr_reg[19] = { 32'h0};
	my_sdr_union.sdr_reg[20] = { 32'h0};
	my_sdr_union.sdr_reg[21] = { 32'h0};
	my_sdr_union.sdr_reg[22] = { 32'h0};
	my_sdr_union.sdr_reg[23] = { 32'h0};
	my_sdr_union.sdr_reg[24] = { 32'h0};
	my_sdr_union.sdr_reg[25] = { 32'h0};
	my_sdr_union.sdr_reg[26] = { 32'h0};
	my_sdr_union.sdr_reg[27] = { 32'h0};
	my_sdr_union.sdr_reg[28] = { 32'h0};
	my_sdr_union.sdr_reg[29] = { 32'h0};
	my_sdr_union.sdr_reg[30] = { 32'h0};
	my_sdr_union.sdr_reg[31] = { 32'h0 };

        @(posedge sdr_control[31]);
total_ones_tb_print();
        @(negedge sdr_control[31]);
	wait (	sdr_status[31] == 1'b1) ;
compare_indexes();
	#8us


	
	my_sdr_union.sdr_reg[0] = { 32'h0F02_7850};
	my_sdr_union.sdr_reg[1] = { 32'h1824_1000};
	my_sdr_union.sdr_reg[2] = { 32'h1110_1110};
	my_sdr_union.sdr_reg[3] = { 32'h0000_0100};
	my_sdr_union.sdr_reg[4] = { 32'h1};
	my_sdr_union.sdr_reg[5] = { 32'h0};
	my_sdr_union.sdr_reg[6] = { 32'h0};
	my_sdr_union.sdr_reg[7] = { 32'h0};
	my_sdr_union.sdr_reg[8] = { 32'h0};
	my_sdr_union.sdr_reg[9] = { 32'h0};
	my_sdr_union.sdr_reg[10] = { 32'h0};
	my_sdr_union.sdr_reg[11] = { 32'h0};
	my_sdr_union.sdr_reg[12] = { 32'h0};
	my_sdr_union.sdr_reg[13] = { 32'h0};
	my_sdr_union.sdr_reg[14] = { 32'h0};
	my_sdr_union.sdr_reg[15] = { 32'h0};
	my_sdr_union.sdr_reg[16] = { 32'h0};
	my_sdr_union.sdr_reg[17] = { 32'h0};
	my_sdr_union.sdr_reg[18] = { 32'h0};
	my_sdr_union.sdr_reg[19] = { 32'h0};
	my_sdr_union.sdr_reg[20] = { 32'h0};
	my_sdr_union.sdr_reg[21] = { 32'h0};
	my_sdr_union.sdr_reg[22] = { 32'h0};
	my_sdr_union.sdr_reg[23] = { 32'h0};
	my_sdr_union.sdr_reg[24] = { 32'h0};
	my_sdr_union.sdr_reg[25] = { 32'h0};
	my_sdr_union.sdr_reg[26] = { 32'h0};
	my_sdr_union.sdr_reg[27] = { 32'h0};
	my_sdr_union.sdr_reg[28] = { 32'h0};
	my_sdr_union.sdr_reg[29] = { 32'h0};
	my_sdr_union.sdr_reg[30] = { 32'h0000_0000};
	my_sdr_union.sdr_reg[31] = { 32'h1000_0000 };
        @(posedge sdr_control[31]);
total_ones_tb_print();
	@(negedge sdr_control[31]);
	wait (	sdr_status[31] == 1'b1) ;
	compare_indexes();

	#7us


	
	my_sdr_union.sdr_reg[0] = { 32'hA7F3_1650};
	my_sdr_union.sdr_reg[1] = { 32'h7402_89A0};
	my_sdr_union.sdr_reg[2] = { 32'h8252_8201};
	my_sdr_union.sdr_reg[3] = { 32'h8000_0000};
	my_sdr_union.sdr_reg[4] = { 32'h0};
	my_sdr_union.sdr_reg[5] = { 32'h0};
	my_sdr_union.sdr_reg[6] = { 32'h0};
	my_sdr_union.sdr_reg[7] = { 32'h0};
	my_sdr_union.sdr_reg[8] = { 32'h0};
	my_sdr_union.sdr_reg[9] = { 32'h0};
	my_sdr_union.sdr_reg[10] = { 32'h0};
	my_sdr_union.sdr_reg[11] = { 32'h0};
	my_sdr_union.sdr_reg[12] = { 32'h0};
	my_sdr_union.sdr_reg[13] = { 32'h0};
	my_sdr_union.sdr_reg[14] = { 32'h0};
	my_sdr_union.sdr_reg[15] = { 32'h0};
	my_sdr_union.sdr_reg[16] = { 32'h0};
	my_sdr_union.sdr_reg[17] = { 32'h0};
	my_sdr_union.sdr_reg[18] = { 32'h0};
	my_sdr_union.sdr_reg[19] = { 32'h0};
	my_sdr_union.sdr_reg[20] = { 32'h0};
	my_sdr_union.sdr_reg[21] = { 32'h0};
	my_sdr_union.sdr_reg[22] = { 32'h0};
	my_sdr_union.sdr_reg[23] = { 32'h0};
	my_sdr_union.sdr_reg[24] = { 32'h0};
	my_sdr_union.sdr_reg[25] = { 32'h0};
	my_sdr_union.sdr_reg[26] = { 32'h0};
	my_sdr_union.sdr_reg[27] = { 32'h0};
	my_sdr_union.sdr_reg[28] = { 32'h0};
	my_sdr_union.sdr_reg[29] = { 32'hFF};
	my_sdr_union.sdr_reg[30] = { 32'hC000_0003};
	my_sdr_union.sdr_reg[31] = { 32'hE000_0000 };
        @(posedge sdr_control[31]);
total_ones_tb_print();
    	@(negedge sdr_control[31]); 
	wait (	sdr_status[31] == 1'b1) ;
	compare_indexes();

 
my_packet = new();
 my_iterations = new();
 
 loop_count = 0;
 repeat (10) begin
 	my_iterations.randomize();
	my_sdr_union.sdr_1024 = '{default:'0};
	loop_count = 0;
        //$display ("****num_bits is %d\n", my_iterations.num_bits);
 	repeat(my_iterations.num_bits) begin
		my_packet.randomize();
           	//$display ("index is %d %d\n", my_packet.index, loop_count);
		loop_count++;
       		
		my_sdr_union.sdr_1024[my_packet.index] = 1'b1;
        end
	sdr_control= 32'h8000_0000;
	#1us
	sdr_control= 32'h0;
	total_ones_tb_print();
	wait (	sdr_status[31] == 1'b1) ;
	compare_indexes();
 end

end


sdr_module sdr_module (
        .clk_i		(clk_i			),
        .rst_ni		(rst_ni			),
        .sdr_index 	(sdr_index		),
        .sdr_status 	(sdr_status		),
        .sdr_control	(sdr_control		),
        .sdr_reg	(my_sdr_union.sdr_reg	),
        .shift_counter	(shift_counter		)

);

endmodule

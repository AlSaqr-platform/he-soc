// Copyright Technion IIT.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// 
//

module ones_count_status (
	input                  	    clk_i,
	input				rst_ni,
	input   logic      sdr_start,
	output	logic 	    [31:0]	ones_total_value ,
	output 	logic 	    [31:0]	ones_sdr_reg,
	input	logic [0:31][31:0]	sdr_reg


);

logic sdr_start_d;
logic calculate;
logic reset_counter;



  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
	ones_total_value <= 32'h0;
	sdr_start_d	 <= 1'b0;
	reset_counter	 <= 1'b0;
	calculate	 <= 1'b0;
    end
    else begin
	reset_counter	<= sdr_start & ~sdr_start_d;
	calculate	<= reset_counter;
	sdr_start_d	<= sdr_start;
	if (reset_counter) begin
		ones_sdr_reg	<= 32'h0;
		ones_total_value <= 32'h0;
	end
	else if (calculate) begin
               for (int i=0;i <= 31;i= i + 1) begin
                  ones_sdr_reg = 0;
                  for (int y=0;y <= 31;y++) begin
                    ones_sdr_reg = ones_sdr_reg + sdr_reg[i][y];
                  end
                  ones_total_value = ones_total_value + ones_sdr_reg;
	           end
	         end
	end
    end

endmodule

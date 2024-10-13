// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Description: 
//

module sdr_counter (
  input						clk_i,
  input						rst_ni,
  input		logic 			counter_rst,
  input		logic			counter_en,
  output	logic			counter_cnt_dn,
  output 	logic [5:0]		counter 


);




assign counter_cnt_dn = (counter == 31) ? 1'b1:1'b0;

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
  	 counter <= 32'b0;
    end else if (counter_rst ) begin
  	 counter <= 32'b0;
    end else if (counter_en && !counter_cnt_dn) begin
	 counter <= counter + 1'b1;
    end
  end
endmodule

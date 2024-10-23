module fifo_indexes_output_prioriy_encoder (
  input                  	    		clk_i,
  input						rst_ni,
  input 	logic				fifo_rready ,
  input 	logic		[31:0]  	fifo_rvalid_o,
  output	logic		[31:0]		fifo_rready_i ,
  input 	logic		[31:0] [4:0]	fifo_rdata_o,
  output 	logic		[15:0]		sdr_index_data_in 

);
always_comb	begin
	fifo_rready_i     = '{default : 0};
	sdr_index_data_in = 16'hFFFF;
	for (int i = 0; i <=31;i++) begin
		if ( fifo_rvalid_o[i] ) begin
			fifo_rready_i[i] = fifo_rready;
			sdr_index_data_in = { 11'b0,fifo_rdata_o[i]} + i*32;
			break;
		end
	end

end

endmodule
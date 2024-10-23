///////////////////////////////////////////////////////////////////////////////
//
// Description: htm_control_fsm
//
///////////////////////////////////////////////////////////////////////////////
//
// Authors    : 
//
///////////////////////////////////////////////////////////////////////////////

module sdr_control_fsm (
     input  logic            clk_i,
     input  logic            rst_ni,
     input  logic            sdr_start,
     input  logic            shift_counter_cnt_dn,
     input  logic            fifo_rvalid_o,
     output logic            fifo_rready_i,
     output logic            shift_counter_rst,
     output logic            shift_counter_en,
     input  logic            sdr_indexes_counter_cnt_dn,
     output logic            sdr_indexes_counter_rst,
     output logic            fifo_clr_i,
     output logic            convert_done,
     output logic            error_fifo_full,
     output logic            error_st,
     input  logic            fifo_full
 );


    enum logic [2:0] {IDLE,SHIFT_DATA_st, SDR_INDEX_st, SDR_DONE_st, SDR_ERROR_st} CS,NS;


    assign busy_o = (CS != IDLE);

    always_comb
    begin
        NS                  = CS;

        case(CS)

           IDLE:
           begin
		if (sdr_start)	begin
			NS = SHIFT_DATA_st;
		end
		else begin
			NS = IDLE;
		end
           end


           SHIFT_DATA_st:
           begin
		if (shift_counter_cnt_dn)	begin
			NS = SDR_INDEX_st;
		end
		else begin
			NS = SHIFT_DATA_st;
		end
           end

           SDR_INDEX_st:
           begin
		if (sdr_indexes_counter_cnt_dn)		
			NS = SDR_ERROR_st;
		else if (!(fifo_rvalid_o ))	begin
			NS = SDR_DONE_st;
		end
		else begin
			NS = SDR_INDEX_st;
		end
           end
           SDR_DONE_st:
           begin
		if (sdr_start)	begin
			//NS = IDLE;
			NS = SHIFT_DATA_st;
		end else begin
			NS = SDR_DONE_st;
		end
           end
	   SDR_ERROR_st:
           begin
		if (sdr_start)	begin
			//NS = IDLE;
			NS = SHIFT_DATA_st;
		end else begin
			NS = SDR_ERROR_st;
		end
           end

           default:
           NS = IDLE;

        endcase
    end

    always_ff @(posedge clk_i or negedge rst_ni)
    begin
        if (rst_ni == 1'b0)
        begin
		//NS			<= IDLE;
		CS			<= IDLE;
	end
	else
	begin
		CS	<= NS;
	end
    end

    always_comb
    begin
        begin
		//CS	<= NS;
	        case(CS)
           	IDLE:
           	begin
	                 shift_counter_rst       <= 1'b1;
       		         shift_counter_en        <= 1'b0;
       		         fifo_rready_i           <= 1'b0;
       		         sdr_indexes_counter_rst <= 1'b1;
       		         fifo_clr_i              <= 1'b1;
     		 	 convert_done	         <= 1'b0;
			 error_fifo_full	 <= 1'b0;
			 error_st		 <= 1'b0;
		end
           	SHIFT_DATA_st:
           	begin
	                 shift_counter_rst       <= 1'b0;
			 if (shift_counter_cnt_dn)
				shift_counter_en        <= 1'b0;
			 else
       		         	shift_counter_en        <= 1'b1;
       		         fifo_rready_i           <= 1'b0;
       		         sdr_indexes_counter_rst <= 1'b1;
       		         fifo_clr_i              <= 1'b0;
     		 	 convert_done	         <= 1'b0;
			 error_fifo_full	 <= fifo_full;
			 error_st		 <= 1'b0;
		end
           	SDR_INDEX_st:
           	begin
	                 shift_counter_rst       <= 1'b0;
       		         shift_counter_en        <= 1'b0;
       		         fifo_rready_i           <= 1'b1;
       		         sdr_indexes_counter_rst <= 1'b0;
       		         fifo_clr_i              <= 1'b0;
			 //error_fifo_full	 <= 1'b0;
		         error_st		 <= 1'b0;
			 if (!fifo_rvalid_o )
     		 	 	convert_done	         <= 1'b1;
			 else
				convert_done	         <= 1'b0;
			 if (sdr_indexes_counter_cnt_dn)
				error_st		 <= 1'b1;
		end
           	SDR_DONE_st:
           	begin
			 //error_fifo_full	 <= 1'b0;
			 error_st		 <= 1'b0;
			 if (sdr_start)	begin
	                 	shift_counter_rst       <= 1'b1;
       		         	shift_counter_en        <= 1'b0;
       		         	fifo_rready_i           <= 1'b0;
       		         	sdr_indexes_counter_rst <= 1'b1;
       		         	fifo_clr_i              <= 1'b1;
     		 	 	convert_done	        <= 1'b0;
			end else begin
	                 	shift_counter_rst       <= 1'b0;
       		         	shift_counter_en        <= 1'b0;
       		         	fifo_rready_i           <= 1'b0;
       		         	sdr_indexes_counter_rst <= 1'b0;
       		         	fifo_clr_i              <= 1'b0;
     		 	 	convert_done	        <= 1'b1;
			end
		end
		SDR_ERROR_st:
           	begin
			 //error_fifo_full	 <= 1'b0;
			 error_st		 <= 1'b1;
			 if (sdr_start)	begin
	                 	shift_counter_rst       <= 1'b1;
       		         	shift_counter_en        <= 1'b0;
       		         	fifo_rready_i           <= 1'b0;
       		         	sdr_indexes_counter_rst <= 1'b1;
       		         	fifo_clr_i              <= 1'b1;
     		 	 	convert_done	        <= 1'b0;
				error_st		<= 1'b0;
			end else begin
	                 	shift_counter_rst       <= 1'b0;
       		         	shift_counter_en        <= 1'b0;
       		         	fifo_rready_i           <= 1'b0;
       		         	sdr_indexes_counter_rst <= 1'b0;
       		         	fifo_clr_i              <= 1'b0;
     		 	 	convert_done	        <= 1'b1;
			end
		end
		default: 
		begin
			shift_counter_rst	<= 1'b1;
			shift_counter_en	<= 1'b0;
			fifo_rready_i		<= 1'b0;
     			sdr_indexes_counter_rst <= 1'b1;
     			fifo_clr_i		<= 1'b1;
     			convert_done		<= 1'b0;
			error_fifo_full	 	<= 1'b0;
			error_st		<= 1'b0;
		end
		endcase

        end
    end

endmodule

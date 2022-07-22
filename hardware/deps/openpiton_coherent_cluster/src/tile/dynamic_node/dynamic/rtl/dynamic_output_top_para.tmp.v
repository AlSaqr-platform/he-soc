/*
Copyright (c) 2015 Princeton University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Princeton University nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY PRINCETON UNIVERSITY "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL PRINCETON UNIVERSITY BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

//Function: The top level module that glues together the datapath and
//the control for a dynamic_output port
//
//Instantiates: dynamic_output_control_para dynamic_output_datapath_para space_avail
//
//State: NONE
//
//Note:
//
`include "network_define.v"
// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml

module dynamic_output_top_para(data_out, 
                          thanks_0_out, thanks_1_out, 
                          valid_out, popped_interrupt_mesg_out, popped_memory_ack_mesg_out, popped_memory_ack_mesg_out_sender, ec_wants_to_send_but_cannot, clk, reset, 
                          route_req_0_in, route_req_1_in, 
                          tail_0_in, tail_1_in, 
                          data_0_in, data_1_in, 
                          valid_0_in, valid_1_in, 
                          default_ready_in, yummy_in);

parameter KILL_HEADERS = 1'b0;

// begin port declarations
output [`DATA_WIDTH-1:0] data_out;

output thanks_0_out;
output thanks_1_out;

output valid_out;

output popped_interrupt_mesg_out;
output popped_memory_ack_mesg_out;
output [9:0] popped_memory_ack_mesg_out_sender;

output ec_wants_to_send_but_cannot;

input clk;
input reset;

input route_req_0_in;
input route_req_1_in;

input tail_0_in;
input tail_1_in;

input [`DATA_WIDTH-1:0] data_0_in;
input [`DATA_WIDTH-1:0] data_1_in;
input valid_0_in;
input valid_1_in;

input default_ready_in;
input yummy_in;

// end port declarations
`define ROUTE_0 1'b0
`define ROUTE_1 1'b1

//This is the state
//NOTHING HERE BUT US CHICKENS

//inputs to the state
//NOTHING HERE EITHER

//wires
wire valid_out_temp_connection;
wire [0:0] current_route_connection;
wire space_avail_connection;
wire valid_out_pre;
wire data_out_len_zero;
wire data_out_interrupt_user_bits_set;
wire data_out_memory_ack_user_bits_set;
wire [`DATA_WIDTH-1:0] data_out_internal;
wire valid_out_internal;

//wire regs
reg current_route_req;

//assigns
assign valid_out_internal = valid_out_pre & ~(KILL_HEADERS & current_route_req);
assign data_out_len_zero = data_out_internal[`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH-4:`DATA_WIDTH-`CHIP_ID_WIDTH-2*`XY_WIDTH-3-`PAYLOAD_LEN] == `PAYLOAD_LEN'd0;
assign data_out_interrupt_user_bits_set = data_out_internal[23:20] == 4'b1111;
assign data_out_memory_ack_user_bits_set = data_out_internal[23:20] == 4'b1110;
//assign popped_zero_len_mesg_out = data_out_len_zero & valid_out_pre & (KILL_HEADERS & current_route_req);
assign popped_interrupt_mesg_out = data_out_interrupt_user_bits_set & data_out_len_zero & valid_out_pre & (KILL_HEADERS & current_route_req);
assign popped_memory_ack_mesg_out = data_out_memory_ack_user_bits_set & data_out_len_zero & valid_out_pre & (KILL_HEADERS & current_route_req);
assign popped_memory_ack_mesg_out_sender = data_out_internal[19:10] & { 10 { KILL_HEADERS} };

assign data_out = data_out_internal;
assign valid_out = valid_out_internal;

//instantiations
space_avail_top space(.valid(valid_out_internal), .clk(clk), .reset(reset), .yummy(yummy_in),.spc_avail(space_avail_connection));

dynamic_output_datapath_para datapath(.data_out(data_out_internal), .valid_out_temp(valid_out_temp_connection), .data_0_in(data_0_in), .data_1_in(data_1_in), .valid_0_in(valid_0_in), .valid_1_in(valid_1_in), .current_route_in(current_route_connection));


dynamic_output_control_para control(.thanks_0(thanks_0_out), .thanks_1(thanks_1_out), 
                               .valid_out(valid_out_pre), .current_route(current_route_connection), .ec_wants_to_send_but_cannot(ec_wants_to_send_but_cannot), .clk(clk), .reset(reset), 
                               .route_req_0_in(route_req_0_in), .route_req_1_in(route_req_1_in), 
                               .tail_0_in(tail_0_in), .tail_1_in(tail_1_in), 
                               .valid_out_temp(valid_out_temp_connection), .default_ready(default_ready_in), .space_avail(space_avail_connection));
//NOTE TO READER.  I like the way that these instantiations look so if it
//really bothers you go open this in emacs and re-tabify everything
//and don't complain to me
always @ (current_route_connection or route_req_0_in or route_req_1_in)
begin
	case(current_route_connection)
    
	`ROUTE_0:    current_route_req <= route_req_0_in;
	`ROUTE_1:    current_route_req <= route_req_1_in;

    /*
    //original
	`ROUTE_A:	current_route_req <= route_req_a_in;
	`ROUTE_B:	current_route_req <= route_req_b_in;
	`ROUTE_C:	current_route_req <= route_req_c_in;
	`ROUTE_D:	current_route_req <= route_req_d_in;
	`ROUTE_X:	current_route_req <= route_req_x_in;
    */
	default:	current_route_req <= 1'bx;
	endcase
end

endmodule

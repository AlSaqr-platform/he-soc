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

//Function: This is the Datapath for the dynamic output
//
//Instantiates: 
//
//State: NONE
//
//Note:
//
`include "network_define.v"
// /usr/scratch/lagrev1/ottavi/he-soc/hardware/openpiton/piton/verif/env/manycore/devices_ariane.xml

module dynamic_output_datapath_para(data_out, valid_out_temp, data_0_in, data_1_in, valid_0_in, valid_1_in, current_route_in);

// begin port declarations

output [`DATA_WIDTH-1:0] data_out;
output valid_out_temp;
input [`DATA_WIDTH-1:0] data_0_in;
input [`DATA_WIDTH-1:0] data_1_in;
input valid_0_in;
input valid_1_in;

input [0:0] current_route_in;

// end port declarations

// `define ROUTE_A 3'b000
// `define ROUTE_B 3'b001
// `define ROUTE_C 3'b010
// `define ROUTE_D 3'b011
// `define ROUTE_X 3'b100

//This is the state
//NONE HERE

//inputs to the state
//NOTHING HERE EITHER

//wires

//wire regs

//assigns

//instantiations

one_of_n #(`DATA_WIDTH) data_mux(.in0(data_0_in), .in1(data_1_in), .sel(current_route_in), .out(data_out));
one_of_n #(1) valid_mux(.in0(valid_0_in), .in1(valid_1_in), .sel(current_route_in), .out(valid_out_temp));

endmodule

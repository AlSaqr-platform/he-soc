// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

/*
 * axi2mem_wrap.sv
 * Davide Rossi <davide.rossi@unibo.it>
 * Antonio Pullini <pullinia@iis.ee.ethz.ch>
 * Igor Loi <igor.loi@unibo.it>
 * Francesco Conti <fconti@iis.ee.ethz.ch>
 */

module axi2tcdm_wrap
#(
  parameter NB_DMAS        = 4,
  parameter AXI_ADDR_WIDTH = 64,
  parameter AXI_DATA_WIDTH = 64,
  parameter AXI_USER_WIDTH = 6,
  parameter AXI_ID_WIDTH   = 6
)
(
  input logic          clk_i,
  input logic          rst_ni,
  input logic          test_en_i,
  AXI_BUS.Slave        axi_slave,
  XBAR_TCDM_BUS.Master tcdm_master[NB_DMAS-1:0],
  output logic         busy_o
);

  logic [NB_DMAS-1:0][31:0] s_tcdm_bus_wdata;
  logic [NB_DMAS-1:0][63:0] s_tcdm_bus_add;
  logic [NB_DMAS-1:0]       s_tcdm_bus_req;
  logic [NB_DMAS-1:0]       s_tcdm_bus_we;
  logic [NB_DMAS-1:0][3:0]  s_tcdm_bus_be;
  logic [NB_DMAS-1:0]       s_tcdm_bus_gnt;
  logic [NB_DMAS-1:0][31:0] s_tcdm_bus_r_rdata;
  logic [NB_DMAS-1:0]       s_tcdm_bus_r_valid;

  generate
    for (genvar i=0; i<NB_DMAS; i++) begin : TCDM_BIND
      assign tcdm_master[i].add    = s_tcdm_bus_add[i][31:0];
      assign tcdm_master[i].req    = s_tcdm_bus_req[i];
      assign tcdm_master[i].wdata  = s_tcdm_bus_wdata[i];
      assign tcdm_master[i].wen    = !s_tcdm_bus_we[i];
      assign tcdm_master[i].be     = s_tcdm_bus_be[i];


      assign s_tcdm_bus_gnt[i]     = tcdm_master[i].gnt;
      assign s_tcdm_bus_r_valid[i] = tcdm_master[i].r_valid;
      assign s_tcdm_bus_r_rdata[i] = tcdm_master[i].r_rdata;
    end
  endgenerate

  axi_to_mem_split_intf #(
    .AXI_ID_WIDTH   (AXI_ID_WIDTH  ),
    .AXI_ADDR_WIDTH (AXI_ADDR_WIDTH),
    .AXI_DATA_WIDTH (AXI_DATA_WIDTH),
    .AXI_USER_WIDTH (AXI_USER_WIDTH),
    .MEM_DATA_WIDTH (32            ),
    .BUF_DEPTH      (4             ),
    .HIDE_STRB      (1'b0          ),
    .OUT_FIFO_DEPTH (32'd1         )
  ) axi2mem_i (
    .clk_i        (clk_i),
    .rst_ni       (rst_ni),
    .test_i       (test_en_i),
    .busy_o       (busy_o),
    .axi_bus      (axi_slave),
    .mem_req_o    (s_tcdm_bus_req),
    .mem_gnt_i    (s_tcdm_bus_gnt),
    .mem_addr_o   (s_tcdm_bus_add),
    .mem_wdata_o  (s_tcdm_bus_wdata),
    .mem_strb_o   (s_tcdm_bus_be),
    .mem_atop_o   (),
    .mem_we_o     (s_tcdm_bus_we),
    .mem_rvalid_i (s_tcdm_bus_r_valid),
    .mem_rdata_i  (s_tcdm_bus_r_rdata)
  );

endmodule

//-----------------------------------------------------------------------------
// Title         : PULPissimo Verilog Wrapper
//-----------------------------------------------------------------------------
// File          : alsaqr_xilinx.v
// Author        : Luca Valente <luca.valente@unibo.it>
// Created       : 15-07-2021
//-----------------------------------------------------------------------------
// Description :
// Verilog Wrapper of AlSaqr to use the module within Xilinx IP integrator.
//-----------------------------------------------------------------------------
// Copyright (C) 2021 ETH Zurich, University of Bologna
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//-----------------------------------------------------------------------------
`include "axi_flat.sv"
module alsaqr_xilinx
  (
    output        c0_init_calib_complete,
    output        c0_data_compare_error,
    input         c0_sys_clk_p,
    input         c0_sys_clk_n,
    output        c0_ddr4_act_n,
    output [16:0] c0_ddr4_adr,
    output [1:0]  c0_ddr4_ba,
    output [0:0]  c0_ddr4_bg,
    output [0:0]  c0_ddr4_cke,
    output [0:0]  c0_ddr4_odt,
    output [0:0]  c0_ddr4_cs_n,
    output [0:0]  c0_ddr4_ck_t,
    output [0:0]  c0_ddr4_ck_c,
    output        c0_ddr4_reset_n,
    inout [1:0]   c0_ddr4_dm_dbi_n,
    inout [15:0]  c0_ddr4_dq,
    inout [1:0]   c0_ddr4_dqs_t,
    inout [1:0]   c0_ddr4_dqs_c,
   
    inout wire    pad_uart_rx,
    inout wire    pad_uart_tx,
   
   
    inout         FMC_hyper0_dqio0 ,
    inout         FMC_hyper0_dqio1 ,
    inout         FMC_hyper0_dqio2 ,
    inout         FMC_hyper0_dqio3 ,
    inout         FMC_hyper0_dqio4 ,
    inout         FMC_hyper0_dqio5 ,
    inout         FMC_hyper0_dqio6 ,
    inout         FMC_hyper0_dqio7 ,
    inout         FMC_hyper0_ck ,
    inout         FMC_hyper0_ckn ,
    inout         FMC_hyper0_csn0 ,
    inout         FMC_hyper0_csn1 ,
    inout         FMC_hyper0_rwds ,
    inout         FMC_hyper0_reset ,

    inout         FMC_hyper1_dqio0 ,
    inout         FMC_hyper1_dqio1 ,
    inout         FMC_hyper1_dqio2 ,
    inout         FMC_hyper1_dqio3 ,
    inout         FMC_hyper1_dqio4 ,
    inout         FMC_hyper1_dqio5 ,
    inout         FMC_hyper1_dqio6 ,
    inout         FMC_hyper1_dqio7 ,
    inout         FMC_hyper1_ck ,
    inout         FMC_hyper1_ckn ,
    inout         FMC_hyper1_csn0 ,
    inout         FMC_hyper1_csn1 ,
    inout         FMC_hyper1_rwds ,
    inout         FMC_hyper1_reset ,

    input wire    pad_reset,

    input wire    pad_jtag_trst,
    input wire    pad_jtag_tck,
    input wire    pad_jtag_tdi,
    output wire   pad_jtag_tdo,
    input wire    pad_jtag_tms
  );

   localparam  APP_ADDR_WIDTH   = 28;
   localparam  MEM_ADDR_ORDER   = "ROW_COLUMN_BANK";
   localparam  DBG_WR_STS_WIDTH = 32;
   localparam  DBG_RD_STS_WIDTH = 32;
   localparam  ECC              = "OFF";
   localparam  APP_DATA_WIDTH   = 512; // This parameter is controllerwise
   localparam  APP_MASK_WIDTH   = 64;  // This parameter is controllerwise
 
   wire        ref_clk;
   wire        ddr_ref_clk;
   logic       s_locked;
   logic       s_clk;
   
   logic       reset_n;
   logic       c0_ddr4_clk;
   

   assign ref_clk = c0_ddr4_clk;  
  
   assign reset_n = ~pad_reset & pad_jtag_trst;

   wire [7:0] s_pad_hyper0_dq;
   wire [1:0] s_pad_hyper0_csn;
   wire [7:0] s_pad_hyper1_dq;
   wire [1:0] s_pad_hyper1_csn;
   
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( 64        ),
     .AXI_DATA_WIDTH ( 64        ),
     .AXI_ID_WIDTH   ( 7         ),
     .AXI_USER_WIDTH ( 1         )
             ) axi_ddr_bus();
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( 64        ),
     .AXI_DATA_WIDTH ( 64        ),
     .AXI_ID_WIDTH   ( 7         ),
     .AXI_USER_WIDTH ( 1         )
             ) axi_ddr_sync();

  wire [APP_ADDR_WIDTH-1:0] c0_ddr4_app_addr;
  wire [2:0]                c0_ddr4_app_cmd;
  wire                      c0_ddr4_app_en;
  wire [APP_DATA_WIDTH-1:0] c0_ddr4_app_wdf_data;
  wire                      c0_ddr4_app_wdf_end;
  wire [APP_MASK_WIDTH-1:0] c0_ddr4_app_wdf_mask;
  wire                      c0_ddr4_app_wdf_wren;
  wire [APP_DATA_WIDTH-1:0] c0_ddr4_app_rd_data;
  wire                      c0_ddr4_app_rd_data_end;
  wire                      c0_ddr4_app_rd_data_valid;
  wire                      c0_ddr4_app_rdy;
  wire                      c0_ddr4_app_wdf_rdy;
  wire                      c0_ddr4_clk;
  wire                      c0_ddr4_rst;
  wire                      dbg_clk;
  wire                      c0_wr_rd_complete;


  reg                       c0_ddr4_aresetn;
  wire                      c0_ddr4_data_msmatch_err;
  wire                      c0_ddr4_write_err;
  wire                      c0_ddr4_read_err;
  wire                      c0_ddr4_test_cmptd;
  wire                      c0_ddr4_write_cmptd;
  wire                      c0_ddr4_read_cmptd;
  wire                      c0_ddr4_cmptd_one_wr_rd;

  // Slave Interface Write Address Ports
  wire [6:0]      c0_ddr4_s_axi_awid;
  wire [28:0]     c0_ddr4_s_axi_awaddr;
  wire [7:0]      c0_ddr4_s_axi_awlen;
  wire [2:0]      c0_ddr4_s_axi_awsize;
  wire [1:0]      c0_ddr4_s_axi_awburst;
  wire [3:0]      c0_ddr4_s_axi_awcache;
  wire [2:0]      c0_ddr4_s_axi_awprot;
  wire            c0_ddr4_s_axi_awvalid;
  wire            c0_ddr4_s_axi_awready;
   // Slave Interface Write Data Ports
  wire [63:0]    c0_ddr4_s_axi_wdata;
  wire [7:0]     c0_ddr4_s_axi_wstrb;
  wire           c0_ddr4_s_axi_wlast;
  wire           c0_ddr4_s_axi_wvalid;
  wire           c0_ddr4_s_axi_wready;
   // Slave Interface Write Response Ports
  wire           c0_ddr4_s_axi_bready;
  wire [6:0]     c0_ddr4_s_axi_bid;
  wire [1:0]     c0_ddr4_s_axi_bresp;
  wire           c0_ddr4_s_axi_bvalid;
   // Slave Interface Read Address Ports
  wire [6:0]     c0_ddr4_s_axi_arid;
  wire [28:0]    c0_ddr4_s_axi_araddr;
  wire [7:0]     c0_ddr4_s_axi_arlen;
  wire [2:0]     c0_ddr4_s_axi_arsize;
  wire [1:0]     c0_ddr4_s_axi_arburst;
  wire [3:0]     c0_ddr4_s_axi_arcache;
  wire           c0_ddr4_s_axi_arvalid;
  wire           c0_ddr4_s_axi_arready;
   // Slave Interface Read Data Ports
  wire           c0_ddr4_s_axi_rready;
  wire [6:0]     c0_ddr4_s_axi_rid;
  wire [63:0]    c0_ddr4_s_axi_rdata;
  wire [1:0]     c0_ddr4_s_axi_rresp;
  wire           c0_ddr4_s_axi_rlast;
  wire           c0_ddr4_s_axi_rvalid;

  wire           c0_ddr4_cmp_data_valid;
  wire [63:0]    c0_ddr4_cmp_data;     // Compare data
  wire [63:0]    c0_ddr4_rdata_cmp;      // Read data

  wire                             c0_ddr4_dbg_wr_sts_vld;
  wire [DBG_WR_STS_WIDTH-1:0]      c0_ddr4_dbg_wr_sts;
  wire                             c0_ddr4_dbg_rd_sts_vld;
  wire [DBG_RD_STS_WIDTH-1:0]      c0_ddr4_dbg_rd_sts;
  assign c0_data_compare_error = c0_ddr4_data_msmatch_err | c0_ddr4_write_err | c0_ddr4_read_err;

  //***********************************************************************
  // Differential input clock input buffers
  //***********************************************************************
  wire c0_sys_clk_i;
  wire c0_sys_clk_o;

  IBUFDS #
    (
     .IBUF_LOW_PWR ("FALSE")
     )
    u_ibufg_sys_clk
      (
       .I  (c0_sys_clk_p),
       .IB (c0_sys_clk_n),
       .O  (c0_sys_clk_o)
       );

wire c0_ddr4_reset_n_int;
  assign c0_ddr4_reset_n = c0_ddr4_reset_n_int;

//***************************************************************************
// The User design is instantiated below. The memory interface ports are
// connected to the top-level and the application interface ports are
// connected to the traffic generator module. This provides a reference
// for connecting the memory controller to system.
//***************************************************************************

  // user design top is one instance for all controllers
ddr4_0 u_ddr4_0
  (
   .sys_rst           (pad_reset),

   .c0_sys_clk_i           (c0_sys_clk_o),
   .c0_init_calib_complete (c0_init_calib_complete),
   .c0_ddr4_act_n          (c0_ddr4_act_n),
   .c0_ddr4_adr            (c0_ddr4_adr),
   .c0_ddr4_ba             (c0_ddr4_ba),
   .c0_ddr4_bg             (c0_ddr4_bg),
   .c0_ddr4_cke            (c0_ddr4_cke),
   .c0_ddr4_odt            (c0_ddr4_odt),
   .c0_ddr4_cs_n           (c0_ddr4_cs_n),
   .c0_ddr4_ck_t           (c0_ddr4_ck_t),
   .c0_ddr4_ck_c           (c0_ddr4_ck_c),
   .c0_ddr4_reset_n        (c0_ddr4_reset_n_int),

   .c0_ddr4_dm_dbi_n       (c0_ddr4_dm_dbi_n),
   .c0_ddr4_dq             (c0_ddr4_dq),
   .c0_ddr4_dqs_c          (c0_ddr4_dqs_c),
   .c0_ddr4_dqs_t          (c0_ddr4_dqs_t),

   .c0_ddr4_ui_clk                (c0_ddr4_clk),
   .c0_ddr4_ui_clk_sync_rst       (c0_ddr4_rst),
   .addn_ui_clkout1                            (),
   .dbg_clk                                    (dbg_clk),

  // Slave Interface Write Address Ports
  .c0_ddr4_aresetn                     (c0_ddr4_aresetn),
  .c0_ddr4_s_axi_awid                  (c0_ddr4_s_axi_awid),
  .c0_ddr4_s_axi_awaddr                (c0_ddr4_s_axi_awaddr),
  .c0_ddr4_s_axi_awlen                 (c0_ddr4_s_axi_awlen),
  .c0_ddr4_s_axi_awsize                (c0_ddr4_s_axi_awsize),
  .c0_ddr4_s_axi_awburst               (c0_ddr4_s_axi_awburst),
  .c0_ddr4_s_axi_awlock                (1'b0),
  .c0_ddr4_s_axi_awcache               (c0_ddr4_s_axi_awcache),
  .c0_ddr4_s_axi_awprot                (c0_ddr4_s_axi_awprot),
  .c0_ddr4_s_axi_awqos                 (4'b0),
  .c0_ddr4_s_axi_awvalid               (c0_ddr4_s_axi_awvalid),
  .c0_ddr4_s_axi_awready               (c0_ddr4_s_axi_awready),
  // Slave Interface Write Data Ports
  .c0_ddr4_s_axi_wdata                 (c0_ddr4_s_axi_wdata),
  .c0_ddr4_s_axi_wstrb                 (c0_ddr4_s_axi_wstrb),
  .c0_ddr4_s_axi_wlast                 (c0_ddr4_s_axi_wlast),
  .c0_ddr4_s_axi_wvalid                (c0_ddr4_s_axi_wvalid),
  .c0_ddr4_s_axi_wready                (c0_ddr4_s_axi_wready),
  // Slave Interface Write Response Ports
  .c0_ddr4_s_axi_bid                   (c0_ddr4_s_axi_bid),
  .c0_ddr4_s_axi_bresp                 (c0_ddr4_s_axi_bresp),
  .c0_ddr4_s_axi_bvalid                (c0_ddr4_s_axi_bvalid),
  .c0_ddr4_s_axi_bready                (c0_ddr4_s_axi_bready),
  // Slave Interface Read Address Ports
  .c0_ddr4_s_axi_arid                  (c0_ddr4_s_axi_arid),
  .c0_ddr4_s_axi_araddr                (c0_ddr4_s_axi_araddr),
  .c0_ddr4_s_axi_arlen                 (c0_ddr4_s_axi_arlen),
  .c0_ddr4_s_axi_arsize                (c0_ddr4_s_axi_arsize),
  .c0_ddr4_s_axi_arburst               (c0_ddr4_s_axi_arburst),
  .c0_ddr4_s_axi_arlock                (1'b0),
  .c0_ddr4_s_axi_arcache               (c0_ddr4_s_axi_arcache),
  .c0_ddr4_s_axi_arprot                (3'b0),
  .c0_ddr4_s_axi_arqos                 (4'b0),
  .c0_ddr4_s_axi_arvalid               (c0_ddr4_s_axi_arvalid),
  .c0_ddr4_s_axi_arready               (c0_ddr4_s_axi_arready),
  // Slave Interface Read Data Ports
  .c0_ddr4_s_axi_rid                   (c0_ddr4_s_axi_rid),
  .c0_ddr4_s_axi_rdata                 (c0_ddr4_s_axi_rdata),
  .c0_ddr4_s_axi_rresp                 (c0_ddr4_s_axi_rresp),
  .c0_ddr4_s_axi_rlast                 (c0_ddr4_s_axi_rlast),
  .c0_ddr4_s_axi_rvalid                (c0_ddr4_s_axi_rvalid),
  .c0_ddr4_s_axi_rready                (c0_ddr4_s_axi_rready),
  
  // Debug Port
  .dbg_bus         (dbg_bus)                                             

  );
   always @(posedge c0_ddr4_clk) begin
     c0_ddr4_aresetn <= ~c0_ddr4_rst;
   end

//***************************************************************************
// ALSAQR
//***************************************************************************
   
   axi_cdc_intf #(
     .AXI_ADDR_WIDTH ( 64        ),
     .AXI_DATA_WIDTH ( 64        ),
     .AXI_ID_WIDTH   ( 7         ),
     .AXI_USER_WIDTH ( 1         ),
     .LOG_DEPTH      ( 2         )
                  ) axiddrcdc (
                               .src_clk_i (ref_clk),
                               .src_rst_ni(reset_n),
                               .src (axi_ddr_bus),
                               .dst_clk_i (c0_sys_clk_o),
                               .dst_rst_ni(~pad_reset),
                               .dst(axi_ddr_sync)
                               );
   
   `AXI_FLATTEN_MASTER(c0_ddr4_s_axi,axi_ddr_sync)
   
   assign s_pad_hyper0_csn[0] = FMC_hyper0_csn0;
   assign s_pad_hyper0_csn[1] = FMC_hyper0_csn1;   
   assign s_pad_hyper0_dq[0]  = FMC_hyper0_dqio0;
   assign s_pad_hyper0_dq[1]  = FMC_hyper0_dqio1;
   assign s_pad_hyper0_dq[2]  = FMC_hyper0_dqio2;
   assign s_pad_hyper0_dq[3]  = FMC_hyper0_dqio3;
   assign s_pad_hyper0_dq[4]  = FMC_hyper0_dqio4;
   assign s_pad_hyper0_dq[5]  = FMC_hyper0_dqio5;
   assign s_pad_hyper0_dq[6]  = FMC_hyper0_dqio6;
   assign s_pad_hyper0_dq[7]  = FMC_hyper0_dqio7;

   assign s_pad_hyper1_csn[0] = FMC_hyper1_csn0;
   assign s_pad_hyper1_csn[1] = FMC_hyper1_csn1;   
   assign s_pad_hyper1_dq[0]  = FMC_hyper1_dqio0;
   assign s_pad_hyper1_dq[1]  = FMC_hyper1_dqio1;
   assign s_pad_hyper1_dq[2]  = FMC_hyper1_dqio2;
   assign s_pad_hyper1_dq[3]  = FMC_hyper1_dqio3;
   assign s_pad_hyper1_dq[4]  = FMC_hyper1_dqio4;
   assign s_pad_hyper1_dq[5]  = FMC_hyper1_dqio5;
   assign s_pad_hyper1_dq[6]  = FMC_hyper1_dqio6;
   assign s_pad_hyper1_dq[7]  = FMC_hyper1_dqio7;
   
    al_saqr #(
        .JtagEnable        ( 1'b1          )
    ) i_alsaqr (
        .rst_ni           ( reset_n          ),
        .rtc_i            ( ref_clk          ),
        .jtag_TCK         ( pad_jtag_tck     ),
        .jtag_TMS         ( pad_jtag_tms     ),
        .jtag_TDI         ( pad_jtag_tdi     ),
        .jtag_TRSTn       ( 1'b1             ),
        .jtag_TDO_data    ( pad_jtag_tdo     ),
        .jtag_TDO_driven  (                  ),
        .axi_ddr_master   ( axi_ddr_bus      ),
        .cva6_uart_rx_i   ( pad_uart_rx      ),
        .cva6_uart_tx_o   ( pad_uart_tx      ),

        .pad_hyper0_dq    ( s_pad_hyper0_dq  ),
        .pad_hyper0_ck    ( FMC_hyper0_ck    ),
        .pad_hyper0_ckn   ( FMC_hyper0_ckn   ),
        .pad_hyper0_csn   ( s_pad_hyper0_csn ),
        .pad_hyper0_rwds  ( FMC_hyper0_rwds  ),
        .pad_hyper0_reset ( FMC_hyper0_reset ),

        .pad_hyper1_dq    ( s_pad_hyper1_dq  ),
        .pad_hyper1_ck    ( FMC_hyper1_ck    ),
        .pad_hyper1_ckn   ( FMC_hyper1_ckn   ),
        .pad_hyper1_csn   ( s_pad_hyper1_csn ),
        .pad_hyper1_rwds  ( FMC_hyper1_rwds  ),
        .pad_hyper1_reset ( FMC_hyper1_reset )
   );


endmodule

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
   

   xilinx_clk_mngr alsaqr_clk_manager(
                                      .resetn(reset_n),
                                      .locked(),
                                      .clk_in1(c0_sys_clk_o),
                                      .clk_out1(ref_clk)
                                      );
     
   assign reset_n = ~pad_reset & pad_jtag_trst;

   wire  [1:0][1:0] hyper_cs_n_wire;
   wire  [1:0]      hyper_ck_wire;
   wire  [1:0]      hyper_ck_n_wire;
   wire  [1:0]      hyper_rwds_wire;
   wire  [1:0][7:0] hyper_dq_wire;
   wire  [1:0]      hyper_reset_n_wire;
   
   AXI_BUS #(
     .AXI_ADDR_WIDTH ( 64        ),
     .AXI_DATA_WIDTH ( 64        ),
     .AXI_ID_WIDTH   ( 7         ),
     .AXI_USER_WIDTH ( 1         )
             ) axi_ddr_bus_64();
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
  wire c0_sys_clk_o;
  wire c0_sys_clk_s;
   
  IBUFDS #
    (
     .IBUF_LOW_PWR ("FALSE")
     )
    u_ibufg_sys_clk
      (
       .I  (c0_sys_clk_p),
       .IB (c0_sys_clk_n),
       .O  (c0_sys_clk_s)
       );  

  IBUF #
    (
     .IBUF_LOW_PWR ("FALSE")
     ) u_ibufg_sys_clk_o
      (
       .I  (c0_sys_clk_s),
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
   .dbg_clk                                    (dbg_clk),

  // Slave Interface Write Address Ports
  .c0_ddr4_aresetn                     (c0_ddr4_aresetn),
  .c0_ddr4_s_axi_awid                  (axi_ddr_sync.aw_id),
  .c0_ddr4_s_axi_awaddr                (axi_ddr_sync.aw_addr[28:0]),
  .c0_ddr4_s_axi_awlen                 (axi_ddr_sync.aw_len),
  .c0_ddr4_s_axi_awsize                (axi_ddr_sync.aw_size),
  .c0_ddr4_s_axi_awburst               (axi_ddr_sync.aw_burst),
  .c0_ddr4_s_axi_awlock                (axi_ddr_sync.aw_lock),
  .c0_ddr4_s_axi_awcache               (axi_ddr_sync.aw_cache),
  .c0_ddr4_s_axi_awprot                (axi_ddr_sync.aw_prot),
  .c0_ddr4_s_axi_awqos                 (axi_ddr_sync.aw_qos),
  .c0_ddr4_s_axi_awvalid               (axi_ddr_sync.aw_valid),
  .c0_ddr4_s_axi_awready               (axi_ddr_sync.aw_ready),
  // Slave Interface Write Data Ports
  .c0_ddr4_s_axi_wdata                 (axi_ddr_sync.w_data),
  .c0_ddr4_s_axi_wstrb                 (axi_ddr_sync.w_strb),
  .c0_ddr4_s_axi_wlast                 (axi_ddr_sync.w_last),
  .c0_ddr4_s_axi_wvalid                (axi_ddr_sync.w_valid),
  .c0_ddr4_s_axi_wready                (axi_ddr_sync.w_ready),
  // Slave Interface Write Response Port
  .c0_ddr4_s_axi_bid                   (axi_ddr_sync.b_id),
  .c0_ddr4_s_axi_bresp                 (axi_ddr_sync.b_resp),
  .c0_ddr4_s_axi_bvalid                (axi_ddr_sync.b_valid),
  .c0_ddr4_s_axi_bready                (axi_ddr_sync.b_ready),
  // Slave Interface Read Address Ports
  .c0_ddr4_s_axi_arid                  (axi_ddr_sync.ar_id),
  .c0_ddr4_s_axi_araddr                (axi_ddr_sync.ar_addr[28:0]),
  .c0_ddr4_s_axi_arlen                 (axi_ddr_sync.ar_len),
  .c0_ddr4_s_axi_arsize                (axi_ddr_sync.ar_size),
  .c0_ddr4_s_axi_arburst               (axi_ddr_sync.ar_burst),
  .c0_ddr4_s_axi_arlock                (axi_ddr_sync.ar_lock),
  .c0_ddr4_s_axi_arcache               (axi_ddr_sync.ar_cache),
  .c0_ddr4_s_axi_arprot                (axi_ddr_sync.ar_prot),
  .c0_ddr4_s_axi_arqos                 (axi_ddr_sync.ar_qos),
  .c0_ddr4_s_axi_arvalid               (axi_ddr_sync.ar_valid),
  .c0_ddr4_s_axi_arready               (axi_ddr_sync.ar_ready),
  // Slave Interface Read Data Ports
  .c0_ddr4_s_axi_rid                   (axi_ddr_sync.r_id),
  .c0_ddr4_s_axi_rdata                 (axi_ddr_sync.r_data),
  .c0_ddr4_s_axi_rresp                 (axi_ddr_sync.r_resp),
  .c0_ddr4_s_axi_rlast                 (axi_ddr_sync.r_last),
  .c0_ddr4_s_axi_rvalid                (axi_ddr_sync.r_valid),
  .c0_ddr4_s_axi_rready                (axi_ddr_sync.r_ready),
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
     .LOG_DEPTH      ( 4         )
                  ) axiddrcdc (
                               .src_clk_i (ref_clk),
                               .src_rst_ni(reset_n),
                               .src (axi_ddr_bus_64),
                               .dst_clk_i (c0_ddr4_clk),
                               .dst_rst_ni(c0_ddr4_aresetn),
                               .dst(axi_ddr_sync)
                               );   
      
   assign hyper_cs_n_wire[0][0] = FMC_hyper0_csn0;
   assign hyper_cs_n_wire[0][1] = FMC_hyper0_csn1;   
   assign hyper_dq_wire[0][0]   = FMC_hyper0_dqio0;
   assign hyper_dq_wire[0][1]   = FMC_hyper0_dqio1;
   assign hyper_dq_wire[0][2]   = FMC_hyper0_dqio2;
   assign hyper_dq_wire[0][3]   = FMC_hyper0_dqio3;
   assign hyper_dq_wire[0][4]   = FMC_hyper0_dqio4;
   assign hyper_dq_wire[0][5]   = FMC_hyper0_dqio5;
   assign hyper_dq_wire[0][6]   = FMC_hyper0_dqio6;
   assign hyper_dq_wire[0][7]   = FMC_hyper0_dqio7;
   assign hyper_rwds_wire[0]    = FMC_hyper0_rwds;
   assign hyper_ck_wire[0]      = FMC_hyper0_ck;
   assign hyper_ck_n_wire[0]    = FMC_hyper0_ckn;
   assign hyper_reset_n_wire[0] = FMC_hyper0_reset;
   
   
   assign hyper_cs_n_wire[1][0] = FMC_hyper1_csn0;
   assign hyper_cs_n_wire[1][1] = FMC_hyper1_csn1;   
   assign hyper_dq_wire[1][0]   = FMC_hyper1_dqio0;
   assign hyper_dq_wire[1][1]   = FMC_hyper1_dqio1;
   assign hyper_dq_wire[1][2]   = FMC_hyper1_dqio2;
   assign hyper_dq_wire[1][3]   = FMC_hyper1_dqio3;
   assign hyper_dq_wire[1][4]   = FMC_hyper1_dqio4;
   assign hyper_dq_wire[1][5]   = FMC_hyper1_dqio5;
   assign hyper_dq_wire[1][6]   = FMC_hyper1_dqio6;
   assign hyper_dq_wire[1][7]   = FMC_hyper1_dqio7;
   assign hyper_rwds_wire[1]    = FMC_hyper1_rwds;
   assign hyper_ck_wire[1]      = FMC_hyper1_ck;
   assign hyper_ck_n_wire[1]    = FMC_hyper1_ckn;
   assign hyper_reset_n_wire[1] = FMC_hyper1_reset;

   
    al_saqr #(
        .JtagEnable        ( 1'b1          )
    ) i_alsaqr (
        .rst_ni           ( reset_n            ),
        .rtc_i            ( ref_clk            ),
        .jtag_TCK         ( pad_jtag_tck       ),
        .jtag_TMS         ( pad_jtag_tms       ),
        .jtag_TDI         ( pad_jtag_tdi       ),
        .jtag_TRSTn       ( 1'b1               ),
        .jtag_TDO_data    ( pad_jtag_tdo       ),
        .jtag_TDO_driven  (                    ),
        .axi_ddr_master   ( axi_ddr_bus_64     ),
        .cva6_uart_rx_i   ( pad_uart_rx        ),
        .cva6_uart_tx_o   ( pad_uart_tx        ),

        .pad_hyper_csn    ( hyper_cs_n_wire    ),
        .pad_hyper_ck     ( hyper_ck_wire      ),
        .pad_hyper_ckn    ( hyper_ck_n_wire    ),
        .pad_hyper_rwds   ( hyper_rwds_wire    ),
        .pad_hyper_reset  ( hyper_reset_n_wire ),
        .pad_hyper_dq     ( hyper_dq_wire      )
                
   );


endmodule

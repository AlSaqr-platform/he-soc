// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Florian Zaruba, ETH Zurich
// Date: 15/04/2017
// Description: Top level testbench module. Instantiates the top level DUT, configures
//              the virtual interfaces and starts the test passed by +UVM_TEST+
//`define TEST_CLOCK_BYPASS

`timescale 1ps/1ps

import ariane_pkg::*;
import uvm_pkg::*;
import ariane_soc::HyperbusNumPhys;
import ariane_soc::NumChipsPerHyperbus;

`include "uvm_macros.svh"
`include "axi/assign.svh"
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"

import "DPI-C" function read_elf(input string filename);
import "DPI-C" function byte get_section(output longint address, output longint len);
import "DPI-C" context function byte read_section(input longint address, inout byte buffer[]);


module ariane_tb;

    static uvm_cmdline_processor uvcl = uvm_cmdline_processor::get_inst();

    localparam int unsigned REFClockPeriod = 67000ps; // jtag clock
    // toggle with RTC period
    `ifndef TEST_CLOCK_BYPASS
      localparam int unsigned RTC_CLOCK_PERIOD = 30.517us;
    `else 
      localparam int unsigned RTC_CLOCK_PERIOD = 10ns;
    `endif
   
    localparam NUM_WORDS = 2**25;
    logic clk_i;
    logic rst_ni;
    logic rtc_i;
    logic s_rst_ni;
    logic s_rtc_i;
    logic s_bypass;
    logic rst_DTM;
    localparam NumPhys = ariane_soc::HyperbusNumPhys;
    localparam NumChips = ariane_soc::NumChipsPerHyperbus;   
   
    localparam ENABLE_DM_TESTS = 0;
   
    parameter  USE_HYPER_MODELS     = 1;
    parameter  USE_24FC1025_MODEL   = 1;
    parameter  USE_S25FS256S_MODEL  = 1;
    parameter  USE_UART             = 1;
    parameter  USE_SERIAL_LINK      = 0;
    parameter  USE_SDIO_0           = 1;
    parameter  USE_SDIO_1           = 0;

    // use camera verification IP
    parameter  USE_SDVT_CPI = 0;

  `ifdef PRELOAD
    parameter  PRELOAD_HYPERRAM    = 1;
    parameter  LOCAL_JTAG          = 1;
    parameter  CHECK_LOCAL_JTAG    = 0; 
  `else 
    parameter PRELOAD_HYPERRAM = 0;
    `ifdef USE_LOCAL_JTAG 
      parameter  LOCAL_JTAG          = 1;
      parameter  CHECK_LOCAL_JTAG    = 0; 
    `else
      parameter  LOCAL_JTAG          = 0;
      parameter  CHECK_LOCAL_JTAG    = 0; 
    `endif
  `endif
   

  `ifdef POSTLAYOUT
    localparam int unsigned JtagSampleDelay = (REFClockPeriod < 10ns) ? 2 : 1;
  `else
    localparam int unsigned JtagSampleDelay = 0;
  `endif    

  `ifdef JTAG_RBB 
    parameter int   jtag_enable = '1 ;
  `else  
    parameter int   jtag_enable = '0 ;
  `endif
   
    localparam logic [15:0] PartNumber = 1; 
    logic program_loaded = 0;
    logic  eoc;
    logic [31:0]  retval = 32'h0;  // Store return value
    localparam logic [31:0] dm_idcode  = (dm::DbgVersion013 << 28) | (PartNumber << 12) | 32'b1; 
    localparam AxiWideBeWidth    = ariane_axi_soc::DataWidth / 8;
    localparam AxiWideByteOffset = $clog2(AxiWideBeWidth);
    typedef logic [ariane_axi_soc::AddrWidth-1:0] addr_t;
    typedef logic [ariane_axi_soc::DataWidth-1:0] data_t;   
    data_t memory [bit [31:0]];
    int sections  [bit [31:0]];
   
    wire                  s_dmi_req_valid;
    wire                  s_dmi_req_ready;
    wire [ 6:0]           s_dmi_req_bits_addr;
    wire [ 1:0]           s_dmi_req_bits_op;
    wire [31:0]           s_dmi_req_bits_data;
    wire                  s_dmi_resp_valid;
    wire                  s_dmi_resp_ready;
    wire [ 1:0]           s_dmi_resp_bits_resp;
    wire [31:0]           s_dmi_resp_bits_data;   
    wire                  s_dmi_exit;
   
    wire                  s_jtag_TCK       ;
    wire                  s_jtag_TMS       ;
    wire                  s_jtag_TDI       ;
    wire                  s_jtag_TRSTn     ;
    wire                  s_jtag_TDO_data  ;
    wire                  s_jtag_TDO_driven;
    wire                  s_jtag_exit      ;
  
    string                stimuli_file      ;
    logic                 s_tck         ;
    logic                 s_tms         ;
    logic                 s_tdi         ;
    logic                 s_trstn       ;
    logic                 s_tdo         ;

    wire                  s_jtag2alsaqr_tck       ;
    wire                  s_jtag2alsaqr_tms       ;
    wire                  s_jtag2alsaqr_tdi       ;
    wire                  s_jtag2alsaqr_trstn     ;
    wire                  s_jtag2alsaqr_tdo       ;
   
    wire  [NumPhys-1:0][1:0] hyper_cs_n_wire;
    wire  [NumPhys-1:0]      hyper_ck_wire;
    wire  [NumPhys-1:0]      hyper_ck_n_wire;
    wire  [NumPhys-1:0]      hyper_rwds_wire;
    wire  [NumPhys-1:0][7:0] hyper_dq_wire;
    wire  [NumPhys-1:0]      hyper_reset_n_wire;

    wire                  soc_clock;

    wire                  w_i2c_sda      ;
    wire                  w_i2c_scl      ;

    tri                   w_spim_sck     ; 
    tri                   w_spim_csn0    ;
    tri                   w_spim_sdio0   ; 
    wire                  w_spim_sdio1   ;
    tri                   w_spim_sdio2   ; 
    tri                   w_spim_sdio3   ;

    wire                  w_cam_pclk;
    wire [7:0]            w_cam_data;
    wire                  w_cam_hsync;
    wire                  w_cam_vsync;

    //NEW PAD PERIPHERALS SIGNALS
    wire    pad_periphs_pad_gpio_b_00_pad;
    wire    pad_periphs_pad_gpio_b_01_pad;
    wire    pad_periphs_pad_gpio_b_02_pad;
    wire    pad_periphs_pad_gpio_b_03_pad;
    wire    pad_periphs_pad_gpio_b_04_pad;
    wire    pad_periphs_pad_gpio_b_05_pad;
    wire    pad_periphs_pad_gpio_b_06_pad;
    wire    pad_periphs_pad_gpio_b_07_pad;
    wire    pad_periphs_pad_gpio_b_08_pad;
    wire    pad_periphs_pad_gpio_b_09_pad;
    wire    pad_periphs_pad_gpio_b_10_pad;
    wire    pad_periphs_pad_gpio_b_11_pad;
    wire    pad_periphs_pad_gpio_b_12_pad;
    wire    pad_periphs_pad_gpio_b_13_pad;

    wire                  w_cva6_uart_rx ;
    wire                  w_cva6_uart_tx ;
    wire                  apb_uart_rx ;
    wire                  apb_uart_tx ;
   
    wire ddr_ext_clk;
  
    longint unsigned cycles;
    longint unsigned max_cycles;

    logic [31:0] exit_o;

    string        binary ;
    string        cluster_binary;
  
  /* NB: This test is not used on FPGA
  assign pad_periphs_pad_gpio_b_37_pad = pad_periphs_pad_gpio_b_05_pad;
  assign pad_periphs_pad_gpio_b_38_pad = pad_periphs_pad_gpio_b_06_pad;
  assign pad_periphs_pad_gpio_b_39_pad = pad_periphs_pad_gpio_b_07_pad;*/
   
  `ifndef TEST_CLOCK_BYPASS
    assign s_bypass=1'b0;
  `else
    assign s_bypass=1'b1;
  `endif
    
  assign s_rst_ni=rst_ni;
  assign s_rtc_i=rtc_i;

  assign exit_o              = (jtag_enable[0]) ? s_jtag_exit          : s_dmi_exit;

  assign s_jtag2alsaqr_tck    = LOCAL_JTAG  ?  s_tck   : s_jtag_TCK   ;
  assign s_jtag2alsaqr_tms    = LOCAL_JTAG  ?  s_tms   : s_jtag_TMS   ;
  assign s_jtag2alsaqr_tdi    = LOCAL_JTAG  ?  s_tdi   : s_jtag_TDI   ;
  assign s_jtag2alsaqr_trstn  = LOCAL_JTAG  ?  s_trstn : s_jtag_TRSTn ;
  assign s_jtag_TDO_data      = s_jtag2alsaqr_tdo       ;
  assign s_tdo                = s_jtag2alsaqr_tdo       ;
  
  if (~jtag_enable[0] & !LOCAL_JTAG) begin
    SimDTM i_SimDTM (
      .clk                  ( clk_i                 ),
      .reset                ( ~rst_DTM              ),
      .debug_req_valid      ( s_dmi_req_valid       ),
      .debug_req_ready      ( s_dmi_req_ready       ),
      .debug_req_bits_addr  ( s_dmi_req_bits_addr   ),
      .debug_req_bits_op    ( s_dmi_req_bits_op     ),
      .debug_req_bits_data  ( s_dmi_req_bits_data   ),
      .debug_resp_valid     ( s_dmi_resp_valid      ),
      .debug_resp_ready     ( s_dmi_resp_ready      ),
      .debug_resp_bits_resp ( s_dmi_resp_bits_resp  ),
      .debug_resp_bits_data ( s_dmi_resp_bits_data  ), 
      .exit                 ( s_dmi_exit            )
    );
  end else begin
    assign dmi_req_valid = '0;
    assign debug_req_bits_op = '0;
    assign dmi_exit = 1'b0;
  end   
   
  // SiFive's SimJTAG Module
  // Converts to DPI calls
  SimJTAG i_SimJTAG (
    .clock                ( clk_i                ),
    .reset                ( ~rst_ni              ),
    .enable               ( jtag_enable[0]       ),
    .init_done            ( rst_ni               ),
    .jtag_TCK             ( s_jtag_TCK           ),
    .jtag_TMS             ( s_jtag_TMS           ),
    .jtag_TDI             ( s_jtag_TDI           ),
    .jtag_TRSTn           ( s_jtag_TRSTn         ),
    .jtag_TDO_data        ( s_jtag_TDO_data      ),
    .jtag_TDO_driven      ( s_jtag_TDO_driven    ),
    .exit                 ( s_jtag_exit          )
  );
  
    al_saqr 
    `ifndef TARGET_TOP_POST_SYNTH_SIM #(
        .NUM_WORDS         ( NUM_WORDS                   ),
        .InclSimDTM        ( 1'b1                        ),
        .StallRandomOutput ( 1'b1                        ),
        .StallRandomInput  ( 1'b1                        ),
        .JtagEnable        ( jtag_enable[0] | LOCAL_JTAG )
    ) `endif dut (
        .rst_ni               ( s_rst_ni               ),
        .rtc_i                ( s_rtc_i                ),
        .bypass_clk_i         ( s_bypass               ),
        `ifndef TARGET_TOP_POST_SYNTH_SIM
        .dmi_req_valid        ( s_dmi_req_valid        ),
        .dmi_req_ready        ( s_dmi_req_ready        ),
        .dmi_req_bits_addr    ( s_dmi_req_bits_addr    ),
        .dmi_req_bits_op      ( s_dmi_req_bits_op      ),
        .dmi_req_bits_data    ( s_dmi_req_bits_data    ),
        .dmi_resp_valid       ( s_dmi_resp_valid       ),
        .dmi_resp_ready       ( s_dmi_resp_ready       ),
        .dmi_resp_bits_resp   ( s_dmi_resp_bits_resp   ),
        .dmi_resp_bits_data   ( s_dmi_resp_bits_data   ),
        `endif
        .jtag_TCK             ( s_jtag2alsaqr_tck      ),
        .jtag_TMS             ( s_jtag2alsaqr_tms      ),
        .jtag_TDI             ( s_jtag2alsaqr_tdi      ),
        .jtag_TRSTn           ( s_jtag2alsaqr_trstn    ),
        .jtag_TDO_data        ( s_jtag2alsaqr_tdo      ),
        .jtag_TDO_driven      ( s_jtag_TDO_driven      ),

        .cva6_uart_rx_i       ( w_cva6_uart_rx         ),
        .cva6_uart_tx_o       ( w_cva6_uart_tx         ),
        .apb_uart_rx_i        ( apb_uart_rx            ),
        .apb_uart_tx_o        ( apb_uart_tx            ),
        
        .pad_hyper_csn        ( hyper_cs_n_wire        ),
        .pad_hyper_ck         ( hyper_ck_wire          ),
        .pad_hyper_ckn        ( hyper_ck_n_wire        ),
        .pad_hyper_rwds       ( hyper_rwds_wire        ),
        .pad_hyper_reset      ( hyper_reset_n_wire     ),
        .pad_hyper_dq         ( hyper_dq_wire          ), 
        
        .pad_periphs_pad_gpio_b_00_pad(pad_periphs_pad_gpio_b_00_pad),
        .pad_periphs_pad_gpio_b_01_pad(pad_periphs_pad_gpio_b_01_pad),
        .pad_periphs_pad_gpio_b_02_pad(pad_periphs_pad_gpio_b_02_pad),
        .pad_periphs_pad_gpio_b_03_pad(pad_periphs_pad_gpio_b_03_pad),
        .pad_periphs_pad_gpio_b_04_pad(pad_periphs_pad_gpio_b_04_pad),
        .pad_periphs_pad_gpio_b_05_pad(pad_periphs_pad_gpio_b_05_pad),
        .pad_periphs_pad_gpio_b_06_pad(pad_periphs_pad_gpio_b_06_pad),
        .pad_periphs_pad_gpio_b_07_pad(pad_periphs_pad_gpio_b_07_pad),
        .pad_periphs_pad_gpio_b_08_pad(pad_periphs_pad_gpio_b_08_pad),
        .pad_periphs_pad_gpio_b_09_pad(pad_periphs_pad_gpio_b_09_pad),
        .pad_periphs_pad_gpio_b_10_pad(pad_periphs_pad_gpio_b_10_pad),
        .pad_periphs_pad_gpio_b_11_pad(pad_periphs_pad_gpio_b_11_pad),
        .pad_periphs_pad_gpio_b_12_pad(pad_periphs_pad_gpio_b_12_pad),
        .pad_periphs_pad_gpio_b_13_pad(pad_periphs_pad_gpio_b_13_pad)
   );

   
   if (USE_UART == 1) begin
        assign pad_periphs_pad_gpio_b_07_pad =pad_periphs_pad_gpio_b_06_pad;
   end

   generate
     /* I2C memory models connected on I2C0*/
     if (USE_24FC1025_MODEL == 1) begin
        pullup scl0_pullup_i (pad_periphs_pad_gpio_b_04_pad);
        pullup sda0_pullup_i (pad_periphs_pad_gpio_b_05_pad);

        M24FC1025 i_i2c_mem_0 (
           .A0    ( 1'b0       ),
           .A1    ( 1'b0       ),
           .A2    ( 1'b1       ),
           .WP    ( 1'b0       ),
           .SDA   ( pad_periphs_pad_gpio_b_05_pad ),
           .SCL   ( pad_periphs_pad_gpio_b_04_pad ),
           .RESET ( 1'b0       )
        );
       
        M24FC1025 i_i2c_mem_1 (
           .A0    ( 1'b1       ),
           .A1    ( 1'b0       ),
           .A2    ( 1'b1       ),
           .WP    ( 1'b0       ),
           .SDA   ( pad_periphs_pad_gpio_b_05_pad ),
           .SCL   ( pad_periphs_pad_gpio_b_04_pad ),
           .RESET ( 1'b0       )
        );

   end
   endgenerate

  generate
    /* SPI flash */
      if(USE_S25FS256S_MODEL == 1) begin
         s25fs256s #(
            .TimingModel   ( "S25FS256SAGMFI000_F_30pF" ),
            .mem_file_name ( "./vectors/qspi_stim.slm" ),
            .UserPreload   ( 0 )
         ) i_spi_flash_csn0 (
            .SI       ( pad_periphs_pad_gpio_b_03_pad  ),
            .SO       ( pad_periphs_pad_gpio_b_02_pad  ),
            .SCK      ( pad_periphs_pad_gpio_b_01_pad  ),
            .CSNeg    ( pad_periphs_pad_gpio_b_00_pad  ),
            .WPNeg    (  ),
            .RESETNeg (  )
         );
      end
  endgenerate

  /*generate
      if (USE_SDVT_CPI==1) begin
         cam_vip #(
            .HRES       ( 32 ), //320
            .VRES       ( 32 ) //240
         ) i_cam_vip (
            .en_i        ( pad_periphs_pad_gpio_b_00_pad  ),  //GPIO B 0
            .cam_clk_o   ( pad_periphs_pad_gpio_d_00_pad  ),
            .cam_vsync_o ( pad_periphs_pad_gpio_d_10_pad ),
            .cam_href_o  ( pad_periphs_pad_gpio_d_01_pad ),
            .cam_data_o  ( w_cam_data  )
         );
        
        assign pad_periphs_pad_gpio_d_02_pad = w_cam_data[0];
        assign pad_periphs_pad_gpio_d_03_pad = w_cam_data[1];
        assign pad_periphs_pad_gpio_d_04_pad = w_cam_data[2];
        assign pad_periphs_pad_gpio_d_05_pad = w_cam_data[3];
        assign pad_periphs_pad_gpio_d_06_pad = w_cam_data[4];
        assign pad_periphs_pad_gpio_d_07_pad = w_cam_data[5];
        assign pad_periphs_pad_gpio_d_08_pad = w_cam_data[6];
        assign pad_periphs_pad_gpio_d_09_pad = w_cam_data[7];
      end
  endgenerate*/

  generate
      if (USE_SDIO_0==1) begin

        sdModel sdModelTB0(
        .sdClk ( pad_periphs_pad_gpio_b_12_pad ),
        .cmd   ( pad_periphs_pad_gpio_b_13_pad ),
        .dat   ( {
                  pad_periphs_pad_gpio_b_11_pad,
                  pad_periphs_pad_gpio_b_10_pad,
                  pad_periphs_pad_gpio_b_09_pad,
                  pad_periphs_pad_gpio_b_08_pad } 
                )
        );

      end
  endgenerate

  /*generate
      if (USE_SDIO_1==1) begin

        sdModel sdModelTB1(
        .sdClk ( pad_periphs_pad_gpio_f_05_pad ),
        .cmd   ( pad_periphs_pad_gpio_f_06_pad ),
        .dat   ( {
                  pad_periphs_pad_gpio_f_04_pad,
                  pad_periphs_pad_gpio_f_03_pad,
                  pad_periphs_pad_gpio_f_02_pad,
                  pad_periphs_pad_gpio_f_01_pad } 
                )
        );

      end
  endgenerate*/



  /*generate
    if (USE_SERIAL_LINK==1) begin

      localparam time         TckDdr           = 70ns;
      parameter int unsigned AXI_USER_WIDTH    = 1;
      parameter int unsigned AXI_ADDRESS_WIDTH = 64;
      parameter int unsigned AXI_DATA_WIDTH    = 64;
      parameter int unsigned L2_BANK_SIZE      = 4096;
      parameter int unsigned AXI_WRITE_DATA    = 777;   //This define the write data for the write_axi task

      ariane_axi_soc::req_t ddr_1_in_req, ddr_1_out_req;
      ariane_axi_soc::resp_t ddr_1_in_rsp, ddr_1_out_rsp;

      wire [3:0] ddr_i, ddr_o;
      wire ddr_clk;

      logic [63:0] mem_rdata_o, mem_wdata_o, mem_addr_o;
      logic [7:0] mem_strb_o;
      logic req_to_mem, mem_we_o;
      logic clk;

      localparam RegAw  = 32;
      localparam RegDw  = 32;

      typedef logic [RegAw-1:0]   reg_addr_t;
      typedef logic [RegDw-1:0]   reg_data_t;
      typedef logic [RegDw/8-1:0] reg_strb_t;

      `REG_BUS_TYPEDEF_REQ(reg_req_t, reg_addr_t, reg_data_t, reg_strb_t)
      `REG_BUS_TYPEDEF_RSP(reg_rsp_t, reg_data_t)
     
      reg_req_t   ddr_reg_req ='0;
      reg_rsp_t   ddr_reg_rsp ;

      assign pad_periphs_pad_gpio_f_17_pad = pad_periphs_pad_gpio_b_00_pad==1 ? ddr_clk : 0 ;

      assign pad_periphs_pad_gpio_f_18_pad = ddr_o[0];
      assign pad_periphs_pad_gpio_f_19_pad = ddr_o[1];
      assign pad_periphs_pad_gpio_f_20_pad = ddr_o[2];
      assign pad_periphs_pad_gpio_f_21_pad = ddr_o[3];

      assign ddr_i[0] = pad_periphs_pad_gpio_f_22_pad;
      assign ddr_i[1] = pad_periphs_pad_gpio_f_23_pad;       
      assign ddr_i[2] = pad_periphs_pad_gpio_f_24_pad;
      assign ddr_i[3] = pad_periphs_pad_gpio_f_25_pad;

      assign ddr_clk = pad_periphs_pad_gpio_b_00_pad==1 ? ddr_ext_clk : 0; 

      // DDR link ext clock
      initial begin
        clk = 1'b0;
      end
      always begin
        // Emit rising clock edge.
        clk = 1'b1;
        // Wait for at most half the clock period before emitting falling clock edge.  Due to integer
        // division, this is not always exactly half the clock period but as close as we can get.
        #(TckDdr / 2);
        // Emit falling clock edge.
        clk = 1'b0;
        // Wait for remainder of clock period before continuing with next cycle.
        #((TckDdr + 1) / 2);
      end
      assign ddr_ext_clk = clk;

      AXI_BUS #(
        .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH        ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH           ),
        .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH           )
      ) ddr_axi_master();

      AXI_BUS #(
        .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH   ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH      ),
        .AXI_ID_WIDTH   ( ariane_soc::IdWidth ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH      )
      ) ddr_axi_slave();

      `AXI_ASSIGN_FROM_REQ(ddr_axi_slave, ddr_1_out_req)
      `AXI_ASSIGN_TO_RESP(ddr_1_out_rsp, ddr_axi_slave)

      `AXI_ASSIGN_TO_REQ(ddr_1_in_req, ddr_axi_master )
      `AXI_ASSIGN_FROM_RESP(ddr_axi_master, ddr_1_in_rsp )
     
      // first serial instance
      serial_link #(
        .axi_req_t        ( ariane_axi_soc::req_t     ),
        .axi_rsp_t        ( ariane_axi_soc::resp_t    ),
        .aw_chan_t        ( ariane_axi_soc::aw_chan_t ),
        .ar_chan_t        ( ariane_axi_soc::ar_chan_t ),
        .cfg_req_t        ( reg_req_t ),
        .cfg_rsp_t        ( reg_rsp_t )
      ) i_serial_link_out (
          .clk_i          ( s_tck ),
          .rst_ni         ( rst_ni ),
          .testmode_i     ( 1'b0   ),
         
          .axi_in_req_i   ( ddr_1_in_req ), //slv -> mst axi
          .axi_in_rsp_o   ( ddr_1_in_rsp ), //slv -> mst axi

          .axi_out_req_o  ( ddr_1_out_req ), //mst -> slv axi
          .axi_out_rsp_i  ( ddr_1_out_rsp ), //mst -> slv axi

          .cfg_req_i      ( ddr_reg_req  ), //apb slave
          .cfg_rsp_o      ( ddr_reg_rsp  ), //apb slave
          
          .ddr_clk_i      ( ddr_clk ),
          .ddr_i          ( ddr_i ),
          .ddr_o          ( ddr_o )
      );

      axi2mem #(
        .AXI_ID_WIDTH   ( ariane_soc::IdWidthSlave ),
        .AXI_ADDR_WIDTH ( AXI_ADDRESS_WIDTH ),
        .AXI_DATA_WIDTH ( AXI_DATA_WIDTH ),
        .AXI_USER_WIDTH ( AXI_USER_WIDTH )
      ) i_axi2rom (
        .clk_i  ( s_tck ),
        .rst_ni ( rst_ni ),
        .slave  ( ddr_axi_slave ), //from serial link mst port (slv)
        .req_o  ( req_to_mem  ), //to mem
        .we_o   ( mem_we_o    ),
        .addr_o ( mem_addr_o  ),
        .be_o   ( mem_strb_o  ),
        .data_o ( mem_wdata_o ),

        .data_i ( mem_rdata_o ) //from mem
      );

      tc_sram #(
        .SimInit   ( "random"            ),
        .NumWords  ( L2_BANK_SIZE        ), // 2^15 lines of 32 bits each (128kB), 4 Banks -> 512 kB total memory
        .DataWidth ( AXI_DATA_WIDTH      ),
        .NumPorts  ( 1                   )
      ) slink_mem (
        .clk_i   ( s_tck ),
        .rst_ni  ( rst_ni      ),
        .req_i   ( req_to_mem  ),
        .we_i    ( mem_we_o    ),
        .addr_i  ( mem_addr_o  ),
        .wdata_i ( mem_wdata_o ),
        .be_i    ( mem_strb_o  ),
        .rdata_o ( mem_rdata_o )
      );

       // -------------------- DDR AXI drivers --------------------

        localparam AxiAw  = 64;
        localparam AxiDw  = 64;
        localparam AxiMaxSize = $clog2(AxiDw/8);
        localparam AxiIw  = ariane_soc::IdWidthSlave;

        typedef logic [AxiAw-1:0]   axi_addr_t;
        typedef logic [AxiDw-1:0]   axi_data_t;
        typedef logic [AxiDw/8-1:0] axi_strb_t;
        typedef logic [AxiIw-1:0]   axi_id_t;

    
        AXI_BUS_DV #(
            .AXI_ADDR_WIDTH(AxiAw ),
            .AXI_DATA_WIDTH(AxiDw ),
            .AXI_ID_WIDTH  (AxiIw ),
            .AXI_USER_WIDTH(1     )
        ) axi_dv(s_tck);

        `AXI_ASSIGN(ddr_axi_master, axi_dv)

        typedef axi_test::axi_driver #(
            .AW(AxiAw ),
            .DW(AxiDw ),
            .IW(AxiIw ),
            .UW(1),
            .TA(REFClockPeriod*0.1),
            .TT(REFClockPeriod*0.9)
        ) axi_drv_t;

        axi_drv_t ddr_axi_master_drv = new(axi_dv);

        axi_test::axi_ax_beat #(.AW(AxiAw ), .IW(AxiIw ), .UW(1)) ar_beat = new();
        axi_test::axi_r_beat  #(.DW(AxiDw ), .IW(AxiIw ), .UW(1)) r_beat  = new();
        axi_test::axi_ax_beat #(.AW(AxiAw ), .IW(AxiIw ), .UW(1)) aw_beat = new();
        axi_test::axi_w_beat  #(.DW(AxiDw ), .UW(1))              w_beat  = new();
        axi_test::axi_b_beat  #(.IW(AxiIw ), .UW(1))              b_beat  = new();

        initial begin
            ddr_axi_master_drv.reset_master();
            @(posedge pad_periphs_pad_gpio_b_00_pad);
                #(1ms)
                 write_axi('h1C000000, 4090, 3, AXI_WRITE_DATA, 'hffff);
        end

        // -------------------------- Regbus driver --------------------------


        logic [AxiDw-1:0] trans_wdata;
        logic [AxiDw-1:0] trans_rdata;
        axi_addr_t    temp_waddr;
        axi_addr_t    temp_raddr;
        logic [4:0]   last_waddr;
        logic [4:0]   last_raddr;
        typedef logic [AxiDw-1:0] data_t;   

        data_t        memory[bit [31:0]];
        int           read_index = 0;
        int           write_index = 0;
       
       
        reg_req_t   reg_req;
        reg_rsp_t   reg_rsp;

        REG_BUS #(
            .ADDR_WIDTH( RegAw ),
            .DATA_WIDTH( RegDw )
        ) i_rbus (
            .clk_i (s_tck)
        );
        
        integer fr, fw;

        reg_test::reg_driver #(
            .AW ( RegAw  ),
            .DW ( RegDw  ),
            .TA(REFClockPeriod*0.1),
            .TT(REFClockPeriod*0.9)
        ) i_rmaster = new( i_rbus );

        assign reg_req = reg_req_t'{
            addr:   i_rbus.addr,
            write:  i_rbus.write,
            wdata:  i_rbus.wdata,
            wstrb:  i_rbus.wstrb,
            valid:  i_rbus.valid
        };

        assign i_rbus.rdata = reg_rsp.rdata;
        assign i_rbus.ready = reg_rsp.ready;
        assign i_rbus.error = reg_rsp.error;

      //----------------------- AXI DRIVER TASKS --------------------------

      int unsigned            k, j;

          // axi write task
          task write_axi;
              input axi_addr_t      waddr;
              input axi_pkg::len_t  burst_len;
              input axi_pkg::size_t size;
              input logic [63:0]    data_w;
              input axi_strb_t      wstrb;

              @(posedge s_tck);

              temp_waddr = waddr;
              aw_beat.ax_addr  = waddr;
              aw_beat.ax_len   = burst_len;
              aw_beat.ax_burst = axi_pkg::BURST_INCR;
              aw_beat.ax_size  = size;
             
              w_beat.w_strb   = wstrb;
              w_beat.w_last   = 1'b0;
              last_waddr = '0;

              if(aw_beat.ax_size>AxiMaxSize) begin
                $display("Not supported");
              end else begin
                $display("%p", aw_beat);

                ddr_axi_master_drv.send_aw(aw_beat);
                
                
                for(int unsigned i = 0; i < burst_len + 1; i++) begin
                    if (i == burst_len) begin
                        w_beat.w_last = 1'b1;
                    end
                    w_beat.w_data = data_w;
                    ddr_axi_master_drv.send_w(w_beat);
                    trans_wdata = '1; //the memory regions where we do not write are have all ones in the hyperram.
                    `ifdef AXI_VERBOSE
                    $display("%p", w_beat);
                    $display("%x", w_beat.w_data);
                    `endif
                    if (i==0) begin
                       for (k = temp_waddr[AxiMaxSize-1:0]; k<(((temp_waddr[AxiMaxSize-1:0]>>size)<<size) + (2**size)) ; k++)  begin
                         trans_wdata[k*8 +:8] = (wstrb[k]) ? w_beat.w_data[(k*8) +: 8] : '1;
                       end
                    end else begin
                       for(j=temp_waddr[AxiMaxSize-1:0]; j<temp_waddr[AxiMaxSize-1:0]+(2**size); j++) begin
                          trans_wdata[j*8 +:8] = (wstrb[j]) ? w_beat.w_data[(j*8) +: 8] : '1;
                       end
                    end
                    $fwrite(fw, "%x %x %x %d %d \n",  w_beat.w_data, trans_wdata, temp_waddr, (((temp_waddr[AxiMaxSize-1:0]>>size)<<size) + (2**size)), write_index);
                    memory[write_index]=trans_wdata;
                    if($isunknown(trans_wdata)) begin
                       $fatal(1,"Xs @%x\n",temp_waddr);
                    end   
                    write_index++;
                    if(i==0)
                      temp_waddr = ((temp_waddr>>size)<<size) + (2**size);
                    else
                      temp_waddr = temp_waddr + (2**size);
                    last_waddr = temp_waddr[AxiMaxSize-1:0] + (2**size);
                end // for (int unsigned i = 0; i < burst_len + 1; i++)
                
                ddr_axi_master_drv.recv_b(b_beat);
              end 
             
          endtask


    end  
  endgenerate*/

  generate
     for (genvar i=0; i< NumChips ; i++) begin : hyperrams

        if ( NumPhys == 2 ) begin : double
           
           s27ks0641 #(
                 .TimingModel   ( "S27KS0641DPBHI020"    ),
                 .UserPreload   ( PRELOAD_HYPERRAM       ),
                 .mem_file_name ( "./hyperram0.slm"      )
             ) i_main_hyperram0 (
                    .DQ7           ( hyper_dq_wire[0][7]      ),
                    .DQ6           ( hyper_dq_wire[0][6]      ),
                    .DQ5           ( hyper_dq_wire[0][5]      ),
                    .DQ4           ( hyper_dq_wire[0][4]      ),
                    .DQ3           ( hyper_dq_wire[0][3]      ),
                    .DQ2           ( hyper_dq_wire[0][2]      ),
                    .DQ1           ( hyper_dq_wire[0][1]      ),
                    .DQ0           ( hyper_dq_wire[0][0]      ),
                    .RWDS          ( hyper_rwds_wire[0]       ),
                    .CSNeg         ( hyper_cs_n_wire[0][i]    ),
                    .CK            ( hyper_ck_wire[0]         ),
                    .CKNeg         ( hyper_ck_n_wire[0]       ),
                    .RESETNeg      ( hyper_reset_n_wire[0]    )
           ); 
           s27ks0641 #(
                 .TimingModel   ( "S27KS0641DPBHI020"    ),
                 .UserPreload   ( PRELOAD_HYPERRAM       ),
                 .mem_file_name ( "./hyperram1.slm"      )
             ) i_main_hyperram1 (
                    .DQ7           ( hyper_dq_wire[1][7]      ),
                    .DQ6           ( hyper_dq_wire[1][6]      ),
                    .DQ5           ( hyper_dq_wire[1][5]      ),
                    .DQ4           ( hyper_dq_wire[1][4]      ),
                    .DQ3           ( hyper_dq_wire[1][3]      ),
                    .DQ2           ( hyper_dq_wire[1][2]      ),
                    .DQ1           ( hyper_dq_wire[1][1]      ),
                    .DQ0           ( hyper_dq_wire[1][0]      ),
                    .RWDS          ( hyper_rwds_wire[1]       ),
                    .CSNeg         ( hyper_cs_n_wire[1][i]    ),
                    .CK            ( hyper_ck_wire[1]         ),
                    .CKNeg         ( hyper_ck_n_wire[1]       ),
                    .RESETNeg      ( hyper_reset_n_wire[1]    )
           );
        end else begin : single          
          
           s27ks0641 #(
                 .TimingModel   ( "S27KS0641DPBHI020"    ),
                 .UserPreload   ( PRELOAD_HYPERRAM       ),
                 .mem_file_name ( "./hyperram.slm"       )
             ) i_main_hyperram0 (
                    .DQ7           ( hyper_dq_wire[0][7]      ),
                    .DQ6           ( hyper_dq_wire[0][6]      ),
                    .DQ5           ( hyper_dq_wire[0][5]      ),
                    .DQ4           ( hyper_dq_wire[0][4]      ),
                    .DQ3           ( hyper_dq_wire[0][3]      ),
                    .DQ2           ( hyper_dq_wire[0][2]      ),
                    .DQ1           ( hyper_dq_wire[0][1]      ),
                    .DQ0           ( hyper_dq_wire[0][0]      ),
                    .RWDS          ( hyper_rwds_wire[0]       ),
                    .CSNeg         ( hyper_cs_n_wire[0][i]    ),
                    .CK            ( hyper_ck_wire[0]         ),
                    .CKNeg         ( hyper_ck_n_wire[0]       ),
                    .RESETNeg      ( hyper_reset_n_wire[0]    )
           ); 
        end // block: single
          
     end // block: hyperrams
   endgenerate
   
   uart_bus #(.BAUD_RATE(115200), .PARITY_EN(0)) i_uart0_bus (.rx(w_cva6_uart_tx), .tx(w_cva6_uart_rx), .rx_en(1'b1));
   uart_bus #(.BAUD_RATE(115200), .PARITY_EN(0)) i_uart1_bus (.rx(apb_uart_tx), .tx(apb_uart_rx), .rx_en(1'b1));

    initial begin: reset_jtag
      jtag_mst.tdi = 0;
      jtag_mst.tms = 0;
    end
  
    // JTAG Definition
    typedef jtag_test::riscv_dbg #(
      .IrLength       (5                 ),
      .TA             (REFClockPeriod*0.1),
      .TT             (REFClockPeriod*0.9),
      .JtagSampleDelay(JtagSampleDelay   )
    ) riscv_dbg_t;
  
    // JTAG driver
    JTAG_DV jtag_mst (s_tck);
    riscv_dbg_t::jtag_driver_t jtag_driver = new(jtag_mst);
    riscv_dbg_t riscv_dbg = new(jtag_driver);
  
    assign s_trstn      = jtag_mst.trst_n;
    assign s_tms        = jtag_mst.tms;
    assign s_tdi        = jtag_mst.tdi;
    assign jtag_mst.tdo = s_tdo;

    // Clock process
    initial begin
        rst_ni = 1'b0;
        rst_DTM = 1'b0;
        jtag_mst.trst_n = 1'b0;
       
        repeat(2)
            @(posedge rtc_i);
        @(negedge rtc_i);       
        rst_ni = 1'b1;
        repeat(8)
            @(posedge rtc_i);
        rst_DTM = 1'b1;
        jtag_mst.trst_n = 1'b1;       
        forever begin
            @(posedge clk_i);
            cycles++;
        end
    end

    initial begin
        forever begin
            rtc_i = 1'b0;
            #(RTC_CLOCK_PERIOD/2) rtc_i = 1'b1;
            #(RTC_CLOCK_PERIOD/2) rtc_i = 1'b0;
        end
    end
   
   assign clk_i = dut.i_host_domain.i_apb_subsystem.i_alsaqr_clk_rst_gen.clk_soc_o;

   initial begin
      s_tck = '0;
      forever
        #(REFClockPeriod/2) s_tck=~s_tck;
   end
      
    initial begin
        forever begin

            wait (exit_o[0]);

            if ((exit_o >> 1)) begin
                `uvm_error( "Core Test",  $sformatf("*** FAILED *** (tohost = %0d)", (exit_o >> 1)))
            end else begin
                `uvm_info( "Core Test",  $sformatf("*** SUCCESS *** (tohost = %0d)", (exit_o >> 1)), UVM_LOW)
            end

            $stop;
        end
    end


   initial  begin: local_jtag_preload

      logic [63:0] rdata;
      logic [32:0] addr;

      automatic dm::sbcs_t sbcs = '{
        sbautoincrement: 1'b1,
        sbreadondata   : 1'b1,
        default        : 1'b0
      };
      
      if(LOCAL_JTAG) begin

         if(!PRELOAD_HYPERRAM) begin
           if ( $value$plusargs ("CVA6_STRING=%s", binary));
             $display("Testing %s", binary);
           if ( $value$plusargs ("CL_STRING=%s", cluster_binary));
            if(cluster_binary!="none") 
              $display("Testing cluster: %s", cluster_binary);
         end 
         
        repeat(20)
            @(posedge rtc_i);
           debug_module_init();
           if(!PRELOAD_HYPERRAM) begin
              // LOAD cluster code
              if(cluster_binary!="none") 
                load_binary(cluster_binary);
              
              load_binary(binary);
              // Call the JTAG preload task
              jtag_data_preload();
           end else begin
              $display("Sanity write/read at 0x1C000000"); // word = 8 bytes here
              addr = 32'h1c000000;
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);
              riscv_dbg.write_dmi(dm::SBCS, sbcs);
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);
              riscv_dbg.write_dmi(dm::SBAddress0, addr);
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);         
              riscv_dbg.write_dmi(dm::SBData1, 32'hdeadcaca);
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);           
              riscv_dbg.write_dmi(dm::SBData0, 32'habbaabba);
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);  
              sbcs.sbreadonaddr = 1;
              riscv_dbg.write_dmi(dm::SBCS, sbcs);
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);  
              riscv_dbg.write_dmi(dm::SBAddress0, addr);
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);
              riscv_dbg.read_dmi(dm::SBData1, rdata[63:32]);
              // Wait until SBA is free to read another 32 bits
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);           
              riscv_dbg.read_dmi(dm::SBData0, rdata[32:0]);
              // Wait until SBA is free to read another 32 bits
              do riscv_dbg.read_dmi(dm::SBCS, sbcs);
              while (sbcs.sbbusy);           
              if(rdata!=64'hdeadcacaabbaabba) begin
                $fatal(1,"rdata at 0x1c000000: %x" , rdata);
              end else begin
                $display("R/W sanity check ok!");
              end
           end 

           #(REFClockPeriod);
           jtag_ariane_wakeup(32'h80000000);
           jtag_read_eoc(32'h80000000);
         end 
   end
   
  task debug_module_init;
    logic [31:0]  idcode;
    automatic dm::sbcs_t sbcs;

`ifdef POSTLAYOUT
    #(0.05 * REFClockPeriod);
`endif

    $info(" JTAG Preloading start time");
    riscv_dbg.wait_idle(300);

`ifdef POSTLAYOUT
    #(0.05 * REFClockPeriod);
`endif

    $info(" Start getting idcode of JTAG");
    riscv_dbg.get_idcode(idcode);

    // Check Idcode
    assert (idcode == dm_idcode)
    else $error(" Wrong IDCode, expected: %h, actual: %h", dm_idcode, idcode);
    $display(" IDCode = %h", idcode);

    $info(" Activating Debug Module");
    // Activate Debug Module
    riscv_dbg.write_dmi(dm::DMControl, 32'h0000_0001);

    $info(" SBA BUSY ");
    // Wait until SBA is free
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    $info(" SBA FREE");
  endtask // debug_module_init
   
   task jtag_data_preload;
    logic [63:0] rdata;

    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    $display("======== Initializing the Debug Module ========");

    debug_module_init();
    riscv_dbg.write_dmi(dm::SBCS, sbcs);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);

    $display("======== Preload data to SRAM ========");

    // Start writing to SRAM
    foreach (sections[addr]) begin
      $display("Writing %h with %0d words", addr << 3, sections[addr]); // word = 8 bytes here
       riscv_dbg.write_dmi(dm::SBAddress0, (addr << 3));
       do riscv_dbg.read_dmi(dm::SBCS, sbcs);
       while (sbcs.sbbusy);
      for (int i = 0; i < sections[addr]; i++) begin
        // $info(" Loading words to SRAM ");
        $display(" -- Word %0d/%0d", i, sections[addr]);
        riscv_dbg.write_dmi(dm::SBData1, memory[addr + i][63:32]);
        do riscv_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);           
        riscv_dbg.write_dmi(dm::SBData0, memory[addr + i][32:0]);
        // Wait until SBA is free to write next 32 bits
        do riscv_dbg.read_dmi(dm::SBCS, sbcs);
        while (sbcs.sbbusy);
      end
    end

    // Check loaded data
    if (CHECK_LOCAL_JTAG) begin
      $display("======== Checking loaded data ========");
      // Set SBCS register to read data
      sbcs.sbreadonaddr = 1;
      riscv_dbg.write_dmi(dm::SBCS, sbcs);
      foreach (sections[addr]) begin
        $display(" Checking %h", addr << 3);
        riscv_dbg.write_dmi(dm::SBAddress0, (addr << 3));
        for (int i = 0; i < sections[addr]; i++) begin
          riscv_dbg.read_dmi(dm::SBData1, rdata[63:32]);
          // Wait until SBA is free to read another 32 bits
          do riscv_dbg.read_dmi(dm::SBCS, sbcs);
          while (sbcs.sbbusy);           
          riscv_dbg.read_dmi(dm::SBData0, rdata[32:0]);
          // Wait until SBA is free to read another 32 bits
          do riscv_dbg.read_dmi(dm::SBCS, sbcs);
          while (sbcs.sbbusy);
          if (rdata != memory[addr + i])
            $error("Mismatch detected at %h, expected %0d, actual %0d",
              (addr + i) << 3, memory[addr + 1], rdata);
        end
      end
    end

    $display("======== Preloading finished ========");

    // Preloading finished. Can now start executing
    sbcs.sbreadonaddr = 0;
    sbcs.sbreadondata = 0;
    riscv_dbg.write_dmi(dm::SBCS, sbcs);

  endtask // jtag_data_preload


  // Load ELF binary file
  task load_binary;
    input string binary;                   // File name
    addr_t       section_addr, section_len;
    byte         buffer[];

    // Read ELF
    void'(read_elf(binary));
    $display("Reading %s", binary);
    while (get_section(section_addr, section_len)) begin
      // Read Sections
      automatic int num_words = (section_len + AxiWideBeWidth - 1)/AxiWideBeWidth;
      $display("Reading section %x with %0d words", section_addr, num_words);

      sections[section_addr >> AxiWideByteOffset] = num_words;
      buffer                                      = new[num_words * AxiWideBeWidth];
      void'(read_section(section_addr, buffer));
      for (int i = 0; i < num_words; i++) begin
        automatic logic [AxiWideBeWidth-1:0][7:0] word = '0;
        for (int j = 0; j < AxiWideBeWidth; j++) begin
          word[j] = buffer[i * AxiWideBeWidth + j];
        end
        memory[section_addr/AxiWideBeWidth + i] = word;
      end
    end

  endtask // load_binary

  
  task jtag_ariane_wakeup;
    input logic [31:0] start_addr;
    logic [31:0] dm_status;
     
    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    $info("======== Waking up Ariane using JTAG ========");
    // Initialize the dm module again, otherwise it will not work
    debug_module_init();
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    // Write PC to Data0 and Data1
    riscv_dbg.write_dmi(dm::Data0, start_addr);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    riscv_dbg.write_dmi(dm::Data1, 32'h0000_0000);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    // Halt Req
    riscv_dbg.write_dmi(dm::DMControl, 32'h8000_0001);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    // Wait for CVA6 to be halted
    do riscv_dbg.read_dmi(dm::DMStatus, dm_status);
    while (!dm_status[8]);
    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    riscv_dbg.write_dmi(dm::DMControl, 32'h0000_0001);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    // Register Access Abstract Command  
    riscv_dbg.write_dmi(dm::Command, {8'h0,1'b0,3'h3,1'b0,1'b0,1'b1,1'b1,4'h0,dm::CSR_DPC});
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    // Resume req. Exiting from debug mode CVA6 will jump at the DPC address.
    // Ensure haltreq, resumereq and ackhavereset all equal to 0
    riscv_dbg.write_dmi(dm::DMControl, 32'h4000_0001);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
    riscv_dbg.write_dmi(dm::DMControl, 32'h0000_0001);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);
     
    // Wait till end of computation
    program_loaded = 1;

    // When task completed reading the return value using JTAG
    // Mainly used for post synthesis part
    $info("======== Wait for Completion ========");

  endtask // execute_application

  task jtag_read_eoc;
    input logic [31:0] start_addr;
     
    automatic dm::sbcs_t sbcs = '{
      sbautoincrement: 1'b1,
      sbreadondata   : 1'b1,
      default        : 1'b0
    };

    logic [31:0] to_host_addr;
    to_host_addr = start_addr + 32'h1000;
 
    // Initialize the dm module again, otherwise it will not work
    debug_module_init();
    sbcs.sbreadonaddr = 1;
    sbcs.sbautoincrement = 0;
    riscv_dbg.write_dmi(dm::SBCS, sbcs);
    do riscv_dbg.read_dmi(dm::SBCS, sbcs);
    while (sbcs.sbbusy);

    riscv_dbg.write_dmi(dm::SBAddress0, to_host_addr); // tohost address
    riscv_dbg.wait_idle(10);
    do begin 
	     do riscv_dbg.read_dmi(dm::SBCS, sbcs);
	     while (sbcs.sbbusy);
       riscv_dbg.write_dmi(dm::SBAddress0, to_host_addr); // tohost address
	     do riscv_dbg.read_dmi(dm::SBCS, sbcs);
	     while (sbcs.sbbusy);
       riscv_dbg.read_dmi(dm::SBData0, retval);
       # 100ns;
    end while (~retval[0]);
     

    if (retval[31:1]!=0) begin
        `uvm_error( "Core Test",  $sformatf("*** FAILED *** (tohost = %0d)",retval[31:1]))
    end else begin
        `uvm_info( "Core Test",  $sformatf("*** SUCCESS *** (tohost = %0d)", (retval[31:1])), UVM_LOW)
    end

     $finish;
     
  endtask // jtag_read_eoc

endmodule // ariane_tb


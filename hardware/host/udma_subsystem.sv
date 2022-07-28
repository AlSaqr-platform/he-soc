// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
`include "register_interface/typedef.svh"
`include "register_interface/assign.svh"
`include "axi/assign.svh"

module udma_subsystem
  import axi_pkg::xbar_cfg_t;
  import udma_subsystem_pkg::*;
  import ariane_soc::HyperbusNumPhys;
  import ariane_soc::NumChipsPerHyperbus;
(
    output logic                       L2_ro_wen_o ,
    output logic                       L2_ro_req_o ,
    input logic                        L2_ro_gnt_i ,
    output logic [31:0]                L2_ro_addr_o ,
    output logic [L2_DATA_WIDTH/8-1:0] L2_ro_be_o ,
    output logic [L2_DATA_WIDTH-1:0]   L2_ro_wdata_o ,
    input logic                        L2_ro_rvalid_i ,
    input logic [L2_DATA_WIDTH-1:0]    L2_ro_rdata_i ,

    output logic                       L2_wo_wen_o ,
    output logic                       L2_wo_req_o ,
    input logic                        L2_wo_gnt_i ,
    output logic [31:0]                L2_wo_addr_o ,
    output logic [L2_DATA_WIDTH-1:0]   L2_wo_wdata_o ,
    output logic [L2_DATA_WIDTH/8-1:0] L2_wo_be_o ,
    input logic                        L2_wo_rvalid_i ,
    input logic [L2_DATA_WIDTH-1:0]    L2_wo_rdata_i ,

    input logic                        dft_test_mode_i,
    input logic                        dft_cg_enable_i,

    input logic                        sys_clk_i,
    input logic                        sys_resetn_i,

    input logic                        periph_clk_i,

    input logic [APB_ADDR_WIDTH-1:0]   udma_apb_paddr,
    input logic [31:0]                 udma_apb_pwdata,
    input logic                        udma_apb_pwrite,
    input logic                        udma_apb_psel,
    input logic                        udma_apb_penable,
    output logic [31:0]                udma_apb_prdata,
    output logic                       udma_apb_pready,
    output logic                       udma_apb_pslverr,

    output logic [31*4-1:0]            events_o,

    input logic                        event_valid_i,
    input logic [7:0]                  event_data_i,
    output logic                       event_ready_o,

    AXI_BUS.Slave                      hyper_axi_bus_slave, 
    REG_BUS.in                         hyper_reg_cfg_slave,
 
    // SPIM
    output                             qspi_to_pad_t [N_SPI-1:0] qspi_to_pad,
    input                              pad_to_qspi_t [N_SPI-1:0] pad_to_qspi,
    
    // I2C
    output                             i2c_to_pad_t [N_I2C-1:0] i2c_to_pad,
    input                              pad_to_i2c_t [N_I2C-1:0] pad_to_i2c,
   
    // CAM
  	input                              pad_to_cam_t [N_CAM-1:0] pad_to_cam,
    
    // UART
    input                              pad_to_uart_t [N_UART-1:0] pad_to_uart,
    output                             uart_to_pad_t [N_UART-1:0] uart_to_pad,
    
    // SDIO
    output                             sdio_to_pad_t [N_SDIO-1:0] sdio_to_pad,
    input                              pad_to_sdio_t [N_SDIO-1:0] pad_to_sdio
 
    // HYPERBUS
    `ifndef XILINX_DDR
    ,
    inout  [HyperbusNumPhys-1:0][NumChipsPerHyperbus-1:0] pad_hyper_csn,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_ck,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_ckn,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_rwds,
    inout  [HyperbusNumPhys-1:0]                          pad_hyper_reset,
    inout  [HyperbusNumPhys-1:0][7:0]                     pad_hyper_dq 
   `endif
);


    localparam DEST_SIZE = 2;

    localparam L2_AWIDTH_NOAL = L2_ADDR_WIDTH + 2;

    localparam N_FILTER   = 1;
    localparam N_CH_HYPER = 1;
   
    localparam N_RX_CHANNELS =   N_SPI + N_HYPER + N_SDIO + N_UART + N_I2C + N_CAM;
    localparam N_TX_CHANNELS = 2*N_SPI + N_HYPER + N_SDIO + N_UART + 2*N_I2C;

    localparam N_RX_EXT_CHANNELS =   N_FILTER;
    localparam N_TX_EXT_CHANNELS = 2*N_FILTER;
    localparam N_STREAMS         =   N_FILTER;
    localparam STREAM_ID_WIDTH   = 1;//$clog2(N_STREAMS)

    localparam N_PERIPHS = N_SPI + N_HYPER + N_UART + N_I2C + N_CAM + N_SDIO + N_FILTER + N_CH_HYPER*N_HYPER;  
    localparam N_EVENTS  = N_SPI + N_HYPER + N_UART + N_I2C + N_CAM + N_SDIO + N_FILTER ;  

    // TX Channels
    localparam CH_ID_TX_UART    = 0;
    localparam CH_ID_TX_SPIM    = N_UART;
    localparam CH_ID_CMD_SPIM   = CH_ID_TX_SPIM  + N_SPI  ;
    localparam CH_ID_TX_I2C     = CH_ID_CMD_SPIM + N_SPI  ;
    localparam CH_ID_CMD_I2C    = CH_ID_TX_I2C   + N_I2C  ;
    localparam CH_ID_TX_SDIO    = CH_ID_CMD_I2C  + N_I2C  ;
    localparam CH_ID_TX_HYPER   = CH_ID_TX_SDIO  + N_SDIO ;
    // Tx Ext Channel
    localparam CH_ID_TX_EXT_PER = CH_ID_TX_HYPER + N_HYPER ;
 

    // RX Channels
    localparam CH_ID_RX_UART    = 0;
    localparam CH_ID_RX_SPIM    = N_UART;
    localparam CH_ID_RX_I2C     = CH_ID_RX_SPIM  + N_SPI  ;
    localparam CH_ID_RX_SDIO    = CH_ID_RX_I2C   + N_I2C  ;
    localparam CH_ID_RX_CAM     = CH_ID_RX_SDIO  + N_SDIO ;
    localparam CH_ID_RX_HYPER   = CH_ID_RX_CAM   + N_CAM  ;
    // Rx Ext Channel
    localparam CH_ID_RX_EXT_PER = CH_ID_RX_HYPER + N_HYPER;

    // Stream Channel
    localparam STREAM_ID_FILTER = 0;

    localparam CH_ID_EXT_TX_FILTER = 0;
    localparam CH_ID_EXT_RX_FILTER = 0;

    localparam PER_ID_UART    = 0;                  
    localparam PER_ID_SPIM    = PER_ID_UART   + N_UART   ; // 7
    localparam PER_ID_I2C     = PER_ID_SPIM   + N_SPI    ; // 18   
    localparam PER_ID_SDIO    = PER_ID_I2C    + N_I2C    ; // 24
    localparam PER_ID_CAM     = PER_ID_SDIO   + N_SDIO   ; // 26
    localparam PER_ID_FILTER  = PER_ID_CAM    + N_CAM    ; // 28
    localparam PER_ID_HYPER   = PER_ID_FILTER + N_FILTER ; // 29
    

    logic [N_TX_CHANNELS-1:0] [L2_AWIDTH_NOAL-1 : 0] s_tx_cfg_startaddr;
    logic [N_TX_CHANNELS-1:0]     [TRANS_SIZE-1 : 0] s_tx_cfg_size;
    logic [N_TX_CHANNELS-1:0]                        s_tx_cfg_continuous;
    logic [N_TX_CHANNELS-1:0]                        s_tx_cfg_en;
    logic [N_TX_CHANNELS-1:0]                        s_tx_cfg_clr;

    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_req;
    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_gnt;
    logic [N_TX_CHANNELS-1:0]               [31 : 0] s_tx_ch_data;
    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_valid;
    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_ready;
    logic [N_TX_CHANNELS-1:0]                [1 : 0] s_tx_ch_datasize;
    logic [N_TX_CHANNELS-1:0]      [DEST_SIZE-1 : 0] s_tx_ch_destination;
    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_events;
    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_en;
    logic [N_TX_CHANNELS-1:0]                        s_tx_ch_pending;
    logic [N_TX_CHANNELS-1:0] [L2_AWIDTH_NOAL-1 : 0] s_tx_ch_curr_addr;
    logic [N_TX_CHANNELS-1:0]     [TRANS_SIZE-1 : 0] s_tx_ch_bytes_left;

    logic [N_RX_CHANNELS-1:0] [L2_AWIDTH_NOAL-1 : 0] s_rx_cfg_startaddr;
    logic [N_RX_CHANNELS-1:0]     [TRANS_SIZE-1 : 0] s_rx_cfg_size;
    logic [N_RX_CHANNELS-1:0]                        s_rx_cfg_continuous;
    logic [N_RX_CHANNELS-1:0]                        s_rx_cfg_en;
    logic [N_RX_CHANNELS-1:0]                        s_rx_cfg_clr;
    logic [N_RX_CHANNELS-1:0]                [1 : 0] s_rx_cfg_stream;
    logic [N_RX_CHANNELS-1:0] [STREAM_ID_WIDTH-1: 0] s_rx_cfg_stream_id;

    logic [N_RX_CHANNELS-1:0]               [31 : 0] s_rx_ch_data;
    logic [N_RX_CHANNELS-1:0]                        s_rx_ch_valid;
    logic [N_RX_CHANNELS-1:0]                        s_rx_ch_ready;
    logic [N_RX_CHANNELS-1:0]                [1 : 0] s_rx_ch_datasize;
    logic [N_RX_CHANNELS-1:0]      [DEST_SIZE-1 : 0] s_rx_ch_destination;
    logic [N_RX_CHANNELS-1:0]                        s_rx_ch_events;
    logic [N_RX_CHANNELS-1:0]                        s_rx_ch_en;
    logic [N_RX_CHANNELS-1:0]                        s_rx_ch_pending;
    logic [N_RX_CHANNELS-1:0] [L2_AWIDTH_NOAL-1 : 0] s_rx_ch_curr_addr;
    logic [N_RX_CHANNELS-1:0]     [TRANS_SIZE-1 : 0] s_rx_ch_bytes_left;

    logic [N_RX_EXT_CHANNELS-1:0]  [L2_AWIDTH_NOAL-1 : 0] s_rx_ext_addr;
    logic [N_RX_EXT_CHANNELS-1:0]                 [1 : 0] s_rx_ext_datasize;
    logic [N_RX_EXT_CHANNELS-1:0]       [DEST_SIZE-1 : 0] s_rx_ext_destination;
    logic [N_RX_EXT_CHANNELS-1:0]                 [1 : 0] s_rx_ext_stream;
    logic [N_RX_EXT_CHANNELS-1:0] [STREAM_ID_WIDTH-1 : 0] s_rx_ext_stream_id;
    logic [N_RX_EXT_CHANNELS-1:0]                         s_rx_ext_sot;
    logic [N_RX_EXT_CHANNELS-1:0]                         s_rx_ext_eot;
    logic [N_RX_EXT_CHANNELS-1:0]                         s_rx_ext_valid;
    logic [N_RX_EXT_CHANNELS-1:0]                [31 : 0] s_rx_ext_data;
    logic [N_RX_EXT_CHANNELS-1:0]                         s_rx_ext_ready;

    logic [N_TX_EXT_CHANNELS-1:0]                        s_tx_ext_req;
    logic [N_TX_EXT_CHANNELS-1:0]                [1 : 0] s_tx_ext_datasize;
    logic [N_TX_EXT_CHANNELS-1:0]      [DEST_SIZE-1 : 0] s_tx_ext_destination;
    logic [N_TX_EXT_CHANNELS-1:0] [L2_AWIDTH_NOAL-1 : 0] s_tx_ext_addr;
    logic [N_TX_EXT_CHANNELS-1:0]                        s_tx_ext_gnt;
    logic [N_TX_EXT_CHANNELS-1:0]                        s_tx_ext_valid;
    logic [N_TX_EXT_CHANNELS-1:0]               [31 : 0] s_tx_ext_data;
    logic [N_TX_EXT_CHANNELS-1:0]                        s_tx_ext_ready;

    logic [N_STREAMS-1:0]                    [31 : 0] s_stream_data;
    logic [N_STREAMS-1:0]                     [1 : 0] s_stream_datasize;
    logic [N_STREAMS-1:0]                             s_stream_valid;
    logic [N_STREAMS-1:0]                             s_stream_sot;
    logic [N_STREAMS-1:0]                             s_stream_eot;
    logic [N_STREAMS-1:0]                             s_stream_ready;

    logic [N_EVENTS*4-1:0] s_events;

    logic         [1:0] s_rf_event;

    logic [N_PERIPHS-1:0]        s_clk_periphs_core;
    logic [N_PERIPHS-1:0]        s_clk_periphs_per;

    logic                 [31:0] s_periph_data_to;
    logic                  [4:0] s_periph_addr;
    logic                        s_periph_rwn;
    logic [N_PERIPHS-1:0] [31:0] s_periph_data_from;
    logic [N_PERIPHS-1:0]        s_periph_valid;
    logic [N_PERIPHS-1:0]        s_periph_ready;

    logic            [N_SPI-1:0] s_spi_eot;
    logic            [N_I2C-1:0] s_i2c_evt;
    logic            [N_I2C-1:0] s_i2c_eot;
   
    logic         [3:0] s_trigger_events;

    logic s_filter_eot_evt;
    logic s_filter_act_evt;

    integer i;

    assign s_cam_evt     = 1'b0;

    assign events_o      = s_events;
       
    assign L2_ro_wen_o   = 1'b1;
    assign L2_wo_wen_o   = 1'b0;

    assign L2_ro_be_o    =  'h0;
    assign L2_ro_wdata_o =  'h0;

    udma_core #(
        .L2_AWIDTH_NOAL    ( L2_AWIDTH_NOAL    ),
        .L2_DATA_WIDTH     ( L2_DATA_WIDTH     ),
        .DATA_WIDTH        ( 32                ),
        .N_RX_LIN_CHANNELS ( N_RX_CHANNELS     ),
        .N_TX_LIN_CHANNELS ( N_TX_CHANNELS     ),
        .N_RX_EXT_CHANNELS ( N_RX_EXT_CHANNELS ),
        .N_TX_EXT_CHANNELS ( N_TX_EXT_CHANNELS ),
        .N_STREAMS         ( N_STREAMS         ),
        .STREAM_ID_WIDTH   ( STREAM_ID_WIDTH   ),
        .TRANS_SIZE        ( TRANS_SIZE        ),
        .N_PERIPHS         ( N_PERIPHS         ),
        .APB_ADDR_WIDTH    ( APB_ADDR_WIDTH    )
    ) i_udmacore (
        .sys_clk_i           ( sys_clk_i          ),
        .per_clk_i           ( periph_clk_i       ),

        .dft_cg_enable_i     ( dft_cg_enable_i    ),

        .HRESETn             ( sys_resetn_i       ),

        .PADDR               ( udma_apb_paddr     ),
        .PWDATA              ( udma_apb_pwdata    ),
        .PWRITE              ( udma_apb_pwrite    ),
        .PSEL                ( udma_apb_psel      ),
        .PENABLE             ( udma_apb_penable   ),
        .PRDATA              ( udma_apb_prdata    ),
        .PREADY              ( udma_apb_pready    ),
        .PSLVERR             ( udma_apb_pslverr   ),

        .periph_per_clk_o    ( s_clk_periphs_per  ),
        .periph_sys_clk_o    ( s_clk_periphs_core ),

        .event_valid_i       ( event_valid_i      ),
        .event_data_i        ( event_data_i       ),
        .event_ready_o       ( event_ready_o      ),

        .event_o             ( s_trigger_events   ),

        .periph_data_to_o    ( s_periph_data_to   ),
        .periph_addr_o       ( s_periph_addr      ),
        .periph_data_from_i  ( s_periph_data_from ),
        .periph_ready_i      ( s_periph_ready     ),
        .periph_valid_o      ( s_periph_valid     ),
        .periph_rwn_o        ( s_periph_rwn       ),

        .tx_l2_req_o         ( L2_ro_req_o        ),
        .tx_l2_gnt_i         ( L2_ro_gnt_i        ),
        .tx_l2_addr_o        ( L2_ro_addr_o       ),
        .tx_l2_rdata_i       ( L2_ro_rdata_i      ),
        .tx_l2_rvalid_i      ( L2_ro_rvalid_i     ),

        .rx_l2_req_o         ( L2_wo_req_o        ),
        .rx_l2_gnt_i         ( L2_wo_gnt_i        ),
        .rx_l2_addr_o        ( L2_wo_addr_o       ),
        .rx_l2_be_o          ( L2_wo_be_o         ),
        .rx_l2_wdata_o       ( L2_wo_wdata_o      ),

        .stream_data_o       ( s_stream_data      ),
        .stream_datasize_o   ( s_stream_datasize  ),
        .stream_valid_o      ( s_stream_valid     ),
        .stream_sot_o        ( s_stream_sot       ),
        .stream_eot_o        ( s_stream_eot       ),
        .stream_ready_i      ( s_stream_ready     ),

        .tx_lin_req_i         ( s_tx_ch_req          ),
        .tx_lin_gnt_o         ( s_tx_ch_gnt          ),
        .tx_lin_valid_o       ( s_tx_ch_valid        ),
        .tx_lin_data_o        ( s_tx_ch_data         ),
        .tx_lin_ready_i       ( s_tx_ch_ready        ),
        .tx_lin_datasize_i    ( s_tx_ch_datasize     ),
        .tx_lin_destination_i ( s_tx_ch_destination  ),
        .tx_lin_events_o      ( s_tx_ch_events       ),
        .tx_lin_en_o          ( s_tx_ch_en           ),
        .tx_lin_pending_o     ( s_tx_ch_pending      ),
        .tx_lin_curr_addr_o   ( s_tx_ch_curr_addr    ),
        .tx_lin_bytes_left_o  ( s_tx_ch_bytes_left   ),
        .tx_lin_cfg_startaddr_i  ( s_tx_cfg_startaddr   ),
        .tx_lin_cfg_size_i       ( s_tx_cfg_size        ),
        .tx_lin_cfg_continuous_i ( s_tx_cfg_continuous  ),
        .tx_lin_cfg_en_i         ( s_tx_cfg_en          ),
        .tx_lin_cfg_clr_i        ( s_tx_cfg_clr         ),

        .rx_lin_valid_i          ( s_rx_ch_valid        ),
        .rx_lin_data_i           ( s_rx_ch_data         ),
        .rx_lin_ready_o          ( s_rx_ch_ready        ),
        .rx_lin_datasize_i       ( s_rx_ch_datasize     ),
        .rx_lin_destination_i    ( s_rx_ch_destination  ),
        .rx_lin_events_o         ( s_rx_ch_events       ),
        .rx_lin_en_o             ( s_rx_ch_en           ),
        .rx_lin_pending_o        ( s_rx_ch_pending      ),
        .rx_lin_curr_addr_o      ( s_rx_ch_curr_addr    ),
        .rx_lin_bytes_left_o     ( s_rx_ch_bytes_left   ),
        .rx_lin_cfg_startaddr_i  ( s_rx_cfg_startaddr   ),
        .rx_lin_cfg_size_i       ( s_rx_cfg_size        ),
        .rx_lin_cfg_continuous_i ( s_rx_cfg_continuous  ),
        .rx_lin_cfg_stream_i     ( s_rx_cfg_stream      ),
        .rx_lin_cfg_stream_id_i  ( s_rx_cfg_stream_id   ),
        .rx_lin_cfg_en_i         ( s_rx_cfg_en          ),
        .rx_lin_cfg_clr_i        ( s_rx_cfg_clr         ),

        .rx_ext_addr_i           ( s_rx_ext_addr        ),
        .rx_ext_datasize_i       ( s_rx_ext_datasize    ),
        .rx_ext_destination_i    ( s_rx_ext_destination ),
        .rx_ext_stream_i         ( s_rx_ext_stream      ),
        .rx_ext_stream_id_i      ( s_rx_ext_stream_id   ),
        .rx_ext_sot_i            ( s_rx_ext_sot         ),
        .rx_ext_eot_i            ( s_rx_ext_eot         ),
        .rx_ext_valid_i          ( s_rx_ext_valid       ),
        .rx_ext_data_i           ( s_rx_ext_data        ),
        .rx_ext_ready_o          ( s_rx_ext_ready       ),

        .tx_ext_req_i            ( s_tx_ext_req         ),
        .tx_ext_datasize_i       ( s_tx_ext_datasize    ),
        .tx_ext_destination_i    ( s_tx_ext_destination ),
        .tx_ext_addr_i           ( s_tx_ext_addr        ),
        .tx_ext_gnt_o            ( s_tx_ext_gnt         ),
        .tx_ext_valid_o          ( s_tx_ext_valid       ),
        .tx_ext_data_o           ( s_tx_ext_data        ),
        .tx_ext_ready_i          ( s_tx_ext_ready       )

    );

    //PER_ID 0
    generate
        for (genvar g_uart=0;g_uart<N_UART;g_uart++)
        begin : i_uart_gen
            assign s_events[4*(PER_ID_UART+g_uart)+0] = s_rx_ch_events[CH_ID_RX_UART+g_uart];
            assign s_events[4*(PER_ID_UART+g_uart)+1] = s_tx_ch_events[CH_ID_TX_UART+g_uart];
            assign s_events[4*(PER_ID_UART+g_uart)+2] = 1'b0;
            assign s_events[4*(PER_ID_UART+g_uart)+3] = 1'b0;

            assign s_rx_cfg_stream[CH_ID_RX_UART+g_uart] = 'h0;
            assign s_rx_cfg_stream_id[CH_ID_RX_UART+g_uart] = 'h0;
            assign s_rx_ch_destination[CH_ID_RX_UART+g_uart] = 'h0;
            assign s_tx_ch_destination[CH_ID_TX_UART+g_uart] = 'h0;

            udma_uart_top #(
                .L2_AWIDTH_NOAL(L2_AWIDTH_NOAL),
                .TRANS_SIZE(TRANS_SIZE)
            ) i_uart(
                .sys_clk_i           ( s_clk_periphs_core[PER_ID_UART+g_uart]    ),
                .periph_clk_i        ( s_clk_periphs_per[PER_ID_UART+g_uart]     ),
                .rstn_i              ( sys_resetn_i                              ),
                                                                                 
                .uart_tx_o           ( uart_to_pad[g_uart].tx_o                  ),
                .uart_rx_i           ( pad_to_uart[g_uart].rx_i                  ),

                .rx_char_event_o     (                                           ),
                .err_event_o         (                                           ),
                                                                                 
                .cfg_data_i          ( s_periph_data_to                          ),
                .cfg_addr_i          ( s_periph_addr                             ),
                .cfg_valid_i         ( s_periph_valid[PER_ID_UART+g_uart]        ),
                .cfg_rwn_i           ( s_periph_rwn                              ),
                .cfg_data_o          ( s_periph_data_from[PER_ID_UART+g_uart]    ),
                .cfg_ready_o         ( s_periph_ready[PER_ID_UART+g_uart]        ),

                .cfg_rx_startaddr_o  ( s_rx_cfg_startaddr[CH_ID_RX_UART+g_uart]  ),
                .cfg_rx_size_o       ( s_rx_cfg_size[CH_ID_RX_UART+g_uart]       ),
                .cfg_rx_continuous_o ( s_rx_cfg_continuous[CH_ID_RX_UART+g_uart] ),
                .cfg_rx_en_o         ( s_rx_cfg_en[CH_ID_RX_UART+g_uart]         ),
                .cfg_rx_clr_o        ( s_rx_cfg_clr[CH_ID_RX_UART+g_uart]        ),
                .cfg_rx_en_i         ( s_rx_ch_en[CH_ID_RX_UART+g_uart]          ),
                .cfg_rx_pending_i    ( s_rx_ch_pending[CH_ID_RX_UART+g_uart]     ),
                .cfg_rx_curr_addr_i  ( s_rx_ch_curr_addr[CH_ID_RX_UART+g_uart]   ),
                .cfg_rx_bytes_left_i ( s_rx_ch_bytes_left[CH_ID_RX_UART+g_uart]  ),
                .cfg_rx_datasize_o   (                                           ),  // FIXME ANTONIO

                .cfg_tx_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_TX_UART+g_uart]  ),
                .cfg_tx_size_o       ( s_tx_cfg_size[CH_ID_TX_UART+g_uart]       ),
                .cfg_tx_continuous_o ( s_tx_cfg_continuous[CH_ID_TX_UART+g_uart] ),
                .cfg_tx_en_o         ( s_tx_cfg_en[CH_ID_TX_UART+g_uart]         ),
                .cfg_tx_clr_o        ( s_tx_cfg_clr[CH_ID_TX_UART+g_uart]        ),
                .cfg_tx_en_i         ( s_tx_ch_en[CH_ID_TX_UART+g_uart]          ),
                .cfg_tx_pending_i    ( s_tx_ch_pending[CH_ID_TX_UART+g_uart]     ),
                .cfg_tx_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_TX_UART+g_uart]   ),
                .cfg_tx_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_TX_UART+g_uart]  ),
                .cfg_tx_datasize_o   (                                           ),  // FIXME ANTONIO

                .data_tx_req_o       ( s_tx_ch_req[CH_ID_TX_UART+g_uart]         ),
                .data_tx_gnt_i       ( s_tx_ch_gnt[CH_ID_TX_UART+g_uart]         ),
                .data_tx_datasize_o  ( s_tx_ch_datasize[CH_ID_TX_UART+g_uart]    ),
                .data_tx_i           ( s_tx_ch_data[CH_ID_TX_UART+g_uart]        ),
                .data_tx_valid_i     ( s_tx_ch_valid[CH_ID_TX_UART+g_uart]       ),
                .data_tx_ready_o     ( s_tx_ch_ready[CH_ID_TX_UART+g_uart]       ),

                .data_rx_datasize_o  ( s_rx_ch_datasize[CH_ID_RX_UART+g_uart]    ),
                .data_rx_o           ( s_rx_ch_data[CH_ID_RX_UART+g_uart]        ),
                .data_rx_valid_o     ( s_rx_ch_valid[CH_ID_RX_UART+g_uart]       ),
                .data_rx_ready_i     ( s_rx_ch_ready[CH_ID_RX_UART+g_uart]       )
            );
        end
    endgenerate

    //PER_ID 1
    generate
        for (genvar g_spi=0;g_spi<N_SPI;g_spi++)
        begin : i_spim_gen
            assign s_events[4*(PER_ID_SPIM+g_spi)+0] = s_rx_ch_events[CH_ID_RX_SPIM+g_spi];
            assign s_events[4*(PER_ID_SPIM+g_spi)+1] = s_tx_ch_events[CH_ID_TX_SPIM+g_spi];
            assign s_events[4*(PER_ID_SPIM+g_spi)+2] = s_tx_ch_events[CH_ID_CMD_SPIM+g_spi];
            assign s_events[4*(PER_ID_SPIM+g_spi)+3] = s_spi_eot[g_spi];

            assign s_rx_cfg_stream[CH_ID_RX_SPIM+g_spi] = 'h0;
            assign s_rx_cfg_stream_id[CH_ID_RX_SPIM+g_spi] = 'h0;
            assign s_rx_ch_destination[CH_ID_RX_SPIM+g_spi] = 'h0;
            assign s_tx_ch_destination[CH_ID_TX_SPIM+g_spi] = 'h0;
            assign s_tx_ch_destination[CH_ID_CMD_SPIM+g_spi] = 'h0;
            udma_spim_top
            #(
                .L2_AWIDTH_NOAL      ( L2_AWIDTH_NOAL                           ),
                .TRANS_SIZE          ( TRANS_SIZE                               )
            ) i_spim (
                .sys_clk_i           ( s_clk_periphs_core[PER_ID_SPIM+g_spi]    ),
                .periph_clk_i        ( s_clk_periphs_per[PER_ID_SPIM+g_spi]     ),
                .rstn_i              ( sys_resetn_i                             ),
                .dft_test_mode_i     ( dft_test_mode_i                          ),
                .dft_cg_enable_i     ( dft_cg_enable_i                          ),
                .spi_eot_o           ( s_spi_eot[g_spi]                         ),
                .spi_event_i         ( s_trigger_events                         ),
                .spi_clk_o           ( qspi_to_pad[g_spi].clk_o                 ),
                .spi_csn0_o          ( qspi_to_pad[g_spi].csn0_o                ),
                .spi_csn1_o          ( qspi_to_pad[g_spi].csn1_o                ),
                .spi_csn2_o          ( qspi_to_pad[g_spi].csn2_o                ),
                .spi_csn3_o          ( qspi_to_pad[g_spi].csn3_o                ),
                .spi_oen0_o          ( qspi_to_pad[g_spi].sd0_oen_o             ),
                .spi_oen1_o          ( qspi_to_pad[g_spi].sd1_oen_o             ),
                .spi_oen2_o          ( qspi_to_pad[g_spi].sd2_oen_o             ),
                .spi_oen3_o          ( qspi_to_pad[g_spi].sd3_oen_o             ),
                .spi_sdo0_o          ( qspi_to_pad[g_spi].sd0_o                ),
                .spi_sdo1_o          ( qspi_to_pad[g_spi].sd1_o                ),
                .spi_sdo2_o          ( qspi_to_pad[g_spi].sd2_o                ),
                .spi_sdo3_o          ( qspi_to_pad[g_spi].sd3_o                ),
                .spi_sdi0_i          ( pad_to_qspi[g_spi].sd0_i                ),
                .spi_sdi1_i          ( pad_to_qspi[g_spi].sd1_i                ),
                .spi_sdi2_i          ( pad_to_qspi[g_spi].sd2_i                ),
                .spi_sdi3_i          ( pad_to_qspi[g_spi].sd3_i                ),

                .cfg_data_i          ( s_periph_data_to                         ),
                .cfg_addr_i          ( s_periph_addr                            ),
                .cfg_valid_i         ( s_periph_valid[PER_ID_SPIM+g_spi]        ),
                .cfg_rwn_i           ( s_periph_rwn                             ),
                .cfg_data_o          ( s_periph_data_from[PER_ID_SPIM+g_spi]    ),
                .cfg_ready_o         ( s_periph_ready[PER_ID_SPIM+g_spi]        ),

                .cmd_req_o           ( s_tx_ch_req[CH_ID_CMD_SPIM+g_spi]          ),
                .cmd_gnt_i           ( s_tx_ch_gnt[CH_ID_CMD_SPIM+g_spi]          ),
                .cmd_datasize_o      ( s_tx_ch_datasize[CH_ID_CMD_SPIM+g_spi]     ),
                .cmd_i               ( s_tx_ch_data[CH_ID_CMD_SPIM+g_spi]         ),
                .cmd_valid_i         ( s_tx_ch_valid[CH_ID_CMD_SPIM+g_spi]        ),
                .cmd_ready_o         ( s_tx_ch_ready[CH_ID_CMD_SPIM+g_spi]        ),

                .data_tx_req_o       ( s_tx_ch_req[CH_ID_TX_SPIM+g_spi]           ),
                .data_tx_gnt_i       ( s_tx_ch_gnt[CH_ID_TX_SPIM+g_spi]           ),
                .data_tx_datasize_o  ( s_tx_ch_datasize[CH_ID_TX_SPIM+g_spi]      ),
                .data_tx_i           ( s_tx_ch_data[CH_ID_TX_SPIM+g_spi]          ),
                .data_tx_valid_i     ( s_tx_ch_valid[CH_ID_TX_SPIM+g_spi]         ),
                .data_tx_ready_o     ( s_tx_ch_ready[CH_ID_TX_SPIM+g_spi]         ),

                .data_rx_datasize_o  ( s_rx_ch_datasize[CH_ID_RX_SPIM+g_spi]      ),
                .data_rx_o           ( s_rx_ch_data[CH_ID_RX_SPIM+g_spi]          ),
                .data_rx_valid_o     ( s_rx_ch_valid[CH_ID_RX_SPIM+g_spi]         ),
                .data_rx_ready_i     ( s_rx_ch_ready[CH_ID_RX_SPIM+g_spi]         ),

                .cfg_cmd_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_CMD_SPIM+g_spi]  ),
                .cfg_cmd_size_o       ( s_tx_cfg_size[CH_ID_CMD_SPIM+g_spi]       ),
                .cfg_cmd_continuous_o ( s_tx_cfg_continuous[CH_ID_CMD_SPIM+g_spi] ),
                .cfg_cmd_en_o         ( s_tx_cfg_en[CH_ID_CMD_SPIM+g_spi]         ),
                .cfg_cmd_clr_o        ( s_tx_cfg_clr[CH_ID_CMD_SPIM+g_spi]        ),
                .cfg_cmd_en_i         ( s_tx_ch_en[CH_ID_CMD_SPIM+g_spi]          ),
                .cfg_cmd_pending_i    ( s_tx_ch_pending[CH_ID_CMD_SPIM+g_spi]     ),
                .cfg_cmd_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_CMD_SPIM+g_spi]   ),
                .cfg_cmd_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_CMD_SPIM+g_spi]  ),

                .cfg_tx_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_TX_SPIM+g_spi]    ),
                .cfg_tx_size_o       ( s_tx_cfg_size[CH_ID_TX_SPIM+g_spi]         ),
                .cfg_tx_continuous_o ( s_tx_cfg_continuous[CH_ID_TX_SPIM+g_spi]   ),
                .cfg_tx_en_o         ( s_tx_cfg_en[CH_ID_TX_SPIM+g_spi]           ),
                .cfg_tx_clr_o        ( s_tx_cfg_clr[CH_ID_TX_SPIM+g_spi]          ),
                .cfg_tx_en_i         ( s_tx_ch_en[CH_ID_TX_SPIM+g_spi]            ),
                .cfg_tx_pending_i    ( s_tx_ch_pending[CH_ID_TX_SPIM+g_spi]       ),
                .cfg_tx_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_TX_SPIM+g_spi]     ),
                .cfg_tx_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_TX_SPIM+g_spi]    ),

                .cfg_rx_startaddr_o  ( s_rx_cfg_startaddr[CH_ID_RX_SPIM+g_spi]    ),
                .cfg_rx_size_o       ( s_rx_cfg_size[CH_ID_RX_SPIM+g_spi]         ),
                .cfg_rx_continuous_o ( s_rx_cfg_continuous[CH_ID_RX_SPIM+g_spi]   ),
                .cfg_rx_en_o         ( s_rx_cfg_en[CH_ID_RX_SPIM+g_spi]           ),
                .cfg_rx_clr_o        ( s_rx_cfg_clr[CH_ID_RX_SPIM+g_spi]          ),
                .cfg_rx_en_i         ( s_rx_ch_en[CH_ID_RX_SPIM+g_spi]            ),
                .cfg_rx_pending_i    ( s_rx_ch_pending[CH_ID_RX_SPIM+g_spi]       ),
                .cfg_rx_curr_addr_i  ( s_rx_ch_curr_addr[CH_ID_RX_SPIM+g_spi]     ),
                .cfg_rx_bytes_left_i ( s_rx_ch_bytes_left[CH_ID_RX_SPIM+g_spi]    )
            );
        end
    endgenerate

    //PER_ID 2, 3
    generate
        for (genvar g_i2c=0;g_i2c<N_I2C;g_i2c++)
        begin: i_i2c_gen
            assign s_events[4*(PER_ID_I2C+g_i2c)+0] = s_rx_ch_events[CH_ID_RX_I2C+g_i2c];
            assign s_events[4*(PER_ID_I2C+g_i2c)+1] = s_tx_ch_events[CH_ID_TX_I2C+g_i2c];
            assign s_events[4*(PER_ID_I2C+g_i2c)+2] = s_tx_ch_events[CH_ID_CMD_I2C+g_i2c];
            assign s_events[4*(PER_ID_I2C+g_i2c)+3] = s_i2c_eot[g_i2c];

            assign s_rx_cfg_stream[CH_ID_RX_I2C+g_i2c] = 'h0;
            assign s_rx_cfg_stream_id[CH_ID_RX_I2C+g_i2c] = 'h0;
            assign s_rx_ch_destination[CH_ID_RX_I2C+g_i2c] = 'h0;
            assign s_tx_ch_destination[CH_ID_TX_I2C+g_i2c] = 'h0;
            assign s_tx_ch_destination[CH_ID_CMD_I2C+g_i2c] = 'h0;

            udma_i2c_top #(
                .L2_AWIDTH_NOAL(L2_AWIDTH_NOAL),
                .TRANS_SIZE(TRANS_SIZE)
            ) i_i2c (
                .sys_clk_i           ( s_clk_periphs_core[PER_ID_I2C+g_i2c]      ),
                .periph_clk_i        ( s_clk_periphs_per[PER_ID_I2C+g_i2c]       ),
                .rstn_i              ( sys_resetn_i                              ),
                .i2c_eot_o           ( s_i2c_eot[g_i2c]                          ),

                .cfg_data_i          ( s_periph_data_to                          ),
                .cfg_addr_i          ( s_periph_addr                             ),
                .cfg_valid_i         ( s_periph_valid[PER_ID_I2C+g_i2c]          ),
                .cfg_rwn_i           ( s_periph_rwn                              ),
                .cfg_data_o          ( s_periph_data_from[PER_ID_I2C+g_i2c]      ),
                .cfg_ready_o         (  s_periph_ready[PER_ID_I2C+g_i2c]         ),

                .cmd_req_o           ( s_tx_ch_req[CH_ID_CMD_I2C+g_i2c]          ),
                .cmd_gnt_i           ( s_tx_ch_gnt[CH_ID_CMD_I2C+g_i2c]          ),
                .cmd_datasize_o      ( s_tx_ch_datasize[CH_ID_CMD_I2C+g_i2c]     ),
                .cmd_i               ( s_tx_ch_data[CH_ID_CMD_I2C+g_i2c]         ),
                .cmd_valid_i         ( s_tx_ch_valid[CH_ID_CMD_I2C+g_i2c]        ),
                .cmd_ready_o         ( s_tx_ch_ready[CH_ID_CMD_I2C+g_i2c]        ),

                .cfg_cmd_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_CMD_I2C+g_i2c]  ),
                .cfg_cmd_size_o       ( s_tx_cfg_size[CH_ID_CMD_I2C+g_i2c]       ),
                .cfg_cmd_continuous_o ( s_tx_cfg_continuous[CH_ID_CMD_I2C+g_i2c] ),
                .cfg_cmd_en_o         ( s_tx_cfg_en[CH_ID_CMD_I2C+g_i2c]         ),
                .cfg_cmd_clr_o        ( s_tx_cfg_clr[CH_ID_CMD_I2C+g_i2c]        ),
                .cfg_cmd_en_i         ( s_tx_ch_en[CH_ID_CMD_I2C+g_i2c]          ),
                .cfg_cmd_pending_i    ( s_tx_ch_pending[CH_ID_CMD_I2C+g_i2c]     ),
                .cfg_cmd_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_CMD_I2C+g_i2c]   ),
                .cfg_cmd_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_CMD_I2C+g_i2c]  ),

                .cfg_tx_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_TX_I2C+g_i2c]    ),
                .cfg_tx_size_o       ( s_tx_cfg_size[CH_ID_TX_I2C+g_i2c]         ),
                .cfg_tx_continuous_o ( s_tx_cfg_continuous[CH_ID_TX_I2C+g_i2c]   ),
                .cfg_tx_en_o         ( s_tx_cfg_en[CH_ID_TX_I2C+g_i2c]           ),
                .cfg_tx_clr_o        ( s_tx_cfg_clr[CH_ID_TX_I2C+g_i2c]          ),
                .cfg_tx_en_i         ( s_tx_ch_en[CH_ID_TX_I2C+g_i2c]            ),
                .cfg_tx_pending_i    ( s_tx_ch_pending[CH_ID_TX_I2C+g_i2c]       ),
                .cfg_tx_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_TX_I2C+g_i2c]     ),
                .cfg_tx_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_TX_I2C+g_i2c]    ),

                .cfg_rx_startaddr_o  ( s_rx_cfg_startaddr[CH_ID_RX_I2C+g_i2c]    ),
                .cfg_rx_size_o       ( s_rx_cfg_size[CH_ID_RX_I2C+g_i2c]         ),
                .cfg_rx_continuous_o ( s_rx_cfg_continuous[CH_ID_RX_I2C+g_i2c]   ),
                .cfg_rx_en_o         ( s_rx_cfg_en[CH_ID_RX_I2C+g_i2c]           ),
                .cfg_rx_clr_o        ( s_rx_cfg_clr[CH_ID_RX_I2C+g_i2c]          ),
                .cfg_rx_en_i         ( s_rx_ch_en[CH_ID_RX_I2C+g_i2c]            ),
                .cfg_rx_pending_i    ( s_rx_ch_pending[CH_ID_RX_I2C+g_i2c]       ),
                .cfg_rx_curr_addr_i  ( s_rx_ch_curr_addr[CH_ID_RX_I2C+g_i2c]     ),
                .cfg_rx_bytes_left_i ( s_rx_ch_bytes_left[CH_ID_RX_I2C+g_i2c]    ),

                .data_tx_req_o       ( s_tx_ch_req[CH_ID_TX_I2C+g_i2c]           ),
                .data_tx_gnt_i       ( s_tx_ch_gnt[CH_ID_TX_I2C+g_i2c]           ),
                .data_tx_datasize_o  ( s_tx_ch_datasize[CH_ID_TX_I2C+g_i2c]      ),
                .data_tx_i           ( s_tx_ch_data[CH_ID_TX_I2C+g_i2c][7:0]     ),
                .data_tx_valid_i     ( s_tx_ch_valid[CH_ID_TX_I2C+g_i2c]         ),
                .data_tx_ready_o     ( s_tx_ch_ready[CH_ID_TX_I2C+g_i2c]         ),

                .data_rx_datasize_o  ( s_rx_ch_datasize[CH_ID_RX_I2C+g_i2c]      ),
                .data_rx_o           ( s_rx_ch_data[CH_ID_RX_I2C+g_i2c][7:0]     ),
                .data_rx_valid_o     ( s_rx_ch_valid[CH_ID_RX_I2C+g_i2c]         ),
                .data_rx_ready_i     ( s_rx_ch_ready[CH_ID_RX_I2C+g_i2c]         ),

                .err_o               ( s_i2c_evt[g_i2c]                          ),

                .scl_i               ( pad_to_i2c[g_i2c].scl_i                   ),
                .scl_o               ( i2c_to_pad[g_i2c].scl_o                   ),
                .scl_oe              ( i2c_to_pad[g_i2c].scl_oe_o                ),
                .sda_i               ( pad_to_i2c[g_i2c].sda_i                   ),
                .sda_o               ( i2c_to_pad[g_i2c].sda_o                   ),
                .sda_oe              ( i2c_to_pad[g_i2c].sda_oe_o                ),
                .ext_events_i        ( s_trigger_events                          )
            );
            assign s_rx_ch_data[CH_ID_RX_I2C+g_i2c][31:8]= 'h0;
        end
    endgenerate

    //PER_ID 4 , 5
    logic [N_SDIO-1:0] s_sdio_eot;
    logic [N_SDIO-1:0] s_sdio_err;

    logic [N_SDIO-1:0][3:0]sdio_data_o;
    logic [N_SDIO-1:0][3:0]sdio_data_oen_o;
    logic [N_SDIO-1:0][3:0]sdio_data_i;
    generate
       for (genvar g_sdio=0;g_sdio<N_SDIO;g_sdio++)
         begin: i_sdio_gen
            assign s_events[4*(PER_ID_SDIO+g_sdio)]    = s_rx_ch_events[CH_ID_RX_SDIO+g_sdio];
            assign s_events[4*(PER_ID_SDIO+g_sdio)+1]  = s_tx_ch_events[CH_ID_TX_SDIO+g_sdio];
            assign s_events[4*(PER_ID_SDIO+g_sdio)+2]  = s_sdio_eot[g_sdio];
            assign s_events[4*(PER_ID_SDIO+g_sdio)+3]  = s_sdio_err[g_sdio];
            assign s_rx_cfg_stream[CH_ID_RX_SDIO+g_sdio] = 'h0;
            assign s_rx_cfg_stream_id[CH_ID_RX_SDIO+g_sdio] = 'h0;
            assign s_rx_ch_destination[CH_ID_RX_SDIO+g_sdio] = 'h0;
            assign s_tx_ch_destination[CH_ID_TX_SDIO+g_sdio] = 'h0;
            udma_sdio_top #(
                .L2_AWIDTH_NOAL ( L2_AWIDTH_NOAL ),
                .TRANS_SIZE     ( TRANS_SIZE     )
            ) i_sdio (
                .sys_clk_i           ( s_clk_periphs_core[PER_ID_SDIO+g_sdio] ),
                .periph_clk_i        ( s_clk_periphs_per[PER_ID_SDIO+g_sdio]  ),
                .rstn_i              ( sys_resetn_i                           ),
            
                .err_o               ( s_sdio_err[g_sdio] ),
                .eot_o               ( s_sdio_eot[g_sdio] ),
            
                .sdclk_o             ( sdio_to_pad[g_sdio].clk_o      ),
                .sdcmd_o             ( sdio_to_pad[g_sdio].cmd_o      ),
                .sdcmd_i             ( pad_to_sdio[g_sdio].cmd_i      ),
                .sdcmd_oen_o         ( sdio_to_pad[g_sdio].cmd_oen_o  ),
                .sddata_o            ( sdio_data_o[g_sdio]            ),
                .sddata_i            ( sdio_data_i[g_sdio]            ),
                .sddata_oen_o        ( sdio_data_oen_o[g_sdio]        ),
            
                .cfg_data_i          ( s_periph_data_to                              ),
                .cfg_addr_i          ( s_periph_addr                                 ),
                .cfg_valid_i         ( s_periph_valid[PER_ID_SDIO+g_sdio]            ),
                .cfg_rwn_i           ( s_periph_rwn                                  ),
                .cfg_data_o          ( s_periph_data_from[PER_ID_SDIO+g_sdio]        ),
                .cfg_ready_o         ( s_periph_ready[PER_ID_SDIO+g_sdio]            ),
            
                .cfg_rx_startaddr_o  ( s_rx_cfg_startaddr[CH_ID_RX_SDIO+g_sdio]      ),
                .cfg_rx_size_o       ( s_rx_cfg_size[CH_ID_RX_SDIO+g_sdio]           ),
                .cfg_rx_continuous_o ( s_rx_cfg_continuous[CH_ID_RX_SDIO+g_sdio]     ),
                .cfg_rx_en_o         ( s_rx_cfg_en[CH_ID_RX_SDIO+g_sdio]             ),
                .cfg_rx_clr_o        ( s_rx_cfg_clr[CH_ID_RX_SDIO+g_sdio]            ),
                .cfg_rx_en_i         ( s_rx_ch_en[CH_ID_RX_SDIO+g_sdio]              ),
                .cfg_rx_pending_i    ( s_rx_ch_pending[CH_ID_RX_SDIO+g_sdio]         ),
                .cfg_rx_curr_addr_i  ( s_rx_ch_curr_addr[CH_ID_RX_SDIO+g_sdio]       ),
                .cfg_rx_bytes_left_i ( s_rx_ch_bytes_left[CH_ID_RX_SDIO+g_sdio]      ),
            
                .cfg_tx_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_TX_SDIO+g_sdio]      ),
                .cfg_tx_size_o       ( s_tx_cfg_size[CH_ID_TX_SDIO+g_sdio]           ),
                .cfg_tx_continuous_o ( s_tx_cfg_continuous[CH_ID_TX_SDIO+g_sdio]     ),
                .cfg_tx_en_o         ( s_tx_cfg_en[CH_ID_TX_SDIO+g_sdio]             ),
                .cfg_tx_clr_o        ( s_tx_cfg_clr[CH_ID_TX_SDIO+g_sdio]            ),
                .cfg_tx_en_i         ( s_tx_ch_en[CH_ID_TX_SDIO+g_sdio]              ),
                .cfg_tx_pending_i    ( s_tx_ch_pending[CH_ID_TX_SDIO+g_sdio]         ),
                .cfg_tx_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_TX_SDIO+g_sdio]       ),
                .cfg_tx_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_TX_SDIO+g_sdio]      ),
            
                .data_tx_req_o       ( s_tx_ch_req[CH_ID_TX_SDIO+g_sdio]             ),
                .data_tx_gnt_i       ( s_tx_ch_gnt[CH_ID_TX_SDIO+g_sdio]             ),
                .data_tx_datasize_o  ( s_tx_ch_datasize[CH_ID_TX_SDIO+g_sdio]        ),
                .data_tx_i           ( s_tx_ch_data[CH_ID_TX_SDIO+g_sdio]            ),
                .data_tx_valid_i     ( s_tx_ch_valid[CH_ID_TX_SDIO+g_sdio]           ),
                .data_tx_ready_o     ( s_tx_ch_ready[CH_ID_TX_SDIO+g_sdio]           ),
            
                .data_rx_datasize_o  ( s_rx_ch_datasize[CH_ID_RX_SDIO+g_sdio]        ),
                .data_rx_o           ( s_rx_ch_data[CH_ID_RX_SDIO+g_sdio]            ),
                .data_rx_valid_o     ( s_rx_ch_valid[CH_ID_RX_SDIO+g_sdio]           ),
                .data_rx_ready_i     ( s_rx_ch_ready[CH_ID_RX_SDIO+g_sdio]           )
            );

            assign sdio_to_pad[g_sdio].data0_o = sdio_data_o[g_sdio][0];
            assign sdio_to_pad[g_sdio].data1_o = sdio_data_o[g_sdio][1];
            assign sdio_to_pad[g_sdio].data2_o = sdio_data_o[g_sdio][2];
            assign sdio_to_pad[g_sdio].data3_o = sdio_data_o[g_sdio][3];
            assign sdio_to_pad[g_sdio].data0_oen_o = sdio_data_oen_o[g_sdio][0];
            assign sdio_to_pad[g_sdio].data1_oen_o = sdio_data_oen_o[g_sdio][1];
            assign sdio_to_pad[g_sdio].data2_oen_o = sdio_data_oen_o[g_sdio][2];
            assign sdio_to_pad[g_sdio].data3_oen_o = sdio_data_oen_o[g_sdio][3];
            assign sdio_data_i[g_sdio][0] = pad_to_sdio[g_sdio].data0_i;
            assign sdio_data_i[g_sdio][1] = pad_to_sdio[g_sdio].data1_i;
            assign sdio_data_i[g_sdio][2] = pad_to_sdio[g_sdio].data2_i;
            assign sdio_data_i[g_sdio][3] = pad_to_sdio[g_sdio].data3_i;            
         end // block: assign
     endgenerate


    //PER_ID 6
    generate
       for (genvar g_cam=0;g_cam<N_CAM;g_cam++)
        begin: i_cam_gen
        logic  [7:0] cam_data_i;    
        assign s_events[4*(PER_ID_CAM+g_cam)]    = s_rx_ch_events[CH_ID_RX_CAM+g_cam];
        assign s_events[4*(PER_ID_CAM+g_cam)+1]  = 1'b0;
        assign s_events[4*(PER_ID_CAM+g_cam)+2]  = 1'b0;
        assign s_events[4*(PER_ID_CAM+g_cam)+3]  = 1'b0;
        assign s_rx_cfg_stream[CH_ID_RX_CAM+g_cam] = 'h0;
        assign s_rx_cfg_stream_id[CH_ID_RX_CAM+g_cam] = 'h0;
        assign s_rx_ch_destination[CH_ID_RX_CAM+g_cam] = 'h0;
        camera_if #(
            .L2_AWIDTH_NOAL(L2_AWIDTH_NOAL),
            .TRANS_SIZE(TRANS_SIZE),
            .DATA_WIDTH(8)
        ) i_camera_if (
            .clk_i(s_clk_periphs_core[PER_ID_CAM+g_cam]),
            .rstn_i(sys_resetn_i),
        
            .dft_test_mode_i(dft_test_mode_i),
            .dft_cg_enable_i(dft_cg_enable_i),
        
            .cfg_data_i          ( s_periph_data_to                        ),
            .cfg_addr_i          ( s_periph_addr                           ),
            .cfg_valid_i         ( s_periph_valid[PER_ID_CAM+g_cam]        ),
            .cfg_rwn_i           ( s_periph_rwn                            ),
            .cfg_data_o          ( s_periph_data_from[PER_ID_CAM+g_cam]    ),
            .cfg_ready_o         ( s_periph_ready[PER_ID_CAM+g_cam]        ),
        
            .cfg_rx_startaddr_o  ( s_rx_cfg_startaddr[CH_ID_RX_CAM+g_cam]  ),
            .cfg_rx_size_o       ( s_rx_cfg_size[CH_ID_RX_CAM+g_cam]       ),
            .cfg_rx_continuous_o ( s_rx_cfg_continuous[CH_ID_RX_CAM+g_cam] ),
            .cfg_rx_en_o         ( s_rx_cfg_en[CH_ID_RX_CAM+g_cam]         ),
            .cfg_rx_clr_o        ( s_rx_cfg_clr[CH_ID_RX_CAM+g_cam]        ),
            .cfg_rx_en_i         ( s_rx_ch_en[CH_ID_RX_CAM+g_cam]          ),
            .cfg_rx_pending_i    ( s_rx_ch_pending[CH_ID_RX_CAM+g_cam]     ),
            .cfg_rx_curr_addr_i  ( s_rx_ch_curr_addr[CH_ID_RX_CAM+g_cam]   ),
            .cfg_rx_bytes_left_i ( s_rx_ch_bytes_left[CH_ID_RX_CAM+g_cam]  ),
        
            .data_rx_datasize_o  ( s_rx_ch_datasize[CH_ID_RX_CAM+g_cam]    ),
            .data_rx_data_o      ( s_rx_ch_data[CH_ID_RX_CAM+g_cam][15:0]  ),
            .data_rx_valid_o     ( s_rx_ch_valid[CH_ID_RX_CAM+g_cam]       ),
            .data_rx_ready_i     ( s_rx_ch_ready[CH_ID_RX_CAM+g_cam]       ),
        
            .cam_clk_i           ( pad_to_cam[g_cam].clk_i                 ),
            .cam_data_i          ( cam_data_i                              ),
            .cam_hsync_i         ( pad_to_cam[g_cam].hsync_i               ),
            .cam_vsync_i         ( pad_to_cam[g_cam].vsync_i               )
        );
        assign s_rx_ch_data[CH_ID_RX_CAM+g_cam][31:16]='h0;
        assign cam_data_i[0] = pad_to_cam[g_cam].data0_i;
        assign cam_data_i[1] = pad_to_cam[g_cam].data1_i;
        assign cam_data_i[2] = pad_to_cam[g_cam].data2_i;
        assign cam_data_i[3] = pad_to_cam[g_cam].data3_i;
        assign cam_data_i[4] = pad_to_cam[g_cam].data4_i;
        assign cam_data_i[5] = pad_to_cam[g_cam].data5_i;
        assign cam_data_i[6] = pad_to_cam[g_cam].data6_i;           
        assign cam_data_i[7] = pad_to_cam[g_cam].data7_i;           
     end // block: assign
   endgenerate
   
   //PER_ID 7
    assign s_events[4*PER_ID_FILTER]    = s_filter_eot_evt;
    assign s_events[4*PER_ID_FILTER+1]  = s_filter_act_evt;
    assign s_events[4*PER_ID_FILTER+2]  = 1'b0;
    assign s_events[4*PER_ID_FILTER+3]  = 1'b0;

    assign s_rx_ext_destination[CH_ID_EXT_RX_FILTER] = 'h0;
    assign s_rx_ext_stream[CH_ID_EXT_RX_FILTER]      = 'h0;
    assign s_rx_ext_stream_id[CH_ID_EXT_RX_FILTER]   = 'h0;
    assign s_rx_ext_sot[CH_ID_EXT_RX_FILTER]         = 'h0;
    assign s_rx_ext_eot[CH_ID_EXT_RX_FILTER]         = 'h0;

    assign s_tx_ext_destination[CH_ID_EXT_TX_FILTER]   = 'h0;
    assign s_tx_ext_destination[CH_ID_EXT_TX_FILTER+1] = 'h0;

    udma_filter #(
        .L2_AWIDTH_NOAL(L2_AWIDTH_NOAL),
        .TRANS_SIZE(TRANS_SIZE)
    ) i_filter (
        .clk_i(s_clk_periphs_core[PER_ID_FILTER]),
        .resetn_i(sys_resetn_i),

        .cfg_data_i              ( s_periph_data_to                  ),
        .cfg_addr_i              ( s_periph_addr                     ),
        .cfg_valid_i             ( s_periph_valid[PER_ID_FILTER]     ),
        .cfg_rwn_i               ( s_periph_rwn                      ),
        .cfg_data_o              ( s_periph_data_from[PER_ID_FILTER] ),
        .cfg_ready_o             ( s_periph_ready[PER_ID_FILTER]     ),

        .eot_event_o              ( s_filter_eot_evt ),
        .act_event_o              ( s_filter_act_evt ),

        .filter_tx_ch0_req_o      ( s_tx_ext_req[CH_ID_EXT_TX_FILTER]      ),
        .filter_tx_ch0_addr_o     ( s_tx_ext_addr[CH_ID_EXT_TX_FILTER]     ),
        .filter_tx_ch0_datasize_o ( s_tx_ext_datasize[CH_ID_EXT_TX_FILTER] ),
        .filter_tx_ch0_gnt_i      ( s_tx_ext_gnt[CH_ID_EXT_TX_FILTER]      ),

        .filter_tx_ch0_valid_i    ( s_tx_ext_valid[CH_ID_EXT_TX_FILTER]    ),
        .filter_tx_ch0_data_i     ( s_tx_ext_data[CH_ID_EXT_TX_FILTER]     ),
        .filter_tx_ch0_ready_o    ( s_tx_ext_ready[CH_ID_EXT_TX_FILTER]    ),

        .filter_tx_ch1_req_o      ( s_tx_ext_req[CH_ID_EXT_TX_FILTER+1]      ),
        .filter_tx_ch1_addr_o     ( s_tx_ext_addr[CH_ID_EXT_TX_FILTER+1]     ),
        .filter_tx_ch1_datasize_o ( s_tx_ext_datasize[CH_ID_EXT_TX_FILTER+1] ),
        .filter_tx_ch1_gnt_i      ( s_tx_ext_gnt[CH_ID_EXT_TX_FILTER+1]      ),

        .filter_tx_ch1_valid_i    ( s_tx_ext_valid[CH_ID_EXT_TX_FILTER+1]    ),
        .filter_tx_ch1_data_i     ( s_tx_ext_data[CH_ID_EXT_TX_FILTER+1]     ),
        .filter_tx_ch1_ready_o    ( s_tx_ext_ready[CH_ID_EXT_TX_FILTER+1]    ),

        .filter_rx_ch_addr_o      ( s_rx_ext_addr[CH_ID_EXT_RX_FILTER]     ),
        .filter_rx_ch_datasize_o  ( s_rx_ext_datasize[CH_ID_EXT_RX_FILTER] ),
        .filter_rx_ch_valid_o     ( s_rx_ext_valid[CH_ID_EXT_RX_FILTER]    ),
        .filter_rx_ch_data_o      ( s_rx_ext_data[CH_ID_EXT_RX_FILTER]     ),
        .filter_rx_ch_ready_i     ( s_rx_ext_ready[CH_ID_EXT_RX_FILTER]    ),

        .filter_id_i              (  ),
        .filter_data_i            ( s_stream_data[STREAM_ID_FILTER]     ),
        .filter_datasize_i        ( s_stream_datasize[STREAM_ID_FILTER] ),
        .filter_valid_i           ( s_stream_valid[STREAM_ID_FILTER]    ),
        .filter_sof_i             ( s_stream_sot[STREAM_ID_FILTER]      ),
        .filter_eof_i             ( s_stream_eot[STREAM_ID_FILTER]      ),
        .filter_ready_o           ( s_stream_ready[STREAM_ID_FILTER]    )
    );


    localparam RegAw  = 32;
    localparam RegDw  = 32; 
    typedef logic [RegAw-1:0]   reg_addr_t;
    typedef logic [RegDw-1:0]   reg_data_t;
    typedef logic [RegDw/8-1:0] reg_strb_t;   
    `REG_BUS_TYPEDEF_REQ(reg_req_t, reg_addr_t, reg_data_t, reg_strb_t)
    `REG_BUS_TYPEDEF_RSP(reg_rsp_t, reg_data_t)   

    `ifndef XILINX_DDR
    generate
       for (genvar g_hyper=0;g_hyper<N_HYPER;g_hyper++) begin: i_hyper_gen

         logic [ariane_soc::HyperbusNumPhys-1:0][ariane_soc::NumChipsPerHyperbus-1:0] hyper_cs_no;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_ck_o;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_ck_no;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_rwds_o;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_rwds_i;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_rwds_oe_o;
         logic [ariane_soc::HyperbusNumPhys-1:0][7:0]                                 hyper_dq_i;
         logic [ariane_soc::HyperbusNumPhys-1:0][7:0]                                 hyper_dq_o;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_dq_oe_o;
         logic [ariane_soc::HyperbusNumPhys-1:0]                                      hyper_reset_no;

         logic [N_CH_HYPER-1:0] s_evt_eot_hyper;
         logic is_hyper_read_q;
         logic is_hyper_read_d;
         
         assign s_events[4*(PER_ID_HYPER+g_hyper)]            = s_rx_ch_events[CH_ID_RX_HYPER+g_hyper];
         assign s_events[4*(PER_ID_HYPER+g_hyper)+1]          = s_tx_ch_events[CH_ID_TX_HYPER+g_hyper];
         assign s_events[4*(PER_ID_HYPER+g_hyper)+2]          = |s_evt_eot_hyper & is_hyper_read_d ;
         assign s_events[4*(PER_ID_HYPER+g_hyper)+3]          = |s_evt_eot_hyper & !is_hyper_read_d;

         always_ff @(posedge sys_clk_i, negedge sys_resetn_i) begin
            if(!sys_resetn_i) 
                  is_hyper_read_q <= 1'b0;
            else
                  is_hyper_read_q <= is_hyper_read_d;
         end 
         always_comb begin
                if(is_hyper_read_q) begin
                     if ( s_tx_ch_events[CH_ID_TX_HYPER] & !s_rx_ch_events[CH_ID_RX_HYPER]) begin
                           is_hyper_read_d = 1'b0;
                     end
                     else  is_hyper_read_d = 1'b1;
                end 
                else if(!is_hyper_read_q) begin
                     if ( s_rx_ch_events[CH_ID_RX_HYPER] & !s_tx_ch_events[CH_ID_TX_HYPER]) begin
                           is_hyper_read_d = 1'b1;
                     end
                     else  is_hyper_read_d = 1'b0;
                end
         end


         assign s_rx_cfg_stream[CH_ID_RX_HYPER+g_hyper]     = 'h0;
         assign s_rx_cfg_stream_id[CH_ID_RX_HYPER+g_hyper]  = 'h0;
         assign s_rx_ch_destination[CH_ID_RX_HYPER+g_hyper] = 'h0;
         assign s_tx_ch_destination[CH_ID_TX_HYPER+g_hyper] = 'h0;
         
        `ifdef EXCLUDE_LLC
         ariane_axi_soc::req_slv_t    axi_hyper_req;
         ariane_axi_soc::resp_slv_t   axi_hyper_rsp;
        `else
         ariane_axi_soc::req_slv_mem_t    axi_hyper_req;
         ariane_axi_soc::resp_slv_mem_t   axi_hyper_rsp;
        `endif
         `AXI_ASSIGN_TO_REQ(axi_hyper_req,hyper_axi_bus_slave)
         `AXI_ASSIGN_FROM_RESP(hyper_axi_bus_slave,axi_hyper_rsp)
         reg_req_t   reg_req;
         reg_rsp_t   reg_rsp;
         `REG_BUS_ASSIGN_TO_REQ(reg_req,hyper_reg_cfg_slave)
         `REG_BUS_ASSIGN_FROM_RSP(hyper_reg_cfg_slave,reg_rsp)
    
         hyperbus #(
              .L2_AWIDTH_NOAL ( L2_AWIDTH_NOAL                                           ),
              .TRANS_SIZE     ( TRANS_SIZE                                               ),
              .NB_CH          ( N_CH_HYPER                                               ),
              .NumPhys        ( ariane_soc::HyperbusNumPhys                              ),
              .NumChips       ( ariane_soc::NumChipsPerHyperbus                          ),
              .AxiAddrWidth   ( 64                                                       ),
              .AxiDataWidth   ( 64                                                       ),
              `ifdef EXCLUDE_LLC
              .AxiIdWidth     ( ariane_soc::IdWidthSlave                                 ),
              .axi_req_t      ( ariane_axi_soc::req_slv_t                                ),
              .axi_rsp_t      ( ariane_axi_soc::resp_slv_t                               ),
              .axi_w_chan_t   ( ariane_axi_soc::w_chan_t                                 ),
              .axi_aw_chan_t  ( ariane_axi_soc::aw_chan_slv_t                            ),
              .axi_b_chan_t   ( ariane_axi_soc::b_chan_slv_t                             ),
              .axi_ar_chan_t  ( ariane_axi_soc::ar_chan_slv_t                            ),
              .axi_r_chan_t   ( ariane_axi_soc::r_chan_slv_t                             ),
              `else
              .AxiIdWidth     ( ariane_soc::IdWidthSlave+1                               ),
              .axi_req_t      ( ariane_axi_soc::req_slv_mem_t                            ),
              .axi_rsp_t      ( ariane_axi_soc::resp_slv_mem_t                           ),
              .axi_w_chan_t   ( ariane_axi_soc::w_chan_t                                 ),
              .axi_aw_chan_t  ( ariane_axi_soc::aw_chan_slv_mem_t                        ),
              .axi_b_chan_t   ( ariane_axi_soc::b_chan_slv_mem_t                         ),
              .axi_ar_chan_t  ( ariane_axi_soc::ar_chan_slv_mem_t                        ),
              .axi_r_chan_t   ( ariane_axi_soc::r_chan_slv_mem_t                         ),
              `endif
              .AxiUserWidth   ( ariane_axi_soc::UserWidth                                ),
              .IsClockODelayed( 0                                                        ),
              .RegAddrWidth   ( RegAw                                                    ),
              .RegDataWidth   ( RegDw                                                    ),
              .reg_req_t      ( reg_req_t                                                ),
              .reg_rsp_t      ( reg_rsp_t                                                ),
              .axi_rule_t     ( ariane_soc::addr_map_rule_t                              ),
              .RxFifoLogDepth ( 4                                                        ),
              .TxFifoLogDepth ( 4                                                        ),
              .RstChipBase    ( ariane_soc::HYAXIBase + ariane_soc::HYAXILength*g_hyper  ),  // Base address for all chips
              .RstChipSpace   ( 'h800000                                                 )   
         ) i_hyper (
             .clk_sys_i           ( sys_clk_i                                            ),
             .clk_phy_i           ( periph_clk_i                                         ),
             .rst_sys_ni          ( sys_resetn_i                                         ),
             .rst_phy_ni          ( sys_resetn_i                                         ),
             .test_mode_i         ( '0                                                   ),
             .axi_req_i           ( axi_hyper_req                                        ),
             .axi_rsp_o           ( axi_hyper_rsp                                        ),
             .reg_req_i           ( reg_req                                              ),
             .reg_rsp_o           ( reg_rsp                                              ),
             .cfg_data_i          ( s_periph_data_to                                     ),
             .cfg_addr_i          ( s_periph_addr                                        ),
             .cfg_rwn_i           ( s_periph_rwn                                         ),
             .cfg_valid_i         ( s_periph_valid[PER_ID_HYPER+N_CH_HYPER+(g_hyper*(N_CH_HYPER+1)) : PER_ID_HYPER+(g_hyper*(N_CH_HYPER+1))]      ),
             .cfg_ready_o         ( s_periph_ready[PER_ID_HYPER+N_CH_HYPER+(g_hyper*(N_CH_HYPER+1)) : PER_ID_HYPER+(g_hyper*(N_CH_HYPER+1))]      ),
             .cfg_data_o          ( s_periph_data_from[PER_ID_HYPER+N_CH_HYPER+(g_hyper*(N_CH_HYPER+1)) : PER_ID_HYPER+(g_hyper*(N_CH_HYPER+1))]  ),
         
             .cfg_rx_startaddr_o  ( s_rx_cfg_startaddr[CH_ID_RX_HYPER+g_hyper]              ),
             .cfg_rx_size_o       ( s_rx_cfg_size[CH_ID_RX_HYPER+g_hyper]                   ),
             .cfg_rx_continuous_o ( s_rx_cfg_continuous[CH_ID_RX_HYPER+g_hyper]             ),
             .cfg_rx_en_o         ( s_rx_cfg_en[CH_ID_RX_HYPER+g_hyper]                     ),
             .cfg_rx_clr_o        ( s_rx_cfg_clr[CH_ID_RX_HYPER+g_hyper]                    ),
             .cfg_rx_en_i         ( s_rx_ch_en[CH_ID_RX_HYPER+g_hyper]                      ),
             .cfg_rx_pending_i    ( s_rx_ch_pending[CH_ID_RX_HYPER+g_hyper]                 ),
             .cfg_rx_curr_addr_i  ( s_rx_ch_curr_addr[CH_ID_RX_HYPER+g_hyper]               ),
             .cfg_rx_bytes_left_i ( s_rx_ch_bytes_left[CH_ID_RX_HYPER+g_hyper]              ),
         
             .cfg_tx_startaddr_o  ( s_tx_cfg_startaddr[CH_ID_TX_HYPER+g_hyper]              ),
             .cfg_tx_size_o       ( s_tx_cfg_size[CH_ID_TX_HYPER+g_hyper]                   ),
             .cfg_tx_continuous_o ( s_tx_cfg_continuous[CH_ID_TX_HYPER+g_hyper]             ),
             .cfg_tx_en_o         ( s_tx_cfg_en[CH_ID_TX_HYPER+g_hyper]                     ),
             .cfg_tx_clr_o        ( s_tx_cfg_clr[CH_ID_TX_HYPER+g_hyper]                    ),
             .cfg_tx_en_i         ( s_tx_ch_en[CH_ID_TX_HYPER+g_hyper]                      ),
             .cfg_tx_pending_i    ( s_tx_ch_pending[CH_ID_TX_HYPER+g_hyper]                 ),
             .cfg_tx_curr_addr_i  ( s_tx_ch_curr_addr[CH_ID_TX_HYPER+g_hyper]               ),
             .cfg_tx_bytes_left_i ( s_tx_ch_bytes_left[CH_ID_TX_HYPER+g_hyper]              ),
             .evt_eot_hyper_o     ( s_evt_eot_hyper                                         ),
         
             .data_tx_req_o       ( s_tx_ch_req[CH_ID_TX_HYPER+g_hyper]                     ),
             .data_tx_gnt_i       ( s_tx_ch_gnt[CH_ID_TX_HYPER+g_hyper]                     ),
             .data_tx_datasize_o  ( s_tx_ch_datasize[CH_ID_TX_HYPER+g_hyper]                ),
             .data_tx_i           ( s_tx_ch_data[CH_ID_TX_HYPER+g_hyper]                    ),
             .data_tx_valid_i     ( s_tx_ch_valid[CH_ID_TX_HYPER+g_hyper]                   ),
             .data_tx_ready_o     ( s_tx_ch_ready[CH_ID_TX_HYPER+g_hyper]                   ),
         
             .data_rx_datasize_o  ( s_rx_ch_datasize[CH_ID_RX_HYPER+g_hyper]                ),
             .data_rx_o           ( s_rx_ch_data[CH_ID_RX_HYPER+g_hyper]                    ),
             .data_rx_valid_o     ( s_rx_ch_valid[CH_ID_RX_HYPER+g_hyper]                   ),
             .data_rx_ready_i     ( s_rx_ch_ready[CH_ID_RX_HYPER+g_hyper]                   ),
         
              //////////////TO/FROM EXTERNAL OF THE CHIP///////////////////////////
             .pad_hyper_csn,
             .pad_hyper_ck,
             .pad_hyper_ckn,
             .pad_hyper_rwds,
             .pad_hyper_reset,
             .pad_hyper_dq
         );

       end // block: i_hyper_gen
   endgenerate
    `else // !`ifndef XILINX_DDR

   assign hyper_reg_cfg_slave.ready     = 1'b1;
   assign hyper_reg_cfg_slave.error     = '0;
   
   assign cfg_ready_o         = 1'b1;
   assign cfg_data_o          = '0;
   assign cfg_rx_startaddr_o  = '0;
   assign cfg_rx_size_o       = '0;
   assign cfg_rx_continuous_o = '0;
   assign cfg_rx_en_o         = '0;
   assign cfg_rx_clr_o        = '0;
   assign cfg_tx_startaddr_o  = '0;
   assign cfg_tx_size_o       = '0;
   assign cfg_tx_continuous_o = '0;
   assign cfg_tx_en_o         = '0;
   assign cfg_tx_clr_o        = '0;
   assign evt_eot_hyper_o     = '0;
         
   assign data_tx_req_o       = '0;
   assign data_tx_datasize_o  = '0;
   assign data_tx_ready_o     = 1'b1;

   assign data_rx_datasize_o  = '0;
   assign data_rx_o           = '0;
   assign data_rx_valid_o     = '0;         

   `endif
   
endmodule

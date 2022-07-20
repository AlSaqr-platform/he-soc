// Copyright 2017-2019 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
// Author: Luca Valente 
// Date: 13.01.2021
// Description: Ariane synth wrapper

//`include "/scratch/aibrahim/clean/he-soc/hardware/tb/common/assign.svh"

module cva6_synth_wrap
 import ariane_pkg::*;
 import ariane_soc::*;
 import ariane_axi_soc::*; #(

  localparam AXI_ID_WIDTH       = 5,
  localparam AXI_ADDR_WIDTH     = 64,
  localparam AXI_USER_WIDTH     = 1,
  localparam AXI_DATA_WIDTH     = 64,
  localparam AXI_STRB_WIDTH     = AXI_ADDR_WIDTH/8,
  localparam LOG_DEPTH          = 1,
                             
  localparam AW_WIDTH           = AXI_ID_WIDTH+AXI_ADDR_WIDTH+AXI_USER_WIDTH+$bits(axi_pkg::len_t)+$bits(axi_pkg::size_t)+$bits(axi_pkg::burst_t)+$bits(axi_pkg::cache_t)+$bits(axi_pkg::prot_t)+$bits(axi_pkg::qos_t)+$bits(axi_pkg::region_t)+$bits(axi_pkg::atop_t)+1,
  localparam W_WIDTH            = AXI_USER_WIDTH+AXI_STRB_WIDTH+AXI_DATA_WIDTH+1,
  localparam R_WIDTH            = AXI_ID_WIDTH+AXI_DATA_WIDTH+AXI_USER_WIDTH+$bits(axi_pkg::resp_t)+1,
  localparam B_WIDTH            = AXI_USER_WIDTH+AXI_ID_WIDTH+$bits(axi_pkg::resp_t),
  localparam AR_WIDTH           = AXI_ID_WIDTH+AXI_ADDR_WIDTH+AXI_USER_WIDTH+$bits(axi_pkg::len_t)+$bits(axi_pkg::size_t)+$bits(axi_pkg::burst_t)+$bits(axi_pkg::cache_t)+$bits(axi_pkg::prot_t)+$bits(axi_pkg::qos_t)+$bits(axi_pkg::region_t)+1,

  localparam ASYNC_AW_DATA_WIDTH = (2**LOG_DEPTH)*AW_WIDTH,
  localparam ASYNC_W_DATA_WIDTH  = (2**LOG_DEPTH)*W_WIDTH,
  localparam ASYNC_B_DATA_WIDTH  = (2**LOG_DEPTH)*B_WIDTH,
  localparam ASYNC_AR_DATA_WIDTH = (2**LOG_DEPTH)*AR_WIDTH,
  localparam ASYNC_R_DATA_WIDTH  = (2**LOG_DEPTH)*R_WIDTH
)  (
  input  logic                         clk_i,
  input  logic                         rst_ni,
  // Core ID, Cluster ID and boot address are considered more or less static
  input  logic [riscv::VLEN-1:0]       boot_addr_i,  // reset boot address
  input  logic [riscv::XLEN-1:0]       hart_id_i,    // hart id in a multicore environment (reflected in a CSR)
  // Interrupt inputs
  input  logic [1:0]                   irq_i,        // level sensitive IR lines, mip & sip (async)
  input  logic                         ipi_i,        // inter-processor interrupts (async)
  // Timer facilities
  input  logic                         time_irq_i,   // timer interrupt in (async)
  input  logic                         debug_req_i,  // debug request (async)

  // memory side, AXI Master
  // AXI4 MASTER
  //***************************************
  // WRITE ADDRESS CHANNEL
  output logic [LOG_DEPTH:0]                  data_master_aw_wptr_o,
  output logic [ASYNC_AW_DATA_WIDTH-1:0]      data_master_aw_data_o, 
  input logic [LOG_DEPTH:0]                   data_master_aw_rptr_i,
                                                 
  // READ ADDRESS CHANNEL                        
  output logic [LOG_DEPTH:0]                  data_master_ar_wptr_o,
  output logic [ASYNC_AR_DATA_WIDTH-1:0]      data_master_ar_data_o,
  input logic [LOG_DEPTH:0]                   data_master_ar_rptr_i,
                                                 
  // WRITE DATA CHANNEL                          
  output logic [LOG_DEPTH:0]                  data_master_w_wptr_o,
  output logic [ASYNC_W_DATA_WIDTH-1:0]       data_master_w_data_o,
  input logic [LOG_DEPTH:0]                   data_master_w_rptr_i,
                                                 
  // READ DATA CHANNEL                           
  input logic [LOG_DEPTH:0]                   data_master_r_wptr_i,
  input logic [ASYNC_R_DATA_WIDTH-1:0]        data_master_r_data_i,
  output logic [LOG_DEPTH:0]                  data_master_r_rptr_o,
                                                 
  // WRITE RESPONSE CHANNEL                      
  input logic [LOG_DEPTH:0]                   data_master_b_wptr_i,
  input logic [ASYNC_B_DATA_WIDTH-1:0]        data_master_b_data_i,
  output logic [LOG_DEPTH:0]                  data_master_b_rptr_o

);
   
  AXI_BUS #(
    .AXI_ADDR_WIDTH ( 64   ),
    .AXI_DATA_WIDTH ( 64   ),
    .AXI_ID_WIDTH   ( 5    ),
    .AXI_USER_WIDTH ( 1    )
  ) cva6_axi_master();

  AXI_BUS_ASYNC_GRAY #(
    .AXI_ADDR_WIDTH ( 64   ),
    .AXI_DATA_WIDTH ( 64   ),
    .AXI_ID_WIDTH   ( 5    ),
    .AXI_USER_WIDTH ( 1    ),
    .LOG_DEPTH      ( 1    )
  ) cva6_axi_master_src();

                       
  ariane_axi_soc::req_t_512    axi_ariane_req;
  ariane_axi_soc::resp_t_512   axi_ariane_resp;

  ariane_axi_soc::req_t   w_axi_ariane_req;
  ariane_axi_soc::resp_t   w_axi_ariane_resp;
   
  /*ariane #(
    .ArianeCfg  ( ariane_soc::ArianeSocCfg )
  ) i_ariane (
    .clk_i                ( clk_i               ),
    .rst_ni               ( rst_ni              ),
    .boot_addr_i          ( ariane_soc::ROMBase ), // start fetching from ROM
    .hart_id_i            ( '0                  ),
    .irq_i                ( irq_i               ), // async signal
    .ipi_i                ( ipi_i               ), // async signal
    .time_irq_i           ( time_irq_i          ), // async signal
    .debug_req_i          ( debug_req_i         ), // async signal
    .axi_req_o            ( axi_ariane_req      ),
    .axi_resp_i           ( axi_ariane_resp     )
  );*/



  wire [4:0] dump_wid;

  axi_dw_converter #(
    .AxiMaxReads          (2)    , // Number of outstanding reads
    .AxiSlvPortDataWidth  (512)    , // Data width of the slv port
    .AxiMstPortDataWidth  (64)    , // Data width of the mst port
    .AxiAddrWidth         (64)    , // Address width
    .AxiIdWidth           (5)    , // ID width
    .aw_chan_t                    (ariane_axi_soc::aw_chan_t), // AW Channel Type
    .mst_w_chan_t                 (ariane_axi_soc::w_chan_t), //  W Channel Type for the mst port
    .slv_w_chan_t                 (ariane_axi_soc::w_chan_t_512), //  W Channel Type for the slv port
    .b_chan_t                    (ariane_axi_soc::b_chan_t), //  B Channel Type
    .ar_chan_t                   (ariane_axi_soc::ar_chan_t), // AR Channel Type
    .mst_r_chan_t                (ariane_axi_soc::r_chan_t), //  R Channel Type for the mst port
    .slv_r_chan_t                (ariane_axi_soc::r_chan_t_512), //  R Channel Type for the slv port
    .axi_mst_req_t               (ariane_axi_soc::req_t), // AXI Request Type for mst ports
    .axi_mst_resp_t              (ariane_axi_soc::resp_t), // AXI Response Type for mst ports
    .axi_slv_req_t               (ariane_axi_soc::req_t_512), // AXI Request Type for slv ports
    .axi_slv_resp_t              (ariane_axi_soc::resp_t_512)  // AXI Response Type for slv ports
  )size_converter(
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    // Slave interface
    .slv_req_i(axi_ariane_req),
    .slv_resp_o(axi_ariane_resp),
    // Master interface
    .mst_req_o(w_axi_ariane_req),
    .mst_resp_i(w_axi_ariane_resp)
);

  cache_coherent_ariane_wrapper i_ariane (
    .core_ref_clk(clk_i),
    .sys_rst_n(rst_ni),
    // Debug
    .debug_req_i(debug_req_i),   // async debug request
    // CLINT
    .timer_irq_i(timer_irq_i),   // Timer interrupts
    .ipi_i(ipi_i),         // software interrupt (a.k.a inter-process-interrupt)
    // PLIC
    .irq_i(irq_i),          // level sensitive IR lines, mip & sip (async)

    .m_axi_awid(axi_ariane_req.aw.id),
    .m_axi_awaddr(axi_ariane_req.aw.addr),
    .m_axi_awlen(axi_ariane_req.aw.len),
    .m_axi_awsize(axi_ariane_req.aw.size),
    .m_axi_awburst(axi_ariane_req.aw.burst),
    .m_axi_awlock(axi_ariane_req.aw.lock ),
    .m_axi_awcache(axi_ariane_req.aw.cache),
    .m_axi_awprot(axi_ariane_req.aw.prot),
    .m_axi_awqos(axi_ariane_req.aw.qos ),
    .m_axi_awregion(axi_ariane_req.aw.region),
    .m_axi_awuser(axi_ariane_req.aw.user),
    .m_axi_awvalid(axi_ariane_req.aw_valid),
    .m_axi_awready(axi_ariane_resp.aw_ready),

    .m_axi_wid(dump_wid),
    .m_axi_wdata(axi_ariane_req.w.data),
    .m_axi_wstrb(axi_ariane_req.w.strb),
    .m_axi_wlast(axi_ariane_req.w.last),
    .m_axi_wuser(axi_ariane_req.w.user),
    .m_axi_wvalid(axi_ariane_req.w_valid),
    .m_axi_wready(axi_ariane_resp.w_ready),

    .m_axi_arid(axi_ariane_req.ar.id),
    .m_axi_araddr(axi_ariane_req.ar.addr),
    .m_axi_arlen(axi_ariane_req.ar.len),
    .m_axi_arsize(axi_ariane_req.ar.size ),
    .m_axi_arburst(axi_ariane_req.ar.burst),
    .m_axi_arlock(axi_ariane_req.ar.lock),
    .m_axi_arcache(axi_ariane_req.ar.cache),
    .m_axi_arprot(axi_ariane_req.ar.prot),
    .m_axi_arqos(axi_ariane_req.ar.qos),
    .m_axi_arregion(axi_ariane_req.ar.region),
    .m_axi_aruser(axi_ariane_req.ar.user),
    .m_axi_arvalid(axi_ariane_req.ar_valid),
    .m_axi_arready(axi_ariane_resp.ar_ready),

    .m_axi_rid(axi_ariane_resp.r.id),
    .m_axi_rdata(axi_ariane_resp.r.data),
    .m_axi_rresp(axi_ariane_resp.r.resp),
    .m_axi_rlast(axi_ariane_resp.r.last),
    .m_axi_ruser(axi_ariane_resp.r.user),
    .m_axi_rvalid(axi_ariane_resp.r_valid),
    .m_axi_rready(axi_ariane_req.r_ready),

    .m_axi_bid(axi_ariane_resp.b.id),
    .m_axi_bresp(axi_ariane_resp.b.resp),
    .m_axi_buser(axi_ariane_resp.b.user),
    .m_axi_bvalid(axi_ariane_resp.b_valid),
    .m_axi_bready(axi_ariane_req.b_ready)
  );
  
  axi_master_connect i_axi_master_connect_ariane (
    .axi_req_i(w_axi_ariane_req),
    .axi_resp_o(w_axi_ariane_resp),
    .master(cva6_axi_master)
  );

   axi_cdc_src_intf #(
                      .AXI_ID_WIDTH(5),
                      .AXI_ADDR_WIDTH(64),
                      .AXI_DATA_WIDTH(64),
                      .AXI_USER_WIDTH(1),
                      .LOG_DEPTH(1)
                      )
   cva6tosocdomainfifo (
                        .src_clk_i  ( clk_i               ),
                        .src_rst_ni ( rst_ni              ),
                        .src        ( cva6_axi_master     ),
                        .dst        ( cva6_axi_master_src )
                        );

   assign data_master_aw_wptr_o = cva6_axi_master_src.aw_wptr;
   assign data_master_aw_data_o = cva6_axi_master_src.aw_data;
   assign cva6_axi_master_src.aw_rptr = data_master_aw_rptr_i ;

   assign data_master_ar_wptr_o = cva6_axi_master_src.ar_wptr;
   assign data_master_ar_data_o = cva6_axi_master_src.ar_data;
   assign cva6_axi_master_src.ar_rptr = data_master_ar_rptr_i ;

   assign data_master_w_wptr_o = cva6_axi_master_src.w_wptr;
   assign data_master_w_data_o = cva6_axi_master_src.w_data;
   assign cva6_axi_master_src.w_rptr = data_master_w_rptr_i ;
   
   assign cva6_axi_master_src.r_wptr = data_master_r_wptr_i;
   assign cva6_axi_master_src.r_data = data_master_r_data_i;
   assign data_master_r_rptr_o = cva6_axi_master_src.r_rptr;

   assign cva6_axi_master_src.b_wptr = data_master_b_wptr_i;
   assign cva6_axi_master_src.b_data = data_master_b_data_i;
   assign data_master_b_rptr_o = cva6_axi_master_src.b_rptr;

  // -------------
  // Simulation Helper Functions
  // -------------
  // check for response errors
  always_ff @(posedge clk_i) begin : p_assert
    if (axi_ariane_req.r_ready &&
      axi_ariane_resp.r_valid &&
      axi_ariane_resp.r.resp inside {axi_pkg::RESP_DECERR, axi_pkg::RESP_SLVERR}) begin
      $warning("R Response Errored");
    end
    if (axi_ariane_req.b_ready &&
      axi_ariane_resp.b_valid &&
      axi_ariane_resp.b.resp inside {axi_pkg::RESP_DECERR, axi_pkg::RESP_SLVERR}) begin
      $warning("B Response Errored");
    end
  end
   
endmodule // cva6_synth_wrap

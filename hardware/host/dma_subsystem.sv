// Copyright 2022 ETH Zurich and University of Bologna.
// Solderpad Hardware License, Version 0.51, see LICENSE for details.
// SPDX-License-Identifier: SHL-0.51

// Yvan Tortorella <yvan.tortorella@unibo.it>
// Subsystem dedicate to the instantiation of the DMA

`include "axi/assign.svh"
import ariane_soc::*;

module dma_subsystem #(
  parameter int  AxiAddrWidth      = 64     ,
  parameter int  AxiDataWidth      = 64     ,
  parameter int  AxiUserWidth      = -1     ,
  parameter int  AxiIdWidth        = -1     ,
  parameter int  AxiSlvIdWidth     = -1     ,
  parameter int  NSpeculation      = 4      ,
  parameter int  PendingFifoDepth  = 4      ,
  parameter int  InputFifoDepth    = 8      ,
  parameter int  unsigned DMA_GEN  = DMA_GEN,
  parameter type dma_mst_aw_chan_t = logic  , // AW Channel Type, master port
  parameter type dma_mst_w_chan_t  = logic  , //  W Channel Type, all ports
  parameter type dma_mst_b_chan_t  = logic  , //  B Channel Type, master port
  parameter type dma_mst_ar_chan_t = logic  , // AR Channel Type, master port
  parameter type dma_mst_r_chan_t  = logic  , //  R Channel Type, master port
  parameter type dma_mst_req_t     = logic  ,
  parameter type dma_mst_rsp_t     = logic  ,
  parameter type dma_slv_req_t     = logic  ,
  parameter type dma_slv_rsp_t     = logic
) (
  input  logic         clk_i        ,
  input  logic         rst_ni       ,
  input  logic         testmode_i   ,
  output logic         irq_o        ,
  output dma_mst_req_t dma_mst_req_o,
  input  dma_mst_rsp_t dma_mst_rsp_i,
  input  dma_slv_req_t dma_slv_req_i,
  output dma_slv_rsp_t dma_slv_rsp_o
);

generate
  if (DMA_GEN) begin : generate_dma
    dma_desc_wrap #(
      .AxiAddrWidth     ( AxiAddrWidth      ),
      .AxiDataWidth     ( AxiDataWidth      ),
      .AxiUserWidth     ( AxiUserWidth      ),
      .AxiIdWidth       ( AxiIdWidth        ),
      .AxiSlvIdWidth    ( AxiSlvIdWidth     ),
      .NSpeculation     ( NSpeculation      ),
      .PendingFifoDepth ( PendingFifoDepth  ),
      .InputFifoDepth   ( InputFifoDepth    ),
      .mst_aw_chan_t    ( dma_mst_aw_chan_t ), // AW Channel Type, master port
      .mst_w_chan_t     ( dma_mst_w_chan_t  ), //  W Channel Type, all ports
      .mst_b_chan_t     ( dma_mst_b_chan_t  ), //  B Channel Type, master port
      .mst_ar_chan_t    ( dma_mst_ar_chan_t ), // AR Channel Type, master port
      .mst_r_chan_t     ( dma_mst_r_chan_t  ), //  R Channel Type, master port
      .axi_mst_req_t    ( dma_mst_req_t     ),
      .axi_mst_rsp_t    ( dma_mst_rsp_t     ),
      .axi_slv_req_t    ( dma_slv_req_t     ),
      .axi_slv_rsp_t    ( dma_slv_rsp_t     )
    ) dma_i             (
      .clk_i                             ,
      .rst_ni                            ,
      .testmode_i                        ,
      .irq_o                             ,
      .axi_master_req_o ( dma_mst_req_o ),
      .axi_master_rsp_i ( dma_mst_rsp_i ),
      .axi_slave_req_i  ( dma_slv_req_i ),
      .axi_slave_rsp_o  ( dma_slv_rsp_o )
    );
  end else begin : generate_no_dma
  
    axi_err_slv        #(
      .AxiIdWidth       ( AxiIdWidth           ),
      .axi_req_t        ( dma_slv_req_t        ),
      .axi_resp_t       ( dma_slv_rsp_t        ),
      .RespWidth        ( 64                   ),
      .RespData         ( 64'h000000D10CAD10CA ),
      .ATOPs            ( 1'b1                 ),
      .MaxTrans         ( 1                    )
    ) dma_err_slv_i     (
      .clk_i                       ,
      .rst_ni                      ,
      .test_i     ( testmode_i    ),
      .slv_req_i  ( dma_slv_req_i ),
      .slv_resp_o ( dma_slv_rsp_o )
    );

    // Master Bus manual binding
    // AW chan
    assign dma_mst_req_o.aw.id     = '0;
    assign dma_mst_req_o.aw.addr   = '0;
    assign dma_mst_req_o.aw.len    = '0;
    assign dma_mst_req_o.aw.size   = '0;
    assign dma_mst_req_o.aw.burst  = '0;
    assign dma_mst_req_o.aw.lock   = '0;
    assign dma_mst_req_o.aw.cache  = '0;
    assign dma_mst_req_o.aw.prot   = '0;
    assign dma_mst_req_o.aw.qos    = '0;
    assign dma_mst_req_o.aw.region = '0;
    assign dma_mst_req_o.aw.atop   = '0;
    assign dma_mst_req_o.aw.user   = '0;
    assign dma_mst_req_o.aw_valid  = '0;
    // W Chan
    assign dma_mst_req_o.w.data  = '0;
    assign dma_mst_req_o.w.strb  = '0;
    assign dma_mst_req_o.w.last  = '0;
    assign dma_mst_req_o.w.user  = '0;
    assign dma_mst_req_o.w_valid = '0;
    // B Chan
    assign dma_mst_req_o.b_ready = '0;
    // AR chan
    assign dma_mst_req_o.ar.id     = '0;
    assign dma_mst_req_o.ar.addr   = '0;
    assign dma_mst_req_o.ar.len    = '0;
    assign dma_mst_req_o.ar.size   = '0;
    assign dma_mst_req_o.ar.burst  = '0;
    assign dma_mst_req_o.ar.lock   = '0;
    assign dma_mst_req_o.ar.cache  = '0;
    assign dma_mst_req_o.ar.prot   = '0;
    assign dma_mst_req_o.ar.qos    = '0;
    assign dma_mst_req_o.ar.region = '0;
    assign dma_mst_req_o.ar.user   = '0;
    assign dma_mst_req_o.ar_valid  = '0;
    // R Chan
    assign dma_mst_req_o.r_ready = '0;
  end
endgenerate

endmodule : dma_subsystem

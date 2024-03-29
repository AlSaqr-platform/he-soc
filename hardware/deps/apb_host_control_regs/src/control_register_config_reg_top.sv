// Copyright lowRISC contributors.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0
//
// Register Top module auto-generated by `reggen`


`include "common_cells/assertions.svh"

module control_register_config_reg_top #(
    parameter type reg_req_t = logic,
    parameter type reg_rsp_t = logic,
    parameter int AW = 7
) (
  input clk_i,
  input rst_ni,
  input  reg_req_t reg_req_i,
  output reg_rsp_t reg_rsp_o,
  // To HW
  output control_register_config_reg_pkg::control_register_config_reg2hw_t reg2hw, // Write
  input  control_register_config_reg_pkg::control_register_config_hw2reg_t hw2reg, // Read


  // Config
  input devmode_i // If 1, explicit error return for unmapped register access
);

  import control_register_config_reg_pkg::* ;

  localparam int DW = 32;
  localparam int DBW = DW/8;                    // Byte Width

  // register signals
  logic           reg_we;
  logic           reg_re;
  logic [AW-1:0]  reg_addr;
  logic [DW-1:0]  reg_wdata;
  logic [DBW-1:0] reg_be;
  logic [DW-1:0]  reg_rdata;
  logic           reg_error;

  logic          addrmiss, wr_err;

  logic [DW-1:0] reg_rdata_next;

  // Below register interface can be changed
  reg_req_t  reg_intf_req;
  reg_rsp_t  reg_intf_rsp;


  assign reg_intf_req = reg_req_i;
  assign reg_rsp_o = reg_intf_rsp;


  assign reg_we = reg_intf_req.valid & reg_intf_req.write;
  assign reg_re = reg_intf_req.valid & ~reg_intf_req.write;
  assign reg_addr = reg_intf_req.addr;
  assign reg_wdata = reg_intf_req.wdata;
  assign reg_be = reg_intf_req.wstrb;
  assign reg_intf_rsp.rdata = reg_rdata;
  assign reg_intf_rsp.error = reg_error;
  assign reg_intf_rsp.ready = 1'b1;

  assign reg_rdata = reg_rdata_next ;
  assign reg_error = (devmode_i & addrmiss) | wr_err;


  // Define SW related signals
  // Format: <reg>_<field>_{wd|we|qs}
  //        or <reg>_{wd|we|qs} if field == 1 or 0
  logic control_cluster_reset_n_qs;
  logic control_cluster_reset_n_wd;
  logic control_cluster_reset_n_we;
  logic control_cluster_en_sa_boot_qs;
  logic control_cluster_en_sa_boot_wd;
  logic control_cluster_en_sa_boot_we;
  logic control_cluster_fetch_en_qs;
  logic control_cluster_fetch_en_wd;
  logic control_cluster_fetch_en_we;
  logic enable_llc_counters_qs;
  logic enable_llc_counters_wd;
  logic enable_llc_counters_we;
  logic [31:0] llc_read_miss_cache_qs;
  logic [31:0] llc_read_hit_cache_qs;
  logic [31:0] llc_write_miss_cache_qs;
  logic [31:0] llc_write_hit_cache_qs;
  logic [31:0] llc_cache_addr_start_qs;
  logic [31:0] llc_cache_addr_start_wd;
  logic llc_cache_addr_start_we;
  logic [31:0] llc_cache_addr_end_qs;
  logic [31:0] llc_cache_addr_end_wd;
  logic llc_cache_addr_end_we;
  logic [31:0] llc_spm_addr_start_qs;
  logic [31:0] llc_spm_addr_start_wd;
  logic llc_spm_addr_start_we;
  logic [1:0] ot_clk_sel_qs;
  logic [1:0] ot_clk_sel_wd;
  logic ot_clk_sel_we;
  logic [31:0] ot_clk_div_qs;
  logic [31:0] ot_clk_div_wd;
  logic ot_clk_div_we;
  logic ot_clk_gate_en_qs;
  logic ot_clk_gate_en_wd;
  logic ot_clk_gate_en_we;
  logic [31:0] logic_locking_key_0_0_qs;
  logic [31:0] logic_locking_key_0_0_wd;
  logic logic_locking_key_0_0_we;
  logic [31:0] logic_locking_key_0_1_qs;
  logic [31:0] logic_locking_key_0_1_wd;
  logic logic_locking_key_0_1_we;
  logic [31:0] logic_locking_key_0_2_qs;
  logic [31:0] logic_locking_key_0_2_wd;
  logic logic_locking_key_0_2_we;
  logic [31:0] logic_locking_key_0_3_qs;
  logic [31:0] logic_locking_key_0_3_wd;
  logic logic_locking_key_0_3_we;
  logic [31:0] logic_locking_key_1_0_qs;
  logic [31:0] logic_locking_key_1_0_wd;
  logic logic_locking_key_1_0_we;
  logic [31:0] logic_locking_key_1_1_qs;
  logic [31:0] logic_locking_key_1_1_wd;
  logic logic_locking_key_1_1_we;
  logic [31:0] logic_locking_key_1_2_qs;
  logic [31:0] logic_locking_key_1_2_wd;
  logic logic_locking_key_1_2_we;
  logic [31:0] logic_locking_key_1_3_qs;
  logic [31:0] logic_locking_key_1_3_wd;
  logic logic_locking_key_1_3_we;
  logic [31:0] logic_locking_key_2_0_qs;
  logic [31:0] logic_locking_key_2_0_wd;
  logic logic_locking_key_2_0_we;
  logic [31:0] logic_locking_key_2_1_qs;
  logic [31:0] logic_locking_key_2_1_wd;
  logic logic_locking_key_2_1_we;
  logic [31:0] logic_locking_key_2_2_qs;
  logic [31:0] logic_locking_key_2_2_wd;
  logic logic_locking_key_2_2_we;
  logic [31:0] logic_locking_key_2_3_qs;
  logic [31:0] logic_locking_key_2_3_wd;
  logic logic_locking_key_2_3_we;
  logic [31:0] logic_locking_key_3_0_qs;
  logic [31:0] logic_locking_key_3_0_wd;
  logic logic_locking_key_3_0_we;
  logic [31:0] logic_locking_key_3_1_qs;
  logic [31:0] logic_locking_key_3_1_wd;
  logic logic_locking_key_3_1_we;
  logic [31:0] logic_locking_key_3_2_qs;
  logic [31:0] logic_locking_key_3_2_wd;
  logic logic_locking_key_3_2_we;
  logic [31:0] logic_locking_key_3_3_qs;
  logic [31:0] logic_locking_key_3_3_wd;
  logic logic_locking_key_3_3_we;

  // Register instances
  // R[control_cluster]: V(False)

  //   F[reset_n]: 0:0
  prim_subreg #(
    .DW      (1),
    .SWACCESS("RW"),
    .RESVAL  (1'h1)
  ) u_control_cluster_reset_n (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (control_cluster_reset_n_we),
    .wd     (control_cluster_reset_n_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.control_cluster.reset_n.q ),

    // to register interface (read)
    .qs     (control_cluster_reset_n_qs)
  );


  //   F[en_sa_boot]: 1:1
  prim_subreg #(
    .DW      (1),
    .SWACCESS("RW"),
    .RESVAL  (1'h0)
  ) u_control_cluster_en_sa_boot (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (control_cluster_en_sa_boot_we),
    .wd     (control_cluster_en_sa_boot_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.control_cluster.en_sa_boot.q ),

    // to register interface (read)
    .qs     (control_cluster_en_sa_boot_qs)
  );


  //   F[fetch_en]: 2:2
  prim_subreg #(
    .DW      (1),
    .SWACCESS("RW"),
    .RESVAL  (1'h0)
  ) u_control_cluster_fetch_en (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (control_cluster_fetch_en_we),
    .wd     (control_cluster_fetch_en_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.control_cluster.fetch_en.q ),

    // to register interface (read)
    .qs     (control_cluster_fetch_en_qs)
  );


  // R[enable_llc_counters]: V(False)

  prim_subreg #(
    .DW      (1),
    .SWACCESS("RW"),
    .RESVAL  (1'h0)
  ) u_enable_llc_counters (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (enable_llc_counters_we),
    .wd     (enable_llc_counters_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.enable_llc_counters.q ),

    // to register interface (read)
    .qs     (enable_llc_counters_qs)
  );


  // R[llc_read_miss_cache]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RO"),
    .RESVAL  (32'h0)
  ) u_llc_read_miss_cache (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    .we     (1'b0),
    .wd     ('0  ),

    // from internal hardware
    .de     (hw2reg.llc_read_miss_cache.de),
    .d      (hw2reg.llc_read_miss_cache.d ),

    // to internal hardware
    .qe     (),
    .q      (),

    // to register interface (read)
    .qs     (llc_read_miss_cache_qs)
  );


  // R[llc_read_hit_cache]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RO"),
    .RESVAL  (32'h0)
  ) u_llc_read_hit_cache (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    .we     (1'b0),
    .wd     ('0  ),

    // from internal hardware
    .de     (hw2reg.llc_read_hit_cache.de),
    .d      (hw2reg.llc_read_hit_cache.d ),

    // to internal hardware
    .qe     (),
    .q      (),

    // to register interface (read)
    .qs     (llc_read_hit_cache_qs)
  );


  // R[llc_write_miss_cache]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RO"),
    .RESVAL  (32'h0)
  ) u_llc_write_miss_cache (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    .we     (1'b0),
    .wd     ('0  ),

    // from internal hardware
    .de     (hw2reg.llc_write_miss_cache.de),
    .d      (hw2reg.llc_write_miss_cache.d ),

    // to internal hardware
    .qe     (),
    .q      (),

    // to register interface (read)
    .qs     (llc_write_miss_cache_qs)
  );


  // R[llc_write_hit_cache]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RO"),
    .RESVAL  (32'h0)
  ) u_llc_write_hit_cache (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    .we     (1'b0),
    .wd     ('0  ),

    // from internal hardware
    .de     (hw2reg.llc_write_hit_cache.de),
    .d      (hw2reg.llc_write_hit_cache.d ),

    // to internal hardware
    .qe     (),
    .q      (),

    // to register interface (read)
    .qs     (llc_write_hit_cache_qs)
  );


  // R[llc_cache_addr_start]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h80000000)
  ) u_llc_cache_addr_start (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (llc_cache_addr_start_we),
    .wd     (llc_cache_addr_start_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.llc_cache_addr_start.q ),

    // to register interface (read)
    .qs     (llc_cache_addr_start_qs)
  );


  // R[llc_cache_addr_end]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h80800000)
  ) u_llc_cache_addr_end (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (llc_cache_addr_end_we),
    .wd     (llc_cache_addr_end_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.llc_cache_addr_end.q ),

    // to register interface (read)
    .qs     (llc_cache_addr_end_qs)
  );


  // R[llc_spm_addr_start]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h70000000)
  ) u_llc_spm_addr_start (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (llc_spm_addr_start_we),
    .wd     (llc_spm_addr_start_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.llc_spm_addr_start.q ),

    // to register interface (read)
    .qs     (llc_spm_addr_start_qs)
  );


  // R[ot_clk_sel]: V(False)

  prim_subreg #(
    .DW      (2),
    .SWACCESS("RW"),
    .RESVAL  (2'h1)
  ) u_ot_clk_sel (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (ot_clk_sel_we),
    .wd     (ot_clk_sel_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.ot_clk_sel.q ),

    // to register interface (read)
    .qs     (ot_clk_sel_qs)
  );


  // R[ot_clk_div]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h1)
  ) u_ot_clk_div (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (ot_clk_div_we),
    .wd     (ot_clk_div_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (reg2hw.ot_clk_div.qe),
    .q      (reg2hw.ot_clk_div.q ),

    // to register interface (read)
    .qs     (ot_clk_div_qs)
  );


  // R[ot_clk_gate_en]: V(False)

  prim_subreg #(
    .DW      (1),
    .SWACCESS("RW"),
    .RESVAL  (1'h0)
  ) u_ot_clk_gate_en (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (ot_clk_gate_en_we),
    .wd     (ot_clk_gate_en_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.ot_clk_gate_en.q ),

    // to register interface (read)
    .qs     (ot_clk_gate_en_qs)
  );



  // Subregister 0 of Multireg logic_locking_key_0
  // R[logic_locking_key_0_0]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_0_0 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_0_0_we),
    .wd     (logic_locking_key_0_0_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_0[0].q ),

    // to register interface (read)
    .qs     (logic_locking_key_0_0_qs)
  );

  // Subregister 1 of Multireg logic_locking_key_0
  // R[logic_locking_key_0_1]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_0_1 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_0_1_we),
    .wd     (logic_locking_key_0_1_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_0[1].q ),

    // to register interface (read)
    .qs     (logic_locking_key_0_1_qs)
  );

  // Subregister 2 of Multireg logic_locking_key_0
  // R[logic_locking_key_0_2]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_0_2 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_0_2_we),
    .wd     (logic_locking_key_0_2_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_0[2].q ),

    // to register interface (read)
    .qs     (logic_locking_key_0_2_qs)
  );

  // Subregister 3 of Multireg logic_locking_key_0
  // R[logic_locking_key_0_3]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_0_3 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_0_3_we),
    .wd     (logic_locking_key_0_3_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_0[3].q ),

    // to register interface (read)
    .qs     (logic_locking_key_0_3_qs)
  );



  // Subregister 0 of Multireg logic_locking_key_1
  // R[logic_locking_key_1_0]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_1_0 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_1_0_we),
    .wd     (logic_locking_key_1_0_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_1[0].q ),

    // to register interface (read)
    .qs     (logic_locking_key_1_0_qs)
  );

  // Subregister 1 of Multireg logic_locking_key_1
  // R[logic_locking_key_1_1]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_1_1 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_1_1_we),
    .wd     (logic_locking_key_1_1_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_1[1].q ),

    // to register interface (read)
    .qs     (logic_locking_key_1_1_qs)
  );

  // Subregister 2 of Multireg logic_locking_key_1
  // R[logic_locking_key_1_2]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_1_2 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_1_2_we),
    .wd     (logic_locking_key_1_2_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_1[2].q ),

    // to register interface (read)
    .qs     (logic_locking_key_1_2_qs)
  );

  // Subregister 3 of Multireg logic_locking_key_1
  // R[logic_locking_key_1_3]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_1_3 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_1_3_we),
    .wd     (logic_locking_key_1_3_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_1[3].q ),

    // to register interface (read)
    .qs     (logic_locking_key_1_3_qs)
  );



  // Subregister 0 of Multireg logic_locking_key_2
  // R[logic_locking_key_2_0]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_2_0 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_2_0_we),
    .wd     (logic_locking_key_2_0_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_2[0].q ),

    // to register interface (read)
    .qs     (logic_locking_key_2_0_qs)
  );

  // Subregister 1 of Multireg logic_locking_key_2
  // R[logic_locking_key_2_1]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_2_1 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_2_1_we),
    .wd     (logic_locking_key_2_1_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_2[1].q ),

    // to register interface (read)
    .qs     (logic_locking_key_2_1_qs)
  );

  // Subregister 2 of Multireg logic_locking_key_2
  // R[logic_locking_key_2_2]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_2_2 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_2_2_we),
    .wd     (logic_locking_key_2_2_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_2[2].q ),

    // to register interface (read)
    .qs     (logic_locking_key_2_2_qs)
  );

  // Subregister 3 of Multireg logic_locking_key_2
  // R[logic_locking_key_2_3]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_2_3 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_2_3_we),
    .wd     (logic_locking_key_2_3_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_2[3].q ),

    // to register interface (read)
    .qs     (logic_locking_key_2_3_qs)
  );



  // Subregister 0 of Multireg logic_locking_key_3
  // R[logic_locking_key_3_0]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_3_0 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_3_0_we),
    .wd     (logic_locking_key_3_0_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_3[0].q ),

    // to register interface (read)
    .qs     (logic_locking_key_3_0_qs)
  );

  // Subregister 1 of Multireg logic_locking_key_3
  // R[logic_locking_key_3_1]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_3_1 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_3_1_we),
    .wd     (logic_locking_key_3_1_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_3[1].q ),

    // to register interface (read)
    .qs     (logic_locking_key_3_1_qs)
  );

  // Subregister 2 of Multireg logic_locking_key_3
  // R[logic_locking_key_3_2]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_3_2 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_3_2_we),
    .wd     (logic_locking_key_3_2_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_3[2].q ),

    // to register interface (read)
    .qs     (logic_locking_key_3_2_qs)
  );

  // Subregister 3 of Multireg logic_locking_key_3
  // R[logic_locking_key_3_3]: V(False)

  prim_subreg #(
    .DW      (32),
    .SWACCESS("RW"),
    .RESVAL  (32'h0)
  ) u_logic_locking_key_3_3 (
    .clk_i   (clk_i    ),
    .rst_ni  (rst_ni  ),

    // from register interface
    .we     (logic_locking_key_3_3_we),
    .wd     (logic_locking_key_3_3_wd),

    // from internal hardware
    .de     (1'b0),
    .d      ('0  ),

    // to internal hardware
    .qe     (),
    .q      (reg2hw.logic_locking_key_3[3].q ),

    // to register interface (read)
    .qs     (logic_locking_key_3_3_qs)
  );




  logic [27:0] addr_hit;
  always_comb begin
    addr_hit = '0;
    addr_hit[ 0] = (reg_addr == CONTROL_REGISTER_CONFIG_CONTROL_CLUSTER_OFFSET);
    addr_hit[ 1] = (reg_addr == CONTROL_REGISTER_CONFIG_ENABLE_LLC_COUNTERS_OFFSET);
    addr_hit[ 2] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_READ_MISS_CACHE_OFFSET);
    addr_hit[ 3] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_READ_HIT_CACHE_OFFSET);
    addr_hit[ 4] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_WRITE_MISS_CACHE_OFFSET);
    addr_hit[ 5] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_WRITE_HIT_CACHE_OFFSET);
    addr_hit[ 6] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_CACHE_ADDR_START_OFFSET);
    addr_hit[ 7] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_CACHE_ADDR_END_OFFSET);
    addr_hit[ 8] = (reg_addr == CONTROL_REGISTER_CONFIG_LLC_SPM_ADDR_START_OFFSET);
    addr_hit[ 9] = (reg_addr == CONTROL_REGISTER_CONFIG_OT_CLK_SEL_OFFSET);
    addr_hit[10] = (reg_addr == CONTROL_REGISTER_CONFIG_OT_CLK_DIV_OFFSET);
    addr_hit[11] = (reg_addr == CONTROL_REGISTER_CONFIG_OT_CLK_GATE_EN_OFFSET);
    addr_hit[12] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_0_0_OFFSET);
    addr_hit[13] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_0_1_OFFSET);
    addr_hit[14] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_0_2_OFFSET);
    addr_hit[15] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_0_3_OFFSET);
    addr_hit[16] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_1_0_OFFSET);
    addr_hit[17] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_1_1_OFFSET);
    addr_hit[18] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_1_2_OFFSET);
    addr_hit[19] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_1_3_OFFSET);
    addr_hit[20] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_2_0_OFFSET);
    addr_hit[21] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_2_1_OFFSET);
    addr_hit[22] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_2_2_OFFSET);
    addr_hit[23] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_2_3_OFFSET);
    addr_hit[24] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_3_0_OFFSET);
    addr_hit[25] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_3_1_OFFSET);
    addr_hit[26] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_3_2_OFFSET);
    addr_hit[27] = (reg_addr == CONTROL_REGISTER_CONFIG_LOGIC_LOCKING_KEY_3_3_OFFSET);
  end

  assign addrmiss = (reg_re || reg_we) ? ~|addr_hit : 1'b0 ;

  // Check sub-word write is permitted
  always_comb begin
    wr_err = (reg_we &
              ((addr_hit[ 0] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 0] & ~reg_be))) |
               (addr_hit[ 1] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 1] & ~reg_be))) |
               (addr_hit[ 2] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 2] & ~reg_be))) |
               (addr_hit[ 3] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 3] & ~reg_be))) |
               (addr_hit[ 4] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 4] & ~reg_be))) |
               (addr_hit[ 5] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 5] & ~reg_be))) |
               (addr_hit[ 6] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 6] & ~reg_be))) |
               (addr_hit[ 7] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 7] & ~reg_be))) |
               (addr_hit[ 8] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 8] & ~reg_be))) |
               (addr_hit[ 9] & (|(CONTROL_REGISTER_CONFIG_PERMIT[ 9] & ~reg_be))) |
               (addr_hit[10] & (|(CONTROL_REGISTER_CONFIG_PERMIT[10] & ~reg_be))) |
               (addr_hit[11] & (|(CONTROL_REGISTER_CONFIG_PERMIT[11] & ~reg_be))) |
               (addr_hit[12] & (|(CONTROL_REGISTER_CONFIG_PERMIT[12] & ~reg_be))) |
               (addr_hit[13] & (|(CONTROL_REGISTER_CONFIG_PERMIT[13] & ~reg_be))) |
               (addr_hit[14] & (|(CONTROL_REGISTER_CONFIG_PERMIT[14] & ~reg_be))) |
               (addr_hit[15] & (|(CONTROL_REGISTER_CONFIG_PERMIT[15] & ~reg_be))) |
               (addr_hit[16] & (|(CONTROL_REGISTER_CONFIG_PERMIT[16] & ~reg_be))) |
               (addr_hit[17] & (|(CONTROL_REGISTER_CONFIG_PERMIT[17] & ~reg_be))) |
               (addr_hit[18] & (|(CONTROL_REGISTER_CONFIG_PERMIT[18] & ~reg_be))) |
               (addr_hit[19] & (|(CONTROL_REGISTER_CONFIG_PERMIT[19] & ~reg_be))) |
               (addr_hit[20] & (|(CONTROL_REGISTER_CONFIG_PERMIT[20] & ~reg_be))) |
               (addr_hit[21] & (|(CONTROL_REGISTER_CONFIG_PERMIT[21] & ~reg_be))) |
               (addr_hit[22] & (|(CONTROL_REGISTER_CONFIG_PERMIT[22] & ~reg_be))) |
               (addr_hit[23] & (|(CONTROL_REGISTER_CONFIG_PERMIT[23] & ~reg_be))) |
               (addr_hit[24] & (|(CONTROL_REGISTER_CONFIG_PERMIT[24] & ~reg_be))) |
               (addr_hit[25] & (|(CONTROL_REGISTER_CONFIG_PERMIT[25] & ~reg_be))) |
               (addr_hit[26] & (|(CONTROL_REGISTER_CONFIG_PERMIT[26] & ~reg_be))) |
               (addr_hit[27] & (|(CONTROL_REGISTER_CONFIG_PERMIT[27] & ~reg_be)))));
  end

  assign control_cluster_reset_n_we = addr_hit[0] & reg_we & !reg_error;
  assign control_cluster_reset_n_wd = reg_wdata[0];

  assign control_cluster_en_sa_boot_we = addr_hit[0] & reg_we & !reg_error;
  assign control_cluster_en_sa_boot_wd = reg_wdata[1];

  assign control_cluster_fetch_en_we = addr_hit[0] & reg_we & !reg_error;
  assign control_cluster_fetch_en_wd = reg_wdata[2];

  assign enable_llc_counters_we = addr_hit[1] & reg_we & !reg_error;
  assign enable_llc_counters_wd = reg_wdata[0];

  assign llc_cache_addr_start_we = addr_hit[6] & reg_we & !reg_error;
  assign llc_cache_addr_start_wd = reg_wdata[31:0];

  assign llc_cache_addr_end_we = addr_hit[7] & reg_we & !reg_error;
  assign llc_cache_addr_end_wd = reg_wdata[31:0];

  assign llc_spm_addr_start_we = addr_hit[8] & reg_we & !reg_error;
  assign llc_spm_addr_start_wd = reg_wdata[31:0];

  assign ot_clk_sel_we = addr_hit[9] & reg_we & !reg_error;
  assign ot_clk_sel_wd = reg_wdata[1:0];

  assign ot_clk_div_we = addr_hit[10] & reg_we & !reg_error;
  assign ot_clk_div_wd = reg_wdata[31:0];

  assign ot_clk_gate_en_we = addr_hit[11] & reg_we & !reg_error;
  assign ot_clk_gate_en_wd = reg_wdata[0];

  assign logic_locking_key_0_0_we = addr_hit[12] & reg_we & !reg_error;
  assign logic_locking_key_0_0_wd = reg_wdata[31:0];

  assign logic_locking_key_0_1_we = addr_hit[13] & reg_we & !reg_error;
  assign logic_locking_key_0_1_wd = reg_wdata[31:0];

  assign logic_locking_key_0_2_we = addr_hit[14] & reg_we & !reg_error;
  assign logic_locking_key_0_2_wd = reg_wdata[31:0];

  assign logic_locking_key_0_3_we = addr_hit[15] & reg_we & !reg_error;
  assign logic_locking_key_0_3_wd = reg_wdata[31:0];

  assign logic_locking_key_1_0_we = addr_hit[16] & reg_we & !reg_error;
  assign logic_locking_key_1_0_wd = reg_wdata[31:0];

  assign logic_locking_key_1_1_we = addr_hit[17] & reg_we & !reg_error;
  assign logic_locking_key_1_1_wd = reg_wdata[31:0];

  assign logic_locking_key_1_2_we = addr_hit[18] & reg_we & !reg_error;
  assign logic_locking_key_1_2_wd = reg_wdata[31:0];

  assign logic_locking_key_1_3_we = addr_hit[19] & reg_we & !reg_error;
  assign logic_locking_key_1_3_wd = reg_wdata[31:0];

  assign logic_locking_key_2_0_we = addr_hit[20] & reg_we & !reg_error;
  assign logic_locking_key_2_0_wd = reg_wdata[31:0];

  assign logic_locking_key_2_1_we = addr_hit[21] & reg_we & !reg_error;
  assign logic_locking_key_2_1_wd = reg_wdata[31:0];

  assign logic_locking_key_2_2_we = addr_hit[22] & reg_we & !reg_error;
  assign logic_locking_key_2_2_wd = reg_wdata[31:0];

  assign logic_locking_key_2_3_we = addr_hit[23] & reg_we & !reg_error;
  assign logic_locking_key_2_3_wd = reg_wdata[31:0];

  assign logic_locking_key_3_0_we = addr_hit[24] & reg_we & !reg_error;
  assign logic_locking_key_3_0_wd = reg_wdata[31:0];

  assign logic_locking_key_3_1_we = addr_hit[25] & reg_we & !reg_error;
  assign logic_locking_key_3_1_wd = reg_wdata[31:0];

  assign logic_locking_key_3_2_we = addr_hit[26] & reg_we & !reg_error;
  assign logic_locking_key_3_2_wd = reg_wdata[31:0];

  assign logic_locking_key_3_3_we = addr_hit[27] & reg_we & !reg_error;
  assign logic_locking_key_3_3_wd = reg_wdata[31:0];

  // Read data return
  always_comb begin
    reg_rdata_next = '0;
    unique case (1'b1)
      addr_hit[0]: begin
        reg_rdata_next[0] = control_cluster_reset_n_qs;
        reg_rdata_next[1] = control_cluster_en_sa_boot_qs;
        reg_rdata_next[2] = control_cluster_fetch_en_qs;
      end

      addr_hit[1]: begin
        reg_rdata_next[0] = enable_llc_counters_qs;
      end

      addr_hit[2]: begin
        reg_rdata_next[31:0] = llc_read_miss_cache_qs;
      end

      addr_hit[3]: begin
        reg_rdata_next[31:0] = llc_read_hit_cache_qs;
      end

      addr_hit[4]: begin
        reg_rdata_next[31:0] = llc_write_miss_cache_qs;
      end

      addr_hit[5]: begin
        reg_rdata_next[31:0] = llc_write_hit_cache_qs;
      end

      addr_hit[6]: begin
        reg_rdata_next[31:0] = llc_cache_addr_start_qs;
      end

      addr_hit[7]: begin
        reg_rdata_next[31:0] = llc_cache_addr_end_qs;
      end

      addr_hit[8]: begin
        reg_rdata_next[31:0] = llc_spm_addr_start_qs;
      end

      addr_hit[9]: begin
        reg_rdata_next[1:0] = ot_clk_sel_qs;
      end

      addr_hit[10]: begin
        reg_rdata_next[31:0] = ot_clk_div_qs;
      end

      addr_hit[11]: begin
        reg_rdata_next[0] = ot_clk_gate_en_qs;
      end

      addr_hit[12]: begin
        reg_rdata_next[31:0] = logic_locking_key_0_0_qs;
      end

      addr_hit[13]: begin
        reg_rdata_next[31:0] = logic_locking_key_0_1_qs;
      end

      addr_hit[14]: begin
        reg_rdata_next[31:0] = logic_locking_key_0_2_qs;
      end

      addr_hit[15]: begin
        reg_rdata_next[31:0] = logic_locking_key_0_3_qs;
      end

      addr_hit[16]: begin
        reg_rdata_next[31:0] = logic_locking_key_1_0_qs;
      end

      addr_hit[17]: begin
        reg_rdata_next[31:0] = logic_locking_key_1_1_qs;
      end

      addr_hit[18]: begin
        reg_rdata_next[31:0] = logic_locking_key_1_2_qs;
      end

      addr_hit[19]: begin
        reg_rdata_next[31:0] = logic_locking_key_1_3_qs;
      end

      addr_hit[20]: begin
        reg_rdata_next[31:0] = logic_locking_key_2_0_qs;
      end

      addr_hit[21]: begin
        reg_rdata_next[31:0] = logic_locking_key_2_1_qs;
      end

      addr_hit[22]: begin
        reg_rdata_next[31:0] = logic_locking_key_2_2_qs;
      end

      addr_hit[23]: begin
        reg_rdata_next[31:0] = logic_locking_key_2_3_qs;
      end

      addr_hit[24]: begin
        reg_rdata_next[31:0] = logic_locking_key_3_0_qs;
      end

      addr_hit[25]: begin
        reg_rdata_next[31:0] = logic_locking_key_3_1_qs;
      end

      addr_hit[26]: begin
        reg_rdata_next[31:0] = logic_locking_key_3_2_qs;
      end

      addr_hit[27]: begin
        reg_rdata_next[31:0] = logic_locking_key_3_3_qs;
      end

      default: begin
        reg_rdata_next = '1;
      end
    endcase
  end

  // Unused signal tieoff

  // wdata / byte enable are not always fully used
  // add a blanket unused statement to handle lint waivers
  logic unused_wdata;
  logic unused_be;
  assign unused_wdata = ^reg_wdata;
  assign unused_be = ^reg_be;

  // Assertions for Register Interface
  `ASSERT(en2addrHit, (reg_we || reg_re) |-> $onehot0(addr_hit))

endmodule

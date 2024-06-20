/* Copyright 2018 ETH Zurich and University of Bologna.
 * Copyright 2022 PlanV GmbH
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the “License”); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */

 `include "ace/typedef.svh"
 `include "ace/assign.svh"

package ariane_ace_soc;

  import cv64a6_imafdch_wb_sv39_alsaqr_pkg::CVA6AXIIdWidth;
  import ariane_axi_soc::AddrWidth;
  import ariane_axi_soc::DataWidth;
  import ariane_axi_soc::StrbWidth;
  import ariane_axi_soc::UserWidth;
  import ariane_axi_soc::StrbWidth;

  typedef logic [CVA6AXIIdWidth-1:0] ariane_axi_id_t;
  typedef logic [AddrWidth-1:0]      ariane_axi_addr_t;
  typedef logic [DataWidth-1:0]      ariane_axi_data_t;
  typedef logic [UserWidth-1:0]      ariane_axi_user_t;
  typedef logic [StrbWidth-1:0]      ariane_axi_strb_t;

  // W and B channel remain untouched compared to AXI
  typedef ariane_axi_soc::w_chan_t w_chan_t;
  typedef ariane_axi_soc::b_chan_t b_chan_t;

  // AW Channel
  `ACE_TYPEDEF_AW_CHAN_T(aw_chan_t, ariane_axi_addr_t, ariane_axi_id_t, ariane_axi_user_t)

  // AR Channel
  `ACE_TYPEDEF_AR_CHAN_T(ar_chan_t, ariane_axi_addr_t, ariane_axi_id_t, ariane_axi_user_t)

  // R Channel
  `ACE_TYPEDEF_R_CHAN_T(r_chan_t, ariane_axi_addr_t, ariane_axi_id_t, ariane_axi_user_t)

  // AC Channel
  `SNOOP_TYPEDEF_AC_CHAN_T(ac_chan_t, ariane_axi_addr_t)

  // CD Channel
  `SNOOP_TYPEDEF_CD_CHAN_T(cd_chan_t, ariane_axi_addr_t)

  // CR Channel
  `SNOOP_TYPEDEF_CR_CHAN_T(cr_chan_t)

  // Request/Response structs
  typedef struct packed {
    aw_chan_t             aw;
    logic                 aw_valid;
    w_chan_t              w;
    logic                 w_valid;
    logic                 b_ready;
    ar_chan_t             ar;
    logic                 ar_valid;
    logic                 r_ready;
    logic                 wack;
    logic                 rack;
    // Snoop signals are reversed w.r.t. request / response
    logic                 ac_ready;
    logic                 cr_valid;
    cr_chan_t             cr_resp;
    logic                 cd_valid;
    cd_chan_t             cd;
  } req_t;

  `ACE_TYPEDEF_REQ_T(req_nosnoop_t, aw_chan_t, w_chan_t, ar_chan_t)

  `SNOOP_TYPEDEF_REQ_T(snoop_req_t, ac_chan_t)

  typedef struct packed {
    logic                aw_ready;
    logic                ar_ready;
    logic                w_ready;
    logic                b_valid;
    b_chan_t             b;
    logic                r_valid;
    r_chan_t             r;
    // Snoop signals are reversed w.r.t. request / response
    ac_chan_t            ac;
    logic                ac_valid;
    logic                cr_ready;
    logic                cd_ready;
  } resp_t;

  `AXI_TYPEDEF_RESP_T(resp_nosnoop_t, b_chan_t, r_chan_t)

  `SNOOP_TYPEDEF_RESP_T(snoop_resp_t, cd_chan_t, cr_chan_t)

endpackage

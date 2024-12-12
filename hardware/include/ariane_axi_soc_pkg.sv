/* Copyright 2018 ETH Zurich and University of Bologna.
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the “License”); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * File:   ariane_axi_soc_pkg.sv
 * Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>
 * Date:   17.8.2018
 *
 * Description: Contains Ariane's AXI ports on SoC, does not contain user ports
 */

package ariane_axi_soc;

    // used in axi_adapter.sv
    typedef enum logic { SINGLE_REQ, CACHE_LINE_REQ } ad_req_t;

   `ifdef QUAD_CORE
    localparam UserWidth = 2;
   `else
    localparam UserWidth = 1;
   `endif
    localparam AddrWidth = 64;
    localparam DataWidth = 64;
    localparam StrbWidth = DataWidth / 8;

    typedef logic [ariane_soc::IdWidth-1:0]      id_t;
    typedef logic [ariane_soc::IdWidthSlave-1:0] id_slv_t;
    typedef logic [ariane_soc::IdWidthSlave:0]   id_slv_mem_t;
    typedef logic [AddrWidth-1:0] addr_t;
    typedef logic [DataWidth-1:0] data_t;
    typedef logic [StrbWidth-1:0] strb_t;
    typedef logic [UserWidth-1:0] user_t;

    // AXI extension for untranslated transactions - IOMMU (Chapter A14)
    typedef logic [23:0]    sid_t;
    typedef logic           ssidv_t;
    typedef logic [19:0]    ssid_t;

    // AXI Aditional Request Qualifiers - IOPMP (Chapter A11)
    typedef logic [3:0]     nsaid_t;

    // AW Channel
    typedef struct packed {
        id_t              id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        axi_pkg::atop_t   atop;
        user_t            user;
    } aw_chan_t;

    // AW Channel - Slave
    typedef struct packed {
        id_slv_t          id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        axi_pkg::atop_t   atop;
        user_t            user;
    } aw_chan_slv_t;

    typedef struct packed {
        id_slv_mem_t      id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        axi_pkg::atop_t   atop;
        user_t            user;
    } aw_chan_slv_mem_t;

    // AW Channel - AXI Standard Extensions
    typedef struct packed {
        id_t              id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        axi_pkg::atop_t   atop;
        user_t            user;
        sid_t             stream_id;
        ssidv_t           ss_id_valid;
        ssid_t            substream_id;
        nsaid_t           nsaid;
    } aw_chan_ext_t;

    // W Channel - AXI4 doesn't define a wid
    typedef struct packed {
        data_t data;
        strb_t strb;
        logic  last;
        user_t user;
    } w_chan_t;

    // B Channel
    typedef struct packed {
        id_t            id;
        axi_pkg::resp_t resp;
        user_t          user;
    } b_chan_t;

    // B Channel - Slave
    typedef struct packed {
        id_slv_t        id;
        axi_pkg::resp_t resp;
        user_t          user;
    } b_chan_slv_t;

    typedef struct packed {
        id_slv_mem_t    id;
        axi_pkg::resp_t resp;
        user_t          user;
    } b_chan_slv_mem_t;

    // AR Channel
    typedef struct packed {
        id_t             id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        user_t            user;
    } ar_chan_t;

    // AR Channel - Slave
    typedef struct packed {
        id_slv_t          id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        user_t            user;
    } ar_chan_slv_t;

    // AR Channel - Slave
    typedef struct packed {
        id_slv_mem_t      id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        user_t            user;
    } ar_chan_slv_mem_t;

    // AR Channel - AXI Standard Extensions
    typedef struct packed {
        id_t              id;
        addr_t            addr;
        axi_pkg::len_t    len;
        axi_pkg::size_t   size;
        axi_pkg::burst_t  burst;
        logic             lock;
        axi_pkg::cache_t  cache;
        axi_pkg::prot_t   prot;
        axi_pkg::qos_t    qos;
        axi_pkg::region_t region;
        user_t            user;
        sid_t             stream_id;
        ssidv_t           ss_id_valid;
        ssid_t            substream_id;
        nsaid_t           nsaid;
    } ar_chan_ext_t;

    // R Channel
    typedef struct packed {
        id_t            id;
        data_t          data;
        axi_pkg::resp_t resp;
        logic           last;
        user_t          user;
    } r_chan_t;

    // R Channel - Slave
    typedef struct packed {
        id_slv_t        id;
        data_t          data;
        axi_pkg::resp_t resp;
        logic           last;
        user_t          user;
    } r_chan_slv_t;

    // R Channel
    typedef struct packed {
        id_slv_mem_t    id;
        data_t          data;
        axi_pkg::resp_t resp;
        logic           last;
        user_t          user;
    } r_chan_slv_mem_t;

    // Request/Response structs
    typedef struct packed {
        aw_chan_t aw;
        logic     aw_valid;
        w_chan_t  w;
        logic     w_valid;
        logic     b_ready;
        ar_chan_t ar;
        logic     ar_valid;
        logic     r_ready;
    } req_t;

    typedef struct packed {
        logic     aw_ready;
        logic     ar_ready;
        logic     w_ready;
        logic     b_valid;
        b_chan_t  b;
        logic     r_valid;
        r_chan_t  r;
    } resp_t;

    typedef struct packed {
        aw_chan_slv_t aw;
        logic         aw_valid;
        w_chan_t      w;
        logic         w_valid;
        logic         b_ready;
        ar_chan_slv_t ar;
        logic         ar_valid;
        logic         r_ready;
    } req_slv_t;

    typedef struct packed {
        logic         aw_ready;
        logic         ar_ready;
        logic         w_ready;
        logic         b_valid;
        b_chan_slv_t  b;
        logic         r_valid;
        r_chan_slv_t  r;
    } resp_slv_t;

    typedef struct packed {
        aw_chan_slv_mem_t aw;
        logic             aw_valid;
        w_chan_t          w;
        logic             w_valid;
        logic             b_ready;
        ar_chan_slv_mem_t ar;
        logic             ar_valid;
        logic             r_ready;
    } req_slv_mem_t;

    typedef struct packed {
        logic             aw_ready;
        logic             ar_ready;
        logic             w_ready;
        logic             b_valid;
        b_chan_slv_mem_t  b;
        logic             r_valid;
        r_chan_slv_mem_t  r;
    } resp_slv_mem_t;

    // AXI Request struct with standard extensions
    typedef struct packed {
        aw_chan_ext_t   aw;
        logic           aw_valid;
        w_chan_t        w;
        logic           w_valid;
        logic           b_ready;
        ar_chan_ext_t   ar;
        logic           ar_valid;
        logic           r_ready;
    } req_ext_t;


    localparam LiteAddrWidth = 32;
    localparam LiteDataWidth = 32;
    localparam LiteStrbWidth = LiteDataWidth / 8;

    typedef logic [LiteAddrWidth-1:0] lite_addr_t;
    typedef logic [LiteDataWidth-1:0] lite_data_t;
    typedef logic [LiteStrbWidth-1:0] lite_strb_t;

    typedef struct packed {
      lite_addr_t     addr;
      axi_pkg::prot_t prot;
    } aw_chan_lite_t;

    typedef struct packed {
      lite_data_t   data;
      lite_strb_t   strb;
    } w_chan_lite_t;

    typedef struct packed {
      axi_pkg::resp_t resp;
    } b_chan_lite_t;

    typedef struct packed {
      lite_addr_t     addr;
      axi_pkg::prot_t prot;
    } ar_chan_lite_t;

    typedef struct packed {
      lite_data_t     data;
      axi_pkg::resp_t resp;
    } r_chan_lite_t;

    typedef struct packed {
      aw_chan_lite_t aw;
      logic          aw_valid;
      w_chan_lite_t  w;
      logic          w_valid;
      logic          b_ready;
      ar_chan_lite_t ar;
      logic          ar_valid;
      logic          r_ready;
    } req_lite_t;

    typedef struct packed {
      logic          aw_ready;
      logic          w_ready;
      b_chan_lite_t  b;
      logic          b_valid;
      logic          ar_ready;
      r_chan_lite_t  r;
      logic          r_valid;
    } resp_lite_t;

endpackage

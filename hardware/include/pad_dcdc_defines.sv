// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`define PAD_INST(pat)                              \
  IN22FDX_GPIO18_10M19S40PI_IO_H ku_dcdc_``pat`` (  \
    .PAD     ( pad_ku_dcdc_``pat``     ),          \
    .DATA    ( s_data_ku_dcdc_``pat``  ),          \
    .Y       ( s_y_ku_dcdc_``pat``     ),          \
    .TRIEN   ( s_trien_ku_dcdc_``pat`` ),          \
    .RXEN    ( s_rxen_ku_dcdc_``pat``  ),          \
    .PUEN    ( s_puen_ku_dcdc_``pat``  ),          \
    .PDEN    ( s_pden_ku_dcdc_``pat``  ),          \
    .NDIN    ( s_ndin_ku_dcdc_``pat``  ),          \
    .NDOUT   ( s_ndout_ku_dcdc_``pat`` ),          \
    .DRV     ( s_drv_ku_dcdc_``pat``   ),          \
    .SLW     ( s_slw_ku_dcdc_``pat``   ),          \
    .SMT     ( s_smt_ku_dcdc_``pat``   ), .PWORK ( PWROK_S ), .IOPWROK ( IOPWROK_S ), .BIAS ( BIAS_S ), .RETC ( RETC_S ) );

`define DECLARE_LOGIC(pat) \
    logic        s_data_ku_dcdc_``pat`` ;          \
    logic        s_y_ku_dcdc_``pat``    ;          \
    logic        s_trien_ku_dcdc_``pat``;          \
    logic        s_rxen_ku_dcdc_``pat`` ;          \
    logic        s_puen_ku_dcdc_``pat`` ;          \
    logic        s_pden_ku_dcdc_``pat`` ;          \
    logic        s_ndin_ku_dcdc_``pat`` ;          \
    logic        s_ndout_ku_dcdc_``pat``;          \
    logic [1:0]  s_drv_ku_dcdc_``pat``  ;          \
    logic        s_slw_ku_dcdc_``pat``  ;          \
    logic        s_smt_ku_dcdc_``pat``  ;          
      
`define CONNECT_PAD(pat) \
    .data_``pat``_o  ( s_data_ku_dcdc_``pat``  ),          \
    .y_``pat``_i     ( s_y_ku_dcdc_``pat``     ),          \
    .trien_``pat``_o ( s_trien_ku_dcdc_``pat`` ),          \
    .rxen_``pat``_o  ( s_rxen_ku_dcdc_``pat``  ),          \
    .puen_``pat``_o  ( s_puen_ku_dcdc_``pat``  ),          \
    .pden_``pat``_o  ( s_pden_ku_dcdc_``pat``  ),          \
    .ndind_``pat``_o ( s_ndin_ku_dcdc_``pat``  ),          \
    .ndout_``pat``_i ( s_ndout_ku_dcdc_``pat`` ),          \
    .drv_``pat``_o   ( s_drv_ku_dcdc_``pat``   ),          \
    .slw_``pat``_o   ( s_slw_ku_dcdc_``pat``   ),          \
    .smt_``pat``_o   ( s_smt_ku_dcdc_``pat``   )           

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
  IN22FDX_GPIO18_10M3S40PI_IO_H ku_dcdc_``pat`` (  \
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
    .SMT     ( s_smt_ku_dcdc_``pat``   ),          \
    .PWORK   ( PWROK_S                 ),          \
    .IOPWROK ( IOPWROK_S               ),          \
    .BIAS    ( BIAS_S                  ),          \ 
    .RETC    ( RETC_S                  )           \
    );

`define DECLARE_LOGIC(pat)
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
    logic        s_smt_ku_dcdc_``pat``  ;          \
      
`define CONNECT_PAD(pat)
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
    .smt_``pat``_o   ( s_smt_ku_dcdc_``pat``   )           \

module khalifa_dcdc (
       // ANALOG SIGNALS
       inout logic        ku_dcdc_vdd_b    ,
       inout logic        ku_dcdc_vdd_r250 ,
       inout logic        ku_dcdc_vref_b   ,
       inout logic        ku_dcdc_vref_r250,
       inout logic        ku_dcdc_vout_b   ,
       inout logic        ku_dcdc_vout_r250,
       // DIGITAL PADS
       output logic       data_control_1_o , 
       input logic        y_control_1_i    ,    
       output logic       trien_control_1_o,
       output logic       rxen_control_1_o , 
       output logic       puen_control_1_o , 
       output logic       pden_control_1_o , 
       output logic       ndind_control_1_o,
       input logic        ndout_control_1_i,
       output logic [1:0] drv_control_1_o  ,  
       output logic       slw_control_1_o  ,  
       output logic       smt_control_1_o  ,

       output logic       data_control_2_o , 
       input logic        y_control_2_i    ,    
       output logic       trien_control_2_o,
       output logic       rxen_control_2_o , 
       output logic       puen_control_2_o , 
       output logic       pden_control_2_o , 
       output logic       ndind_control_2_o,
       input logic        ndout_control_2_i,
       output logic [1:0] drv_control_2_o  ,  
       output logic       slw_control_2_o  ,  
       output logic       smt_control_2_o  ,

       output logic       data_clk_ext_o   , 
       input logic        y_clk_ext_i      ,    
       output logic       trien_clk_ext_o  ,
       output logic       rxen_clk_ext_o   , 
       output logic       puen_clk_ext_o   , 
       output logic       pden_clk_ext_o   , 
       output logic       ndind_clk_ext_o  ,
       input logic        ndout_clk_ext_i  ,
       output logic [1:0] drv_clk_ext_o    ,  
       output logic       slw_clk_ext_o    ,  
       output logic       smt_clk_ext_o    ,

       output logic       data_sel_clk_o   , 
       input logic        y_sel_clk_i      ,    
       output logic       trien_sel_clk_o  ,
       output logic       rxen_sel_clk_o   , 
       output logic       puen_sel_clk_o   , 
       output logic       pden_sel_clk_o   , 
       output logic       ndind_sel_clk_o  ,
       input logic        ndout_sel_clk_i  ,
       output logic [1:0] drv_sel_clk_o    ,  
       output logic       slw_sel_clk_o    ,  
       output logic       smt_sel_clk_o    ,

       output logic       data_SM_ext_o    , 
       input logic        y_SM_ext_i       ,    
       output logic       trien_SM_ext_o   ,
       output logic       rxen_SM_ext_o    , 
       output logic       puen_SM_ext_o    , 
       output logic       pden_SM_ext_o    , 
       output logic       ndind_SM_ext_o   ,
       input logic        ndout_SM_ext_i   ,
       output logic [1:0] drv_SM_ext_o     ,  
       output logic       slw_SM_ext_o     ,  
       output logic       smt_SM_ext_o     ,

       output logic       data_sel_SM_o    , 
       input logic        y_sel_SM_i       ,    
       output logic       trien_sel_SM_o   ,
       output logic       rxen_sel_SM_o    , 
       output logic       puen_sel_SM_o    , 
       output logic       pden_sel_SM_o    , 
       output logic       ndind_sel_SM_o   ,
       input logic        ndout_sel_SM_i   ,
       output logic [1:0] drv_sel_SM_o     ,  
       output logic       slw_sel_SM_o     ,  
       output logic       smt_sel_SM_o     ,

       output logic       data_PFM_out_o   , 
       input logic        y_PFM_out_i      ,    
       output logic       trien_PFM_out_o  ,
       output logic       rxen_PFM_out_o   , 
       output logic       puen_PFM_out_o   , 
       output logic       pden_PFM_out_o   , 
       output logic       ndind_PFM_out_o  ,
       input logic        ndout_PFM_out_i  ,
       output logic [1:0] drv_PFM_out_o    ,  
       output logic       slw_PFM_out_o    ,  
       output logic       smt_PFM_out_o                     
)

endmodule

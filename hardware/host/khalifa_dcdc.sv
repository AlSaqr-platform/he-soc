// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`ifndef TARGET_ASIC
module  IN22FDX_GPIO18_10M3S40PI_IO_H ( 

  input       TRIEN,
  input       NDIN,
  input [1:0] DRV,
  inout       PAD,
  inout       PWROK,
  output      Y,
  input       RXEN,
  input       PDEN,
  input       DATA,
  inout       IOPWROK,
  output      NDOUT,
  input       PUEN,
  inout       RETC,
  inout       BIAS,
  input       SMT,
  input       SLW);
   
endmodule
`endif
                                        
(* dont_touch = "true" *) 
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
     );
   

endmodule

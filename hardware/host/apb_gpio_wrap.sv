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
// Author: Mattia Sinigaglia, University of Bologna
// Date: 05/11/2021
// Description: Wrapper APB GPIO 
//              

module apb_gpio_wrap
  import udma_subsystem_pkg::*;
  import gpio_pkg::*; 
  import pkg_alsaqr_periph_padframe::*; 
  #( 
    parameter int unsigned NUM_GPIO   = 64 
  )(
      output logic [NUM_GPIO-1:0]  gpio_in,
      input logic [NUM_GPIO-1:0] gpio_out,
      input logic [NUM_GPIO-1:0] gpio_dir,

      output gpio_to_pad_t        gpio_to_pad,
      input  pad_to_gpio_t        pad_to_gpio,
      input port_signals_pad2soc_t port_signals_pad2soc
  );

    assign gpio_in[0] =  port_signals_pad2soc.periphs.gpio_b.gpio0_o;
    assign gpio_to_pad.gpio0_d_o = gpio_dir[0];
    assign gpio_to_pad.gpio0_o = gpio_out[0];

    assign gpio_in[1] =  port_signals_pad2soc.periphs.gpio_b.gpio1_o;
    assign gpio_to_pad.gpio1_d_o = gpio_dir[1];
    assign gpio_to_pad.gpio1_o = gpio_out[1];

    assign gpio_in[2] =  port_signals_pad2soc.periphs.gpio_b.gpio2_o;
    assign gpio_to_pad.gpio2_d_o = gpio_dir[2];
    assign gpio_to_pad.gpio2_o = gpio_out[2];

    assign gpio_in[3] =  port_signals_pad2soc.periphs.gpio_b.gpio3_o;
    assign gpio_to_pad.gpio3_d_o = gpio_dir[3];
    assign gpio_to_pad.gpio3_o = gpio_out[3];

    assign gpio_in[4] =  port_signals_pad2soc.periphs.gpio_b.gpio4_o;
    assign gpio_to_pad.gpio4_d_o = gpio_dir[4];
    assign gpio_to_pad.gpio4_o = gpio_out[4];

    assign gpio_in[5] =  port_signals_pad2soc.periphs.gpio_b.gpio5_o;
    assign gpio_to_pad.gpio5_d_o = gpio_dir[5];
    assign gpio_to_pad.gpio5_o = gpio_out[5];

    assign gpio_in[6] =  port_signals_pad2soc.periphs.gpio_b.gpio6_o;
    assign gpio_to_pad.gpio6_d_o = gpio_dir[6];
    assign gpio_to_pad.gpio6_o = gpio_out[6];

    assign gpio_in[7] =  port_signals_pad2soc.periphs.gpio_b.gpio7_o;
    assign gpio_to_pad.gpio7_d_o = gpio_dir[7];
    assign gpio_to_pad.gpio7_o = gpio_out[7];

    assign gpio_in[8] =  port_signals_pad2soc.periphs.gpio_b.gpio8_o;
    assign gpio_to_pad.gpio8_d_o = gpio_dir[8];
    assign gpio_to_pad.gpio8_o = gpio_out[8];

    assign gpio_in[9] =  port_signals_pad2soc.periphs.gpio_b.gpio9_o;
    assign gpio_to_pad.gpio9_d_o = gpio_dir[9];
    assign gpio_to_pad.gpio9_o = gpio_out[9];

    assign gpio_in[10] =  port_signals_pad2soc.periphs.gpio_b.gpio10_o;
    assign gpio_to_pad.gpio10_d_o = gpio_dir[10];
    assign gpio_to_pad.gpio10_o = gpio_out[10];

    assign gpio_in[11] =  port_signals_pad2soc.periphs.gpio_b.gpio11_o;
    assign gpio_to_pad.gpio11_d_o = gpio_dir[11];
    assign gpio_to_pad.gpio11_o = gpio_out[11];

    assign gpio_in[12] =  port_signals_pad2soc.periphs.gpio_b.gpio12_o;
    assign gpio_to_pad.gpio12_d_o = gpio_dir[12];
    assign gpio_to_pad.gpio12_o = gpio_out[12];

    assign gpio_in[13] =  port_signals_pad2soc.periphs.gpio_b.gpio13_o;
    assign gpio_to_pad.gpio13_d_o = gpio_dir[13];
    assign gpio_to_pad.gpio13_o = gpio_out[13];

    assign gpio_in[14] =  port_signals_pad2soc.periphs.gpio_b.gpio14_o;
    assign gpio_to_pad.gpio14_d_o = gpio_dir[14];
    assign gpio_to_pad.gpio14_o = gpio_out[14];

    assign gpio_in[15] =  port_signals_pad2soc.periphs.gpio_b.gpio15_o;
    assign gpio_to_pad.gpio15_d_o = gpio_dir[15];
    assign gpio_to_pad.gpio15_o = gpio_out[15];

    assign gpio_in[16] =  port_signals_pad2soc.periphs.gpio_b.gpio16_o;
    assign gpio_to_pad.gpio16_d_o = gpio_dir[16];
    assign gpio_to_pad.gpio16_o = gpio_out[16];

    assign gpio_in[17] =  port_signals_pad2soc.periphs.gpio_b.gpio17_o;
    assign gpio_to_pad.gpio17_d_o = gpio_dir[17];
    assign gpio_to_pad.gpio17_o = gpio_out[17];

    assign gpio_in[18] =  port_signals_pad2soc.periphs.gpio_b.gpio18_o;
    assign gpio_to_pad.gpio18_d_o = gpio_dir[18];
    assign gpio_to_pad.gpio18_o = gpio_out[18];

    assign gpio_in[19] =  port_signals_pad2soc.periphs.gpio_b.gpio19_o;
    assign gpio_to_pad.gpio19_d_o = gpio_dir[19];
    assign gpio_to_pad.gpio19_o = gpio_out[19];

    assign gpio_in[20] =  port_signals_pad2soc.periphs.gpio_b.gpio20_o;
    assign gpio_to_pad.gpio20_d_o = gpio_dir[20];
    assign gpio_to_pad.gpio20_o = gpio_out[20];

    assign gpio_in[21] =  port_signals_pad2soc.periphs.gpio_b.gpio21_o;
    assign gpio_to_pad.gpio21_d_o = gpio_dir[21];
    assign gpio_to_pad.gpio21_o = gpio_out[21];

    assign gpio_in[22] =  port_signals_pad2soc.periphs.gpio_b.gpio22_o;
    assign gpio_to_pad.gpio22_d_o = gpio_dir[22];
    assign gpio_to_pad.gpio22_o = gpio_out[22];

    assign gpio_in[23] =  port_signals_pad2soc.periphs.gpio_b.gpio23_o;
    assign gpio_to_pad.gpio23_d_o = gpio_dir[23];
    assign gpio_to_pad.gpio23_o = gpio_out[23];

    assign gpio_in[24] =  port_signals_pad2soc.periphs.gpio_b.gpio24_o;
    assign gpio_to_pad.gpio24_d_o = gpio_dir[24];
    assign gpio_to_pad.gpio24_o = gpio_out[24];

    assign gpio_in[25] =  port_signals_pad2soc.periphs.gpio_b.gpio25_o;
    assign gpio_to_pad.gpio25_d_o = gpio_dir[25];
    assign gpio_to_pad.gpio25_o = gpio_out[25];

    assign gpio_in[26] =  port_signals_pad2soc.periphs.gpio_b.gpio26_o;
    assign gpio_to_pad.gpio26_d_o = gpio_dir[26];
    assign gpio_to_pad.gpio26_o = gpio_out[26];

    assign gpio_in[27] =  port_signals_pad2soc.periphs.gpio_b.gpio27_o;
    assign gpio_to_pad.gpio27_d_o = gpio_dir[27];
    assign gpio_to_pad.gpio27_o = gpio_out[27];

    assign gpio_in[28] =  port_signals_pad2soc.periphs.gpio_b.gpio28_o;
    assign gpio_to_pad.gpio28_d_o = gpio_dir[28];
    assign gpio_to_pad.gpio28_o = gpio_out[28];

    assign gpio_in[29] =  port_signals_pad2soc.periphs.gpio_b.gpio29_o;
    assign gpio_to_pad.gpio29_d_o = gpio_dir[29];
    assign gpio_to_pad.gpio29_o = gpio_out[29];

    assign gpio_in[30] =  port_signals_pad2soc.periphs.gpio_b.gpio30_o;
    assign gpio_to_pad.gpio30_d_o = gpio_dir[30];
    assign gpio_to_pad.gpio30_o = gpio_out[30];

    assign gpio_in[31] =  port_signals_pad2soc.periphs.gpio_b.gpio31_o;
    assign gpio_to_pad.gpio31_d_o = gpio_dir[31];
    assign gpio_to_pad.gpio31_o = gpio_out[31];

    assign gpio_in[32] =  port_signals_pad2soc.periphs.gpio_b.gpio32_o;
    assign gpio_to_pad.gpio32_d_o = gpio_dir[32];
    assign gpio_to_pad.gpio32_o = gpio_out[32];

    assign gpio_in[33] =  port_signals_pad2soc.periphs.gpio_b.gpio33_o;
    assign gpio_to_pad.gpio33_d_o = gpio_dir[33];
    assign gpio_to_pad.gpio33_o = gpio_out[33];

    assign gpio_in[34] =  port_signals_pad2soc.periphs.gpio_b.gpio34_o;
    assign gpio_to_pad.gpio34_d_o = gpio_dir[34];
    assign gpio_to_pad.gpio34_o = gpio_out[34];

    assign gpio_in[35] =  port_signals_pad2soc.periphs.gpio_b.gpio35_o;
    assign gpio_to_pad.gpio35_d_o = gpio_dir[35];
    assign gpio_to_pad.gpio35_o = gpio_out[35];

    assign gpio_in[36] =  port_signals_pad2soc.periphs.gpio_b.gpio36_o;
    assign gpio_to_pad.gpio36_d_o = gpio_dir[36];
    assign gpio_to_pad.gpio36_o = gpio_out[36];

    assign gpio_in[37] =  port_signals_pad2soc.periphs.gpio_b.gpio37_o;
    assign gpio_to_pad.gpio37_d_o = gpio_dir[37];
    assign gpio_to_pad.gpio37_o = gpio_out[37];

    assign gpio_in[38] =  port_signals_pad2soc.periphs.gpio_b.gpio38_o;
    assign gpio_to_pad.gpio38_d_o = gpio_dir[38];
    assign gpio_to_pad.gpio38_o = gpio_out[38];

    assign gpio_in[39] =  port_signals_pad2soc.periphs.gpio_b.gpio39_o;
    assign gpio_to_pad.gpio39_d_o = gpio_dir[39];
    assign gpio_to_pad.gpio39_o = gpio_out[39];

    assign gpio_in[40] =  port_signals_pad2soc.periphs.gpio_b.gpio40_o;
    assign gpio_to_pad.gpio40_d_o = gpio_dir[40];
    assign gpio_to_pad.gpio40_o = gpio_out[40];

    assign gpio_in[41] =  port_signals_pad2soc.periphs.gpio_b.gpio41_o;
    assign gpio_to_pad.gpio41_d_o = gpio_dir[41];
    assign gpio_to_pad.gpio41_o = gpio_out[41];

    assign gpio_in[42] =  port_signals_pad2soc.periphs.gpio_b.gpio42_o;
    assign gpio_to_pad.gpio42_d_o = gpio_dir[42];
    assign gpio_to_pad.gpio42_o = gpio_out[42];

    assign gpio_in[43] =  port_signals_pad2soc.periphs.gpio_b.gpio43_o;
    assign gpio_to_pad.gpio43_d_o = gpio_dir[43];
    assign gpio_to_pad.gpio43_o = gpio_out[43];

    assign gpio_in[44] =  port_signals_pad2soc.periphs.gpio_b.gpio44_o;
    assign gpio_to_pad.gpio44_d_o = gpio_dir[44];
    assign gpio_to_pad.gpio44_o = gpio_out[44];

    assign gpio_in[45] =  port_signals_pad2soc.periphs.gpio_b.gpio45_o;
    assign gpio_to_pad.gpio45_d_o = gpio_dir[45];
    assign gpio_to_pad.gpio45_o = gpio_out[45];

    assign gpio_in[46] =  port_signals_pad2soc.periphs.gpio_b.gpio46_o;
    assign gpio_to_pad.gpio46_d_o = gpio_dir[46];
    assign gpio_to_pad.gpio46_o = gpio_out[46];

    assign gpio_in[47] =  port_signals_pad2soc.periphs.gpio_b.gpio47_o;
    assign gpio_to_pad.gpio47_d_o = gpio_dir[47];
    assign gpio_to_pad.gpio47_o = gpio_out[47];

    assign gpio_in[48] =  port_signals_pad2soc.periphs.gpio_b.gpio48_o;
    assign gpio_to_pad.gpio48_d_o = gpio_dir[48];
    assign gpio_to_pad.gpio48_o = gpio_out[48];

    assign gpio_in[49] =  port_signals_pad2soc.periphs.gpio_b.gpio49_o;
    assign gpio_to_pad.gpio49_d_o = gpio_dir[49];
    assign gpio_to_pad.gpio49_o = gpio_out[49];

    assign gpio_in[50] =  port_signals_pad2soc.periphs.gpio_b.gpio50_o;
    assign gpio_to_pad.gpio50_d_o = gpio_dir[50];
    assign gpio_to_pad.gpio50_o = gpio_out[50];

    assign gpio_in[51] =  port_signals_pad2soc.periphs.gpio_b.gpio51_o;
    assign gpio_to_pad.gpio51_d_o = gpio_dir[51];
    assign gpio_to_pad.gpio51_o = gpio_out[51];

    assign gpio_in[52] =  port_signals_pad2soc.periphs.gpio_b.gpio52_o;
    assign gpio_to_pad.gpio52_d_o = gpio_dir[52];
    assign gpio_to_pad.gpio52_o = gpio_out[52];

    assign gpio_in[53] =  port_signals_pad2soc.periphs.gpio_b.gpio53_o;
    assign gpio_to_pad.gpio53_d_o = gpio_dir[53];
    assign gpio_to_pad.gpio53_o = gpio_out[53];

    assign gpio_in[54] =  port_signals_pad2soc.periphs.gpio_b.gpio54_o;
    assign gpio_to_pad.gpio54_d_o = gpio_dir[54];
    assign gpio_to_pad.gpio54_o = gpio_out[54];

    assign gpio_in[55] =  port_signals_pad2soc.periphs.gpio_b.gpio55_o;
    assign gpio_to_pad.gpio55_d_o = gpio_dir[55];
    assign gpio_to_pad.gpio55_o = gpio_out[55];

    assign gpio_in[56] =  port_signals_pad2soc.periphs.gpio_b.gpio56_o;
    assign gpio_to_pad.gpio56_d_o = gpio_dir[56];
    assign gpio_to_pad.gpio56_o = gpio_out[56];

    assign gpio_in[57] =  port_signals_pad2soc.periphs.gpio_b.gpio57_o;
    assign gpio_to_pad.gpio57_d_o = gpio_dir[57];
    assign gpio_to_pad.gpio57_o = gpio_out[57];

    assign gpio_in[58] =  port_signals_pad2soc.periphs.gpio_b.gpio58_o;
    assign gpio_to_pad.gpio58_d_o = gpio_dir[58];
    assign gpio_to_pad.gpio58_o = gpio_out[58];

    assign gpio_in[59] =  port_signals_pad2soc.periphs.gpio_b.gpio59_o;
    assign gpio_to_pad.gpio59_d_o = gpio_dir[59];
    assign gpio_to_pad.gpio59_o = gpio_out[59];

    assign gpio_in[60] =  port_signals_pad2soc.periphs.gpio_b.gpio60_o;
    assign gpio_to_pad.gpio60_d_o = gpio_dir[60];
    assign gpio_to_pad.gpio60_o = gpio_out[60];

    assign gpio_in[61] =  port_signals_pad2soc.periphs.gpio_b.gpio61_o;
    assign gpio_to_pad.gpio61_d_o = gpio_dir[61];
    assign gpio_to_pad.gpio61_o = gpio_out[61];
  
endmodule

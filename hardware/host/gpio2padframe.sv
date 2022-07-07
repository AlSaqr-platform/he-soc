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

module gpio2padframe
  import udma_subsystem_pkg::*;
  import gpio_pkg::*; 
  `ifndef FPGA_EMUL
    `ifndef SIMPLE_PADFRAME
        import pkg_alsaqr_periph_padframe::*;
      `else
        import pkg_alsaqr_periph_fpga_padframe::*; 
      `endif
  `else
      import pkg_alsaqr_periph_fpga_padframe::*; 
  `endif
  #( 
    parameter int unsigned NUM_GPIO   = 64 
  )(

    output logic [NUM_GPIO-1:0] gpio_in,
    input  logic [NUM_GPIO-1:0] gpio_out,
    input  logic [NUM_GPIO-1:0] gpio_dir,

    output gpio_to_pad_t        gpio_to_pad,
    input  pad_to_gpio_t        pad_to_gpio
  );

    assign gpio_in[0] =  pad_to_gpio.gpio0_i;
    assign gpio_to_pad.gpio0_d_o = gpio_dir[0];
    assign gpio_to_pad.gpio0_o = gpio_out[0];

    assign gpio_in[1] =  pad_to_gpio.gpio1_i;
    assign gpio_to_pad.gpio1_d_o = gpio_dir[1];
    assign gpio_to_pad.gpio1_o = gpio_out[1];

    assign gpio_in[2] =  pad_to_gpio.gpio2_i;
    assign gpio_to_pad.gpio2_d_o = gpio_dir[2];
    assign gpio_to_pad.gpio2_o = gpio_out[2];

    assign gpio_in[3] =  pad_to_gpio.gpio3_i;
    assign gpio_to_pad.gpio3_d_o = gpio_dir[3];
    assign gpio_to_pad.gpio3_o = gpio_out[3];

    assign gpio_in[4] =  pad_to_gpio.gpio4_i;
    assign gpio_to_pad.gpio4_d_o = gpio_dir[4];
    assign gpio_to_pad.gpio4_o = gpio_out[4];

    assign gpio_in[5] =  pad_to_gpio.gpio5_i;
    assign gpio_to_pad.gpio5_d_o = gpio_dir[5];
    assign gpio_to_pad.gpio5_o = gpio_out[5];

    assign gpio_in[6] =  pad_to_gpio.gpio6_i;
    assign gpio_to_pad.gpio6_d_o = gpio_dir[6];
    assign gpio_to_pad.gpio6_o = gpio_out[6];

    assign gpio_in[7] =  pad_to_gpio.gpio7_i;
    assign gpio_to_pad.gpio7_d_o = gpio_dir[7];
    assign gpio_to_pad.gpio7_o = gpio_out[7];

    assign gpio_in[8] =  pad_to_gpio.gpio8_i;
    assign gpio_to_pad.gpio8_d_o = gpio_dir[8];
    assign gpio_to_pad.gpio8_o = gpio_out[8];

    assign gpio_in[9] =  pad_to_gpio.gpio9_i;
    assign gpio_to_pad.gpio9_d_o = gpio_dir[9];
    assign gpio_to_pad.gpio9_o = gpio_out[9];

    assign gpio_in[10] =  pad_to_gpio.gpio10_i;
    assign gpio_to_pad.gpio10_d_o = gpio_dir[10];
    assign gpio_to_pad.gpio10_o = gpio_out[10];

    assign gpio_in[11] =  pad_to_gpio.gpio11_i;
    assign gpio_to_pad.gpio11_d_o = gpio_dir[11];
    assign gpio_to_pad.gpio11_o = gpio_out[11];

    assign gpio_in[12] =  pad_to_gpio.gpio12_i;
    assign gpio_to_pad.gpio12_d_o = gpio_dir[12];
    assign gpio_to_pad.gpio12_o = gpio_out[12];

    assign gpio_in[13] =  pad_to_gpio.gpio13_i;
    assign gpio_to_pad.gpio13_d_o = gpio_dir[13];
    assign gpio_to_pad.gpio13_o = gpio_out[13];

    assign gpio_in[14] =  pad_to_gpio.gpio14_i;
    assign gpio_to_pad.gpio14_d_o = gpio_dir[14];
    assign gpio_to_pad.gpio14_o = gpio_out[14];

    assign gpio_in[15] =  pad_to_gpio.gpio15_i;
    assign gpio_to_pad.gpio15_d_o = gpio_dir[15];
    assign gpio_to_pad.gpio15_o = gpio_out[15];

    assign gpio_in[16] =  pad_to_gpio.gpio16_i;
    assign gpio_to_pad.gpio16_d_o = gpio_dir[16];
    assign gpio_to_pad.gpio16_o = gpio_out[16];

    assign gpio_in[17] =  pad_to_gpio.gpio17_i;
    assign gpio_to_pad.gpio17_d_o = gpio_dir[17];
    assign gpio_to_pad.gpio17_o = gpio_out[17];

    assign gpio_in[18] =  pad_to_gpio.gpio18_i;
    assign gpio_to_pad.gpio18_d_o = gpio_dir[18];
    assign gpio_to_pad.gpio18_o = gpio_out[18];

    assign gpio_in[19] =  pad_to_gpio.gpio19_i;
    assign gpio_to_pad.gpio19_d_o = gpio_dir[19];
    assign gpio_to_pad.gpio19_o = gpio_out[19];

    assign gpio_in[20] =  pad_to_gpio.gpio20_i;
    assign gpio_to_pad.gpio20_d_o = gpio_dir[20];
    assign gpio_to_pad.gpio20_o = gpio_out[20];

    assign gpio_in[21] =  pad_to_gpio.gpio21_i;
    assign gpio_to_pad.gpio21_d_o = gpio_dir[21];
    assign gpio_to_pad.gpio21_o = gpio_out[21];

    assign gpio_in[22] =  pad_to_gpio.gpio22_i;
    assign gpio_to_pad.gpio22_d_o = gpio_dir[22];
    assign gpio_to_pad.gpio22_o = gpio_out[22];

    assign gpio_in[23] =  pad_to_gpio.gpio23_i;
    assign gpio_to_pad.gpio23_d_o = gpio_dir[23];
    assign gpio_to_pad.gpio23_o = gpio_out[23];

    assign gpio_in[24] =  pad_to_gpio.gpio24_i;
    assign gpio_to_pad.gpio24_d_o = gpio_dir[24];
    assign gpio_to_pad.gpio24_o = gpio_out[24];

    assign gpio_in[25] =  pad_to_gpio.gpio25_i;
    assign gpio_to_pad.gpio25_d_o = gpio_dir[25];
    assign gpio_to_pad.gpio25_o = gpio_out[25];

    assign gpio_in[26] =  pad_to_gpio.gpio26_i;
    assign gpio_to_pad.gpio26_d_o = gpio_dir[26];
    assign gpio_to_pad.gpio26_o = gpio_out[26];

    assign gpio_in[27] =  pad_to_gpio.gpio27_i;
    assign gpio_to_pad.gpio27_d_o = gpio_dir[27];
    assign gpio_to_pad.gpio27_o = gpio_out[27];

    assign gpio_in[28] =  pad_to_gpio.gpio28_i;
    assign gpio_to_pad.gpio28_d_o = gpio_dir[28];
    assign gpio_to_pad.gpio28_o = gpio_out[28];

    assign gpio_in[29] =  pad_to_gpio.gpio29_i;
    assign gpio_to_pad.gpio29_d_o = gpio_dir[29];
    assign gpio_to_pad.gpio29_o = gpio_out[29];

    assign gpio_in[30] =  pad_to_gpio.gpio30_i;
    assign gpio_to_pad.gpio30_d_o = gpio_dir[30];
    assign gpio_to_pad.gpio30_o = gpio_out[30];

    assign gpio_in[31] =  pad_to_gpio.gpio31_i;
    assign gpio_to_pad.gpio31_d_o = gpio_dir[31];
    assign gpio_to_pad.gpio31_o = gpio_out[31];

    assign gpio_in[32] =  pad_to_gpio.gpio32_i;
    assign gpio_to_pad.gpio32_d_o = gpio_dir[32];
    assign gpio_to_pad.gpio32_o = gpio_out[32];

    assign gpio_in[33] =  pad_to_gpio.gpio33_i;
    assign gpio_to_pad.gpio33_d_o = gpio_dir[33];
    assign gpio_to_pad.gpio33_o = gpio_out[33];

    assign gpio_in[34] =  pad_to_gpio.gpio34_i;
    assign gpio_to_pad.gpio34_d_o = gpio_dir[34];
    assign gpio_to_pad.gpio34_o = gpio_out[34];

    assign gpio_in[35] =  pad_to_gpio.gpio35_i;
    assign gpio_to_pad.gpio35_d_o = gpio_dir[35];
    assign gpio_to_pad.gpio35_o = gpio_out[35];

    assign gpio_in[36] =  pad_to_gpio.gpio36_i;
    assign gpio_to_pad.gpio36_d_o = gpio_dir[36];
    assign gpio_to_pad.gpio36_o = gpio_out[36];

    assign gpio_in[37] =  pad_to_gpio.gpio37_i;
    assign gpio_to_pad.gpio37_d_o = gpio_dir[37];
    assign gpio_to_pad.gpio37_o = gpio_out[37];

    assign gpio_in[38] =  pad_to_gpio.gpio38_i;
    assign gpio_to_pad.gpio38_d_o = gpio_dir[38];
    assign gpio_to_pad.gpio38_o = gpio_out[38];

    assign gpio_in[39] =  pad_to_gpio.gpio39_i;
    assign gpio_to_pad.gpio39_d_o = gpio_dir[39];
    assign gpio_to_pad.gpio39_o = gpio_out[39];

    assign gpio_in[40] =  pad_to_gpio.gpio40_i;
    assign gpio_to_pad.gpio40_d_o = gpio_dir[40];
    assign gpio_to_pad.gpio40_o = gpio_out[40];

    assign gpio_in[41] =  pad_to_gpio.gpio41_i;
    assign gpio_to_pad.gpio41_d_o = gpio_dir[41];
    assign gpio_to_pad.gpio41_o = gpio_out[41];

    assign gpio_in[42] =  pad_to_gpio.gpio42_i;
    assign gpio_to_pad.gpio42_d_o = gpio_dir[42];
    assign gpio_to_pad.gpio42_o = gpio_out[42];

    assign gpio_in[43] =  pad_to_gpio.gpio43_i;
    assign gpio_to_pad.gpio43_d_o = gpio_dir[43];
    assign gpio_to_pad.gpio43_o = gpio_out[43];

    assign gpio_in[44] =  pad_to_gpio.gpio44_i;
    assign gpio_to_pad.gpio44_d_o = gpio_dir[44];
    assign gpio_to_pad.gpio44_o = gpio_out[44];

    assign gpio_in[45] =  pad_to_gpio.gpio45_i;
    assign gpio_to_pad.gpio45_d_o = gpio_dir[45];
    assign gpio_to_pad.gpio45_o = gpio_out[45];

    assign gpio_in[46] =  pad_to_gpio.gpio46_i;
    assign gpio_to_pad.gpio46_d_o = gpio_dir[46];
    assign gpio_to_pad.gpio46_o = gpio_out[46];

    assign gpio_in[47] =  pad_to_gpio.gpio47_i;
    assign gpio_to_pad.gpio47_d_o = gpio_dir[47];
    assign gpio_to_pad.gpio47_o = gpio_out[47];

    assign gpio_in[48] =  pad_to_gpio.gpio48_i;
    assign gpio_to_pad.gpio48_d_o = gpio_dir[48];
    assign gpio_to_pad.gpio48_o = gpio_out[48];

    assign gpio_in[49] =  pad_to_gpio.gpio49_i;
    assign gpio_to_pad.gpio49_d_o = gpio_dir[49];
    assign gpio_to_pad.gpio49_o = gpio_out[49];

    assign gpio_in[50] =  pad_to_gpio.gpio50_i;
    assign gpio_to_pad.gpio50_d_o = gpio_dir[50];
    assign gpio_to_pad.gpio50_o = gpio_out[50];

    assign gpio_in[51] =  pad_to_gpio.gpio51_i;
    assign gpio_to_pad.gpio51_d_o = gpio_dir[51];
    assign gpio_to_pad.gpio51_o = gpio_out[51];

    assign gpio_in[52] =  pad_to_gpio.gpio52_i;
    assign gpio_to_pad.gpio52_d_o = gpio_dir[52];
    assign gpio_to_pad.gpio52_o = gpio_out[52];

    assign gpio_in[53] =  pad_to_gpio.gpio53_i;
    assign gpio_to_pad.gpio53_d_o = gpio_dir[53];
    assign gpio_to_pad.gpio53_o = gpio_out[53];

    assign gpio_in[54] =  pad_to_gpio.gpio54_i;
    assign gpio_to_pad.gpio54_d_o = gpio_dir[54];
    assign gpio_to_pad.gpio54_o = gpio_out[54];

    assign gpio_in[55] =  pad_to_gpio.gpio55_i;
    assign gpio_to_pad.gpio55_d_o = gpio_dir[55];
    assign gpio_to_pad.gpio55_o = gpio_out[55];

    assign gpio_in[56] =  pad_to_gpio.gpio56_i;
    assign gpio_to_pad.gpio56_d_o = gpio_dir[56];
    assign gpio_to_pad.gpio56_o = gpio_out[56];

    assign gpio_in[57] =  pad_to_gpio.gpio57_i;
    assign gpio_to_pad.gpio57_d_o = gpio_dir[57];
    assign gpio_to_pad.gpio57_o = gpio_out[57];

    assign gpio_in[58] = '0;
    assign gpio_in[59] = '0;
    assign gpio_in[60] = '0;
    assign gpio_in[61] = '0;
    assign gpio_in[62] = '0;
    assign gpio_in[63] = '0;
  
endmodule

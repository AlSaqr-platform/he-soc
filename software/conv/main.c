// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
#include <stdio.h>
#include <math.h>
#include "encoding.h"
#include "utils.h"
#include "input.h"
#include "ref.h"

#include "conv_kernel.c"
#define ABS(x) ((x>=0)?x:-x)
#define CHECK
#define VERBOSE

void __attribute ((noinline)) check_result(int cid, unsigned int * result, int SIZE) {

  if(cid == 0) {
    float diff;
    int err = 0;

    for (int i = 0; i < SIZE; i++) {
      if(result[i]!=ref[i] && result[i]!=0 && ref[i]!=0) {
        err++;
        #ifdef VERBOSE
        if(err<40)
          printf("Error at index %u:\t expected %u\t real %u\t \r\n", i, ref[i], result[i]);
        #endif
      }
    }
  
    if(err != 0)
      printf("TEST FAILED with %d errors!!\n", err);
    else
      printf("TEST PASSED!!\n");

    return;
  }
}

int main(int argc, char const *argv[]) {
  
  int m, n;
  int baud_rate = 115200;
  int test_freq = 50000000;
  unsigned int Out[IMG_DIM];  

  int cid=0;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  

  stats(Conv5x5_Scalar(cid,In_Img,Out,ROWS,COLS,Filter_Kern),10);


  #ifdef CHECK
   check_result(cid, Out, IMG_DIM);
  #endif
  
  return 0;
}


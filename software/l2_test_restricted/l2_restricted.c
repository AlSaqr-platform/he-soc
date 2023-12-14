#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define N 20
#define STEP 800
#define VERBOSE 1

const int RESULT_FIB[N] = {0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181};

int main(int argc, char const *argv[]) {
  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  alsaqr_periph_padframe_periphs_a_00_mux_set(3);
  alsaqr_periph_padframe_periphs_a_01_mux_set(3);
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  int * b;
  b=0x1C000000 + 0x4;   //NOTE: 0x1C000000 already used by the jtag sanity check => do not READ/WRITE that register
  int i;
  b[0*STEP]=0;
  b[1*STEP]=1;
  b[2*STEP]=1;
  for(i=3;i<10;i++)
    {
      b[i*STEP]=b[(i-1)*STEP]+b[(i-2)*STEP];
      if(b[i*STEP]!=RESULT_FIB[i]){
        printf("Test FAILED\naborting...\n");
        return 1;
      }
      #if VERBOSE > 5
        printf("TESTED ADDRESS: 0x%8x\n", &b[i*STEP]);
      #endif
    }
  printf("Test Passed\n");
  return 0;
}

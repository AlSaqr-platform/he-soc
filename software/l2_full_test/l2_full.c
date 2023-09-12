#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define VERBOSE 1

int main(int argc, char const *argv[]) {
  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  int *w_i, *w_f;
  w_i = 0x1C000000;
  w_f = 0x1C000000 + 0x10000 - 0x4;
  *w_i =  0;
  *w_f = -1;
  int i = 1;
  while(&w_i[i] != w_f){
    w_i[i] = ++w_i[i-1];
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] <- 0x%8x)\naborting...\n", i, &w_i[i]);
      return 1;
    }
    #if VERBOSE > 5
      printf("0x%8x: w_i[%6d] = %6d; expecting %6d\n", &w_i[i], i, w_i[i], i);
    #endif
    i++;
  }
  #if VERBOSE > 0
    printf("LAST MEMORY ADDRESS: w_i[%0d] <- 0x%8x, w_f <- 0x%8x\n", i, &w_i[i], w_f);
  #endif
  w_i[i] = ++w_i[i-1];
  if(w_i[i] != i){
    printf("Test FAILED (w_i[%0d] <- 0x%8x)\naborting...\n", i, &w_i[i]);
    return 1;
  }
  printf("Test Passed\n");
  return 0;
}

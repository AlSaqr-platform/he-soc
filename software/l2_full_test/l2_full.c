#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define VERBOSE 1

int main(int argc, char const *argv[]) {

  int *w_i, *w_f;
  w_i = 0x1C000000 + 0x4;   //NOTE: 0x1C000000 already used by the jtag sanity check => do not READ/WRITE that register
  w_f = 0x1C000000 + 0x8000 - 0x4;  //32kB of L2
  w_i[0]  =  0;
  w_i[1]  =  1,
  w_f[0]  = -1;
  w_f[-1] = ((int) w_f - (int) w_i)/4;
  int i = 2;
  while((&w_i[i] != w_f) && ((&w_i[i+1] != w_f))){
    w_i[i]   = w_i[i-2] + 2;
    w_i[i+1] = w_i[i-1] + 2;
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] = %0d <- 0x%8x) %p\naborting...\n", i, w_i[i], &w_i[i]);
      return 1;
    }
    #if VERBOSE > 5
      printf("0x%8x: w_i[%0d] = %0d; expecting %0d\n", &w_i[i], i, w_i[i], i);
    #endif
    i++;
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] = %0d <- 0x%8x) %p\naborting...\n", i, w_i[i], &w_i[i]);
      return 1;
    }
    #if VERBOSE > 5
      printf("0x%8x: w_i[%0d] = %0d; expecting %0d\n", &w_i[i], i, w_i[i], i);
    #endif
    i++;
  }
  if(&w_i[i] != w_f){
    w_i[i]   = w_i[i-2] + 2;
    w_i[i+1] = w_i[i-1] + 2;
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] = %0d <- 0x%8x) %p\naborting...\n", i, w_i[i], &w_i[i]);
      return 1;
    }
    #if VERBOSE > 5
      printf("0x%8x: w_i[%0d] = %0d; expecting %0d\n", &w_i[i], i, w_i[i], i);
    #endif
    i++;
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] = %0d <- 0x%8x) %p\naborting...\n", i, w_i[i], &w_i[i]);
      return 1;
    }
    #if VERBOSE > 5
      printf("0x%8x: w_i[%0d] = %0d; expecting %0d\n", &w_i[i], i, w_i[i], i);
    #endif
    #if VERBOSE > 0
      printf("LAST MEMORY ADDRESS: w_i[%0d] <- 0x%8x, w_f <- 0x%8x\n", i, &w_i[i], w_f);
    #endif
  }else{
    w_i[i]   = w_i[i-2] + 2;
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] = %0d <- 0x%8x) %p\naborting...\n", i, w_i[i], &w_i[i]);
      return 1;
    }
    #if VERBOSE > 5
      printf("0x%8x: w_i[%0d] = %0d; expecting %0d\n", &w_i[i], i, w_i[i], i);
    #endif
    #if VERBOSE > 0
      printf("LAST MEMORY ADDRESS: w_i[%0d] <- 0x%8x, w_f <- 0x%8x\n", i, &w_i[i], w_f);
    #endif
  }
  printf("Test Passed\n");
  return 0;
}

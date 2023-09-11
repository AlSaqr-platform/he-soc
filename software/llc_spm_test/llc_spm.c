#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define VERBOSE 10
#define APB_SOC_CTRL_BASE 0x1A106000
#define APB_SOC_CTRL_LLC_CACHE_ADDR_START 0x18
#define APB_SOC_CTRL_LLC_CACHE_ADDR_END 0x1C
#define APB_SOC_CTRL_LLC_SPM_ADDR_START 0x20
#define AXI_LITE_BASE 0x10401000
#define AXI_LLC_CFG_SPM_LOW 0x0
#define AXI_LLC_CFG_SPM_HIGH 0x4
#define AXI_LLC_CFG_COMMIT 0x10

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
  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_CACHE_ADDR_START, 0x80000000);    //LLC cache address start
  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_CACHE_ADDR_END  , 0x80800000);    //LLC cache address end (8MB)
  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_SPM_ADDR_START  , 0x70000000);    //LLC SPM address end
  pulp_write32(AXI_LITE_BASE + AXI_LLC_CFG_SPM_LOW , 0xFFFFFFFF);   //set first half of LLC in SPM mode
  pulp_write32(AXI_LITE_BASE + AXI_LLC_CFG_SPM_HIGH, 0xFFFFFFFF);   //set second half of LLC in SPM mode
  pulp_write32(AXI_LITE_BASE + AXI_LLC_CFG_COMMIT  , 0xFFFFFFFF);   //commit the SPM mode configuration 
  #if VERBOSE > 9
    printf("Configured LLC (SPM mode)...\n");
    printf("Starting test (baud_rate: %0d, test_freq: %0d)...\n", baud_rate, test_freq);
  #endif
  int *w_i, *w_f;
  w_i = 0x70000000;
  w_f = 0x70000000 + 0x40000 - 0x4; //256KB of LLC SPM
  *w_i =  0;
  *w_f = -1;
  int i = 1;
  #if VERBOSE > 9
    printf("Starting read/write loop (address range: [0x%0x-0x%0x])...\n", w_i, w_f);
    printf("Initial values: w_i = %0d@%0p, w_f = %0d@%0p...\n", *w_i, *w_f, w_i, w_f);
  #endif
  while(&w_i[i] != w_f){
    w_i[i] = ++w_i[i-1];
    if(w_i[i] != i){
      printf("Test FAILED (w_i[%0d] <- %p) %p\naborting...\n", i, &w_i[i]);
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
    printf("Test FAILED (w_i[%0d] <- %p) %p\naborting...\n", i, &w_i[i]);
    return 1;
  }
  printf("Test Passed\n");
  return 0;
}

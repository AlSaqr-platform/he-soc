#include <stdio.h>
#include <stdlib.h>
#include "utils.h"

#define VERBOSE 1
#define APB_SOC_CTRL_BASE 0x1A106000
#define APB_SOC_CTRL_LLC_CACHE_ADDR_START 0x18
#define APB_SOC_CTRL_LLC_CACHE_ADDR_END 0x1C
#define APB_SOC_CTRL_LLC_SPM_ADDR_START 0x20
#define LLC_CACHE_START 0x80000000
#define LLC_CACHE_END 0x80800000
#define LLC_SPM_START 0x70000000
#define AXI_LITE_BASE 0x10401000

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
  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_CACHE_ADDR_START, LLC_CACHE_START);    //LLC cache address start
  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_CACHE_ADDR_END  , LLC_CACHE_END);      //LLC cache address end (8MB)
  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_SPM_ADDR_START  , LLC_SPM_START);      //LLC SPM address end
  axi_llc_reg32_all_spm(AXI_LITE_BASE);   //set LLC in SPM mode
  #if VERBOSE > 9
    printf("Configured LLC (SPM mode)...\n");
    printf("Starting test (baud_rate: %0d, test_freq: %0d)...\n", baud_rate, test_freq);
    printf("LLC SPM configuration registers: 0x%16x...\n", axi_llc_reg32_get_spm(AXI_LITE_BASE));
  #endif
  int *w_i, *w_f;
  w_i = 0x70000000;
  w_f = 0x70000000 + 0x20000 - 0x4; //128KB of LLC SPM
  w_i[0]  =  0;
  w_i[1]  =  1,
  w_f[0]  = -1;
  w_f[-1] = ((int) w_f - (int) w_i)/4;
  int i = 2;
  #if VERBOSE > 9
    printf("Starting read/write loop (address range: [0x%0x-0x%0x])...\n", w_i, w_f);
    printf("Initial values: w_i = %0d [address: 0x%0x], w_f = %0d [address: 0x%0x]...\n", *w_i, w_i, *w_f, w_f);
  #endif
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

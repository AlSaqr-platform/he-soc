//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "utils.h"
// #define VERBOSE
//#define FPGA_EMULATION

void dma_setup_regions(uint64_t src_ptr        ,
                       uint64_t dst_ptr        ,
                       uint32_t transfer_length) {
  // clear a bit before as well
  printf("Zeroing region...\n");
  uint32_t src = (uint32_t)src_ptr;
  uint32_t dst = (uint32_t)dst_ptr;
  for (uint32_t i = 0; i < transfer_length/4; i++) {
    #ifdef VERBOSE
      printf("%d\n", i);
      printf("%x\n", src + i*4);
      printf("%x\n", dst + i*4);
    #endif
    pulp_write32(src + i*4, 0);
    pulp_write32(dst + i*4, 0);
  }
  printf("Filling region...\n");
  for (uint32_t i = 0; i < transfer_length/4; i++) {
    pulp_write32(src + i*4, 0x1234 + i*4);
    #ifdef VERBOSE
      printf("%d\n", pulp_read32(src + i*4) );
    #endif
  }
}

int dma_check_regions(uint64_t src_ptr        ,
                      uint64_t dst_ptr        ,
                      uint32_t transfer_length) {
  uint32_t error = 0;
  uint32_t src = (uint32_t)src_ptr;
  uint32_t dst = (uint32_t)dst_ptr;
  for (uint32_t i = 0; i < transfer_length/4; i++) {
    #ifdef VERBOSE
      printf("[SRC] Addr: %x; Content: %x\n", src + i*4, pulp_read32(src + i*4));
      printf("[DST] Addr: %x; Content: %x\n", dst + i*4, pulp_read32(dst + i*4));
    #endif
    if (pulp_read32(src + i*4) != pulp_read32(dst + i*4))
      error ++;
  }
  return error;
}

int main(int argc, char const *argv[]) {

  #ifdef FPGA_EMULATION
    int baud_rate = 9600;
    int test_freq = 10000000;
  #else
    set_flls();
    int baud_rate = 115200;
    int test_freq = 100000000;
  #endif

  printf("DMA test started.\n");
  int error = 0;
  uint32_t transfer_len = 16; // 512 byte transfer
  bool     irq = true;
  struct descriptor *dma_descriptor;
  
  uint64_t src_addr = 0x1c004000;
  uint64_t dst_addr = 0x88000000;
  printf("Configuring DMA descriptor to move data between L3 and L2...\n");
  printf("Transfering %d bytes from %x to %x.\n", transfer_len, src_addr, dst_addr);
  dma_setup_regions(src_addr    ,
                    dst_addr    ,
                    transfer_len);
  
  dma_setup_transfer (src_addr       ,
                      dst_addr       ,
                      transfer_len   ,
                      irq            ,
                      false          ,
                      &dma_descriptor);
  
  dma_submit_transfer(&dma_descriptor);

  error = dma_check_regions(src_addr    ,
                            dst_addr    ,
                            transfer_len);

  if (error == 0)
    printf("L2 -> L3 test succeded!\n");
  else
    printf("L2 -> L3 test failed with %d errors..\n", error);

  src_addr = 0x88000000;
  dst_addr = 0x1c004000;
  printf("Transfering %d bytes from %x to %x.\n", transfer_len, src_addr, dst_addr);
  dma_setup_regions(src_addr    ,
                    dst_addr    ,
                    transfer_len);
  
  dma_setup_transfer (src_addr       ,
                      dst_addr       ,
                      transfer_len   ,
                      irq            ,
                      false          ,
                      &dma_descriptor);
  
  dma_submit_transfer(&dma_descriptor);
  
  error = dma_check_regions(src_addr    ,
                            dst_addr    ,
                            transfer_len);
  
  if (error == 0)
    printf("L3 -> L2 test succeded!\n");
  else
    printf("L3 -> L2 test failed with %d errors..\n", error);

  src_addr = 0x10000100;
  dst_addr = 0x89000000;
  printf("Configuring DMA descriptor to move data between L1 and L3...\n");
  printf("Transfering %d bytes from %x to %x.\n", transfer_len, src_addr, dst_addr);
  dma_setup_regions(src_addr    ,
                    dst_addr    ,
                    transfer_len);
  
  dma_setup_transfer (src_addr       ,
                      dst_addr       ,
                      transfer_len   ,
                      irq            ,
                      false          ,
                      &dma_descriptor);
  
  dma_submit_transfer(&dma_descriptor);

  error = dma_check_regions(src_addr    ,
                            dst_addr    ,
                            transfer_len);

  if (error == 0)
    printf("L1 -> L3 test succeded!\n");
  else
    printf("L1 -> L3 test failed with %d errors..\n", error);

  src_addr = 0x89000000;
  dst_addr = 0x10000100;
  printf("Transfering %d bytes from %x to %x.\n", transfer_len, src_addr, dst_addr);
  dma_setup_regions(src_addr    ,
                    dst_addr    ,
                    transfer_len);
  
  dma_setup_transfer (src_addr       ,
                      dst_addr       ,
                      transfer_len   ,
                      irq            ,
                      false          ,
                      &dma_descriptor);
  
  dma_submit_transfer(&dma_descriptor);
  
  error = dma_check_regions(src_addr    ,
                            dst_addr    ,
                            transfer_len);
  
  if (error == 0)
    printf("L3 -> L1 test succeded!\n");
  else
    printf("L3 -> L1 test failed with %d errors..\n", error);
    
  uart_wait_tx_done();
  
  return 0;
}

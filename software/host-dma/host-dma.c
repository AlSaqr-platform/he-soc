//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "utils.h"
//#define FPGA_EMULATION

void dma_setup_regions(volatile uint64_t *src_ptr,
                       volatile uint64_t *dst_ptr,
                       uint32_t transfer_length  ) {
  // clear a bit before as well
  printf("Zeroing region!\n");
  for (int64_t i = 0; i < transfer_length; i++) {
    pulp_write32(src_ptr + 4*i, 0);
    pulp_write32(dst_ptr + i*4, 0);
  }
  printf("Filling region with pattern!\n");
  for (int64_t i = 0; i < transfer_length; i++) {
    pulp_write32(src_ptr + i*4, 0x1234 + i);
    // printf("%d\n", pulp_read32(src_ptr + i) );
  }
}

int dma_check_regions(volatile uint64_t *src_ptr,
                       volatile uint64_t *dst_ptr,
                       uint32_t transfer_length  ) {
  uint32_t error = 0;
  for (uint32_t i = 0; i < transfer_length; i++) {
    if (pulp_read32(src_ptr + i*4) != pulp_read32(dst_ptr + i*4)){
      printf("[SRC] Addr: %x; Content: %x\n", src_ptr + i*4, pulp_read32(src_ptr + i*4));
      printf("[DST] Addr: %x; Content: %x\n", dst_ptr + i*4, pulp_read32(dst_ptr + i*4));
      error ++;
    }
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
  uint32_t transfer_len = 128; // 512 byte transfer
  bool     irq = true;
  uint64_t start_addr = 0x88000000;
  uint64_t dst_addr   = 0x1c004000;
  struct descriptor *dma_descriptor;
  
  printf("Configuring DMA descriptor...\n");
  printf("Transfering %d bytes from %x to %x.\n", transfer_len, start_addr, dst_addr);
  dma_setup_regions((uint64_t*)start_addr,
                    (uint64_t*)dst_addr  ,
                    transfer_len         );
  
  dma_setup_transfer (start_addr     ,
                      dst_addr       ,
                      transfer_len   ,
                      irq            ,
                      false          ,
                      &dma_descriptor);
  
  dma_submit_transfer(&dma_descriptor);

  // dma_wait_for_transfer(&dma_descriptor);
  asm volatile ("wfi");

  int ret_value = dma_check_regions((uint64_t*)start_addr ,
                                    (uint64_t*)dst_addr   ,
                                    (uint32_t)transfer_len);

  if (ret_value == 0)
    printf("Test passed!\n");
  else {
    printf("Test failed..\n");
    printf("Errors: %d\n", ret_value);
  }
  uart_wait_tx_done();

  return 0;
}

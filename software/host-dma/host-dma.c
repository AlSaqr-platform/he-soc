//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "utils.h"
//#define FPGA_EMULATION

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
  uint64_t stride = 512; // 512 byte transfer
  bool     irq = true;
  uint64_t start_addr = 0x81000000;
  uint64_t end_addr   = start_addr + stride;
  struct descriptor *dma_descriptor;
  
  printf("Configuring DMA descriptor...\n");
  printf("Transfering %d bytes from %x to %x.\n", stride, start_addr, end_addr);
  dma_setup_regions((uint8_t*)start_addr, (uint8_t*)end_addr, (uint32_t)stride);
  dma_setup_transfer (start_addr     ,
                      end_addr       ,
                      stride         ,
                      irq            ,
                      false          ,
                      &dma_descriptor);
  dma_submit_transfer(&dma_descriptor);
  uart_wait_tx_done();

  return 0;
}
 



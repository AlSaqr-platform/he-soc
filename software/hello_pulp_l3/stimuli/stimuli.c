#include <stdio.h>
#include <stdlib.h>
#include "pulp.h"
// #define FPGA_EMULATION

unsigned int i;
#ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
#else
  int baud_rate = 115200;
  int test_freq = 200000000;
#endif

//int main(int argc, char const *argv[]) {
int main() {

  i = 0x10000000;

  if(core_id() == 0) {

    pulp_write32(i, 0);

    #ifdef USE_UART
    uart_set_cfg(0, (test_freq / baud_rate) >> 4);
    printf("UART BASE: %X\n", UART_BASE_ADDR);
    printf("%d\n", core_id());
    uart_wait_tx_done();
    #endif

    pulp_write32(i, pulp_read32(i) + 1);
  }

  synch_barrier();

  while(pulp_read32(i) < core_id());
  
  if(core_id() != 0) {

  #ifdef USE_UART
  printf("%d\n",core_id());
  uart_wait_tx_done();
  #endif

  pulp_write32(i,pulp_read32(i)+1);
  }

  synch_barrier();

  if(core_id() == 0){
    // Write msg to mailbox
    pulp_write32(0x10403000 + 0x00, 0);
  }

  while (1) {
          __asm__ volatile("wfi;");
  }

  return 0;
}

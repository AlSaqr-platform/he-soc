//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
//#define FPGA_EMULATION

static inline unsigned int core_id() {
  int hart_id;
  asm("csrr %0, 0xF14" : "=r" (hart_id) : );
  // in PULP the hart id is {22'b0, cluster_id, core_id}
  return hart_id & 0x01f;
}

int main(int argc, char const *argv[]) {

  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  int baud_rate = 115200;
  int test_freq = 17500000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  if (core_id()==0)
    printf("Hello from cluster!\n");
  uart_wait_tx_done();

  return 0;
}

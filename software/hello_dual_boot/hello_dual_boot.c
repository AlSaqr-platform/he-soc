#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

volatile uint64_t count __attribute__((section(".nocache_share_region")));

void thread_entry(int cid, int nc)
{
  int * pointer;
  int mbox_id = 10;

  // Ack opentitan irq
  pointer = (int *) 0x10404020;
  *pointer = 0x1;

  // core 0 initializes the synchronization variable and prints hello before core 1
  if (cid == 0){
    count = 0;
    hello_world(cid);
  }
  else{
    while(count != cid);
    hello_world(cid);
  }

  count++;

  // cores wait here
  while(cid)
    { asm volatile ("wfi"); }

  // core 0 continues after all cores have finished
  if (cid == 0) {
    while (count != nc)
      { asm volatile ("nop"); }
  }
}

void hello_world(int cid){
  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 40000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  printf("Hello Culsans! I'm Core %d!\r\n", cid);
  uart_wait_tx_done();
}

int main(int argc, char const *argv[]) {
  return 0;
}




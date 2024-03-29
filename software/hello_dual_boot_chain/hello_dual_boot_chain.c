//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

volatile uint64_t count __attribute__((section(".nocache_share_region")));

void thread_entry(int cid, int nc)
{
  int * pointer;
  int mbox_id = 10;
  hello_world(cid);
  // core 0 initializes the synchronization variable
  if (cid == 0){
    count = 0;
    // Init CVA6 Plic - core 1
    pointer = (int *) 0x0C000028;
    *pointer = 0x1;
    pointer = (int *) 0x0C002180; // configure core 1 plic target
    *pointer =  0x400;
    // Boot core 1
    pointer = (int *) 0x10404000;
    *pointer = 0x80000000;
    // Send IRQ and boot
    pointer = (int *) 0x10404024;
    *pointer = 0x1;
  }
  else{
    pointer = (int *) 0x10404024;
    *pointer = 0x0;
    while(count != cid);
  }
  // actual test
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

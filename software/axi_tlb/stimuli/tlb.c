//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
// #define VERBOSE

static inline unsigned int core_id() {
  int hart_id;
  asm("csrr %0, 0xF14" : "=r" (hart_id) : );
  // in PULP the hart id is {22'b0, cluster_id, core_id}
  return hart_id & 0x01f;
}

int * i;

//int main(int argc, char const *argv[]) {
int thread_entry(int cid, int nc) {

  i = 0x10000000;
  pulp_write32(i, 0);
  pulp_write32(0x10004000, 0);
  pulp_write32(0x10002000, 0);
  
  if(core_id() == 0){
    #ifdef VERBOSE
      printf("%d\n", 0x1234 + core_id());
    #else
      printf("Testing TLB..\n");
    #endif
    uart_wait_tx_done();
    pulp_write32(i, pulp_read32(i) + 1);
  }

  while(pulp_read32(i) < core_id());
  
  if(core_id() != 0){
    tlb_cfg(0x10401000, core_id(), 0x8000000000000000 + core_id()*0x1000, 0x8000000000001000 + core_id()*0x1000, 0x0000000080000000 + core_id()*0x1000, 0x07);
    pulp_write32(0x8000000000000000 + core_id()*0x1000, 0x1234 + core_id());
    if (pulp_read32(0x8000000000000000 + core_id()*0x1000) == 0x1234 + core_id()){
      #ifdef VERBOSE
        printf("%d\n", pulp_read32(0x8000000000000000 + core_id()*0x1000));
        uart_wait_tx_done();
      #endif
    } else {
        pulp_write32(0x10002000, 0xDEADFACE);
        goto end;
    }
    pulp_write32(i, pulp_read32(i) + 1);
  } else {
      while(pulp_read32(i) < 8);
      pulp_write32(0x10004000, 1);
  }

  end:
  if (core_id() == 7) {
    pulp_write32(0x10003010, 0xBEDEAD);
    #ifdef VERBOSE
      printf("%x\n", pulp_read32(0x10003010));
      uart_wait_tx_done();
    #endif
  }

  return 0;
}

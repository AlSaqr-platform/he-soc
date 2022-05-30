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

int thread_entry(int cid, int nc) {

  if(core_id() == 0){
    pulp_write32(0x1040301C,0x1);
    pulp_write32(0x10403000,0x1);
  }

  while (1) {
          __asm__ volatile("wfi;");
  }
  
  return 0;
}

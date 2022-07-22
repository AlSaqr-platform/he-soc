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

int thread_entry(int cid, int nc) {

  int read_value;
  if(core_id() == 0){
    while( (pulp_read32(0x10403008) & 0x1) != 0 );
    read_value = pulp_read32(0x10403004);
    printf("[PULP Cluster] : %x\n",read_value);
    pulp_write32(0x10403000,read_value);
  }

  while (1) {
          __asm__ volatile("wfi;");
  }
  
  return 0;
}

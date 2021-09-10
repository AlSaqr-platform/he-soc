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

int * i;

//int main(int argc, char const *argv[]) {
int thread_entry(int cid, int nc) {

  i=0x10000000;
  pulp_write32(i,0);
  if(core_id()==0){
  printf("%d\n", core_id());
  uart_wait_tx_done();
  pulp_write32(i,pulp_read32(i)+1);
  }

  while(pulp_read32(i)<core_id());
  
  if(core_id()!=0){
  printf("%d\n",core_id());
  uart_wait_tx_done();
  pulp_write32(i,pulp_read32(i)+1);
  }
  
  while(pulp_read32(i)<8);
  
  pulp_write32(0x10001000,1<<31);
  
  return 0;
}

//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define VERBOSE

static inline unsigned int core_id() {
  int hart_id;
  asm("csrr %0, 0xF14" : "=r" (hart_id) : );
  // in PULP the hart id is {22'b0, cluster_id, core_id}
  return hart_id & 0x01f;
}

int * i;

uint64_t *h2c_src_ptr = 0x1C005000;
uint64_t *h2c_dst_ptr = 0x10005000;

// uint64_t *h2c_src_ptr = 0x1C001000;
// uint64_t *h2c_dst_ptr = 0x10001000;
uint32_t  h2c_tfr_len = 4*16;
uint32_t  c2h_tfr_len = 4*16;
// uint64_t *c2h_dst_ptr = 0x1C003000;
// uint64_t *c2h_src_ptr = 0x10003000;
// uint32_t  c2h_trf_len = 0x00001000;
uint32_t dma_job_id;

//int main(int argc, char const *argv[]) {
int thread_entry(int cid, int nc) {

  pulp_write32(i, 0);
  pulp_write32(0x10003010, 0);
  pulp_write32(0x10002000, 0);
  
  i = 0x10000000;
  pulp_write32(i, 0);
  if(core_id() == 0){
  dma_job_id = dma_h2c_tfr_cfg (0x000000001C005000, 0x10005000, h2c_tfr_len);
  while(pulp_read32(0x10201828) <= dma_job_id);
  }

  pulp_write32(0x10003010, 0xBEDEAD);

  return 0;
}

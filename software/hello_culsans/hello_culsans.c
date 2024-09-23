//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

__attribute__ ((section(".heapl2ram"))) volatile int flag[2] = { 0, 0};

__attribute__ ((section(".heapl2ram"))) volatile int victim = -1;

__attribute__ ((section(".heapl2ram"))) volatile int core_1 = -1;

static __attribute__ ((noinline)) void lock(int cid) {
  flag[cid] = 1;
  victim = cid;
  int other_cid = 1-cid;
  while( flag[other_cid] && (victim==cid) ) {
    __asm__ volatile("nop;");
  }
}

static __attribute__ ((noinline)) void unlock(int cid) {
  flag[cid] = 0;
}

int thread_entry(int cid, int nc){

  lock(cid);
  uint64_t misa = read_csr(misa);
  if(!(misa & 0x80)){
    printf("Hypervisor extension MISSING!\r\n");
    uart_wait_tx_done();
    return -1;
  }
  printf("Hello Culsans! I'm Core %d!\r\n", cid);
  uart_wait_tx_done();
  unlock(cid);

  return 0;
}

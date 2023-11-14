//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

#define FPGA_EMULATION

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

  int core_id =  read_csr(mhartid);

  lock(cid);

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 40000000;
  alsaqr_periph_fpga_padframe_periphs_cva6_uart_00_mux_set(1);
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  printf("Hello Culsans! I'm Core %d!\r\n", core_id);
  uart_wait_tx_done();

  unlock(cid);

  return 0;
}

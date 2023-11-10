//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

//#define FPGA_EMULATION
__attribute__ ((section(".heapl2ram"))) int core_done;

static inline void cva6_barrier(int cid, int nc) {

  while(core_done != (cid-1)){
    __asm__ volatile("nop;");
  }
  core_done++;
  if(cid==nc-1)
    core_done = -1;

}

int thread_entry(int cid, int nc){

  int core_id =  read_csr(mhartid);
  if(core_id==0)
    core_done = -1;
  cva6_barrier(core_id,nc);

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  alsaqr_periph_fpga_padframe_periphs_cva6_uart_00_mux_set(1);
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  for(int i = 0; i<nc; i++) {
    if(i==core_id) {
      printf("Hello Culsans! I'm Core %d!\r\n", core_id);
      uart_wait_tx_done();
    }
    cva6_barrier(core_id,nc);
  }

  return 0;
}

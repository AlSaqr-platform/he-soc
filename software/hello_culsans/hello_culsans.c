//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

__attribute__ ((section(".heapl2ram"))) int core_done;

//#define FPGA_EMULATION
int thread_entry(int cid, int nc){

  if(cid==0) {
    core_done = -1;
    while(core_done!=0){
      __asm__ volatile("nop;");
    }
  }
  if(cid==1)
    core_done = 0;

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

  while(core_done<cid){
    __asm__ volatile("nop;");
  }

  printf("Hello Culsans! I'm Core %d!\r\n", read_csr(mhartid));
  uart_wait_tx_done();

  core_done++;

  while(core_done<2){
    __asm__ volatile("nop;");
  }
  return 0;
}

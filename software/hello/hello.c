//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

//#define FPGA_EMULATION

int main(int argc, char const *argv[]) {

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
  uint32_t * hyaxicfg_reg_mask = 0x1A101018;
  pulp_write32(hyaxicfg_reg_mask,26); //128MB addressable
  uint32_t * hyaxicfg_reg_memspace_end_addr1 = 0x1A10102C;
  pulp_write32(hyaxicfg_reg_memspace_end_addr1,0x88000000);
  uint32_t * hyaxicfg_reg_memspace_start_addr1 = 0x1A101028;
  pulp_write32(hyaxicfg_reg_memspace_start_addr1,0x84000000);
  uint32_t * hyaxicfg_reg_memspace_end_addr0 = 0x1A101024;
  pulp_write32(hyaxicfg_reg_memspace_end_addr0,0x84000000);
  printf("Hello World! I'm Core %d!\r\n", read_csr(mhartid));
  uart_wait_tx_done();
  return 0;
}

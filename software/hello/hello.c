//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

//#define FPGA_EMULATION

int main(int argc, char const *argv[]) {

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

//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
//#define FPGA_EMULATION

#define LEN 5

int main(int argc, char const *argv[]) {

  int vec[LEN]= {10,2,6,8,9};
  int i=0;
  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  //set_flls();
  int baud_rate = 115200;
  int test_freq = 50000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  /*uint32_t * hyaxicfg_reg_mask = 0x1A101018;
  pulp_write32(hyaxicfg_reg_mask,26); //128MB addressable
  uint32_t * hyaxicfg_reg_memspace_end_addr1 = 0x1A10102C;
  pulp_write32(hyaxicfg_reg_memspace_end_addr1,0x88000000);
  uint32_t * hyaxicfg_reg_memspace_start_addr1 = 0x1A101028;
  pulp_write32(hyaxicfg_reg_memspace_start_addr1,0x84000000);
  uint32_t * hyaxicfg_reg_memspace_end_addr0 = 0x1A101024;
  pulp_write32(hyaxicfg_reg_memspace_end_addr0,0x84000000); */
  
  while(1){
    //printf("Val vec %d is : %d \r\n", i, vec[i]);
    printf("Hello!!!\r\n");
    uart_wait_tx_done();
    if (i<5)
      i++;
    else
      i=0;
  }
  return 0;
}
 


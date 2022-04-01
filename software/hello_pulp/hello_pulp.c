//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"

//#define FPGA_EMULATION


int main(int argc, char const *argv[]) {
    
  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  // H2C TLB configuration
  tlb_cfg(H2C_TLB_BASE_ADDR, 0, h2c_first_va, h2c_last_va, h2c_base_pa, h2c_flags);
  // C2H TLB configuration
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, c2h_flags);
  uint32_t * hyaxicfg_reg_mask = 0x1A104018;
  pulp_write32(hyaxicfg_reg_mask,26); //128MB addressable
  uint32_t * hyaxicfg_reg_memspace = 0x1A104024;
  pulp_write32(hyaxicfg_reg_memspace,0x84000000); // Changing RAM end address, 64 MB
  // cluster setup
  load_cluster_code();
  
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1C000854,0x1C00813E);
  pulp_write32(0x100000CC,0);
  pulp_write32(0x10201400,0xffffffff);
  pulp_write32(0x100000C8,0x0000ff38);
  pulp_write32(0x100000CC,0);
  pulp_write32(0x100040CC,0);
  pulp_write32(0x100040C8,0x0000BF38);
  pulp_write32(0x100000C4,0x100000C8);
  // change ris5y boot addresses
  int boot_addr_core=0x10200040;
  for (int i=0; i<8; i++)
    pulp_write32(0x10200040+i*4,0x1C000000);
  pulp_write32(0x1A106000,0x3);
  pulp_write32(0x1A106000,0x7);
  pulp_write32(0x10200008,0xff);

  pulp_write32(0x10001000,0x0);
  pulp_write32(0x10001030,0x0);
  
  while( ((pulp_read32(0x10001000))<<31)!=0x80000000 );

  if(((pulp_read32(0x10001000))<<31)==0x80000000)
    printf("Cl ok\n");
  else
    printf("Cl error!\n");
  
  printf("Hello CVA6!\n");
  uart_wait_tx_done();
    
  return 0;
}
 



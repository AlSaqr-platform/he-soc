//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"

#define FPGA_EMULATION

int launch_cluster() {
  
  tlb_cfg(H2C_TLB_BASE_ADDR, 0, h2c_first_va, h2c_last_va, h2c_base_pa, h2c_flags);
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, c2h_flags);

  load_cluster_code();

  // Reset the cluster
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);

  // Enable cluster's instruction cache
  pulp_write32(0x10201400,0xffffffff);

  // change ris5y boot addresses
  int boot_addr_core=0x10200040;
  for (int i=0; i<8; i++)
    pulp_write32(0x10200040+i*4,0x1C000000);

  // Set enable and fetch enable
  pulp_write32(0x1A106000,0x3);
  pulp_write32(0x1A106000,0x7);

  // Cluster control unit registers, fetch enable
  pulp_write32(0x10200008,0xff);

  while( ((pulp_read32(0x10001000))<<31)!=0x80000000 );

  if(((pulp_read32(0x10001000))<<31)==0x80000000)
    printf("Cl ok\n");
  else
    printf("Cl error!\n");

  uart_wait_tx_done();
  return 0;
}

int main(int argc, char const *argv[]) {
    
  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  

  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  launch_cluster();
  
  printf("Hello CVA6!\n");
  uart_wait_tx_done();
    
  return 0;
}
 



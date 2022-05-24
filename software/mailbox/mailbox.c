//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"
//#define FPGA_EMULATION

uint32_t ret_value = 0;
#define PLIC_BASE 0x0C000000

int main(int argc, char const *argv[]) {

  uint32_t mb_plic_id = 8;
  int ret_value;
  
  // H2C TLB configuration
  tlb_cfg(H2C_TLB_BASE_ADDR, 0, h2c_first_va, h2c_last_va, h2c_base_pa, 0x07);
  // C2H TLB configuration
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  load_cluster_code();

  pulp_write32(PLIC_BASE+(mb_plic_id*4),0x1);
  pulp_write32(PLIC_BASE+0x2000,1<<mb_plic_id);

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

  while ( pulp_read32(PLIC_BASE+0x200004)!=mb_plic_id ) {
   asm volatile ("wfi");
  }

  uint32_t msg;
  msg = pulp_read32(0x10403004);
  
  if (msg!=0x1) {
    printf("Error!\n");
    ret_value += 1;
  } else 
      printf("Ok!\n");

  pulp_write32(0x10404018,0x1);
  pulp_write32(0x10404018,0x0);
  pulp_write32(0x10404024,0x1);
  pulp_write32(0x10404024,0x0);
  uart_wait_tx_done();
    
  return ret_value;
}

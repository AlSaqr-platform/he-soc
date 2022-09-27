//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"

#define FPGA_EMULATION
#define PLIC_BASE 0x0C000000

int launch_cluster() {
  
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  load_cluster_code();

  uint32_t mb_plic_id = 8;
  pulp_write32(PLIC_BASE+(mb_plic_id*4),0x1);
  pulp_write32(PLIC_BASE+0x2000,1<<mb_plic_id);
  
  // Reset the cluster
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);

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
  pulp_write32(PLIC_BASE+0x200004,mb_plic_id);
  uint32_t msg = pulp_read32(0x10402004);

  if(msg==0xabbaabba)
    printf("Cl ok\n");
  else
    printf("Cl error! %x\n", msg);

  uart_wait_tx_done();
  return 0;
}

int main(int argc, char const *argv[]) {
    
  int baud_rate = 115200;
  int test_freq = 50000000;

  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  printf("Hello\r\n");
  uart_wait_tx_done();
  launch_cluster();

  printf("UART BASE: %X\n", UART_BASE_ADDR);
  uart_wait_tx_done();
  
  printf("Hello CVA6!\n");
  uart_wait_tx_done();
    
  return 0;
}
 



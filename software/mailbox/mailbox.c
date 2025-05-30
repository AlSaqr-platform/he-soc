//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"
#include "encoding.h"

#define FPGA_EMULATION

uint32_t ret_value = 0;
#define PLIC_BASE 0x0C000000

int main(int argc, char const *argv[]) {

  uint32_t mb_plic_id = 8;
  int ret_value;
  volatile uint64_t perf_c;


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
  perf_c = -read_csr(mcycle);

  // Cluster control unit registers, fetch enable
  pulp_write32(0x10200008,0xff);

  if( ( pulp_read32(0x10402008) & 0x2 ) == 0 )
    pulp_write32(0x10402000,0xabbaabba);

  while ( pulp_read32(PLIC_BASE+0x200004)!=mb_plic_id ) {
   asm volatile ("wfi");
  }
  perf_c += read_csr(mcycle);

  pulp_write32(PLIC_BASE+0x200004,mb_plic_id);

  uint32_t msg;
  msg = pulp_read32(0x10402004);

  if (msg!=0xabbaabba) {
    printf("Error!\n");
    ret_value += 1;
  } else
    printf("Ok in %d\r\n", (uint32_t)perf_c);

  pulp_write32(0x10403018,0x1);
  pulp_write32(0x10403024,0x1);
  pulp_write32(0x10402018,0x1);
  pulp_write32(0x10402024,0x1);
  uart_wait_tx_done();

  return ret_value;
}

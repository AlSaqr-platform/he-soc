//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"

//#define FPGA_EMULATION

int launch_cluster() {
  
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  load_cluster_code();

  uint32_t mb_plic_id = 8;
  uint32_t plic_context = 0;

  plic_set_priority(mb_plic_id, 0x1);
  plic_set_ie(plic_context, mb_plic_id, 0x1);

  // Flush R FIFO
  pulp_write32(0x10402000 + 0x24, (0x1 << 1));

  // Enable W IRQ
  pulp_write32(0x10403000 + 0x1C, (0x1 << 0));

  // Enable external irqs in CVA6
  unsigned int __tmp = (1 << IRQ_M_EXT);
  asm volatile ("csrrs x0, mie, %0" :  : "r"(__tmp));

  init_cluster(BOOT_ADDR);

  while (plic_claim_msg(plic_context) != mb_plic_id) {
   asm volatile ("wfi");
  }

  // Read irq status
  uint32_t mb_irqs = pulp_read32(0x10403000 + 0x18);
  uint32_t msg = -1;
  if ((mb_irqs & 0b111) == 0b001) {
    // Clear interrupt in mb
    pulp_write32(0x10403000 + 0x18, 0b001);
    msg = pulp_read32(0x10402000 + 0x04);
  }

  // Complete irq
  plic_complete_msg(plic_context, mb_plic_id);

  return msg;
}

int main(int argc, char const *argv[]) {
    
  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif

  unsigned int msg;
  int retval = 0;

  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  printf("Test init\r\n");
  uart_wait_tx_done();
  msg = launch_cluster();

  if(msg == 0)
    printf("Cl ok\n");
  else
    printf("Cl error! %x\n", msg);

  uart_wait_tx_done();

  printf("UART BASE: %X\n", UART_BASE_ADDR);
  uart_wait_tx_done();
  
  printf("Test Done\r\n");
  uart_wait_tx_done();
    
  return msg;
}

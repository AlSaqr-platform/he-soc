//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"
#include "udma.h"
#include "apb_timer.h"

#define N_TIMER 1

#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080

int main(int argc, char const *argv[]) {

  uint32_t timer_0_plic_id =5;

  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  uint32_t * hyaxicfg_reg_mask = 0x1A101018;
  pulp_write32(hyaxicfg_reg_mask,26); //128MB addressable
  uint32_t * hyaxicfg_reg_memspace_end_addr1 = 0x1A10102C;
  pulp_write32(hyaxicfg_reg_memspace_end_addr1,0x88000000);
  uint32_t * hyaxicfg_reg_memspace_start_addr1 = 0x1A101028;
  pulp_write32(hyaxicfg_reg_memspace_start_addr1,0x84000000);
  uint32_t * hyaxicfg_reg_memspace_end_addr0 = 0x1A101024;
  pulp_write32(hyaxicfg_reg_memspace_end_addr0,0x84000000);

  printf("Hello CVA6!\r\n");
  uart_wait_tx_done();

  // CVA6 clk out
  alsaqr_periph_padframe_periphs_b_62_mux_set( 2 );

  apb_timer_set_value(N_TIMER-1,0);
  apb_timer_set_compare(N_TIMER-1,100000);

  apb_timer_enable(N_TIMER-1,8); //it count every 8 cycles

  pulp_write32(PLIC_BASE+timer_0_plic_id*4, 1);
  pulp_write32(PLIC_EN_BITS+(((int)(timer_0_plic_id/32))*4), 1<<(timer_0_plic_id%32)); //enable interrupt
  //  wfi until reading the rx id from the PLIC
  while(pulp_read32(PLIC_CHECK)!=timer_0_plic_id) {
    asm volatile ("wfi");
  }
  //Set completed Interrupt
  pulp_write32(PLIC_CHECK,timer_0_plic_id);

  apb_timer_disable(N_TIMER-1);

  return 0;
}



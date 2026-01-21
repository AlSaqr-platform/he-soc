//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "gpio_v3.h"
#include "./cluster_code.h"

#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080


#define ARCHI_GPIO_ADDR 0x1A105000
#define GPIO2_PAD_A2_ADDR 0x1A10500C

#define OUT 1
#define IN  0

uint32_t configure_gpio(uint32_t number, uint32_t direction){
  uint32_t address;
  uint32_t dir;
  uint32_t gpioen;

  //--- set GPIO
  if(number < 32)
  {
    if (direction == IN)
    {

      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_OFFSET;

      gpioen = pulp_read32(address);
      //--- enable GPIO
      //printf("GPIOEN RD: %x\n",gpioen);
      gpioen |= (1 << number);
      //printf("GPIOEN WR: %x\n",gpioen);
      pulp_write32(address, gpioen);
      //--- set direction
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_OFFSET;
      dir = pulp_read32(address);
      //printf("GPIODIR RD: %x\n",dir);
      dir |= (0 << number);
      //printf("GPIODIR WR: %x\n",dir);
      pulp_write32(address, dir);

    }else if (direction == OUT){
      //--- enable GPIO
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_OFFSET;
      gpioen = pulp_read32(address);
      gpioen |= (1 << number);
      pulp_write32(address, gpioen);
      /*printf("GPIO Enable Address %x  Val: %x\n\r",address, gpioen);
      uart_wait_tx_done();*/
      //--- set direction
      dir=gpioen;
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_OFFSET;
      pulp_write32(address, dir);
      /*printf("GPIO Direction OUT Address %x  Val: %x\n\r",address, dir);
      uart_wait_tx_done();*/
    }
  }else{
    if (direction == IN)
    {
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_32_63_OFFSET;
      gpioen = pulp_read32(address);
      //--- enable GPIO
      //printf("GPIOEN RD: %x\n",gpioen);
      gpioen |= (1 << (number-32));
      //printf("GPIOEN WR: %x\n",gpioen);
      pulp_write32(address, gpioen);
      //--- set direction
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_32_63_OFFSET;
      dir = pulp_read32(address);
      //printf("GPIODIR RD: %x\n",dir);
      dir |= (0 << (number-32));
      //printf("GPIODIR WR: %x\n",dir);
      pulp_write32(address, dir);
    }else if (direction == OUT){
      //--- enable GPIO
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_32_63_OFFSET;
      gpioen = pulp_read32(address);
      gpioen |= (1 << (number-32));
      pulp_write32(address, gpioen);
      //--- set direction
      dir=gpioen;
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_32_63_OFFSET;
      pulp_write32(address, dir);
    }
  }

  while(pulp_read32(address) != dir);

}

void set_gpio(uint32_t number, uint32_t value){
  uint32_t value_wr;
  uint32_t address;
  if (number < 32)
  {
    address = ARCHI_GPIO_ADDR + GPIO_PADOUT_OFFSET;
    value_wr = pulp_read32(address);
    if (value == 1)
    {
      value_wr |= (1 << (number));
    }else{
      value_wr &= ~(1 << (number));
    }
    pulp_write32(address, value_wr);
  }else{
    address = ARCHI_GPIO_ADDR + GPIO_PADOUT_32_63_OFFSET;
    value_wr = pulp_read32(address);
    if (value == 1)
    {
      value_wr |= (1 << (number % 32));
    }else{
      value_wr &= ~(1 << (number % 32));
    }
    pulp_write32(address, value_wr);
  }

  while(pulp_read32(address) != value_wr);
}

int launch_cluster() {

  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  load_cluster_code();

  uint32_t mb_plic_id = 8;
  uint32_t plic_context = 0;

  pulp_write32(PLIC_BASE+mb_plic_id*4, 1); // set mb_plic_id interrupt priority to 1

  pulp_write32(PLIC_EN_BITS+(((int)(mb_plic_id/32))*4), 1<<(mb_plic_id%32)); //enable interrupt

  // Clear IRQS Register
  pulp_write32(0x10403000 + 0x18, 0x7);

  // Flush R FIFO
  pulp_write32(0x10402000 + 0x24, (0x1 << 1));

  // Enable W IRQ
  pulp_write32(0x10403000 + 0x1C, (0x1 << 0));

  // Enable external irqs in CVA6
  unsigned int __tmp = (1 << IRQ_M_EXT);
  asm volatile ("csrrs x0, mie, %0" :  : "r"(__tmp));

  init_cluster(BOOT_ADDR);

  while (pulp_read32(PLIC_CHECK)!= mb_plic_id) {
   asm volatile ("wfi");
  }

  // Core in sleep
  /*while (1) {
   asm volatile ("wfi");
  }*/

  // Read irq status
  uint32_t mb_irqs = pulp_read32(0x10403000 + 0x18);
  uint32_t msg = -1;
  if ((mb_irqs & 0b111) == 0b001) {

    // Read the message
    msg = pulp_read32(0x10402000 + 0x04);

  }

  // Complete irq
  pulp_write32(PLIC_CHECK,mb_plic_id);

  return msg;
}

int main(int argc, char const *argv[]) {

  unsigned int msg = -1;
  int retval = 0;
  uint32_t mb_plic_id = 8;

  uint32_t gpio_val= 0x00000004;

  // Config Pad GPIO 2
  //alsaqr_periph_padframe_periphs_a_02_mux_set(2);

  // Set GPIO 0 OUT
  //configure_gpio(2, OUT);
  //set_gpio(2, gpio_val);

  // Apply this on the chip if needed to gate/ungate the cluster
  //clock_gating_cluster();

  msg = launch_cluster();

  //clock_gating_cluster();

  if(msg == 0){
    //printf("Success!! \r\n");
  }
  else{
    //printf("Fail!!\r\n");
  }

  return (msg != 0);
}

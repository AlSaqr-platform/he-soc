/*
 * Copyright (C) 2018 ETH Zurich and University of Bologna
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* 
 * Mantainer: Luca Valente (luca.valente2@unibo.it)
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "utils.h"
#include "udma.h" //for the padframe

#define BUFFER_SIZE 10
#define BUFFER_SIZE_READ 12

#define SERIAL_LINK_BASE 0x60000000
#define SERIAL_LINK_CFG_BASE 0X1A107000
#define L2_BASE 0x1C000000
#define VAL_WR_AXI_DRV 777


#define GPIO_PADDIR_0_31_OFFSET 0x0
#define GPIO_PADEN_0_31_OFFSET 0x4
#define GPIO_PADOUT_0_31_OFFSET 0xC
#define GPIO_GPIOEN_32_63_OFFSET 0x3C
#define GPIO_PADIN_32_63_OFFSET 0x40

static inline void wait_cycles(const unsigned cycles)
{
  /**
   * Each iteration of the loop below will take four cycles on RI5CY (one for
   * `addi` and three for the taken `bnez`; if the instructions hit in the
   * I$).  Thus, we let `i` count the number of remaining loop iterations and
   * initialize it to a fourth of the number of clock cyles.  With this
   * initialization, we must not enter the loop if the number of clock cycles
   * is less than four, because this will cause an underflow on the first
   * subtraction.
   */
  register unsigned threshold;
  asm volatile("li %[threshold], 4" : [threshold] "=r" (threshold));
  asm volatile goto("ble %[cycles], %[threshold], %l2"
          : /* no output */
    : [cycles] "r" (cycles), [threshold] "r" (threshold)
          : /* no clobbers */
    : __wait_cycles_end);
  register unsigned i = cycles >> 2;
  __wait_cycles_start:
  // Decrement `i` and loop if it is not yet zero.
  asm volatile("addi %0, %0, -1" : "+r" (i));
  asm volatile goto("bnez %0, %l1"
          : /* no output */
    : "r" (i)
          : /* no clobbers */
    : __wait_cycles_start);
  __wait_cycles_end:
  return;
}

int main(){
  int error=0;

  //config registers
  uint32_t reg=0;
  uint16_t concat=0;
  uint32_t address;
  uint32_t val_wr = 0x00000000;
  uint32_t reg_val = 0x00000000;

  uint16_t *rx_addr= (uint16_t*) 0x1C001000;

  int j;

  #ifdef FPGA_EMULATION
    int baud_rate = 9600;
    int test_freq = 10000000;
  #else
    set_flls();
    int baud_rate = 115200;
    int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4); 

  //Config pad_gpio_b_00 as GPIO
  alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_set( 1 );

  //Set GPIO 0 direction as OUT
  address = ARCHI_GPIO_ADDR + GPIO_PADDIR_0_31_OFFSET;
  val_wr = 0x1;
  pulp_write32(address, val_wr);
  while(pulp_read32(address) != val_wr);

  //Disable the ddr_clk_i by GPIO 0 -> 0
  address = ARCHI_GPIO_ADDR + GPIO_PADOUT_0_31_OFFSET;
  val_wr = 0x0;
  pulp_write32(address, val_wr);
  while(pulp_read32(address) != val_wr);

  //config padframe SERIAL LINK
  alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_set( 1 );

  //Enable the ddr_clk_i by GPIO 0 -> 1
  address = ARCHI_GPIO_ADDR + GPIO_PADOUT_0_31_OFFSET;
  val_wr = 0x1;
  pulp_write32(address, val_wr);
  while(pulp_read32(address) != val_wr);

  address = L2_BASE;
  while(pulp_read32(address) != VAL_WR_AXI_DRV);
  printf("OK read (%d) written into L2 from offchip Serial Link \n",pulp_read32(address));
  
  wait_cycles(50000);

  address = SERIAL_LINK_BASE;

  for (j=0; j< 100; j++) {

    pulp_write32(address,j+100);
    
    wait_cycles(500);
    val_wr=0;

    val_wr=pulp_read32(address);

    if(val_wr!=j+100)
      error++;

    wait_cycles(500);
    address += 4;
  }

  //Test read cfg reg from APB

  /*
    SerialCfgStatus       = 32'h000,
    SerialCfgTrainingMask = 32'h008,
    SerialCfgDelay        = 32'h010
  */
  address = SERIAL_LINK_CFG_BASE;
  val_wr=pulp_read32(address);
  printf ("First read SerialCfgStatus reg: %d \n",val_wr);
  reg_val= 0xFFFFFFFF;
  pulp_write32(address, reg_val);
  reg_val=pulp_read32(address);
  printf ("Read after write SerialCfgStatus reg: %d -> %d \n",val_wr, reg_val);
  if(val_wr==reg_val)
    error++;
  
  if(error!=0)
    printf("Test FAILED with :%d\n",error);
  else
    printf("Test PASSED\n");

  uart_wait_tx_done();

  return error;
}

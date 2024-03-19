/*
 * Copyright (C) 2021 ETH Zurich and University of Bologna
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
#include <stdint.h>
#include "utils.h"
#include "udma.h"
#include "timer.h"

#define BUFFER_SIZE 32

//#define FPGA_EMULATION
//#define SIMPLE_PAD

//#define VERBOSE
//#define EXTRA_VERBOSE

#define TIMER0_OFFSET 0x1A103000
#define TIMER1_OFFSET 0x1A223000
#define TIMER2_OFFSET 0x1A224000
#define TIMER3_OFFSET 0x1A225000
#define TIMER4_OFFSET 0x1A226000
#define TIMER5_OFFSET 0x1A227000
#define TIMER6_OFFSET 0x1A228000
#define TIMER7_OFFSET 0x1A229000

#define PLIC_BASE     0x0C000000
#define PLIC_CHECK    PLIC_BASE + 0x201004

#define PLIC_EN_BITS  PLIC_BASE + 0x2080

#define N_CH 1

int main() {

  int buff;
  int irq = 143;
  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  #ifdef FPGA_EMULATION

  #else
    #ifdef SIMPLE_PAD

    #else
      //out pwm0 - pwm3
      alsaqr_periph_padframe_periphs_a_08_mux_set (3);
      alsaqr_periph_padframe_periphs_a_09_mux_set (3);
      alsaqr_periph_padframe_periphs_a_10_mux_set (2);
      alsaqr_periph_padframe_periphs_a_11_mux_set (2);
      //out pwm4 - pwm7
      alsaqr_periph_padframe_periphs_b_32_mux_set (3);
      alsaqr_periph_padframe_periphs_b_33_mux_set (3);
      alsaqr_periph_padframe_periphs_b_46_mux_set (3);
      alsaqr_periph_padframe_periphs_b_47_mux_set (3);
    #endif
  #endif

  // Clock gating timers

  // TIMER 0 CH0
  enable_timer(TIMER0_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER0_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER0_OFFSET,i,0,0x8);
    set_threshold(TIMER0_OFFSET,i,0,0x8,3);
  }

  // TIMER 1 CH0
  enable_timer(TIMER1_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER1_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER1_OFFSET,i,0,0x8);
    set_threshold(TIMER1_OFFSET,i,0,0x8,3);
  }


  // TIMER 2 CH0
  enable_timer(TIMER2_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER2_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER2_OFFSET,i,0,0x8);
    set_threshold(TIMER2_OFFSET,i,0,0x8,3);
  }



  // TIMER 3 CH0
  enable_timer(TIMER3_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER3_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER3_OFFSET,i,0,0x8);
    set_threshold(TIMER3_OFFSET,i,0,0x8,3);
  }

  // TIMER 4 CH0
  enable_timer(TIMER4_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER4_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER4_OFFSET,i,0,0x8);
    set_threshold(TIMER4_OFFSET,i,0,0x8,3);
  }


  // TIMER 5 CH0
  enable_timer(TIMER5_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER5_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER5_OFFSET,i,0,0x8);
    set_threshold(TIMER5_OFFSET,i,0,0x8,3);
  }


  // TIMER 6 CH0
  enable_timer(TIMER6_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER6_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER6_OFFSET,i,0,0x8);
    set_threshold(TIMER6_OFFSET,i,0,0x8,3);
  }


  // TIMER 7 CH0
  enable_timer(TIMER7_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER7_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER7_OFFSET,i,0,0x8);
    set_threshold(TIMER7_OFFSET,i,0,0x8,3);
  }

  printf("Start channels of each timers...\r\n");
  uart_wait_tx_done();

  // Enable irqs
  pulp_write32(TIMER0_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER1_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER2_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER3_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER4_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER5_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER6_OFFSET+0x100,0xF0000);
  pulp_write32(TIMER7_OFFSET+0x100,0xF0000);

  // Enable CH0 + CH1 per each timer
  for (int i=0; i< N_CH; i++) {
    start_timer(TIMER0_OFFSET, i);
    start_timer(TIMER1_OFFSET, i);
    start_timer(TIMER2_OFFSET, i);
    start_timer(TIMER3_OFFSET, i);
    start_timer(TIMER4_OFFSET, i);
    start_timer(TIMER5_OFFSET, i);
    start_timer(TIMER6_OFFSET, i);
    start_timer(TIMER7_OFFSET, i);
  }

  pulp_write32(PLIC_BASE+irq*4, 1);                                // set mbox interrupt priority to 1
  pulp_write32(PLIC_EN_BITS+(((int)(irq/32))*4), 1<<(irq%32)); // enable interrupt

  for(volatile int i = 0; i<100; i++){
    asm volatile ("wfi");
    buff=pulp_read32(PLIC_CHECK);
    pulp_write32(PLIC_CHECK, irq);
  }
  return 0;

}

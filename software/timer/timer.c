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

#define N_CH 1

int main() {

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
      //out pwm0
      alsaqr_periph_padframe_periphs_a_08_mux_set (3);
      alsaqr_periph_padframe_periphs_a_09_mux_set (3);
      alsaqr_periph_padframe_periphs_a_10_mux_set (2);
      alsaqr_periph_padframe_periphs_a_11_mux_set (2);
      //out pwm1
      alsaqr_periph_padframe_periphs_b_32_mux_set (3);
      alsaqr_periph_padframe_periphs_b_33_mux_set (3);
      alsaqr_periph_padframe_periphs_b_46_mux_set (3);
      alsaqr_periph_padframe_periphs_b_47_mux_set (3);
    #endif
  #endif

  // Clock gating timers

  // TIMER 0 CH0 + CH1
  enable_timer(TIMER0_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER0_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER0_OFFSET,i,0,0x8);
    set_threshold(TIMER0_OFFSET,i,0,0x8,3);
  }

  // TIMER 1 CH0 + CH1
  enable_timer(TIMER1_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER1_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER1_OFFSET,i,0,0x8);
    set_threshold(TIMER1_OFFSET,i,0,0x8,3);
  }


  // TIMER 2 CH0 + CH1
  enable_timer(TIMER2_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER2_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER2_OFFSET,i,0,0x8);
    set_threshold(TIMER2_OFFSET,i,0,0x8,3);
  }



  // TIMER 3 CH0 + CH1
  enable_timer(TIMER3_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER3_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER3_OFFSET,i,0,0x8);
    set_threshold(TIMER3_OFFSET,i,0,0x8,3);
  }

  // TIMER 4 CH0 + CH1
  enable_timer(TIMER4_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER4_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER4_OFFSET,i,0,0x8);
    set_threshold(TIMER4_OFFSET,i,0,0x8,3);
  }


  // TIMER 5 CH0 + CH1
  enable_timer(TIMER5_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER5_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER5_OFFSET,i,0,0x8);
    set_threshold(TIMER5_OFFSET,i,0,0x8,3);
  }


  // TIMER 6 CH0 + CH1
  enable_timer(TIMER6_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER6_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER6_OFFSET,i,0,0x8);
    set_threshold(TIMER6_OFFSET,i,0,0x8,3);
  }


  // TIMER 7 CH0 + CH1
  enable_timer(TIMER7_OFFSET);
  for (int i=0; i< N_CH; i++) {
    config_counter(TIMER7_OFFSET,i,249,0,0xFF,0,0);
    set_counter_range(TIMER7_OFFSET,i,0,0x8);
    set_threshold(TIMER7_OFFSET,i,0,0x8,3);
  }

  printf("Start channels of each timers...\r\n");
  uart_wait_tx_done();

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

  for(volatile int i = 0; i<500000; i++)
    asm volatile ("wfi");

  return 0;

}

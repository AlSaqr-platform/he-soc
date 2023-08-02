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
//#define VERBOSE
//#define EXTRA_VERBOSE

//#define FPGA_EMULATION
#define SIMPLE_PAD

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
    alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set( 2 );
  #else
    #ifdef SIMPLE_PAD
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set( 2 );
    #else
      alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_set (1);
    #endif
  #endif

  // Clock gating timers
  enable_timer();
  for (int i=0; i<2; i++){
    config_counter(i,249,0,0xFF,0,0);
    set_counter_range(i,0,0x8);
    set_threshold(i,0,0x8,3);
  }


  printf("Start all timers...\r\n");
  uart_wait_tx_done();


  start_timer();

  for(volatile int i = 0; i<500000; i++)
    asm volatile ("wfi");

  return 0;

}

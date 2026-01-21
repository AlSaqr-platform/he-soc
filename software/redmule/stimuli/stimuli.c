/*
 * Copyright (C) 2022-2023 ETH Zurich and University of Bologna
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
 * SPDX-License-Identifier: Apache-2.0
 *
 * Author: Yvan Tortorella  <yvan.tortorella@unibo.it>
 *
 * RedMulE SW test
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "archi_redmule.h"
#include "hal_redmule.h"
#include "pulp.h"

#define GPIO2_PAD_A2_ADDR 0x1A10500C

void test_redmule(int *retval);

int retval = -1;

int main() {

  uint32_t gpio_val= 0x00000004;

  synch_barrier();

  //////////
  // TEST //
  //////////

  if(core_id() == 0){
    test_redmule(&retval);
    // Write msg to mailbox
    pulp_write32(0x10403000, retval);
  } else{
    // Cores 1-7 in wfi
    while (1) {
      __asm__ volatile("wfi;");
    }
  }
  return 0;
}

void test_redmule(int *retval) {

  volatile int errors = 0;

  int cycle_start=0;
  int cycle_end=0;
  uint32_t gpio_val= 0x00000004;

  uint16_t m_size = M_SIZE;
  uint16_t n_size = N_SIZE;
  uint16_t k_size = K_SIZE;

  uint8_t *x_ext = x_inp;
  uint8_t *w_ext = w_inp;
  uint8_t *y_ext = y_inp;
  uint8_t *z_ext = z_oup;

  uint8_t volatile *x = (uint8_t volatile *) pi_l1_malloc(0, (2*m_size*n_size));
  uint8_t volatile *w = (uint8_t volatile *) pi_l1_malloc(0, (2*n_size*k_size));
  uint8_t volatile *y = (uint8_t volatile *) pi_l1_malloc(0, (2*m_size*k_size));

  uint8_t volatile *z = (uint8_t volatile *) pi_l1_malloc(0, (2*m_size*k_size));

  #ifdef USE_DMA
    volatile unsigned int dma_id = 0;
    dma_id = mchan_alloc();
    mchan_transfer((unsigned int) 2*(2*m_size*n_size),
                       (unsigned int) x_ext,
                       (unsigned int) x    );
    mchan_barrier(dma_id);
    mchan_free(dma_id);

    dma_id = mchan_alloc();
    mchan_transfer((unsigned int) 2*(2*n_size*k_size),
                       (unsigned int) w_ext,
                       (unsigned int) w    );
    mchan_barrier(dma_id);
    mchan_free(dma_id);

    dma_id = mchan_alloc();
    mchan_transfer((unsigned int) 2*(2*m_size*k_size),
                       (unsigned int) y_ext,
                       (unsigned int) y    );
    mchan_barrier(dma_id);
  #else
    generate_test_data16((int) x, (int) w, (int) y, (int) m_size, (int) n_size, (int) k_size);
  #endif

    int gold_sum = 0, check_sum = 0;
    int i,j;

    int offload_id_tmp, offload_id;

    //printf("Enable Redmule.\r\n");

    //Power Loop
    //while(1){
      // Enable RedMulE
      hwpe_cg_enable();

      hwpe_soft_clear();

      // redmule_cfg ((unsigned int) x,
      //              (unsigned int) w,
      //              (unsigned int) y,
      //              m_size, n_size, k_size,
      //              (uint8_t) GEMM,
      //              (uint8_t) Float16);
      redmule_x_add_set ((unsigned int) x);
      redmule_w_add_set ((unsigned int) w);
      redmule_y_add_set ((unsigned int) y);
      redmule_z_add_set ((unsigned int) z);

      redmule_cfg (m_size, n_size, k_size, gemm_ops);

      ////printf("X: %x , W: %x, Y: %x, Z: %x\r\n", x, w, y, y);

      // Enable perf counter
      /*perf_stop();
      perf_reset();
      cycle_start=cpu_perf_get(CSR_PCER_CYCLES);
      printf("Perf CYCLES INIT: %d\r\n",  cycle_start);
      perf_start();*/

      // Start RedMulE operation
      hwpe_trigger_job();

      // Wait for end of computation
      redmule_evt_wait();

      //printf("Redmule completed.\r\n");
      /*perf_stop();
      cycle_end= cpu_perf_get(CSR_PCER_CYCLES) - cycle_start;
      pulp_write32(0x1C000300, cycle_end);*/
      //printf("Done in %d cycles!\r\n", cycle_end);

      // Disable RedMulE
      hwpe_cg_disable();
      //printf("Redmule disable.\r\n");

      errors = redmule_compare16_err((int) z, (int) m_size, (int) k_size);

      if (errors==0){
          gpio_val ^= 0x00000004;
          pulp_write32(GPIO2_PAD_A2_ADDR,gpio_val);
          //printf("Redmule done in %d cycles!\r\n", cycle_end);
          //uart_wait_tx_done();
      }else{
        pulp_write32(GPIO2_PAD_A2_ADDR,0x00000000);
      }

    //} //while loop

  *(int *) 0x1A1040A0 = errors;

  //printf ("Terminated test with %d errors. See you!\n", errors);

  *retval = errors;
}


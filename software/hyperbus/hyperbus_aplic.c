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
#include "hyperbus_test.h"
#include "encoding.h"
#define BUFFER_SIZE 64
//#define VERBOSE
//#define EXTRA_VERBOSE
#define CSR_MTOPEI 0x35C

int main() {

    #ifdef FPGA_EMULATION
    int baud_rate = 115200;
    int test_freq = 40000000;
    #else
    set_flls();
    int baud_rate = 115200;
    int test_freq = 100000000;
    #endif
    uart_set_cfg(0,(test_freq/baud_rate)>>4);

    int * tx_buffer;
    int * rx_buffer;
    tx_buffer = 0x1C0007B0;
    rx_buffer = 0x1C001000;
    int l3_buffer[BUFFER_SIZE];
    int a;
    int *p;
    int hyper_addr;
    int error =0;
    int id1, id2;
    int pass = 0;
    int periph_id = 28;
    uart_set_cfg(0,(test_freq/baud_rate)>>4);
    // PLIC setup for hyper tx
    int plic_base = 0x0C000000;
    int tx_hyper_plic_id = 139;
    int rx_hyper_plic_id = 138;
    int tx_hyper_imsic_id = 2;
    int rx_hyper_imsic_id = 1;
    
    aplic_init();
    imsic_init();

    config_irq_aplic(rx_hyper_plic_id, rx_hyper_imsic_id, 0);
    config_irq_aplic(tx_hyper_plic_id, tx_hyper_imsic_id, 0);

    udma_hyper_setup();
    set_pagebound_hyper(2048);
    
    set_chipsel_hyper(0);
    for (int i=0; i< (BUFFER_SIZE); i++)
    {
      tx_buffer[i]=0xffff0000+i;
    } 
  #ifdef VERBOSE
    printf("hyper_addr: %d \n", hyper_addr);
  #endif
    barrier();
    udma_hyper_dwrite((BUFFER_SIZE*4),(unsigned int) l3_buffer, (unsigned int)tx_buffer, 128, 0);
    barrier();
    
  #ifdef VERBOSE
    printf("started writing\n");
    int busy=udma_hyper_busy(0);
    printf("BUSY: %d ID:%d \n", udma_hyper_busy(0), 0);
    if(busy) {
      udma_hyper_wait(0);
      printf("BUSY: %d \n", udma_hyper_busy(0));
    }
  #endif

    asm volatile ("wfi");
    imsic_intp_arrive(tx_hyper_imsic_id);
    CSRW(CSR_MTOPEI, 0);
    
    udma_hyper_dread((BUFFER_SIZE*4),(unsigned int) l3_buffer, (unsigned int)rx_buffer, 128, 0);

    asm volatile ("wfi");
    imsic_intp_arrive(rx_hyper_imsic_id);
    CSRW(CSR_MTOPEI, 0);

    aplic_reset(tx_hyper_imsic_id);
    aplic_reset(rx_hyper_imsic_id);

  #ifdef VERBOSE
    printf("start reading\n");
  #endif
    for (int i=0; i< BUFFER_SIZE; i++)
      {      
      #ifdef EXTRA_VERBOSE
      printf("%x\n", rx_buffer[i]);
      #endif
      error += rx_buffer[i] ^ tx_buffer[i];
      }
      #ifdef EXTRA_VERBOSE
      uart_wait_tx_done();
      #endif
      
      if(error!=0) { 
          printf("Test FAILED\n");
          pass=1;
          }
      else printf("Test Passed\n");
      uart_wait_tx_done();

      return pass;
  
    
}

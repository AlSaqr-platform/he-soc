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
#include "udma.h"

#include "udma_uart_v1.h"
#include "udma_uart.c"

#define BUFFER_SIZE 16
#define UART_BAUDRATE 115200
#define N_UART 1


#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080

/*******************************************************************************
**                             IMPORTANT                                      **
**  FPGA_EMULATION AND SIMPLE_PAD MUST BE DEFINED IN MUTUAL EXCLUSION         **
**  IF NOT DEFINED, THE CODE IS SUPPOSED TO BE EXECUTED ON THE FULL PADFRAME  **                                                                        **
**  - FPGA_EMULATION: MUST BE SETTED ONLY WHEN THE CODE RUNS ON FPGA          **
**  - SIMPLE_PAD: MUST BE SETTED ONLY TO SIMULATE THE FPGA PAD ON RTL         **
*******************************************************************************/

#define FPGA_EMULATION
#define SIMPLE_PAD


int uart_read_nb(int uart_id, void *buffer, uint32_t size)
{
  int periph_id = ARCHI_UDMA_UART_ID(uart_id);
  int channel = UDMA_CHANNEL_ID(periph_id);

  unsigned int base = hal_udma_channel_base(channel);

  plp_udma_enqueue(base, (int)buffer, size, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_8);

  //uart_wait_rx_done(periph_id);

  return 0;
}

int uart_write_nb(int uart_id, void *buffer, uint32_t size)
{
  int periph_id = ARCHI_UDMA_UART_ID(uart_id);
  int channel = UDMA_CHANNEL_ID(periph_id) + 1;

  unsigned int base = hal_udma_channel_base(channel);

  plp_udma_enqueue(base, (int)buffer, size, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_8);

  //uart_wait_tx_done(periph_id);

  return 0;
}

int main()
{

  
int error = 0;

//int tx_buffer[BUFFER_SIZE] = {'S','t','a','y',' ','a','t',' ','h','o','m','e','!','!','!','!'};
int *tx_buffer= (int*) 0x1C001000;

//int rx_buffer[BUFFER_SIZE];
int *rx_buffer= (int*) 0x1C002000;

uint32_t tx_uart_plic_id ;
uint32_t rx_uart_plic_id ; 

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
    alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set( 2 ); //tx
    alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set( 2 ); //rx
  #else
    #ifdef SIMPLE_PAD
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set( 2 ); //tx
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set( 2 ); //rx
    #else
      alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_set( 2 ); //tx
      alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_set( 2 );  //rx
    #endif    
  #endif 


printf("uart start\n");
uart_wait_tx_done();


for (int i=0; i <BUFFER_SIZE; i++){
    switch (i) {
      case 0: 
      tx_buffer[i]= 'S';
      break;
      case 1: 
      tx_buffer[i]= 't';
      break;
      case 2: 
      tx_buffer[i]= 'a';
      break;
      case 3: 
      tx_buffer[i]= 'y';
      break;
      case 4: 
      tx_buffer[i]= ' ';
      break;
      case 5: 
      tx_buffer[i]= 'a';
      break;
      case 6: 
      tx_buffer[i]= 't';
      break;
      case 7: 
      tx_buffer[i]= ' ';
      break;
      case 8: 
      tx_buffer[i]= 'h';
      break;
      case 9: 
      tx_buffer[i]= 'o';
      break;
      case 10: 
      tx_buffer[i]= 'm';
      break;
      case 11: 
      tx_buffer[i]= 'e';
      break;
      case 12: 
      tx_buffer[i]= '!';
      break;
      case 13: 
      tx_buffer[i]= '!';
      break;
      case 14: 
      tx_buffer[i]= '!';
      break;
      case 15: 
      tx_buffer[i]= '!';
      break;

      default:
      tx_buffer[i]= 0;
      break;
    }
  }

for (int u = 0; u < N_UART; ++u)
{
  for (int j = 0; j < BUFFER_SIZE; ++j)
  {
    rx_buffer[j] = 0;
  }

  rx_uart_plic_id = ARCHI_UDMA_UART_ID(u)*4 +8 ; //8
  tx_uart_plic_id = ARCHI_UDMA_UART_ID(u)*4 +8 +1; //9

  //printf("[%d, %d] Start test uart %d\n",  get_cluster_id(), get_core_id(), u);
  udma_uart_open(u,test_freq,UART_BAUDRATE);

  for (int i = 0; i < BUFFER_SIZE; ++i)
  {
    uart_write_nb(u,tx_buffer + i,1); //--- non blocking write
    
    //set tx interrupt
    pulp_write32(PLIC_BASE+tx_uart_plic_id*4, 1); // set rx interrupt priority to 1

    //enable interrupt
    pulp_write32(PLIC_EN_BITS+(((int)(tx_uart_plic_id/32))*4), 1<<(tx_uart_plic_id%32)); //enable interrupt

    //  wfi until reading the rx id from the PLIC
    while(pulp_read32(PLIC_CHECK)!=tx_uart_plic_id) {
      asm volatile ("wfi");
    }

    //Set completed Interrupt
    pulp_write32(PLIC_CHECK,tx_uart_plic_id);

    printf("TX Interrupt received\n\r");

    udma_uart_read(u,rx_buffer + i,1);     //--- blocking read

    //set rx interrupt
    pulp_write32(PLIC_BASE+rx_uart_plic_id*4, 1); // set rx interrupt priority to 1

    //enable interrupt
    pulp_write32(PLIC_EN_BITS+(((int)(rx_uart_plic_id/32))*4), 1<<(rx_uart_plic_id%32)); //enable interrupt

    //  wfi until reading the rx id from the PLIC
    while(pulp_read32(PLIC_CHECK)!=rx_uart_plic_id) {
      asm volatile ("wfi");
    }

    //Set completed Interrupt
    pulp_write32(PLIC_CHECK,rx_uart_plic_id);

    printf("RX Interrupt received\n\r");
    
    if (tx_buffer[i] == rx_buffer[i])
    {
      printf("PASS: tx %c, rx %c\n\r", tx_buffer[i],rx_buffer[i]);
    }else{
      printf("FAIL: tx %c, rx %c\n\r", tx_buffer[i],rx_buffer[i]);
      error++;
    }
  }
   udma_uart_close(u);
}

  if (error==0)
    printf("Test PASSED\n\r");
  else
    printf("Test FAILED\n\r");

  uart_wait_tx_done();
  return error;
}

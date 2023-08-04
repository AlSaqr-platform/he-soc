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
 * Mantainer: Victor Isachi (victor.isachi@unibo.it)
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
#define N_USART 4

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

//#define FPGA_EMULATION
//#define SIMPLE_PAD

int usart_read_nb(int usart_id, void *buffer, uint32_t size)
{
  int periph_id = ARCHI_UDMA_USART_ID(usart_id);
  int channel = UDMA_CHANNEL_ID(periph_id);

  unsigned int base = hal_udma_channel_base(channel);

  plp_udma_enqueue(base, (int)buffer, size, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_8);

  return 0;
}

int usart_write_nb(int usart_id, void *buffer, uint32_t size)
{
  int periph_id = ARCHI_UDMA_USART_ID(usart_id);
  int channel = UDMA_CHANNEL_ID(periph_id) + 1;

  unsigned int base = hal_udma_channel_base(channel);

  plp_udma_enqueue(base, (int)buffer, size, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_8);

  return 0;
}

int main()
{
  int error = 0;
  int a, k, setup;

  //int tx_buffer[BUFFER_SIZE] = {'S','t','a','y',' ','a','t',' ','h','o','m','e','!','!','!','!'};
  int *tx_buffer= (int*) 0x1C001000;

  //int rx_buffer[BUFFER_SIZE];
  int *rx_buffer= (int*) 0x1C002000;

  uint32_t tx_usart_plic_id ;
  uint32_t rx_usart_plic_id ; 

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  // USART0
  alsaqr_periph_padframe_periphs_a_28_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_29_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_30_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_31_mux_set( 1 );

  // USART1
  alsaqr_periph_padframe_periphs_a_61_mux_set( 2 );
  alsaqr_periph_padframe_periphs_a_62_mux_set( 2 );
  alsaqr_periph_padframe_periphs_a_63_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_64_mux_set( 1 );

  // USART2
  alsaqr_periph_padframe_periphs_a_69_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_70_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_71_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_72_mux_set( 1 );

  // USART3
  alsaqr_periph_padframe_periphs_a_73_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_74_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_75_mux_set( 1 );
  alsaqr_periph_padframe_periphs_a_76_mux_set( 1 );

  printf("USART start...\n\r");
  uart_wait_tx_done();

  tx_buffer[0]= 'S';
  tx_buffer[1]= 't';
  tx_buffer[2]= 'a';
  tx_buffer[3]= 'y';
  tx_buffer[4]= ' ';
  tx_buffer[5]= 'a';
  tx_buffer[6]= 't';
  tx_buffer[7]= ' ';
  tx_buffer[8]= 'h';
  tx_buffer[9]= 'o';
  tx_buffer[10]= 'm';
  tx_buffer[11]= 'e';
  tx_buffer[12]= '!';
  tx_buffer[13]= '!';
  tx_buffer[14]= '!';
  tx_buffer[15]= '!';

  for (int u = 0; u < N_USART; ++u)
  {
    printf("USART_%0d[control flow OFF] test started...\n\r", u);
    for (int j = 0; j < BUFFER_SIZE; ++j)
    {
      rx_buffer[j] = 0;
    }

    rx_usart_plic_id = ARCHI_UDMA_USART_ID(u)*4 +16 ;
    tx_usart_plic_id = ARCHI_UDMA_USART_ID(u)*4 +16 +1;

    //printf("[%d, %d] Start test uart %d\n",  get_cluster_id(), get_core_id(), u);
    udma_usart_open(u,test_freq,UART_BAUDRATE);

    for (int i = 0; i < BUFFER_SIZE; ++i)
    {
      usart_write_nb(u,tx_buffer + i,1); //--- non blocking write
      
      //set tx interrupt
      pulp_write32(PLIC_BASE+tx_usart_plic_id*4, 1); // set rx interrupt priority to 1

      //enable interrupt
      pulp_write32(PLIC_EN_BITS+(((int)(tx_usart_plic_id/32))*4), 1<<(tx_usart_plic_id%32)); //enable interrupt

      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=tx_usart_plic_id) {
        asm volatile ("wfi");
      }

      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,tx_usart_plic_id);

      //printf("TX Interrupt received\n\r");

      udma_usart_read(u,rx_buffer + i,1);     //--- blocking read

      //set rx interrupt
      pulp_write32(PLIC_BASE+rx_usart_plic_id*4, 1); // set rx interrupt priority to 1

      //enable interrupt
      pulp_write32(PLIC_EN_BITS+(((int)(rx_usart_plic_id/32))*4), 1<<(rx_usart_plic_id%32)); //enable interrupt

      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=rx_usart_plic_id) {
        asm volatile ("wfi");
      }

      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,rx_usart_plic_id);

      //printf("RX Interrupt received\n\r");
      
      if (tx_buffer[i] == rx_buffer[i])
      {
        printf("USART_%0d[control flow OFF] PASS: tx %c, rx %c\n\r", u, tx_buffer[i],rx_buffer[i]);
      }else{
        printf("USART_%0d[control flow OFF] FAIL: tx %c, rx %c\n\r", u, tx_buffer[i],rx_buffer[i]);
        error++;
      }
    }

    printf("USART_%0d[control flow ON] test started...\n\r", u);
    for (int j = 0; j < BUFFER_SIZE; ++j)
    {
      rx_buffer[j] = 0;
    }

    a = k = 0;

    //enable control flow inside uart peripheral
    setup = pulp_read32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(u) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_SETUP_OFFSET);
    setup |= 0x00C0;
    pulp_write32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(u) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_SETUP_OFFSET, setup);

    while(a < BUFFER_SIZE){
      if(pulp_read32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(u) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_STATUS_OFFSET) & 0x0004){
        udma_usart_read(u,rx_buffer + k,1);   //--- blocking read
        k++;
      }else{
        udma_usart_write(u,tx_buffer + a,1);  //--- blocking write
        a++;
      }
    }

    while(k < BUFFER_SIZE){
      udma_usart_read(u,rx_buffer + k,1);   //--- blocking read
      k++;
    }

    for(int i = 0; i < BUFFER_SIZE; ++i){
      if (tx_buffer[i] == rx_buffer[i]){
        printf("USART_%0d[control flow ON] PASS: tx %c, rx %c\n\r", u, tx_buffer[i],rx_buffer[i]);
      }else{
        printf("USART_%0d[control flow ON] FAIL: tx %c, rx %c\n\r", u, tx_buffer[i],rx_buffer[i]);
        error++;
      }
    }

    udma_usart_close(u);
  }

  if (error==0)
    printf("Test PASSED\n\r");
  else
    printf("Test FAILED\n\r");

  uart_wait_tx_done();
  return error;
}

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
 * Mantainer: Mattia Sinigaglia (mattia.sinigaglia5@unibo.it)
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "utils.h"
#include "udma.h"
#include "udma_sdio.h"

#define BLOCK_SIZE 512
#define BLOCK_COUNT 0x0

#define N_SDIO 1
#define SDIO_QUAD_EN 1

#define FPGA_EMUL 0


#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080

void init_sdio (int32_t u, uint32_t * response, int32_t eot_sdio_plic_id){

  uint16_t rca=0;

  sdio_send_cmd (u, CMD0 , 0, response, eot_sdio_plic_id);

  // CMD 8. Get voltage (Only 2.0 Card response to this)
  
  if (FPGA_EMUL)
    sdio_send_cmd(u, CMD8 <<8 | RSP_48_CRC, 0x1AA, response);

  // Wait until busy is clear in the card
  do {
    // Send CMD 55
    sdio_send_cmd(u, CMD55 | RSP_48_CRC , 0, response, eot_sdio_plic_id);

    // Send ACMD 41
    sdio_send_cmd(u, ACMD41  | RSP_48_CRC , 0xC0100000, response, eot_sdio_plic_id);
  } while ((response[0]>>31)  == 0);

  //printf ("CMD2\n");
  sdio_send_cmd (u, CMD2 | RSP_136 , 0, response, eot_sdio_plic_id);

  //printf ("CMD3\n");
  sdio_send_cmd (u, CMD3 | RSP_48_CRC , 0, response, eot_sdio_plic_id);

  rca= (response[0] >> 16) & 0xFFFF;
  printf ("RCA: %x\n", rca);

  sdio_send_cmd (u, CMD9 | RSP_136 , (rca<<16) , response, eot_sdio_plic_id);

  printf ("Card Class = %x\n", response[2] >> 20);

  // setup_card_to_transfer
  // Send CMD 7
  // select the card with previously obtained rca
  sdio_send_cmd (u, CMD7 | RSP_48_CRC , (rca<<16) , response, eot_sdio_plic_id);

  // Set Block Size 512
  // Send CMD 16
  sdio_send_cmd (u, CMD16 | RSP_48_CRC , (rca<<16) , response, eot_sdio_plic_id);
  printf("Card status after Block Size set = %x\n", response[0]);

  // Set bus width
  // Send CMD 55
  sdio_send_cmd (u, CMD55 | RSP_48_CRC , (rca<<16) , response, eot_sdio_plic_id);

  // Send ACMD 6
  if(FPGA_EMUL==0 ){
    if (SDIO_QUAD_EN==1)
      sdio_send_cmd (u, ACMD6 | RSP_48_CRC , 0x80000002 , response, eot_sdio_plic_id);
    else
      sdio_send_cmd (u, ACMD6 | RSP_48_CRC , 0 , response, eot_sdio_plic_id);
  }else
    sdio_send_cmd (u, ACMD6 | RSP_48_CRC , 0 , response, eot_sdio_plic_id);
    
  printf ("End INIT...\n");
}

void sdio_read_response( uint32_t *response, int32_t u){
    response[0] = pulp_read32(UDMA_SDIO_RSP0(u));
    response[1] = pulp_read32(UDMA_SDIO_RSP1(u));
    response[2] = pulp_read32(UDMA_SDIO_RSP2(u));
    response[3] = pulp_read32(UDMA_SDIO_RSP3(u));
    //printf("RES: 0x%08x:%08x:%08x:%08x\n", response[3], response[2], response[1], response[0]);
}

/**
 * Send a command and wait until the sd card answers
 * retuns 1 if an error/timeout happened
 * else response is filled with sdcard response
 **/
void sdio_send_cmd(uint32_t u, uint32_t cmd_op, uint32_t cmd_arg, uint32_t *response, uint32_t eot_sdio_plic_id) {
  
  int status =0;

  //set EOT interrupt
  pulp_write32(PLIC_BASE+eot_sdio_plic_id*4, 1); // set eot interrupt priority to 1
  pulp_write32(PLIC_EN_BITS+(((int)(eot_sdio_plic_id/32))*4), 1<<(eot_sdio_plic_id%32)); //enable interrupt

  pulp_write32(UDMA_SDIO_CMD_OP(u),cmd_op);
  pulp_write32(UDMA_SDIO_CMD_ARG(u),cmd_arg);
  pulp_write32(UDMA_SDIO_START(u),1);   

  //  wfi until reading the EOT id from the PLIC
  while(pulp_read32(PLIC_CHECK)!=eot_sdio_plic_id) {
    asm volatile ("wfi");
  }

  //Set completed Interrupt
  pulp_write32(PLIC_CHECK,eot_sdio_plic_id);

  status = pulp_read32(UDMA_SDIO_STATUS(u));

  if (status & 0x10){
    printf ("Status %d \n", status);
  }else {
    if (status & 0x8)
    printf ("Status ERROR...\n");
  }

  //Clear EOT
  pulp_write32(UDMA_SDIO_STATUS(u), 0x1);

  if(cmd_op != CMD0)
    sdio_read_response(response, u);

}

void test_single_block_write (uint32_t u, uint32_t *tx_buffer, uint32_t *response, uint32_t eot_sdio_plic_id, uint32_t tx_sdio_plic_id ){

  printf ("Write on the SD...\n");

  plp_udma_enqueue(UDMA_SDIO_TX_ADDR(u), (int)tx_buffer, BLOCK_SIZE, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);

  if (FPGA_EMUL==0)
    pulp_write32(UDMA_SDIO_DATA_SETUP(u), ( ((BLOCK_SIZE - 1) <<16) | (0 << 8) | (SDIO_QUAD_EN << 2) | (0 << 1) | 1 ));
  else
    pulp_write32(UDMA_SDIO_DATA_SETUP(u), ( ((BLOCK_SIZE - 1) <<16) | (0 << 8) | (0 << 2) | (0 << 1) | 1 ));

  // Send CMD 24
  sdio_send_cmd(u, CMD24 | RSP_48_CRC, 0x0, response, eot_sdio_plic_id);

  //Set TX interrupt
  pulp_write32(PLIC_BASE+tx_sdio_plic_id*4, 1); // set tx interrupt priority to 1
  pulp_write32(PLIC_EN_BITS+(((int)(tx_sdio_plic_id/32))*4), 1<<(tx_sdio_plic_id%32)); //enable interrupt

    //  wfi until reading the EOT id from the PLIC
  while(pulp_read32(PLIC_CHECK)!=tx_sdio_plic_id) {
    asm volatile ("wfi");
  }

  //Set completed Interrupt
  pulp_write32(PLIC_CHECK,tx_sdio_plic_id);

  printf("End writing...\n"); 

  //Clear Data Setup
  pulp_write32(UDMA_SDIO_DATA_SETUP(u), 0x0 );
}

void test_single_block_read (uint32_t u, uint32_t *rx_buffer , uint32_t *response, uint32_t eot_sdio_plic_id, uint32_t rx_sdio_plic_id){
    
  printf ("Read from the SD...\n");

  plp_udma_enqueue(UDMA_SDIO_RX_ADDR(u), (int)rx_buffer, BLOCK_SIZE, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);

  if (FPGA_EMUL==0)
    pulp_write32(UDMA_SDIO_DATA_SETUP(u), ( ((BLOCK_SIZE - 1) <<16) | (0 << 8) | (SDIO_QUAD_EN << 2) | (1 << 1) | 1));
  else
    pulp_write32(UDMA_SDIO_DATA_SETUP(u), ( ((BLOCK_SIZE - 1) <<16) | (0 << 8) | (0 << 2) | (1 << 1) | 1));

  // Send CMD 17
  sdio_send_cmd(u, CMD17 | RSP_48_CRC, 0x0, response, eot_sdio_plic_id);   
    
  //Set RX interrupt
  pulp_write32(PLIC_BASE+rx_sdio_plic_id*4, 1); // set rx interrupt priority to 1
  pulp_write32(PLIC_EN_BITS+(((int)(rx_sdio_plic_id/32))*4), 1<<(rx_sdio_plic_id%32)); //enable interrupt

  //  wfi until reading the EOT id from the PLIC
  while(pulp_read32(PLIC_CHECK)!=rx_sdio_plic_id) {
    asm volatile ("wfi");
  }

  //Set completed Interrupt
  pulp_write32(PLIC_CHECK,rx_sdio_plic_id);

  printf("End reading...\n");

  //Clear Data Setup
  pulp_write32(UDMA_SDIO_DATA_SETUP(u), 0x0 );   
}

int main()
{
  
  int error = 0;
  int u=0;

  uint32_t *tx_buffer= (uint32_t*) 0x1C001000;
  uint32_t *rx_buffer= (uint32_t*) 0x1C002000;   
  uint32_t *response=  (uint32_t*) 0x1C003000;

  uint32_t tx_sdio_plic_id ;
  uint32_t rx_sdio_plic_id ; 
  uint32_t eot_sdio_plic_id ; 
  uint32_t err_sdio_plic_id ; 
  

  int clk_div= (1<<8) | 3;

  volatile uint32_t resp[4] = {0};

  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
    
  alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_set( 1 );
  alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_set( 1 );

for (int u = 0; u<N_SDIO; u++){

    for(int i = 0; i < BLOCK_SIZE*2 ; i++) {
        tx_buffer[i] = i;
        rx_buffer[i] = 0xFF;
    }

    /* Set plic id for TX, RX, EOT and ERR
    Plics events for a periph with id = N are mapped as
    n_evt[i]=N*4+8+i , with i=[0:3].
    Each periph has 4 event signals it can use. The first
    8 events are already mapped to other non-udma signals.
   */

    rx_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +8 ; //107
    tx_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +8 +1; //108
    eot_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +8 +2; //109
    err_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +8 +3; //110

    //--- enable all the udma channels (see below for selective enable)
    plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));

    //Set clkDIV
    pulp_write32(UDMA_SDIO_CLK_DIV(u), clk_div );

    ////////////////////////////////////////////////////////////////
    //                                                            //
    //  INIT SEQUENCE                                             //
    //                                                            //
    //  CMD 0. Reset Card                                         //
    //  CMD 8. Get voltage (Only 2.0 Card response to this)       //
    //  CMD55. Indicate Next Command are Application specific     //
    //  ACMD44. Get Voltage windows                               //
    //  CMD2. CID reg                                             //
    //  CMD3. Get RCA.                                            //
    //  CMD9. Get CSD.                                            //
    //  CMD13. Get Status.                                        //
    //  setup card for transfer                                   //
    //  CMD 7. Put Card in transfer state                         //
    //  CMD 16. Set block size                                    //
    //  CMD 55.                                                   //
    //  ACMD 6. Set bus width                                     //
    //                                                            //
    ////////////////////////////////////////////////////////////////

    init_sdio (u, response, eot_sdio_plic_id);

    

    /////////////////////////////////////////////////////////////////
    //                                                             //
    //  Send and receive data                                      //
    //  init card                                                  //
    //  CMD 24. Write data                                         //
    //  CMD 17. Read data                                          //
    //                                                             //
    /////////////////////////////////////////////////////////////////

    test_single_block_write (u,tx_buffer, response, eot_sdio_plic_id, tx_sdio_plic_id);

    ////////////////////////////////////////////////////////////////
    //                                                            //
    //  CMD 7. Put Card in transfer state                         //
    //  CMD 16. Set block size                                    //
    //  CMD 55.                                                   //
    //  ACMD 6. Set bus width                                     //
    //  CMD 17. Read single block                                 //
    //                                                            //
    ////////////////////////////////////////////////////////////////

    test_single_block_read (u,rx_buffer, response, eot_sdio_plic_id, rx_sdio_plic_id);

    ////////////////////////////////////////////////////////////////
    //                                                            //
    //                       ERROR CHECK                          //
    //                                                            //
    ////////////////////////////////////////////////////////////////

    /* Print RX_BUFFER */
    for(int i = 0; i < BLOCK_SIZE/4; i++) {
      //printf ("TX: %x - RX: %x \n", tx_buffer[i], rx_buffer[i]);
        if(rx_buffer[i] != tx_buffer[i]){
          error++;
          //printf ("[%d] TX: %x - RX: %x \n",i, tx_buffer[i], rx_buffer[i]);
        }
    }

  }
    
  if(error!=0)
    printf("Test FAILED with %d \n", error);
  else
    printf("Test PASSED\n");

  uart_wait_tx_done();

  return error;
}

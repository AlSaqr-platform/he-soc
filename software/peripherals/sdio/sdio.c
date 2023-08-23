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

#define PRINTF_ON

#define BLOCK_COUNT_MUL 2
#define SDIO_QUAD_EN 1

#define USE_PLIC 0
/*TEST PLIC FAIL*/

/*******************************************************************************
**                             IMPORTANT                                      **
**  FPGA_EMULATION AND SIMPLE_PAD MUST BE DEFINED IN MUTUAL EXCLUSION         **
**  IF NOT DEFINED, THE CODE IS SUPPOSED TO BE EXECUTED ON THE FULL PADFRAME  **                                                                        **
**  - FPGA_EMULATION: MUST BE SETTED ONLY WHEN THE CODE RUNS ON FPGA          **
**  - SIMPLE_PAD: MUST BE SETTED ONLY TO SIMULATE THE FPGA PAD ON RTL         **
*******************************************************************************/

//#define FPGA_EMULATION
#define SIMPLE_PAD

#ifdef FPGA_EMULATION
  #define N_SDIO 1
#else
  #ifdef SIMPLE_PAD
    #define N_SDIO 1
  #else
    #define N_SDIO 2
  #endif
#endif

#define FPGA_CLK_DIV 1920


#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080



void init_sdio (int32_t u, uint32_t * response, int32_t eot_sdio_plic_id, int32_t err_sdio_plic_id){

  uint32_t arg=0;
  uint16_t rca=0;
  int err=0;

  sdio_send_cmd (u, CMD0 , 0, response, eot_sdio_plic_id, err_sdio_plic_id);

  #ifdef PRINTF_ON
    printf("---------- INIT ----------\n\r");
    uart_wait_tx_done();
  #endif

  // CMD 8. Get voltage (Only 2.0 Card response to this) - Resp R7
  //0x1AA tell the uSD that the host power supply is between 2.7 - 3.3 Volt
  #ifdef FPGA_EMULATION
    sdio_send_cmd(u, CMD8 | RSP_48_CRC, 0x1AA, response, eot_sdio_plic_id, err_sdio_plic_id);
    arg|= 0x5<<28 | 0<<24 | 0xF<<20;
  #else
    arg= 0xC0100000;
  #endif

  

  // Wait until busy is clear into the card
  do {
    // Send CMD 55 - Resp R1
    sdio_send_cmd(u, CMD55 | RSP_48_CRC , 0, response, eot_sdio_plic_id, err_sdio_plic_id);
    
    // Send ACMD 41 - Resp R3
    sdio_send_cmd(u, ACMD41  | RSP_48_CRC , arg, response, eot_sdio_plic_id, err_sdio_plic_id);
  } while ((response[0]>>31) ==0);

  //CMD2 - Resp R2
  sdio_send_cmd (u, CMD2 | RSP_136 , 0, response, eot_sdio_plic_id, err_sdio_plic_id);

  //CMD3 - Resp R6
  sdio_send_cmd (u, CMD3 | RSP_48_CRC , 0, response, eot_sdio_plic_id, err_sdio_plic_id);
  rca= (response[0] >> 16) & 0xFFFF;

  #ifdef PRINTF_ON
    printf ("RCA: %x\n\r", rca);
    uart_wait_tx_done();
  #endif
  

  //CMD9 - Resp R2
  err=sdio_send_cmd (u, CMD9 | RSP_136 , (rca<<16) , response, eot_sdio_plic_id, err_sdio_plic_id);

  #ifdef PRINTF_ON
    printf ("Card Class = %x\n\r", response[2] >> 20);
    uart_wait_tx_done();
  #endif
  

  #ifdef FPGA_EMULATION
    sdio_send_cmd (u, CMD13 | RSP_48_CRC , (rca<<16) , response, eot_sdio_plic_id, err_sdio_plic_id);
  #endif

  // setup_card_to_transfer
  // Send CMD 7 - Resp R1b
  // select the card with previously obtained rca
  err=sdio_send_cmd (u, CMD7 | RSP_48_CRC , rca<<16 , response, eot_sdio_plic_id, err_sdio_plic_id);

  // Set Block Size 512
  // Send CMD 16 - Resp R1
  sdio_send_cmd (u, CMD16 | RSP_48_CRC , BLOCK_SIZE , response, eot_sdio_plic_id, err_sdio_plic_id);
  
  #ifdef PRINTF_ON
    printf("Card status after Block Size set = %x\n\r", response[0]);
    uart_wait_tx_done();
  #endif



  // Set bus width
  // Send CMD 55 - Resp R1
  err=sdio_send_cmd (u, CMD55 | RSP_48_CRC , rca<<16 , response, eot_sdio_plic_id, err_sdio_plic_id);

  // Send ACMD 6 - Resp R1
  sdio_send_cmd (u, ACMD6 | RSP_48_CRC , SDIO_QUAD_EN ? 2 : 0 , response, eot_sdio_plic_id, err_sdio_plic_id);
  
  #ifdef PRINTF_ON
    printf ("---------- END INIT ----------\n\r");
    uart_wait_tx_done();
  #endif
  
}

void sdio_read_response( uint32_t *response, int32_t u){
    response[0] = pulp_read32(UDMA_SDIO_RSP0(u));
    response[1] = pulp_read32(UDMA_SDIO_RSP1(u));
    response[2] = pulp_read32(UDMA_SDIO_RSP2(u));
    response[3] = pulp_read32(UDMA_SDIO_RSP3(u));
    //printf("RESPONSE: 0x%08x:%08x:%08x:%08x\n\r", response[3], response[2], response[1], response[0]);
    //uart_wait_tx_done();
}

/**
 * Send a command and wait until the sd card answers
 * retuns 1 if an error/timeout happened
 * else response is filled with sdcard response
 **/
int sdio_send_cmd(uint32_t u, uint32_t cmd_op, uint32_t cmd_arg, uint32_t *response, uint32_t eot_sdio_plic_id, uint32_t err_sdio_plic_id) {
  
  uint32_t status =0;
  int error = 0;
  uint32_t temp=0;

  if (USE_PLIC==1){

    #ifdef PRINTF_ON
      printf("Set EOT and ERR PLIC interrupt..\n\r");
      uart_wait_tx_done();
    #endif

    //set EOT interrupt
    pulp_write32(PLIC_BASE+eot_sdio_plic_id*4, 1); // set eot interrupt priority to 1
    pulp_write32(PLIC_EN_BITS+(((int)(eot_sdio_plic_id/32))*4), 1<<(eot_sdio_plic_id%32)); //enable interrupt

    //set ERR interrupt
    pulp_write32(PLIC_BASE+err_sdio_plic_id*4, 1); // set eot interrupt priority to 1
    pulp_write32(PLIC_EN_BITS+(((int)(err_sdio_plic_id/32))*4), pulp_read32(PLIC_EN_BITS+(((int)(err_sdio_plic_id/32))*4)) | 1<<(err_sdio_plic_id%32)); //enable interrupt

    #ifdef PRINTF_ON
      printf("Interrupt setted..\n\r");
      uart_wait_tx_done(); 
    #endif

    

  }

  pulp_write32(UDMA_SDIO_CMD_OP(u),cmd_op);
  barrier();
  pulp_write32(UDMA_SDIO_CMD_ARG(u),cmd_arg);
  barrier();
  pulp_write32(UDMA_SDIO_START(u),1);
  barrier();

  if (USE_PLIC==0){

    //POLLING
    do{
      status=pulp_read32(UDMA_SDIO_STATUS(u));
      barrier();
    }while(status ==0);

    if((status & 0x00000003)!=0x1){

      //printf("Received ERR...Status %08x >> %08x \n\r",status, status>>16);
      //uart_wait_tx_done();
      
      switch ((status>>16)& 0xFFFFFFFF) {
        case UDMA_SDIO_NO_ERR_CMD: 
          break;
        case UDMA_SDIO_RESP_TIME_OUT_CMD: 
          //printf("UDMA_SDIO_RESP_TIME_OUT_CMD...\n\r");
          //uart_wait_tx_done();
          error=UDMA_SDIO_RESP_TIME_OUT_CMD;
          break;
        case UDMA_SDIO_RESP_WRONG_DIR_CMD: 
          //printf("UDMA_SDIO_RESP_WRONG_DIR_CMD...\n\r");
          //uart_wait_tx_done();
          error=UDMA_SDIO_RESP_WRONG_DIR_CMD;
          break;
        case UDMA_SDIO_RESP_BUSY_TOUT_CMD: 
          //printf("UDMA_SDIO_RESP_BUSY_TOUT_CMD...\n\r");
          //uart_wait_tx_done();
          error=UDMA_SDIO_RESP_BUSY_TOUT_CMD;
          break;
        
        default:
        break;
      }

      switch ((status>>24)& 0xFFFFFFFF) {
        case UDMA_SDIO_NO_ERR_DATA: 
          break;
        case UDMA_SDIO_RESP_TIME_OUT_DATA: 
          //printf("UDMA_SDIO_RESP_TIME_OUT_DATA...\n\r");
          //uart_wait_tx_done();
          error=UDMA_SDIO_RESP_TIME_OUT_DATA;
          break;
        
        default:
        break;
      }
    }

    //Clear EOT and ERR
    pulp_write32(UDMA_SDIO_STATUS(u), 0x3);

  }else{

    //PLIC
    #ifdef PRINTF_ON
      printf("Wait For Interrupt\n\r");
      uart_wait_tx_done();
    #endif
    
    //  wfi until reading the EOT id from the PLIC
    while(pulp_read32(PLIC_CHECK)!=eot_sdio_plic_id && pulp_read32(PLIC_CHECK)!=err_sdio_plic_id) {
      asm volatile ("wfi");
    }

    #ifdef PRINTF_ON
      printf("Interrupt received...\n\r");
      uart_wait_tx_done(); 
    #endif

    //Set completed EOT Interrupt
    pulp_write32(PLIC_CHECK,eot_sdio_plic_id);
    //Set completed ERR Interrupt
    pulp_write32(PLIC_CHECK,err_sdio_plic_id);

    status = pulp_read32(UDMA_SDIO_STATUS(u));

    //Clear EOT and ERR
    pulp_write32(UDMA_SDIO_STATUS(u), 0x3);

  } 

  if(cmd_op != CMD0)
    sdio_read_response(response, u);

  return error;

}

void test_single_block_write (uint32_t u, uint32_t *tx_buffer, uint32_t *response, uint32_t eot_sdio_plic_id, uint32_t err_sdio_plic_id, uint32_t tx_sdio_plic_id ){
  int poll_var=0;

  #ifdef PRINTF_ON
    printf ("Write on the SD...\n\r");
    uart_wait_tx_done(); 
  #endif

  plp_udma_enqueue(UDMA_SDIO_TX_ADDR(u), (int)tx_buffer, BLOCK_SIZE, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
  
  pulp_write32(UDMA_SDIO_DATA_SETUP(u), ( ((BLOCK_SIZE - 1) <<16) | (0 << 8) | (SDIO_QUAD_EN << 2) | (0 << 1) | 1 ));

  // Send CMD 24
  sdio_send_cmd(u, CMD24 | RSP_48_CRC, BLOCK_COUNT, response, eot_sdio_plic_id, err_sdio_plic_id);

  if (USE_PLIC==0){
    do {
      poll_var = pulp_read32(UDMA_CHANNEL_SIZE_OFFSET + UDMA_SDIO_TX_ADDR(u));
      barrier();
    } while(poll_var != 0);

  }else{

    #ifdef PRINTF_ON
      printf("Set TX PLIC interrupt..\n\r");
      uart_wait_tx_done(); 
    #endif

    //Set TX interrupt
    pulp_write32(PLIC_BASE+tx_sdio_plic_id*4, 1); // set tx interrupt priority to 1
    pulp_write32(PLIC_EN_BITS+(((int)(tx_sdio_plic_id/32))*4), 1<<(tx_sdio_plic_id%32)); //enable interrupt

    #ifdef PRINTF_ON
      printf("TX Interrupt setted..\n\r");
      uart_wait_tx_done();  
    #endif

    //  wfi until reading the EOT id from the PLIC
    while(pulp_read32(PLIC_CHECK)!=tx_sdio_plic_id) {
      asm volatile ("wfi");
    }

    #ifdef PRINTF_ON
      printf("Received TX Interrupt ...\n\r");
      uart_wait_tx_done();  
    #endif

    //Set completed Interrupt
    pulp_write32(PLIC_CHECK,tx_sdio_plic_id);
  }

  #ifdef PRINTF_ON
    printf("End writing...\n\r");
    uart_wait_tx_done();  
  #endif

  //Clear Data Setup
  pulp_write32(UDMA_SDIO_DATA_SETUP(u), 0x0 );
}

void test_single_block_read (uint32_t u, uint32_t *rx_buffer , uint32_t *response, uint32_t eot_sdio_plic_id, uint32_t err_sdio_plic_id, uint32_t rx_sdio_plic_id){
  int poll_var=0;

  #ifdef PRINTF_ON
    printf ("Read from the SD...\n\r");
    uart_wait_tx_done();  
  #endif

  plp_udma_enqueue(UDMA_SDIO_RX_ADDR(u), (int)rx_buffer, BLOCK_SIZE, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
 
  pulp_write32(UDMA_SDIO_DATA_SETUP(u), ( ((BLOCK_SIZE - 1) <<16) | (0 << 8) | (SDIO_QUAD_EN << 2) | (1 << 1) | 1));

  // Send CMD 17
  sdio_send_cmd(u, CMD17 | RSP_48_CRC, BLOCK_COUNT, response, eot_sdio_plic_id, err_sdio_plic_id);   
    
  if (USE_PLIC==0){
    do {
      //printf ("Polling on UDMA_SDIO_RX_ADDR until != 0...\n\r");
      //uart_wait_tx_done();
      poll_var = pulp_read32(UDMA_CHANNEL_SIZE_OFFSET + UDMA_SDIO_RX_ADDR(u));
      barrier();
    } while(poll_var != 0);
  }else{
    
    #ifdef PRINTF_ON
      printf("Set RX PLIC interrupt..\n\r");
      uart_wait_tx_done();  
    #endif

    //Set RX interrupt
    pulp_write32(PLIC_BASE+rx_sdio_plic_id*4, 1); // set rx interrupt priority to 1
    pulp_write32(PLIC_EN_BITS+(((int)(rx_sdio_plic_id/32))*4), 1<<(rx_sdio_plic_id%32)); //enable interrupt

    #ifdef PRINTF_ON
      printf("RX Interrupt setted..\n\r");
      uart_wait_tx_done();  
    #endif
    
    //  wfi until reading the EOT id from the PLIC
    while(pulp_read32(PLIC_CHECK)!=rx_sdio_plic_id) {
      asm volatile ("wfi");
    }

    #ifdef PRINTF_ON
      printf("Received RX Interrupt ...\n\r");
      uart_wait_tx_done();  
    #endif

    //Set completed Interrupt
    pulp_write32(PLIC_CHECK,rx_sdio_plic_id);
  }

  #ifdef PRINTF_ON
    printf("End reading...\n\r");
    uart_wait_tx_done();  
  #endif

  //Clear Data Setup
  pulp_write32(UDMA_SDIO_DATA_SETUP(u), 0x0 );   
}


int main(){
  
  int error = 0;
  int clk_div=0;

  uint32_t *tx_buffer= (uint32_t*) 0x1C001000;
  uint32_t *rx_buffer= (uint32_t*) 0x1C002000;   
  uint32_t *response=  (uint32_t*) 0x1C003000;

  uint32_t tx_sdio_plic_id ;
  uint32_t rx_sdio_plic_id ; 
  uint32_t eot_sdio_plic_id ; 
  uint32_t err_sdio_plic_id ; 
  
  // 1920 200KHz FPGA
  // 1920 200KHz FPGA

  #ifdef FPGA_EMULATION
    clk_div= (1<<8) | FPGA_CLK_DIV; //200KHz FPGA
  #else
    clk_div= (1<<8) | 3;
  #endif


  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4); 
    
  for (int u = 0; u<N_SDIO; u++){

    #ifdef PRINTF_ON
      printf ("Testing SDIO_%0d...\n\r", u);
    #endif

    #ifdef FPGA_EMULATION
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_set( 2 );
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_set( 2 );
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_set( 2 );
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_set( 2 );
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_set( 2 );
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_set( 2 );
    #else
      #ifdef SIMPLE_PAD
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_set( 2 );
      #else
        switch(u){
          case 0:
            //Config padframe on SPIO0
            alsaqr_periph_padframe_periphs_a_18_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_19_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_20_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_21_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_22_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_23_mux_set( 1 );
            break;
          case 1:
            //Config padframe on SPIO1
            alsaqr_periph_padframe_periphs_a_58_mux_set( 2 );
            alsaqr_periph_padframe_periphs_a_59_mux_set( 1 );
            alsaqr_periph_padframe_periphs_b_25_mux_set( 2 );
            alsaqr_periph_padframe_periphs_a_60_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_61_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_62_mux_set( 1 );
            break;
        }
      #endif 
    #endif

    for(int i = 0; i < BLOCK_SIZE*2 ; i++) {
        tx_buffer[i] = i+349;
        rx_buffer[i] = 0xFF;
    }

    /* Set plic id for TX, RX, EOT and ERR
    Plics events for a periph with id = N are mapped as
    n_evt[i]=N*4+8+i , with i=[0:3].
    Each periph has 4 event signals it can use. The first
    8 events are already mapped to other non-udma signals.
   */

    rx_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +16 ; //115
    tx_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +16 +1; //116
    eot_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +16 +2; //117
    err_sdio_plic_id = ARCHI_UDMA_SDIO_ID(u)*4 +16 +3; //118

    //--- enable all the udma channels (see below for selective enable)
    plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));

    //Set clkDIV
    pulp_write32(UDMA_SDIO_CLK_DIV(u), clk_div );

    /*printf("UDMA_SDIO_CMD_OP ADDRESS %08x \n\r", UDMA_SDIO_CMD_OP(u));
    uart_wait_tx_done();

    printf("UDMA_SDIO_CMD_ARG ADDRESS %08x \n\r", UDMA_SDIO_CMD_ARG(u));
    uart_wait_tx_done();

    printf("UDMA_SDIO_START ADDRESS %08x \n\r", UDMA_SDIO_START(u));
    uart_wait_tx_done();

    printf("UDMA_SDIO_STATUS ADDRESS %08x \n\r", UDMA_SDIO_STATUS(u));
    uart_wait_tx_done();*/

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

    init_sdio (u, response, eot_sdio_plic_id, err_sdio_plic_id);

    /////////////////////////////////////////////////////////////////
    //                                                             //
    //  Send and receive data                                      //
    //  init card                                                  //
    //  CMD 24. Write data                                         //
    //  CMD 17. Read data                                          //
    //                                                             //
    /////////////////////////////////////////////////////////////////

    test_single_block_write (u,tx_buffer, response, eot_sdio_plic_id, err_sdio_plic_id, tx_sdio_plic_id);


    ////////////////////////////////////////////////////////////////
    //                                                            //
    //  CMD 7. Put Card in transfer state                         //
    //  CMD 16. Set block size                                    //
    //  CMD 55.                                                   //
    //  ACMD 6. Set bus width                                     //
    //  CMD 17. Read single block                                 //
    //                                                            //
    ////////////////////////////////////////////////////////////////

    test_single_block_read (u,rx_buffer, response, eot_sdio_plic_id, err_sdio_plic_id, rx_sdio_plic_id);

   

    ////////////////////////////////////////////////////////////////
    //                                                            //
    //                ERROR SINGLE BLOK CHECK                     //
    //                                                            //
    ////////////////////////////////////////////////////////////////

    /* Print RX_BUFFER */
    for(int i = 0; i < BLOCK_SIZE/4; i++) {
      //printf ("TX: %x - RX: %x \n\r", tx_buffer[i], rx_buffer[i]);
      //uart_wait_tx_done();
        if(rx_buffer[i] != tx_buffer[i]){
          error++;
          printf ("SDIO_%0d: [%d] TX = %x - RX = %x \n\r", u, i, tx_buffer[i], rx_buffer[i]);
          //uart_wait_tx_done();
        }
    }
    
    uart_wait_tx_done();  
  }
  if(error!=0)
    printf("Test FAILED with %d errors\n\r", error);
  else
    printf("Test PASSED\n\r");

  return error;
}

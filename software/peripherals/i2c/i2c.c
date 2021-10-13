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
#include "../../inc/udma/udma.h"
#include "../../inc/udma/i2c/udma_i2c_v2.h"

#define DATA_SIZE 4
#define BUFFER_SIZE 10
#define BUFFER_SIZE_READ 12
#define N_I2C 1

int main()
{
  int pass = 1;
  int error = 0;
  int u=0;

  uint8_t *expected_rx_buffer= (uint8_t*) 0x1C001000;
  uint8_t *rx_buffer= (uint8_t*) 0x1C002000;
  uint32_t *cmd_buffer_wr = (uint32_t*) 0x1C003000;
  uint32_t *cmd_buffer_rd = (uint32_t*) 0x1C004000;

  //Expected datas
  /*uint8_t expected_rx_buffer[DATA_SIZE]={ 0xCA,
                                      0x00,
                                      0xDE,
                                      0xCA};*/
   for (int i=0; i <4; i++){
    switch (i) {
      case 0: 
      expected_rx_buffer[i]= 0xCA;
      break;
      case 1: 
      expected_rx_buffer[i]= 0x00;
      break;
      case 2: 
      expected_rx_buffer[i]= 0xDE;
      break;
      case 3: 
      expected_rx_buffer[i]= 0xCA;
      break;
      default:
      expected_rx_buffer[i]= 0;
      break;
    }
  }


  //--- rx buffer
  //volatile uint8_t rx_buffer[DATA_SIZE];
  //--- CMD buffer for WRITE command
  /*volatile uint32_t cmd_buffer_wr[BUFFER_SIZE] = {(((uint32_t)I2C_CMD_CFG) << 24) | 0x40,
                                                 (((uint32_t)I2C_CMD_START)<<24),
                                                 (((uint32_t)I2C_CMD_WRB)<<24) | 0xa0, //Control-->write
                                                 (((uint32_t)I2C_CMD_WRB)<<24), //Addr MSB
                                                 (((uint32_t)I2C_CMD_WRB)<<24), //ADDR LSB
                                                 (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[0], //DATA0
                                                 (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[1], //DATA1
                                                 (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[2], //DATA2
                                                 (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[3], //DATA3
                                                 (((uint32_t)I2C_CMD_STOP)<<24)};*/

   for (int i=0; i <10; i++){
    switch (i) {
      case 0: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_CFG) << 24) | 0x40;
      break;
      case 1: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_START)<<24);
      break;
      case 2: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa0;
      break;
      case 3: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24);
      break;
      case 4: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24);
      break;
      case 5: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[0];
      break;
      case 6: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[1];
      break;
      case 7: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[2];
      break;
      case 8: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[3];
      break;
      case 9: 
      cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_STOP)<<24);
      break;
      default:
      cmd_buffer_wr[i]= 0;
      break;
    }
  }


 //--- CMD buffer for READ command
  /*volatile uint32_t cmd_buffer_rd[BUFFER_SIZE_READ] = {(((uint32_t)I2C_CMD_CFG)<<24) | 0x40,
                                                 (((uint32_t)I2C_CMD_START)<<24),
                                                 (((uint32_t)I2C_CMD_WRB)<<24 | 0xa0), //Control-->write (the address)
                                                 (((uint32_t)I2C_CMD_WRB)<<24), //Addr MSB
                                                 (((uint32_t)I2C_CMD_WRB)<<24), //ADDR LSB
                                                 (((uint32_t)I2C_CMD_START)<<24),
                                                 (((uint32_t)I2C_CMD_WRB)<<24 | 0xa1), //Control--> read
                                                 (((uint32_t)I2C_CMD_RD_ACK)<<24), //DATA0
                                                 (((uint32_t)I2C_CMD_RD_ACK)<<24), //DATA1
                                                 (((uint32_t)I2C_CMD_RD_ACK)<<24), //DATA2
                                                 (((uint32_t)I2C_CMD_RD_NACK)<<24), //DATA3
                                                 (((uint32_t)I2C_CMD_STOP)<<24)};*/

  for (int i=0; i <12; i++){
    switch (i) {
      case 0: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_CFG)<<24) | 0x40;
      break;
      case 1: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_START)<<24);
      break;
      case 2: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24 | 0xa0);
      break;
      case 3: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24);
      break;
      case 4: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24);
      break;
      case 5: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_START)<<24);
      break;
      case 6: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24 | 0xa1);
      break;
      case 7: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
      break;
      case 8: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
      break;
      case 9: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
      break;
      case 10: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
      break;
      case 11: 
      cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_STOP)<<24);
      break;
      default:
      cmd_buffer_rd[i]= 0;
      break;
    }
  }                                               

  //FIX PRINTF UART
  #ifdef FPGA_EMULATION
      int baud_rate = 9600;
      int test_freq = 10000000;
  #else
      int baud_rate = 115200;
      int test_freq = 17500000;
  #endif  
      uart_set_cfg(0,(test_freq/baud_rate)>>4);
    
    
  for (u=0;u<N_I2C;u++) {

    //WRITE

    //printf("[%d, %d] Start test i2c write %d\n",  get_cluster_id(), get_core_id(),u);

    //--- enable all the udma channels (see below for selective enable)
    plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));

    //--- get the base address of the udma channels
    unsigned int udma_i2c_channel_base = hal_udma_channel_base(UDMA_CHANNEL_ID(ARCHI_UDMA_I2C_ID(u)));
    //printf("uDMA i2c%d base channel address %8x\n", u,udma_i2c_channel_base);

    expected_rx_buffer[1]=u;

    cmd_buffer_wr[2] = (((uint32_t)I2C_CMD_WRB)<<24) | 0xa0 | u<<1;
    cmd_buffer_wr[6] = (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[1];

    plp_udma_enqueue(UDMA_I2C_TX_ADDR(u), (int)expected_rx_buffer, 4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_8);
    //--- enqueue cmds on cmd channel
    plp_udma_enqueue(UDMA_I2C_CMD_ADDR(u) ,  (int)cmd_buffer_wr     , BUFFER_SIZE*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);

    // WAIT WRITE TO BE DONE BY THE MEMORY
    for (volatile int i = 0; i < 25000; ++i)
    {
      i++;
    }

    //READ

    //--- clear the rx buffer
    for (int j = 0; j < DATA_SIZE; ++j)
    {
      rx_buffer[j] = 0;
    }

    //printf("[%d, %d] Start test i2c read %d\n",  get_cluster_id(), get_core_id(),u);

    //--- enable all the udma channels (see below for selective enable)
    plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));

    //--- get the base address of the udma channels
    //unsigned int udma_i2c_channel_base = hal_udma_channel_base(UDMA_CHANNEL_ID(ARCHI_UDMA_I2C_ID(u)));
    //printf("uDMA i2c%d base channel address %8x\n", u,udma_i2c_channel_base);

    //--- enqueue cmds on cmd channel and set the rx channel

    cmd_buffer_rd[2] = (((uint32_t)I2C_CMD_WRB)<<24) | 0xa0 | u<<1;
    cmd_buffer_rd[6] = (((uint32_t)I2C_CMD_WRB)<<24) | 0xa1 | u<<1;

    plp_udma_enqueue(UDMA_I2C_DATA_ADDR(u) ,  (int)rx_buffer     , 4               , UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_8);
    plp_udma_enqueue(UDMA_I2C_CMD_ADDR(u) ,  (int)cmd_buffer_rd  , BUFFER_SIZE_READ*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
    for (volatile int i = 0; i < 25000; ++i)
    {
      i++;
    }
    for (int i = 0; i < DATA_SIZE; ++i)
    {
      if (rx_buffer[i]!=expected_rx_buffer[i])
      {
        printf("rx_buffer[%0d]=0x%0x different from expected 0x%0x\n", i, rx_buffer[i], expected_rx_buffer[i]);
        error++;
      }
      else
        printf("rx_buffer[%0d]=0x%0x as expected\n", i, rx_buffer[i]);

      uart_wait_tx_done();
    }
    
      
    
  }
  if(error!=0)
    printf("Test FAILED\n");
  else
    printf("Test PASSED\n");

  uart_wait_tx_done();

  return error;
}
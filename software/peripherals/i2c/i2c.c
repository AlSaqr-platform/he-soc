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
#include "udma_i2c_v2.h"

#define DATA_SIZE 4
#define BUFFER_SIZE 10
#define BUFFER_SIZE_READ 12

#define N_I2C 1

#define I2C_MEM0 0x50
#define I2C_MEM1 0x51

/*******************************************************************************
**                             IMPORTANT                                      **
**  FPGA_EMULATION AND SIMPLE_PAD MUST BE DEFINED IN MUTUAL EXCLUSION         **
**  IF NOT DEFINED, THE CODE IS SUPPOSED TO BE EXECUTED ON THE FULL PADFRAME  **                                                                        **
**  - FPGA_EMULATION: MUST BE SETTED ONLY WHEN THE CODE RUNS ON FPGA          **
**  - SIMPLE_PAD: MUST BE SETTED ONLY TO SIMULATE THE FPGA PAD ON RTL         **
*******************************************************************************/

//#define SIMPLE_PAD
//#define FPGA_EMULATION

//#define VERBOSE
//#define PRINTF_ON

int main()
{
  int error = 0;
  int u=0;

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  #ifdef PRINTF_ON
    printf ("I2C Variable Declaration...\n\r");
    uart_wait_tx_done();
  #endif 

  uint8_t *expected_rx_buffer= (uint8_t*) 0x1C001000;
  
  #ifdef PRINTF_ON
    printf ("Declare expected_rx_buffer..\n\r");
    uart_wait_tx_done();
  #endif 

  uint8_t *rx_buffer= (uint8_t*) 0x1C002000;

  #ifdef PRINTF_ON
    printf ("Declare rx_buffer..\n\r");
    uart_wait_tx_done();   
  #endif
  
  uint32_t *cmd_buffer_wr = (uint32_t*) 0x1C003000;
  
  #ifdef PRINTF_ON
    printf ("Declare cmd_buffer_wr..\n\r");
    uart_wait_tx_done();    
  #endif

  uint32_t *cmd_buffer_rd = (uint32_t*) 0x1C004000;
  
  #ifdef PRINTF_ON
    printf ("Declare cmd_buffer_rd..\n\r");
    uart_wait_tx_done(); 
  #endif

  for (u=0;u<N_I2C;u++) {

    #ifdef PRINTF_ON
    printf ("Test I2C: %d \n\r", u);
    uart_wait_tx_done(); 
    #endif

    //Expected datas
     for (int i=0; i <4; i++){
      switch (i) {
        case 0: 
          expected_rx_buffer[i]= 0xCA;
          break;
        case 1: 
          expected_rx_buffer[i]= u; // this value change for each I2C selected by u
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

    /*
      - I2C_CMD_WRB
        This command requires that each byte must be attached to each sequence of commands (divider, address+dir, data0...)
        The IP automatically sends the data to the i2c device selected by the address.
        To do so you only need to write the cmd_buffer into the UDMA_I2C_CMD_ADDR register of the I2C peripheral
    */

     for (int i=0; i <BUFFER_SIZE; i++){
      switch (i) {
        case 0: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_CFG) << 24) | 0x40; // sets 16 bit clock divider
          break;
        case 1: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_START)<<24); //cmd start
          break;
        case 2: 
          if (u==0){
            cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa0;  // write I2C_MEM0 address + direction bit
          }else{
            cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa2; // write I2C_MEM1 address + direction bit
          }
          break;
        case 3: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24); 
          break;
        case 4: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24);
          break;
        case 5: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[0]; //DATA0
          break;
        case 6: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[1]; //DATA1
          break;
        case 7: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[2]; //DATA2
          break;
        case 8: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[3]; //DATA3
          break;
        case 9: 
          cmd_buffer_wr[i]= (((uint32_t)I2C_CMD_STOP)<<24);
          break;
        default:
          cmd_buffer_wr[i]= 0;
          break;
      }
    }

    for (int i=0; i <BUFFER_SIZE_READ; i++){
      switch (i) {
        case 0: 
          cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_CFG)<<24) | 0x40; // set 16bit clock divider
          break;
        case 1: 
          cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_START)<<24);
          break;
        case 2: 
          if (u==0){
            cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa0;
          }else{
            cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa2;
          }
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
          if (u==0){
            cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa1; //write addr+dir (0xa1) on bus
          }else{
            cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_WRB)<<24) | 0xa3;
          }
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
          cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_RD_NACK)<<24);
          break;
        case 11: 
          cmd_buffer_rd[i]= (((uint32_t)I2C_CMD_STOP)<<24);
          break;
        default:
          cmd_buffer_rd[i]= 0;
          break;
      }
    }  

    #ifdef PRINTF_ON
      printf ("Setting padmux...\n\r");
      uart_wait_tx_done();     
    #endif   


    #ifdef FPGA_EMULATION
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set( 1 );
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set( 1 );
    #else
      #ifdef SIMPLE_PAD
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set( 1 );
      #else
        alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_set( 2 );
        alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_set( 2 );

        // Uncomment this two lines to test the i2c1 in RTL
        //alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_set( 2 );
        //alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_set( 2 );
      #endif    
    #endif 

    #ifdef PRINTF_ON
      printf ("End setting padmux...\n\r");
      uart_wait_tx_done(); 
    #endif  
    
    //WRITE

    //--- enable all the udma channels (see below for selective enable)

    #ifdef PRINTF_ON
      printf ("Enable CG peripherals...\n\r");
      uart_wait_tx_done();
    #endif
    
    plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));

    #ifdef PRINTF_ON
      printf ("Peripherals enabled...\n\r");
      uart_wait_tx_done();
    #endif

    #ifdef PRINTF_ON
      printf ("Enqueue UDMA_I2C_TX_ADDR...\n\r");
      uart_wait_tx_done();
    #endif
    
    //--- enqueue cmds on cmd channel
    #ifdef PRINTF_ON
      printf ("Enqueue UDMA_I2C_CMD_ADDR Write...\n\r");
      uart_wait_tx_done();
    #endif

    plp_udma_enqueue(UDMA_I2C_CMD_ADDR(u) ,  (int)cmd_buffer_wr , BUFFER_SIZE*4, 0);

    #ifdef PRINTF_ON
      printf ("WAIT WRITE TO BE DONE BY THE MEMORY ...\n\r");
      uart_wait_tx_done();
    #endif
    
    // WAIT WRITE TO BE DONE BY THE MEMORY
    for (volatile int i = 0; i < 90000; ++i) //75000
    {
      i++;
    }

    //READ
    #ifdef PRINTF_ON
      printf ("Clear the rx buffer...\n\r");
      uart_wait_tx_done();
    #endif

    //--- clear the rx buffer
    for (int j = 0; j < DATA_SIZE; ++j)
    {
      rx_buffer[j] = 0;
    }

    #ifdef PRINTF_ON
      printf ("Enqueue UDMA_I2C_DATA_ADDR...\n\r");
      uart_wait_tx_done();  
    #endif

    plp_udma_enqueue(UDMA_I2C_DATA_ADDR(u) ,  (int)rx_buffer  , 4  , 0);

    #ifdef PRINTF_ON
      printf ("Enqueue UDMA_I2C_CMD_ADDR Read...\n\r");
      uart_wait_tx_done();
    #endif

    plp_udma_enqueue(UDMA_I2C_CMD_ADDR(u) ,  (int)cmd_buffer_rd  , BUFFER_SIZE_READ*4, 0);

    for (volatile int i = 0; i < 10000; ++i)
    {
      i++;
    }
    for (int i = 0; i < DATA_SIZE; ++i)
    {
      if (rx_buffer[i]!=expected_rx_buffer[i])
      {
        #ifdef VERBOSE
          printf("rx_buffer[%0d]=0x%0x different from expected 0x%0x\n", i, rx_buffer[i], expected_rx_buffer[i]);
        #endif
        error++;
      }
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

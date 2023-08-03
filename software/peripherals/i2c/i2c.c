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
#include "apb_timer.h"

#define DATA_SIZE 4
#define BUFFER_SIZE 10
#define BUFFER_SIZE_READ 12

#define N_I2C 6

#define I2C_MEM0_ADDR_BASE 0xA0
#define I2C_MEM1_ADDR_BASE 0xA0
#define I2C_MEM2_ADDR_BASE 0xA2
#define I2C_MEM3_ADDR_BASE 0xA4
#define I2C_MEM4_ADDR_BASE 0xA6
#define I2C_MEM5_ADDR_BASE 0xA6

#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080

//2 TIMER APB
#define N_TIMER 1

#define USE_PLIC 1

/*******************************************************************************
**                             IMPORTANT                                      **
**  FPGA_EMULATION AND SIMPLE_PAD MUST BE DEFINED IN MUTUAL EXCLUSION         **
**  IF NOT DEFINED, THE CODE IS SUPPOSED TO BE EXECUTED ON THE FULL PADFRAME  **                                                                        **
**  - FPGA_EMULATION: MUST BE SETTED ONLY WHEN THE CODE RUNS ON FPGA          **
**  - SIMPLE_PAD: MUST BE SETTED ONLY TO SIMULATE THE FPGA PAD ON RTL         **
*******************************************************************************/

//#define SIMPLE_PAD
//#define FPGA_EMULATION

#define VERBOSE
#define PRINTF_ON

int main()
{
  int error = 0;
  int u=0;

  uint32_t tx_i2c_plic_id ;
  uint32_t rx_i2c_plic_id ; 
  uint32_t cmd_i2c_plic_id ; 
  uint32_t eot_i2c_plic_id ; 

  uint32_t timer_0_plic_id ; // 3 e 4


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
    expected_rx_buffer[0]= 0xCA;
    expected_rx_buffer[1]= u; // this value change for each I2C selected by u
    expected_rx_buffer[2]= 0xDE;
    expected_rx_buffer[3]= 0xCA;

    /*
      - I2C_CMD_WRB
        This command requires that each byte must be attached to each sequence of commands (divider, address+dir, data0...)
        The IP automatically sends the data to the i2c device selected by the address.
        To do so you only need to write the cmd_buffer into the UDMA_I2C_CMD_ADDR register of the I2C peripheral
    */

    cmd_buffer_wr[0]= (((uint32_t)I2C_CMD_CFG) << 24) | 0x40; // sets 16 bit clock divider
    cmd_buffer_wr[1]= (((uint32_t)I2C_CMD_START)<<24); //cmd start
    switch(u){
      case 0:
        cmd_buffer_wr[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM0_ADDR_BASE | 0x0; // write I2C_MEM0 address + direction bit
        break;
      case 1:
        cmd_buffer_wr[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM1_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
      case 2:
        cmd_buffer_wr[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM2_ADDR_BASE | 0x0; // write I2C_MEM2 address + direction bit
        break;
      case 3:
        cmd_buffer_wr[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM3_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
      case 4:
        cmd_buffer_wr[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM4_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
      case 5:
        cmd_buffer_wr[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM5_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
    }
    cmd_buffer_wr[3]= (((uint32_t)I2C_CMD_WRB)<<24); 
    cmd_buffer_wr[4]= (((uint32_t)I2C_CMD_WRB)<<24);
    cmd_buffer_wr[5]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[0]; //DATA0
    cmd_buffer_wr[6]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[1]; //DATA1
    cmd_buffer_wr[7]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[2]; //DATA2
    cmd_buffer_wr[8]= (((uint32_t)I2C_CMD_WRB)<<24) | expected_rx_buffer[3]; //DATA3
    cmd_buffer_wr[9]= (((uint32_t)I2C_CMD_STOP)<<24);



    cmd_buffer_rd[0]= (((uint32_t)I2C_CMD_CFG)<<24) | 0x40; // set 16bit clock divider
    cmd_buffer_rd[1]= (((uint32_t)I2C_CMD_START)<<24);
    switch(u){
      case 0:
        cmd_buffer_rd[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM0_ADDR_BASE | 0x0; // write I2C_MEM0 address + direction bit
        break;
      case 1:
        cmd_buffer_rd[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM1_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
      case 2:
        cmd_buffer_rd[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM2_ADDR_BASE | 0x0; // write I2C_MEM2 address + direction bit
        break;
      case 3:
        cmd_buffer_rd[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM3_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
      case 4:
        cmd_buffer_rd[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM4_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
      case 5:
        cmd_buffer_rd[2]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM5_ADDR_BASE | 0x0; // write I2C_MEM1 address + direction bit
        break;
    }
    cmd_buffer_rd[3]= (((uint32_t)I2C_CMD_WRB)<<24);
    cmd_buffer_rd[4]= (((uint32_t)I2C_CMD_WRB)<<24);
    cmd_buffer_rd[5]= (((uint32_t)I2C_CMD_START)<<24);
    switch(u){
      case 0:
        cmd_buffer_rd[6]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM0_ADDR_BASE | 0x1; // write I2C_MEM0 address + direction bit
        break;
      case 1:
        cmd_buffer_rd[6]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM1_ADDR_BASE | 0x1; // write I2C_MEM1 address + direction bit
        break;
      case 2:
        cmd_buffer_rd[6]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM2_ADDR_BASE | 0x1; // write I2C_MEM2 address + direction bit
        break;
      case 3:
        cmd_buffer_rd[6]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM3_ADDR_BASE | 0x1; // write I2C_MEM1 address + direction bit
        break;
      case 4:
        cmd_buffer_rd[6]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM4_ADDR_BASE | 0x1; // write I2C_MEM1 address + direction bit
        break;
      case 5:
        cmd_buffer_rd[6]= (((uint32_t)I2C_CMD_WRB)<<24) | I2C_MEM5_ADDR_BASE | 0x1; // write I2C_MEM1 address + direction bit
        break;
    }
    cmd_buffer_rd[7]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
    cmd_buffer_rd[8]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
    cmd_buffer_rd[9]= (((uint32_t)I2C_CMD_RD_ACK)<<24);
    cmd_buffer_rd[10]= (((uint32_t)I2C_CMD_RD_NACK)<<24);
    cmd_buffer_rd[11]= (((uint32_t)I2C_CMD_STOP)<<24);


    #ifdef PRINTF_ON
      printf ("Setting padmux...\n\r");
      uart_wait_tx_done();     
    #endif   


    #ifdef FPGA_EMULATION
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set( 2 ); //TODO: updated with the new FPGA padframe
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set( 2 ); //TODO: updated with the new FPGA padframe
    #else
      #ifdef SIMPLE_PAD
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set( 2 ); //TODO: updated with the new FPGA padframe
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set( 2 ); //TODO: updated with the new FPGA padframe
      #else
        switch (u){
          case 0:
            alsaqr_periph_padframe_periphs_a_00_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_01_mux_set( 1 );
            break;
          case 1:
            alsaqr_periph_padframe_periphs_a_26_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_27_mux_set( 1 );
            break;
          case 2:
            alsaqr_periph_padframe_periphs_a_36_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_37_mux_set( 1 );
            break;
          case 3:
            alsaqr_periph_padframe_periphs_a_42_mux_set( 2 );
            alsaqr_periph_padframe_periphs_a_43_mux_set( 2 );
            break;
          case 4:
            alsaqr_periph_padframe_periphs_a_57_mux_set( 2 );
            alsaqr_periph_padframe_periphs_a_58_mux_set( 1 );
            break;
          case 5:
            alsaqr_periph_padframe_periphs_a_67_mux_set( 1 );
            alsaqr_periph_padframe_periphs_a_68_mux_set( 1 );
            break;
        }

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

    //--- enqueue cmds on cmd channel
    #ifdef PRINTF_ON
      printf ("Enqueue UDMA_I2C_CMD_ADDR Write...\n\r");
      uart_wait_tx_done();
    #endif

    rx_i2c_plic_id = ARCHI_UDMA_I2C_ID(u)*4 +16 ; //96
    tx_i2c_plic_id = ARCHI_UDMA_I2C_ID(u)*4 +16 +1; //97
    cmd_i2c_plic_id = ARCHI_UDMA_I2C_ID(u)*4 +16 +2; //98
    eot_i2c_plic_id = ARCHI_UDMA_I2C_ID(u)*4 +16 +3; //99

    timer_0_plic_id=5;

    plp_udma_enqueue(UDMA_I2C_CMD_ADDR(u) ,  (int)cmd_buffer_wr , BUFFER_SIZE*4, 0);

    #ifdef PRINTF_ON
      printf ("WAIT WRITE TO BE DONE BY THE MEMORY ...\n\r");
      uart_wait_tx_done();
    #endif

    if (USE_PLIC==0){
      // WAIT WRITE TO BE DONE BY THE MEMORY
      for (volatile int i = 0; i < 45000; ++i) //75000
      {
        i++;
      }

    }else {

      #ifdef PRINTF_ON
        printf ("Set interrupt on cmd_i2c_plic_id...\n\r");
        uart_wait_tx_done();    
      #endif 
      
      //Set CMD interrupt
      pulp_write32(PLIC_BASE+cmd_i2c_plic_id*4, 1); // set rx interrupt priority to 1
      
      #ifdef PRINTF_ON
        printf ("Enable interrupt on rx_spi_plic_id...\n\r");
        uart_wait_tx_done();
      #endif 
      
      pulp_write32(PLIC_EN_BITS+(((int)(cmd_i2c_plic_id/32))*4), 1<<(cmd_i2c_plic_id%32)); //enable interrupt

      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=cmd_i2c_plic_id) {
        asm volatile ("wfi");
      }

      #ifdef PRINTF_ON
        printf ("Interrupt received and clear...\n\r");
        uart_wait_tx_done();
      #endif 

      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,cmd_i2c_plic_id);

      // WRITE COMMAND COMPLETED

      //SET TIMER INTERRUPT FOR MEMORY CONSTRAINT (BEFORE TO STORE THE DATA IT REQUIRES SOME TIME)
      apb_timer_set_value(N_TIMER-1,0);
      apb_timer_set_compare(N_TIMER-1,1500000);

      apb_timer_enable(N_TIMER-1,8); //it count every 8 cycles
      
      pulp_write32(PLIC_BASE+timer_0_plic_id*4, 1); 
      pulp_write32(PLIC_EN_BITS+(((int)(timer_0_plic_id/32))*4), 1<<(timer_0_plic_id%32)); //enable interrupt
      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=timer_0_plic_id) {
        asm volatile ("wfi");
      }
      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,timer_0_plic_id);

      apb_timer_disable(N_TIMER-1);

      //Timer EXPIRED
      #ifdef PRINTF_ON
        printf ("Interrupt received from TIMER 0...\n\r");
        uart_wait_tx_done();    
      #endif 
    }

    //READ FROM MEMORY
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
    
    /*for (int i=0; i<BUFFER_SIZE_READ; i++){
      printf ("cmd_buffer_rd[%d]=0x%0x ..\n\r",i, cmd_buffer_rd[i]);
      uart_wait_tx_done();
    }*/

    if (USE_PLIC==0){
      for (volatile int i = 0; i < 10000; ++i) //75000
      {
        i++;
      }

    }else {

      #ifdef PRINTF_ON
        printf ("Set interrupt on cmd_i2c_plic_id...\n\r");
        uart_wait_tx_done();    
      #endif 
      
      //Set CMD interrupt
      pulp_write32(PLIC_BASE+cmd_i2c_plic_id*4, 1); // set rx interrupt priority to 1
      
      #ifdef PRINTF_ON
        printf ("Enable interrupt on rx_spi_plic_id...\n\r");
        uart_wait_tx_done();
      #endif 
      
      pulp_write32(PLIC_EN_BITS+(((int)(cmd_i2c_plic_id/32))*4), 1<<(cmd_i2c_plic_id%32)); //enable interrupt

      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=cmd_i2c_plic_id) {
        asm volatile ("wfi");
      }

      #ifdef PRINTF_ON
        printf ("Interrupt received and clear...\n\r");
        uart_wait_tx_done();
      #endif 

      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,cmd_i2c_plic_id);

      //SET TIMER INTERRUPT FOR MEMORY CONSTRAINT (BEFORE TO STORE THE DATA IT REQUIRES SOME TIME)
      /*apb_timer_set_value(N_TIMER-1,0);
      apb_timer_set_compare(N_TIMER-1,10000);

      apb_timer_enable(N_TIMER-1,8); //it count every 8 cycles
      
      pulp_write32(PLIC_BASE+timer_0_plic_id*4, 1); 
      pulp_write32(PLIC_EN_BITS+(((int)(timer_0_plic_id/32))*4), 1<<(timer_0_plic_id%32)); //enable interrupt
      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=timer_0_plic_id) {
        asm volatile ("wfi");
      }

      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,timer_0_plic_id);

      apb_timer_disable(N_TIMER-1);

      //Timer EXPIRED
      #ifdef PRINTF_ON
        printf ("Interrupt received from TIMER 0...\n\r");
        uart_wait_tx_done();    
      #endif */

      #ifdef PRINTF_ON
        printf ("Set interrupt on rx_i2c_plic_id...\n\r");
        uart_wait_tx_done();    
      #endif 
      
      //Set CMD interrupt
      pulp_write32(PLIC_BASE+rx_i2c_plic_id*4, 1); // set rx interrupt priority to 1
      
      #ifdef PRINTF_ON
        printf ("Enable interrupt on rx_spi_plic_id...\n\r");
        uart_wait_tx_done();
      #endif 
      
      pulp_write32(PLIC_EN_BITS+(((int)(rx_i2c_plic_id/32))*4), 1<<(rx_i2c_plic_id%32)); //enable interrupt

      //  wfi until reading the rx id from the PLIC
      while(pulp_read32(PLIC_CHECK)!=rx_i2c_plic_id) {
        asm volatile ("wfi");
      }

      #ifdef PRINTF_ON
        printf ("Interrupt received and clear...\n\r");
        uart_wait_tx_done();
      #endif 

      //Set completed Interrupt
      pulp_write32(PLIC_CHECK,rx_i2c_plic_id);
    }

    for (int i = 0; i < DATA_SIZE; ++i)
    {
      if (rx_buffer[i]!=expected_rx_buffer[i])
      {
        #ifdef VERBOSE
          printf("i2c_%0d: rx_buffer[%0d]=0x%0x different from expected 0x%0x\n", u, i, rx_buffer[i], expected_rx_buffer[i]);
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

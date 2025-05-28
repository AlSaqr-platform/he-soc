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
#include "udma_spim_v3.h"
#include "flash_page.h"


#define REG_PADFUN0_OFFSET  0x10
#define REG_PADFUN1_OFFSET  0x14
#define REG_PADFUN2_OFFSET  0x18
#define REG_PADFUN3_OFFSET  0x1C
#define REG_PADCFG0_OFFSET  0x24
#define REG_PADCFG1_OFFSET  0x28
#define REG_PADCFG2_OFFSET  0x2C
#define REG_PADCFG3_OFFSET  0x30
#define REG_PADCFG4_OFFSET  0x34
#define REG_PADCFG5_OFFSET  0x38
#define REG_PADCFG6_OFFSET  0x3C
#define REG_PADCFG7_OFFSET  0x40
#define REG_PADCFG8_OFFSET  0x44
#define REG_PADCFG9_OFFSET  0x48
#define REG_PADCFG10_OFFSET 0x4C
#define REG_PADCFG11_OFFSET 0x50
#define REG_PADCFG12_OFFSET 0x54
#define REG_PADCFG13_OFFSET 0x58
#define REG_PADCFG14_OFFSET 0x5C
#define REG_PADCFG15_OFFSET 0x60

#define OUT 1
#define IN  0

// #define PRINTF_ON

/*******************************************************************************
**                             IMPORTANT                                      **
**  FPGA_EMULATION AND SIMPLE_PAD MUST BE DEFINED IN MUTUAL EXCLUSION         **
**  IF NOT DEFINED, THE CODE IS SUPPOSED TO BE EXECUTED ON THE FULL PADFRAME  **                                                                        **
**  - FPGA_EMULATION: MUST BE SETTED ONLY WHEN THE CODE RUNS ON FPGA          **
**  - SIMPLE_PAD: MUST BE SETTED ONLY TO SIMULATE THE FPGA PAD ON RTL         **
*******************************************************************************/

// #define SIMPLE_PAD
// #define FPGA_EMULATION

#ifndef FPGA_EMULATION
  #ifndef SIMPLE_PAD
    #define N_SPI 11
  #else
    #define N_SPI 1
  #endif
#else
  #define N_SPI 1
#endif

#define CLOCK_DIV 2

#define BUFFER_SIZE 16

#define TEST_PAGE_SIZE 256

#define PLIC_BASE 0x0C000000
#define PLIC_CHECK PLIC_BASE + 0x201004
//enable bits for sources 0-31
#define PLIC_EN_BITS  PLIC_BASE + 0x2080

#define USE_PLIC 1
/*TEST PLIC OK*/

int pad_fun_offset[4] = {REG_PADFUN0_OFFSET,REG_PADFUN1_OFFSET,REG_PADFUN2_OFFSET,REG_PADFUN3_OFFSET};
int pad_cfg_offset[16] = {REG_PADCFG0_OFFSET,REG_PADCFG1_OFFSET,REG_PADCFG2_OFFSET,REG_PADCFG3_OFFSET,REG_PADCFG4_OFFSET,REG_PADCFG5_OFFSET,REG_PADCFG6_OFFSET,REG_PADCFG7_OFFSET,REG_PADCFG8_OFFSET,REG_PADCFG9_OFFSET,REG_PADCFG10_OFFSET,REG_PADCFG11_OFFSET,REG_PADCFG12_OFFSET,REG_PADCFG13_OFFSET,REG_PADCFG14_OFFSET,REG_PADCFG15_OFFSET};

static inline void wait_cycles(const unsigned cycles)
{
  /**
   * Each iteration of the loop below will take four cycles on RI5CY (one for
   * `addi` and three for the taken `bnez`; if the instructions hit in the
   * I$).  Thus, we let `i` count the number of remaining loop iterations and
   * initialize it to a fourth of the number of clock cyles.  With this
   * initialization, we must not enter the loop if the number of clock cycles
   * is less than four, because this will cause an underflow on the first
   * subtraction.
   */
  register unsigned threshold;
  asm volatile("li %[threshold], 4" : [threshold] "=r" (threshold));
  asm volatile goto("ble %[cycles], %[threshold], %l2"
          : /* no output */
    : [cycles] "r" (cycles), [threshold] "r" (threshold)
          : /* no clobbers */
    : __wait_cycles_end);
  register unsigned i = cycles >> 2;
  __wait_cycles_start:
  // Decrement `i` and loop if it is not yet zero.
  asm volatile("addi %0, %0, -1" : "+r" (i));
  asm volatile goto("bnez %0, %l1"
          : /* no output */
    : "r" (i)
          : /* no clobbers */
    : __wait_cycles_start);
  __wait_cycles_end:
  return;
}

int main(){

  #if N_SPI == 11
    int N_REPS[N_SPI] = {2, 1, 2, 2, 2, 1, 1, 1, 1, 1, 2};
  #else
    int N_REPS[N_SPI] = {1};
  #endif

  int u=0;
  int poll_var=0;

  // Store all udma's buffers into the L2 memory
  int *memory_page = (int*) 0x1C003000;
  int *tx_buffer_cmd_program = (int*) 0x1C003500;
  int *addr_buffer = (int*) 0x1C004000;
  int *tx_buffer_cmd_read = (int*) 0x1C004500;
  int *rx_page= (int*) 0x1C005000;
  int *tx_buffer_cmd_read_ID= (int*) 0x1C005500;
  int *tx_buffer_cmd_read_WIP = (int*) 0x1C006000;
  int *sr1= (int*) 0x1C006500;
  int *tx_buffer_cmd_erase= (int*) 0x1C007000;


  int *rems_resp= (int*) 0x1C007500;


  int error[N_SPI];
  int temp=0;

  uint32_t tx_spi_plic_id ;
  uint32_t rx_spi_plic_id ;
  uint32_t cmd_spi_plic_id ;
  uint32_t eot_spi_plic_id ;

  printf("Test spim starting...\r\n");
  uart_wait_tx_done();
  //--- refer to this manual for the commands
  //--- https://www.cypress.com/file/216421/download

  #ifdef PRINTF_ON
    printf ("Start test SPI...\n\r");
    uart_wait_tx_done();
  #endif

  for(int i=0; i<N_SPI;i++){
    error[i]=0;
  }

  #ifdef PRINTF_ON
    printf ("Write memory_page...\n\r");
    uart_wait_tx_done();
  #endif

  // Reading address
  for (int i=0; i <260; i++){
    #ifdef FPGA_EMULATION
      memory_page[i] = page[i];
    #else
      if(i<4)
        memory_page[i] = 0x00;
      else
        memory_page[i] = i-4;
    #endif
  }

  #ifdef PRINTF_ON
    printf ("Write tx_buffer_cmd_program...\n\r");
    uart_wait_tx_done();
  #endif

  //--- TX command sequence
  tx_buffer_cmd_program[0]= SPI_CMD_CFG(CLOCK_DIV,0,0);
  tx_buffer_cmd_program[1]= SPI_CMD_SOT(0);
  tx_buffer_cmd_program[2]= SPI_CMD_SEND_CMD(0x06,8,0); //Write enable
  tx_buffer_cmd_program[3]= SPI_CMD_EOT(0,0);
  tx_buffer_cmd_program[4]= SPI_CMD_SOT(0);
  tx_buffer_cmd_program[5]= SPI_CMD_SEND_CMD(0x12,8,0); //Page program to write 4bytes on he flash
  tx_buffer_cmd_program[6]= SPI_CMD_TX_DATA(4,4,8,0,0); //SPI_CMD_TX_DATA(4,0,8,0,0);
  tx_buffer_cmd_program[7]= SPI_CMD_TX_DATA(TEST_PAGE_SIZE,TEST_PAGE_SIZE,8,0,0);
  tx_buffer_cmd_program[8]= SPI_CMD_EOT(0,0);


  #ifdef PRINTF_ON
    printf ("Reset addr_buffer...\n\r");
    uart_wait_tx_done();

  #endif


  //reading address
  for (int i=0; i <4; i++){
    addr_buffer[i] = 0x00;
  }

  #ifdef PRINTF_ON
    printf ("Write tx_buffer_cmd_read...\n\r");
    uart_wait_tx_done();
  #endif

  // Command sequence to read from SPI flash
  tx_buffer_cmd_read[0]= SPI_CMD_CFG(CLOCK_DIV,0,0);
  tx_buffer_cmd_read[1]= SPI_CMD_SOT(0);
  tx_buffer_cmd_read[2]= SPI_CMD_SEND_CMD(0x13,8,0); //--- read command
  tx_buffer_cmd_read[3]= SPI_CMD_TX_DATA(4,4,8,0,0); //SPI_CMD_TX_DATA(4,0,8,0,0); //--- send the read address
  tx_buffer_cmd_read[4]= SPI_CMD_RX_DATA(TEST_PAGE_SIZE,TEST_PAGE_SIZE,8,0,0); //SPI_CMD_RX_DATA(TEST_PAGE_SIZE,0,8,0,0); //
  tx_buffer_cmd_read[5]= SPI_CMD_EOT(0,0);


  #ifdef PRINTF_ON
    printf ("Write tx_buffer_cmd_read_WIP...\n\r");
    uart_wait_tx_done();
  #endif

  // Command sequence to read the Work-In-Progress satus from FLASH
  tx_buffer_cmd_read_WIP[0]= SPI_CMD_CFG(CLOCK_DIV,0,0);
  tx_buffer_cmd_read_WIP[1]= SPI_CMD_SOT(0);
  tx_buffer_cmd_read_WIP[2]= SPI_CMD_SEND_CMD(0x05,8,0);
  tx_buffer_cmd_read_WIP[3]= SPI_CMD_RX_DATA(1,0,8,0,0);//SPI_CMD_RX_DATA(1,TEST_PAGE_SIZE,8,0,0);
  tx_buffer_cmd_read_WIP[4]= SPI_CMD_EOT(0,0);


  #ifdef PRINTF_ON
    printf ("Write tx_buffer_cmd_read_ID...\n\r");
    uart_wait_tx_done();
  #endif


  // Read ID command from FLASH
  tx_buffer_cmd_read_ID[0]= SPI_CMD_CFG(CLOCK_DIV,0,0);
  tx_buffer_cmd_read_ID[1]= SPI_CMD_SOT(0);
  tx_buffer_cmd_read_ID[2]= SPI_CMD_SEND_CMD(0x9F,8,0); // read command
  tx_buffer_cmd_read_ID[3]= SPI_CMD_RX_DATA(6,0,8,0,0);
  tx_buffer_cmd_read_ID[4]= SPI_CMD_EOT(0,0);


  #ifdef PRINTF_ON
    printf ("Write tx_buffer_cmd_erase...\n\r");
    uart_wait_tx_done();
  #endif

  tx_buffer_cmd_erase[0] =SPI_CMD_CFG(CLOCK_DIV,0,0);
  tx_buffer_cmd_erase[1] =SPI_CMD_SOT(0);
  tx_buffer_cmd_erase[2] =SPI_CMD_SEND_CMD(0x06,8,0);
  tx_buffer_cmd_erase[3] =SPI_CMD_EOT(0,0);
  tx_buffer_cmd_erase[4] =SPI_CMD_SOT(0);
  tx_buffer_cmd_erase[5] =SPI_CMD_SEND_CMD(0x60,8,0);
  tx_buffer_cmd_erase[6] =SPI_CMD_EOT(0,0);

  #ifdef PRINTF_ON
    printf ("Setup padframe...\n\r");
    uart_wait_tx_done();
  #endif

  for (int u = 0; u < N_SPI; u++){
    for (int v = 0; v < N_REPS[u]; v++){
      #ifdef FPGA_EMULATION
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_set( 2 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_set( 2 );
      #else
        #ifdef SIMPLE_PAD
          alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set( 2 );
          alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_set( 2 );
          alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_set( 2 );
          alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_set( 2 );
        #else
          switch(u){
            // SPI0
            case 0:
              switch(v){
                case 0:
                  alsaqr_periph_padframe_periphs_a_14_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_a_15_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_a_16_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_17_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_06_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_07_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_08_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_09_mux_set( 0 );
                  break;
                case 1:
                  alsaqr_periph_padframe_periphs_a_14_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_15_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_16_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_17_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_06_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_07_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_08_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_09_mux_set( 4 );
                  break;
              }
              break;
            // SPI1
            case 1:
              alsaqr_periph_padframe_periphs_b_26_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_27_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_28_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_29_mux_set( 3 );
              break;
            // SPI2
            case 2:
              switch(v){
                case 0:
                  alsaqr_periph_padframe_periphs_a_18_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_19_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_20_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_21_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_18_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_19_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_20_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_21_mux_set( 0 );
                  break;
                case 1:
                  alsaqr_periph_padframe_periphs_a_18_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_19_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_20_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_21_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_18_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_19_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_20_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_21_mux_set( 2 );
                  break;
              }
              break;
            // SPI3
            case 3:
              switch(v){
                case 0:
                  alsaqr_periph_padframe_periphs_a_22_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_23_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_24_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_a_25_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_22_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_23_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_24_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_25_mux_set( 0 );
                  break;
                case 1:
                  alsaqr_periph_padframe_periphs_a_22_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_23_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_24_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_a_25_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_22_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_23_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_24_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_25_mux_set( 3 );
                  break;
              }
              break;
            // SPI4
            case 4:
              switch(v){
                case 0:
                  alsaqr_periph_padframe_periphs_b_04_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_05_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_06_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_07_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_14_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_15_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_16_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_17_mux_set( 0 );
                  break;
                case 1:
                  alsaqr_periph_padframe_periphs_b_04_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_05_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_06_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_07_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_14_mux_set( 2 );
                  alsaqr_periph_padframe_periphs_b_15_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_16_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_17_mux_set( 2 );
                  break;
              }
              break;
            // SPI5
            case 5:
              alsaqr_periph_padframe_periphs_b_04_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_05_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_06_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_07_mux_set( 4 );
              break;
            // SPI6
            case 6:
              alsaqr_periph_padframe_periphs_b_10_mux_set( 2 );
              alsaqr_periph_padframe_periphs_b_11_mux_set( 2 );
              alsaqr_periph_padframe_periphs_b_12_mux_set( 2 );
              alsaqr_periph_padframe_periphs_b_13_mux_set( 2 );
              break;
            // SPI7
            case 7:
              alsaqr_periph_padframe_periphs_b_10_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_11_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_12_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_13_mux_set( 3 ); /*CS0*/
              //alsaqr_periph_padframe_periphs_b_14_mux_set( 3 ); /*CS1*/
              break;
            // SPI8
            case 8:
              alsaqr_periph_padframe_periphs_b_22_mux_set( 3 );
              alsaqr_periph_padframe_periphs_b_23_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_24_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_25_mux_set( 4 );
              break;
            // SPI9
            case 9:
              alsaqr_periph_padframe_periphs_b_26_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_27_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_28_mux_set( 4 );
              alsaqr_periph_padframe_periphs_b_29_mux_set( 4 );
              break;
            // SPI10
            case 10:
              switch(v){
                case 0:
                  alsaqr_periph_padframe_periphs_b_30_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_31_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_32_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_33_mux_set( 4 );
                  alsaqr_periph_padframe_periphs_b_38_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_39_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_40_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_41_mux_set( 0 );
                  break;
                case 1:
                  alsaqr_periph_padframe_periphs_b_30_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_31_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_32_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_33_mux_set( 0 );
                  alsaqr_periph_padframe_periphs_b_38_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_39_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_40_mux_set( 3 );
                  alsaqr_periph_padframe_periphs_b_41_mux_set( 3 );
                  break;
              }
              break;
          }
        #endif
      #endif

      rx_spi_plic_id = ARCHI_UDMA_SPIM_ID(u)*4 +16 ; //32
      tx_spi_plic_id = ARCHI_UDMA_SPIM_ID(u)*4 +16 +1; //33
      cmd_spi_plic_id = ARCHI_UDMA_SPIM_ID(u)*4 +16 +2; //34
      eot_spi_plic_id = ARCHI_UDMA_SPIM_ID(u)*4 +16 +3; //35

      printf("[%d, %d] Start test flash page programming over qspi %d.%d\n",  0, 0, u, v);

      #ifdef PRINTF_ON
        printf ("Enable CG peripherals...\n\r");
        uart_wait_tx_done();
      #endif

      // Enable all the udma channels
      plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));
      barrier();

      #ifdef PRINTF_ON
        printf ("Peripherals enabled...\n\r");
        uart_wait_tx_done();
      #endif

      //--- get the base address of the SPIMx udma channels
      //unsigned int udma_spim_channel_base = hal_udma_channel_base(UDMA_CHANNEL_ID(ARCHI_UDMA_SPIM_ID(u)));
      //printf("uDMA spim%d base channel address %8x\n", u,udma_spim_channel_base);
      //barrier();

      //--- check flash ID for debugging (refer to the manual)
      #ifdef PRINTF_ON
        printf ("Reset rems_resp...\n\r");
        uart_wait_tx_done();
      #endif
      for(int i = 0; i < 6; i++) {
        rems_resp[i] = 0;
      }

      #ifdef PRINTF_ON
        printf ("Enqueue UDMA_SPIM_RX_ADDR...\n\r");
        uart_wait_tx_done();
      #endif


      plp_udma_enqueue(UDMA_SPIM_RX_ADDR(u) ,  (unsigned int)rems_resp, 6*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      barrier();

      #ifdef PRINTF_ON
        printf ("Enqueue UDMA_SPIM_CMD_ADDR with tx_buffer_cmd_read_ID...\n\r");
        uart_wait_tx_done();
      #endif

      plp_udma_enqueue(UDMA_SPIM_CMD_ADDR(u),  (int)tx_buffer_cmd_read_ID, 5*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      //--- polling to check if the transfer is completed (when the "SADDR" register of the SPI channel is equal to 0)

      if (USE_PLIC==0){
        do {
            #ifdef PRINTF_ON
              printf ("Polling on UDMA_SPIM_RX_ADDR until != 0...\n\r");
              uart_wait_tx_done();
            #endif

            poll_var = pulp_read32(UDMA_CHANNEL_SIZE_OFFSET + UDMA_SPIM_RX_ADDR(u));
            barrier();

          } while(poll_var != 0);

      }else {
        #ifdef PRINTF_ON
          printf ("Set interrupt on rx_spi_plic_id...\n\r");
          uart_wait_tx_done();
        #endif

        //Set RX interrupt
        pulp_write32(PLIC_BASE+rx_spi_plic_id*4, 1); // set rx interrupt priority to 1

        #ifdef PRINTF_ON
          printf ("Enable interrupt on rx_spi_plic_id...\n\r");
          uart_wait_tx_done();
        #endif

        pulp_write32(PLIC_EN_BITS+(((int)(rx_spi_plic_id/32))*4), 1<<(rx_spi_plic_id%32)); //enable interrupt

        //  wfi until reading the rx id from the PLIC
        while(pulp_read32(PLIC_CHECK)!=rx_spi_plic_id) {
          asm volatile ("wfi");
        }

        #ifdef PRINTF_ON
          printf ("Interrupt received and clear...\n\r");
          uart_wait_tx_done();
        #endif

        //Set completed Interrupt
        pulp_write32(PLIC_CHECK,rx_spi_plic_id);
      }

      #ifdef FPGA_EMULATION {

        #ifdef PRINTF_ON
          printf ("ERASE THE FLASH...\n\r");
          uart_wait_tx_done();
        #endif

        plp_udma_enqueue(UDMA_SPIM_CMD_ADDR(u),  (int)tx_buffer_cmd_erase , 28, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);

        temp=0;
        pulp_write32(sr1,0);

        #ifdef PRINTF_ON
          printf ("Check WIP flag of the Status Register 1 of the flash memory...\n\r");
          uart_wait_tx_done();
        #endif


        do {

          #ifdef PRINTF_ON
            printf ("Enqueue UDMA_SPIM_RX_ADDR with sr1...\n\r");
            uart_wait_tx_done();
          #endif


          plp_udma_enqueue(UDMA_SPIM_RX_ADDR(u) ,  (unsigned int)sr1, 1*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
          barrier();
          //printf ("Enqueue UDMA_SPIM_CMD_ADDR with tx_buffer_cmd_read_WIP...\n\r");
          //uart_wait_tx_done();
          plp_udma_enqueue(UDMA_SPIM_CMD_ADDR(u),  (int)tx_buffer_cmd_read_WIP, 5*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
          barrier();

          if (USE_PLIC==0){
            //--- polling to check if the transfer is completed (when the "SADDR" register of the SPI channel is equal to 0)
            do {
              //printf ("Polling on UDMA_SPIM_RX_ADDR until != 0...\n\r");
              uart_wait_tx_done();
              poll_var = pulp_read32(UDMA_CHANNEL_SIZE_OFFSET + UDMA_SPIM_RX_ADDR(u));
              barrier();
            } while(poll_var != 0);
          }else {
            //printf ("Set interrupt on rx_spi_plic_id...\n\r");
            uart_wait_tx_done();
            //Set RX interrupt
            pulp_write32(PLIC_BASE+rx_spi_plic_id*4, 1); // set tx interrupt priority to 1
            //printf ("Enable interrupt on rx_spi_plic_id...\n\r");
            uart_wait_tx_done();
            pulp_write32(PLIC_EN_BITS+(((int)(rx_spi_plic_id/32))*4), 1<<(rx_spi_plic_id%32)); //enable interrupt

            //  wfi until reading the EOT id from the PLIC
            while(pulp_read32(PLIC_CHECK)!=rx_spi_plic_id) {
              asm volatile ("wfi");
            }
            //printf ("Interrupt received and clear...\n\r");
            uart_wait_tx_done();
            //Set completed Interrupt
            pulp_write32(PLIC_CHECK,rx_spi_plic_id);
          }

          //printf ("Check WIP on Sr1\n\r");
          uart_wait_tx_done();
          temp=pulp_read32(sr1);
          barrier();
          temp &=1;
          barrier();
        } while( temp != 0);

      #endif


      #ifdef PRINTF_ON
        printf ("WRITING MEMORY PAGE ON THE FLASH...\n\r");
        uart_wait_tx_done();

        printf ("Enqueue UDMA_SPIM_TX_ADDR...\n\r");
        uart_wait_tx_done();
      #endif


      //Write the Flash page
      plp_udma_enqueue(UDMA_SPIM_TX_ADDR(u) ,  (int)memory_page          ,TEST_PAGE_SIZE*4 + 4*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      barrier();

      #ifdef PRINTF_ON
        printf ("Enqueue UDMA_SPIM_CMD_ADDR with tx_buffer_cmd_program...\n\r");
        uart_wait_tx_done();
      #endif

      plp_udma_enqueue(UDMA_SPIM_CMD_ADDR(u),  (int)tx_buffer_cmd_program , 9*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      barrier();

      temp=0;
      pulp_write32(sr1,0);

      #ifdef PRINTF_ON
        printf ("Check WIP flag of the Status Register 1 of the flash memory...\n\r");
        uart_wait_tx_done();
      #endif

      #ifdef PRINTF_ON
          printf ("Enqueue UDMA_SPIM_RX_ADDR with sr1...\n\r");
          uart_wait_tx_done();
      #endif
      do {

        plp_udma_enqueue(UDMA_SPIM_RX_ADDR(u) ,  (unsigned int)sr1, 1*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
        barrier();

        #ifdef PRINTF_ON
          printf ("Enqueue UDMA_SPIM_CMD_ADDR with tx_buffer_cmd_read_WIP...\n\r");
          uart_wait_tx_done();
        #endif

        plp_udma_enqueue(UDMA_SPIM_CMD_ADDR(u),  (int)tx_buffer_cmd_read_WIP, 5*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
        barrier();

        if (USE_PLIC==0){
          //--- polling to check if the transfer is completed (when the "SADDR" register of the SPI channel is equal to 0)
          do {

            #ifdef PRINTF_ON
              printf ("Polling on UDMA_SPIM_RX_ADDR until != 0...\n\r");
              uart_wait_tx_done();
            #endif

            poll_var = pulp_read32(UDMA_CHANNEL_SIZE_OFFSET + UDMA_SPIM_RX_ADDR(u));
            barrier();
          } while(poll_var != 0);
        }else {

          #ifdef PRINTF_ON
            printf ("Set interrupt on rx_spi_plic_id...\n\r");
            uart_wait_tx_done();
          #endif

          //Set RX interrupt
          pulp_write32(PLIC_BASE+rx_spi_plic_id*4, 1); // set tx interrupt priority to 1

          #ifdef PRINTF_ON
            printf ("Enable interrupt on rx_spi_plic_id...\n\r");
            uart_wait_tx_done();
          #endif

          pulp_write32(PLIC_EN_BITS+(((int)(rx_spi_plic_id/32))*4), 1<<(rx_spi_plic_id%32)); //enable interrupt

          //  wfi until reading the EOT id from the PLIC
          while(pulp_read32(PLIC_CHECK)!=rx_spi_plic_id) {
            asm volatile ("wfi");
          }

          #ifdef PRINTF_ON
            printf ("Interrupt received and clear...\n\r");
            uart_wait_tx_done();
          #endif

          //Set completed Interrupt
          pulp_write32(PLIC_CHECK,rx_spi_plic_id);
        }

        #ifdef PRINTF_ON
          printf ("Check WIP on Sr1\n\r");
          uart_wait_tx_done();
        #endif

        temp=pulp_read32(sr1);
        barrier();
        temp &=1;
        barrier();
      } while( temp != 0);

      barrier();
      #ifdef PRINTF_ON
        printf ("READING BACK MEMORY PAGE FROM THE FLASH...\n\r");
        uart_wait_tx_done();

        printf ("Enqueue UDMA_SPIM_RX_ADDR with rx_page...\n\r");
        uart_wait_tx_done();
      #endif

      // Read back data
      plp_udma_enqueue(UDMA_SPIM_RX_ADDR(u) ,  (int)rx_page     , TEST_PAGE_SIZE*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      barrier();

      #ifdef PRINTF_ON
        printf ("Enqueue UDMA_SPIM_TX_ADDR with addr_buffer...\n\r");
        uart_wait_tx_done();
      #endif

      plp_udma_enqueue(UDMA_SPIM_TX_ADDR(u) ,  (int)addr_buffer    , 4*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      barrier();

      #ifdef PRINTF_ON
        printf ("Enqueue UDMA_SPIM_CMD_ADDR with tx_buffer_cmd_read...\n\r");
        uart_wait_tx_done();
      #endif

      plp_udma_enqueue(UDMA_SPIM_CMD_ADDR(u),  (int)tx_buffer_cmd_read , 6*4, UDMA_CHANNEL_CFG_EN | UDMA_CHANNEL_CFG_SIZE_32);
      barrier();

      // Polling to check if the transfer is completed (when the "SADDR" register of the SPI channel is equal to 0)
      if (USE_PLIC==0){
        do {
          #ifdef PRINTF_ON
            printf ("Polling on UDMA_SPIM_RX_ADDR until != 0...\n\r");
            uart_wait_tx_done();
          #endif

          poll_var = pulp_read32(UDMA_CHANNEL_SIZE_OFFSET + UDMA_SPIM_RX_ADDR(u));
          barrier();
        } while(poll_var != 0);
      }else{

        #ifdef PRINTF_ON
          printf ("Set interrupt on rx_spi_plic_id...\n\r");
          uart_wait_tx_done();
        #endif


        //Set RX interrupt
        pulp_write32(PLIC_BASE+rx_spi_plic_id*4, 1); // set rx interrupt priority to 1

        #ifdef PRINTF_ON
          printf ("Enable interrupt on rx_spi_plic_id...\n\r");
          uart_wait_tx_done();
        #endif

        pulp_write32(PLIC_EN_BITS+(((int)(rx_spi_plic_id/32))*4), 1<<(rx_spi_plic_id%32)); //enable interrupt

        //  wfi until reading the rx id from the PLIC
        while(pulp_read32(PLIC_CHECK)!=rx_spi_plic_id) {
          asm volatile ("wfi");
        }

        #ifdef PRINTF_ON
          printf ("Interrupt received and clear...\n\r");
          uart_wait_tx_done();
        #endif

        //Set completed Interrupt
        pulp_write32(PLIC_CHECK,rx_spi_plic_id);
      }

      barrier();
      #ifdef PRINTF_ON
        printf ("Check rx_page and memory_page...\n\r");
        uart_wait_tx_done();
      #endif


      for (int i = 0; i < TEST_PAGE_SIZE; ++i){
        //printf("Index %d: read %8x, expected %8x \n\r",i,rx_page[i],memory_page[i+4]);
        if (rx_page[i] != memory_page[i+4])
        {
          //printf("Index %d: read %8x, expected %8x -- ERROR\n\r",i,rx_page[i],memory_page[i+4]);
          error[u]++;
        }else
          //printf("Index %d: read %8x, expected %8x \n\r",i,rx_page[i],memory_page[i+4]);
        uart_wait_tx_done();
      }

      if (error[u] == 0){
        printf("Test SPI_%d.%d PASSED\n", u, v);
      }else{
        printf("Test SPI_%d.%d FAILED with %d errors\n\r", u, v, error[u]);
      }
      uart_wait_tx_done();
    }
  }

  temp=0;
  for(int i=0; i<N_SPI; i++){
    temp+=error[i];
  }
  if (temp == 0){
    printf("Test PASSED\n");
  }else{
    printf("Test FAILED with %d errors\n\r", temp);
  }

  return temp;
}

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
#include "udma.h" //for the padframe

#define BUFFER_SIZE 10
#define BUFFER_SIZE_READ 12

#define CAN0_APB_BASE 0X1A108000
#define CAN1_APB_BASE 0X1A109000

#define L2_BASE 0x1C000000

/* CAN_Registers memory map */
#define CTU_CAN_FD_DEVICE_ID           0x0
#define CTU_CAN_FD_VERSION             0x2
#define CTU_CAN_FD_MODE                0x4
#define CTU_CAN_FD_SETTINGS            0x6
#define CTU_CAN_FD_STATUS              0x8
#define CTU_CAN_FD_COMMAND             0xc
#define CTU_CAN_FD_INT_STAT            0x10
#define CTU_CAN_FD_INT_ENA_SET         0x14
#define CTU_CAN_FD_INT_ENA_CLR         0x18
#define CTU_CAN_FD_INT_MASK_SET        0x1c
#define CTU_CAN_FD_INT_MASK_CLR        0x20
#define CTU_CAN_FD_BTR                 0x24
#define CTU_CAN_FD_BTR_FD              0x28
#define CTU_CAN_FD_EWL                 0x2c
#define CTU_CAN_FD_ERP                 0x2d
#define CTU_CAN_FD_FAULT_STATE         0x2e
#define CTU_CAN_FD_REC                 0x30
#define CTU_CAN_FD_TEC                 0x32
#define CTU_CAN_FD_ERR_NORM            0x34
#define CTU_CAN_FD_ERR_FD              0x36
#define CTU_CAN_FD_CTR_PRES            0x38
#define CTU_CAN_FD_FILTER_A_MASK       0x3c
#define CTU_CAN_FD_FILTER_A_VAL        0x40
#define CTU_CAN_FD_FILTER_B_MASK       0x44
#define CTU_CAN_FD_FILTER_B_VAL        0x48
#define CTU_CAN_FD_FILTER_C_MASK       0x4c
#define CTU_CAN_FD_FILTER_C_VAL        0x50
#define CTU_CAN_FD_FILTER_RAN_LOW      0x54
#define CTU_CAN_FD_FILTER_RAN_HIGH     0x58
#define CTU_CAN_FD_FILTER_CONTROL      0x5c
#define CTU_CAN_FD_FILTER_STATUS       0x5e
#define CTU_CAN_FD_RX_MEM_INFO         0x60
#define CTU_CAN_FD_RX_POINTERS         0x64
#define CTU_CAN_FD_RX_STATUS           0x68
#define CTU_CAN_FD_RX_SETTINGS         0x6a
#define CTU_CAN_FD_RX_DATA             0x6c
#define CTU_CAN_FD_TX_STATUS           0x70
#define CTU_CAN_FD_TX_COMMAND          0x74
#define CTU_CAN_FD_TXTB_INFO           0x76
#define CTU_CAN_FD_TX_PRIORITY         0x78
#define CTU_CAN_FD_ERR_CAPT            0x7c
#define CTU_CAN_FD_RETR_CTR            0x7d
#define CTU_CAN_FD_ALC                 0x7e
#define CTU_CAN_FD_TRV_DELAY           0x80
#define CTU_CAN_FD_SSP_CFG             0x82
#define CTU_CAN_FD_RX_FR_CTR           0x84
#define CTU_CAN_FD_TX_FR_CTR           0x88
#define CTU_CAN_FD_DEBUG_REGISTER      0x8c
#define CTU_CAN_FD_YOLO_REG            0x90
#define CTU_CAN_FD_TIMESTAMP_LOW       0x94
#define CTU_CAN_FD_TIMESTAMP_HIGH      0x98
#define CTU_CAN_FD_TXTB1_DATA_1        0x100
#define CTU_CAN_FD_TXTB1_DATA_2        0x104
#define CTU_CAN_FD_TXTB1_DATA_20       0x14c
#define CTU_CAN_FD_TXTB2_DATA_1        0x200
#define CTU_CAN_FD_TXTB2_DATA_2        0x204
#define CTU_CAN_FD_TXTB2_DATA_20       0x24c
#define CTU_CAN_FD_TXTB3_DATA_1        0x300
#define CTU_CAN_FD_TXTB3_DATA_2        0x304
#define CTU_CAN_FD_TXTB3_DATA_20       0x34c
#define CTU_CAN_FD_TXTB4_DATA_1        0x400
#define CTU_CAN_FD_TXTB4_DATA_2        0x404
#define CTU_CAN_FD_TXTB4_DATA_20       0x44c
#define CTU_CAN_FD_TXTB5_DATA_1        0x500
#define CTU_CAN_FD_TXTB5_DATA_2        0x504
#define CTU_CAN_FD_TXTB5_DATA_20       0x54c
#define CTU_CAN_FD_TXTB6_DATA_1        0x600
#define CTU_CAN_FD_TXTB6_DATA_2        0x604
#define CTU_CAN_FD_TXTB6_DATA_20       0x64c
#define CTU_CAN_FD_TXTB7_DATA_1        0x700
#define CTU_CAN_FD_TXTB7_DATA_2        0x704
#define CTU_CAN_FD_TXTB7_DATA_20       0x74c
#define CTU_CAN_FD_TXTB8_DATA_1        0x800
#define CTU_CAN_FD_TXTB8_DATA_2        0x804
#define CTU_CAN_FD_TXTB8_DATA_20       0x84c
#define CTU_CAN_FD_TST_CONTROL         0x900
#define CTU_CAN_FD_TST_DEST            0x904
#define CTU_CAN_FD_TST_WDATA           0x908
#define CTU_CAN_FD_TST_RDATA           0x90c


static inline void wait_cycles(const unsigned cycles)
{
  /**
   * Each iteration of the loop below will take four cycles on RI5CY (one for
   * `addi` and three for the taken `bnez`; if the instructions hit in the
   * I$).  Thus, we let `i` count the number of remaining loop iterations and
   * initialize it to a fourth of the number of clock cyles.  With this
   * initialization, we must not enter the loop if the number of clock cycles
   * is less than four, because this will cause an underflow on the first
   * suregaction.
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
  int error=0;

  //config registers
  uint32_t reg32=0;
  uint32_t address = 0x00000000;
  uint32_t val_wr  = 0x00000000;
  uint32_t reg_val = 0x00000000;

  int j;

  printf("Test CAN starting...\r\n");
  uart_wait_tx_done();

  /* This test is intended to perform only read and write op on CAN register from APB
     For the configuration of the can check its datasheet from: https://canbus.pages.fel.cvut.cz/ctucanfd_ip_core/doc/Datasheet.pdf
  */

  int num_reps = 2;
  for (int v = 0; v < num_reps; v++){
    switch(v){
      case 0:
        //Config padframe CAN0
        alsaqr_periph_padframe_periphs_a_00_mux_set( 1 );
        alsaqr_periph_padframe_periphs_a_01_mux_set( 1 );
        alsaqr_periph_padframe_periphs_b_42_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_43_mux_set( 0 );
        //Config padframe CAN1
        alsaqr_periph_padframe_periphs_a_02_mux_set( 1 );
        alsaqr_periph_padframe_periphs_a_03_mux_set( 1 );
        alsaqr_periph_padframe_periphs_b_30_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_31_mux_set( 0 );
        break;
      case 1:
        //Config padframe CAN0
        alsaqr_periph_padframe_periphs_a_00_mux_set( 0 );
        alsaqr_periph_padframe_periphs_a_01_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_42_mux_set( 2 );
        alsaqr_periph_padframe_periphs_b_43_mux_set( 2 );
        //Config padframe CAN1
        alsaqr_periph_padframe_periphs_a_02_mux_set( 0 );
        alsaqr_periph_padframe_periphs_a_03_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_30_mux_set( 1 );
        alsaqr_periph_padframe_periphs_b_31_mux_set( 1 );
        break;
    }

    // WAR SETTING REG CAN 0
    address = CAN0_APB_BASE + CTU_CAN_FD_MODE;
    reg32 = pulp_read32(address);
    reg_val = reg32;
    reg32^= 1<<22;
    pulp_write32( address, reg32 );
    reg32 = pulp_read32(address);

    if(reg_val==reg32){
      error++;
      printf("ERROR: CAN0.%0d\n\r", v);
    }

    // WAR SETTING REG CAN 1
    address = CAN1_APB_BASE + CTU_CAN_FD_MODE;
    reg32 = pulp_read32(address);
    reg_val = reg32;
    reg32^= 1<<22;
    pulp_write32( address, reg32 );
    reg32 = pulp_read32(address);

    if(reg_val==reg32){
      error++;
      printf("ERROR: CAN1.%0d\n\r", v);
    }
  }

  if(error!=0)
    printf("Test FAILED with :%d\n", error);
  else
    printf("Test PASSED\n");

  uart_wait_tx_done();

  return error;
}

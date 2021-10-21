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
#include "../../inc/udma/cpi/udma_cpi_v1.h"
#include "rgb565_f0.h"

#define HRES 32
#define VRES 32

#define BUFFER_SIZE 10
#define BUFFER_SIZE_READ 12
#define N_CAM 1

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
  int error=0;

  //config registers
  uint32_t reg=0;
  uint16_t concat=0;

  uint16_t *rx_addr= (uint16_t*) 0x1C001000;

  int j;


  //FIX PRINTF UART
  #ifdef FPGA_EMULATION
      int baud_rate = 9600;
      int test_freq = 10000000;
  #else
      int baud_rate = 115200;
      int test_freq = 17500000;
  #endif  
      uart_set_cfg(0,(test_freq/baud_rate)>>4);

  //clear rx buffer
  for(int i=0; i< HRES * VRES; i++){
    rx_addr[i]=0x00;
  }

  uint32_t udma_cam_channel_base = hal_udma_channel_base(UDMA_CHANNEL_ID(ARCHI_UDMA_CAM_ID(0))); //select the camera ID=0
  barrier();

  plp_udma_cg_set(plp_udma_cg_get() | (0xffffffff));
  printf("Enable all CG\n");
  barrier();

  //write RX_SADDR register: it sets the L2 start address 
  udma_cpi_cam_rx_saddr_set(udma_cam_channel_base, 0x1C001000);
  barrier();
     
  //write RX_SIZE register: it sets the buffer syze in bytes
  udma_cpi_cam_rx_size_set(udma_cam_channel_base, N_PIXEL);

  reg|= 1<<UDMA_CPI_CAM_CFG_FILTER_R_COEFF_BIT | 1<<UDMA_CPI_CAM_CFG_FILTER_G_COEFF_BIT | 1<<UDMA_CPI_CAM_CFG_FILTER_B_COEFF_BIT ;
  udma_cpi_cam_cfg_filter_set(udma_cam_channel_base, reg);
  barrier();

  reg=0;
  reg|= 1<<UDMA_CPI_CAM_VSYNC_POLARITY_VSYNC_POLARITY_BIT;
  udma_cpi_cam_vsync_polarity_set(udma_cam_channel_base, reg);

  reg=0;
  reg|= 1<<UDMA_CPI_CAM_CFG_GLOB_EN_BIT | 4<< UDMA_CPI_CAM_CFG_GLOB_FORMAT_BIT;
  udma_cpi_cam_cfg_glob_set(udma_cam_channel_base, reg);
  barrier();

  reg=0;
  reg|= 1<<UDMA_CPI_CAM_RX_CFG_EN_BIT | 1<<UDMA_CPI_CAM_RX_CFG_DATASIZE_BIT | 0<<UDMA_CPI_CAM_RX_CFG_CONTINOUS_BIT;
  udma_cpi_cam_rx_cfg_set(udma_cam_channel_base,reg);
  barrier();

  printf("End Of Config\n");

  //wait_cycles(70000);
  do{
    printf("Still writing...\n");
  }while(udma_cpi_cam_rx_size_get(udma_cam_channel_base)!=0);

  printf("End Transaction\n");

  for (int i=0; i<N_PIXEL; i+=2){
    concat= frame_0[i]<<8 | frame_0[i+1];
    if(rx_addr[j]!=concat)
      error++;
    //printf("L2[%d]: %x - Pixel[%d]: %x\n", j, rx_addr[j], j, concat);
    j++;
  }

  if(error!=0)
    printf("Test FAILED with :%d\n",error);
  else
    printf("Test PASSED\n");

  uart_wait_tx_done();

  return error;
}
/*
 * Copyright (C) 2024 ETH Zurich and University of Bologna
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
 * Maintainer: Chaoqun Liang (chaoqun.liang@unibo.it)
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "utils.h"

#define DRIVER_NAME     "alsaqr-eth"
#define N_REPS           2

#define ETH_BASE 			  		         0x30000000
#define MACLO_OFFSET                 0x0
#define MACHI_OFFSET                 0x4
#define IRQ_OFFSET                   0x18
#define IDMA_SRC_ADDR_OFFSET         0x1c
#define IDMA_DST_ADDR_OFFSET         0x20
#define IDMA_LENGTH_OFFSET           0x24
#define IDMA_SRC_PROTO_OFFSET        0x28
#define IDMA_DST_PROTO_OFFSET        0x2c
#define IDMA_REQ_VALID_OFFSET        0x44
#define IDMA_REQ_READY_OFFSET        0x48
#define IDMA_RSP_READY_OFFSET        0x4c
#define IDMA_RSP_VALID_OFFSET        0x50
#define IDMA_RX_EN_OFFSET            0x54

#define DATA_CHUNK 8

#define BYTE_SIZE 8

// spm
#define TX_BASE 0x70000000
#define RX_BASE 0x70001000

#define APB_SOC_CTRL_BASE 0x1A106000
#define APB_SOC_CTRL_LLC_CACHE_ADDR_START 0x18
#define APB_SOC_CTRL_LLC_CACHE_ADDR_END 0x1C
#define APB_SOC_CTRL_LLC_SPM_ADDR_START 0x20
#define LLC_CACHE_START 0x80000000
#define LLC_CACHE_END 0x80800000
#define LLC_SPM_START 0x70000000
#define AXI_LITE_BASE 0x10401000

#define ETH_APLIC_ID 3
#define ETH_IMSIC_ID 1
#define CORE_ID 0
#define CSR_MTOPEI 0x35C

int main() {

	#ifdef ETH2FMC
		/* do nothing */
	#elif SIMPLE_PAD
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_set( 1 );
		alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_set( 1 );
	#else
		alsaqr_periph_padframe_periphs_b_23_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_24_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_25_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_26_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_27_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_28_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_29_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_30_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_31_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_32_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_33_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_34_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_35_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_36_mux_set( 0 );
		alsaqr_periph_padframe_periphs_b_37_mux_set( 0 );
		alsaqr_periph_padframe_periphs_a_15_mux_set( 1 );
		alsaqr_periph_padframe_periphs_a_16_mux_set( 1 );
		alsaqr_periph_padframe_periphs_a_17_mux_set( 1 );
		alsaqr_periph_padframe_periphs_a_18_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_19_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_20_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_21_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_22_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_23_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_24_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_25_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_26_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_27_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_28_mux_set( 2 );
		alsaqr_periph_padframe_periphs_a_29_mux_set( 1 );
	#endif

	  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_CACHE_ADDR_START, LLC_CACHE_START);    //LLC cache address start
	  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_CACHE_ADDR_END  , LLC_CACHE_END);      //LLC cache address end (8MB)
	  pulp_write32(APB_SOC_CTRL_BASE + APB_SOC_CTRL_LLC_SPM_ADDR_START  , LLC_SPM_START);      //LLC SPM address end
	  axi_llc_reg32_all_spm(AXI_LITE_BASE);   //set LLC in SPM mode
    
    aplic_init();
    imsic_init();

    config_irq_aplic(ETH_APLIC_ID, ETH_IMSIC_ID, CORE_ID);

    volatile uint64_t data_to_write[DATA_CHUNK] = {
        0x0207230100890702, 
        0x3210400020709800,
        0x1716151413121110, 
        0x2726252423222120,
        0x3736353433323130, 
        0x4746454443424140,
        0x5756555453525150, 
        0x6766656463626160
    };

  // load data into mem
  for (int i = 0; i < DATA_CHUNK; ++i) {
        volatile uint64_t *tx_addr = (volatile uint64_t*)(TX_BASE + i * sizeof(uint64_t));
        *tx_addr = data_to_write[i];
  }
  
  // Low 32 bit MAc Address 
  pulp_write32(ETH_BASE+MACLO_OFFSET,0x89000123);
  // High 16 bit Mac Address
  pulp_write32(ETH_BASE+MACHI_OFFSET,0x00800207);
  // DMA Source Address
  pulp_write32(ETH_BASE+IDMA_SRC_ADDR_OFFSET,TX_BASE);
  // DMA Destination Address
  pulp_write32(ETH_BASE+IDMA_DST_ADDR_OFFSET,0x0);
  // Data length
  pulp_write32(ETH_BASE+IDMA_LENGTH_OFFSET,DATA_CHUNK*BYTE_SIZE);
  // Source Protocol
  pulp_write32(ETH_BASE+IDMA_DST_PROTO_OFFSET,0x0);
  // Destination Protocol
  pulp_write32(ETH_BASE+IDMA_DST_PROTO_OFFSET,0x5);
  // Validate Request to DMA
  pulp_write32(ETH_BASE+IDMA_REQ_VALID_OFFSET,0x1);
   
  // RX Test
  // configure ethernet
  pulp_write32(ETH_BASE+MACLO_OFFSET, 0x89000123);  
  pulp_write32(ETH_BASE+MACHI_OFFSET, 0x00800207);  

  // rx irq
  asm volatile ("wfi");
  imsic_intp_arrive(ETH_IMSIC_ID);
  CSRW(CSR_MTOPEI, 0);

  // dma length ready, dma can be configured now
  while (!pulp_read32(ETH_BASE+IDMA_RX_EN_OFFSET));
  pulp_write32(ETH_BASE+IDMA_SRC_ADDR_OFFSET, 0x0); 
  pulp_write32(ETH_BASE+IDMA_DST_ADDR_OFFSET,RX_BASE);
  pulp_write32(ETH_BASE+IDMA_SRC_PROTO_OFFSET,0x5);
  pulp_write32(ETH_BASE+IDMA_DST_PROTO_OFFSET,0x0);
  pulp_write32(ETH_BASE+IDMA_REQ_VALID_OFFSET,0x1);

  // wait until DMA moves all data
  while (!pulp_read32(ETH_BASE+IDMA_RSP_VALID_OFFSET));

  uint32_t error = 0;

  for (int i = 0; i < DATA_CHUNK; ++i) {
    volatile uint64_t *rx_addr = (volatile uint64_t*)(RX_BASE + i * sizeof(uint64_t));
    uint64_t data_read = *rx_addr;

    if (data_read != data_to_write[i]) error ++;
  }

  return error;
}
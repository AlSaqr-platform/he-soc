/*
 * Copyright (C) 2021 ETH Zurich and University of Bologna
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
#include <stdint.h>
#include "utils.h"
#include "gpio_v3.h"
#include "udma.h"

#define BUFFER_SIZE 32

#define ARCHI_GPIO_ADDR 0x1A105000

#define OUT 1
#define IN  0

//#define FPGA_EMULATION
#define SIMPLE_PAD

#ifndef FPGA_EMULATION
  #ifndef SIMPLE_PAD
    #define NUM_GPIOS 63
  #else
    #define NUM_GPIOS 14
  #endif
#else
  #define NUM_GPIOS 14
#endif

#define VERBOSE 10

uint32_t configure_gpio(uint32_t number, uint32_t direction){
  uint32_t address;
  uint32_t dir;
  uint32_t gpioen;
  //--- set GPIO
  if(number < 32){
    if (direction == IN) {
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_OFFSET;
      gpioen = pulp_read32(address);
      //--- enable GPIO
      //printf("GPIOEN RD: %x\n",gpioen);
      gpioen |= (1 << number);
      //printf("GPIOEN WR: %x\n",gpioen); 
      pulp_write32(address, gpioen);
      //--- set direction
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_OFFSET;
      dir = pulp_read32(address);
      //printf("GPIODIR RD: %x\n",dir);
      dir |= (0 << number);
      //printf("GPIODIR WR: %x\n",dir);
      pulp_write32(address, dir);
    }else if (direction == OUT){ 
      //--- enable GPIO
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_OFFSET;
      gpioen = pulp_read32(address);
      gpioen |= (1 << number);
      pulp_write32(address, gpioen);
      //--- set direction
      dir=gpioen;
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_OFFSET;
      pulp_write32(address, dir);
    }
  }else{
    if (direction == IN){
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_32_63_OFFSET;
      gpioen = pulp_read32(address);
      //--- enable GPIO
      //printf("GPIOEN RD: %x\n",gpioen);
      gpioen |= (1 << (number-32));
      //printf("GPIOEN WR: %x\n",gpioen); 
      pulp_write32(address, gpioen);
      //--- set direction
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_32_63_OFFSET;
      dir = pulp_read32(address);
      //printf("GPIODIR RD: %x\n",dir);
      dir |= (0 << (number-32));
      //printf("GPIODIR WR: %x\n",dir);
      pulp_write32(address, dir);
    }else if (direction == OUT){
      //--- enable GPIO
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_32_63_OFFSET;
      gpioen = pulp_read32(address);
      gpioen |= (1 << (number-32));
      pulp_write32(address, gpioen);
      //--- set direction
      dir=gpioen;
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_32_63_OFFSET;
      pulp_write32(address, dir);
    }
  }

  while(pulp_read32(address) != dir);
}

void set_gpio(uint32_t number, uint32_t value){
  uint32_t value_wr;
  uint32_t address;
  if (number < 32){
    address = ARCHI_GPIO_ADDR + GPIO_PADOUT_OFFSET;
    value_wr = pulp_read32(address);
    if (value == 1){
      value_wr |= (1 << (number));
    }else{
      value_wr &= ~(1 << (number));
    }
    pulp_write32(address, value_wr);
  }else{
    address = ARCHI_GPIO_ADDR + GPIO_PADOUT_32_63_OFFSET;
    value_wr = pulp_read32(address);
    if (value == 1){
      value_wr |= (1 << (number % 32));
    }else{
      value_wr &= ~(1 << (number % 32));
    }
    pulp_write32(address, value_wr);
  }

  while(pulp_read32(address) != value_wr);
}

uint32_t get_gpio(uint32_t number){
  uint32_t value_rd;
  uint32_t address;
  uint32_t bit;
  if (number < 32){
    address = ARCHI_GPIO_ADDR + GPIO_PADIN_OFFSET;
    value_rd = pulp_read32(address);
    bit= 0x1 & (value_rd>>number);
  }else{
    address = ARCHI_GPIO_ADDR + GPIO_PADIN_32_63_OFFSET;
    value_rd = pulp_read32(address);
    bit= 0x1 & (value_rd>>(number%32));
  }  
  //printf("GPIO %d: HEX:%x Bit:%d \n",number,value_rd,bit);
  return bit;
}

int main() {

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  
  uint32_t error = 0;
  uint32_t gpio_val;
  uint32_t address;
  uint32_t simple_padframe;

  #ifdef FPGA_EMULATION
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
    simple_padframe=1;
  #else
    #ifdef SIMPLE_PAD
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
      simple_padframe=1;
    #else
      alsaqr_periph_padframe_periphs_b_00_mux_set(1);
      alsaqr_periph_padframe_periphs_b_01_mux_set(1);
      alsaqr_periph_padframe_periphs_b_02_mux_set(1);
      alsaqr_periph_padframe_periphs_b_03_mux_set(1);
      alsaqr_periph_padframe_periphs_b_04_mux_set(1);
      alsaqr_periph_padframe_periphs_b_05_mux_set(1);
      alsaqr_periph_padframe_periphs_b_06_mux_set(1);
      alsaqr_periph_padframe_periphs_b_07_mux_set(1);
      alsaqr_periph_padframe_periphs_b_08_mux_set(1);
      alsaqr_periph_padframe_periphs_b_09_mux_set(1);
      alsaqr_periph_padframe_periphs_b_10_mux_set(1);
      alsaqr_periph_padframe_periphs_b_11_mux_set(1);
      alsaqr_periph_padframe_periphs_b_12_mux_set(1);
      alsaqr_periph_padframe_periphs_b_13_mux_set(1);
      alsaqr_periph_padframe_periphs_b_14_mux_set(1);
      alsaqr_periph_padframe_periphs_b_15_mux_set(1);
      alsaqr_periph_padframe_periphs_b_16_mux_set(1);
      alsaqr_periph_padframe_periphs_b_17_mux_set(1);
      alsaqr_periph_padframe_periphs_b_18_mux_set(1);
      alsaqr_periph_padframe_periphs_b_19_mux_set(2);
      alsaqr_periph_padframe_periphs_b_20_mux_set(2);
      alsaqr_periph_padframe_periphs_b_21_mux_set(2);
      alsaqr_periph_padframe_periphs_b_22_mux_set(2);
      alsaqr_periph_padframe_periphs_b_23_mux_set(2);
      alsaqr_periph_padframe_periphs_b_24_mux_set(2);
      alsaqr_periph_padframe_periphs_b_25_mux_set(1);
      alsaqr_periph_padframe_periphs_b_26_mux_set(1);
      alsaqr_periph_padframe_periphs_b_27_mux_set(1);
      alsaqr_periph_padframe_periphs_b_28_mux_set(1);
      alsaqr_periph_padframe_periphs_b_29_mux_set(1);
      alsaqr_periph_padframe_periphs_b_30_mux_set(1);
      alsaqr_periph_padframe_periphs_b_31_mux_set(1);
      alsaqr_periph_padframe_periphs_b_32_mux_set(1);
      alsaqr_periph_padframe_periphs_b_33_mux_set(1);
      alsaqr_periph_padframe_periphs_b_34_mux_set(1);
      alsaqr_periph_padframe_periphs_b_35_mux_set(1);
      alsaqr_periph_padframe_periphs_b_36_mux_set(1);
      alsaqr_periph_padframe_periphs_b_37_mux_set(1);
      alsaqr_periph_padframe_periphs_b_38_mux_set(1);
      alsaqr_periph_padframe_periphs_b_39_mux_set(1);
      alsaqr_periph_padframe_periphs_b_40_mux_set(1);
      alsaqr_periph_padframe_periphs_b_41_mux_set(1);
      alsaqr_periph_padframe_periphs_b_42_mux_set(1);
      alsaqr_periph_padframe_periphs_b_43_mux_set(1);
      alsaqr_periph_padframe_periphs_b_44_mux_set(1);
      alsaqr_periph_padframe_periphs_b_45_mux_set(1);
      alsaqr_periph_padframe_periphs_b_46_mux_set(1);
      alsaqr_periph_padframe_periphs_b_47_mux_set(2);
      alsaqr_periph_padframe_periphs_b_48_mux_set(2);
      alsaqr_periph_padframe_periphs_b_49_mux_set(2);
      alsaqr_periph_padframe_periphs_b_50_mux_set(2);
      alsaqr_periph_padframe_periphs_b_51_mux_set(2);
      alsaqr_periph_padframe_periphs_b_52_mux_set(2);
      alsaqr_periph_padframe_periphs_b_53_mux_set(2);
      alsaqr_periph_padframe_periphs_b_54_mux_set(2);
      alsaqr_periph_padframe_periphs_b_55_mux_set(2);
      alsaqr_periph_padframe_periphs_b_56_mux_set(2);
      alsaqr_periph_padframe_periphs_b_57_mux_set(2);
      alsaqr_periph_padframe_periphs_b_58_mux_set(2);
      alsaqr_periph_padframe_periphs_b_59_mux_set(2);
      alsaqr_periph_padframe_periphs_b_60_mux_set(2);
      alsaqr_periph_padframe_periphs_b_61_mux_set(2);
      alsaqr_periph_padframe_periphs_b_62_mux_set(2);
      simple_padframe=0;
    #endif    
  #endif

  //*************************************************
  // Test Phase
  //*************************************************
  if(simple_padframe){

    for(int i = 0; i < NUM_GPIOS/2; i++) {
      configure_gpio( i , OUT );
      #if VERBOSE > 1
        printf("gpio_%0d direction: %s\n", i, "OUT");
      #endif
    }
    for(int i = NUM_GPIOS/2; i < NUM_GPIOS; i++) {
      configure_gpio( i , IN );
      #if VERBOSE > 1
        printf("gpio_%0d direction: %s\n", i, "IN");
      #endif
    }

    printf("Start...\n");
    gpio_val=1;
    for (int i = 0; i < 8; i++){
      for(int j = 0; j < NUM_GPIOS/2; j++) {
        set_gpio( j , gpio_val);
        #if VERBOSE > 5
          printf("gpio_%0d value: %0d\n", j, gpio_val);
        #endif
      }
      for(int j = NUM_GPIOS/2; j < NUM_GPIOS; j++) {
        if(get_gpio(j) != gpio_val){
          printf("ERROR: gpio_%0d value != %0d\n", j, gpio_val);
          error++;
        }
      }
      gpio_val=!gpio_val;
    }

    if(!error)
      printf("Test PASSED\n\r");
    else
      printf("Test FAILED\n\r");
    return error;

  }else{

    for(int i = 0; i < NUM_GPIOS; i++) {
      configure_gpio( i , OUT );
      #if VERBOSE > 1
        printf("gpio_%0d direction: %s\n", i, "OUT");
      #endif
    }
    
    printf("Start...\n");
    gpio_val=1;
    for (int i = 0; i < 8; i++){
      for(int j = 0; j < NUM_GPIOS; j++) {
        set_gpio( j , gpio_val);
        #if VERBOSE > 5
          printf("gpio_%0d value: %0d\n", j, gpio_val);
        #endif
      }
      gpio_val=!gpio_val;
    }

    printf("\n************************************************************\n");
    printf("*VISUALLY INSPECT THAT YOU SEE 1010_1010 ON ALL GPIO SIGNALS*\n");
    printf("\n************************************************************\n");

    return 0;
  }
  
}

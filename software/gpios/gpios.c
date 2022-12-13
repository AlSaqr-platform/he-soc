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
 * Mantainer: Luca Valente (luca.valente2@unibo.it)
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

#define FPGA_EMULATION
#define SIMPLE_PAD

//#define VERBOSE
//#define EXTRA_VERBOSE

uint32_t configure_gpio(uint32_t number, uint32_t direction){
  uint32_t address;
  uint32_t dir;
  uint32_t gpioen;

  //--- set GPIO
  if(number < 32)
  {
    if (direction == IN) 
    {

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
    if (direction == IN)
    {
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
  if (number < 32)
  {
    address = ARCHI_GPIO_ADDR + GPIO_PADOUT_OFFSET;
    value_wr = pulp_read32(address);
    if (value == 1)
    {
      value_wr |= (1 << (number));
    }else{
      value_wr &= ~(1 << (number));
    }
    pulp_write32(address, value_wr);
  }else{
    address = ARCHI_GPIO_ADDR + GPIO_PADOUT_32_63_OFFSET;
    value_wr = pulp_read32(address);
    if (value == 1)
    {
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
  if (number < 32)
  {
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
  
  uint32_t error [3]= {0,0,0};
  uint32_t simple=0;
  uint32_t val_wr = 0x00000000;
  uint32_t val_rd = 0;
  uint32_t gpio_out;
  uint32_t gpio_in;
  uint32_t val_rd1;
  uint32_t gpio_val;
  uint32_t address;


  #ifdef FPGA_EMULATION
    alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set( 1 ); //tx uart
    alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set( 1 ); //rx uart
    simple=1;
  #else
    #ifdef SIMPLE_PAD
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set( 1 ); //tx uart
      alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set( 1 ); //rx uart
      simple=1;
    #else
      alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_set(1);
      alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_set(1);
      alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_set(1);

      alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_set(1);
      alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_set(1);
      alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_set(1);
    #endif    
  #endif 
  
  if (simple==1){
    configure_gpio( 6 , OUT );
    configure_gpio( 7 , IN );
  }else{
    configure_gpio( 5 , OUT );
    configure_gpio( 6 , OUT );
    configure_gpio( 7 , OUT );

    configure_gpio( 37 , IN );
    configure_gpio( 38 , IN );
    configure_gpio( 39 , IN );

    /*configure_gpio( 5 , IN );
    configure_gpio( 6 , IN );
    configure_gpio( 7 , IN );

    configure_gpio( 37 , OUT );
    configure_gpio( 38 , OUT );
    configure_gpio( 39 , OUT );*/

  }
  
  gpio_val=1;
  printf("Start...\n");

  for (int i=0; i<100; i++){
    if(simple==1){
      //TEST FOR SIMPLE PADFRAME AND FPGA
      set_gpio(6,gpio_val);
      if (gpio_val!=get_gpio(7))
        error[0]++;
    }else{
      //TEST FOR FULL PADFRAME
      
      set_gpio(5,gpio_val);
      set_gpio(6,gpio_val);  
      set_gpio(7,gpio_val);
      
      if (gpio_val!=get_gpio(37))
        error[0]++;
      if (gpio_val!=get_gpio(38))
        error[1]++;
      if (gpio_val!=get_gpio(39))
        error[2]++;

      /*set_gpio(37,gpio_val);
      set_gpio(38,gpio_val);  
      set_gpio(39,gpio_val);
      
      if (gpio_val!=get_gpio(5))
        error[0]++;
      if (gpio_val!=get_gpio(6))
        error[1]++;
      if (gpio_val!=get_gpio(7))
        error[2]++;*/
    }
    gpio_val=!gpio_val;
  }

  if (error[0]+error[1]+error[2]!=0)
    printf ("TEST GPIO FAIL with: %d %d %d\n", error[0], error[1], error[2]);
  else
    printf ("TEST GPIO PASSED\n");

  uart_wait_tx_done();  
  return error[0]+error[1]+error[2];
}

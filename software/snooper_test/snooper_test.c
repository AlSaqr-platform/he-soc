// Copyright (c) 2022 ETH Zurich and University of Bologna
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//
//

#include "utils.h"
#include "snooper_test.h"
#include <stdbool.h>

#define INSTR

#define SNOOP_BASE    0x10405000
#define AXI_PORT_BASE 0x71000000

// Function to set a specific bit in the register
void set_register_bit(uint32_t base_addr, uint32_t reg_offset, uint32_t bit_position) {
    uint32_t reg_value = pulp_write32(base_addr + reg_offset);
    reg_value |= (1 << bit_position);
    pulp_write32(base_addr + reg_offset, reg_value);
}

int main(int argc, char **argv) {

  #ifdef TARGET_SYNTHESIS
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  //set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  int volatile * p_reg;
  int err = 0;

  printf("\r\n");
  uart_wait_tx_done();

  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_BASE_H_REG_OFFSET, 0x00000000);
  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_BASE_L_REG_OFFSET, 0x80000e3c);
  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_LAST_H_REG_OFFSET, 0x00000000);
  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_LAST_L_REG_OFFSET, 0x80000f2a);

  printf("CVA6: configuring and starting snooper\r\n");
  //#ifdef INSTR
  set_register_bit(SNOOP_BASE, CFG_REGS_CTRL_REG_OFFSET,CFG_REGS_CTRL_M_MODE_BIT);
  set_register_bit(SNOOP_BASE, CFG_REGS_CTRL_REG_OFFSET,CFG_REGS_CTRL_PC_RANGE_0_BIT);

  asm volatile ("wfi");
  //pulp_write32(SNOOP_BASE + CFG_REGS_CTRL_REG_OFFSET, 0x800 + 0x80 + 0x8 + 0x4);
  //#else
  //pulp_write32(SNOOP_BASE + CFG_REGS_CTRL_REG_OFFSET,         0x80 + 0x8 + 0x4);
  //#endif

  /*
  #ifdef INSTR
  for(int i=0;i<0x3999;i+=0x1){
    p_reg = (int *) AXI_PORT_BASE + i;
    if(*p_reg != i*4){
      err++;
      printf("Addr: %x Data: %x\r\n", AXI_PORT_BASE + i*4,  *p_reg);
    }
  }
  #else
  for(int i=0;i<0x999;i+=0x1){
    p_reg = (int *) AXI_PORT_BASE + i;
    if(*p_reg != i*4){
      err++;
      printf("Addr: %x Data: %x\r\n", AXI_PORT_BASE + i*4,  *p_reg);
    }
  }
  */

  return err;
}

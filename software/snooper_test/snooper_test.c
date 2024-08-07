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

#define SNOOP_BASE    0x10405000
#define AXI_PORT_BASE 0x71000000

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
  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_BASE_L_REG_OFFSET, 0x00000000);
  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_LAST_H_REG_OFFSET, 0x0FFFFFFF);
  pulp_write32(SNOOP_BASE + CFG_REGS_RANGE_0_LAST_L_REG_OFFSET, 0xFFFFFFFF);
  pulp_write32(SNOOP_BASE + CFG_REGS_TRIG_PC0_H_REG_OFFSET, 0x00000004);
  pulp_write32(SNOOP_BASE + CFG_REGS_TRIG_PC0_L_REG_OFFSET, 0x00000000);

  #ifdef INSTR
  pulp_write32(SNOOP_BASE + CFG_REGS_CTRL_REG_OFFSET, 0x800 + 0x80 + 0x8 + 0x4);
  #else
  pulp_write32(SNOOP_BASE + CFG_REGS_CTRL_REG_OFFSET,         0x80 + 0x8 + 0x4);
  #endif

  while(pulp_read32(SNOOP_BASE + CFG_REGS_LAST_REG_OFFSET ) != 0x3FFC);

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
  #endif
  
  return err;
}

// 1 << CFG_REGS_CTRL_TEST_MODE_BIT  +
// 1 << CFG_REGS_CTRL_PC_RANGE_0_BIT +
// 1 << CFG_REGS_CTRL_M_MODE_BIT     +
// 1 << CFG_REGS_CTRL_TRIG_PC_0_BIT ;

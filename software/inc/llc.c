// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the ?License?); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an ?AS IS? BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#include "llc.h"

int write_llc_reg(uint32_t LLC_REG, uint32_t val) {
  if(LLC_REG>0)
    return -1;
  else
    *(volatile unsigned int*)((long)(0x1A106004 + LLC_REG)) = val;

  return 0;
}

unsigned int read_llc_reg(uint32_t  LLC_REG) {
  return  *(volatile unsigned int*)( (long) (0x1A106004 + LLC_REG));
}

void disable_llc_counters(){
  write_llc_reg(LLC_REG_CYCLE_CNT,0x0);
}

void enable_llc_counters(){
  write_llc_reg(LLC_REG_CYCLE_CNT,0x1);
}

unsigned int get_llc_hit() {
  return (read_llc_reg(LLC_REG_READ_HIT) + read_llc_reg(LLC_REG_WRITE_HIT));
}

unsigned int get_llc_miss() {
  return (read_llc_reg(LLC_REG_READ_MISS) + read_llc_reg(LLC_REG_WRITE_MISS));
}

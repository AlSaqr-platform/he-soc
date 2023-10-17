// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the ?License?); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an ?AS IS? BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

#ifndef _LLC_H
#define _LLC_H

#include <stdint.h>

#define LLC_REG_CYCLE_CNT   0x0
#define LLC_REG_READ_MISS   0x4
#define LLC_REG_READ_HIT    0x8
#define LLC_REG_WRITE_MISS  0xC
#define LLC_REG_WRITE_HIT   0x10

int write_llc_reg(uint32_t LLC_REG, uint32_t val);
unsigned int read_llc_reg(uint32_t  LLC_REG);
void enable_llc_counters();
unsigned int get_llc_hit();
unsigned int get_llc_miss();

#endif

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

//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define FPGA_EMULATION


int main(int argc, char const *argv[])
{
#ifdef FPGA_EMULATION                  
	int baud_rate = 115200;
	int test_freq = 40000000;
#else
	set_flls();
	int baud_rate = 115200;
	int test_freq = 100000000;
#endif
  
	#define PLIC_BASE     0x0C000000
	#define PLIC_CHECK    PLIC_BASE + 0x201004
	#define PLIC_EN_BITS  PLIC_BASE + 0x2080
	uart_set_cfg(0,(test_freq/baud_rate)>>4);

	// JAL  x1, 10
	uint32_t call_opcode   = 0x00a000ef;

	int mbox_id = 143;

	printf("[CVA6] Start Shadow Stack call testbench\n");
	uart_wait_tx_done();

	// Set MailBox interrupt priority and enable interrupts.
	pulp_write32(PLIC_BASE+mbox_id*4, 1);
	pulp_write32(PLIC_EN_BITS+(((int)(mbox_id/32))*4), 1<<(mbox_id%32));

	// Test call.
	pulp_write32(0x10404000, call_opcode);
	pulp_write32(0x10404020, 0x00000001);
	asm volatile ("wfi");
	pulp_write32(0x10404024, 0x00000000);

	// Complete IRQ.
	pulp_write32(PLIC_CHECK, mbox_id);

	return 0;
}

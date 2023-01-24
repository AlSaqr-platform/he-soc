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
	#define PLIC_BASE     0x0C000000
	#define PLIC_CHECK    PLIC_BASE + 0x201004
  
	//enable bits for sources 0-31
	#define PLIC_EN_BITS  PLIC_BASE + 0x2080

	// JAL  x1, 10
	uint32_t call_opcode   = 0x00a000ef;
	// JALR x0, x1, 0
	uint32_t return_opcode = 0x00008067;

	int mbox_id = 143;

	// Initialazing the interrupt controller
	pulp_write32(PLIC_BASE+mbox_id*4, 1);                                // set mbox interrupt priority to 1
	pulp_write32(PLIC_EN_BITS+(((int)(mbox_id/32))*4), 1<<(mbox_id%32)); // enable interrupt

	////////////////////// start memory test //////////////////////

	printf("Ariane: JAL\r\n");
	uart_wait_tx_done();
	pulp_write32(0x10404008, call_opcode);
	pulp_write32(0x10404020, 0x00000001); // ring doorbell 
	asm volatile ("wfi"); // the handler just returns here + 4
	pulp_write32(0x10404024, 0x00000000); // Cleaning the irq source
	pulp_write32(PLIC_CHECK, mbox_id);    // Completing irq (according to riscv specs)

	uart_wait_tx_done();
	pulp_write32(0x10404008, return_opcode);
	pulp_write32(0x10404020, 0x00000001); // ring doorbell 
	asm volatile ("wfi"); // the handler just returns here + 4
	pulp_write32(0x10404024, 0x00000000); // Cleaning the irq source
	pulp_write32(PLIC_CHECK, mbox_id);    // Completing irq (according to riscv specs)

	return 0;
}

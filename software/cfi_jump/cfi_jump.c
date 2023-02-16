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


int main(int argc, char const *argv[]) {
	unsigned long cycles_active;
	unsigned long cycles_wait;
	unsigned int  cfi_config;
	unsigned int  cfi_mask;
	unsigned int  cfi_pred;

	cfi_mask   = 0xfff;
	cfi_pred   = 0x06f;
	cfi_config = 0x1;
	asm volatile("csrw 0x7c1, %0"::"r"(cfi_mask));
	asm volatile("csrw 0x7c2, %0"::"r"(cfi_pred));
	asm volatile("csrw 0x7c0, %0"::"r"(cfi_config));

label0:
	asm goto(
		"j %l0 \n\t"
		::::label1
	);

label1:
	asm goto(
		"j %l0 \n\t"
		::::label2
	);

label2:
	asm goto(
		"j %l0 \n\t"
		::::label3
	);

label3:
	asm goto(
		"j %l0 \n\t"
		::::label4
	);

label4:
	asm goto(
		"j %l0 \n\t"
		::::label5
	);

label5:
	asm goto(
		"j %l0 \n\t"
		::::label6
	);

label6:
	asm goto(
		"j %l0 \n\t"
		::::label7
	);

label7:
	asm goto(
		"j %l0 \n\t"
		::::label8
	);

label8:
	asm volatile("csrwi 0x7c0, 0");
	asm volatile("csrr %0, 0xcc0" :"=r"(cycles_active));
	asm volatile("csrr %0, 0xcc1" :"=r"(cycles_wait));

	printf("Cycles ACTIVE : %6d\n", cycles_active);
	printf("Cycles WAIT   : %6d\n", cycles_wait);
	
	return 0;
}

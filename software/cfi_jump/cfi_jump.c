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

label0:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label1
	);

label1:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label2
	);

label2:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label3
	);

label3:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label4
	);

label4:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label5
	);

label5:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label6
	);

label6:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label7
	);

label7:
	asm goto(
		"j %l0 \n\t"
		"nop"
		::::label8
	);

label8:
	return 0;

}


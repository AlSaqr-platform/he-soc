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


  #define PLIC_BASE     0x0C000000
  #define PLIC_CHECK    PLIC_BASE + 0x201004

  //enable bits for sources 0-31
  #define PLIC_EN_BITS  PLIC_BASE + 0x2080

  int a, b, c, d, e, f;
  int mbox_id = 10;


  // Initialazing the interrupt controller
  pulp_write32(PLIC_BASE+mbox_id*4, 1);                                // set mbox interrupt priority to 1
  pulp_write32(PLIC_EN_BITS+(((int)(mbox_id/32))*4), 1<<(mbox_id%32)); // enable interrupt

  ////////////////////// start memory test //////////////////////

  pulp_write32(0x10404008, 0xBAADC0DE); // implements pointer based write (addr,data)
  pulp_write32(0x10404010, 0xBAADC0DE);
  pulp_write32(0x10404014, 0xBAADC0DE);
  pulp_write32(0x10404018, 0xBAADC0DE);
  pulp_write32(0x1040401C, 0xBAADC0DE);

  a = pulp_read32(0x10404008);          // implements pointer based read  (addr)
  b = pulp_read32(0x10404010);
  c = pulp_read32(0x10404014);
  d = pulp_read32(0x10404018);
  e = pulp_read32(0x1040401C);

  if( a == 0xBAADC0DE && b == 0xBAADC0DE && c == 0xBAADC0DE && d == 0xBAADC0DE && e == 0xBAADC0DE){
     printf("Ariane: Populating mbox memory and ringing doorbell, Hello Ibex :)\r\n");
     uart_wait_tx_done();
     pulp_write32(0x10404020, 0x00000001); // ring doorbell
     while(pulp_read32(PLIC_CHECK)!=mbox_id)
       asm volatile ("wfi"); // the handler just returns here + 4
  }
  else{
     printf("Mailbox failure!\n");
     uart_wait_tx_done();
     return 0;
  }

  // Start of """Interrupt Service Routine""" (this code should be into an IRQ Handler)
  printf("Ibex: the mbox irq has been received and processed.\r\nIbex: raising the completion irq, Hello Ariane :)\r\n");
  uart_wait_tx_done();
  pulp_write32(0x10404024, 0x00000000); // Cleaning the irq source
  pulp_write32(PLIC_CHECK, mbox_id);    // Completing irq (according to riscv specs)
  printf("Ariane: completion irq received\r\n");
  uart_wait_tx_done();

  // end of """Interrupt Service Routine"""

  printf("Test Succeeded!!!\r\n");
  uart_wait_tx_done();

  return 0;
}

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

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include "utils.h"
#include "aplic.h"

#define CSR_MTOPEI 	0x35C
#define MBOX_IRQ_ID 10
#define MBOX_IMSIC_ID 1

int main(int argc, char const *argv[]) {

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 40000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif

  int a, b, c, d, e, f;
  bool cond_ctl = false;

  // Initialazing the uart
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  unsigned val_1 = 0x00001808;  // Set global interrupt enable in ibex regs
  unsigned val_2 = 0x00000800;  // Set external interrupts

  asm volatile("csrw  mstatus, %0\n" : : "r"(val_1));
  asm volatile("csrw  mie, %0\n"     : : "r"(val_2));

  aplic_init();
  imsic_init();

  config_irq_aplic(MBOX_IRQ_ID,MBOX_IMSIC_ID);

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
  printf("Ariane: completion irq received\r\n");
  uart_wait_tx_done();

  // end of """Interrupt Service Routine"""

  printf("Test Succeeded!!!\r\n");
  uart_wait_tx_done();

  return 0;
}


void handle_trap(uintptr_t cause, uintptr_t epc, uintptr_t regs[32])
{
  bool cond_ctl = imsic_intp_arrive(MBOX_IMSIC_ID);
  pulp_write32(0x10404024, 0x00000000); // Cleaning the irq source
  CSRW(CSR_MTOPEI, 0);
  return;
}

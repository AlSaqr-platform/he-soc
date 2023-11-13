// Copyright 2021 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include "uart.h"
#define SPL_SRC 0x1001000UL
#define SPL_SIZE 0xC000
#define SPL_DEST 0x70000000UL

#define read_csr(reg) ({ unsigned long __tmp;    \
  asm volatile ("csrr %0, " #reg : "=r"(__tmp)); \
  __tmp; })

// Boot modes.
enum boot_mode_t { JTAG, SPL_ROM };

int mbox_id = 10;

int main() {
    //  TODO:Fix uart deadlock

    int * pointer;
    __asm__ volatile(
        "csrr a0, mhartid;"
        "la a1, device_tree;");
      //"ebreak;");

    while (1) {
      wait_for_boot_irq();
      claim_irq();
      boot();
    }
}

void handle_trap(void) {
}

void wait_for_boot_irq(void) {
  int * pointer;
  if(read_csr(mhartid))
    pointer=(int *)0x0C203004;
  else
    pointer=(int *)0x0C201004;
  while(*pointer != mbox_id)
    __asm__ volatile("wfi;");
}

void claim_irq(void) {
  int * pointer;
  if(read_csr(mhartid)){
    pointer = (int *) 0x0C203004;
    *pointer = mbox_id;
    pointer = (int *) 0x0C002180; // disable core 1 plic target
    *pointer = 0x0;
  }
  else{
    pointer = (int *) 0x0C201004;
    *pointer = mbox_id;
    pointer = (int *) 0x0C002080; // disable core 1 plic target
    *pointer = 0x0;
  }
}

void boot(void) {
  int * pointer;
  pointer=(int *)0x10404024;
  *pointer=0x0;
  __asm__ volatile("li a0, 0x10404000;");
  __asm__ volatile("lwu t0, 0(a0);");
  __asm__ volatile("jr t0;");
}

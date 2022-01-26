// Copyright 2021 ETH Zurich and University of Bologna.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

#include "uart.h"
#define SPL_SRC 0x1001000UL
#define SPL_SIZE 0xC000
#define SPL_DEST 0x70000000UL

// Boot modes.
enum boot_mode_t { JTAG, SPL_ROM };

int main() {
    //  TODO:Fix uart deadlock

    __asm__ volatile(
        "csrr a0, mhartid;"
        "la a1, device_tree;"
        "ebreak;");

    
    while (1) {
            __asm__ volatile("wfi;");
    }
}

void handle_trap(void) {
}

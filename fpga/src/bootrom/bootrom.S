# Copyright 2020 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

.global _start
_start:
    li    sp, 0x84000000
    # write exception vector
    la    t0, exception
    csrw  mtvec, t0
    # That will park all 32-bit cores since it isn't a supported instruction.
    
    lwu   t0, main
    call  main
exception:
    wfi
    li t1, 0x00000000
    li a4, 0x0C201004     // load completion irq address (for PLIC)
    li a3, 0x10404000     // load mbox base address
    li t4, 0x0000008F     // mbox id to be written to plic regs
    lw t3, 0(a4)          // load irq id from plic
//    lw t3, 0x24(a3)       // load content of mbox irq register
    bne t3, t4, exception // if 0, another irq: jump to wfi again
    j     secure_boot     // if 1, mbox irq: jump to secure boot
entry_addr:
    .word exception

.align 3
.globl device_tree
device_tree:
   .incbin "occamy.dtb"

.section .text.secure_boot
.globl secure_boot
secure_boot:
  sw t1, 0x24(a3)        // clear the mbox irq
  sw t4, 0(a4)           // resolve irq pending to plic
  lwu t2, 0(a3)          // load form mbox the PC wrote by OpenTitan
  jr t2                  // jump to the received PC

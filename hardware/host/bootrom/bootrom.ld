/* Copyright 2022 ETH Zurich and University of Bologna. */
/* Licensed under the Apache License, Version 2.0, see LICENSE for details. */
/* SPDX-License-Identifier: Apache-2.0 */

MEMORY {
  bootrom (rx)  : ORIGIN = 0x00010000, LENGTH = 64K
  spm (rwx)     : ORIGIN = 0x1C000000, LENGTH = 32K
}

SECTIONS {
  __stack_pointer$  = ORIGIN(spm) + LENGTH(spm) - 8;

  .text : {
    *(.text._start)
    *(.text)
    *(.text.*)
  } > bootrom

  .misc : ALIGN(16) {
    *(.rodata)
    *(.rodata.*)
    *(.data)
    *(.data.*)
    *(.srodata)
    *(.srodata.*)
    *(.sdata)
    *(.sdata.*)
  } > bootrom

  . = ALIGN(32);
  __bss_start = .;
  .bss : {
    *(.bss)
    *(.bss.*)
    *(.sbss)
    *(.sbss.*)
  } > bootrom
  . = ALIGN(32);
  __bss_end = .;

  .bulk : ALIGN(16) {
    *(.bulk)
    *(.bulk.*)
  } > bootrom
}

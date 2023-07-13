/*======================================================================*/
/* Proxy kernel linker script                                           */
/*======================================================================*/
/* This is the linker script used when building the proxy kernel. */

/*----------------------------------------------------------------------*/
/* Setup                                                                */
/*----------------------------------------------------------------------*/

/* The OUTPUT_ARCH command specifies the machine architecture where the
   argument is one of the names used in the BFD library. More
   specifically one of the entires in bfd/cpu-mips.c
   See LICENSE for license details.
*/

OUTPUT_ARCH( "riscv" )
ENTRY(_start)

/*----------------------------------------------------------------------*/
/* Sections                                                             */
/*----------------------------------------------------------------------*/

SECTIONS
{

  /* text: for code & constants */
  . = 0x80000000;
  .text.init : { *(.text.init) }

  . = ALIGN(0x1000);
  .tohost : { *(.tohost) }

  .text : { *(.text) }

  /* data: for initialized data */
  .data : { *(.data) }

  .sdata : {
    __global_pointer$ = . + 0x800;
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
  }

  /* Read Only Cluster Code */
  .rodata :  {
    *(.rodata);
    . = ALIGN(0x10);
    __cluster_code_start = . ;
    KEEP(*(.clusterraw*))
    __cluster_code_end = . ;
    }

  /* bss: for uninitialized data */
  .sbss : {
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  }
  .bss : {
    *(.bss)
  }

  /* thread-local data segment */
  .tdata :
  {
    _tls_data = .;
    *(.tdata.begin)
    *(.tdata)
    *(.tdata.end)
  }
  .tbss :
  {
    *(.tbss)
    *(.tbss.end)
  }

  /* stack 256K */
  .stack :
  {
    . = . + 0x8000;
    _stack = .;
  }

  /* End of uninitalized data segement */
  _end = .;
}

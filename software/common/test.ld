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

MEMORY
{
  L2      (rwx) : ORIGIN = 0x1C000000, LENGTH = 0x00100000
  L3      (rwx) : ORIGIN = 0x80000000, LENGTH = 0x20000000
}

/*----------------------------------------------------------------------*/
/* Sections                                                             */
/*----------------------------------------------------------------------*/

SECTIONS
{

  /* text: for code & constants */
  . = 0x80000000;
  .text.init : { *(.text.init) } > L3
  . = 0x80000100;
  .nocache_share_region : { *(.nocache_share_region) }
  . = ALIGN(0x1000);
  .tohost : { *(.tohost) } > L2

  .text : { *(.text) } > L3

  /* data: for initialized data */
  .data : { *(.data) } > L3

  .sdata : {
    __global_pointer$ = . + 0x800;
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
  } > L3

  /* Read Only Cluster Code */
  .rodata :  {
    *(.rodata);
    . = ALIGN(0x10);
    __cluster_code_start = . ;
    KEEP(*(.clusterraw*))
    __cluster_code_end = . ;
    } > L3

  /* bss: for uninitialized data */
  .sbss : {
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  } > L3
  .bss : {
    *(.bss)
  } > L3

  /* thread-local data segment */
  .tdata :
  {
    _tls_data = .;
    *(.tdata.begin)
    *(.tdata)
    *(.tdata.end)
  } > L3
  .tbss :
  {
    *(.tbss)
    *(.tbss.end)
  } > L3

  /* stack 256K */
  .stack :
  {
    . = . + 0x8000;
    _stack = .;
  } > L3

  /* End of uninitalized data segement */
  _end = .;
}

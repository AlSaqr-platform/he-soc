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
  LLC     (rwx) : ORIGIN = 0x70000000, LENGTH = 0x00020000
  L2      (rwx) : ORIGIN = 0x1C000000, LENGTH = 0x00008000
  L3      (rwx) : ORIGIN = 0x80000000, LENGTH = 0x20000000
}

/*----------------------------------------------------------------------*/
/* Sections                                                             */
/*----------------------------------------------------------------------*/

SECTIONS
{

  /* text: for code & constants */
  . = 0x70000000;
  .text.init : { *(.text.init) } > LLC
  . = 0x70000100;
  .nocache_share_region : { *(.nocache_share_region) } > LLC
  . = ALIGN(0x1000);
  .tohost : { *(.tohost) } > L2

  .text : { *(.text) } > LLC

  /* SPM DATA */
  .spm_data : { *(.heapl2ram) } > L2

  /* data: for initialized data */
  .data : { *(.data) } > LLC

  .sdata : {
    __global_pointer$ = . + 0x800;
    *(.srodata.cst16) *(.srodata.cst8) *(.srodata.cst4) *(.srodata.cst2) *(.srodata*)
    *(.sdata .sdata.* .gnu.linkonce.s.*)
  } > LLC

  /* Read Only Cluster Code */
  .rodata :  {
    *(.rodata);
    . = ALIGN(0x10);
    __cluster_code_start = . ;
    KEEP(*(.clusterraw*))
    __cluster_code_end = . ;
    } > LLC

  /* bss: for uninitialized data */
  .sbss : {
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  } > LLC
  .bss : {
    *(.bss)
  } > LLC

  /* thread-local data segment */
  .tdata :
  {
    _tls_data = .;
    *(.tdata.begin)
    *(.tdata)
    *(.tdata.end)
  } > LLC
  .tbss :
  {
    *(.tbss)
    *(.tbss.end)
  } > LLC

  /* stack 16K */
  .stack :
  {
    . = . + 0x4000;
    _stack = .;
  } > LLC

  /* End of uninitalized data segement */
  _end = .;
}

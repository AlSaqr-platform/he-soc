/*======================================================================*/
/* Proxy kernel linker script                                           */
/*======================================================================*/
/* This is the linker script used when building the proxy kernel. */

/*----------------------------------------------------------------------*/
/* Setup                                                                */
/*----------------------------------------------------------------------*/

/* The OUTPUT_ARCH command specifies the machine architecture where the
   argument is one of the names used in the BFD library. More
   specifically one of the entires in bfd/cpu-mips.c */

OUTPUT_ARCH( "riscv" )
ENTRY(_start)

/*----------------------------------------------------------------------*/
/* Memory layout                                                        */
/*----------------------------------------------------------------------*/


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
  /* set the base address at the beginnning of the RAM */
  . = 0x80000000;
  .text.init : { *(.text.init) } > L3
  /* to host mapped in L2 non-cached region because we use WB cache */
  . = ALIGN(0x1000);
  .tohost : { *(.tohost) } > L2

  .text : { *(.text) } > L3

  /* data segment */
  .data : {
    *(.cached_region_2)
  } > L3

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

  .nocache_noshare_region : {
    *(.nocache_noshare_region)
    } > L3

  .nocache_share_region : {
    *(.nocache_share_region)
  } > L3

  .cache_share_region : {
    *(.cache_share_region)
  } > L3

  .cache_noshare_region : {
    *(.cache_noshare_region)
  } > L3

  /* bss segment */
  .sbss : {
    *(.sbss .sbss.* .gnu.linkonce.sb.*)
    *(.scommon)
  } > L3

  .bss : {
    *(.bss)
  } > L3

  /* thread-local data segment */
  .tdata : {
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


OUTPUT_ARCH(riscv)
ENTRY( _start )
MEMORY
{
  L3           : ORIGIN = 0x800088a0, LENGTH = 0x0000fffc
  L1           : ORIGIN = 0x10000004, LENGTH = 0x0003fff8
}

/*
 * This linker script try to put FC data in L2 private bank0 and FC code 
 * in L2 private bank1 to avoid contention between FC code and data
 * as FC has no instruction cache and is so often accessing L2 to
 * get instructions. Everything can be shifted in case one bank is full.
 *
 * Cluster code and initialized data are put in shared banks to not polute
 * private banks which are quite small, and also avoid contentions between
 * cluster cache refill and FC.
 */


SECTIONS
{
  /*
   * L2 PRIVATE BANK0
   *
   * Contains FC data
   */

  .init :
  {
    . = ALIGN(4);
    KEEP( *(.init) )
  } > L3


  .fini :
  {
    . = ALIGN(4);
    KEEP( *(.fini) )
  } > L3


  .preinit_array : {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__preinit_array_start = .);
    KEEP (*(.preinit_array))
    PROVIDE_HIDDEN (__preinit_array_end = .);
  } > L3


  .init_array : {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__init_array_start = .);
    __CTOR_LIST__ = .;
    LONG((__CTOR_END__ - __CTOR_LIST__) / 4 - 2)
    KEEP(*(.ctors.start))
    KEEP(*(.ctors))
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array ))
    LONG(0)
    __CTOR_END__ = .;
    PROVIDE_HIDDEN (__init_array_end = .);
  } > L3


  .fini_array : {
    . = ALIGN(4);
    PROVIDE_HIDDEN (__fini_array_start = .);
    __DTOR_LIST__ = .;
    LONG((__DTOR_END__ - __DTOR_LIST__) / 4 - 2)
    KEEP(*(.dtors.start))
    KEEP(*(.dtors))
    LONG(0)
    __DTOR_END__ = .;
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array ))
    PROVIDE_HIDDEN (__fini_array_end = .);
  } > L3


  .boot : {
    . = ALIGN(4);
    *(.boot)
    *(.boot.data)
  } > L3


  .rodata : {
    . = ALIGN(4);
    *(.rodata);
    *(.rodata.*)
    *(.srodata);
    *(.srodata.*)
    *(.eh_frame*)
  } > L3


  .got : {
    . = ALIGN(4);
    *(.got.plt) * (.igot.plt) *(.got) *(.igot)
  } > L3


  .shbss : {
    . = ALIGN(4);
    *(.shbss)
  } > L3


  .talias : {
  } > L3


  .gnu.offload_funcs : {
    . = ALIGN(4);
    KEEP(*(.gnu.offload_funcs))
  } > L3


  .gnu.offload_vars : {
    . = ALIGN(4);
    KEEP(*(.gnu.offload_vars))
  } > L3


  .stack : {
    . = ALIGN(4);
    . = ALIGN(16);
    stack_start = .;
    . = . + 0x800;
    stack = .;
  } > L3


  .data : {
    . = ALIGN(4);
    sdata  =  .;
    _sdata  =  .;
    *(.data_fc)
    *(.data_fc.*)
    *(.data);
    *(.data.*)
    *(.sdata);
    *(.sdata.*)
    *(.heapl2ram)
    *(.fcTcdm)
    *(.fcTcdm.*)
    *(.fcTcdm_g)
    *(.fcTcdm_g.*)
    . = ALIGN(4);
    edata  =  .;
    _edata  =  .;
  } > L3


  .bss : {
    . = ALIGN(8);
    _bss_start = .;
    *(.bss)
    *(.bss.*)
    *(.sbss)
    *(.sbss.*)
    *(COMMON)
    . = ALIGN(4);
    _bss_end = .;
  } > L3


  __l2_priv0_end = ALIGN(4);




  /*
   * L2 PRIVATE BANK1
   *
   * Contains FC code
   */

  .vectors MAX(0x80008280 + 8 * 1024,ALIGN(256)) :
  {
    . = ALIGN(256);
    __irq_vector_base = .;
    KEEP(*(.vectors))
  } > L3

  .text :
  {
    . = ALIGN(4);
    _stext = .;
    *(.text)
    *(.text.*)
    _etext  =  .;
    *(.lit)
    *(.shdata)
    _endtext = .;
    . = ALIGN(4);
  } > L3

  __l2_priv1_end = ALIGN(4);


  /*
   * L2 SHARED BANKS
   *
   * Contains other data such as peripheral data and cluster code and data
   */

  .l2_data MAX(0x80008280 + 16 * 1024,ALIGN(4)) :
  {
    . = ALIGN(4);
    __cluster_text_start = .;
    *(.cluster.text)
    *(.cluster.text.*)
    . = ALIGN(4);
    __cluster_text_end = .;
    *(.l2_data)
    *(.l2_data.*)
    *(.data_fc_shared)
    *(.data_fc_shared.*)
    . = ALIGN(4);
  } > L3

  .l1cluster_g : {
    . = ALIGN(4);
    *(.heapsram)
    *(.heapsram.*)
    *(.l1cluster_g)
    *(.l1cluster_g.*)
    *(.data_l1)
    *(.data_l1.*)
    . = ALIGN(4);
    _libgomp_start = .;
    *(.libgomp)
    *(.libgomp.*)
    . = ALIGN(4);
  } > L1

  .bss_l1 : {
    . = ALIGN(4);
    *(.bss_l1)
    *(.bss_l1.*)
    . = ALIGN(4);
  } > L1

  __l1_end = ALIGN(4);

  __l2_shared_end = LOADADDR(.bss_l1) + SIZEOF(.bss_l1);




  __cluster_text_size = __cluster_text_end - __cluster_text_start;

  __l1_heap_start = ALIGN(4);
  __l1_heap_size = LENGTH(L1) - __l1_heap_start + ORIGIN(L1);
}

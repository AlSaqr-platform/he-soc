//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "./cluster_code.h"
//#define FPGA_EMULATION

int main(int argc, char const *argv[]) {

  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  // C2H TLB configuration
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, c2h_flags);
  
  uint32_t * hyaxicfg_reg_mask = 0x1A104018;
  pulp_write32(hyaxicfg_reg_mask,26); //128MB addressable
  uint32_t * hyaxicfg_reg_memspace = 0x1A104024;
  pulp_write32(hyaxicfg_reg_memspace,0x84000000); // Changing RAM end address, 64 MB
  // cluster setup
  load_cluster_code();
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1C000854,0x1C00813E);
  pulp_write32(0x100000CC,0);
  pulp_write32(0x10201400,0xffffffff);
  pulp_write32(0x100000C8,0x0000ff38);
  pulp_write32(0x100000CC,0);
  pulp_write32(0x100040CC,0);
  pulp_write32(0x100040C8,0x0000BF38);
  pulp_write32(0x100000C4,0x100000C8);
  //start of custom memory set-up
  pulp_write32(0x10000004, 0x1C0011b8);
  pulp_write32(0x1C0011b8, 0x1c008a84);
  pulp_write32(0x1c0011bc, 0x1c00118c);
  pulp_write32(0x1c0011d8, 0x00000000);
  pulp_write32(0x1c0011c4, 0x00000800);
  pulp_write32(0x1c0011c8, 0x00000400);
  pulp_write32(0x1c0011dc, 0x000000ff);
  pulp_write32(0x1c0011cc, 0x00000008);
  pulp_write32(0x1c00118c, 0x1c008a9a);
  pulp_write32(0x1c0011c0, 0x100001a8);
  pulp_write32(0x1c0011d0, 0x1c001130);
  //end of custom memory set-up
  
  // change ris5y boot addresses
  int boot_addr_core=0x10200040;
  for (int i=0; i<8; i++)
    pulp_write32(0x10200040+i*4,0x1C008080);
  pulp_write32(0x1A106000,0x3);
  pulp_write32(0x1A106000,0x7);
  pulp_write32(0x10200008,0xff);

  while( ((pulp_read32(0x10001000))<<31)!=0x80000000 );

  if(((pulp_read32(0x10001000))<<31)==0x80000000){
    printf("FP16ALT test OK\n");
    uart_wait_tx_done();
    return 0; }
  else {
    printf("FP16ALT test FAILED!\n");
    uart_wait_tx_done();
    return -1; }
    
  return -1;
}
 



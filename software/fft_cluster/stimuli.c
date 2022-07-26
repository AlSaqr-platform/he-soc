#include <stdio.h>
#include "encoding.h"
#include "utils.h"
#include "./cluster_code.h"
#include "fft.h"
#include "data_signal.h"
#include "data_out.h"

#define CHECK
#define PLIC_BASE 0x0C000000

int main(int argc, char const *argv[]) {
  int i, m, n;
  volatile uint64_t perf_c;
  uint32_t mb_plic_id = 8;
  
  pulp_write32(0x10403018,0x1);
  pulp_write32(0x10403024,0x1);
  pulp_write32(0x10402018,0x1);
  pulp_write32(0x10402024,0x1);

  // C2H TLB configuration
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  int baud_rate = 115200;
  int test_freq = 50000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  perf_c = -read_csr(mcycle);
  load_cluster_code();
  
  pulp_write32(PLIC_BASE+(mb_plic_id*4),0x1);
  pulp_write32(PLIC_BASE+0x2000,1<<mb_plic_id);

  // Reset the cluster
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);
  
  pulp_write32(0x10402000,Input_Signal);
  pulp_write32(0x10402000,twiddle_factors);
  pulp_write32(0x10402000,bit_rev_radix2_LUT);
  pulp_write32(0x10402000,Buffer_Signal_Out);

  int boot_addr_core=0x10200040;
  for (int i=0; i<8; i++)
    pulp_write32(0x10200040+i*4,0x1C000000);

  // Set enable and fetch enable
  pulp_write32(0x1A106000,0x3);
  pulp_write32(0x1A106000,0x7);

  // Cluster control unit registers, fetch enable
  pulp_write32(0x10200008,0xff);

  while ( pulp_read32(PLIC_BASE+0x200004)!=mb_plic_id ) {
   asm volatile ("wfi");
  }  
  perf_c += read_csr(mcycle);
  uint32_t msg;
  msg = pulp_read32(0x10402004);
    
  #ifdef CHECK    
  int re_err = 0;
  int im_err = 0;
  
  for(i=0;i<FFT_LEN_RADIX2;i++)
  {
    if (check_re(Buffer_Signal_Out,ref, i)) {
    	re_err++;
    }
    
    if(check_im(Buffer_Signal_Out,ref, i)){
    	im_err++;
    }
    
  }

  #ifdef VERBOSE
  if((re_err+im_err) != 0)
    printf("TEST FAILED!!\r\n");
  else if((re_err!=0) & (im_err!=0))
    printf("TEST FAILED with %d errors on real part and %d errors on imaginary part!!\r\n", re_err, im_err);
  else if(re_err != 0)
    printf("TEST FAILED with %d errors on the real part!!\r\n", re_err);
  else if(im_err != 0)
    printf("TEST FAILED with %d errors on the imaginary part!!\r\n", im_err);

  if(re_err+im_err==0)
    printf("TEST PASSED in %d\r\n", perf_c);
  #endif
    
  uart_wait_tx_done();

  printf("Cycles cluster %x\r\n", msg);
  
  #endif

  pulp_write32(0x10403018,0x1);
  pulp_write32(0x10403024,0x1);
  pulp_write32(0x10402018,0x1);
  pulp_write32(0x10402024,0x1);

  return 0;

}

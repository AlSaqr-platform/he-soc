//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

#define PLIC_BASE 0x0C000000
long int buffer [256 * 1024]; // 8 bytes * 256 * 1024 byte = 2 MB

extern int __cluster_code_start;
extern int __cluster_code_end;

int load_cluster_code() {
  uint32_t *p, *end, *p0;
  p = (uint32_t*)&__cluster_code_start;
  p0 = (uint32_t*)&__cluster_code_start;
  end = (uint32_t*)&__cluster_code_end;
  uint32_t * addr;
  while(p<end){
     addr = 0x1C000000 + ((p - p0)*4);
     pulp_write32(addr,pulp_read32(p));
     p++;
  }
  return 0;
  uart_wait_tx_done();
}

int cl_start(unsigned int boot_addr) {
  // Reset the cluster
  pulp_write32(0x1A106000,0x1);
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);

  // change ris5y boot addresses
  int boot_addr_core=0x10200040;
  for (int i=0; i<8; i++)
    pulp_write32(0x10200040+i*4,boot_addr);

  // Set enable and fetch enable
  pulp_write32(0x1A106000,0x3);
  pulp_write32(0x1A106000,0x7);

  // Cluster control unit registers, fetch enable
  pulp_write32(0x10200008,0xff);
}

int rst_mbox() {
  pulp_write32(0x10403018,0x1);
  pulp_write32(0x10403024,0x1);
  pulp_write32(0x10402018,0x1);
  pulp_write32(0x10402024,0x1);
}

int launch_cluster() {
  uart_wait_tx_done();
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, 0x07);

  load_cluster_code();

  uint32_t mb_plic_id = 8;
  pulp_write32(PLIC_BASE+(mb_plic_id*4),0x1);
  pulp_write32(PLIC_BASE+0x2000,1<<mb_plic_id);

  rst_mbox();
  pulp_write32(0x10402000,buffer);

  cl_start(0x1C000000);

  return 0;
}

void read_from_cache(int l1_way_size, int stride) {
    asm volatile("": : :"memory");     
    for(int j = 0; j < l1_way_size; j++)
    {
      * ( ( volatile long int * ) &buffer[j] );
    }
    asm volatile("": : :"memory");    
    for(int j = 0; j < l1_way_size; j++)
    {
      * ( ( volatile long int * ) &buffer[(j+0)*stride]);
    }
    asm volatile("": : :"memory");    
}

void write_to_cache(int l1_way_size, int stride) {
    asm volatile("": : :"memory");     
    for(int j = 0; j < l1_way_size; j++)
    {
      buffer[j] = 0;
    }
    asm volatile("": : :"memory");    
    for(int j = 0; j < l1_way_size; j++)
    {
      buffer[(j+0)*stride] = 0;
    }
    asm volatile("": : :"memory");    
}

int sweep(int stride)
{

  int l1_way_size = 4 * 1024 / 8;
  int working_set = l1_way_size * stride * 8;

  long unsigned instret_start, cycle_start;
  long unsigned numload_start, dcachemiss_start;
  unsigned int llc_hit;
  unsigned int llc_miss;
    
  for(int i = 0; i < 10; i++)
  {
    if(i==1)
    {
      instret_start = read_csr(minstret);
      cycle_start = read_csr(mcycle);
      numload_start = read_csr(mhpmcounter7);
      dcachemiss_start = read_csr(mhpmcounter4);
      llc_miss = get_llc_miss();
      llc_hit = get_llc_hit();
    }
    // write_to_cache(l1_way_size,stride);
    read_from_cache(l1_way_size, stride);
  }

  long unsigned instrets = read_csr(minstret) - instret_start;
  long unsigned cycles = read_csr(mcycle) - cycle_start;
  long unsigned numload = read_csr(mhpmcounter7) - numload_start;
  long unsigned dcachemiss = read_csr(mhpmcounter4) - dcachemiss_start;
  llc_miss = get_llc_miss() - llc_miss;
  llc_hit = get_llc_hit() - llc_hit;

//  printf("%3dKB        , %6d       , %6d     , %5d      , %5d       , %5d       , %5d\r\n", 
//           working_set / 1024, (int)instrets, (int)cycles, (int)numload, (int)dcachemiss, llc_miss, llc_hit );
//  uart_wait_tx_done();
//  printf("%6d\r\n",(int)cycles);
//  uart_wait_tx_done();

  return (int)cycles;
}


int main()
{
//  int baud_rate = 115200;
//  int test_freq = 50000000;
  int baud_rate = 4800;
  int test_freq = 10000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  enable_llc_counters();

  int cycles[5];
//  printf("Working_set  , instructions , cycles     , num loads  , l1 dmiss    , LLC miss    , LLC hit\r\n");
//  uart_wait_tx_done();

  launch_cluster();  

  int j=0;
  for( int i = 4; i<128; i=i*2){
    cycles[j] = sweep(i);
    j++;
  }

  for(int i=0;i<5;i++)
    printf("%d\r\n",cycles[i]);

  return 0;
}
 



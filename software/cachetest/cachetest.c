//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

long int buffer [256 * 1024]; // 8 bytes * 256 * 1024 byte = 2 MB

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

void sweep(int stride)
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
    read_from_cache(l1_way_size, stride);
  }

  long unsigned instrets = read_csr(minstret) - instret_start;
  long unsigned cycles = read_csr(mcycle) - cycle_start;
  long unsigned numload = read_csr(mhpmcounter7) - numload_start;
  long unsigned dcachemiss = read_csr(mhpmcounter4) - dcachemiss_start;
  llc_miss = get_llc_miss() - llc_miss;
  llc_hit = get_llc_hit() - llc_hit;

  printf("%3dKB        , %6d       , %6d     , %5d      , %5d       , %5d       , %5d\r\n", 
           working_set / 1024, (int)instrets, (int)cycles, (int)numload, (int)dcachemiss, llc_miss, llc_hit );
  uart_wait_tx_done();
  
}


int main()
{
  int baud_rate = 115200;
  int test_freq = 50000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  enable_llc_counters();

  printf("Working_set  , instructions , cycles     , num loads  , l1 dmiss    , LLC miss    , LLC hit\r\n");
  
  for( int i = 4; i<128; i=i*2)
    sweep(i);
    
  return 0;
}
 



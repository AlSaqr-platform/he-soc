//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"
#define FPGA_EMULATION
#include "mm.h"

void matrix_init() {
  unsigned int i, j;

  // init, copy to TCDM
  for(i = 0; i < SIZE; i++) {
    for(j = 0; j < SIZE; j++) {
      g_mA[i][j] = m_a[i * SIZE + j];
      g_mB[i][j] = m_b[i * SIZE + j];
      g_mC[i][j] = 0;
    }
  }
}

unsigned int matrix_check() {
  unsigned int errors = 0;
  unsigned int i, j;
  // check
  for(i = 0; i < SIZE; i++) {
    for(j = 0; j < SIZE; j++) {
      if(g_mC[i][j] != m_exp[i * SIZE + j]) {
        printf("At index %d, %d\n", i, j, 0, 0);
        errors++;
      }
    }
  }

  return errors;
}

int main(int argc, char const *argv[]) {

  #ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  uint64_t perf_c;
  int cid = 0;
  
  int num_cores = 1;
  int core_id = 0;
  unsigned int i, j, k;
  unsigned int chunk;
  unsigned int lb, ub;
  unsigned int errors = 0;

  chunk = SIZE / num_cores;
  // lower bound
  lb = core_id * chunk;
  // upper bound
  ub = lb + chunk;

  if(core_id == 0) {
    matrix_init();
  }
  size_t instret, cycles, icachemiss, dcachemiss;
  unsigned int llc_hit;
  unsigned int llc_miss;
  
  asm volatile("": : :"memory");
  long unsigned int start = read_csr(mcycle);
  icachemiss = -read_csr(mhpmcounter3);
  dcachemiss = -read_csr(mhpmcounter4);
  instret = -read_csr(minstret);
  enable_llc_counters();
  llc_miss = get_llc_miss();
  llc_hit = get_llc_hit();
  
  asm volatile("": : :"memory");

  for(i = lb; i < ub; i++) {
    for(j = 0; j < SIZE; j++) {
      for(k = 0; k < SIZE; k++) {
        g_mC[i][j] += g_mA[i][k] * g_mB[k][j];
      }
    }
  }
  
  asm volatile("": : :"memory");
  llc_miss = get_llc_miss() - llc_miss;
  llc_hit = get_llc_hit() - llc_hit;
  long unsigned int end = read_csr(mcycle);
  instret = -read_csr(minstret);
  icachemiss += read_csr(mhpmcounter3);
  dcachemiss += read_csr(mhpmcounter4);
  asm volatile("": : :"memory");

  long unsigned int perfc = end -start;
  

  printf("g_mA @ %x g_mB @ %x\r\n", &g_mA, &g_mB);
  if(errors==0)
    printf("success in %d\r\n", (uint32_t)(perfc) );

  printf("C%d: 0x%x instructions\r\n", cid, (int)(instret));
  uart_wait_tx_done();
  printf("C%d: %d dcachemiss\r\n", cid, (int)(dcachemiss));
  uart_wait_tx_done();
  printf("C%d: %d icachemiss\r\n", cid, (int)(icachemiss));
  uart_wait_tx_done();
  printf("C%d: LLC hit %d miss %d tot %d \r\n", cid, (int)(llc_hit), (int)(llc_miss), (int)(llc_miss+llc_hit));
  uart_wait_tx_done();

  
  uart_wait_tx_done();
  return 0;
}
 



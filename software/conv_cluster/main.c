// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
#include <stdio.h>
#include <math.h>
#include "encoding.h"
#include "utils.h"
#include "./cluster_code.h"
#include "input.h"
#include "ref.h"

#include "conv_kernel.c"
#define ABS(x) ((x>=0)?x:-x)
#define CHECK
#define VERBOSE
#define PLIC_BASE 0x0C000000

void __attribute ((noinline)) check_result(int cid, int * result, int SIZE) {

  if(cid == 0) {
    float diff;
    int err = 0;

    for (int i = 2; i < ROWS-2; i++) {
      for (int j = 2; j < COLS -2 ; j++) {
        
        if(result[i*ROWS+j]!=ref[i*ROWS+j]) {
          err++;
          #ifdef VERBOSE
          if(err<5)
            printf("Error at index %d,%d:\t expected %u\t real %u\t \r\n", i,j ,ref[ROWS*i + j], result[i*ROWS +j]);
          #endif
        }
      }
    }
  
  
    if(err != 0)
      printf("TEST FAILED with %d errors!!\n", err);
    else
      printf("TEST PASSED!!\n");

    return;
  }
}

int main(int argc, char const *argv[]) {
  
  volatile long int perf_c;
  uint32_t mb_plic_id = 8;
  int Out[IMG_DIM];  
  
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
  
  pulp_write32(0x10402000,In_Img);
  pulp_write32(0x10402000,Filter_Kern);
  pulp_write32(0x10402000,Out);
  
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

   printf("Cycles %d\r\n", perf_c);
   printf("Cycles cluster %x\r\n", msg);

  pulp_write32(0x10403018,0x1);
  pulp_write32(0x10403024,0x1);
  pulp_write32(0x10402018,0x1);
  pulp_write32(0x10402024,0x1);

  #ifdef CHECK
   check_result(0, Out, IMG_DIM);
  #endif

   return 0;
}


//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define DEFAULT_SEED 0xcaca5a5adeadbeef
#define FEEDBACK  0x6c0000397f000032
// Here is the base of the first 4 Hyperram CS0 - CS1
#define ADDR_BASE_FIRST_HALF 0x80000000 
#define ADDR_LAST_FIRST_HALF 0x81000000

// Here is the base of the scnd 4 Hyperram CS2 - CS3
#define ADDR_BASE_SCND_HALF 0x81000000 
#define ADDR_LAST_SCND_HALF 0x82000000


//  Be careful, this is the size of the hyperram we have on fpga.
//  The test takes a while also @ 10MHz. Don't run this on Questa.
//  Also, modify the linker script to have the stack in L2, if you
//  want to check the whole memory.
#define STRIDE 0x2000
//#define FPGA_EMULATION
uint64_t *lfsr_byte_feedback;

uint32_t lfsr_iter_bit(uint64_t lfsr) {
  return (lfsr & 1) ? ((lfsr >> 1) ^ FEEDBACK) : (lfsr >> 1);
}

uint32_t lfsr_iter_byte(uint64_t lfsr, uint64_t *lfsr_byte_feedback) {
  uint32_t l = lfsr;
  for(int i=0; i<8; i++)
    l = lfsr_iter_bit(l);
  return l;
}

uint32_t lfsr_iter_word(uint64_t lfsr, uint64_t *lfsr_byte_feedback) {
  uint32_t l = lfsr_iter_byte(lfsr, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  return lfsr_iter_byte(l, lfsr_byte_feedback);
}

uint64_t lfsr_64bits(uint64_t lfsr,  uint64_t *lfsr_byte_feedback) {
  uint64_t l = lfsr_iter_byte(lfsr, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  l = lfsr_iter_byte(l, lfsr_byte_feedback);
  return lfsr_iter_byte(l, lfsr_byte_feedback);
}

int main(int argc, char const *argv[]) {

  uint32_t cnt = 0;
  uint32_t cnt2= 0; // (ADDR_LAST_SCND_HALF-ADDR_BASE_FIRST_HALF)/STRIDE
  
  printf("Test L3_test_4cs starting...\r\n");
  uart_wait_tx_done();
  printf("WRITE \n" );
  uart_wait_tx_done();  

  //WRITE all the memory with stride=128B
  uint64_t lfsr = DEFAULT_SEED;
  for(uint32_t addr=ADDR_BASE_FIRST_HALF; addr<ADDR_LAST_SCND_HALF; addr+=STRIDE) {
      lfsr = lfsr_64bits(lfsr, lfsr_byte_feedback);
      *(uint64_t *)(addr) = lfsr;
  }

  //READ
  lfsr = DEFAULT_SEED;
  printf("READ\n" );
  uart_wait_tx_done();
  for(uint32_t addr=ADDR_BASE_FIRST_HALF; addr<ADDR_LAST_SCND_HALF; addr+=STRIDE) {
      lfsr = lfsr_64bits(lfsr, lfsr_byte_feedback);
      cnt2++;
      if(lfsr!=(*(uint64_t *)(addr)))
        cnt++;
  }
    
  if(cnt==0)
    printf("Test Passed: %d correct!\n", cnt2);
  else
    printf("Test FAILED: number of errors: %d/%d \n", cnt, cnt2 );
  uart_wait_tx_done();  
  return cnt;
  
}

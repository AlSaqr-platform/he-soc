#include <stdio.h>
#include <stdlib.h>
#include "pulp.h"
// #define FPGA_EMULATION

#ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
#else
  int baud_rate = 115200;
  int test_freq = 200000000;
#endif

#define BASE_ADDR     0x10000000
#define MEM_SIZE      256 * 1024

#ifdef PSEUDO_RANDOM_VALUES

  #define DEFAULT_SEED  0xabcd1234

  uint32_t xorshift32 (uint32_t state) {
    /* Algorithm "xor" from p. 4 of Marsaglia, "Xorshift RNGs" */
    uint32_t x = state;
    x ^= x << 13;
    x ^= x >> 17;
    x ^= x << 5;
    return x;
  }
#else
  #define TEST_VALUE    0xcafecafe           // write/read test value
#endif

void check_write_read_l1(int*);

PI_L2 int retval[8];

int main () {

  synch_barrier();
  
  //////////
  // TEST //
  //////////

  check_write_read_l1(retval);

  synch_barrier();

  if(core_id() == 0){
    int acc = 0;
    for (int i = 0; i < 8; i++)
      acc += retval[i];
    // Write msg to mailbox
    pulp_write32(0x10403000, acc);
  }

  while (1) {
          __asm__ volatile("wfi;");
  }

  return 0;
}

void check_write_read_l1 (int *retval) {

  unsigned int errors = 0;

  #ifdef VERBOSE
  printf("L1 WRITE READ TEST\n");
  #endif

  #ifdef PSEUDO_RANDOM_VALUES
    uint32_t xorshift_state = DEFAULT_SEED * (1 + core_id());
  #endif
  int *current_addr = (int *) BASE_ADDR + core_id();

  #ifdef VERBOSE
  printf("=== WRITE ===\n");
  printf("First addr written: %p\n", current_addr);
  #endif

  for (unsigned int i = 0; i < (MEM_SIZE >> 5); i++) {
    #ifdef PSEUDO_RANDOM_VALUES
      xorshift_state = xorshift32(xorshift_state);
      (*current_addr) = xorshift_state;
    #else
      (*current_addr) = TEST_VALUE;
    #endif
    current_addr += 8;
  }

  #ifdef VERBOSE  
  printf("Last addr written: %p\n", (current_addr-1));
  #endif

  #ifdef PSEUDO_RANDOM_VALUES
    xorshift_state = DEFAULT_SEED * (1 + core_id());
  #endif
  current_addr = (int *) BASE_ADDR + core_id();

  #ifdef VERBOSE
  printf("=== READ ===\n");
  printf("First addr read: %p\n", current_addr);
  #endif

  for (unsigned int i = 0; i < (MEM_SIZE >> 5); i++) {
    #ifdef PSEUDO_RANDOM_VALUES
      xorshift_state = xorshift32(xorshift_state);
      if (*current_addr != xorshift_state) {
        #ifdef VERBOSE
        printf("@%p: expected: %x, actual: %x\n", current_addr, xorshift_state, *current_addr);
        #endif
        errors++;
      }
    #else
      if (*current_addr != TEST_VALUE) {
        #ifdef VERBOSE
        printf("@%p: expected: %x, actual: %x\n", current_addr, TEST_VALUE, *current_addr);
        #endif
        errors++;
      }
    #endif
    current_addr += 8;
  }

  #ifdef VERBOSE
  printf("Last addr read: %p\n", (current_addr-1));
  #endif

  retval[core_id()] = errors;

  return;
}


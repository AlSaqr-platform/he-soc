#include "encoding.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "pmu_test_func.c"

// The CUA will always miss in the L1 but after one run of the loop, it will never miss in the LLC.
#define NUM_NON_CUA 3

#ifndef TESTS_AUTO
  #define JUMP_CUA        8    // multiply by 8 for bytes
  #define JUMP_NONCUA     8    // multiply by 8 for bytes
  // #define LEN_NONCUA   32768
  // #define LEN_NONCUA   524288
  #define LEN_NONCUA   40960      // array size: 320 kB
  // #define LEN_NONCUA   262144  // array size: 2048 kB
  #define START_NONCUA    0
#endif


#define INTF_RD

// Sometimes the UART skips over output.
// Gives the UART more time to finish output before filling up the UART Tx FIFO with more data.
void my_sleep() {
  uint32_t sleep = 100000;
  for (volatile uint32_t i=0; i<sleep; i++) {
    asm volatile ("fence");
    asm volatile ("addi x1, x1, 1");
    asm volatile ("fence");
  }  
}

void end_test(uint32_t mhartid){
  printf("Exiting: %0d.\r\n", mhartid);
}

#define read_32b(addr)         (*(volatile uint32_t *)(long)(addr))
#define write_32b(addr, val_)  (*(volatile uint32_t *)(long)(addr) = val_)

// *********************************************************************
// Main Function
// *********************************************************************
int main(int argc, char const *argv[]) {
  
  uint32_t mhartid;
  asm volatile (
    "csrr %0, 0xF14\n"
    : "=r" (mhartid)
  );

  uint32_t error = 0;

  // *******************************************************************
  // Core 0
  // *******************************************************************
  if (mhartid == 0) {   
    #ifdef FPGA_EMULATION
    uint32_t baud_rate = 9600;
    uint32_t test_freq = 100000000;
    #else
    set_flls();
    uint32_t baud_rate = 115200;
    uint32_t test_freq = 50000000;
    #endif
    uart_set_cfg(0,(test_freq/baud_rate)>>4);

    // Partition the cache.
    // write_32b(0x50 + 0x10401000, 0xFFFFFF00);
    // write_32b(0x54 + 0x10401000, 0xFFFF00FF);
    // write_32b(0x58 + 0x10401000, 0xFF00FFFF);
    // write_32b(0x5c + 0x10401000, 0x00FFFFFF);

    uint32_t program[] = {
      0x33,
      0x10428437,
      0x30040413,
      0x104287b7,
      0x40078793,
      0xfef42423,
      0xfe042623,
      0xfec42703,
      0x3ff00793,
      0x02e7ca63,
      0xfec42783,
      0x00279793,
      0xfe842703,
      0x00f707b3,
      0xfec42683,
      0xfec42703,
      0x02e68733,
      0x00e7a023,
      0xfec42783,
      0x00178793,
      0xfef42623,
      0xfc9ff06f,
      0x104287b7,
      0xfef42223,
      0xfe442783,
      0x10000713,
      0x00e7a023,
      0xfadff06f
    };

    uint32_t program_size = sizeof(program) / sizeof(program[0]);

    printf("Halt PMU core before writing to ISPM-hehe!\n");
    write_32b(PMC_STATUS_ADDR, 1);

    error += test_spm(ISPM_BASE_ADDR, program_size, program);

    printf("Start PMU core!\n");
    write_32b(PMC_STATUS_ADDR, 0);

    volatile uint32_t *read_addr = (uint32_t*)(DSPM_BASE_ADDR + 0x400);
    volatile uint32_t read_val;

    asm volatile ("fence");
    volatile uint32_t *done_ptr = (uint32_t*)(DSPM_BASE_ADDR);
    while (*done_ptr != 256);

    while (1) {
      printf("Run.\n");
      for (int a_idx=1; a_idx<1024; a_idx++) {
        asm volatile (
          "lw %0, 0(%1)\n"
          : "=r"(read_val)
          : "r"(read_addr + a_idx)
        );

        if (read_val != a_idx*a_idx) {
          printf("Error - %d vs %d!\n", a_idx*a_idx, read_val);
        }
      }
    }
    asm volatile ("fence");

    // test_pmu_core_bubble_sort (ISPM_BASE_ADDR, DSPM_BASE_ADDR, PMC_STATUS_ADDR, 20, 1);
    // test_pmu_core_bubble_sort (ISPM_BASE_ADDR+0x400, DSPM_BASE_ADDR+0x1000, PMC_STATUS_ADDR, 20);
    // run_pmu_core_test_suite(ISPM_BASE_ADDR,
    //                         COUNTER_B_BASE_ADDR,
    //                         DSPM_BASE_ADDR,
    //                         PMC_STATUS_ADDR, 
    //                         COUNTER_BUNDLE_SIZE,
    //                         8, 20, 1);

    printf("Error: %d\r\n", error);
    end_test(mhartid);
    uart_wait_tx_done();

  // *******************************************************************
  // Core 1-3
  // *******************************************************************
  } else if (mhartid <= NUM_NON_CUA) {
    uint64_t var;

    // 1 - 0x28, 2 - 0x2c, 3 - 0x30
    write_32b(DSPM_BASE_ADDR+0x24+mhartid*0x4, 1);

    while (1) {
      // volatile uint64_t *array = (uint64_t*)(uint64_t)(0x83000000 + mhartid * 0x01000000);
      // for (int a_idx = 0; a_idx < 262144; a_idx +=8) {
      //     var = a_idx;
      //     asm volatile (
      //       "sd   %0, 0(%1)\n"
      //       :: "r"(var),
      //           "r"(array - a_idx)
      //     );
      // } 
    }
    
  } else {
    end_test(mhartid);
    uart_wait_tx_done();
    while (1);
  }
  
  return 0;
}
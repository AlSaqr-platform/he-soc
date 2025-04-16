#include "encoding.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "pmu_test_func.c"
#include "plic.h"

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
  
  volatile uint32_t read_target_0;
  volatile uint32_t read_target_1;
  volatile uint32_t read_target_2;
  volatile uint32_t read_target_3;

  // PLIC code
  #define PLIC_BASE     0x0C000000
  #define PLIC_CHECK    PLIC_BASE + 0x201004
  //enable bits for sources 0-31
  #define PLIC_EN_BITS  PLIC_BASE + 0x2080
  // In RTL: PMU Connected to irq_sources 155 <=> 162
  // pmu_plic_id needs to be 156 <=> 163
  int pmu_plic_id = 156;
    // Initialazing the interrupt controller
  pulp_write32(PLIC_BASE+pmu_plic_id*4, 1);                                // set pmu interrupt priority to 1
  pulp_write32(PLIC_EN_BITS+(((int)(pmu_plic_id/32))*4), 1<<(pmu_plic_id%32)); // enable interrupt
  

  uint32_t mhartid;
  asm volatile (
    "csrr %0, 0xF14\n"
    : "=r" (mhartid)
  );

  uint32_t dspm_base_addr;
  uint32_t read_target;
  uint32_t error_count = 0;

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



    uint32_t event_info_val = OVERFLOW_EN; 
    // Counter 0:
    write_32b (EVENT_INFO_BASE_ADDR, event_info_val);
    write_32b (COUNTER_BASE_ADDR, 0x40000000);
    // Counter 1:
    // write_32b (EVENT_INFO_BASE_ADDR + COUNTER_BUNDLE_SIZE, event_info_val);
    // write_32b (COUNTER_BASE_ADDR + COUNTER_BUNDLE_SIZE, 0x40000000);
    // Setting overflow for all the counters
    //for (uint32_t i = 0; i<8; i++) {
    //  write_32b (EVENT_INFO_BASE_ADDR + (COUNTER_BUNDLE_SIZE*i), event_info_val);
    //  write_32b (COUNTER_BASE_ADDR + (COUNTER_BUNDLE_SIZE*i), 0x40000000);
    //  printf("PMU raising %d :)\r\n", i);
    //}

    // end_test(mhartid);
    uart_wait_tx_done();


    

  // *******************************************************************
  // Core 1-3
  // *******************************************************************
  } else if (mhartid <= NUM_NON_CUA) {
    uint64_t var;

    // 1 - 0x28, 2 - 0x2c, 3 - 0x30
    write_32b(DSPM_BASE_ADDR+0x24+mhartid*0x4, 1);

    while (1) {
      
    }
    
  } else {
    end_test(mhartid);
    uart_wait_tx_done();
    while (1);
  }
  printf("This is a line before wfi! :)\r\n");
    asm volatile ("wfi");
    // while(pulp_read32(PLIC_CHECK)!=pmu_plic_id)
    //      asm volatile ("wfi"); // the handler just returns here + 4
    // Start of """Interrupt Service Routine""" (this code should be into an IRQ Handler)
    printf("This is a line after wfi!: irq has been received and processed. :)\r\n");
    // Cleanup the IRQ Source:
    pulp_write32(0x10407000, 0x00000000);
    pulp_write32(PLIC_CHECK, pmu_plic_id);    // Completing irq (according to riscv specs)
    printf("Ariane: completion irq received\r\n");
    printf("Test Succeeded!!!\r\n");
    end_test(mhartid);
    uart_wait_tx_done();
  return 0;
}
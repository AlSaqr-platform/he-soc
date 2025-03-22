#include "pmu_defines.h"
#include "riscv_encoder_instr.c"

// *********************************************************************
// Macros and Defines
// *********************************************************************
#define TEST_0
#define TEST_1

// All Widths are in Bytes
#define INSTR_WIDTH 4
#define DATA_WIDTH 4

#define NUM_INSTR 100
#define NUM_DATA 100

// For the array traversal
#define NUM_ELEMENT 100

// Counter Bundle
typedef struct {
  uint32_t  counter;
  uint32_t  event_sel;
  uint32_t  event_info;
  uint32_t  init_budget;
} counter_b_t;

// PMU Bundle
typedef struct {
  uint64_t  timer;
  uint64_t  period;
} pmu_b_t;

// *********************************************************************
// Function Prototypes
// *********************************************************************
// Macro convert string to binary.
#define Bin(x) S_to_binary_(#x)
uint32_t S_to_binary_(const char *s);

// Functiona to create a number with N LSB bits set to 1.
uint32_t set_n_lsb_bits (uint32_t n);

// The AXI4-Lite interconnect is 32bit.
// Can only read-write to 32bits at a time.
#define read_32b(addr)         (*(volatile uint32_t *)(long)(addr))
#define write_32b(addr, val_)  (*(volatile uint32_t *)(long)(addr) = val_)

// A simple LCG (Linear Congruential Generator) algorithm to generate pseudo-random numbers for testing.
uint32_t my_rand(uint32_t seed);

// Read-Write functions to read from / write to `len` number of 32-bit registers.
// The address of the first register is `base_addr` and each consequent register is `+ step_size` away from the previous one.
void read_32b_regs(uint64_t base_addr, uint32_t len, uint32_t* rval, uint32_t step_size);
void write_32b_regs(uint64_t base_addr, uint32_t len, uint32_t val[], uint32_t step_size);

// Read-Write functions to write to `num_regs` number of 64-bit registers.
// The address of the first register is `base_addr` and each consequent register is `+ step_size` away from the previous one.
void read_64b_regs(uint64_t base_addr, uint32_t len, uint64_t* rval, uint32_t step_size);
void write_64b_regs(uint64_t base_addr, uint32_t len, uint64_t val[], uint32_t step_size);

// Function reads a struct of type `counter_b_t` from `base_addr` and returns it.
counter_b_t read_counter_b(uint64_t base_addr);
// Function writes a a struct of type `counter_b_t` to `base_addr`.
void write_counter_b(uint64_t base_addr, counter_b_t counter_b);

// Function to test read and writes to counter bundles.
// This test will make `num_rw` number of writes, from array `val[]` (of type `counter_b_t`), and then reads from the counter bundles; starting from address `base_addr`.
// For each mismatch it increments the error counter and then returns it.
// A return of 0 indicates that the test successfully passed.
uint32_t test_counter_bundle(uint64_t base_addr, uint32_t num_rw, uint32_t bundle_size, counter_b_t val[]);
// This function generates a random array of size `num_rw` (using `my_rand()`) and then calls `test_counterb`. 
uint32_t test_counter_bundle_rand(uint64_t base_addr, uint32_t num_rw, uint32_t bundle_size);

uint32_t array_traversal(uint32_t len);

// Function that generates event_sel register value based on specified parameters.
// Assuming the following register format:
//    [PortID_Val, PortID_Mask, SourceID_Val, SourceID_Mask, EventID_Val, EventID_Mask].
//    |<---- PortIDWidth*2 --->||<---- SourceIDWidth*2 ---->||<--- EventIDWidth*2 --->| 
uint32_t gen_event_sel_reg_value (
            uint32_t event_id_width,
            uint32_t source_id_width,
            uint32_t port_id_width,
            uint32_t event_id_mask,
            uint32_t event_id_val,
            uint32_t source_id_mask,
            uint32_t source_id_val,
            uint32_t port_id_mask,
            uint32_t port_id_val);

// Function to test read and writes to the SPM.
// This test will make `num_rw` number of writes, from array `val[]`,  and then reads to the DSPM, starting from addreses `base_addr`.
// For each mismatch it increments the error counter and then returns it.
// A return of 0 indicates that the test successfully passed.
uint32_t test_spm(uint64_t base_addr, uint32_t num_rw, uint32_t val[]);
// This function generates a random array of size `num_rw` (using `my_rand()`) and then calls `test_spm`. 
uint32_t test_spm_rand(uint64_t base_addr, uint32_t num_rw);

// BubbleSort
// The `test_pmu_core_bubble_sort` function writes the RISC-V assembly program for bubble sort in the ISPM, populate the DSPM with a randomized array of 
// size `len` at address `arr_base` and intialize the core.
// Set DEBUG = 2 for most information.
void bubble_sort (uint32_t *array, uint32_t len);
uint32_t test_pmu_core_bubble_sort (
              uint32_t program_start_addr, 
              uint32_t arr_base,
              uint32_t pmc_status_base_addr, 
              uint32_t len, 
              uint32_t DEBUG);

uint32_t pmu_core_send_interrupt (
            uint32_t program_start_addr, 
            uint32_t counter_addr,
            uint32_t target_addr,
            uint32_t pmc_status_base_addr, 
            uint32_t DEBUG);              

// PMU core writes to counter bundles.
// The `test_pmu_core_counter_b_writes` function writes multiples of 17 to all the registers in the all the counter bundles in the PMU.
// The base address of the first counter bundle is provided through `counter_b_base_addr`.
// counter[0]      = 17*1
// eventSelCfg[0]  = 17*2
// eventInfoCfg[0] = 17*3
// initBudgeReg[0] = 17*4
// counter[1]      = 17*5
// ...
// When all bundles are written to, the PMU core writes a 1 at `target_addr`.
// Until then the application core is stuck in a while loop reading this address.
// Once `target_addr` is updated to 1, the application core reads all the counter bundles 
// and verifies that the write operations indeed occurred.
uint32_t test_pmu_core_counter_b_writes (
            uint32_t program_start_addr, 
            uint32_t counter_b_base_addr,
            uint32_t target_addr,
            uint32_t pmc_status_base_addr, 
            uint32_t counter_b_size,
            uint32_t num_counter,
            uint32_t DEBUG);

// Runs the following test functions:
//      1. `test_spm_rand` for ISPM and DSPM
//      2. `test_pmu_core_bubble_sort`
//      3. `test_pmu_core_counter_b_writes`
uint32_t run_pmu_core_test_suite (
            uint32_t ispm_base_addr, 
            uint32_t counter_b_base_addr,
            uint32_t dspm_base_addr,
            uint32_t pmc_status_base_addr, 
            uint32_t counter_b_size,
            uint32_t num_counter,
            uint32_t arr_len,
            uint32_t DEBUG);
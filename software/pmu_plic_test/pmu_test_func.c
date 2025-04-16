#include "pmu_test_func.h"

uint32_t S_to_binary_(const char *s) {
  uint32_t i = 0;
  while (*s) {
          i <<= 1;
          i += *s++ - '0';
  }
  return i;
}

uint32_t my_rand(uint32_t seed) {
  uint32_t a = 1103515245;
  uint32_t c = 12345;
  uint32_t m = 2<<29;

  seed = (a * seed + c) % m;
  return seed;
}

uint32_t array_traversal(uint32_t len) {
  uint32_t comp_array[len];
  for(uint32_t i=0; i<len; i++) {
    if (i==0) {
      comp_array[i] = 1;  
    } else {
      comp_array[i] = comp_array[i-1] + i*i;
    }
  }

  return comp_array[len-1];
}

counter_b_t read_counter_b(uint64_t base_addr) {
  counter_b_t counter_b;
  counter_b.counter     = read_32b(base_addr);
  base_addr = base_addr + 0x4;
  counter_b.event_sel   = read_32b(base_addr);
  base_addr = base_addr + 0x4;
  counter_b.event_info  = read_32b(base_addr);
  base_addr = base_addr + 0x4;
  counter_b.init_budget = read_32b(base_addr);
  return counter_b;  
}

void write_counter_b(uint64_t base_addr, counter_b_t counter_b) {  
  write_32b(base_addr, counter_b.counter);
  base_addr = base_addr + 0x4;
  write_32b(base_addr, counter_b.event_sel);
  base_addr = base_addr + 0x4;
  write_32b(base_addr, counter_b.event_info);
  base_addr = base_addr + 0x4;
  write_32b(base_addr, counter_b.init_budget);
}

void read_32b_regs(uint64_t base_addr, uint32_t len, uint32_t* rval, uint32_t step_size) {
  for (int i=0; i<len; i++) {
    rval[i] = read_32b(base_addr);
    base_addr = base_addr + step_size;
  }
}

void write_32b_regs(uint64_t base_addr, uint32_t len, uint32_t val[], uint32_t step_size) {
  for (int i=0; i<len; i++) {
    write_32b(base_addr, val[i]);
    base_addr = base_addr + step_size;
  }
}

void read_64b_regs(uint64_t base_addr, uint32_t len, uint64_t* rval, uint32_t step_size) {
  uint32_t val_l, val_h;

  for (uint32_t i=0; i<len; i++) {
    val_l = read_32b(base_addr);
    val_h = read_32b(base_addr+4);
    rval[i] = (val_h << 32) | val_l; 
    base_addr += step_size;
  }
}

void write_64b_regs(uint64_t base_addr, uint32_t len, uint64_t val[], uint32_t step_size) {
  uint32_t val_l, val_h;

  for (uint32_t i=0; i<len; i++) {
    val_l = val[i] & 0xFFFFFFFF;
    val_h = val[i] >> 32;
    write_32b(base_addr, val_l);
    write_32b(base_addr+4, val_h);
    base_addr += step_size;
  }
}

uint32_t test_counter_bundle(uint64_t base_addr, uint32_t num_rw, uint32_t bundle_size, counter_b_t val[]) {
  uint64_t saved_base_addr;
  uint32_t error_count = 0;
  counter_b_t rval[num_rw];    // used to read from the SPM

  saved_base_addr = base_addr;
  for (uint32_t i=0; i<num_rw; i++) {
    write_counter_b(base_addr, val[i]);
    base_addr = base_addr + bundle_size;
  }
  
  base_addr = saved_base_addr;
  for (uint32_t i=0; i<num_rw; i++) {
    rval[i] = read_counter_b(base_addr);
    base_addr = base_addr + bundle_size;
  }

  for (uint32_t i=0; i<num_rw; i++) {
    if (val[i].counter != rval[i].counter) {
      error_count += 1;
    }
    if (val[i].event_sel != rval[i].event_sel) {
      error_count += 1;
    }
    if (val[i].event_info != rval[i].event_info) {
      error_count += 1;
    }
    if (val[i].init_budget != rval[i].init_budget) {
      error_count += 1;
    }
  }
  return error_count;
}

uint32_t test_counter_bundle_rand(uint64_t base_addr, uint32_t num_rw, uint32_t bundle_size) {
  uint32_t seed;
  counter_b_t rand_val[num_rw];    // used to write to the SPM, is populated with random numbers
  
  for(uint32_t i=0; i<num_rw; i++) {
    seed = (uint32_t)(base_addr * i + num_rw);
    rand_val[i].counter     = (uint32_t)(my_rand(seed+0));
    rand_val[i].event_sel   = (uint32_t)(my_rand(seed+1));
    rand_val[i].event_info  = (uint32_t)(my_rand(seed+2));
    rand_val[i].init_budget = (uint32_t)(my_rand(seed+3));
  }

  test_counter_bundle(base_addr, num_rw, bundle_size, rand_val);
}

uint32_t test_spm(uint64_t base_addr, uint32_t num_rw, uint32_t val[]) {
  uint32_t error_count = 0;
  uint32_t rval[num_rw];   // used to read from the SPM

  write_32b_regs(base_addr, num_rw, val, 0x4);
  read_32b_regs(base_addr, num_rw, rval, 0x4);

  for (uint32_t i=0; i<num_rw; i++) {
    if (val[i] != rval[i]) {
      error_count += 1;
    }
  }

  return error_count;
}

uint32_t test_spm_rand(uint64_t base_addr, uint32_t num_rw) {
  uint32_t seed;
  uint32_t rand_val[num_rw];    // used to write to the SPM, is populated with random numbers
  
  for(uint32_t i=0; i<num_rw; i++) {
    seed = (uint32_t)(base_addr * i + num_rw);
    rand_val[i] = (uint32_t)(my_rand(seed));
  }

  return test_spm(base_addr, num_rw, rand_val);
}

uint32_t test_pmu_core_bubble_sort (
              uint32_t program_start_addr, 
              uint32_t arr_base,
              uint32_t pmc_status_base_addr, 
              uint32_t len, 
              uint32_t DEBUG) {
  uint32_t program[] = {
    0x33,         // The first instruction to the core is discarded so it must be NOP.
    0x00000000,   // lui x1, (arr_base >> 12)
    0x00000000,   // addi x1, x1, (arr_base && 0xFFF)
    0x00000000,   // addi x2, x1, (ARR_SIZE-1)*4
    0x8333,
    0x2b3,
    0x32203,
    0x432183,
    0x41f863,
    0x332023,
    0x432223,
    0x100293,
    0x430313,
    0xfe2312e3,
    0x28663,
    0xffc10113,
    0xfc1118e3,
    0x33,
    0xfe000ee3
  };

  uint32_t error_count = 0;
  uint32_t prev_error_count = -1;
  uint32_t instruction;
  uint32_t cva6_val[len];
  uint32_t ibex_val[len];
  uint32_t program_size = sizeof(program) / sizeof(program[0]);
  
  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(1, arr_base >> 12, (DEBUG >= 2));
  program[1] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(1, 1, arr_base & 0xFFF, (DEBUG >= 2));
  program[2] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(2,1,(len-1)*4, (DEBUG >= 2));
  program[3] = instruction;

  if (DEBUG >= 1)
    printf("Halt PMU core before writing to ISPM!\n");
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(program_start_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Writing array of length %0d to PMU-DSPM!\n", len);
  error_count += test_spm_rand(arr_base, len);

  read_32b_regs(arr_base, len, cva6_val, 0x4);
  if (DEBUG >= 2) {
    printf("Print input array!\n");
    for (uint32_t i=0; i<len; i++) {
      printf("%x: %0d\n",&cva6_val[i], cva6_val[i]);
    }
  }

  if (DEBUG >= 1)
    printf("Start PMU core!\n");
  write_32b(pmc_status_base_addr, 0);

  // Sort array, this is golden output.
  bubble_sort(cva6_val, len);
  if (DEBUG >= 2) {
    printf("Print golden array!\n");
    for (uint32_t i=0; i<len; i++) {
      printf("%x: %0d\n",&cva6_val[i], cva6_val[i]);
    }
  }

  // Keep polling DSPM and comparing array outputs. 
  // Exit when either the error_count = 0 or when it stabilizes.
  while (prev_error_count != error_count) {
    prev_error_count = error_count;
    error_count = 0;
    read_32b_regs(arr_base, len, ibex_val, 0x4);
    for (uint32_t i=0; i<len; i++) {
      if (cva6_val[i] != ibex_val[i]) {
        error_count += 1;
      }
    }
  }

  if (DEBUG >= 2) {
      printf("Output array!\n");
      for (uint32_t i=0; i<len; i++) {
        printf("%x: %0d\n",&ibex_val[i], ibex_val[i]);
      }
    }
  
  return error_count;
}

void bubble_sort (uint32_t *array, uint32_t len) {
  // loop to access each array element
  for (uint32_t step = 0; step < len - 1; ++step) {
    // check if swapping occurs  
    uint32_t swapped = 0;
    // loop to compare array elements
    for (uint32_t i = 0; i < len - step - 1; ++i) {
      // compare two array elements
      // change > to < to sort in descending order
      if (array[i] > array[i + 1]) {
        // swapping occurs if elements
        // are not in the intended order
        uint32_t temp = array[i];
        array[i] = array[i + 1];
        array[i + 1] = temp;
        swapped = 1;
      }
    }
    // no swapping means the array is already sorted
    // so no need for further comparison
    if (swapped == 0) {
      break;
    }
  }
}

uint32_t pmu_core_send_interrupt (
            uint32_t program_start_addr, 
            uint32_t counter_addr,
            uint32_t target_addr,
            uint32_t pmc_status_base_addr, 
            uint32_t DEBUG) {

  uint32_t program[] = {
    0x33,         // The first instruction to the core is discarded so it must be NOP.
    0x104040b7,   // 1: lui x1, (counter_addr >> 12)
    0x1408093,    // 2: addi x1, x1, (counter_addr && 0xFFF)
    0x104063b7,   // 3: lui x7, (target_addr >> 12)
    0x38393,      // 4: addi x7, x7, (target_addr && 0xFFF)
    0x40000137,   // 5: lui x2,0x40000; Set overflow bit as 1
    0x20a023,     // 6: sw x2, 0(x1)
    0x6500413,    // 7: addi x8,x0,101
    0x83a023,     // 8: sw x8,0(x7)
    0x33,         // 9: add x0, x0, x0
    0xfe000ee3    // 10: beq x0, x0, -4
  };

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);
  uint64_t target_value = 0;

  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(1, counter_addr >> 12, (DEBUG >= 2));
  program[1] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(1, 1, counter_addr & 0xFFF, (DEBUG >= 2));
  program[2] = instruction;
  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(7, target_addr >> 12, (DEBUG >= 2));
  program[3] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(7, 7, target_addr & 0xFFF, (DEBUG >= 2));
  program[4] = instruction;

  if (DEBUG >= 1)
    printf("Halt PMU core before writing to ISPM!\n");
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(program_start_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Start PMU core!\n");
  write_32b(pmc_status_base_addr, 0);

  while (1) {
    uint read_target = read_32b(target_addr);
    if (read_target == 101)
      break;
  }

  return error_count;
}

uint32_t test_pmu_core_counter_b_writes (
            uint32_t program_start_addr, 
            uint32_t counter_b_base_addr,
            uint32_t target_addr,
            uint32_t pmc_status_base_addr, 
            uint32_t counter_b_size,
            uint32_t num_counter,
            uint32_t DEBUG) {
    
  uint32_t program[] = {
    0x33,         // The first instruction to the core is discarded so it must be NOP.
    0x104040b7,   // 1: lui x1, (counter_b_base_addr >> 12)
    0x1408093,    // 2: addi x1, x1, (counter_b_base_addr & 0xFFF)
    0x104063b7,   // 3: lui x7, (target_addr >> 12)
    0x38393,      // 4: addi x7, x7, (target_addr & 0xFFF)
    0x400113,     // 5: addi x2, x0, num_counter
    0x1b7,        // 6: lui x3, (COUNTER_BUNDLE_SIZE >> 12)
    0x1000193,    // 7: addi x3, x0, (COUNTER_BUNDLE_SIZE & 0xFFF)
    0x233,
    0x82b3,
    0x10f00313,
    0x62a023,
    0x10f30313,
    0x62a223,
    0x10f30313,
    0x62a423,
    0x10f30313,
    0x62a623,
    0x10f30313,
    0x120213,
    0x3282b3,
    0xfc221ce3,
    0x6500413,
    0x83a023,
    0x33,
    0xfe000ee3
  };

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);
  uint64_t target_value = 0;
  uint64_t base_addr    = counter_b_base_addr;
  counter_b_t rval[num_counter];

  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(1, counter_b_base_addr >> 12, (DEBUG >= 2));
  program[1] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(1, 1, counter_b_base_addr & 0xFFF, (DEBUG >= 2));
  program[2] = instruction;
  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(7, target_addr >> 12, (DEBUG >= 2));
  program[3] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(7, 7, target_addr & 0xFFF, (DEBUG >= 2));
  program[4] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(2,0,num_counter, (DEBUG >= 2));
  program[5] = instruction;
  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(3,COUNTER_BUNDLE_SIZE >> 12, (DEBUG >= 2));
  program[6] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(3,3,COUNTER_BUNDLE_SIZE & 0xFFF, (DEBUG >= 2));
  program[7] = instruction;

  if (DEBUG >= 1)
    printf("Halt PMU core before writing to ISPM!\n");
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(program_start_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Start PMU core!\n");
  write_32b(pmc_status_base_addr, 0);

  while (1) {
    uint read_target = read_32b(target_addr);
    if (read_target == 101)
      break;
  }

  
  for (uint32_t i=0; i<num_counter; i++) {
    rval[i] = read_counter_b(base_addr);
    base_addr = base_addr + COUNTER_BUNDLE_SIZE;
  }

  for (uint32_t i=0; i<num_counter; i++) {
    target_value = target_value + 271;
    if (rval[i].counter != target_value) {
      error_count += 1;
      printf("Counter_b.counter %0d: Reading %0d vs %0d!\n", i, target_value, rval[i].counter);
    }
    target_value = target_value + 271;
    if (rval[i].event_sel != target_value) {
      error_count += 1;
      printf("Counter_b.event_sel %0d: Reading %0d vs %0d!\n", i, target_value, rval[i].event_sel);
    }
    target_value = target_value + 271;
    if (rval[i].event_info != target_value) {
      error_count += 1;
      printf("Counter_b.event_info %0d: Reading %0d vs %0d!\n", i, target_value, rval[i].event_info);
    }
    target_value = target_value + 271;
    if (rval[i].init_budget != target_value) {
      error_count += 1;
      printf("Counter_b.init_budget %0d: Reading %0d vs %0d!\n", i, target_value, rval[i].init_budget);
    }
  }

  return error_count;
}

uint32_t pmu_halt_core (
              uint32_t program_start_addr,
              uint32_t pmc_status_base_addr, 
              uint32_t core_id,
              uint32_t DEBUG) {
  
  uint32_t program[] = {
    0x33,         // The first instruction to the core is discarded so it must be NOP.
    0x137,        // lui x2,0
    0x20010113,   // addi x2,x2,512
    0x213,        // Update: addi x4,x0,core_id
    0x412023,     // sw x4,0(x2)
    0x33,
    0xfe000ee3
  };

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(4, 0, core_id & 0xFFF, (DEBUG >= 2));
  program[3] = instruction;

  if (DEBUG >= 1) {
    printf("Running pmu_halt_core()!\n");
    printf("Halt PMU core before writing to ISPM!\n");
  }
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(program_start_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Start PMU core! %0d\n");
  write_32b(pmc_status_base_addr, 0);
  return error_count;
}

uint32_t pmu_resume_core (
              uint32_t program_start_addr,
              uint32_t pmc_status_base_addr, 
              uint32_t core_id,
              uint32_t DEBUG) {

  uint32_t program[] = {
    0x33,         // The first instruction to the core is discarded so it must be NOP.
    0x137,        // lui x2,0
    0x20010113,   // addi x2,x2,512
    0x213,        // Update: addi x4,x0,core_id
    0x412423,     // sw x4,8(x2)
    0x33,
    0xfe000ee3
  };

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(4, 0, core_id & 0xFFF, (DEBUG >= 2));
  program[3] = instruction;

  if (DEBUG >= 1) {
    printf("Running pmu_resume_core()!\n");
    printf("Halt PMU core before writing to ISPM!\n");
  }
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(program_start_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Start PMU core! %0d\n");
  write_32b(pmc_status_base_addr, 0);
  return error_count;  
}

// This test has a lot of problems mainly because the debug module and my hacks are not fully compatible.
// If the debug module is blocking/has blocked/is resuming a core then any debug request from the PMU is ignored.
uint32_t test_pmu_debug_func (
              uint32_t program_start_addr,
              uint32_t pmc_status_base_addr, 
              uint32_t num_core,
              uint32_t wait_before_resuming,
              uint32_t DEBUG) {

  uint32_t program[] = {
    0x33,         // The first instruction to the core is discarded so it must be NOP.
    0x400093,     // addi x1,x0,num_counter
    0x1400313,    // addi x6,x0,wait_before_resuming
    0x137,        
    0x20010113,
    0x213,
    0x293,
    0x412023,
    0x120213,
    0x128293,
    0xfe129ae3,
    0x3b3,
    0x33,
    0x138393,
    0xfe639ce3,
    0x213,
    0x293,
    0x412423,
    0x120213,
    0x128293,
    0xfe129ae3,
    0x33,
    0xfe000ee3
  };

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);

  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(1, 0, num_core & 0xFFF, (DEBUG >= 2));
  program[1] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(6, 0, wait_before_resuming & 0xFFF, (DEBUG >= 2));
  program[2] = instruction;

  if (DEBUG >= 1) {
    printf("Running test_pmu_debug_func()!\n");
    printf("Halt PMU core before writing to ISPM!\n");
  }
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(program_start_addr, program_size, program);
  
  // For simulation, wait until all cores are up and running.
  // To do: A better way of doing this.
  uint32_t res = array_traversal(num_core*150);

  if (DEBUG >= 1)
    printf("Start PMU core! %0d\n", res);
  write_32b(pmc_status_base_addr, 0);
  return error_count;
}

uint32_t run_pmu_core_test_suite (
            uint32_t ispm_base_addr, 
            uint32_t counter_b_base_addr,
            uint32_t dspm_base_addr,
            uint32_t pmc_status_base_addr, 
            uint32_t counter_b_size,
            uint32_t num_counter,
            uint32_t arr_len,
            uint32_t DEBUG) {
  uint32_t error;
  uint32_t error_count = 0;

  error = test_spm_rand(ispm_base_addr, arr_len);
  error_count += error;
  printf("Reads-writes to ISPM completed. Errors: %0d!\n", error);

  error = test_spm_rand(dspm_base_addr, arr_len);
  error_count += error;
  printf("Reads-writes to DSPM completed. Errors: %0d!\n", error);

  error = test_pmu_core_bubble_sort(
              ispm_base_addr,
              dspm_base_addr,
              pmc_status_base_addr,
              arr_len,            
              DEBUG);
  error_count += error;                  
  printf("BubbleSort test completed. Errors: %0d!\n", error);
                                    
  error = test_pmu_core_counter_b_writes(
            ispm_base_addr,
            counter_b_base_addr,
            dspm_base_addr,
            pmc_status_base_addr,
            counter_b_size,
            num_counter,            
            DEBUG);
  error_count += error;                  
  printf("PMU core reads-writes to PMU registers completed. Errors: %0d!\n", error);

  printf("pmu_core_test_suite completed. Errors: %0d!\n", error_count);
  return error_count;
}

uint32_t test_case_study_without_debug (
              uint32_t ispm_base_addr,
              uint32_t dspm_base_addr,
              uint32_t pmc_status_base_addr, 
              uint32_t counter_base_addr,
              uint32_t counter_bundle_size,
              uint32_t period_base_addr,
              uint32_t num_intf_core,
              uint32_t PRINT_TRACE,
              uint32_t DEBUG) {
  uint32_t program[] = {
      0x33,         // 0: NOP
      0x400f93,     // 1: addi x31, x0, num_intf_core
      0xf37,        // 2: lui x30, (dspm_base_addr >> 12)
      0xf0f13,      // 3: addi x30, x30, (dspm_base_addr & 0xFFF)
      0x28f0913,
      0xeb7,
      0x200e8e93,
      0x100093,
      0xf2e03,
      0x4f2d83,
      0x8f2b83,
      0xcf2c03,
      0x10f2c83,
      0x14f2d03,
      0x100093,
      0xa13,
      0x113,
      0x193,
      0x18207,
      0x118193,
      0x18287,
      0x520233,
      0x118193,
      0x18387,
      0x19007,
      0x118193,
      0x18407,
      0x19007,
      0x8383b3,
      0x18f2403,
      0x1cf2483,
      0x838433,
      0x747463,
      0x148493,
      0x8f2c23,
      0x9f2e23,
      0x24e0533,
      0x24e35b3,
      0x24d8833,
      0x24db8b3,
      0x95ea63,
      0x959463,
      0x856663,
      0x493,
      0x463,
      0x100493,
      0x110113,
      0x118193,
      0x18507,
      0x118193,
      0x18587,
      0x118193,
      0x18607,
      0x118193,
      0x18687,
      0x40b50533,
      0x40d60633,
      0x3750233,
      0x37532b3,
      0x3858333,
      0x385b3b3,
      0x7282b3,
      0x620233,
      0x627463,
      0x128293,
      0x458ee63,
      0x589463,
      0x4486a63,
      0x3960333,
      0x39633b3,
      0x7282b3,
      0x620233,
      0x627463,
      0x128293,
      0x258ec63,
      0x589463,
      0x2486863,
      0x3a68333,
      0x3a6b3b3,
      0x7282b3,
      0x620233,
      0x627463,
      0x128293,
      0x58ea63,
      0x589463,
      0x486663,
      0x293,
      0x463,
      0x100293,
      0x2099b3,
      0x13a7ab3,
      0x2adab3,
      0x12c313,
      0x6afb33,
      0x41b0863,
      0x1aca93,
      0x154fb33,
      0x5b7b33,
      0x1b0863,
      0xf3f116e3,
      0x21f2223,
      0xea0006e3,
      0x13a6a33,
      0x34f2023,
      0x10404237,
      0x22283,
      0x422303,
      0x1009213,
      0x220233,
      0x492023,
      0x592223,
      0x692423,
      0xc90913,
      0xfc0004e3,
      0xfff9c993,
      0x13a7a33,
      0x34f2023,
      0x10404237,
      0x22283,
      0x422303,
      0x1109213,
      0x220233,
      0x492023,
      0x592223,
      0x692423,
      0xc90913,
      0xf8000ae3};

  uint32_t dspm_val[] = {
    60,   // Average latency threshold
    20,   // Acceptable delay allowed per core
    60,   // Read-hit delay on CUA from the interfering cores
    80,   // Read-miss delay on CUA from the interfering cores.
    100,  // Write-hit delay on CUA from the interfering cores.  
    200,  // Write-miss delay on CUA from the interfering cores.
    0,    // Initial CUA latency value, upper 32-bits.
    0     // Initial CUA latency value, lower 32-bits.
  };

  printf("Test Parameters\r\n");
  printf("Average latency threshold: %0d\r\n", dspm_val[0]);
  printf("Acceptable delay allowed per request per core: %0d\r\n", dspm_val[1]);
  printf("Non-CUA parameters (rh,rm,wh,wm): %0d, %0d, %0d, %0d\r\n", dspm_val[2], dspm_val[3], dspm_val[4], dspm_val[5]);

  uint32_t N_TEST = 10;
  // True implies that the core is halted.
  // Fase implies it is resumed.                                                                                       2    4     8
  uint32_t test_cases[10][16] = {{876, 546, 75000, 50000, 776, 66, 45, 23, 670, 56, 200, 1, 80, 80, 200, 50},     // TRUE, TRUE, TRUE     0xe   1
                                 {6546, 7000, 380000, 420000, 776, 66, 45, 23, 670, 56, 200, 1, 35, 20, 200, 50}, // FALSE, FALSE, FALSE  0     2
                                 {240, 120, 20000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},                    // FALSE, FALSE, FALSE  0     3
                                 {654, 700, 500000, 420000, 776, 66, 45, 23, 670, 56, 200, 1, 80, 57, 200, 50},   // TRUE, TRUE, TRUE     0xe   4
                                 {678, 240, 60000, 22000, 435, 44, 322, 222, 0, 0, 0, 0, 100, 100, 100, 100},     // TRUE, FALSE, TRUE    0xa   5
                                 {678, 240, 60000, 22000, 0, 0, 0, 0, 435, 44, 322, 222, 100, 100, 100, 100},     // FALSE, TRUE, TRUE    0xc   6
                                 {678, 240, 60000, 22000, 435, 44, 322, 222, 100, 100, 100, 100, 0, 0, 0, 0},     // TRUE, TRUE, FALSE    0x6   7
                                 {876, 546, 75000, 50000, 776, 66, 45, 23, 0, 0, 0, 0, 0, 0, 0, 0},               // TRUE, FALSE, FALSE   0x2   8
                                 {876, 546, 75000, 50000, 0, 0, 0, 0, 670, 56, 200, 1, 0, 0, 0, 0},               // FALSE, TRUE, FALSE   0x4   9
                                 {876, 546, 75000, 50000, 0, 0, 0, 0, 0, 0, 0, 0, 135, 80, 200, 50}};              // FALSE, FALSE, TRUE   0x8   10

  uint32_t golden_results[10] = {0xe, 0, 0, 0xe, 0xa, 0xc, 0x6, 0x2, 0x4, 0x8};

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);

  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(31, 0, num_intf_core & 0xFFF, (DEBUG >= 2));
  program[1] = instruction;
  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(30, dspm_base_addr >> 12, (DEBUG >= 2));
  program[2] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(30, 30, dspm_base_addr & 0xFFF, (DEBUG >= 2));
  program[3] = instruction;

  if (DEBUG >= 1)
    printf("Halt PMU core before writing to ISPM!\n");
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(ispm_base_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Writing program to PMU-DSPM!\n");
  error_count += test_spm(dspm_base_addr, 6, dspm_val);

  if (DEBUG >= 1)
    printf("Set up PMU Period to activate PMU Timer.\n");
  write_32b(period_base_addr, 0xFFFFFFFF);
  write_32b(period_base_addr + 0x4, 0xFFFFFFFF);

  for (uint32_t i=0; i<N_TEST; i++) {
    if (DEBUG >= 1)
      printf("Writing case %d counter values!\n", i);
    write_32b_regs(counter_base_addr, 16, test_cases[i], counter_bundle_size);
    
    if (DEBUG >= 1)
      printf("Start PMU core!\n");
    write_32b(pmc_status_base_addr, 0);

    while (1) {
      uint read_target = read_32b(dspm_base_addr + 0x24);
      if (read_target == 1)
        break;
    }

    uint32_t result = read_32b(dspm_base_addr + 0x20);
    printf("Result %d: %d, it should be %d.\n", i+1, result, golden_results[i]);

    if (golden_results[i] != result) {
      error_count += 1;
    }

    if (PRINT_TRACE) {
      for (uint32_t i=0; i<1000; i++) {
        uint32_t code       = read_32b(DSPM_BASE_ADDR + 0x28 + i*0xc);
        uint32_t time_lower = read_32b(DSPM_BASE_ADDR + 0x2c + i*0xc);
        uint32_t time_upper = read_32b(DSPM_BASE_ADDR + 0x30 + i*0xc);

        write_32b(DSPM_BASE_ADDR + 0x28 + i*0xc, 0);
        write_32b(DSPM_BASE_ADDR + 0x2c + i*0xc, 0);
        write_32b(DSPM_BASE_ADDR + 0x30 + i*0xc, 0);

        printf("Trace %0d: %x: %x_%x\r\n", i, code, time_upper, time_lower);

        if (code == 0) {
          break;
        }
      }
    }

    if (DEBUG >= 1)
      printf("Reset PMU core before running next test!\n");
    write_32b(pmc_status_base_addr, 1);
    write_32b(dspm_base_addr + 0x18, 0);
    write_32b(dspm_base_addr + 0x1c, 0);
    write_32b(dspm_base_addr + 0x20, 0);
    write_32b(dspm_base_addr + 0x24, 0);
  }

  return error_count;
}

uint32_t test_case_study_with_debug (
              uint32_t ispm_base_addr,
              uint32_t dspm_base_addr,
              uint32_t pmc_status_base_addr, 
              uint32_t counter_base_addr,
              uint32_t counter_bundle_size,
              uint32_t period_base_addr,
              uint32_t num_intf_core,
              uint32_t DEBUG) {
  uint32_t program[] = {
    0x33,         // 0: NOP
    0x400f93,     // 1: addi x31, x0, num_intf_core
    0xf37,        // 2: lui x30, (dspm_base_addr >> 12)
    0xf0f13,      // 3: addi x30, x30, (dspm_base_addr & 0xFFF)
    0x28f0913,
    0xeb7,
    0x200e8e93,
    0x100093,
    0xf2e03,
    0x4f2d83,
    0x8f2b83,
    0xcf2c03,
    0x10f2c83,
    0x14f2d03,
    0x100093,
    0xa13,
    0x113,
    0x193,
    0x18207,
    0x118193,
    0x18287,
    0x520233,
    0x118193,
    0x18387,
    0x19007,
    0x118193,
    0x18407,
    0x19007,
    0x8383b3,
    0x18f2403,
    0x1cf2483,
    0x838433,
    0x747463,
    0x148493,
    0x8f2c23,
    0x9f2e23,
    0x24e0533,
    0x24e35b3,
    0x24d8833,
    0x24db8b3,
    0x95ea63,
    0x959463,
    0x856663,
    0x493,
    0x463,
    0x100493,
    0x110113,
    0x118193,
    0x18507,
    0x118193,
    0x18587,
    0x118193,
    0x18607,
    0x118193,
    0x18687,
    0x40b50533,
    0x40d60633,
    0x3750233,
    0x37532b3,
    0x3858333,
    0x385b3b3,
    0x7282b3,
    0x620233,
    0x627463,
    0x128293,
    0x458ee63,
    0x589463,
    0x4486a63,
    0x3960333,
    0x39633b3,
    0x7282b3,
    0x620233,
    0x627463,
    0x128293,
    0x258ec63,
    0x589463,
    0x2486863,
    0x3a68333,
    0x3a6b3b3,
    0x7282b3,
    0x620233,
    0x627463,
    0x128293,
    0x58ea63,
    0x589463,
    0x486663,
    0x293,
    0x463,
    0x100293,
    0x2099b3,
    0x13a7ab3,
    0x2adab3,
    0x12c313,
    0x6afb33,
    0x41b0863,
    0x1aca93,
    0x154fb33,
    0x5b7b33,
    0x1b0863,
    0xf3f116e3,
    0x21f2223,
    0xea0006e3,
    0x13a6a33,
    0x2ea023,
    0x10404237,
    0x22283,
    0x422303,
    0x1009213,
    0x220233,
    0x492023,
    0x592223,
    0x692423,
    0xc90913,
    0xfc0004e3,
    0xfff9c993,
    0x13a7a33,
    0x2ea423,
    0x10404237,
    0x22283,
    0x422303,
    0x1109213,
    0x220233,
    0x492023,
    0x592223,
    0x692423,
    0xc90913,
    0xf8000ae3};

  uint32_t dspm_val[] = {
    60,   // Average latency threshold
    20,   // Acceptable delay allowed per core
    60,   // Read-hit delay on CUA from the interfering cores
    80,   // Read-miss delay on CUA from the interfering cores.
    100,  // Write-hit delay on CUA from the interfering cores.  
    200,  // Write-miss delay on CUA from the interfering cores.
    0,    // Initial CUA latency value, upper 32-bits.
    0     // Initial CUA latency value, lower 32-bits.
  };

  uint32_t N_TEST = 10;
  // True implies that the core is halted.
  // Fase implies it is resumed.                                                                                       2    4     8
  uint32_t test_cases[10][16] = {{876, 546, 75000, 50000, 776, 66, 45, 23, 670, 56, 200, 1, 80, 80, 200, 50},     // TRUE, TRUE, TRUE     0xe   1
                                 {6546, 7000, 380000, 420000, 776, 66, 45, 23, 670, 56, 200, 1, 35, 20, 200, 50}, // FALSE, FALSE, FALSE  0     2
                                 {240, 120, 20000, 10000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},                    // FALSE, FALSE, FALSE  0     3
                                 {654, 700, 500000, 420000, 776, 66, 45, 23, 670, 56, 200, 1, 80, 57, 200, 50},   // TRUE, TRUE, TRUE     0xe   4
                                 {678, 240, 60000, 22000, 435, 44, 322, 222, 0, 0, 0, 0, 100, 100, 100, 100},     // TRUE, FALSE, TRUE    0xa   5
                                 {678, 240, 60000, 22000, 0, 0, 0, 0, 435, 44, 322, 222, 100, 100, 100, 100},     // FALSE, TRUE, TRUE    0xc   6
                                 {678, 240, 60000, 22000, 435, 44, 322, 222, 100, 100, 100, 100, 0, 0, 0, 0},     // TRUE, TRUE, FALSE    0x6   7
                                 {876, 546, 75000, 50000, 776, 66, 45, 23, 0, 0, 0, 0, 0, 0, 0, 0},               // TRUE, FALSE, FALSE   0x2   8
                                 {876, 546, 75000, 50000, 0, 0, 0, 0, 670, 56, 200, 1, 0, 0, 0, 0},               // FALSE, TRUE, FALSE   0x4   9
                                 {876, 546, 75000, 50000, 0, 0, 0, 0, 0, 0, 0, 0, 135, 80, 200, 50}};              // FALSE, FALSE, TRUE   0x8   10

  uint32_t golden_results[10] = {0xe, 0, 0, 0xe, 0xa, 0xc, 0x6, 0x2, 0x4, 0x8};

  uint32_t error_count = 0;
  uint32_t instruction;
  uint32_t program_size = sizeof(program) / sizeof(program[0]);

  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(31, 0, num_intf_core & 0xFFF, (DEBUG >= 2));
  program[1] = instruction;
  // encodeLUI (uint32_t rd, uint32_t imm)
  instruction = encodeLUI(30, dspm_base_addr >> 12, (DEBUG >= 2));
  program[2] = instruction;
  // encodeADDI (uint32_t rd, uint32_t rs1, uint32_t imm)
  instruction = encodeADDI(30, 30, dspm_base_addr & 0xFFF, (DEBUG >= 2));
  program[3] = instruction;

  if (DEBUG >= 1)
    printf("Halt PMU core before writing to ISPM!\n");
  write_32b(pmc_status_base_addr, 1);

  if (DEBUG >= 1)
    printf("Writing program to PMU-ISPM!\n");
  error_count += test_spm(ispm_base_addr, program_size, program);

  if (DEBUG >= 1)
    printf("Writing program to PMU-DSPM!\n");
  error_count += test_spm(dspm_base_addr, 6, dspm_val);

  if (DEBUG >= 1)
    printf("Set up PMU Period to activate PMU Timer.\n");
  write_32b(period_base_addr, 0xFFFFFFFF);
  write_32b(period_base_addr + 0x4, 0xFFFFFFFF);

  for (uint32_t i=0; i<N_TEST; i++) {
    if (DEBUG >= 1)
      printf("Writing case %d counter values!\n", i);
    write_32b_regs(counter_base_addr, 16, test_cases[i], counter_bundle_size);
    
    if (DEBUG >= 1)
      printf("Start PMU core!\n");
    write_32b(pmc_status_base_addr, 0);

    while (1) {
      uint read_target = read_32b(dspm_base_addr + 0x24);
      if (read_target == 1)
        break;
    }

    uint32_t result = read_32b(dspm_base_addr + 0x20);
    printf("Result %d: %d, it should be %d.\n", i+1, result, golden_results[i]);

    if (golden_results[i] != result) {
      error_count += 1;
    }

    if (DEBUG >= 1)
      printf("Reset PMU core before running next test!\n");
    write_32b(pmc_status_base_addr, 1);
    write_32b(dspm_base_addr + 0x18, 0);
    write_32b(dspm_base_addr + 0x1c, 0);
    write_32b(dspm_base_addr + 0x20, 0);
    write_32b(dspm_base_addr + 0x24, 0);
  }

  return error_count;
}
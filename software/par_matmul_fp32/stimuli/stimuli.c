#include <stdio.h>
#include <stdlib.h>
#include "pulp.h"
#include "config.h"
#include <stdio.h>
#include <stdint.h>
#include <limits.h> /* for CHAR_BIT */
#include <math.h>
#include "data.h"
// #define FPGA_EMULATION

#define GPIO2_PAD_A2_ADDR 0x1A10500C

#ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 40000000;
#else
  int baud_rate = 115200;
  int test_freq = 200000000;
#endif

#define STACK_SIZE 2048
DATA_LOCATION MA_TYPE matA[M*N] __attribute__ ((aligned (4)));
DATA_LOCATION MB_TYPE matB[N*P] __attribute__ ((aligned (4)));
DATA_LOCATION OUT_TYPE matC[M*P] __attribute__ ((aligned (4)));

void main_fn(int*);

int retval = -1;

int main () {
  int cycle_start=0;
  int cycle_end=0;

  synch_barrier();

  //////////
  // TEST //
  //////////

  //Executed by everyone
  main_fn(&retval);

  synch_barrier();

  if(core_id() == 0){
    // Write msg to mailbox
    pulp_write32(0x10403000, retval);
  }

  while (1) {
    __asm__ volatile("wfi;");
  }

  return 0;
}

void __attribute__ ((noinline)) matrix_init(MA_TYPE * __restrict__ A, MB_TYPE * __restrict__ B, OUT_TYPE * __restrict__ C) {

  /*for (int i = 0; i < M; i++)
    for (int j = 0; j < N; j++){
      A[i*N+j] = A_mat[i*N+j];
    }

  for (int i = 0; i < N; i++)
    for (int j = 0; j < P; j++){
      B[i*P+j] = B_mat[i*P+j];
    }*/

  for (int i = 0; i < M; i++)
    for (int j = 0; j < P; j++)
      C[i*P+j] = 0;
}

int __attribute ((noinline)) check_result(OUT_TYPE * __restrict__ result) {
    float diff;
    int err = 0;

    for (int i = 0; i < (M*P); i++) {
      diff = fabs(result[i] - ref[i]);
      if(diff > THR) {
        err++;
      #ifdef VERBOSE

        printf("Error at index %d:\t refrence %f\t output %f\t error %.4f\n", i, ref[i], result[i], diff);
      #endif

      }

      #ifdef PRINT_RESULTS

        printf("index %d:\t refrence %f\t output %f\t error %f\n", i, ref[i], result[i], diff);
      #endif
    }

    return err;
}

void main_fn(int *retval){

  uint32_t gpio_val= 0x00000004;
  int cycle_start=0;
  int cycle_end=0;

  //power loop
  //while(1){
    if (get_core_id() == 0)
      matrix_init(matA, matB, matC);

    #ifndef FABRIC
    synch_barrier();
    #endif

    // Enable perf counter
    if (get_core_id() == 0){
      pulp_write32(0x10200020,0x00000000);
        // Enable perf counter
        /*perf_stop();
        perf_reset();
        cycle_start=cpu_perf_get(CSR_PCER_CYCLES);
        perf_start();*/
        pulp_write32(0x10200020,0x00000001);
    }

    matMul(A_mat, B_mat, matC, M, N, P);

    if (get_core_id() == 0){
      // perf counter off
      /*perf_stop();
      cycle_end= cpu_perf_get(CSR_PCER_CYCLES) - cycle_start;
      pulp_write32(0x1C000300, cycle_end);*/
      //(0x10200020,0x00000000);
      if (check_result(matC)==0){
        gpio_val ^= 0x00000004;
        pulp_write32(GPIO2_PAD_A2_ADDR,gpio_val);
      }else{
        pulp_write32(GPIO2_PAD_A2_ADDR,0x00000000);
        while(1){}
      }
    }
  //} // while power

  #ifdef CHECK
  if (get_core_id() == 0)
    *retval = check_result(matC);
  #endif
}

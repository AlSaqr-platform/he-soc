#include <stdio.h>
#include <stdlib.h>
#include "pulp.h"
#include "parMatrixMul.h"
// #define FPGA_EMULATION

// static inline unsigned int core_id() {
//   int hart_id;
//   asm("csrr %0, 0xF14" : "=r" (hart_id) : );
//   // in PULP the hart id is {22'b0, cluster_id, core_id}
//   return hart_id & 0x01f;
// }

unsigned int i;
#ifdef FPGA_EMULATION
  int baud_rate = 115200;
  int test_freq = 50000000;
#else
  int baud_rate = 115200;
  int test_freq = 200000000;
#endif

#define N_ITERS 1

#define CHECKSUM 

#ifdef CHECKSUM
#define CHKSM 88408
#endif

__attribute__ ((section(".heapsram"))) int A[SIZE][SIZE];
__attribute__ ((section(".heapsram"))) int B[SIZE][SIZE];
__attribute__ ((section(".heapsram"))) int C[SIZE][SIZE];

void initialize_mat();
void matrix_multiplication(int *retval);

int retval = -1;

int main () {

  synch_barrier();
  
  //////////
  // TEST //
  //////////

  matrix_multiplication(&retval);

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

void initialize_mat() {
  int i,j;
  
  for (i=0;i<SIZE;i++) {
    for (j=0;j<SIZE;j++) {
      A[i][j] = A_init[i][j];
      B[i][j] = B_init[i][j];
    }
  }
  
}

void matrix_multiplication(int *retval) {
  int coreid = core_id();
  int numcores = 8;
  int *CHKSUM_RESULT;
  short int i, iter, j, k;
  int lb, ub, chunk;

  if (coreid == 0){
    // initialize matrix A and B
    initialize_mat();
  }
  //number of rows each core has to multiply
  chunk = SIZE / numcores;
  //lower bound
  lb = coreid * chunk;
  //upper bound
  ub = lb + chunk;  
  
  synch_barrier();
  
  /********************* Benchmark Execution *********************/
  if (coreid<numcores) {

    for (iter = 0; iter < N_ITERS; iter++) {
      for (i = lb; i < ub; i++) {
        for (k = 0; k < SIZE; k++) {
          C[i][k] = 0;
          for (j = 0; j < SIZE; j++)
            C[i][k] += A[i][j] * B[j][k];
        }
      }
    } 
  }
  synch_barrier();
  
  /********************* Benchmark Execution *********************/
  if(coreid == 0) {
    int chk = 0;
    for (k = 0; k < SIZE; k++)
      for (j = 0; j < SIZE; j++)
        chk += C[k][j];
    *retval = chk != CHKSM;
  }
}


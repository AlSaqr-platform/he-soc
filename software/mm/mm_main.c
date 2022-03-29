/*
 * Copyright (C) 2018 ETH Zurich and University of Bologna
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* 
 * Mantainer: Luca Valente (luca.valente2@unibo.it)
 */

#include "common.h"
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include "mm.c"
#include "utils.h"
#include "encoding.h"

#pragma GCC optimize ("unroll-loops")

int  main(int argc, char const *argv[]) {
  const int R = 8;
  int m, n, p;
  uint64_t s = 0xdeadbeefU;

  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  int cid=0;
  m = CBM;
  n = CBN;
  p = CBK;

  t a[m*p];
  t b[p*n];
  t c[m*n];

  for (size_t i = 0; i < m; i++)
    for (size_t j = 0; j < p; j++)
      a[i*p+j] = (t)(s = lfsr(s));
  for (size_t i = 0; i < p; i++)
    for (size_t j = 0; j < n; j++)
      b[i*n+j] = (t)(s = lfsr(s));
  memset(c, 0, m*n*sizeof(c[0]));

  size_t instret, cycles;
  for (int i = 0; i < R; i++)
  {
    instret = -read_csr(minstret);
    cycles = -read_csr(mcycle);
    mm(m, n, p, a, p, b, n, c, n);
    instret += read_csr(minstret);
    cycles += read_csr(mcycle);
  }

  asm volatile("fence");

  #ifdef VERBOSE
  printf("C%d: reg block %dx%dx%d, cache block %dx%dx%d\n",
         cid, RBM, RBN, RBK, CBM, CBN, CBK);
  uart_wait_tx_done();
  printf("C%d: %d instructions\n", cid, (int)(instret));
  uart_wait_tx_done();
  printf("C%d: %d cycles\n", cid, (int)(cycles));
  uart_wait_tx_done();
  printf("C%d: %d flops\n", cid, 2*m*n*p);
  uart_wait_tx_done();
  printf("C%d: %d Mflops @ %d MHz\n", cid, (test_freq/1000000)*2*m*n*p/(cycles), test_freq/1000000);
  uart_wait_tx_done();
  #endif

#if 1
  for (size_t i = 0; i < m; i++)
  {
    for (size_t j = 0; j < n; j++)
    {
      t s = 0;
      for (size_t k = 0; k < p; k++)
        s += a[i*p+k] * b[k*n+j];
      s *= R;
      if (fabs(c[i*n+j]-s) > fabs(1e-6*s))
      {
        printf("C%d: c[%lu][%lu] %f != %f\n", cid, i, j, c[i*n+j], s);
        return 1;
      }
    }
  }
#endif

  barrier();
  return 0;
}

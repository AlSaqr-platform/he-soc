/*
 * Copyright (C) 2022-2023 ETH Zurich and University of Bologna
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
 * SPDX-License-Identifier: Apache-2.0
 *
 * Author: Yvan Tortorella  <yvan.tortorella@unibo.it>
 *
 * RedMulE Hardware Abstraction Layer (HAL)
 */

#ifndef __HAL_REDMULE_H__
#define __HAL_REDMULE_H__

#include <pulp.h>
#include "inc/x_input.h"
#include "inc/w_input.h"
#include "inc/y_input.h"
#include "inc/z_output.h"
#include "inc/golden.h"
#include "inc/tensor_dim.h"

/*
 *
 * For control, generic configuration register layout,
 * and job-dependent register map, look at redmule_archi.h
 *
 */

// For all the following functions we use __builtin_pulp_OffsetedWrite and __builtin_pulp_OffsetedRead
// instead of classic load/store because otherwise the compiler is not able to correctly factorize
// the HWPE base in case several accesses are done, ending up with twice more code

#define HWPE_WRITE(value, offset) *(int *)(ARCHI_CLUST_HWPE_BASE + offset) = value
#define HWPE_READ(offset) *(int *)(ARCHI_CLUST_HWPE_BASE + offset)

static inline void redmule_x_add_set (unsigned int value) {
  HWPE_WRITE(value, REDMULE_REG_OFFS + REDMULE_REG_X_PTR);
}

static inline void redmule_w_add_set (unsigned int value) {
  HWPE_WRITE(value, REDMULE_REG_OFFS + REDMULE_REG_W_PTR);
}

static inline void redmule_y_add_set (unsigned int value) {
  HWPE_WRITE(value, REDMULE_REG_OFFS + REDMULE_REG_Y_PTR);
}

static inline void redmule_z_add_set (unsigned int value) {
  HWPE_WRITE(value, REDMULE_REG_OFFS + REDMULE_REG_Z_PTR);
}

// static inline void redmule_mcfg_set (uint32_t mcfg0, uint32_t mcfg1) {
//   HWPE_WRITE(mcfg0, REDMULE_REG_OFFS + REDMULE_MCFG0_PTR);
//   HWPE_WRITE(mcfg1, REDMULE_REG_OFFS + REDMULE_MCFG1_PTR);
// }
//
// static inline void redmule_arith_set (uint32_t arith) {
//   HWPE_WRITE(arith, REDMULE_REG_OFFS + REDMULE_ARITH_PTR);
// }

static inline void hwpe_trigger_job() {
  HWPE_WRITE(0, REDMULE_TRIGGER);
}

static inline int hwpe_acquire_job() {
  return HWPE_READ(REDMULE_ACQUIRE);
}

static inline unsigned int hwpe_get_status() {
  return HWPE_READ(REDMULE_STATUS);
}

static inline void hwpe_soft_clear() {
  HWPE_WRITE(1, REDMULE_SOFT_CLEAR);
}

static inline void hwpe_cg_enable() {
  *(volatile int*) (ARCHI_CLUST_CTRL_BASE + CLUST_CTRL_HWPE_EN) |= CLUST_CTRL_HWPE_EN_MASK;
}

static inline void hwpe_cg_disable() {
  *(volatile int*) (ARCHI_CLUST_CTRL_BASE + CLUST_CTRL_HWPE_EN) &= ~CLUST_CTRL_HWPE_EN_MASK;
}

static inline void redmule_evt_wait() {
  do {
    eu_evt_maskWaitAndClr (1 << ARCHI_CL_HWPE_EVT0);
  } while((*(int volatile *)(ARCHI_CLUST_HWPE_BASE + REDMULE_STATUS)) != 0);
}

/* DMA APIs */
static inline int mchan_alloc(){
  return *(volatile int*) DMA_COMMAND_QUEUE;
}

static inline void mchan_transfer(unsigned int len,
                                  unsigned int ext_addr,
                                  unsigned int tcdm_addr) {

  *(volatile int*) DMA_COMMAND_QUEUE = len |
                                       (DMA_RX << PLP_DMA_TYPE_BIT)  |
                                       (DMA_INC << PLP_DMA_INCR_BIT) |
                                       (0 << PLP_DMA_2D_BIT)         |
                                       (1 << PLP_DMA_ELE_BIT)        |
                                       (1 << PLP_DMA_ILE_BIT)        |
                                       (0 << PLP_DMA_BLE_BIT)        |
                                       (0 << PLP_DMA_2D_TCDM_BIT);
  *(volatile int*) DMA_COMMAND_QUEUE = tcdm_addr;
  *(volatile int*) DMA_COMMAND_QUEUE = ext_addr;
}

static inline void mchan_barrier(int id) {
  while(((*(volatile int*)(DMA_STATUS_REGISTER)) >> id ) & 0x1 ) {
    eu_evt_maskWaitAndClr(1 << FC_DMA_EVENT);
 }
}

static inline void mchan_free(int id) {
  *(volatile int*) DMA_STATUS_REGISTER = 0x1 << id;
}

// void redmule_cfg (unsigned int x,  unsigned int w,  unsigned int z,
//                   uint16_t m_size, uint16_t n_size, uint16_t k_size,
//                   uint8_t gemm_op, uint8_t gemm_fmt){
//
//   uint32_t mcfg_reg0 = 0;
//   uint32_t mcfg_reg1 = 0;
//   uint32_t arith_reg = 0;
//
//   mcfg_reg0 = (k_size << 16) |
//               (m_size <<  0);
//   mcfg_reg1 = n_size << 0;
//
//   arith_reg = (gemm_op << 10) |
//               (gemm_fmt << 7);
//
//   redmule_x_add_set ((unsigned int) x);
//   redmule_w_add_set ((unsigned int) w);
//   redmule_z_add_set ((unsigned int) z);
//   redmule_mcfg_set  ((unsigned int) mcfg_reg0,
//                      (unsigned int) mcfg_reg1);
//   redmule_arith_set ((unsigned int) arith_reg);
//
// }

void redmule_cfg (uint16_t m_size, uint16_t n_size, uint16_t k_size, uint8_t gemm_ops){
   uint32_t x_iters        = 0;
   uint32_t w_iters        = 0;
   uint32_t leftovers      = 0;
   uint32_t left_params    = 0;
   uint32_t x_d1_stride    = 0;
   uint32_t x_rows_offs    = 0;
   uint32_t w_tot_len      = 0;
   uint32_t w_d1_len       = 0;
   uint32_t w_d0_stride    = 0;
   uint32_t yz_tot_len     = 0;
   uint32_t yz_d0_stride   = 0;
   uint32_t yz_d2_stride   = 0;
   uint32_t tot_x_read     = 0;
   uint32_t x_buffer_slots = 0;
   uint32_t op_selection   = 0;
   uint16_t tot_stores     = 0;
   uint16_t w_rows         = n_size;
   uint16_t depth          = DATA_WIDTH/(ARRAY_HEIGHT*FPFORMAT);
   uint8_t  tile           = ARRAY_HEIGHT*(PIPE_REGS + 1);
   _Bool    x_rows_sub     = 0;
   _Bool    x_cols_sub     = 0;
   _Bool    w_cols_sub     = 0;
   uint16_t x_rows_iter,
            x_rows_iter_tmp,
            w_rows_iter,
            w_rows_iter_tmp;
   uint16_t x_cols_iter,
            x_cols_iter_tmp,
            w_cols_iter,
            w_cols_iter_tmp;
   uint8_t  x_rows_lftovr,
            x_cols_lftovr,
            w_rows_lftovr,
            w_cols_lftovr,
            slots;

   // Calculating the number of iterations alng the two dimensions of the X matrix
   x_rows_iter_tmp = m_size/ARRAY_WIDTH;
   x_cols_iter_tmp = n_size/tile;

   // Calculating the number of iterations alng the two dimensions of the W matrix
   w_rows_iter_tmp = w_rows;
   w_cols_iter_tmp = k_size/tile;

   // Calculating the residuals along the input dimensions
   x_rows_lftovr = m_size - (x_rows_iter_tmp*ARRAY_WIDTH);
   x_cols_lftovr = n_size - (x_cols_iter_tmp*tile);

   // Calculating the residuals along the weight dimensions
   w_rows_lftovr = n_size - (ARRAY_HEIGHT*(w_rows/ARRAY_HEIGHT));
   w_cols_lftovr = k_size - (w_cols_iter_tmp*tile);

   if (w_cols_lftovr != 0)
     w_cols_iter = w_cols_iter_tmp + 1;
   else
     w_cols_iter = w_cols_iter_tmp;

  if (w_rows_lftovr != 0)
    w_rows_iter = w_rows_iter_tmp + ARRAY_HEIGHT - w_rows_lftovr;
  else
    w_rows_iter = w_rows_iter_tmp;

   if (x_cols_lftovr != 0)
     x_cols_iter = x_cols_iter_tmp + 1;
   else
     x_cols_iter = x_cols_iter_tmp;

   if (x_rows_lftovr != 0)
     x_rows_iter = x_rows_iter_tmp + 1;
   else
     x_rows_iter = x_rows_iter_tmp;

   if (x_cols_lftovr%depth != 0)
     x_buffer_slots = x_cols_lftovr/depth + 1;
   else
     x_buffer_slots = x_cols_lftovr/depth;

   // Calculating the number of total stores
   tot_stores = x_rows_iter*w_cols_iter;

   // Determining if input matrixes are sub-matrixes
   if (m_size < ARRAY_WIDTH)
     x_rows_sub = 1;
   if (n_size < ARRAY_HEIGHT)
     x_cols_sub = 1;
   if (k_size < tile)
    w_cols_sub = 1;

   // Operation selection
   switch (gemm_ops) {
     case MATMUL:
       op_selection |= (RNE << 29 | RNE << 26 | OP_FMADD << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 0;
     break;

     case GEMM:
       op_selection |= (RNE << 29 | RNE << 26 | OP_FMADD << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;

     case ADDMAX:
       op_selection |= (RNE << 29 | RTZ << 26 | OP_ADD << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;

     case ADDMIN:
       op_selection |= (RNE << 29 | RNE << 26 | OP_ADD << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;

     case MULMAX:
       op_selection |= (RNE << 29 | RTZ << 26 | OP_MUL << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;

     case MULMIN:
       op_selection |= (RNE << 29 | RNE << 26 | OP_MUL << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;

     case MAXMIN:
       op_selection |= (RTZ << 29 | RNE << 26 | OP_MINMAX << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;

     case MINMAX:
       op_selection |= (RNE << 29 | RTZ << 26 | OP_MINMAX << 22 | OP_MINMAX << 18 | SRC_FMT << 15 | DST_FMT << 12) | 1;
     break;
   }

   // Storing iterations and residuals in registers
   x_iters      |= x_rows_iter   << 16 | x_cols_iter   << 0;
   w_iters      |= w_rows_iter   << 16 | w_cols_iter   << 0;
   leftovers    |= x_rows_lftovr << 24 | x_cols_lftovr << 16 | w_rows_lftovr << 8  | w_cols_lftovr << 0;
   left_params  |= tot_stores    << 16 | x_rows_sub    << 15 | x_cols_sub    << 14 | w_cols_sub   << 13;
   x_d1_stride   = ((4*FPFORMAT)/ADDR_WIDTH)*(((DATA_WIDTH/FPFORMAT)*x_cols_iter_tmp) + x_cols_lftovr);
   x_rows_offs   = ARRAY_WIDTH*x_d1_stride;
   w_tot_len     = w_rows_iter*w_cols_iter*x_rows_iter;
   w_d0_stride   = ((4*FPFORMAT)/ADDR_WIDTH)*(((DATA_WIDTH/FPFORMAT)*w_cols_iter_tmp) + w_cols_lftovr);
   yz_tot_len    = ARRAY_WIDTH*x_rows_iter*w_cols_iter;
   yz_d0_stride  = w_d0_stride;
   yz_d2_stride  = ARRAY_WIDTH*w_d0_stride;
   tot_x_read    = x_rows_iter*x_cols_iter*w_cols_iter;

   // Writing the computations in configuration register
   HWPE_WRITE(x_iters       , REDMULE_REG_OFFS + REDMULE_REG_X_ITER_PTR         );
   HWPE_WRITE(w_iters       , REDMULE_REG_OFFS + REDMULE_REG_W_ITER_PTR         );
   HWPE_WRITE(leftovers     , REDMULE_REG_OFFS + REDMULE_REG_LEFTOVERS_PTR      );
   HWPE_WRITE(left_params   , REDMULE_REG_OFFS + REDMULE_REG_LEFT_PARAMS_PTR    );
   HWPE_WRITE(x_d1_stride   , REDMULE_REG_OFFS + REDMULE_REG_X_D1_STRIDE_PTR    );
   HWPE_WRITE(x_rows_offs   , REDMULE_REG_OFFS + REDMULE_REG_X_ROWS_OFFS_PTR    );
   HWPE_WRITE(tot_x_read    , REDMULE_REG_OFFS + REDMULE_REG_TOT_X_READ_PTR     );
   HWPE_WRITE(x_buffer_slots, REDMULE_REG_OFFS + REDMULE_REG_X_BUFFER_SLOTS_PTR );
   HWPE_WRITE(w_tot_len     , REDMULE_REG_OFFS + REDMULE_REG_W_TOT_LEN_PTR      );
   HWPE_WRITE(w_d0_stride   , REDMULE_REG_OFFS + REDMULE_REG_W_D0_STRIDE_PTR    );
   HWPE_WRITE(yz_tot_len    , REDMULE_REG_OFFS + REDMULE_REG_YZ_TOT_LEN_PTR     );
   HWPE_WRITE(yz_d0_stride  , REDMULE_REG_OFFS + REDMULE_REG_YZ_D0_STRIDE_PTR   );
   HWPE_WRITE(yz_d2_stride  , REDMULE_REG_OFFS + REDMULE_REG_YZ_D2_STRIDE_PTR   );
   HWPE_WRITE(op_selection  , REDMULE_REG_OFFS + REDMULE_REG_OP_SELECTION       );
}

void generate_test_data16(int x_start_addr,
                          int w_start_addr,
                          int y_start_addr,
                          int m_size,
                          int n_size,
                          int k_size) {

  int x_addr     = x_start_addr;
  int w_addr     = w_start_addr;
  int y_addr     = y_start_addr;
  int x_end_addr = x_start_addr + (2*m_size*n_size);
  int w_end_addr = w_start_addr + (2*n_size*k_size);
  int y_end_addr = y_start_addr + (2*m_size*k_size);

  // Generating input stimuli from golden model
  for (x_addr = x_start_addr; x_addr < x_end_addr; x_addr += 2) {
    int x = x_addr - x_start_addr;
    *(uint32_t *)(x_addr) = x_inp[x/2];
  }

  // Generating Weight stimuli from golden model
  for (w_addr = w_start_addr; w_addr < w_end_addr; w_addr += 2) {
    int w = w_addr - w_start_addr;
    *(uint32_t *)(w_addr) = w_inp[w/2];
  }

  for (y_addr = y_start_addr; y_addr < y_end_addr; y_addr += 2) {
    int y = y_addr - y_start_addr;
    *(uint32_t *)(y_addr) = y_inp[y/2];
  }
}

int redmule_compare16 (int z_start_addr, int m_size, int k_size) {
  int err = 0;
  int z_end_addr = z_start_addr + 2*m_size*k_size;
  uint16_t z_computed;
  uint16_t diff, diff_1, diff_2;

  for (int z_addr = z_start_addr; z_addr < z_end_addr; z_addr += 2) {
    int z = z_addr - z_start_addr;
    z_computed = *(uint32_t *)(z_addr);

    if ( z_computed != z_oup[z/2] ) {
      diff_1 = z_computed - z_oup[z/2];
      if (diff_1 > 3) {
        diff_2 = z_oup[z/2] - z_computed;
        if (diff_2 > 3) {
          err++;
        }
      }
    }
  }

  return err;

}

int redmule16_compare_int(uint32_t *actual_z, uint32_t *golden_z, int len) {
  #define ERR 0x0011
  uint32_t actual_word = 0;
  uint16_t actual_MSHWord, actual_LSHWord;
  uint32_t golden_word = 0;
  uint16_t golden_MSHWord, golden_LSHWord;
  uint32_t actual = 0;
  uint32_t golden = 0;

  int errors = 0;
  int error;

  for (int i=0; i<len; i++) {
    error = 0;
    actual_word = *(actual_z+i);
    golden_word = *(golden_z+i);

    uint16_t diff = 0;

    // Chechink Least Significant Half-Word
    actual_LSHWord = (uint16_t)(actual_word & 0x0000FFFF);
    golden_LSHWord = (uint16_t)(golden_word & 0x0000FFFF);

    diff = (actual_LSHWord > golden_LSHWord) ? (actual_LSHWord - golden_LSHWord) : 0;
    diff = (actual_LSHWord < golden_LSHWord) ? (golden_LSHWord - actual_LSHWord) : 0;

    if (diff > ERR) {
      error = 1;
      #ifdef VERBOSE
        tfp_printf ("diff: 0x%08x\n", diff);
        tfp_printf ("LSW: Error!\n");
      #endif
    }

    // Checking Most Significant Half-Word
    actual_MSHWord = (uint16_t)((actual_word >> 16) & 0x0000FFFF);
    golden_MSHWord = (uint16_t)((golden_word >> 16) & 0x0000FFFF);

    diff = (actual_MSHWord > golden_MSHWord) ? (actual_MSHWord - golden_MSHWord) : 0;
    diff = (actual_MSHWord < golden_MSHWord) ? (golden_MSHWord - actual_MSHWord) : 0;

    if (diff > ERR) {
      error = 1;
      #ifdef VERBOSE
        tfp_printf ("diff: 0x%08x\n", diff);
        tfp_printf ("MSW: Error!\n");
      #endif
    }

    errors += error;

    #ifdef DEBUG
      tfp_printf("  Golden: 0x%08x; Actual: 0x%08x,\n", golden_word, actual_word);
    #endif

    #ifdef VERBOSE
    if(error) {
        if(errors==1) tfp_printf("  golden     <- actual     @ address    @ index\n");
        tfp_printf("  0x%08x <- 0x%08x @ 0x%08x @ 0x%08x\n", golden_word, actual_word, (actual_z+i), i*4);
    }
    #endif
  }
  return errors;
}

int redmule8_compare_int(uint32_t *actual_z, uint32_t *golden_z, int len) {
  #define ERR 0x0011
  uint32_t actual_word = 0;
  uint8_t  actual_Byte0,
           actual_Byte1,
           actual_Byte2,
           actual_Byte3;
  uint32_t golden_word = 0;
  uint8_t  golden_Byte0,
           golden_Byte1,
           golden_Byte2,
           golden_Byte3;
  uint32_t actual = 0;
  uint32_t golden = 0;

  int errors = 0;
  int error;

  for (int i=0; i<len; i++) {
    error = 0;
    actual_word = *(actual_z+i);
    golden_word = *(golden_z+i);

    uint8_t diff = 0;

    // Cheching Byte0
    actual_Byte0 = (uint8_t)(actual_word & 0x000000FF);
    golden_Byte0 = (uint8_t)(golden_word & 0x000000FF);

    diff = (actual_Byte0 > golden_Byte0) ? (actual_Byte0 - golden_Byte0) : 0;
    diff = (actual_Byte0 < golden_Byte0) ? (golden_Byte0 - actual_Byte0) : 0;

    if (diff > ERR) {
      error = 1;
      tfp_printf ("diff: 0x%08x\n", diff);
      tfp_printf ("Byte0: Error!\n");
    }

    // Cheching Byte1
    actual_Byte1 = (uint8_t)( (actual_word >> 8 ) & 0x000000FF);
    golden_Byte1 = (uint8_t)( (golden_word >> 8 ) & 0x000000FF);

    diff = (actual_Byte1 > golden_Byte1) ? (actual_Byte1 - golden_Byte1) : 0;
    diff = (actual_Byte1 < golden_Byte1) ? (golden_Byte1 - actual_Byte1) : 0;

    if (diff > ERR) {
      error = 1;
      tfp_printf ("diff: 0x%08x\n", diff);
      tfp_printf ("Byte1: Error!\n");
    }

    // Cheching Byte2
    actual_Byte2 = (uint8_t)( (actual_word >> 16 ) & 0x000000FF);
    golden_Byte2 = (uint8_t)( (golden_word >> 16 ) & 0x000000FF);

    diff = (actual_Byte2 > golden_Byte2) ? (actual_Byte2 - golden_Byte2) : 0;
    diff = (actual_Byte2 < golden_Byte2) ? (golden_Byte2 - actual_Byte2) : 0;

    if (diff > ERR) {
      error = 1;
      tfp_printf ("diff: 0x%08x\n", diff);
      tfp_printf ("Byte2: Error!\n");
    }

    // Cheching Byte3
    actual_Byte3 = (uint8_t)( (actual_word >> 24 ) & 0x000000FF);
    golden_Byte3 = (uint8_t)( (golden_word >> 24 ) & 0x000000FF);

    diff = (actual_Byte3 > golden_Byte3) ? (actual_Byte3 - golden_Byte3) : 0;
    diff = (actual_Byte3 < golden_Byte3) ? (golden_Byte3 - actual_Byte3) : 0;

    if (diff > ERR) {
      error = 1;
      tfp_printf ("diff: 0x%08x\n", diff);
      tfp_printf ("Byte3: Error!\n");
    }

    errors += error;

    #ifdef DEBUG
      tfp_printf("  Golden: 0x%08x; Actual: 0x%08x,\n", golden_word, actual_word);
    #endif

    #ifdef VERBOSE
      if(error) {
        if(errors==1) tfp_printf("  golden     <- actual     @ address    @ index\n");
        tfp_printf("  0x%08x <- 0x%08x @ 0x%08x @ 0x%08x\n", golden_word, actual_word, (actual_z+i), i*4);
      }
    #endif
  }
  return errors;
}

#endif

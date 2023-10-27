#ifndef __UTILS_H__
#define __UTILS_H__

#include <stdint.h>
#include "pulp_io.h"
#include "encoding.h"
#include "memory_map.h"
#include "properties.h"
#include "apb_soc/apb_soc.h"
#include "uart.h"
#ifdef FLL_DRIVER
#include "fll.h"
#endif
#include "cluster_ctrl_v2.h"
#include "plic.h"
#include "string_lib.h"
#include "archi_tlb/archi_tlb.h"
#include "archi_dma/archi_dma.h"
#include "llc.h"
#include "axi_llc_reg32.h"
#include "padframe/inc/alsaqr_periph_padframe.h"
#include "fpga_padframe/inc/alsaqr_periph_fpga_padframe.h"

#define BOOT_ADDR 0x1c002080 // Cluster boot addr

static inline void barrier() {
    __sync_synchronize();
}

void uart_sim_cfg();

static uint64_t lfsr(uint64_t);

void set_flls();

void tlb_cfg ( uint32_t,
               uint32_t,
               uint64_t,
               uint64_t,
               uint64_t,
               uint8_t
             );

uint32_t dma_h2c_trnf_cfg( uint64_t,
                           uint32_t,
                           uint32_t
                         );

uint32_t dma_c2h_trnf_cfg( uint32_t,
                           uint64_t,
                           uint32_t
                         );

void dma_wait_trnf_done (uint32_t trnf_id);

#define stats(code, iter) enable_llc_counters(); for(int __k = 0; __k < iter; __k++) { \
    unsigned long _c = -read_csr(mcycle), _i = -read_csr(minstret); \
    unsigned long int _l1d_miss = -read_csr(mhpmcounter4); \
    unsigned long int _l1i_miss = -read_csr(mhpmcounter3); \
    unsigned int _llc_hit = get_llc_hit(), _llc_miss = get_llc_miss(); \
    code; \
    _c += read_csr(mcycle), _i += read_csr(minstret); \
    _l1d_miss += read_csr(mhpmcounter4); \
    _l1i_miss += read_csr(mhpmcounter3); \
    _llc_hit = get_llc_hit() - _llc_hit; _llc_miss = get_llc_miss() - _llc_miss; \
    printf("@ Iter %d : %d cycles, %d instructions, L1D miss %d, L1I miss %d, LLC hit ratio: %d / %d\r\n",  __k, _c, _i, _l1d_miss, _l1i_miss,_llc_hit, _llc_hit + _llc_miss); \
  } 

void apb_timer_start();

unsigned int apb_timer_get();

static inline void synch_barrier() {
    __sync_synchronize();
}

static inline void pi_cl_team_barrier() {
    __sync_synchronize();
}
  
#define pi_core_id() 0

#define START_STATS(iter) enable_llc_counters(); for(int __k = 0; __k < iter; __k++) { \
    unsigned long _c = -read_csr(mcycle), _i = -read_csr(minstret); \
    unsigned long int _l1d_miss = -read_csr(mhpmcounter4); \
    unsigned long int _l1i_miss = -read_csr(mhpmcounter3); \
    unsigned int _llc_hit = get_llc_hit(), _llc_miss = get_llc_miss(); \

#define STOP_STATS()     _c += read_csr(mcycle), _i += read_csr(minstret); \
    _l1d_miss += read_csr(mhpmcounter4); \
    _l1i_miss += read_csr(mhpmcounter3); \
    _llc_hit = get_llc_hit() - _llc_hit; _llc_miss = get_llc_miss() - _llc_miss; \
    printf("@ Iter %d : %d cycles, %d instructions, L1D miss %d, L1I miss %d, LLC hit ratio: %d / %d\r\n",  __k, _c, _i, _l1d_miss, _l1i_miss,_llc_hit, _llc_hit + _llc_miss); \
  } 

#endif

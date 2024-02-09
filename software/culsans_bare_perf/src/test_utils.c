#include <stdint.h>
#include "utils.h"
#include "cache.h"
#include "test_stats.h"

void profile(void (*func)(volatile cacheline_t*), volatile cacheline_t* data) {

    uint64_t begin, end;
    uint64_t instr_begin, instr_end;

    reset_counters();
    start_counters();
    begin = rdcycle();
    instr_begin = rdinstret();

    func(data);

    instr_end = rdinstret();
    end = rdcycle();
    stop_counters();
    uint64_t cycles = end - begin;
    uint64_t instr  = instr_end - instr_begin;

    printf("IMISS: %d, DMISS: %d, TOT_CYC: %d, LOADS: %d, STORES: %d, INSTR: %d, L1_ACC: %d, L1_EVICT: %d\r\n",
        read_imiss(),                       // Instruction cache misses
        read_dmiss(),                       // Data cache misses
        cycles,                             // Total cycles taken
        read_loads(),                       // Number of loads
        read_stores(),                      // Number of stores
        instr,                              // Number of instructions
        read_l1_accesses(),                 // L1 accesses
        read_l1_eviction()                  // L1 evictions
    );

    uart_wait_tx_done();

    return;
}

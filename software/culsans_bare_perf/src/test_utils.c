#include <stdint.h>
#include "utils.h"
#include "cache.h"
#include "test_stats.h"

void profile(void (*func)(void), uint32_t stride) {

    // Execute the provided function (test) multiple times to warm up the cache

    uint64_t begin, end;

    reset_counters();
    start_counters();
    begin = rdcycle();

    func();

    end = rdcycle();
    stop_counters();
    uint64_t cycles = end - begin;

    printf("IMISS: %d, DMISS: %d, IF_EMPTY: %d, TOT_CYC: %d, AVG_CYC: %d\r\n",
        read_imiss(),                       // Instruction cache misses
        read_dmiss(),                       // Data cache misses
        read_if_empty(),                    // Instruction fetch empty
        cycles,                             // Total cycles taken
        cycles>>(NUM_WORDS - stride + 1)    // Average cycles per word accessed
    );

    uart_wait_tx_done();

    return;
}

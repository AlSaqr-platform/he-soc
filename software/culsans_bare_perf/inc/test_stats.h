#ifndef __TEST_STATS_H__
#define __TEST_STATS_H__

#include "encoding.h"

inline void reset_counters() {
    write_csr(mhpmcounter3, 0b0);
    write_csr(mhpmcounter4, 0b0);
}

inline void start_counters() {
    write_csr(mhpmevent3, 0b00001);
    write_csr(mhpmevent4, 0b00010);
}

inline void stop_counters() {
    write_csr(mhpmevent3, 0b0);
    write_csr(mhpmevent4, 0b0);
}

inline unsigned int read_imiss() {
    return read_csr(mhpmcounter3);
}

inline unsigned int read_dmiss() {
    return read_csr(mhpmcounter4);
}

#endif
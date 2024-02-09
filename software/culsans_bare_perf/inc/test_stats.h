#ifndef __TEST_STATS_H__
#define __TEST_STATS_H__

#include "encoding.h"

inline void reset_counters() {
    write_csr(mhpmcounter3, 0b0);
    write_csr(mhpmcounter4, 0b0);
    write_csr(mhpmcounter5, 0b0);
    write_csr(mhpmcounter6, 0b0);
    write_csr(mhpmcounter7, 0b0);
    write_csr(mhpmcounter8, 0b0);
}

inline void start_counters() {
    write_csr(mhpmevent3, 0b00001); // IMISS
    write_csr(mhpmevent4, 0b00010); // DMISS
    write_csr(mhpmevent5, 0b10010); // L1 EVICTION
    write_csr(mhpmevent6, 0b00101); // LOAD
    write_csr(mhpmevent7, 0b00110); // STORE
    write_csr(mhpmevent8, 0b10001); // L1 ACCESS
}

inline void stop_counters() {
    write_csr(mhpmevent3, 0b0);
    write_csr(mhpmevent4, 0b0);
    write_csr(mhpmevent5, 0b0);
    write_csr(mhpmevent6, 0b0);
    write_csr(mhpmevent7, 0b0);
    write_csr(mhpmevent8, 0b0);
}

inline unsigned int read_imiss() {
    return read_csr(mhpmcounter3);
}

inline unsigned int read_dmiss() {
    return read_csr(mhpmcounter4);
}

inline unsigned int read_l1_eviction() {
    return read_csr(mhpmcounter5);
}

inline unsigned int read_l1_accesses() {
    return read_csr(mhpmcounter8);
}

inline unsigned int read_loads() {
    return read_csr(mhpmcounter6);
}

inline unsigned int read_stores() {
    return read_csr(mhpmcounter7);
}


#endif
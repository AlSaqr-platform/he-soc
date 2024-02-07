#ifndef __TEST_UTILS_H__
#define __TEST_UTILS_H__

#include <stdint.h>
#include "cache.h"

#define read_loop(ptr, size) \
    for (uint32_t i = 0; i < (size); i++) { \
        *(ptr + i); \
    }

#define write_loop(ptr, size) \
    for (uint32_t i = 0; i < (size); i++) { \
        *(ptr + i) = 0x1234ABCD; \
    }

inline void warm(void (*func)(void), uint32_t iter) {
    for(uint32_t i = 0; i < iter; i++)
        func();
}

void profile(void (*test)(void), uint32_t stride);

void unrolled_read(void);

void unrolled_write(void);

#endif
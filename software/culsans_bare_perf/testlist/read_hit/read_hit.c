#include "read_hit.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data [CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

int read_hit(int cid, int nc)
{
  if (cid == 0) {
    // Bring data1 in dcache
    write_loop(data, CACHE_WAYS * CACHE_ENTRIES);
    // Warm I$
    volatile cacheline_t *data_ptr = &data[2048 / sizeof(cacheline_t)];
    reads(data_ptr);
    reads(data_ptr);
    // Profile
    profile(reads, data_ptr);
    exit(0);
  }
  return 0;
}
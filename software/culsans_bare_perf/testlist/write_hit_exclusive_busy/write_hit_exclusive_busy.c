#include "write_hit_exclusive_busy.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile cacheline_t dummy __attribute__((section(".nocache_noshare_region")));

int write_hit_exclusive_busy(int cid, int nc)
{
  if (cid == 0) {
    // Bring data in dcache with exclusivity
    read_loop(data, CACHE_WAYS * CACHE_ENTRIES);
    // Warm I$
    volatile cacheline_t *data_ptr = &data[2048 / sizeof(cacheline_t)];
    writes(data_ptr);
    writes(data_ptr);
    // Profile
    profile(writes, data_ptr);
    exit(0);
  }

  // create some traffic
  while (1) {
    dummy++;
  }

  return 0;
}
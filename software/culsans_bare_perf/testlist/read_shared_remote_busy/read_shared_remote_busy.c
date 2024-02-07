#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));
volatile cacheline_t more_data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile uint64_t dummy __attribute__((section(".nocache_noshare_region")));

int read_shared_remote_busy(int cid, int nc)
{
  if (cid == 0) {

    // Warm I$
    warm(unrolled_read, 2);

    // Make sure to evict all entries
    read_loop(more_data, CACHE_WAYS * CACHE_ENTRIES);

    profile(unrolled_read, 2);

    exit(0);
  }

  // just create traffic at shared memory level
  while(1)
    dummy++;

  return 0;
}
#include "read_shared_remote.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));
volatile cacheline_t more_data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

int read_shared_remote(int cid, int nc)
{
  if (cid == 0) {

    // Warm I$
    warm(unrolled_read, 2);

    // Make sure to evict all entries
    read_loop(more_data, CACHE_WAYS * CACHE_ENTRIES);

    profile(unrolled_read, 2);

    exit(0);
  }

  return 0;
}
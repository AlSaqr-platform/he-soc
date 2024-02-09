#include "write_shared_busy.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

// synchronization variable: non-cached and non-shared
volatile uint64_t count __attribute__((section(".nocache_noshare_region")));

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile cacheline_t dummy __attribute__((section(".nocache_noshare_region")));

int write_shared_busy(int cid, int nc)
{
  count = 0;

  volatile cacheline_t *data_ptr = &data[2048 / sizeof(cacheline_t)];

  if (cid == 0) {
    // warm I$
    writes(data_ptr);
    writes(data_ptr);
    count++;
  }

  while(count == 0);

  if (cid == nc-1) {
    // Cache the whole data array
    write_loop(data, CACHE_WAYS * CACHE_ENTRIES);
    count++;
  }

  while(count == 1);

  if (cid == 0) {
    // Write locations
    profile(writes, data_ptr);
    exit(0);
  }

  // create some traffic
  while (1) {
    dummy++;
  }

  return 0;
}
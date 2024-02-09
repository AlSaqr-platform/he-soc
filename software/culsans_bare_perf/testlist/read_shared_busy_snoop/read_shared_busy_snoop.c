#include "read_shared_busy_snoop.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

// synchronization variable: non-cached and non-shared
volatile uint64_t count __attribute__((section(".nocache_noshare_region")));

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile cacheline_t dummy __attribute__((section(".nocache_share_region")));
volatile cacheline_t* dummyptr;

int read_shared_busy_snoop(int cid, int nc)
{
  count = 0;

  volatile cacheline_t *data_ptr = &data[2048 / sizeof(cacheline_t)];

  if (cid == 0) {
    // Warm I$
    reads(data_ptr);
    reads(data_ptr);
    count++;
  }

  while(count == 0);

  if (cid == nc-1) {
    // The core nc-1 owns the locations
    write_loop(data, CACHE_WAYS * CACHE_ENTRIES);
    count++;
  }

  while(count == 1);

  if (cid == 0) {
    profile(reads, data_ptr);
    exit(0);
  }

  // create some traffic
  dummyptr = &dummy;
  while (1) {
    *(dummyptr++);
  }

  return 0;
}
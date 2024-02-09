#include "read_hit_busy_snoop.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile cacheline_t dummy __attribute__((section(".nocache_share_region")));
volatile cacheline_t* dummyptr;

int read_hit_busy_snoop(int cid, int nc)
{
  if (cid == 0) {
    // Bring data in dcache
    write_loop(data, CACHE_WAYS * CACHE_ENTRIES);
    // Init dummy
    dummy = 0;
    // Warm I$
    volatile cacheline_t *data_ptr = &data[2048 / sizeof(cacheline_t)];
    reads(data_ptr);
    reads(data_ptr);
    // Profile
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
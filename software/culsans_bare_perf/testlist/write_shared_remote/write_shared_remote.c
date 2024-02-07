#include "write_shared_remote.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));
volatile cacheline_t more_data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

int write_shared_remote(int cid, int nc)
{
  long begin, end;

  if (cid == 0) {
    warm(unrolled_write, 2);
    read_loop(more_data, CACHE_WAYS * CACHE_ENTRIES);
    profile(unrolled_write, 1);
    exit(0);
  }

  return 0;
}
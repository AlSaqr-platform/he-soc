#include "write_hit_shared.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

void prepare()
{
  for (int i = 0; i < sizeof(data)/sizeof(data[0]); i++)
    data[i] = i+1;
}

int write_hit_shared(int cid, int nc)
{
  if (cid == 0) {
    // `data` should be cached and shared -> read it
    read_loop(data, CACHE_WAYS * CACHE_ENTRIES);
    profile(unrolled_write, 1);
    exit(0);
  }

  return 0;
}
#include "write_hit_exclusive_busy_snoop.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile cacheline_t dummy __attribute__((section(".nocache_share_region")));
volatile cacheline_t* dummyptr;

void prepare()
{
  for (int i = 0; i < sizeof(data)/sizeof(data[0]); i++)
    data[i] = i+1;
}

int write_hit_exclusive_busy_snoop(int cid, int nc)
{
  if (cid == 0) {
    prepare();
    warm(unrolled_write, 2);
    profile(unrolled_write, 1);
    exit(0);
  }

  // create some traffic
  dummyptr = &dummy;
  while (1) {
    *(dummyptr++);
  }

  return 0;
}
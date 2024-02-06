#include "write_hit_shared_busy.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

volatile cacheline_t dummy __attribute__((section(".nocache_noshare_region")));

void prepare()
{
  for (int i = 0; i < sizeof(data)/sizeof(data[0]); i++)
    data[i] = i+1;
}

int write_hit_shared_busy(int cid, int nc)
{
  long begin, end;

  if (cid == 0) {
    for (int i = 0; i < sizeof(data)/sizeof(data[0]); i++)
      data[i];
    begin = rdcycle();
    unrolled_write();
    end = rdcycle();
    exit((end-begin)>>12);
  }

  // create some traffic
  while (1) {
    dummy++;
  }

  return 0;
}
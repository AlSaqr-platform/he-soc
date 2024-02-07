#include "read_shared.h"
#include "encoding.h"
#include "test_utils.h"
#include <stdint.h>

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

void prepare()
{
  for (int i = 0; i < sizeof(data)/sizeof(data[0]); i++)
    data[i] = i+1;
}

int read_shared(int cid, int nc)
{
  if (cid == 0) {
    warm(unrolled_read, 2);
    profile(unrolled_read, 2);
    exit(0);
  }

  return 0;
}
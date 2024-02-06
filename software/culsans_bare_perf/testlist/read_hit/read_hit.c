#include "read_hit.h"
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

int read_hit(int cid, int nc)
{
  long begin, end;

  if (cid == 0) {
    prepare();
    begin = rdcycle();
    unrolled_read();
    end = rdcycle();
    exit((end-begin)>>11);
  }

  return 0;
}

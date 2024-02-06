#include "read_shared_remote.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_share_region")));

int read_shared_remote(int cid, int nc)
{
  long begin, end;

  if (cid == 0) {
    begin = rdcycle();
    unrolled_read();
    end = rdcycle();
    exit((end-begin)>>11);
  }

  return 0;
}
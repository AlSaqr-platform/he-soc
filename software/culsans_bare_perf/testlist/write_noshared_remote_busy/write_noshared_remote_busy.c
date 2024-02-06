#include "write_noshared_remote_busy.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_noshare_region")));

volatile uint64_t dummy __attribute__((section(".nocache_noshare_region")));

int write_noshared_remote_busy(int cid, int nc)
{
  long begin, end;

  if (cid == 0) {
    begin = rdcycle();
    unrolled_write();
    end = rdcycle();
    exit((end-begin)>>12);
  }

  // just create traffic at shared memory level
  while(1)
    dummy++;

  return 0;
}
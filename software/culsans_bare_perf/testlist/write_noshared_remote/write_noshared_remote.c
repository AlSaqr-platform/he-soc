#include "write_noshared_remote.h"
#include <stdint.h>
#include "encoding.h"
#include "test_utils.h"

extern void exit(int);

volatile cacheline_t data[CACHE_WAYS * CACHE_ENTRIES] __attribute__((section(".cache_noshare_region")));

int write_noshared_remote(int cid, int nc)
{
  long begin, end;

  if (cid == 0) {
    begin = rdcycle();
    unrolled_write();
    end = rdcycle();
    exit((end-begin)>>12);
  }

  return 0;
}

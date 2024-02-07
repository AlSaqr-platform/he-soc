#include "write_shared.h"
#include <stdint.h>
#include "test_utils.h"

// synchronization variable: non-cached and non-shared
volatile uint64_t count __attribute__((section(".nocache_noshare_region")));

extern void exit(int);

void thread_entry(int cid, int nc)
{
  count = 0;
  if (cid == 0) {
    warm(unrolled_write, 2);
    count++;
  }

  while(count == 0);

  if (cid == nc-1) {
    prepare();
    count++;
  }

  while(count == 1);

  // actual test
  write_shared(cid, nc);

  // cores wait here
  while(cid)
    { asm volatile ("wfi"); }
}

int main()
{
  return 0;
}

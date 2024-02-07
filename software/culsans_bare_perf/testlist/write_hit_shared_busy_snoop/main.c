#include "write_hit_shared_busy_snoop.h"
#include <stdint.h>
#include "test_utils.h"

// synchronization variable: non-cached and non-shared
volatile uint64_t count __attribute__((section(".nocache_noshare_region")));

extern void exit(int);

void thread_entry(int cid, int nc)
{
  count = 0;
  if (cid == 0) {
    // Warm I$
    // This will make `data` not shared!
    warm(unrolled_write, 2);
    count++;
  }

  while(count == 0);

  if (cid == nc-1) {
    // Core nc-1 takes back data by modifying it
    prepare();
    count++;
  }

  while(count == 1);

  // actual test
  write_hit_shared_busy_snoop(cid, nc);

  // cores wait here
  while(cid)
    { asm volatile ("wfi"); }
}

int main()
{
  return 0;
}

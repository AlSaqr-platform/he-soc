#include "write_hit_shared_busy_snoop.h"
#include <stdint.h>

extern void exit(int);

void thread_entry(int cid, int nc)
{
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

#include "write_shared_busy.h"
#include <stdint.h>

extern void exit(int);

void thread_entry(int cid, int nc)
{
  // actual test
  write_shared_busy(cid, nc);

  // cores wait here
  while(cid)
    { asm volatile ("wfi"); }
}

int main()
{
  return 0;
}

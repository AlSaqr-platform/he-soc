#include "read_shared_busy.h"
#include <stdint.h>

extern void exit(int);

void thread_entry(int cid, int nc)
{
  // actual test
  read_shared_busy(cid, nc);
}

int main()
{
  return 0;
}

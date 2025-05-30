//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#define N 20

const int RESULT_FIB[N] = {0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181};

int main(int argc, char const *argv[]) {

  // C2H TLB configuration
  tlb_cfg(C2H_TLB_BASE_ADDR, 0, c2h_first_va, c2h_last_va, c2h_base_pa, c2h_flags);
  int * b;
  b=0x10000000;
  int i;
  b[0]=0;
  b[1]=1;
  b[2]=1;
  for(i=3;i<10;i++)
    {
      b[i]=b[i-1]+b[i-2];
      if(b[i]!=RESULT_FIB[i])
        return 1;
    }
  printf("0k!\n");
  return 0;
}

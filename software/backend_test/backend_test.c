#include <stdio.h>
#include <stdlib.h>
#include "utils.h"

int main(int argc, char const *argv[]) {

  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  uint32_t * address;
  pulp_write32(0x1A106000,0x0);
  pulp_write32(0x1A106000,0x1);
  for(int i=1;i<10;i++) {
    address = (uint32_t *)0x1A106000+i;
    pulp_write32(address,0xabba5a5a);
    printf("%x\n",pulp_read32(address));
  }
  address= (uint32_t *)0x1A106028;
  printf("%x\n",pulp_read32(address));
  return 0;
}
 



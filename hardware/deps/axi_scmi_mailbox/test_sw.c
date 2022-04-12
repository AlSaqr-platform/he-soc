#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
//#define N 20

//const int RESULT_FIB[N] = {0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181};

int main(int argc, char const *argv[]) {
  #ifdef FPGA_EMULATION
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
 
  int volatile * p_reg, * p_reg1, * p_reg2, * p_reg3, * p_reg4, * p_reg5;
  int a, b, c, d, e;
  
  p_reg  = (int *) 0x50000004;
  
  p_reg1 = (int *) 0x50000008;
  p_reg2 = (int *) 0x50000010;
  p_reg3 = (int *) 0x50000014;
  p_reg4 = (int *) 0x50000018;
  p_reg5 = (int *) 0x5000001C;

  *p_reg1 = 0xBAADC0DE;
  *p_reg2 = 0xBAADC0DE;
  *p_reg3 = 0xBAADC0DE;
  *p_reg4 = 0xBAADC0DE;
  *p_reg5 = 0xBAADC0DE;

  a = *p_reg1;
  b = *p_reg2;
  c = *p_reg3;
  d = *p_reg4;
  e = *p_reg5; 

  if( a == 0xBAADC0DE && b == 0xBAADC0DE && c == 0xBAADC0DE && d == 0xBAADC0DE && e == 0xBAADC0DE){
     *p_reg = 0x00000001;
     while(*p_reg != 0x00000000);
  }
  else{
     printf("Test failed!\n");
     uart_wait_tx_done();
     return 0;
  }

  printf("Test succeeded!\n");
  uart_wait_tx_done();
  
  return 0;
}

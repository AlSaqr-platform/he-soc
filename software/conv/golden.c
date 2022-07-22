#include <stdio.h>                                                                               
#include <math.h>
#include "./input.h"
#define NUM_CORES 1
#include "conv_kernel.c"

int main ()
{

  unsigned int Out[IMG_DIM];  
  Conv5x5_Scalar(0,In_Img,Out,ROWS,COLS,Filter_Kern);

  int i=0;
  printf("uint32_t ref [IMG_DIM]= {\n");
  for(i = 0; i<IMG_DIM-1; i++)
    printf("%u , \n", Out[i]);

  printf("%u}; \n", Out[IMG_DIM-1]);
  
  return 0;

}

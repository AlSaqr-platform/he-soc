#include <stdio.h>                                                                               
#include <math.h>
#include "./input.h"
#define NUM_CORES 1
#include "conv_kernel.c"

int main ()
{

  int Out[IMG_DIM];
  
  Conv5x5_Scalar(0,In_Img,Out,ROWS,COLS,Filter_Kern);

  int i=0;
  printf("int ref [IMG_DIM]= {\n");
  for(i = 0; i<IMG_DIM-1; i++)
    printf("%d , \n", Out[i]);

  printf("%d}; \n", Out[IMG_DIM-1]);
  
  return 0;

}

#define ROWS 32   
#define COLS 32 
#define IMG_DIM ROWS * COLS
#define FILT_WIN 5
#define FILT_DIM FILT_WIN*FILT_WIN

#include <stdio.h>                                                                               
#include <math.h>
int main ()
{

  int i ,j;
  printf("#define ROWS %d \n", ROWS);
  printf("#define COLS %d \n", COLS);
  printf("#define IMG_DIM ROWS * COLS \n");
  printf("#define FILT_WIN %d\n", FILT_WIN);
  printf("#define FILT_DIM FILT_WIN*FILT_WIN\n");
  
  printf("int Filter_Kern[FILT_DIM] = { ");
  for( i = 0; i<FILT_DIM-1 ; i++) 
    printf("%d ,", rand()%32);

  printf("%d}; \n\n", rand()%32);
  
  printf("int In_Img[IMG_DIM]= { ");

  // padding
  for (i=0;i<IMG_DIM-1;i++)
        printf("%d, \n", rand()%8);

  printf("0 };");

  
  return 0;

}

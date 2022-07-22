#define LOG2_FFT_LEN_RADIX2     11
#define FFT_LEN_RADIX2          (1 << LOG2_FFT_LEN_RADIX2)

#include <stdio.h>                                                                               
#include <math.h>
int main ()
{
  float Theta = -(2*(3.14f))/FFT_LEN_RADIX2;
  float Phi;
  int i = 0;
  int j = 0;
  
  printf("#define LOG2_FFT_LEN_RADIX2     11 \n");
  printf("#define FFT_LEN_RADIX2          (1 << LOG2_FFT_LEN_RADIX2) \n");
  printf("#define THR 0.1f  \n");
  printf("typedef struct {\n");
  printf("  float re;\n");
  printf("  float im;\n");
  printf(" } Complex_type;\n \n");
  printf("Complex_type twiddle_factors[FFT_LEN_RADIX2/2] = { \n");
  
  for (i=0; i<((FFT_LEN_RADIX2/2)-1); i++)  {
    Phi = Theta*i;
    printf("   { %ff , %ff }, \n", cosf(Phi), sinf(Phi) );
  }

  Phi = Theta*i;
  printf("   { %ff , %ff } \n", cosf(Phi), sinf(Phi) );
  printf("};\n");

  printf("short bit_rev_radix2_LUT[FFT_LEN_RADIX2] = {\n");
  for (j=0; j<FFT_LEN_RADIX2;j++){
    unsigned int revNum = 0;
    for (i=0; i<FFT_LEN_RADIX2;i++) {
      unsigned int temp = (j & (1 << i));
      if (temp != 0)
        revNum |= (1 << ((LOG2_FFT_LEN_RADIX2 -1) - i));
    }
    if(j<FFT_LEN_RADIX2-1)
      printf("%d,\n", revNum);
    else
      printf("%d\n", revNum);
  }

  printf("};\n");
  
  return 0;

}

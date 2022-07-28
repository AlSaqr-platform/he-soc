#include "twiddles.h"
#define _USE_MATH_DEFINES

#define PARALLEL

#define LOG2_FFT_LEN_RADIX2     11
#define FFT_LEN_RADIX2          (1 << LOG2_FFT_LEN_RADIX2)

#define SORT_OUTPUT
#define BITREV_LUT

#define ABS(x) ((x>=0)?x:-x)

#define VERBOSE

Complex_type Buffer_Signal_Out[FFT_LEN_RADIX2];


Complex_type complex_mul (Complex_type A, Complex_type B)
{
  Complex_type c_tmp;

  c_tmp.re = A.re * B.re - A.im * B.im;
  c_tmp.im = A.re * B.im + A.im * B.re;

  return c_tmp;
}
 
Complex_type complex_mul_real (float A, Complex_type B)
{
  Complex_type c_tmp;
  c_tmp.re = A * B.re;
  c_tmp.im = A * B.im;
  return c_tmp;
}

int check_re (Complex_type * A, Complex_type * B, int index)
{
  float * re0 = ( (void *) (A + 4*index) );
  float * re1 = ( (void *) (A + 4*index) );
  float re = ABS(*re0 - *re1); /// breaks 
  
  if(re>THR) {
    #ifdef VERBOSE
      	printf("Buffer_Signal_Out[%d].re = %f,\t expected %f\t error=%f\r\n", index, *re0, *re1, re);
        uart_wait_tx_done();
    #endif
    return 1;
  }
  else
    return 0;

}

int check_im (Complex_type * A, Complex_type * B, int index)
{
  float * re0 = ( (void *) (A + 4*index + 4) );
  float * re1 = ( (void *) (A + 4*index + 4) );
  float re = ABS(*re0 - *re1); /// breaks 
  
  if(re>THR) {
    #ifdef VERBOSE
      	printf("Buffer_Signal_Out[%d].re = %f,\t expected %f\t error=%f\r\n", index, *re0, *re1, re);
        uart_wait_tx_done();
    #endif
    return 1;
  }
  else
    return 0;

}

void process_butterfly_real_radix2 (Complex_type* input, int twiddle_index, int distance, Complex_type* twiddle_ptr) //1^stage
{
  int index = 0;
  float d0         = input[index].re;
  float d1         = input[index+distance].re;

  Complex_type r0, r1;

  //Re(c1*c2) = c1.re*c2.re - c1.im*c2.im, since c1 is real = c1.re*c2.re
  r0.re = d0 + d1;
  r1.re = d0 - d1;

  Complex_type tw0 = twiddle_ptr[twiddle_index];

  // input[index]            = complex_mul_real(r0.re,tw0);
  input[index]            = r0;
  input[index+distance]   = complex_mul_real(r1.re,tw0);
}

void process_butterfly_radix2 (Complex_type* input, int twiddle_index, int index, int distance, Complex_type* twiddle_ptr)
{
  Complex_type r0, r1;

  float d0         = input[index].re;
  float d1         = input[index+distance].re;
  float e0         = input[index].im;
  float e1         = input[index+distance].im;

  //Re(c1*c2) = c1.re*c2.re - c1.im*c2.im

  r0.re = d0 + d1;
  r1.re = d0 - d1;

  //Im(c1*c2) = c1.re*c2.im + c1.im*c2.re

  r0.im = e0 + e1;
  r1.im = e0 - e1;

  Complex_type tw0 = twiddle_ptr[twiddle_index];

  input[index]           = r0;
  input[index+distance]  = complex_mul(tw0, r1);
}

void  process_butterfly_last_radix2 (Complex_type* input, Complex_type* output, int outindex ) //uscita
{
  int index = 0;
  Complex_type r0, r1;

  float d0  = input[index].re;
  float d1  = input[index+1].re;
  float e0  = input[index].im;
  float e1  = input[index+1].im;


  //Re(c1*c2) = c1.re*c2.re - c1.im*c2.im

  r0.re = d0 + d1;
  r1.re = d0 - d1;

  //Im(c1*c2) = c1.re*c2.im + c1.im*c2.re

  r0.im = e0 + e1;
  r1.im = e0 - e1;

  /* In the Last step, twiddle factors are all 1 */
  output[outindex  ] = r0;
  output[outindex+1] = r1;
}

void  fft_radix2 (Complex_type * Inp_signal, Complex_type * Out_signal, Complex_type * input_twiddle_factors)
{
  int k,j,stage, step, d, index;
  Complex_type * _in;
  Complex_type * _out;
  Complex_type  temp;
  int dist = FFT_LEN_RADIX2 >> 1;
  int nbutterfly = FFT_LEN_RADIX2 >> 1;
  int butt = 2; //number of butterfly in the same group
  Complex_type * _in_ptr;
  Complex_type * _out_ptr;
  Complex_type * _tw_ptr;
  _in  = &(Inp_signal[0]);
  _out = &(Out_signal[0]);

  // FIRST STAGE, input is real, stage=1
  stage = 1;

  _in_ptr = _in;
  _tw_ptr = input_twiddle_factors;

  for(j=0;j<nbutterfly;j++)
  {
    process_butterfly_real_radix2(_in_ptr, j, dist, _tw_ptr);
    _in_ptr++;
  } //j

  stage = stage + 1;
  dist  = dist >> 1;
  
  while(dist > 1)
  {
    step = dist << 1;
    for(j=0;j<butt;j++)
    {
      _in_ptr = _in;
      for(d = 0; d < dist; d++)
      {
         process_butterfly_radix2(_in_ptr, d*butt, j*step, dist, _tw_ptr);
         _in_ptr++;
       } //d
    } //j
    stage = stage + 1;
    dist  = dist >> 1;
    butt = butt  << 1;
  }

  // LAST STAGE
  _in_ptr = _in;
  index=0;
  for(j=0;j<FFT_LEN_RADIX2>>1;j++)
  {
    process_butterfly_last_radix2(_in_ptr, _out, index);
    _in_ptr +=2;
    index   +=2;
   } //j

   // ORDER VALUES
  for(j=0; j<FFT_LEN_RADIX2; j+=4)
  {
    unsigned int index12 = *((unsigned int *)(&bit_rev_radix2_LUT[j]));
    unsigned int index34 = *((unsigned int *)(&bit_rev_radix2_LUT[j+2]));
    unsigned int index1  = index12 & 0x0000FFFF;
    unsigned int index2  = index12 >> 16;
    unsigned int index3  = index34 & 0x0000FFFF;
    unsigned int index4  = index34 >> 16;
    if(index1 > j)
    {
      temp         = _out[j];
      _out[j]      = _out[index1];
      _out[index1] = temp;
    }
    if(index2 > j+1)
    {
      temp         = _out[j+1];
      _out[j+1]    = _out[index2];
      _out[index2] = temp;
    }
    if(index3 > j+2)
    {
      temp         = _out[j+2];
      _out[j+2]    = _out[index3];
      _out[index3] = temp;
    }
    if(index4 > j+3)
    {
      temp         = _out[j+3];
      _out[j+3]    = _out[index4];
      _out[index4] = temp;
    }
  }
 
}



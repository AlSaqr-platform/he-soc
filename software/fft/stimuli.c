#include <stdio.h>
#include "encoding.h"
#include "utils.h"
#include "fft.h"
#include "data_signal.h"
#include "data_out.h"

#define CHECK

int main(int argc, char const *argv[]) {
  int i, m, n;
  
  int baud_rate = 115200;
  int test_freq = 50000000;
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
  
  stats(fft_radix2(Input_Signal, Buffer_Signal_Out,twiddle_factors),10);
  
  #ifdef CHECK    
  int re_err = 0;
  int im_err = 0;
  
  for(i=0;i<FFT_LEN_RADIX2;i++)
  {
    if (check_re(Buffer_Signal_Out,ref, i)) {
    	re_err++;
    }
    
    if(check_im(Buffer_Signal_Out,ref, i)){
    	im_err++;
    }
    
  }

  #ifdef VERBOSE
  if((re_err+im_err) != 0)
    printf("TEST FAILED!!\r\n");
  else if((re_err!=0) & (im_err!=0))
    printf("TEST FAILED with %d errors on real part and %d errors on imaginary part!!\r\n", re_err, im_err);
  else if(re_err != 0)
    printf("TEST FAILED with %d errors on the real part!!\r\n", re_err);
  else if(im_err != 0)
    printf("TEST FAILED with %d errors on the imaginary part!!\r\n", im_err);

  if(re_err+im_err==0)
    printf("TEST PASSED\r\n");
  #endif
    
    uart_wait_tx_done();
  
  #endif

  return 0;

}

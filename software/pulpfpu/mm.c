//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
//#define FPGA_EMULATION

static inline unsigned int core_id() {
  int hart_id;
  asm("csrr %0, 0xF14" : "=r" (hart_id) : );
  // in PULP the hart id is {22'b0, cluster_id, core_id}
  return hart_id & 0x01f;
}

int * i;

int thread_entry(int cid, int nc) {

  float fv0[8] = { 29.0024052F, 16.8149376F, 42.0270653F, 86.9266739F, 167475.188F, 167471.844F, 738649.812F,  738635.062F  };
  float fv1[8] = { 86825.1797F, 86823.4453F, 257317.766F, 257312.609F, 205468.344F, 205464.25F, 1.28340175E+6F, 1.283376E+6F };
  float * fv2 ;
  float * fv3 ;
  float * fresult ;
  int * result_pointer;
  float gold_result = 1964788416512.0F;

  i = 0x10001030;
  fv2 = 0x10000000 ;
  fv3 = 0x10000040 ;
  fresult = 0x10001020 ;
  result_pointer = 0x10001020;
  
  for (int k=0; k<8; k++)
    if(core_id()==k) {
      fv2[k] = fv0[k] * fv1[k];
      fv3[k] = fv0[k] / fv1[k];
    }
  
  if(core_id()==7){
      pulp_write32(i,8);
  }

  if (core_id()==0){

    while(pulp_read32(i)!=8);
    fresult[0]=0.0F;
    fresult[1]=0.0F;
    
    for (int j=0; j<8; j++) {
      fresult[0] = fresult[0] + fv2[j];
      fresult[1] = fresult[1] + fv3[j];
    }
    
    printf("%x\n", *result_pointer);
    printf("%x\n", *(result_pointer+0x1));
    
    if( (*result_pointer!=0x53e4bb42) || (*(result_pointer+0x1)!=4032110a) )
      printf("error\n");
    pulp_write32(0x10001000,1);

  }

  do
      __asm__ volatile("wfi");
  while(1);
            
  return 0;
}

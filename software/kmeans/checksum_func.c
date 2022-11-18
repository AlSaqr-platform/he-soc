#include "config.h"
#include "checksum.h"
#include "checksum_func.h"
#include "pmsis.h"


void checksum_f_vect(FLOAT *x, int r){
		 
		float diff = 0.0f;
		//float thr = 0.001f; //FP32
		//float thr = 0.172f; //FP16ALT
		//float thr = 0.0034f; //FP16
		int err = 0;

		for(int i = 0; i < r; i++){  
			diff = fabs(x[i] - check[i]);
			
				if(diff>THR){
					err++;
					#ifdef VERBOSE
					printf("Error at index %d:\t expected %f\t real %f\t error %f\n", i, check[i], x[i], diff);
					#endif
				}
		}

		if(err != 0)
			printf("TEST FAILED with %d errors!!\n", err);
		else
			printf("TEST PASSED!!\n");
}
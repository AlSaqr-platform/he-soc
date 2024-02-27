#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include "utils.h"

   
#define ETH_BASE 			 0x30000000
#define L2_BASE              0x1C001000

#define MACLO_OFFSET                 0x0
#define MACHI_OFFSET                 0x4

#define IDMA_SRC_ADDR_OFFSET         0x10
#define IDMA_DST_ADDR_OFFSET         0x14
#define IDMA_LENGTH_OFFSET           0x18
#define IDMA_SRC_PROTO_OFFSET        0x1c
#define IDMA_DST_PROTO_OFFSET        0x20
#define IDMA_REQ_VALID_OFFSET        0x38
#define IDMA_REQ_READY_OFFSET        0x3c
#define IDMA_RSP_READY_OFFSET        0x40
#define IDMA_RSP_VALID_OFFSET        0x44




  
int main() {
		
	// for (int v = 0; v < N_REPS; v++) {
	// 	#ifdef FPGA_EMULATION
	// 		return 0;
	// 	#else
	// 		#ifdef SIMPLE_PAD
	// 		return 0;
	// 	#else
	// 		switch(v){
	// 		case 0:
	// 		alsaqr_periph_padframe_periphs_a_00_mux_set( 2 );  

			// alsaqr_periph_padframe_periphs_b_23_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_24_mux_set( 1 ); 
			// alsaqr_periph_padframe_periphs_b_25_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_26_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_27_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_28_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_29_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_30_mux_set( 2 );
			// alsaqr_periph_padframe_periphs_b_31_mux_set( 2 );
			// alsaqr_periph_padframe_periphs_b_32_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_33_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_34_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_35_mux_set( 1 );
			// alsaqr_periph_padframe_periphs_b_36_mux_set( 2 );
			// alsaqr_periph_padframe_periphs_b_37_mux_set( 2 );


   //    alsaqr_periph_padframe_periphs_a_15_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_16_mux_set( 0);
			// alsaqr_periph_padframe_periphs_a_17_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_18_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_19_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_20_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_21_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_22_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_23_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_24_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_25_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_26_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_27_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_28_mux_set( 0 );
			// alsaqr_periph_padframe_periphs_a_29_mux_set( 0 );
			// break;
			// case 1:
			// alsaqr_periph_padframe_periphs_a_00_mux_set( 2 );  

			alsaqr_periph_padframe_periphs_b_23_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_24_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_25_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_26_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_27_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_28_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_29_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_30_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_31_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_32_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_33_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_34_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_35_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_36_mux_set( 0 );
			alsaqr_periph_padframe_periphs_b_37_mux_set( 0 );
			alsaqr_periph_padframe_periphs_a_15_mux_set( 1 );
			alsaqr_periph_padframe_periphs_a_16_mux_set( 1 );
			alsaqr_periph_padframe_periphs_a_17_mux_set( 1 );
			alsaqr_periph_padframe_periphs_a_18_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_19_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_20_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_21_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_22_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_23_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_24_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_25_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_26_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_27_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_28_mux_set( 2 );
			alsaqr_periph_padframe_periphs_a_29_mux_set( 1 );
	// 		break;
	// 		}
	// 		#endif    
	// 	 #endif
	// }

    
  uint64_t data_to_write[8] = {
        0x1032207098001032, 
        0x3210E20020709800,
        0x1716151413121110, 
        0x2726252423222120,
        0x3736353433323130, 
        0x4746454443424140,
        0x5756555453525150, 
        0x6766656463626160
    };
 
  // load data into L2 
  for (int i = 0; i < 8; ++i) {
    
        volatile uint64_t *tx_addr = (volatile uint64_t*)(0x1C001000 + i * sizeof(uint64_t));
        *tx_addr = data_to_write[i];
  }
  

  *(volatile uint32_t *)(ETH_BASE + MACLO_OFFSET)  = 0x98001032;  
  *(volatile uint32_t *)(ETH_BASE + MACHI_OFFSET) = 0x00012070;  

  *(volatile uint32_t *)(ETH_BASE + IDMA_SRC_ADDR_OFFSET)= 0x1C001000; 
  *(volatile uint32_t *)(ETH_BASE + IDMA_DST_ADDR_OFFSET)= 0x0;
  *(volatile uint32_t *)(ETH_BASE + IDMA_LENGTH_OFFSET) = 0x40;
  *(volatile uint32_t *)(ETH_BASE + IDMA_SRC_PROTO_OFFSET) = 0x0;
  *(volatile uint32_t *)(ETH_BASE + IDMA_DST_PROTO_OFFSET) = 0x5;


  // // config ethernet
  //  pulp_write32( ETH_BASE + MACLO_OFFSET , 0x98001032 );
  //  pulp_write32( ETH_BASE + MACHI_OFFSET , 0x00012070 );

  // //config idma
  //  pulp_write32( ETH_BASE + IDMA_SRC_ADDR_OFFSET , 0x1C001000 ); // src addr
  //  pulp_write32( ETH_BASE + IDMA_DST_ADDR_OFFSET , 0x0 ); 
  //  pulp_write32( ETH_BASE + IDMA_LENGTH_OFFSET ,   0x40);
  //  pulp_write32( ETH_BASE + IDMA_SRC_PROTO_OFFSET , 0x0);
  //  pulp_write32( ETH_BASE + IDMA_DST_PROTO_OFFSET , 0x5);

   // req 
  uint32_t status =0;

  do {
    status = pulp_read32(0x3000003c);;
    barrier();
	} while (status == 0);
   
  pulp_write32( ETH_BASE + IDMA_REQ_VALID_OFFSET ,   0x1);

  pulp_write32( ETH_BASE + IDMA_REQ_VALID_OFFSET ,   0x0);
  
   // data
   pulp_write32( ETH_BASE + IDMA_RSP_READY_OFFSET , 0x1);
  
   // to-do deassert rsp_ready when rx transaction is complete
    while(1);


}

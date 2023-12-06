#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include "utils.h"

   
#define DRIVER_NAME     "alsaqr-eth"
#define BUFFER_SIZE      8
#define WORD_SIZE        8
#define N_REPS           2
	
#define ETH_BASE 			  		 				 0x30000000
// #define GPIO_PADDIR_0_31_OFFSET      0x0
// #define GPIO_PADEN_0_31_OFFSET       0x4
// rx frame check sequence register(read) and last register(write) 
#define RFCS_OFFSET                  0x0828             
//tx packet length
#define TPLR_OFFSET                  0x0810
// MAC address low 32-bits
#define MACLO_OFFSET                 0x0800
// MAC address high 16-bits and MAC ctrl 
#define MACHI_OFFSET                 0x0808         
// TX buffer
#define TXBUFF_OFFSET                0x1000
// RX buffer
#define RXBUFF_OFFSET                0x4000



  
int main() {
	   
	// uint32_t address;
	// uint32_t val_wr = 0x00000000;
	// uint64_t *tx_buffer = (uint64_t *) ( ETH_BASE + TXBUFF_OFFSET );
	 // uint64_t *rx_buffer = (uint64_t *) ( ETH_BASE + RXBUFF_OFFSET );
		
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

    
  

  //wait_cycles(2);

	// // tests 
	// uint64_t tx_data[8] = {
	// 	0x1032207098001032, // 1 --> 230100890702 2301, mac dest + start of mac source
	// 	0x3210E20020709800, // 2 -->  00890702 002E 0123, end mac source + length + payload
	// 	0x1716151413121110, // payload
	// 	0x2726252423222120,
	// 	0x3736353433323130,
	// 	0x4746454443424140,
	// 	0x5756555453525150,
	// 	0x6766656463626160
 // };
   

	// // write the data array into tx buffer
	// for (int i = 0; i < BUFFER_SIZE; i++) {
	// 	*(tx_buffer + i) = tx_data[i];
	// }


    // Write data to respective addresses
    *(volatile uint64_t *)0x30001000 = 0x1032207098001032;
    *(volatile uint64_t *)0x30001008 = 0x3210E20020709800;
    *(volatile uint64_t *)0x30001010 = 0x1716151413121110;
    *(volatile uint64_t *)0x30001018 = 0x2726252423222120;
    *(volatile uint64_t *)0x30001020 = 0x3736353433323130;
    *(volatile uint64_t *)0x30001028 = 0x4746454443424140;
    *(volatile uint64_t *)0x30001030 = 0x5756555453525150;
    *(volatile uint64_t *)0x30001038 = 0x6766656463626160;


     // asm volatile("": : :"memory");
	pulp_write32( ETH_BASE + TPLR_OFFSET, 0x00000040 );

//  wait_cycles(5);
    //asm volatile("": : :"memory");
  pulp_write32( ETH_BASE + MACLO_OFFSET , 0x00890702 );
//  wait_cycles(1);
   // asm volatile("": : :"memory");
	pulp_write32( ETH_BASE + MACHI_OFFSET , 0x00802301 );
//  wait_cycles(1);
	  //asm volatile("": : :"memory");
	pulp_write32( ETH_BASE + RFCS_OFFSET,   0x00000008 );	
//  wait_cycles(1);

	 while(1);

 
	// //enable GPIO used to sync tx_buffer complete with tb
	// address = ARCHI_GPIO_ADDR + GPIO_PADEN_0_31_OFFSET;
	// val_wr = 1 << 0; //Enable GPIO 0
	// pulp_write32(address, val_wr);
		
	// //Set GPIO direction
	// address = ARCHI_GPIO_ADDR + GPIO_PADDIR_0_31_OFFSET;
	// val_wr = 0 << 0; //Set GPIO 0 direction as IN
	// pulp_write32(address, val_wr);
		

	// // flag polling
	// while(!(pulp_read32(address) & 0x00000001)) {
	// 	asm volatile ("wfi");
	// }	

	// // read from the rx buffer
	// for (int j = 0; j < BUFFER_SIZE; j++) {
	// 	if ( *(rx_buffer + j) == tx_data[j] )
	// 		printf("Test Pass\n");
	// 	else 
	// 		printf("Test Fail\n");
	// }		
}

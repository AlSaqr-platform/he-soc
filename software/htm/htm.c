#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "encoding.h"

  // the base address to which you access the couters is: 0x1A22_A000 upto 0x1A22_AFFF

int main(int argc, char const *argv[]) {

  // write here your test
  #ifdef FPGA_EMULATION                   // Not our case
  int baud_rate = 9600;
  int test_freq = 10000000;
  #else
  set_flls();
  int baud_rate = 115200;
  int test_freq = 100000000;
  #endif
  
  #define HTM_BASE		0x1A230000     
  #define PLIC_CHECK    PLIC_BASE + 0x201004

  // Register offsets
#define HTM_BLOCK_SDR_0_CONTROL_REG_OFFSET 0x0
#define HTM_BLOCK_SDR_0_STATUS_REG_OFFSET 0x4
#define HTM_BLOCK_SDR_0_0_OFFSET 0x8
#define HTM_BLOCK_SDR_0_1_OFFSET 0xc
#define HTM_BLOCK_SDR_0_2_OFFSET 0x10
#define HTM_BLOCK_SDR_0_3_OFFSET 0x14
#define HTM_BLOCK_SDR_0_4_OFFSET 0x18
#define HTM_BLOCK_SDR_0_5_OFFSET 0x1c
#define HTM_BLOCK_SDR_0_6_OFFSET 0x20
#define HTM_BLOCK_SDR_0_7_OFFSET 0x24
#define HTM_BLOCK_SDR_0_8_OFFSET 0x28
#define HTM_BLOCK_SDR_0_9_OFFSET 0x2c
#define HTM_BLOCK_SDR_0_10_OFFSET 0x30
#define HTM_BLOCK_SDR_0_11_OFFSET 0x34
#define HTM_BLOCK_SDR_0_12_OFFSET 0x38
#define HTM_BLOCK_SDR_0_13_OFFSET 0x3c
#define HTM_BLOCK_SDR_0_14_OFFSET 0x40
#define HTM_BLOCK_SDR_0_15_OFFSET 0x44
#define HTM_BLOCK_SDR_0_16_OFFSET 0x48
#define HTM_BLOCK_SDR_0_17_OFFSET 0x4c
#define HTM_BLOCK_SDR_0_18_OFFSET 0x50
#define HTM_BLOCK_SDR_0_19_OFFSET 0x54
#define HTM_BLOCK_SDR_0_20_OFFSET 0x58
#define HTM_BLOCK_SDR_0_21_OFFSET 0x5c
#define HTM_BLOCK_SDR_0_22_OFFSET 0x60
#define HTM_BLOCK_SDR_0_23_OFFSET 0x64
#define HTM_BLOCK_SDR_0_24_OFFSET 0x68
#define HTM_BLOCK_SDR_0_25_OFFSET 0x6c
#define HTM_BLOCK_SDR_0_26_OFFSET 0x70
#define HTM_BLOCK_SDR_0_27_OFFSET 0x74
#define HTM_BLOCK_SDR_0_28_OFFSET 0x78
#define HTM_BLOCK_SDR_0_29_OFFSET 0x7c
#define HTM_BLOCK_SDR_0_30_OFFSET 0x80
#define HTM_BLOCK_SDR_0_31_OFFSET 0x84
#define HTM_BLOCK_SDR_0_INDEX_0_OFFSET 0x88
#define HTM_BLOCK_SDR_0_INDEX_1_OFFSET 0x8c
#define HTM_BLOCK_SDR_0_INDEX_2_OFFSET 0x90
#define HTM_BLOCK_SDR_0_INDEX_3_OFFSET 0x94
#define HTM_BLOCK_SDR_0_INDEX_4_OFFSET 0x98
#define HTM_BLOCK_SDR_0_INDEX_5_OFFSET 0x9c
#define HTM_BLOCK_SDR_0_INDEX_6_OFFSET 0xa0
#define HTM_BLOCK_SDR_0_INDEX_7_OFFSET 0xa4
#define HTM_BLOCK_SDR_0_INDEX_8_OFFSET 0xa8
#define HTM_BLOCK_SDR_0_INDEX_9_OFFSET 0xac
#define HTM_BLOCK_SDR_0_INDEX_10_OFFSET 0xb0
#define HTM_BLOCK_SDR_0_INDEX_11_OFFSET 0xb4
#define HTM_BLOCK_SDR_0_INDEX_12_OFFSET 0xb8
#define HTM_BLOCK_SDR_0_INDEX_13_OFFSET 0xbc
#define HTM_BLOCK_SDR_0_INDEX_14_OFFSET 0xc0
#define HTM_BLOCK_SDR_0_INDEX_15_OFFSET 0xc4
 
#define HTM_BLOCK_SDR_1_CONTROL_REG_OFFSET 0xc8
#define HTM_BLOCK_SDR_1_STATUS_REG_OFFSET 0xcc
#define HTM_BLOCK_SDR_1_0_OFFSET 0xd0
#define HTM_BLOCK_SDR_1_1_OFFSET 0xd4
#define HTM_BLOCK_SDR_1_2_OFFSET 0xd8
#define HTM_BLOCK_SDR_1_3_OFFSET 0xdc
#define HTM_BLOCK_SDR_1_4_OFFSET 0xe0
#define HTM_BLOCK_SDR_1_5_OFFSET 0xe4
#define HTM_BLOCK_SDR_1_6_OFFSET 0xe8
#define HTM_BLOCK_SDR_1_7_OFFSET 0xec
#define HTM_BLOCK_SDR_1_8_OFFSET 0xf0
#define HTM_BLOCK_SDR_1_9_OFFSET 0xf4
#define HTM_BLOCK_SDR_1_10_OFFSET 0xf8
#define HTM_BLOCK_SDR_1_11_OFFSET 0xfc
#define HTM_BLOCK_SDR_1_12_OFFSET 0x100
#define HTM_BLOCK_SDR_1_13_OFFSET 0x104
#define HTM_BLOCK_SDR_1_14_OFFSET 0x108
#define HTM_BLOCK_SDR_1_15_OFFSET 0x10c
#define HTM_BLOCK_SDR_1_16_OFFSET 0x110
#define HTM_BLOCK_SDR_1_17_OFFSET 0x114
#define HTM_BLOCK_SDR_1_18_OFFSET 0x118
#define HTM_BLOCK_SDR_1_19_OFFSET 0x11c
#define HTM_BLOCK_SDR_1_20_OFFSET 0x120
#define HTM_BLOCK_SDR_1_21_OFFSET 0x124
#define HTM_BLOCK_SDR_1_22_OFFSET 0x128
#define HTM_BLOCK_SDR_1_23_OFFSET 0x12c
#define HTM_BLOCK_SDR_1_24_OFFSET 0x130
#define HTM_BLOCK_SDR_1_25_OFFSET 0x134
#define HTM_BLOCK_SDR_1_26_OFFSET 0x138
#define HTM_BLOCK_SDR_1_27_OFFSET 0x13c
#define HTM_BLOCK_SDR_1_28_OFFSET 0x140
#define HTM_BLOCK_SDR_1_29_OFFSET 0x144
#define HTM_BLOCK_SDR_1_30_OFFSET 0x148
#define HTM_BLOCK_SDR_1_31_OFFSET 0x14c
#define HTM_BLOCK_SDR_1_INDEX_0_OFFSET 0x150
#define HTM_BLOCK_SDR_1_INDEX_1_OFFSET 0x154
#define HTM_BLOCK_SDR_1_INDEX_2_OFFSET 0x158
#define HTM_BLOCK_SDR_1_INDEX_3_OFFSET 0x15c
#define HTM_BLOCK_SDR_1_INDEX_4_OFFSET 0x160
#define HTM_BLOCK_SDR_1_INDEX_5_OFFSET 0x164
#define HTM_BLOCK_SDR_1_INDEX_6_OFFSET 0x168
#define HTM_BLOCK_SDR_1_INDEX_7_OFFSET 0x16c
#define HTM_BLOCK_SDR_1_INDEX_8_OFFSET 0x170
#define HTM_BLOCK_SDR_1_INDEX_9_OFFSET 0x174
#define HTM_BLOCK_SDR_1_INDEX_10_OFFSET 0x178
#define HTM_BLOCK_SDR_1_INDEX_11_OFFSET 0x17c
#define HTM_BLOCK_SDR_1_INDEX_12_OFFSET 0x180
#define HTM_BLOCK_SDR_1_INDEX_13_OFFSET 0x184
#define HTM_BLOCK_SDR_1_INDEX_14_OFFSET 0x188
#define HTM_BLOCK_SDR_1_INDEX_15_OFFSET 0x18c

#define HTM_BLOCK_SDR_2_CONTROL_REG_OFFSET 0x190
#define HTM_BLOCK_SDR_2_STATUS_REG_OFFSET 0x194
#define HTM_BLOCK_SDR_2_0_OFFSET 0x198
#define HTM_BLOCK_SDR_2_1_OFFSET 0x19c
#define HTM_BLOCK_SDR_2_2_OFFSET 0x1a0
#define HTM_BLOCK_SDR_2_3_OFFSET 0x1a4
#define HTM_BLOCK_SDR_2_4_OFFSET 0x1a8
#define HTM_BLOCK_SDR_2_5_OFFSET 0x1ac
#define HTM_BLOCK_SDR_2_6_OFFSET 0x1b0
#define HTM_BLOCK_SDR_2_7_OFFSET 0x1b4
#define HTM_BLOCK_SDR_2_8_OFFSET 0x1b8
#define HTM_BLOCK_SDR_2_9_OFFSET 0x1bc
#define HTM_BLOCK_SDR_2_10_OFFSET 0x1c0
#define HTM_BLOCK_SDR_2_11_OFFSET 0x1c4
#define HTM_BLOCK_SDR_2_12_OFFSET 0x1c8
#define HTM_BLOCK_SDR_2_13_OFFSET 0x1cc
#define HTM_BLOCK_SDR_2_14_OFFSET 0x1d0
#define HTM_BLOCK_SDR_2_15_OFFSET 0x1d4
#define HTM_BLOCK_SDR_2_16_OFFSET 0x1d8
#define HTM_BLOCK_SDR_2_17_OFFSET 0x1dc
#define HTM_BLOCK_SDR_2_18_OFFSET 0x1e0
#define HTM_BLOCK_SDR_2_19_OFFSET 0x1e4
#define HTM_BLOCK_SDR_2_20_OFFSET 0x1e8
#define HTM_BLOCK_SDR_2_21_OFFSET 0x1ec
#define HTM_BLOCK_SDR_2_22_OFFSET 0x1f0
#define HTM_BLOCK_SDR_2_23_OFFSET 0x1f4
#define HTM_BLOCK_SDR_2_24_OFFSET 0x1f8
#define HTM_BLOCK_SDR_2_25_OFFSET 0x1fc
#define HTM_BLOCK_SDR_2_26_OFFSET 0x200
#define HTM_BLOCK_SDR_2_27_OFFSET 0x204
#define HTM_BLOCK_SDR_2_28_OFFSET 0x208
#define HTM_BLOCK_SDR_2_29_OFFSET 0x20c
#define HTM_BLOCK_SDR_2_30_OFFSET 0x210
#define HTM_BLOCK_SDR_2_31_OFFSET 0x214
#define HTM_BLOCK_SDR_2_INDEX_0_OFFSET 0x218
#define HTM_BLOCK_SDR_2_INDEX_1_OFFSET 0x21c
#define HTM_BLOCK_SDR_2_INDEX_2_OFFSET 0x220
#define HTM_BLOCK_SDR_2_INDEX_3_OFFSET 0x224
#define HTM_BLOCK_SDR_2_INDEX_4_OFFSET 0x228
#define HTM_BLOCK_SDR_2_INDEX_5_OFFSET 0x22c
#define HTM_BLOCK_SDR_2_INDEX_6_OFFSET 0x230
#define HTM_BLOCK_SDR_2_INDEX_7_OFFSET 0x234
#define HTM_BLOCK_SDR_2_INDEX_8_OFFSET 0x238
#define HTM_BLOCK_SDR_2_INDEX_9_OFFSET 0x23c
#define HTM_BLOCK_SDR_2_INDEX_10_OFFSET 0x240
#define HTM_BLOCK_SDR_2_INDEX_11_OFFSET 0x244
#define HTM_BLOCK_SDR_2_INDEX_12_OFFSET 0x248
#define HTM_BLOCK_SDR_2_INDEX_13_OFFSET 0x24c
#define HTM_BLOCK_SDR_2_INDEX_14_OFFSET 0x250
#define HTM_BLOCK_SDR_2_INDEX_15_OFFSET 0x254

#define HTM_BLOCK_SDR_3_CONTROL_REG_OFFSET 0x258
#define HTM_BLOCK_SDR_3_STATUS_REG_OFFSET 0x25c
#define HTM_BLOCK_SDR_3_0_OFFSET 0x260
#define HTM_BLOCK_SDR_3_1_OFFSET 0x264
#define HTM_BLOCK_SDR_3_2_OFFSET 0x268
#define HTM_BLOCK_SDR_3_3_OFFSET 0x26c
#define HTM_BLOCK_SDR_3_4_OFFSET 0x270
#define HTM_BLOCK_SDR_3_5_OFFSET 0x274
#define HTM_BLOCK_SDR_3_6_OFFSET 0x278
#define HTM_BLOCK_SDR_3_7_OFFSET 0x27c
#define HTM_BLOCK_SDR_3_8_OFFSET 0x280
#define HTM_BLOCK_SDR_3_9_OFFSET 0x284
#define HTM_BLOCK_SDR_3_10_OFFSET 0x288
#define HTM_BLOCK_SDR_3_11_OFFSET 0x28c
#define HTM_BLOCK_SDR_3_12_OFFSET 0x290
#define HTM_BLOCK_SDR_3_13_OFFSET 0x294
#define HTM_BLOCK_SDR_3_14_OFFSET 0x298
#define HTM_BLOCK_SDR_3_15_OFFSET 0x29c
#define HTM_BLOCK_SDR_3_16_OFFSET 0x2a0
#define HTM_BLOCK_SDR_3_17_OFFSET 0x2a4
#define HTM_BLOCK_SDR_3_18_OFFSET 0x2a8
#define HTM_BLOCK_SDR_3_19_OFFSET 0x2ac
#define HTM_BLOCK_SDR_3_20_OFFSET 0x2b0
#define HTM_BLOCK_SDR_3_21_OFFSET 0x2b4
#define HTM_BLOCK_SDR_3_22_OFFSET 0x2b8
#define HTM_BLOCK_SDR_3_23_OFFSET 0x2bc
#define HTM_BLOCK_SDR_3_24_OFFSET 0x2c0
#define HTM_BLOCK_SDR_3_25_OFFSET 0x2c4
#define HTM_BLOCK_SDR_3_26_OFFSET 0x2c8
#define HTM_BLOCK_SDR_3_27_OFFSET 0x2cc
#define HTM_BLOCK_SDR_3_28_OFFSET 0x2d0
#define HTM_BLOCK_SDR_3_29_OFFSET 0x2d4
#define HTM_BLOCK_SDR_3_30_OFFSET 0x2d8
#define HTM_BLOCK_SDR_3_31_OFFSET 0x2dc
#define HTM_BLOCK_SDR_3_INDEX_0_OFFSET 0x2e0
#define HTM_BLOCK_SDR_3_INDEX_1_OFFSET 0x2e4
#define HTM_BLOCK_SDR_3_INDEX_2_OFFSET 0x2e8
#define HTM_BLOCK_SDR_3_INDEX_3_OFFSET 0x2ec
#define HTM_BLOCK_SDR_3_INDEX_4_OFFSET 0x2f0
#define HTM_BLOCK_SDR_3_INDEX_5_OFFSET 0x2f4
#define HTM_BLOCK_SDR_3_INDEX_6_OFFSET 0x2f8
#define HTM_BLOCK_SDR_3_INDEX_7_OFFSET 0x2fc
#define HTM_BLOCK_SDR_3_INDEX_8_OFFSET 0x300
#define HTM_BLOCK_SDR_3_INDEX_9_OFFSET 0x304
#define HTM_BLOCK_SDR_3_INDEX_10_OFFSET 0x308
#define HTM_BLOCK_SDR_3_INDEX_11_OFFSET 0x30c
#define HTM_BLOCK_SDR_3_INDEX_12_OFFSET 0x310
#define HTM_BLOCK_SDR_3_INDEX_13_OFFSET 0x314
#define HTM_BLOCK_SDR_3_INDEX_14_OFFSET 0x318
#define HTM_BLOCK_SDR_3_INDEX_15_OFFSET 0x31c



int sdr_reg[3][32]; 
        			 sdr_reg[0][0] = 0x82038208;
        			 sdr_reg[0][1] = 0x74028309;
        			 sdr_reg[0][2] = 0x34518208;
        			 sdr_reg[0][3] = 0x80000000;
        			 sdr_reg[0][4] = 0x0;
        			 sdr_reg[0][5] = 0x0;
        			 sdr_reg[0][6] = 0x0;
        			 sdr_reg[0][7] = 0x0;
        			 sdr_reg[0][8] = 0x0;
        			 sdr_reg[0][9] = 0x0;
        			 sdr_reg[0][10] = 0x0;
        			 sdr_reg[0][11] = 0x0;
        			 sdr_reg[0][12] = 0x0;
        			 sdr_reg[0][13] = 0x0;
        			 sdr_reg[0][14] = 0x0;
        			 sdr_reg[0][15] = 0x0;
        			 sdr_reg[0][16] = 0x0;
        			 sdr_reg[0][17] = 0x0;
        			 sdr_reg[0][18] = 0x0;
        			 sdr_reg[0][19] = 0x0;
        			 sdr_reg[0][20] = 0x0;
        			 sdr_reg[0][21] = 0x0;
        			 sdr_reg[0][22] = 0x0;
        			 sdr_reg[0][23] = 0x0;
        			 sdr_reg[0][24] = 0x0;
        			 sdr_reg[0][25] = 0x0;
        			 sdr_reg[0][26] = 0x0;
        			 sdr_reg[0][27] = 0x0;
        			 sdr_reg[0][28] = 0x0;
        			 sdr_reg[0][29] = 0x0;
        			 sdr_reg[0][30] = 0xC0000003;
        			 sdr_reg[0][31] = 0xE0000000; 		
 

  int a, b, c, d, e;
  int mbox_id = 133;
  int addr;
  int sdr_reg_array_offset[4];
  int sdr_control_reg_array_offset[4];
  int sdr_status_reg_array_offset[4];
  int sdr_index_array_offset[4];
  
	sdr_reg_array_offset[0] = HTM_BLOCK_SDR_0_0_OFFSET;
	sdr_reg_array_offset[1] = HTM_BLOCK_SDR_1_0_OFFSET;
	sdr_reg_array_offset[2] = HTM_BLOCK_SDR_2_0_OFFSET;
	sdr_reg_array_offset[3] = HTM_BLOCK_SDR_3_0_OFFSET;
	
	sdr_control_reg_array_offset[0] = HTM_BLOCK_SDR_0_CONTROL_REG_OFFSET;
	sdr_control_reg_array_offset[1] = HTM_BLOCK_SDR_1_CONTROL_REG_OFFSET;
	sdr_control_reg_array_offset[2] = HTM_BLOCK_SDR_2_CONTROL_REG_OFFSET;
	sdr_control_reg_array_offset[3] = HTM_BLOCK_SDR_3_CONTROL_REG_OFFSET;  

	sdr_status_reg_array_offset[0] =	HTM_BLOCK_SDR_0_STATUS_REG_OFFSET;
	sdr_status_reg_array_offset[1] = 	HTM_BLOCK_SDR_1_STATUS_REG_OFFSET;
	sdr_status_reg_array_offset[2] = 	HTM_BLOCK_SDR_2_STATUS_REG_OFFSET;
	sdr_status_reg_array_offset[3] =	HTM_BLOCK_SDR_3_STATUS_REG_OFFSET;
	
	sdr_index_array_offset[0] = HTM_BLOCK_SDR_0_INDEX_0_OFFSET;
	sdr_index_array_offset[1] = HTM_BLOCK_SDR_1_INDEX_0_OFFSET;
	sdr_index_array_offset[2] = HTM_BLOCK_SDR_2_INDEX_0_OFFSET;
	sdr_index_array_offset[3] = HTM_BLOCK_SDR_3_INDEX_0_OFFSET;	

  
  // Initialazing the uart
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

	printf("SET SDR REGISTERS \r\n");
	for (int y=0;y<=3;y++) {
		for (int i=0;i<32;i++) {
			printf("WRITE SDR_%d REGS %d addr= %x %x  \r\n",y,i, i*4,sdr_reg[0][i]);
			pulp_write32(HTM_BASE+sdr_reg_array_offset[y]+i*4, sdr_reg[0][i]);
		}
	}
	for (int y=0;y<=3;y++) {
			printf("WRITE SDR_ %d CONTROL_REG   %x  \r\n",y,0x00000001);
			pulp_write32(HTM_BASE+sdr_control_reg_array_offset[y], 0x1);
	}
    for (int y=0;y<=3;y++) {
		printf(" **************** READ SDR_%d STATUS REGISTER ************************   \r\n",y);
		while (!(pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]) & 0x80000000)) {
			a = pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]);
			printf(" **************** READING SDR_%d STATUS REGISTER %x ************************   \r\n",y,a);
		}
		a = pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]);
		printf("READ SDR_%d STATUS REGISTER  %x  \r\n",y,a);
	}

	for (int y=0;y<=3;y++) {
		for (int i=0;i<16;i++) {
			addr = HTM_BASE+sdr_index_array_offset[y] + i*4;
			a = pulp_read32(addr);
			printf("READ SDR_%d INDEXES REG %d addr= %x %x  \r\n",y,i, addr, a);
		}
	}


        			 sdr_reg[1][0] = 0x0F027850;
        			 sdr_reg[1][1] = 0x18241000;
        			 sdr_reg[1][2] = 0x11101110;
        			 sdr_reg[1][3] = 0x00000100;
        			 sdr_reg[1][4] = 0x1;
        			 sdr_reg[1][5] = 0x0;
        			 sdr_reg[1][6] = 0x0;
        			 sdr_reg[1][7] = 0x0;
        			 sdr_reg[1][8] = 0x0;
        			 sdr_reg[1][9] = 0x0;
        			 sdr_reg[1][10] = 0x0;
        			 sdr_reg[1][11] = 0x0;
        			 sdr_reg[1][12] = 0x0;
        			 sdr_reg[1][13] = 0x0;
        			 sdr_reg[1][14] = 0x0;
        			 sdr_reg[1][15] = 0x0;
        			 sdr_reg[1][16] = 0x0;
        			 sdr_reg[1][17] = 0x0;
        			 sdr_reg[1][18] = 0x0;
        			 sdr_reg[1][19] = 0x0;
        			 sdr_reg[1][20] = 0x0;
        			 sdr_reg[1][21] = 0x0;
        			 sdr_reg[1][22] = 0x0;
        			 sdr_reg[1][23] = 0x0;
        			 sdr_reg[1][24] = 0x0;
        			 sdr_reg[1][25] = 0x0;
        			 sdr_reg[1][26] = 0x0;
        			 sdr_reg[1][27] = 0x0;
        			 sdr_reg[1][28] = 0x0;
        			 sdr_reg[1][29] = 0x0;
        			 sdr_reg[1][30] = 0x0;
        			 sdr_reg[1][31] = 0x10000000; 

	for (int y=0;y<=3;y++) {
		for (int i=0;i<32;i++) {
			printf("WRITE SDR_%d REGS %d addr= %x %x  \r\n",y,i, i*4,sdr_reg[1][i]);
			pulp_write32(HTM_BASE+sdr_reg_array_offset[y]+i*4, sdr_reg[1][i]);
		}
	}
	for (int y=0;y<=3;y++) {
			printf("WRITE SDR_ %d CONTROL_REG   %x  \r\n",y,0x00000001);
			pulp_write32(HTM_BASE+sdr_control_reg_array_offset[y], 0x1);
	}
    for (int y=0;y<=3;y++) {
		printf(" **************** READ SDR_%d STATUS REGISTER ************************   \r\n",y);
		while (!(pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]) & 0x80000000)) {
			a = pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]);
			printf(" **************** READING SDR_%d STATUS REGISTER %x ************************   \r\n",y,a);
		}
		a = pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]);
		printf("READ SDR_%d STATUS REGISTER  %x  \r\n",y,a);
	}

	for (int y=0;y<=3;y++) {
		for (int i=0;i<16;i++) {
			addr = HTM_BASE+sdr_index_array_offset[y] + i*4;
			a = pulp_read32(addr);
			printf("READ SDR_%d INDEXES REG %d addr= %x %x  \r\n",y,i, addr, a);
		}
	}

        			 sdr_reg[2][0] = 0xA7F31650;
        			 sdr_reg[2][1] = 0x740289A0;
        			 sdr_reg[2][2] = 0x82528201;
        			 sdr_reg[2][3] = 0x80000000;
        			 sdr_reg[2][4] = 0x1;
        			 sdr_reg[2][5] = 0x0;
        			 sdr_reg[2][6] = 0x0;
        			 sdr_reg[2][7] = 0x0;
        			 sdr_reg[2][8] = 0x0;
        			 sdr_reg[2][9] = 0x0;
        			 sdr_reg[2][10] = 0x0;
        			 sdr_reg[2][11] = 0x0;
        			 sdr_reg[2][12] = 0x0;
        			 sdr_reg[2][13] = 0x0;
        			 sdr_reg[2][14] = 0x0;
        			 sdr_reg[2][15] = 0x0;
        			 sdr_reg[2][16] = 0x0;
        			 sdr_reg[2][17] = 0x0;
        			 sdr_reg[2][18] = 0x0;
        			 sdr_reg[2][19] = 0x0;
        			 sdr_reg[2][20] = 0x0;
        			 sdr_reg[2][21] = 0x0;
        			 sdr_reg[2][22] = 0x0;
        			 sdr_reg[2][23] = 0x0;
        			 sdr_reg[2][24] = 0x0;
        			 sdr_reg[2][25] = 0x0;
        			 sdr_reg[2][26] = 0x0;
        			 sdr_reg[2][27] = 0x0;
        			 sdr_reg[2][28] = 0x0;
        			 sdr_reg[2][29] = 0xFF;
        			 sdr_reg[2][30] = 0xC0000003;
        			 sdr_reg[2][31] = 0xE0000000; 

  printf("SET SDR REGISTERS \r\n");
	for (int y=0;y<=3;y++) {
		for (int i=0;i<32;i++) {
			printf("WRITE SDR_%d REGS %d addr= %x %x  \r\n",y,i, i*4,sdr_reg[2][i]);
			pulp_write32(HTM_BASE+sdr_reg_array_offset[y]+i*4, sdr_reg[2][i]);
		}
	}
	for (int y=0;y<=3;y++) {
			printf("WRITE SDR_ %d CONTROL_REG   %x  \r\n",y,0x00000001);
			pulp_write32(HTM_BASE+sdr_control_reg_array_offset[y], 0x1);
	}
    	for (int y=0;y<=3;y++) {
		printf(" **************** READ SDR_%d STATUS REGISTER ************************   \r\n",y);
		while (!(pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]) & 0x80000000)) {
			a = pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]);
			printf(" **************** READING SDR_%d STATUS REGISTER %x ************************   \r\n",y,a);
		}
		a = pulp_read32(HTM_BASE+sdr_status_reg_array_offset[y]);
		printf("READ SDR_%d STATUS REGISTER  %x  \r\n",y,a);
	}

	for (int y=0;y<=3;y++) {
		for (int i=0;i<16;i++) {
			addr = HTM_BASE+sdr_index_array_offset[y] + i*4;
			a = pulp_read32(addr);
			printf("READ SDR_%d INDEXES REG %d addr= %x %x  \r\n",y,i, addr, a);
		}
	}
printf("CHECK LOGIC OPERATIONS \r\n");
int z;
int control_reg;
z=0;
		for (int i=0;i<32;i++) {
         		printf("WRITE SDR_%d REGS %d addr= %x %x  \r\n",z,i, i*4,sdr_reg[2][i]);
         		pulp_write32(HTM_BASE+sdr_reg_array_offset[z]+i*4, sdr_reg[2][i]);
         		printf("WRITE SDR_%d REGS %d addr= %x %x  \r\n",z+1,i, i*4,sdr_reg[1][i]);
         		pulp_write32(HTM_BASE+sdr_reg_array_offset[z+1]+i*4, sdr_reg[1][i]);
		}
control_reg=0x00001010; 
                        printf("WRITE SDR_LOGICAL_MODULE CONTROL REG  addr= %x %x  \r\n", 0x320,control_reg);
                        pulp_write32(HTM_BASE+0x320, control_reg);
		for (int i=0;i<32;i++) {
			addr = HTM_BASE+0x324 + i*4;
			a = pulp_read32(addr);
			printf("READ SDR_LOGICAL_RESULT_%d REG %d addr= %x %x  \r\n",i, addr, a);
		}

  return 0;
}

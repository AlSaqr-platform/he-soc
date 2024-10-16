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
  /*
  // Register offsets
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_CONTROL_REG_OFFSET = 8'h 0;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_STATUS_REG_OFFSET = 8'h 4;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_0_OFFSET = 8'h 8;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_1_OFFSET = 8'h c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_2_OFFSET = 8'h 10;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_3_OFFSET = 8'h 14;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_4_OFFSET = 8'h 18;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_5_OFFSET = 8'h 1c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_6_OFFSET = 8'h 20;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_7_OFFSET = 8'h 24;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_8_OFFSET = 8'h 28;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_9_OFFSET = 8'h 2c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_10_OFFSET = 8'h 30;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_11_OFFSET = 8'h 34;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_12_OFFSET = 8'h 38;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_13_OFFSET = 8'h 3c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_14_OFFSET = 8'h 40;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_15_OFFSET = 8'h 44;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_16_OFFSET = 8'h 48;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_17_OFFSET = 8'h 4c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_18_OFFSET = 8'h 50;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_19_OFFSET = 8'h 54;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_20_OFFSET = 8'h 58;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_21_OFFSET = 8'h 5c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_22_OFFSET = 8'h 60;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_23_OFFSET = 8'h 64;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_24_OFFSET = 8'h 68;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_25_OFFSET = 8'h 6c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_26_OFFSET = 8'h 70;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_27_OFFSET = 8'h 74;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_28_OFFSET = 8'h 78;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_29_OFFSET = 8'h 7c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_30_OFFSET = 8'h 80;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_0_31_OFFSET = 8'h 84;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_0_OFFSET = 8'h 88;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_1_OFFSET = 8'h 8c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_2_OFFSET = 8'h 90;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_3_OFFSET = 8'h 94;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_4_OFFSET = 8'h 98;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_5_OFFSET = 8'h 9c;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_6_OFFSET = 8'h a0;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_7_OFFSET = 8'h a4;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_8_OFFSET = 8'h a8;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_9_OFFSET = 8'h ac;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_10_OFFSET = 8'h b0;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_11_OFFSET = 8'h b4;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_12_OFFSET = 8'h b8;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_13_OFFSET = 8'h bc;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_14_OFFSET = 8'h c0;
  parameter logic [BlockAw-1:0] HTM_BLOCK_SDR_INDEX_0_15_OFFSET = 8'h c4;
  */

        int sdr_reg[32] ={ 	 0x82038208,
        			 0x74028309,
        			 0x34518208,
        			 0x80000000,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0x0,
        			 0xC0000003,
        			 0xE0000000 
			};


  

  int a, b, c, d, e;
  int mbox_id = 133;
  int addr;

  // Initialazing the uart
  uart_set_cfg(0,(test_freq/baud_rate)>>4);

  printf("SET SDR REGISTERS \r\n");
  for (int i=0;i<32;i++) {
  	printf("WRITE SDR REG %d addr= %x %x  \r\n",i, i*4,sdr_reg[i]);
        pulp_write32(HTM_BASE+0x8+i*4, sdr_reg[i]);
  }
  printf("WRITE CONTROL_REG   %x  \r\n",0x00000001);
  pulp_write32(HTM_BASE+0x0, 0x1);

  printf(" **************** READ STATUS REGISTER ************************   \r\n");
  a = pulp_read32(HTM_BASE+0x4);
  printf("READ STATUS REGISTER  %x  \r\n",a);

  for (int i=0;i<16;i++) {
	addr = HTM_BASE+0x88 + i*4;
  	a = pulp_read32(addr);
        printf("READ INDEXES REG %d addr= %x %x  \r\n",i, addr, a);
  }


        			 sdr_reg[0] = 0x0F027850;
        			 sdr_reg[1] = 0x18241000;
        			 sdr_reg[2] = 0x11101110;
        			 sdr_reg[3] = 0x00000100;
        			 sdr_reg[4] = 0x1;
        			 sdr_reg[5] = 0x0;
        			 sdr_reg[6] = 0x0;
        			 sdr_reg[7] = 0x0;
        			 sdr_reg[8] = 0x0;
        			 sdr_reg[9] = 0x0;
        			 sdr_reg[10] = 0x0;
        			 sdr_reg[11] = 0x0;
        			 sdr_reg[12] = 0x0;
        			 sdr_reg[13] = 0x0;
        			 sdr_reg[14] = 0x0;
        			 sdr_reg[15] = 0x0;
        			 sdr_reg[16] = 0x0;
        			 sdr_reg[17] = 0x0;
        			 sdr_reg[18] = 0x0;
        			 sdr_reg[19] = 0x0;
        			 sdr_reg[20] = 0x0;
        			 sdr_reg[21] = 0x0;
        			 sdr_reg[22] = 0x0;
        			 sdr_reg[23] = 0x0;
        			 sdr_reg[24] = 0x0;
        			 sdr_reg[25] = 0x0;
        			 sdr_reg[26] = 0x0;
        			 sdr_reg[27] = 0x0;
        			 sdr_reg[28] = 0x0;
        			 sdr_reg[29] = 0x0;
        			 sdr_reg[30] = 0x0;
        			 sdr_reg[31] = 0x10000000; 

  printf("SET SDR REGISTERS \r\n");
  for (int i=0;i<32;i++) {
  	printf("WRITE SDR REG %d addr= %x %x  \r\n",i, i*4,sdr_reg[i]);
        pulp_write32(HTM_BASE+0x8+i*4, sdr_reg[i]);
  }
  printf("WRITE CONTROL_REG   %x  \r\n",0x00000001);
  pulp_write32(HTM_BASE+0x0, 0x1);

  printf(" **************** READ STATUS REGISTER ************************   \r\n");
  a = pulp_read32(HTM_BASE+0x4);
  printf("READ STATUS REGISTER %x  \r\n",a);

  for (int i=0;i<16;i++) {
	addr = HTM_BASE+0x88 + i*4;
  	a = pulp_read32(addr);
        printf("READ INDEXES REG %d addr= %x %x  \r\n",i, addr, a);
  }

        			 sdr_reg[0] = 0xA7F31650;
        			 sdr_reg[1] = 0x740289A0;
        			 sdr_reg[2] = 0x82528201;
        			 sdr_reg[3] = 0x80000000;
        			 sdr_reg[4] = 0x1;
        			 sdr_reg[5] = 0x0;
        			 sdr_reg[6] = 0x0;
        			 sdr_reg[7] = 0x0;
        			 sdr_reg[8] = 0x0;
        			 sdr_reg[9] = 0x0;
        			 sdr_reg[10] = 0x0;
        			 sdr_reg[11] = 0x0;
        			 sdr_reg[12] = 0x0;
        			 sdr_reg[13] = 0x0;
        			 sdr_reg[14] = 0x0;
        			 sdr_reg[15] = 0x0;
        			 sdr_reg[16] = 0x0;
        			 sdr_reg[17] = 0x0;
        			 sdr_reg[18] = 0x0;
        			 sdr_reg[19] = 0x0;
        			 sdr_reg[20] = 0x0;
        			 sdr_reg[21] = 0x0;
        			 sdr_reg[22] = 0x0;
        			 sdr_reg[23] = 0x0;
        			 sdr_reg[24] = 0x0;
        			 sdr_reg[25] = 0x0;
        			 sdr_reg[26] = 0x0;
        			 sdr_reg[27] = 0x0;
        			 sdr_reg[28] = 0x0;
        			 sdr_reg[29] = 0xFF;
        			 sdr_reg[30] = 0xC0000003;
        			 sdr_reg[31] = 0xE0000000; 

  printf("SET SDR REGISTERS \r\n");
  for (int i=0;i<32;i++) {
  	printf("WRITE SDR REG %d addr= %x %x  \r\n",i, i*4,sdr_reg[i]);
        pulp_write32(HTM_BASE+0x8+i*4, sdr_reg[i]);
  }
  printf("WRITE CONTROL_REG   %x  \r\n",0x00000001);
  pulp_write32(HTM_BASE+0x0, 0x1);

  printf(" **************** READ STATUS REGISTER ************************   \r\n");
  a = pulp_read32(HTM_BASE+0x4);
  printf("READ STATUS REGISTER %x  \r\n",a);

  for (int i=0;i<16;i++) {
	addr = HTM_BASE+0x88 + i*4;
  	a = pulp_read32(addr);
        printf("READ INDEXES REG %d addr= %x %x  \r\n",i, addr, a);
  }

  return 0;
}

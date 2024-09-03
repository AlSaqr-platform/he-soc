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
  
  #define PERFMONITOR_BASE     0x1A22A000
  #define PLIC_CHECK    PLIC_BASE + 0x201004
  /*
  // Register offsets
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_REG_OFFSET = 6'h 0;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENTS_COUNTERS_MUX_REG_OFFSET = 6'h 4;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_COUNTERS_RST_REG_OFFSET = 6'h 8;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_COUNTER3_REG_OFFSET = 6'h c;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_COUNTER2_REG_OFFSET = 6'h 10;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_COUNTER1_REG_OFFSET = 6'h 14;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_COUNTER0_REG_OFFSET = 6'h 18;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_CLK_COUNTER3_REG_OFFSET = 6'h 1c;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_CLK_COUNTER2_REG_OFFSET = 6'h 20;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_CLK_COUNTER1_REG_OFFSET = 6'h 24;
  parameter logic [BlockAw-1:0] PERFCOUNTERS_T_EVENT_CLK_COUNTER0_REG_OFFSET = 6'h 28;
  */
  

  int a, b, c, d, e;
  int mbox_id = 133;

  // Initialazing the uart
  uart_set_cfg(0,(test_freq/baud_rate)>>4);
/*
  11:9	events_counter3_mux
i  8:6	events_counter2_mux
   5:3	events_counter1_mux
   2:0	events_counter0_mux
 */
  // *** EVENT COUNTERS ****
  printf("EVENT1 to COUNTER2 EVENT2 to COUNTER0 MUX \r\n");
  // 000 001 000 010
  pulp_write32(PERFMONITOR_BASE+0x4, 0x42);

  printf("EVENT 2 to write \r\n");
  for (int i=0;i<256;i++) {
        pulp_write32(PERFMONITOR_BASE+0x0, 0x4);
  }
  printf("EVENT COUNTERS RESET  \r\n");
  pulp_write32(PERFMONITOR_BASE+0x8, 0xFF);

  printf("EVENT 2 to write \r\n");
  for (int i=0;i<331;i++) {
        pulp_write32(PERFMONITOR_BASE+0x0, 0x4);
  }

  printf("EVENT 1 to write \r\n");
  for (int i=0;i<35;i++) {
        pulp_write32(PERFMONITOR_BASE+0x0, 0x2);
  }

  printf("EVENT 2 to READ \r\n");
  a = pulp_read32(PERFMONITOR_BASE+0xc);
  printf("EVENT COUNTER3_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x10);
  printf("EVENT COUNTER2_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x14);
  printf("EVENT COUNTER1_REG READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x18);
  printf("EVENT COUNTER0_REG READ %x  \r\n",a);

  // *** EVENT CLK COUNTERS ****
  //
  printf("EVENT CLK COUNTER3-2 RESET  \r\n");
  pulp_write32(PERFMONITOR_BASE+0x8, 0xA0);

  printf("EVENT CLK COUNTERS  READ \r\n");
  a = pulp_read32(PERFMONITOR_BASE+0x1C);
  printf("EVENT CLK_COUNTER3_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x20);
  printf("EVENT CLK_COUNTER2_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x24);
  printf("EVENT CLK_COUNTER1_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x28);
  printf("EVENT CLK_COUNTER0_REG  READ %x  \r\n",a);

  // *** EVENT COUNTERS ****
  printf("EVENT7 to COUNTER3 EVENT3 to COUNTER2 MUX \r\n");
  // 111 011 000 000
  pulp_write32(PERFMONITOR_BASE+0x4, 0xEC0);

  printf("EVENT 7 to write \r\n");
  for (int i=0;i<256;i++) {
        pulp_write32(PERFMONITOR_BASE+0x0, 0x80);
  }
  printf("EVENT COUNTERS RESET  \r\n");
  pulp_write32(PERFMONITOR_BASE+0x8, 0xFF);

  printf("EVENT 7 to write \r\n");
  for (int i=0;i<331;i++) {
        pulp_write32(PERFMONITOR_BASE+0x0, 0x80);
  }

  printf("EVENT 3 to write \r\n");
  for (int i=0;i<50;i++) {
        pulp_write32(PERFMONITOR_BASE+0x0, 0x8);
  }

  a = pulp_read32(PERFMONITOR_BASE+0xC);
  printf("EVENT COUNTER3_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x10);
  printf("EVENT COUNTER2_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x14);
  printf("EVENT COUNTER1_REG READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x18);
  printf("EVENT COUNTER0_REG READ %x  \r\n",a);


  // *** EVENT CLK COUNTERS ****
  //
  printf("EVENT CLK COUNTER2- RESET  \r\n");
  pulp_write32(PERFMONITOR_BASE+0x8, 0x20);
  printf("EVENT CLK COUNTERS  READ \r\n");

  a = pulp_read32(PERFMONITOR_BASE+0x1C);
  printf("EVENT CLK_COUNTER3_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x20);
  printf("EVENT CLK_COUNTER2_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x24);
  printf("EVENT CLK_COUNTER1_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x28);
  printf("EVENT CLK_COUNTER0_REG  READ %x  \r\n",a);


  printf("EVENT CLK COUNTER0- RESET  \r\n");
  pulp_write32(PERFMONITOR_BASE+0x8, 0x02);
  printf("EVENT CLK COUNTERS  READ \r\n");

  a = pulp_read32(PERFMONITOR_BASE+0x1C);
  printf("EVENT CLK_COUNTER3_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x20);
  printf("EVENT CLK_COUNTER2_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x24);
  printf("EVENT CLK_COUNTER1_REG  READ %x  \r\n",a);
  a = pulp_read32(PERFMONITOR_BASE+0x28);
  printf("EVENT CLK_COUNTER0_REG  READ %x  \r\n",a);

  return 0;
}

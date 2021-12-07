#include "./drivers/src/uart.c"
#include "./string_lib/src/string_lib.c"

#define pulp_write32(add, val_) (*(volatile unsigned int *)(long)(add) = val_)
#define pulp_read32(add) (*(volatile unsigned int *)(long)(add))

static inline void barrier() {
    __sync_synchronize();
}

void uart_sim_cfg() {
    int baud_rate = 115200;
    int test_freq = 50000000; 
    uart_set_cfg(0,(test_freq/baud_rate)/16);
}

void set_flls() {
  int data;
  int addr;

  // set up fll 0 to output 200MHz
  addr = 0x1A100010;
  data = 0x25C350;
  pulp_write32(addr, data);

  // enable fll 0 
  addr = 0x1A100030;
  data = 0x11;
  pulp_write32(addr, data);
  
  // put fll 0 to open loop
  addr = 0x1A10000C;
  data = 0x40030A73;
  pulp_write32(addr, data);
   
  // put ffl output clock to every clock 
  addr = 0x1A100030;
  data = 0x1111;
  pulp_write32(addr, data);

}

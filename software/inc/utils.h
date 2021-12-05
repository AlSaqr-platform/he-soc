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

  // set clk_div to 2 for clk[2:0]
  addr = 0x1A10002C;
  data = 0x00020202;
  pulp_write32(addr, data);

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

void h2c_tlb_cfg () {
  pulp_write32(0x50000000, 0x00000000); // First virtual address ->
  pulp_write32(0x50000004, 0x80000000); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(0x50000008, 0xFFFFFFFF); // Last virtual address ->
  pulp_write32(0x5000000C, 0xFFFFFFFF); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(0x50000010, 0x00000000); // Physical base address
  pulp_write32(0x50000014, 0x00000000); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(0x50000018, 0x00000007); // Flags
}

// Cluster to Host TLB config (mapped at 0x0000_0000_5000_1000)
void c2h_tlb_cfg () {
  pulp_write32(0x50001000, 0x80000000); // First virtual address ->
  pulp_write32(0x50001004, 0x00000000); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(0x50001008, 0xFFFFFFFF); // Last virtual address ->
  pulp_write32(0x5000100C, 0xFFFFFFFF); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(0x50001010, 0x10000000); // Physical base address
  pulp_write32(0x50001014, 0x00000000); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(0x50001018, 0x00000007); // Flags
}

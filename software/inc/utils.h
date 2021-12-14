#include "./drivers/src/uart.c"
#include "./string_lib/src/string_lib.c"
#include "./archi_tlb/archi_tlb.h"

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

void tlb_cfg ( uint32_t tlb_addr,
               uint64_t first_va,
               uint64_t last_va ,
               uint64_t base_pa ,
               uint8_t  flags
             ) {
  pulp_write32(tlb_addr + FIRST_VA_LSW, ((first_va & 0xFFFFFFFF00000000)  >> 32 )); // First virtual address ->
  pulp_write32(tlb_addr + FIRST_VA_MSW, ((first_va & 0x00000000FFFFFFFF)        )); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(tlb_addr + LAST_VA_LSW , ((last_va  & 0xFFFFFFFF00000000)  >> 32 )); // Last virtual address ->
  pulp_write32(tlb_addr + LAST_VA_MSW , ((last_va  & 0x00000000FFFFFFFF)        )); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(tlb_addr + BASE_PA_LSW , ((base_pa  & 0xFFFFFFFF00000000)  >> 32 )); // Physical base address
  pulp_write32(tlb_addr + BASE_PA_MSW , ((base_pa  & 0x00000000FFFFFFFF)        )); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(tlb_addr + FLAGS       , flags                                    ); // Flags
}

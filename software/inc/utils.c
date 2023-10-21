#include "utils.h"

void uart_sim_cfg() {
    int baud_rate = 115200;
    int test_freq = 50000000; 
    uart_set_cfg(0,(test_freq/baud_rate)/16);
}

static uint64_t lfsr(uint64_t x)
{
  uint64_t bit = (x ^ (x >> 1)) & 1;
  return (x >> 1) | (bit << 62);
}

void set_flls() {
  #ifdef FLL_DRIVER
  unsigned int freq_all = 200 * 1000000; 
  pi_fll_init_all();
  * ( ( int * ) 0x1a100030 ) = 0x104321;
  pi_freq_set(PI_FREQ_DOMAIN_ALL, freq_all);
  #else
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
  #endif
}

void tlb_cfg ( uint32_t tlb_addr ,
               uint32_t entry_idx,
               uint64_t first_va ,
               uint64_t last_va  ,
               uint64_t base_pa  ,
               uint8_t  flags
             ) {
  uint32_t entry_addr = tlb_addr + (0x1C)*entry_idx;
  pulp_write32(entry_addr + FIRST_VA_LSW, ((first_va & 0xFFFFFFFF00000000)  >> 32 )); // First virtual address ->
  pulp_write32(entry_addr + FIRST_VA_MSW, ((first_va & 0x00000000FFFFFFFF)        )); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(entry_addr + LAST_VA_LSW , ((last_va  & 0xFFFFFFFF00000000)  >> 32 )); // Last virtual address ->
  pulp_write32(entry_addr + LAST_VA_MSW , ((last_va  & 0x00000000FFFFFFFF)        )); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(entry_addr + BASE_PA_LSW , ((base_pa  & 0xFFFFFFFF00000000)  >> 32 )); // Physical base address
  pulp_write32(entry_addr + BASE_PA_MSW , ((base_pa  & 0x00000000FFFFFFFF)        )); // -> Continue if AXI_LITE_DWIDTH < AXI_AWIDTH
  pulp_write32(entry_addr + FLAGS       , flags                                    ); // Flags
}

uint32_t dma_h2c_trnf_cfg( uint64_t src,
                           uint32_t dst,
                           uint32_t dim
                         ) {
  pulp_write32(CL_DMA_BASE + SRC_LOW_OFFS , src        );
  pulp_write32(CL_DMA_BASE + SRC_HIGH_OFFS, (src >> 32));

  pulp_write32(CL_DMA_BASE + DST_LOW_OFFS , dst        );
  pulp_write32(CL_DMA_BASE + DST_HIGH_OFFS, 0x00000000 );
                                                       
  pulp_write32(CL_DMA_BASE + TRNF_LEN_OFFS , dim       );

  // Reading the transfer id starts the DMA transaction
  uint32_t trnf_id = pulp_read32(CL_DMA_BASE + TRNF_ID_OFFS);

  return trnf_id;
}

uint32_t dma_c2h_trnf_cfg( uint32_t src,
                           uint64_t dst,
                           uint32_t dim
                         ) {
  pulp_write32(CL_DMA_BASE + SRC_LOW_OFFS , src        );
  pulp_write32(CL_DMA_BASE + SRC_HIGH_OFFS, 0x00000000 );
                                                       
  pulp_write32(CL_DMA_BASE + DST_LOW_OFFS , dst        );
  pulp_write32(CL_DMA_BASE + DST_HIGH_OFFS, (dst >> 32));

  pulp_write32(CL_DMA_BASE + TRNF_LEN_OFFS , dim       );

  // Reading the transfer id starts the DMA transaction
  uint32_t trnf_id = pulp_read32(CL_DMA_BASE + TRNF_ID_OFFS);

  return trnf_id;
}

void dma_wait_trnf_done (uint32_t trnf_id) {
  while (pulp_read32(CL_DMA_BASE + DONE_ID_OFFS) <= trnf_id);
}

void apb_timer_start() {
  pulp_write32(0x18000000,0);
  pulp_write32(0x18000004,1);
  return;
}

unsigned int apb_timer_get(){
  return pulp_read32(0x18000000);
}

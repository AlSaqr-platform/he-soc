#ifndef __HAL_DMA_H__
#define __HAL_DMA_H__

extern struct descriptor descriptors[10];
extern bool tx_done;

void setup_transfer(uint64_t src, uint64_t dst, uint32_t len, bool do_irq, bool decouple_rw, struct descriptor *desc);
void submit_transfer(struct descriptor *desc);
void wait_for_transfer(volatile struct descriptor *desc);

void setup_interrupts(void);

#endif // __HAL_DMA_H__

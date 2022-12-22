/********************************/
/********** DMA Driver **********/
/********************************/
#include <stdint.h>
#include <stdbool.h>
#include "../archi_dma/archi_dma.h"

struct descriptor descriptors[10] __attribute__((section(".descriptors")));
bool tx_done = false;

void dma_setup_transfer(uint64_t src           ,
                        uint64_t dst           ,
                        uint32_t len           ,
                        bool do_irq            ,
                        bool decouple_rw       ,
                        struct descriptor *desc) {

    // make sure that bools are only one bit
    do_irq       = do_irq ? 1 : 0;
    decouple_rw  = decouple_rw ? 1 : 0;

    desc->length = len;
    desc->next   = ~0;
    desc->src    = src;
    desc->dst    = dst;

    // flags: id: 0xff, cache: 0, deburst: 0, serialize: 1, decouple_rw: 1bit, incr (src/dst): 0101, irq: 1bit
    desc->flags  = 0xff << 16 | (0 << 7) | (1 << 6) | (decouple_rw << 5) | (0x5 << 1) | do_irq;
}

void dma_submit_transfer(struct descriptor *desc) {
    tx_done = false;
    printf("Just before fence\n");
    asm volatile ("fence");
    struct descriptor * volatile* desc_reg = (struct descriptor**)HOST_DMA_BASE;
    printf("Writing...\n");
    *desc_reg = desc;
    printf("After writing\n");
}

void dma_wait_for_transfer(volatile struct descriptor *desc) {
    volatile bool* p_tx_done = &tx_done;
    asm volatile ("fence");
    if (!*p_tx_done) {
        do {
            asm volatile ("nop\n"
                    "nop\n"
                    "nop\n"
                    "nop\n");
            asm volatile ("fence");
        } while (!*p_tx_done ||
                desc->length != ~0);
    }
}

void dma_setup_interrupts(void) {
    // set source 8 priority to 3
    ((volatile uint32_t*)0x0c000000)[8] = 3;
    // enable m-mode interrupt 8
    *(volatile uint32_t*)0x0c002000 |= (1 << 8);
    // set interrupt threshold to 0
    *(volatile uint32_t*)0x0c200000 = 0;
}

void dma_trap_handler(uint64_t interrupt_cause) {
    printf("Got interrupt %ld\n", interrupt_cause);
    uint32_t plic_interrupt = *(volatile uint32_t*)0x0c200004;
    if (plic_interrupt == 8) {
        printf("Claiming interrupt\n");
        // claim interrupt
        *(volatile uint32_t*)0x0c200004 = 8;
        tx_done = true;
    } else {
        printf("PLIC interrupt %d\n", plic_interrupt);
    }
}

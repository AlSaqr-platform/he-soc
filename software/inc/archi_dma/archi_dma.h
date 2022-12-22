#ifndef ARCHI_DMA_H
#define ARCHI_DMA_H

/*Cluster DMA Specifications*/
#define CL_DMA_BASE 0x10201800

#define SRC_LOW_OFFS  0x00
#define SRC_HIGH_OFFS 0x04
#define DST_LOW_OFFS  0x08
#define DST_HIGH_OFFS 0x0C
#define TRNF_LEN_OFFS 0x10
#define TRNF_ID_OFFS  0x20
#define DONE_ID_OFFS  0x28

/* Host DMA Specifications */
#define HOST_DMA_BASE 0x50000000

/* DMA Descriptor */
struct descriptor {
  uint32_t flags;
  uint32_t length;
  uint64_t next;
  uint64_t src;
  uint64_t dst;
};

#endif

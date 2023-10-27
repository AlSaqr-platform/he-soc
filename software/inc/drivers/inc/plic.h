#ifndef __PLIC_H__
#define __PLIC_H__

#include <stdint.h>
#include "pulp_io.h"
#include "memory_map.h"

#define PLIC_PRIORITY_OFFSET 		0x0
#define PLIC_PENDING_OFFSET 		0x1000
#define PLIC_ENABLE_OFFSET 			0x2000
#define PLIC_ENABLE_STRIDE 			0x80
#define PLIC_CONTEXT_OFFSET 		0x200000
#define PLIC_CONTEXT_STRIDE 		0x1000
#define PLIC_CLAIM_COMPLETE_OFFSET 	0x4

uint32_t inline plic_get_priority (uint32_t src) {
	return pulp_read32(ARCHI_PLIC_BASE + PLIC_PRIORITY_OFFSET + (src << 2));
}

void inline plic_set_priority(uint32_t src, uint32_t val) {
	pulp_write32(ARCHI_PLIC_BASE + PLIC_PRIORITY_OFFSET + (src << 2), val);
}

uint32_t inline plic_get_ie(uint32_t context_idx, uint32_t word_idx) {
	return pulp_read32(ARCHI_PLIC_BASE + PLIC_ENABLE_OFFSET +
					   PLIC_ENABLE_STRIDE * context_idx +
					   (word_idx << 2));
}

void inline plic_write_word_ie(uint32_t context_idx, uint32_t word_idx, uint32_t val) {
	pulp_write32(ARCHI_PLIC_BASE + PLIC_ENABLE_OFFSET +
				 PLIC_ENABLE_STRIDE * context_idx +
				 (word_idx << 2), val);
}

void inline plic_set_ie(uint32_t context_idx, uint32_t src, uint32_t val) {
	uint32_t addr = ARCHI_PLIC_BASE + PLIC_ENABLE_OFFSET +
				 	PLIC_ENABLE_STRIDE * context_idx +
				 	4 * (src >> 5);
	uint32_t ie = pulp_read32(addr);
	uint32_t mask = (1 << (src & 0b11111));
	uint32_t new_ie = val ? (ie | mask) : (ie & ~mask);
	pulp_write32(addr, new_ie);
}

uint32_t inline plic_get_thresh(uint32_t context_idx) {
	return pulp_read32(ARCHI_PLIC_BASE + PLIC_CONTEXT_OFFSET +
					   PLIC_CONTEXT_STRIDE * context_idx);
}

void inline plic_set_thresh(uint32_t context_idx, uint32_t val) {
	pulp_write32(ARCHI_PLIC_BASE + PLIC_CONTEXT_OFFSET +
				 PLIC_CONTEXT_STRIDE * context_idx, val);
}

uint32_t inline plic_claim_msg(uint32_t context_idx) {
	return pulp_read32(ARCHI_PLIC_BASE + PLIC_CONTEXT_OFFSET +
					   PLIC_CONTEXT_STRIDE * context_idx +
					   PLIC_CLAIM_COMPLETE_OFFSET);
}

void inline plic_complete_msg(uint32_t context_idx, uint32_t val) {
	pulp_write32(ARCHI_PLIC_BASE + PLIC_CONTEXT_OFFSET +
				 PLIC_CONTEXT_STRIDE * context_idx +
				 PLIC_CLAIM_COMPLETE_OFFSET, val);
}
#endif

#include "iopmp.h"
#include <stdint.h>
#include <stdbool.h>

#define SEED 100
#define MDS_PER_SID 3
#define ITERATIONS  5


uint16_t configured_mds = 0;
uint16_t md_t[NUMBER_MDS] = {0};
uint16_t sid_mds[NUMBER_MASTERS][MDS_PER_SID];


/**
 *  IOPMP Memory-mapped registers
 */
// hwcfg0
uintptr_t hwcfg0_addr = IOPMP_REG_ADDR(IOPMP_HWCFG0_OFFSET);
// hwcfg1
uintptr_t hwcfg1_addr = IOPMP_REG_ADDR(IOPMP_HWCFG1_OFFSET);
// hwcfg2
uintptr_t hwcfg2_addr = IOPMP_REG_ADDR(IOPMP_HWCFG2_OFFSET);
// err_reqinfo
uintptr_t err_reqinfo_addr = IOPMP_REG_ADDR(IOPMP_ERR_REQINFO_OFFSET);
// err_reqid
uintptr_t err_reqid_addr = IOPMP_REG_ADDR(IOPMP_ERR_REQID_OFFSET);
// err_reqaddr
uintptr_t err_reqaddr_addr  = IOPMP_REG_ADDR(IOPMP_ERR_REQADDR_OFFSET);
// err_reqaddr
uintptr_t err_reqaddrh_addr = IOPMP_REG_ADDR(IOPMP_ERR_REQADDRH_OFFSET);

void iopmp_srcmd_config(unsigned int n, uint64_t mds_bmap, uint8_t lock)
{
    uintptr_t srcmd_addr;
    uint64_t config = 0;
    srcmd_addr = IOPMP_REG_ADDR(IOPMP_SRCMD_EN_OFFSET) + n * 32;

    config |= (mds_bmap << 1) | (lock & 0x1);

    write64(srcmd_addr, config);
}

void mdcfg_entry_config(uint16_t t, uint8_t entry_num)
{
    uintptr_t entry_addr = IOPMP_REG_ADDR(IOPMP_MDCFG_OFFSET) + entry_num * 4;

    write32(entry_addr, t);
    uint32_t md_t = read32(entry_addr);
}

void enable_iopmp()
{
    uint32_t config = 0x80000000; // Current spec the enable bit is the last bit of the HWCFG

    // INFO("Writing in %x", hwcfg0_addr);
    write32(hwcfg0_addr, config);
}

int iopmp_entry_set(unsigned int n, unsigned long prot, unsigned long addr,
	    unsigned long log2len)
{
    uintptr_t entry_addr;
    uintptr_t entry_config;
    entry_addr = IOPMP_REG_ADDR(IOPMP_ENTRY_ADDR_OFFSET) + n * 16;
    entry_config = IOPMP_REG_ADDR(IOPMP_ENTRY_CFG_OFFSET) + n * 16;

	// int pmpcfg_csr, pmpcfg_shift, pmpaddr_csr;
	// unsigned long cfgmask, pmpcfg;
	unsigned long addrmask, pmpaddr;

	/* encode PMP config */
    if (prot & MODE_NA){   // Is it naturally aligned? Verify which
        prot |= (log2len == 2) ? MODE_NA4 : MODE_NAPOT;
    }

	/* encode PMP address */
	if (!(prot & MODE_NAPOT)) { // If not NAPOT, its in the other modes, configure with 2
		pmpaddr = (addr >> 2);
	} else {
        addrmask = (1UL << (log2len - 2)) - 1;
        pmpaddr	 = ((addr >> 2) & ~addrmask);
        pmpaddr |= (addrmask >> 1);
	}

    write32(entry_config, prot);
    write64(entry_addr, pmpaddr);

	return 0;
}

void iopmp_mdcfg_config(unsigned int n, unsigned int t)
{
    uintptr_t mdcfg_addr;
    mdcfg_addr = IOPMP_REG_ADDR(IOPMP_MDCFG_OFFSET) + n * 4;

    write32(mdcfg_addr, t);
}

void entry_config(uint64_t addr, uint8_t mode, uint8_t access, uint16_t entry_num)
{
    uintptr_t entry_addr = IOPMP_REG_ADDR(IOPMP_ENTRY_ADDR_OFFSET) + entry_num * 16;
    write64(entry_addr, addr >> 2);

    uint64_t value = read64(entry_addr);

    entry_addr = IOPMP_REG_ADDR(IOPMP_ENTRY_CFG_OFFSET) + entry_num * 16;
    uint32_t config = ((mode & 0x3) << 3) + (access & 0x7);
    write32(entry_addr, config);
}


void set_entry_tor(uint64_t base_addr, uint8_t access, uint16_t entry_num)
{
    unsigned int entry_flags = 0;
    entry_flags |= MODE_TOR;
    entry_flags |= access;

    iopmp_entry_set(entry_num, entry_flags, base_addr, 2);
}

void set_entry_off(uint64_t base_addr, uint8_t access, uint16_t entry_num)
{
    unsigned int entry_flags = 0;
    entry_flags |= MODE_OFF;

    iopmp_entry_set(entry_num, entry_flags, base_addr, 2);
}


void srcmd_entry_config(uint16_t *mds, uint8_t number_mds, uint8_t lock, uint8_t entry_num)
{
    uintptr_t entry_addr = IOPMP_REG_ADDR(IOPMP_SRCMD_EN_OFFSET) + entry_num * 32;

    uint32_t md_value = 0;
    for (int i = 0; i < number_mds; i++)
    {
        md_value = md_value | (1 << mds[i]);
    }

    uint32_t config = (md_value << 1) + (lock & 0x1);
    write32(entry_addr, config);

    config = read32(entry_addr);
}

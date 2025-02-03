#ifndef _RV_IOPMP_H_
#define _RV_IOPMP_H_

#include <stdint.h>

#define MODE_OFF        (0ULL)
#define MODE_TOR        (1ULL << 3)
#define MODE_NA         (2ULL << 3)
#define MODE_NA4        (2ULL << 3)
#define MODE_NAPOT      (3ULL << 3)

#define ACCESS_NONE     (0ULL)
#define ACCESS_READ     (1ULL)
#define ACCESS_WRITE    (2ULL)
#define ACCESS_EXEC     (4ULL)

#define NO_ERROR            (0ULL)
#define READ_ERROR          (1ULL)
#define WRITE_ERROR         (2ULL)
#define EXECUTION_ERROR     (3ULL)
#define PARTIAL_ERROR       (4ULL)
#define NOT_HIT_ERROR       (5ULL)
#define UNKOWN_SID_ERROR    (6ULL)

#define IOPMP_VERSION_OFFSET        0x0
#define IOPMP_IMP_OFFSET            0x4
#define IOPMP_HWCFG0_OFFSET         0x8
#define IOPMP_HWCFG1_OFFSET         0xc
#define IOPMP_HWCFG2_OFFSET         0x10
#define IOPMP_ENTRY_OFFSET_OFFSET   0x14
#define IOPMP_ERRREACT_OFFSET       0x18
#define IOPMP_MDCFGLCK_OFFSET       0x48
#define IOPMP_ENTRYLCK_OFFSET       0x4c
#define IOPMP_ERR_REQINFO_OFFSET    0x60
#define IOPMP_ERR_REQID_OFFSET      0x64
#define IOPMP_ERR_REQADDR_OFFSET    0x68
#define IOPMP_ERR_REQADDRH_OFFSET   0x6c
#define IOPMP_MDCFG_OFFSET          0x800
#define IOPMP_SRCMD_EN_OFFSET       0x1000
#define IOPMP_SRCMD_ENH_OFFSET      0x1004
#define IOPMP_ENTRY_ADDR_OFFSET     0x2000
#define IOPMP_ENTRY_ADDRH_OFFSET    0x2004
#define IOPMP_ENTRY_CFG_OFFSET      0x2008

#define IOPMP_BASE_ADDR 0x50040000

#define IOPMP_REG_ADDR(OFF)     (IOPMP_BASE_ADDR + OFF)

#define REQ_INFO_IP_MASK(value)     (value & 0x1)
#define REQ_INFO_TTYPE_MASK(value)  ((value >> 1) & 0x3)
#define REQ_INFO_ETYPE_MASK(value)  ((value >> 4) & 0x7)

#define REQ_ID_SID(value)           (value & 0xffff)
#define REQ_ID_EID(value)           ((value >> 16) & 0xffff)

#define NUMBER_MASTERS       1
#define NUMBER_MDS           16
#define NUMBER_ENTRIES       32
#define NUMBER_PRIO_ENTRIES  4

void enable_iopmp();

int iopmp_entry_set(unsigned int n, unsigned long prot, unsigned long addr,
	    unsigned long log2len);
void iopmp_mdcfg_config(unsigned int n, unsigned int t);
void iopmp_srcmd_config(unsigned int n, uint64_t mds_bmap, uint8_t lock);
void entry_config(uint64_t addr, uint8_t mode, uint8_t access, uint16_t entry_num);
void set_entry_napot(uint64_t base_addr, uint64_t length, uint8_t access, uint16_t entry_num);
void set_entry_tor(uint64_t base_addr, uint8_t access, uint16_t entry_num);
void set_entry_off(uint64_t base_addr, uint8_t access, uint16_t entry_num);

int entry_set(unsigned int n, unsigned long prot, unsigned long addr,
	    unsigned long log2len);

static inline uint64_t read64(uintptr_t addr){
    asm volatile("fence.i" ::: "memory");
    return *((volatile uint64_t*) addr);
}

static inline uint32_t read32(uintptr_t addr){
    asm volatile("fence.i" ::: "memory");
    return *((volatile uint32_t*) addr);
}

static inline uint16_t read16(uintptr_t addr){
    asm volatile("fence.i" ::: "memory");
    return *((volatile uint16_t*) addr);
}

static inline uint8_t read8(uintptr_t addr){
    asm volatile("fence.i" ::: "memory");
    return *((volatile uint8_t*) addr);
}

static inline void write64(uintptr_t addr, uint64_t val){
    asm volatile("fence.i" ::: "memory");
    *((volatile uint64_t*) addr) = val;
}

static inline void write32(uintptr_t addr, uint32_t val){
    asm volatile("fence.i" ::: "memory");
    *((volatile uint32_t*) addr) = val;
}

static inline void write16(uintptr_t addr, uint16_t val){
    asm volatile("fence.i" ::: "memory");
    *((volatile uint16_t*) addr) = val;
}

static inline void write8(uintptr_t addr, uint8_t val){
    asm volatile("fence.i" ::: "memory");
    *((volatile uint8_t*) addr) = val;
}

#endif  /* _RV_IOPMP_H_ */

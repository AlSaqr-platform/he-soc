#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "aplic.h"

#define IMSICM              0
#define IMSICS              1
#define IMSICVS             2

#define DELEGATE_SRC        0x400
#define INACTIVE            0
#define DETACHED            1
#define EDGE1               4
#define EDGE0               5
#define LEVEL1              6
#define LEVEL0              7

#define CSR_MIE		          0x304
#define CSR_HSTATUS		      0x600

#define CSR_MISELECT		    0x350
#define CSR_MIREG			      0x351
#define CSR_MTOPEI			    0x35c

#define CSR_SISELECT			  0x150
#define CSR_SIREG			      0x151
#define CSR_STOPEI			    0x15c

#define CSR_VSISELECT			  0x250
#define CSR_VSIREG			    0x251
#define CSR_VSTOPEI			    0x25c

#define IMSIC_EIDELIVERY		0x70
#define IMSIC_EITHRESHOLD		0x72
#define IMSIC_EIP		        0x80
#define IMSIC_EIE		        0xC0

#define APLICM_ADDR         0xc000000
#define APLICS_ADDR         0xd000000
#define DOMAIN_OFF          0x0000
#define SOURCECFG_OFF       0x0004
#define APLIC_MMSICFGADDR              0x1bc0
#define APLIC_MMSICFGADDRH             0x1bc4
#define APLIC_SMSICFGADDR              0x1bc8
#define APLIC_SMSICFGADDRH             0x1bcc
#define SETIP_OFF           0x1C00
#define SETIE_OFF           0x1E00
#define SETIPNUM_OFF        0x1CDC
#define SETIENUM_OFF        0x1EDC
#define GENMSI_OFF          0x3000
#define DEBUG_OFF          0x2008
#define TARGET_OFF          0x3004

#define IDC_OFF              0x4000
#define IDELIVERY_OFF        IDC_OFF + 0x00

#define CSR_STR(s) _CSR_STR(s)
#define _CSR_STR(s) #s

#define CSRR(csr)                                     \
    ({                                                \
        uint64_t _temp;                               \
        asm volatile("csrr  %0, " CSR_STR(csr) "\n\r" \
                     : "=r"(_temp)::"memory");        \
        _temp;                                        \
    })

#define CSRW(csr, rs) \
    asm volatile("csrw  " CSR_STR(csr) ", %0\n\r" ::"rK"(rs) : "memory")
#define CSRS(csr, rs) \
    asm volatile("csrs  " CSR_STR(csr) ", %0\n\r" ::"rK"(rs) : "memory")
#define CSRC(csr, rs) \
    asm volatile("csrc  " CSR_STR(csr) ", %0\n\r" ::"rK"(rs) : "memory")

void config_intp(uint8_t intp_id){
  bool cond_ctl;
  uint64_t hold;

  /** Config intp source intp_id by writing sourcecfg reg */
  pulp_write32(APLICM_ADDR+(SOURCECFG_OFF+(0x4*(intp_id-1))), EDGE1);

  /** Enable intp intp_id by writing setienum reg */
  pulp_write32(APLICM_ADDR+SETIENUM_OFF, intp_id);
}

void aplic_init(){
  /** Enable APLIC M Domain */
  pulp_write32(APLICM_ADDR+DOMAIN_OFF, (0x1<<8)|(0x1<<2));
}


void aplic_trigger_intp(uint8_t intp_id){
  pulp_write32(APLICM_ADDR+SETIPNUM_OFF, intp_id);
}


void imsic_en_intp(uint8_t intp_id, uint8_t imsic_id, uint8_t core_id){
  uint32_t prev_val = 0;
  /** Config intp TARGET by writing target reg */
  // Im writing EEID to target. Only for MSI mode
  pulp_write32(APLICM_ADDR+(TARGET_OFF+(0x4*(intp_id-1))), (core_id << 18) | (0 << 12) | imsic_id);
  CSRW(CSR_MISELECT, IMSIC_EIE);
  prev_val = CSRR(CSR_MIREG);
  CSRW(CSR_MIREG, prev_val | (1 << imsic_id));
}

void config_irq_aplic(uint8_t intp_id, uint8_t imsic_id, uint8_t core_id){
  config_intp(intp_id);
  imsic_en_intp(intp_id,imsic_id,core_id);
}

bool imsic_intp_arrive(uint8_t intp_id){
  bool cond_ctl = false;
  do
  {
      cond_ctl = ((CSRR(CSR_MTOPEI) >> 16) == intp_id);
  } while (cond_ctl == false);
  CSRW(CSR_MTOPEI, 0);
  return cond_ctl;
}

void imsic_init(){
  /** Enable interrupt delivery */
  CSRW(CSR_MISELECT, IMSIC_EIDELIVERY);
  CSRW(CSR_MIREG, 1);
  /** Every intp is triggrable */
  CSRW(CSR_MISELECT, IMSIC_EITHRESHOLD);
  CSRW(CSR_MIREG, 0);
}


void aplic_reset(uint8_t irq_id){
  CSRW(CSR_MTOPEI, 0);
  CSRW(CSR_MISELECT, 0);
  CSRW(CSR_MIREG, 1);
  CSRW(CSR_MISELECT, 0);
  CSRW(CSR_MIREG, 0);
  pulp_write32(APLICM_ADDR+DOMAIN_OFF, 0);
  pulp_write32(APLICM_ADDR+(SOURCECFG_OFF+(0x4*(irq_id-1))), 0);
  pulp_write32(APLICM_ADDR+SETIENUM_OFF, 0);
  pulp_write32(APLICM_ADDR+(TARGET_OFF+(0x4*(irq_id-1))), 0);
  CSRW(CSR_MIREG, 0);
  CSRW(CSR_MISELECT, 0);
}

#ifndef __ARCHI_TLB_H__
#define __ARCHI_TLB_H__

#define H2C_TLB_BASE_ADDR 0X10400000
#define C2H_TLB_BASE_ADDR 0x10401000

#define FIRST_VA_LSW 0x00
#define FIRST_VA_MSW 0x04

#define LAST_VA_LSW  0x08
#define LAST_VA_MSW  0x0C
                     
#define BASE_PA_LSW  0x10
#define BASE_PA_MSW  0x14
                     
#define FLAGS        0x18

// H2C_TLB Configuration variables
uint64_t h2c_first_va = 0x0000000000000000;
uint64_t h2c_last_va  = 0x00000000FFFFFFFF;
uint64_t h2c_base_pa  = 0x0000000010000000;
uint8_t  h2c_flags    = 0x07;

// C2H_TLB Configuration variables
uint64_t c2h_first_va = 0x0000000000000000;
uint64_t c2h_last_va  = 0x00000000FFFFFFFF;
uint64_t c2h_base_pa  = 0x0000000000000000;
uint8_t  c2h_flags    = 0x07;

#define TLB_FLAG_VALID    ((uint8_t)(1 << 0))
#define TLB_FLAG_READABLE ((uint8_t)(1 << 1))
#define TLB_FLAG_WRITABLE ((uint8_t)(1 << 2))

#endif

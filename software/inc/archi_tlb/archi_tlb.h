#ifndef __ARCHI_TLB_H__
#define __ARCHI_TLB_H__

#define H2C_TLB_BASE_ADDR 0X50000000
#define C2H_TLB_BASE_ADDR 0x50001000

#define FIRST_VA_LSW 0x00
#define FIRST_VA_MSW 0x04

#define LAST_VA_LSW  0x08
#define LAST_VA_MSW  0x0C
                     
#define BASE_PA_LSW  0x10
#define BASE_PA_MSW  0x14
                     
#define FLAGS        0x18

#endif

#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "bearssl.h"
 
#define FPGA_EMULATION
 
uint8_t data[64] = {0};
uint8_t out[32] = {0};
 
 
int main(int argc, char **argv)
{
#ifdef FPGA_EMULATION
#define baud_rate 115200
#define test_freq 50000000
#else
#define baud_rate 115200
#define test_freq 100000000
    set_flls();
#endif
        uart_set_cfg(
        0,
        (test_freq/baud_rate)>>4
    );

    printf("uart init\t\n");
 
    br_sha256_context ctx;
 
    br_sha256_init(&ctx);
    br_sha256_update(&ctx, data, 64);
    br_sha256_out(&ctx, out);
 
    for (size_t i=0; i<32; i++) printf("out[%02d] = 0x%02x\t\n", i, out[i]);
 
    return 0;
}

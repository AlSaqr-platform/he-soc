// Copyright (c) 2023 ETH Zurich and University of Bologna
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.
//

#include <stdio.h>
#include <stdlib.h>
#include "utils.h"
#include "bearssl.h"


#define FPGA_EMULATION


typedef struct
{
    uint8_t *data;
    size_t n;
} titanssl_buffer_t;


static titanssl_buffer_t buffer_payload;
static titanssl_buffer_t buffer_key;
static titanssl_buffer_t buffer_iv;


/* ============================================================================
 * Benchmark setup
 * ========================================================================= */

#define TITANSSL_CFG_BENCHMARK_DEBUG   1
#define TITANSSL_CFG_BENCHMARK_PAYLOAD 32

/* ============================================================================
 * Benchmark automatic configuration
 * ========================================================================= */

#define TITANSSL_ADDR_PAYLOAD 0x80720000
#define TITANSSL_ADDR_KEY     0x80740000
#define TITANSSL_ADDR_IV      0x80740800
#define TITANSSL_SIZE_PAYLOAD ((TITANSSL_CFG_BENCHMARK_PAYLOAD+0xf)&~0xf)
#define TITANSSL_SIZE_KEY     32
#define TITANSSL_SIZE_IV      16

/* ============================================================================
 * Benchmark implementation
 * ========================================================================= */

void initialize_memory()
{
    buffer_payload.data = (uint8_t*)TITANSSL_ADDR_PAYLOAD;
    buffer_payload.n = TITANSSL_SIZE_PAYLOAD;
    for (size_t i=0; i<TITANSSL_SIZE_PAYLOAD; i++) buffer_payload.data[i] = 0x0;

    buffer_key.data = (uint8_t*)TITANSSL_ADDR_KEY;
    buffer_key.n = TITANSSL_SIZE_KEY;
    for (size_t i=0; i<TITANSSL_SIZE_KEY; i++) buffer_key.data[i] = 0x0;

    buffer_iv.data = (uint8_t*)TITANSSL_ADDR_IV;
    buffer_iv.n = TITANSSL_SIZE_IV;
    for (size_t i=0; i<TITANSSL_SIZE_IV; i++) buffer_iv.data[i] = 0x0;
}

void titanssl_benchmark_aes(
        titanssl_buffer_t *const payload,
        titanssl_buffer_t *const key,
        titanssl_buffer_t *const iv)
{
    br_aes_big_cbcenc_keys ctx;

    br_aes_big_cbcenc_init(
        &ctx,
        key->data,
        key->n
    );
    br_aes_big_cbcenc_run(
        &ctx,
        iv->data,
        payload->data,
        payload->n
    );
}

int main(
		int argc,
		char const *argv[])
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

    initialize_memory();

    titanssl_benchmark_aes(
        &buffer_payload,
        &buffer_key,
        &buffer_iv
    );

#if TITANSSL_CFG_BENCHMARK_DEBUG
    for (size_t i=0; i<buffer_payload.n; i++) printf("AES [%2d] = 0x%02x\r\n", i, buffer_payload.data[i]);
#endif

	return 0;
}

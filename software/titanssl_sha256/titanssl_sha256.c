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
static titanssl_buffer_t buffer_digest;


/* ============================================================================
 * Benchmark setup
 * ========================================================================= */

#define TITANSSL_CFG_BENCHMARK_DEBUG   1
#define TITANSSL_CFG_BENCHMARK_PAYLOAD 64

/* ============================================================================
 * Benchmark automatic configuration
 * ========================================================================= */

#define TITANSSL_ADDR_PAYLOAD 0x80720000
#define TITANSSL_ADDR_DIGEST  0x80740000
#define TITANSSL_SIZE_PAYLOAD TITANSSL_CFG_BENCHMARK_PAYLOAD
#define TITANSSL_SIZE_DIGEST  32

/* ============================================================================
 * Benchmark implementation
 * ========================================================================= */

void initialize_memory()
{
    buffer_payload.data = (uint8_t*)TITANSSL_ADDR_PAYLOAD;
    buffer_payload.n = TITANSSL_SIZE_PAYLOAD;
    for (size_t i=0; i<TITANSSL_SIZE_PAYLOAD; i++) buffer_payload.data[i] = 0x0;

    buffer_digest.data = (uint8_t*)TITANSSL_ADDR_DIGEST;
    buffer_digest.n = TITANSSL_SIZE_DIGEST;
    for (size_t i=0; i<TITANSSL_SIZE_DIGEST; i++) buffer_digest.data[i] = 0x0;
}

void titanssl_benchmark_sha256(
        titanssl_buffer_t *const payload,
        titanssl_buffer_t *const digest)
{
    br_sha256_context ctx;

    br_sha256_init(&ctx);
    br_sha256_update(
        &ctx,
        payload->data,
        payload->n
    );
    br_sha256_out(
        &ctx,
        digest->data
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

    titanssl_benchmark_sha256(
        &buffer_payload,
        &buffer_digest
    );

#if TITANSSL_CFG_BENCHMARK_DEBUG
    for (size_t i=0; i<buffer_digest.n; i++) printf("SHA-256 [%2d] = 0x%02x\r\n", i, buffer_digest.data[i]);
#endif

	return 0;
}

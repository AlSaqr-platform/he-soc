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
static titanssl_buffer_t buffer_key;


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
#define TITANSSL_ADDR_KEY     0x80750000
#define TITANSSL_SIZE_PAYLOAD TITANSSL_CFG_BENCHMARK_PAYLOAD
#define TITANSSL_SIZE_DIGEST  32
#define TITANSSL_SIZE_KEY     32

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

    buffer_key.data = (uint8_t*)TITANSSL_ADDR_KEY;
    buffer_key.n = TITANSSL_SIZE_KEY;
    for (size_t i=0; i<TITANSSL_SIZE_KEY; i++) buffer_key.data[i] = 0x0;
}

void titanssl_benchmark_hmac(
        titanssl_buffer_t *const payload,
        titanssl_buffer_t *const digest,
        titanssl_buffer_t *const key)
{
    br_hmac_key_context ctx_key;
    br_hmac_context ctx_hash;

    br_hmac_key_init(
        &ctx_key,
        &br_sha256_vtable,
        key->data,
        key->n
    );
    br_hmac_init(
        &ctx_hash,
        &ctx_key,
        0
    );
    br_hmac_update(
        &ctx_hash,
        payload->data,
        payload->n
    );
    br_hmac_out(
        &ctx_hash,
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

    titanssl_benchmark_hmac(
        &buffer_payload,
        &buffer_digest,
        &buffer_key
    );

#if TITANSSL_CFG_BENCHMARK_DEBUG
    for (size_t i=0; i<buffer_digest.n; i++) printf("HMAC [%2d] = 0x%02x\r\n", i, buffer_digest.data[i]);
#endif

	return 0;
}

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
#include <stdbool.h>
#include <string.h>
#include "utils.h"
#include "sha3.h"


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
#define TITANSSL_SHA3_MODE  256

/* ============================================================================
 * Benchmark automatic configuration
 * ========================================================================= */

#define TITANSSL_ADDR_PAYLOAD 0x80720000
#define TITANSSL_ADDR_DIGEST  0x80740000
#define TITANSSL_SIZE_PAYLOAD 200
#define TITANSSL_SIZE_DIGEST  (TITANSSL_SHA3_MODE / 8)

/* ============================================================================
 * Benchmark implementation
 * ========================================================================= */

unsigned char plaintext[TITANSSL_SIZE_PAYLOAD];
unsigned char ciphertext[TITANSSL_SIZE_DIGEST];
const void *hash;

static size_t
hextobin(unsigned char *dst, const char *src)
{
	size_t num;
	unsigned acc;
	int z;

	num = 0;
	z = 0;
	acc = 0;
	while (*src != 0) {
		int c = *src ++;
		if (c >= '0' && c <= '9') {
			c -= '0';
		} else if (c >= 'A' && c <= 'F') {
			c -= ('A' - 10);
		} else if (c >= 'a' && c <= 'f') {
			c -= ('a' - 10);
		} else {
			continue;
		}
		if (z) {
			*dst ++ = (acc << 4) + c;
			num ++;
		} else {
			acc = c;
		}
		z = !z;
	}
	return num;
}

void initialize_memory()
{

    buffer_payload.data = (uint8_t*)TITANSSL_ADDR_PAYLOAD;
    buffer_payload.n = TITANSSL_SIZE_PAYLOAD;
    for (size_t i=0; i<TITANSSL_SIZE_PAYLOAD; i++) buffer_payload.data[i] = plaintext[i];

    buffer_digest.data = (uint8_t*)TITANSSL_ADDR_DIGEST;
    buffer_digest.n = TITANSSL_SIZE_DIGEST;
    for (size_t i=0; i<TITANSSL_SIZE_DIGEST; i++) buffer_digest.data[i] = 0x0;
}

void titanssl_benchmark_sha3(
        titanssl_buffer_t *const payload,
        titanssl_buffer_t *const digest)
{

    /*

	sha3_context c;

	sha3_Init(&c, TITANSSL_SHA3_MODE);
    sha3_SetFlags(&c, SHA3_FLAGS_KECCAK);
	sha3_Update(&c, payload->data, TITANSSL_SIZE_PAYLOAD);
	hash = sha3_Finalize(&c);
    
    */

    // /*

    sha3_context c;

    // -> OUT
    //    "\xa8\xea\xce\xda\x4d\x47\xb3\x28"
    //    "\x1a\x79\x5a\xd9\xe1\xea\x21\x22"
    //    "\xb4\x07\xba\xf9\xaa\xbc\xb9\xe1"
    //    "\x8b\x57\x17\xb7\x87\x35\x37\xd2"
    //

    sha3_Init256(&c);
    sha3_SetFlags(&c, SHA3_FLAGS_KECCAK);
    sha3_Update(&c, "\x41\xfb", 2);
    hash = sha3_Finalize(&c);

    // */

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

#if TITANSSL_SHA3_MODE == 256

#endif

    initialize_memory();

    titanssl_benchmark_sha3(
        &buffer_payload,
        &buffer_digest
    );

	memcpy(buffer_digest.data, hash, TITANSSL_SIZE_DIGEST);

#if TITANSSL_CFG_BENCHMARK_DEBUG
    for (size_t i=0; i<buffer_digest.n; i++) printf("SHA3 [%2d] 0x%02x vs 0x%02x\r\n", i, ciphertext[i], buffer_digest.data[i]);
#endif

	return 0;
}

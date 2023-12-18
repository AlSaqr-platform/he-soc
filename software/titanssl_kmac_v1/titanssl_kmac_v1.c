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
#define TITANSSL_SIZE_PAYLOAD (TITANSSL_SHA3_MODE / 32)
#define TITANSSL_SIZE_DIGEST  (TITANSSL_SHA3_MODE / 8)

/* ============================================================================
 * Benchmark implementation
 * ========================================================================= */

#define SHA3_CONST(x) x
#define SHA3_USE_KECCAK_FLAG 0x80000000
#define SHA3_CW(x) ((x) & (~SHA3_USE_KECCAK_FLAG))

#define SHA3_ROTL64(x, y) \
	(((x) << (y)) | ((x) >> ((sizeof(uint64_t)*8) - (y))))

#define SHA3_KECCAK_SPONGE_WORDS \
	(((1600)/8/*bits to byte*/)/sizeof(uint64_t))
typedef struct sha3_context_ {
    uint64_t saved;             /* the portion of the input message that we
                                 * didn't consume yet */
    union {                     /* Keccak's state */
        uint64_t s[SHA3_KECCAK_SPONGE_WORDS];
        uint8_t sb[SHA3_KECCAK_SPONGE_WORDS * 8];
    } u;
    unsigned byteIndex;         /* 0..7--the next byte after the set one
                                 * (starts from 0; 0--none are buffered) */
    unsigned wordIndex;         /* 0..24--the next word to integrate input
                                 * (starts from 0) */
    unsigned capacityWords;     /* the double size of the hash output in
                                 * words (e.g. 16 for Keccak 512) */
} sha3_context;

unsigned char plaintext[TITANSSL_SIZE_PAYLOAD];
unsigned char ciphertext[TITANSSL_SIZE_DIGEST];
const void *hash;

enum SHA3_FLAGS {
    SHA3_FLAGS_NONE=0,
    SHA3_FLAGS_KECCAK=1
};

static const uint64_t keccakf_rndc[24] = {
    SHA3_CONST(0x0000000000000001UL), SHA3_CONST(0x0000000000008082UL),
    SHA3_CONST(0x800000000000808aUL), SHA3_CONST(0x8000000080008000UL),
    SHA3_CONST(0x000000000000808bUL), SHA3_CONST(0x0000000080000001UL),
    SHA3_CONST(0x8000000080008081UL), SHA3_CONST(0x8000000000008009UL),
    SHA3_CONST(0x000000000000008aUL), SHA3_CONST(0x0000000000000088UL),
    SHA3_CONST(0x0000000080008009UL), SHA3_CONST(0x000000008000000aUL),
    SHA3_CONST(0x000000008000808bUL), SHA3_CONST(0x800000000000008bUL),
    SHA3_CONST(0x8000000000008089UL), SHA3_CONST(0x8000000000008003UL),
    SHA3_CONST(0x8000000000008002UL), SHA3_CONST(0x8000000000000080UL),
    SHA3_CONST(0x000000000000800aUL), SHA3_CONST(0x800000008000000aUL),
    SHA3_CONST(0x8000000080008081UL), SHA3_CONST(0x8000000000008080UL),
    SHA3_CONST(0x0000000080000001UL), SHA3_CONST(0x8000000080008008UL)
};

static const unsigned keccakf_rotc[24] = {
    1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 2, 14, 27, 41, 56, 8, 25, 43, 62,
    18, 39, 61, 20, 44
};

static const unsigned keccakf_piln[24] = {
    10, 7, 11, 17, 18, 3, 5, 16, 8, 21, 24, 4, 15, 23, 19, 13, 12, 2, 20,
    14, 22, 9, 6, 1
};

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

static void
keccakf(uint64_t s[25])
{
    int i, j, round;
    uint64_t t, bc[5];
#define KECCAK_ROUNDS 24

    for(round = 0; round < KECCAK_ROUNDS; round++) {

        /* Theta */
        for(i = 0; i < 5; i++)
            bc[i] = s[i] ^ s[i + 5] ^ s[i + 10] ^ s[i + 15] ^ s[i + 20];

        for(i = 0; i < 5; i++) {
            t = bc[(i + 4) % 5] ^ SHA3_ROTL64(bc[(i + 1) % 5], 1);
            for(j = 0; j < 25; j += 5)
                s[j + i] ^= t;
        }

        /* Rho Pi */
        t = s[1];
        for(i = 0; i < 24; i++) {
            j = keccakf_piln[i];
            bc[0] = s[j];
            s[j] = SHA3_ROTL64(t, keccakf_rotc[i]);
            t = bc[0];
        }

        /* Chi */
        for(j = 0; j < 25; j += 5) {
            for(i = 0; i < 5; i++)
                bc[i] = s[j + i];
            for(i = 0; i < 5; i++)
                s[j + i] ^= (~bc[(i + 1) % 5]) & bc[(i + 2) % 5];
        }

        /* Iota */
        s[0] ^= keccakf_rndc[round];
    }
}

void
sha3_Init(void *priv, unsigned bitSize) {
    sha3_context *ctx = (sha3_context *) priv;
    if( bitSize != 256 && bitSize != 384 && bitSize != 512 )
        return;
    memset(ctx, 0, sizeof(*ctx));
    ctx->capacityWords = 2 * bitSize / (8 * sizeof(uint64_t));
    return;
}

enum SHA3_FLAGS
sha3_SetFlags(void *priv, enum SHA3_FLAGS flags)
{
    sha3_context *ctx = (sha3_context *) priv;
    flags &= SHA3_FLAGS_KECCAK;
    ctx->capacityWords |= (flags == SHA3_FLAGS_KECCAK ? SHA3_USE_KECCAK_FLAG : 0);
    return flags;
}

void
sha3_Update(void *priv, void const *bufIn, size_t len)
{
    sha3_context *ctx = (sha3_context *) priv;

    /* 0...7 -- how much is needed to have a word */
    unsigned old_tail = (8 - ctx->byteIndex) & 7;

    size_t words;
    unsigned tail;
    size_t i;

    const uint8_t *buf = bufIn;

    // SHA3_TRACE_BUF("called to update with:", buf, len);

    // SHA3_ASSERT(ctx->byteIndex < 8);
    // SHA3_ASSERT(ctx->wordIndex < sizeof(ctx->u.s) / sizeof(ctx->u.s[0]));

    if(len < old_tail) {        /* have no complete word or haven't started 
                                 * the word yet */
        // SHA3_TRACE("because %d<%d, store it and return", (unsigned)len,
        //         (unsigned)old_tail);
        /* endian-independent code follows: */
        while (len--)
            ctx->saved |= (uint64_t) (*(buf++)) << ((ctx->byteIndex++) * 8);
        // SHA3_ASSERT(ctx->byteIndex < 8);
        return;
    }

    if(old_tail) {              /* will have one word to process */
        // SHA3_TRACE("completing one word with %d bytes", (unsigned)old_tail);
        /* endian-independent code follows: */
        len -= old_tail;
        while (old_tail--)
            ctx->saved |= (uint64_t) (*(buf++)) << ((ctx->byteIndex++) * 8);

        /* now ready to add saved to the sponge */
        ctx->u.s[ctx->wordIndex] ^= ctx->saved;
        // SHA3_ASSERT(ctx->byteIndex == 8);
        ctx->byteIndex = 0;
        ctx->saved = 0;
        if(++ctx->wordIndex ==
                (SHA3_KECCAK_SPONGE_WORDS - SHA3_CW(ctx->capacityWords))) {
            keccakf(ctx->u.s);
            ctx->wordIndex = 0;
        }
    }

    /* now work in full words directly from input */

    // SHA3_ASSERT(ctx->byteIndex == 0);

    words = len / sizeof(uint64_t);
    tail = len - words * sizeof(uint64_t);

    // SHA3_TRACE("have %d full words to process", (unsigned)words);

    for(i = 0; i < words; i++, buf += sizeof(uint64_t)) {
        const uint64_t t = (uint64_t) (buf[0]) |
                ((uint64_t) (buf[1]) << 8 * 1) |
                ((uint64_t) (buf[2]) << 8 * 2) |
                ((uint64_t) (buf[3]) << 8 * 3) |
                ((uint64_t) (buf[4]) << 8 * 4) |
                ((uint64_t) (buf[5]) << 8 * 5) |
                ((uint64_t) (buf[6]) << 8 * 6) |
                ((uint64_t) (buf[7]) << 8 * 7);
        ctx->u.s[ctx->wordIndex] ^= t;
        if(++ctx->wordIndex ==
                (SHA3_KECCAK_SPONGE_WORDS - SHA3_CW(ctx->capacityWords))) {
            keccakf(ctx->u.s);
            ctx->wordIndex = 0;
        }
    }

    // SHA3_TRACE("have %d bytes left to process, save them", (unsigned)tail);

    /* finally, save the partial word */
    // SHA3_ASSERT(ctx->byteIndex == 0 && tail < 8);
    while (tail--) {
        // SHA3_TRACE("Store byte %02x '%c'", *buf, *buf);
        ctx->saved |= (uint64_t) (*(buf++)) << ((ctx->byteIndex++) * 8);
    }
    // SHA3_ASSERT(ctx->byteIndex < 8);
    // SHA3_TRACE("Have saved=0x%016" PRIx64 " at the end", ctx->saved);
}

void const *
sha3_Finalize(void *priv)
{
    sha3_context *ctx = (sha3_context *) priv;

    // SHA3_TRACE("called with %d bytes in the buffer", ctx->byteIndex);

    /* Append 2-bit suffix 01, per SHA-3 spec. Instead of 1 for padding we
     * use 1<<2 below. The 0x02 below corresponds to the suffix 01.
     * Overall, we feed 0, then 1, and finally 1 to start padding. Without
     * M || 01, we would simply use 1 to start padding. */

    uint64_t t;

    if( ctx->capacityWords & SHA3_USE_KECCAK_FLAG ) {
        /* Keccak version */
        t = (uint64_t)(((uint64_t) 1) << (ctx->byteIndex * 8));
    }
    else {
        /* SHA3 version */
        t = (uint64_t)(((uint64_t)(0x02 | (1 << 2))) << ((ctx->byteIndex) * 8));
    }

    ctx->u.s[ctx->wordIndex] ^= ctx->saved ^ t;

    ctx->u.s[SHA3_KECCAK_SPONGE_WORDS - SHA3_CW(ctx->capacityWords) - 1] ^=
            SHA3_CONST(0x8000000000000000UL);
    keccakf(ctx->u.s);

    /* Return first bytes of the ctx->s. This conversion is not needed for
     * little-endian platforms e.g. wrap with #if !defined(__BYTE_ORDER__)
     * || !defined(__ORDER_LITTLE_ENDIAN__) || __BYTE_ORDER__!=__ORDER_LITTLE_ENDIAN__ 
     *    ... the conversion below ...
     * #endif */
    {
        unsigned i;
        for(i = 0; i < SHA3_KECCAK_SPONGE_WORDS; i++) {
            const unsigned t1 = (uint32_t) ctx->u.s[i];
            const unsigned t2 = (uint32_t) ((ctx->u.s[i] >> 16) >> 16);
            ctx->u.sb[i * 8 + 0] = (uint8_t) (t1);
            ctx->u.sb[i * 8 + 1] = (uint8_t) (t1 >> 8);
            ctx->u.sb[i * 8 + 2] = (uint8_t) (t1 >> 16);
            ctx->u.sb[i * 8 + 3] = (uint8_t) (t1 >> 24);
            ctx->u.sb[i * 8 + 4] = (uint8_t) (t2);
            ctx->u.sb[i * 8 + 5] = (uint8_t) (t2 >> 8);
            ctx->u.sb[i * 8 + 6] = (uint8_t) (t2 >> 16);
            ctx->u.sb[i * 8 + 7] = (uint8_t) (t2 >> 24);
        }
    }

    // SHA3_TRACE_BUF("Hash: (first 32 bytes)", ctx->u.sb, 256 / 8);

    return (ctx->u.sb);
}

void titanssl_benchmark_rsa(
        titanssl_buffer_t *const payload,
        titanssl_buffer_t *const digest)
{

	sha3_context c;

	sha3_Init(&c, TITANSSL_SHA3_MODE);
    sha3_SetFlags(&c, SHA3_FLAGS_KECCAK);
	sha3_Update(&c, payload->data, TITANSSL_SIZE_PAYLOAD);
	hash = sha3_Finalize(&c);

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
    hextobin(plaintext, "e7372105");
	hextobin(ciphertext, "8ab6423a8cf279b052c7a34c90276f2978fec406d979ebb1057f7789ae46401e");
#endif

    initialize_memory();

    titanssl_benchmark_rsa(
        &buffer_payload,
        &buffer_digest
    );

	memcpy(buffer_digest.data, hash, TITANSSL_SIZE_DIGEST);

#if TITANSSL_CFG_BENCHMARK_DEBUG
    for (size_t i=0; i<buffer_digest.n; i++) printf("SHA3 [%2d] 0x%02x vs 0x%02x\r\n", i, ciphertext[i], buffer_digest.data[i]);
#endif

	return 0;
}

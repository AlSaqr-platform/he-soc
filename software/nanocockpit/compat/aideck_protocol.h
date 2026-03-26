/*
 * aideck_protocol.h — portable shim
 *
 * Provides inference_stamped_t as defined in the original, without
 * the SPI transport layer and extern declarations.
 */

#pragma once

#include <stdbool.h>
#include <stdint.h>

#define INFERENCE_STAMPED_HEADER "\x90\x19\x8\x32"

typedef struct inference_stamped_s {
  uint32_t stm32_timestamp;   /* [ticks / ms] */
  float x;                    /* [m]   */
  float y;                    /* [m]   */
  float z;                    /* [m]   */
  float phi;                  /* [rad] */
} __attribute__((packed)) inference_stamped_t;

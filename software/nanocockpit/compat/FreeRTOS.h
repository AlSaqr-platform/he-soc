/*
 * FreeRTOS.h — portable shim
 *
 * Provides the tick-conversion macros from FreeRTOSConfig.h used by
 * the frontnet pipeline. On the Crazyflie, ticks == milliseconds
 * (configTICK_RATE_HZ = 1000).
 */

#pragma once

#include <stdint.h>

#define configTICK_RATE_HZ  1000
#define configMINIMAL_STACK_SIZE  128

typedef uint32_t portTickType;

/* Milliseconds <-> ticks (identity at 1 kHz tick rate) */
#define M2T(X)  ((unsigned int)(X))
#define T2M(X)  ((unsigned int)(X))

/* Frequency -> ticks */
#define F2T(X)  ((unsigned int)((configTICK_RATE_HZ / (X))))

/* Seconds <-> ticks */
#define S2T(X)  ((portTickType)((X) * configTICK_RATE_HZ))
#define T2S(X)  ((X) / (float)configTICK_RATE_HZ)

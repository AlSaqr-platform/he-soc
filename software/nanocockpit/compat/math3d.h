/*
 * math3d.h — portable shim
 *
 * Provides the subset of crazyflie-firmware's math3d.h used by the
 * frontnet pipeline: scalar helpers only.
 */

#pragma once

#include <math.h>

#ifndef M_PI_F
#define M_PI_F   (3.14159265358979323846f)
#endif

#ifndef M_1_PI_F
#define M_1_PI_F (0.31830988618379067154f)
#endif

#ifndef M_PI_2_F
#define M_PI_2_F (1.57079632679f)
#endif

static inline float fsqr(float x) { return x * x; }
static inline float radians(float degrees) { return (M_PI_F / 180.0f) * degrees; }
static inline float degrees(float radians) { return (180.0f / M_PI_F) * radians; }

static inline float clamp(float value, float min, float max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}

/*
 * num.h — portable shim for nanocockpit-controller
 */
#pragma once

#include <stdint.h>
#include <math.h>

static inline float constrain(float value, const float minVal, const float maxVal) {
  return fminf(fmaxf(value, minVal), maxVal);
}

static inline uint16_t limitUint16(int32_t value) {
  if (value > 0xFFFF) return (uint16_t)0xFFFF;
  if (value < 0)      return 0;
  return (uint16_t)value;
}

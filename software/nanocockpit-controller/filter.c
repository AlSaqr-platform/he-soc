/*
 * filter.c — ported verbatim from crazyflie-firmware src/utils/src/filter.c
 * (commit ee39e61)
 *
 * physicalConstants.h replaced by compat shim that provides M_PI_F.
 */

#include <math.h>
#include <stdlib.h>

#include "filter.h"
#include "compat/physicalConstants.h"

int16_t iirLPFilterSingle(int32_t in, int32_t attenuation, int32_t* filt)
{
  int32_t inScaled;
  int32_t filttmp = *filt;
  int16_t out;

  if (attenuation > (1 << IIR_SHIFT))
    attenuation = (1 << IIR_SHIFT);
  else if (attenuation < 1)
    attenuation = 1;

  inScaled = in << IIR_SHIFT;
  filttmp  = filttmp + (((inScaled - filttmp) >> IIR_SHIFT) * attenuation);
  out      = (filttmp >> 8) + ((filttmp & (1 << (IIR_SHIFT - 1))) >> (IIR_SHIFT - 1));
  *filt    = filttmp;
  return out;
}

void lpf2pInit(lpf2pData* lpfData, float sample_freq, float cutoff_freq)
{
  if (lpfData == NULL || cutoff_freq <= 0.0f)
    return;
  lpf2pSetCutoffFreq(lpfData, sample_freq, cutoff_freq);
}

void lpf2pSetCutoffFreq(lpf2pData* lpfData, float sample_freq, float cutoff_freq)
{
  float fr  = sample_freq / cutoff_freq;
  float ohm = tanf(M_PI_F / fr);
  float c   = 1.0f + 2.0f * cosf(M_PI_F / 4.0f) * ohm + ohm * ohm;
  lpfData->b0 = ohm * ohm / c;
  lpfData->b1 = 2.0f * lpfData->b0;
  lpfData->b2 = lpfData->b0;
  lpfData->a1 = 2.0f * (ohm * ohm - 1.0f) / c;
  lpfData->a2 = (1.0f - 2.0f * cosf(M_PI_F / 4.0f) * ohm + ohm * ohm) / c;
  lpfData->delay_element_1 = 0.0f;
  lpfData->delay_element_2 = 0.0f;
}

float lpf2pApply(lpf2pData* lpfData, float sample)
{
  float delay_element_0 = sample
      - lpfData->delay_element_1 * lpfData->a1
      - lpfData->delay_element_2 * lpfData->a2;
  if (!isfinite(delay_element_0))
    delay_element_0 = sample;

  float output = delay_element_0 * lpfData->b0
      + lpfData->delay_element_1 * lpfData->b1
      + lpfData->delay_element_2 * lpfData->b2;

  lpfData->delay_element_2 = lpfData->delay_element_1;
  lpfData->delay_element_1 = delay_element_0;
  return output;
}

float lpf2pReset(lpf2pData* lpfData, float sample)
{
  float dval = sample / (lpfData->b0 + lpfData->b1 + lpfData->b2);
  lpfData->delay_element_1 = dval;
  lpfData->delay_element_2 = dval;
  return lpf2pApply(lpfData, sample);
}

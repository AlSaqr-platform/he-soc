/*
 * pid.c — ported verbatim from crazyflie-firmware src/utils/src/pid.c
 * (commit ee39e61)
 *
 * Changes from original:
 *  - autoconf.h replaced by compat shim (CONFIG_CONTROLLER_PID_FILTER_ALL
 *    is left undefined, so the non-filtered path is always used)
 *  - num.h replaced by compat shim
 */

#include "pid.h"
#include "compat/num.h"
#include <math.h>
#include <float.h>

/* CONFIG_CONTROLLER_PID_FILTER_ALL is not defined → standard path */

void pidInit(PidObject* pid, const float desired,
             const float kp, const float ki, const float kd, const float kff,
             const float dt, const float samplingRate, const float cutoffFreq,
             bool enableDFilter)
{
  pid->error         = 0;
  pid->prevMeasured  = 0;
  pid->integ         = 0;
  pid->deriv         = 0;
  pid->desired       = desired;
  pid->kp            = kp;
  pid->ki            = ki;
  pid->kd            = kd;
  pid->kff           = kff;
  pid->iLimit        = DEFAULT_PID_INTEGRATION_LIMIT;
  pid->outputLimit   = DEFAULT_PID_OUTPUT_LIMIT;
  pid->dt            = dt;
  pid->enableDFilter = enableDFilter;
  if (pid->enableDFilter)
    lpf2pInit(&pid->dFilter, samplingRate, cutoffFreq);
}

float pidUpdate(PidObject* pid, const float measured, const bool isYawAngle)
{
  float output = 0.0f;

  pid->error = pid->desired - measured;

  if (isYawAngle) {
    if      (pid->error >  180.0f) pid->error -= 360.0f;
    else if (pid->error < -180.0f) pid->error += 360.0f;
  }

  pid->outP  = pid->kp * pid->error;
  output    += pid->outP;

  float delta = -(measured - pid->prevMeasured);
  if (isYawAngle) {
    if      (delta >  180.0f) delta -= 360.0f;
    else if (delta < -180.0f) delta += 360.0f;
  }

  if (pid->enableDFilter)
    pid->deriv = lpf2pApply(&pid->dFilter, delta / pid->dt);
  else
    pid->deriv = delta / pid->dt;

  if (isnan(pid->deriv)) pid->deriv = 0;

  pid->outD  = pid->kd * pid->deriv;
  output    += pid->outD;

  pid->integ += pid->error * pid->dt;
  if (pid->iLimit != 0)
    pid->integ = constrain(pid->integ, -pid->iLimit, pid->iLimit);

  pid->outI  = pid->ki * pid->integ;
  output    += pid->outI;

  pid->outFF = pid->kff * pid->desired;
  output    += pid->outFF;

  if (pid->outputLimit != 0)
    output = constrain(output, -pid->outputLimit, pid->outputLimit);

  pid->prevMeasured = measured;
  return output;
}

void pidSetIntegralLimit(PidObject* pid, const float limit) { pid->iLimit = limit; }

void pidReset(PidObject* pid, const float actual)
{
  pid->error        = 0;
  pid->prevMeasured = actual;
  pid->integ        = 0;
  pid->deriv        = 0;
}

void  pidSetDesired(PidObject* pid, const float desired) { pid->desired = desired; }
float pidGetDesired(PidObject* pid)                      { return pid->desired; }

bool pidIsActive(PidObject* pid)
{
  return !(pid->kp < 0.0001f && pid->ki < 0.0001f && pid->kd < 0.0001f);
}

void pidSetKp(PidObject* pid, const float kp)   { pid->kp  = kp;  }
void pidSetKi(PidObject* pid, const float ki)   { pid->ki  = ki;  }
void pidSetKd(PidObject* pid, const float kd)   { pid->kd  = kd;  }
void pidSetKff(PidObject* pid, const float kff) { pid->kff = kff; }
void pidSetDt(PidObject* pid, const float dt)   { pid->dt  = dt;  }

void filterReset(PidObject* pid, const float samplingRate, const float cutoffFreq,
                 bool enableDFilter)
{
  pid->enableDFilter = enableDFilter;
  if (pid->enableDFilter)
    lpf2pInit(&pid->dFilter, samplingRate, cutoffFreq);
}

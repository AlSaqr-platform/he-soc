/*
 * pid.h — ported verbatim from crazyflie-firmware src/utils/interface/pid.h
 * (commit ee39e61)
 */
#pragma once

#include <stdbool.h>
#include "filter.h"

#define DEFAULT_PID_INTEGRATION_LIMIT  5000.0f
#define DEFAULT_PID_OUTPUT_LIMIT       0.0f

typedef struct {
  float desired;
  float error;
  float prevMeasured;
  float integ;
  float deriv;
  float kp;
  float ki;
  float kd;
  float kff;
  float outP;
  float outI;
  float outD;
  float outFF;
  float iLimit;
  float outputLimit;
  float dt;
  lpf2pData dFilter;
  bool  enableDFilter;
} PidObject;

void  pidInit(PidObject* pid, const float desired,
              const float kp, const float ki, const float kd, const float kff,
              const float dt, const float samplingRate, const float cutoffFreq,
              bool enableDFilter);
void  pidSetIntegralLimit(PidObject* pid, const float limit);
void  pidReset(PidObject* pid, float initial);
float pidUpdate(PidObject* pid, const float measured, const bool isYawAngle);
void  pidSetDesired(PidObject* pid, const float desired);
float pidGetDesired(PidObject* pid);
bool  pidIsActive(PidObject* pid);
void  pidSetKp(PidObject* pid, const float kp);
void  pidSetKi(PidObject* pid, const float ki);
void  pidSetKd(PidObject* pid, const float kd);
void  pidSetKff(PidObject* pid, const float kff);
void  pidSetDt(PidObject* pid, const float dt);
void  filterReset(PidObject* pid, const float samplingRate,
                  const float cutoffFreq, bool enableDFilter);

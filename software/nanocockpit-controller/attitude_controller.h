/*
 * attitude_controller.h — ported verbatim from crazyflie-firmware
 * src/modules/interface/controller/attitude_controller.h (commit ee39e61)
 */
#pragma once

#include <stdbool.h>
#include <stdint.h>

void attitudeControllerInit(const float updateDt);
bool attitudeControllerTest(void);

void attitudeControllerCorrectAttitudePID(
       float eulerRollActual,   float eulerPitchActual,   float eulerYawActual,
       float eulerRollDesired,  float eulerPitchDesired,  float eulerYawDesired,
       float* rollRateDesired, float* pitchRateDesired,  float* yawRateDesired);

void attitudeControllerCorrectRatePID(
       float rollRateActual,  float pitchRateActual,  float yawRateActual,
       float rollRateDesired, float pitchRateDesired, float yawRateDesired);

void attitudeControllerResetRollAttitudePID(float rollActual);
void attitudeControllerResetPitchAttitudePID(float pitchActual);
void attitudeControllerResetAllPID(float rollActual, float pitchActual, float yawActual);
void attitudeControllerGetActuatorOutput(int16_t* roll, int16_t* pitch, int16_t* yaw);
float attitudeControllerGetYawMaxDelta(void);

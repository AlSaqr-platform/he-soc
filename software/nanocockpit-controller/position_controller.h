/*
 * position_controller.h — ported verbatim from crazyflie-firmware
 * src/modules/interface/controller/position_controller.h (commit ee39e61)
 */
#pragma once

#include "compat/stabilizer_types.h"

void positionControllerInit(void);
void positionControllerResetAllPID(float xActual, float yActual, float zActual);
void positionControllerResetAllfilters(void);
void positionController(float* thrust, attitude_t* attitude,
                        const setpoint_t* setpoint, const state_t* state);
void velocityController(float* thrust, attitude_t* attitude,
                        const Axis3f* setpoint_velocity, const state_t* state);

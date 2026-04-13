/*
 * controller_pid.h — ported verbatim from crazyflie-firmware
 * src/modules/interface/controller/controller_pid.h (commit ee39e61)
 */
#pragma once

#include "compat/stabilizer_types.h"

void controllerPidInit(void);
bool controllerPidTest(void);
void controllerPid(control_t* control, const setpoint_t* setpoint,
                   const sensorData_t* sensors, const state_t* state,
                   const stabilizerStep_t stabilizerStep);

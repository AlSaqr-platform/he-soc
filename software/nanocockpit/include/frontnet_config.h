/*
 * frontnet_config.h
 * Elia Cereda <elia.cereda@idsia.ch>
 * Jérôme Guzzi <jerome@idsia.ch>
 *
 * Copyright (C) 2020-2025 IDSIA, USI-SUPSI
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * 
 * This software is based on the following publication:
 *    E. Cereda, A. Giusti, D. Palossi. "NanoCockpit: Performance-optimized 
 *    Application Framework for AI-based Autonomous Nanorobotics"
 * We kindly ask for a citation if you use in academic work.
 */

#pragma once

#include "FreeRTOS.h"

// FreeRTOS task configuration
#define FRONTNET_TASK_NAME "FRONTNET"
#define FRONTNET_STACKSIZE (2*configMINIMAL_STACK_SIZE)
#define FRONTNET_PRIORITY  (1)

#define FN_APPCHANNEL_TASK_NAME  "FN-APPCHANNEL"
#define FN_APPCHANNEL_STACK_SIZE (configMINIMAL_STACK_SIZE)
#define FN_APPCHANNEL_PRIORITY   (FRONTNET_PRIORITY)

#define STATE_FWD_TASK_NAME "STATE-FWD"
#define STATE_FWD_STACKSIZE (2*configMINIMAL_STACK_SIZE)
#define STATE_FWD_PRIORITY  (1)

// Match the velocity PID controller's rate [Hz]
#define FRONTNET_TIMER_RATE (100)

// Number of inferences considered to compute the average inference rate
#define FRONTNET_INFERENCE_RATE_PERIOD M2T(1000)
#define FRONTNET_PROFILE_KF_COUNT (10)

#define FRONTNET_COMMAND_TIMEOUT M2T(500)

// Time since last inference before control is disabled [ticks]
#define FRONTNET_INFERENCE_TIMEOUT M2T(750)

// Minimum battery voltage before control is disabled [V]
#define FRONTNET_MIN_BATTERY_VOLTAGE (2.9f)

// Kalman filter configuration
#define FRONTNET_KF_DEFAULT_CONFIG ((frontnet_kf_t){                                                             \
  .x   = {.angle = false, .r_xx = 0.012f, .q_vv = 16.0f /* (48/8)*2.7f */, .state = {.p_xx = 100.0f, .p_xv = 0.0f, .p_vv = 10.0f}}, \
  .y   = {.angle = false, .r_xx = 0.012f, .q_vv = 16.0f /* (48/8)*2.7f */, .state = {.p_xx = 100.0f, .p_xv = 0.0f, .p_vv = 10.0f}}, \
  .z   = {.angle = false, .r_xx = 0.024f, .q_vv = 6.0f  /* (48/8)*1.0f */, .state = {.p_xx = 100.0f, .p_xv = 0.0f, .p_vv = 10.0f}}, \
  .phi = {.angle =  true, .r_xx = 0.080f, .q_vv = 16.0f /* (48/8)*5.3f */, .state = {.p_xx =  10.0f, .p_xv = 0.0f, .p_vv = 10.0f}}, \
})

// Target pose configuration
#define FRONTNET_TARGET_DEFAULT_CONFIG ((frontnet_target_t){ \
  .horizontalDistance = 1.5f,                                \
  .altitude = 1.4f,                                          \
  .altitudeReference = GROUND_ALTITUDE_REF                   \
})

// Controller configuration
#define FRONTNET_CTRL_DEFAULT_CONFIG ((frontnet_ctrl_t){ \
  .linearTau = 1.0f,                                     \
  .linearK = 1.0f,                                       \
  .angularTau = 0.5f,                                    \
  .maxHorizontalSpeed = 4.8f,                            \
  .maxVerticalSpeed = 0.8f,                              \
  .maxAngularSpeed = 2.0f                                \
})

// Default: COMMANDER_PRIORITY_CRTP + 1, so that autonomous commands override the user's remote control.
// Alternative: COMMANDER_PRIORITY_AUTONOMOUS. Priority COMMANDER_PRIORITY_AUTONOMOUS = 1 is lower than
// COMMANDER_PRIORITY_CRTP = 2, so that external setpoints (CRTP) always override autonomous control.
// However, it requires changes to cfclient so that it does not send commands when the user is not 
// actively controlling the drone.
#define FRONTNET_SETPOINT_PRIORITY (COMMANDER_PRIORITY_CRTP + 1)

// Rate for state forwarding to GAP8 [Hz]
#define STATE_FWD_RATE (100)

// State history count [samples]
#define STATE_FWD_HISTORY_COUNT (100)

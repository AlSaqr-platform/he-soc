/*
 * frontnet_ctrl.h
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

#include "frontnet_types.h"

typedef enum {
    FRONTNET_CTRL_MODE = 0,
    HOVER_CTRL_MODE = 1,
    LAND_CTRL_MODE = 2
} ctrl_mode_e;

typedef struct frontnet_ctrl_s {
    // TODO: find better names
    float linearTau;          // [s]
    float linearK;            // [scalar]
    float angularTau;         // [s]
  
    float maxVerticalSpeed;   // [m/s]
    float maxHorizontalSpeed; // [m/s]
    float maxAngularSpeed;    // [rad/s]
} frontnet_ctrl_t;

void frontnetSetpointUpdate(const frontnet_ctrl_t *config, const odometry_t *targetOdom, const state_t *state, setpoint_t *setpoint);
void hoverSetpointUpdate(const pose_t *hoverPose, const state_t *state, setpoint_t *setpoint);
void landSetpointUpdate(const frontnet_ctrl_t *config, const state_t *state, setpoint_t *setpoint);

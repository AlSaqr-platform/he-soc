/*
 * frontnet_ctrl.c
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

#include "frontnet_ctrl.h"
#include "frontnet_types.h"

static velocity_t desiredLinearVelocity(const frontnet_ctrl_t *config, const odometry_t *targetOdom, const state_t *state) {
  const point_t *targetPos = &targetOdom->pose.position;
  const velocity_t *targetVel = &targetOdom->twist.linear;

  velocity_t vel = {
    .x = (targetPos->x - state->position.x) / config->linearTau + config->linearK * targetVel->x,
    .y = (targetPos->y - state->position.y) / config->linearTau + config->linearK * targetVel->y,
    .z = (targetPos->z - state->position.z) / config->linearTau,
  };

  // Rescale x and y velocities so that their magnitude is clamped to maxHorizontalSpeed
  float horizontalSpeed = sqrtf(fsqr(vel.x) + fsqr(vel.y));
  if (horizontalSpeed > config->maxHorizontalSpeed) {
    vel.x *= config->maxHorizontalSpeed / horizontalSpeed;
    vel.y *= config->maxHorizontalSpeed / horizontalSpeed;
  }

  // Vertical speed can be clamped directly
  vel.z = clamp(vel.z, -config->maxVerticalSpeed, config->maxVerticalSpeed);
  
  return vel;
}

static float desiredYawRate(const frontnet_ctrl_t *ctrl, const odometry_t *targetOdom, const state_t *state) {
  // NOTE: the firmware uses degrees and degree/s for attitudes and attitude rates in its data types (state_t and setpoint_t)
  const attitude_t *targetAtt = &targetOdom->pose.attitude;

  float yawRate = normalizeAngle(targetAtt->yaw - radians(state->attitude.yaw)) / ctrl->angularTau;
  yawRate = clamp(yawRate, -ctrl->maxAngularSpeed, ctrl->maxAngularSpeed);
  return yawRate;
}

void frontnetSetpointUpdate(const frontnet_ctrl_t *config, const odometry_t *targetOdom, const state_t *state, setpoint_t *setpoint) {
  // NOTE: the firmware uses degrees and degree/s for attitudes and attitude rates in its data types (state_t and setpoint_t)
  setpoint->velocity = desiredLinearVelocity(config, targetOdom, state);
  setpoint->attitudeRate.yaw = degrees(desiredYawRate(config, targetOdom, state));
  setpoint->timestamp = state->position.timestamp;

  setpoint->mode.x = modeVelocity;
  setpoint->mode.y = modeVelocity;
  setpoint->mode.z = modeVelocity;
  setpoint->mode.yaw = modeVelocity;
  setpoint->velocity_body = false;
}

void hoverSetpointUpdate(const pose_t *hoverPose, const state_t *state, setpoint_t *setpoint) {
  setpoint->position.x = hoverPose->position.x;
  setpoint->position.y = hoverPose->position.y;
  setpoint->position.z = hoverPose->position.z;
  setpoint->attitude.yaw = hoverPose->attitude.yaw;
  setpoint->timestamp = state->position.timestamp;

  setpoint->mode.x = modeAbs;
  setpoint->mode.y = modeAbs;
  setpoint->mode.z = modeAbs;
  setpoint->mode.yaw = modeAbs;
  setpoint->velocity_body = false;
}

void landSetpointUpdate(const frontnet_ctrl_t *config, const state_t *state, setpoint_t *setpoint) {
  float currentHeight = state->position.z;
  float targetHeight = 0.1f;
  float desiredVelocity = (targetHeight - currentHeight) / config->linearTau;

  setpoint->velocity.x = 0.0f;
  setpoint->velocity.y = 0.0f;
  setpoint->velocity.z = clamp(desiredVelocity, -config->maxVerticalSpeed, config->maxVerticalSpeed);
  setpoint->attitudeRate.yaw = 0.0f;
  setpoint->timestamp = state->position.timestamp;

  setpoint->mode.x = modeVelocity;
  setpoint->mode.y = modeVelocity;
  setpoint->mode.z = modeVelocity;
  setpoint->mode.yaw = modeVelocity;
  setpoint->velocity_body = false;
}

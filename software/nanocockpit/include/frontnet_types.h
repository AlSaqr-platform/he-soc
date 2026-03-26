/*
 * frontnet_types.h
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

#include "math3d.h"
#include "stabilizer_types.h"

typedef enum {
  GROUND_ALTITUDE_REF = 0,
  SUBJECT_ALTITUDE_REF = 1
} altitude_ref_e;

typedef struct frontnet_target_s {
  float horizontalDistance;  // [m]
  float altitude;            // [m]
  altitude_ref_e altitudeReference;
} frontnet_target_t;

// TODO: do not use point_t and attitude_t: 1) each of them is stamped individually, 2) attitude would 
// be defined in degrees by cf but we use it in radians.
// Pose in free space, broken down in position and orientation, based on geometry_msgs/Pose from ROS
typedef struct pose_s {
  point_t position;    // [m]
  attitude_t attitude; // [rad]
} pose_t;

// Velocity in free space, broken down in linear and angular velocities, based geometry_msgs/Twist from ROS
typedef struct twist_s {
  velocity_t linear;   // [m/s]
  attitude_t angular;  // [rad/s]
} twist_t;

// Estimate of a pose and velocity in free space, based on nav_msgs/Odometry from ROS
typedef struct odometry_s {
  pose_t pose;
  twist_t twist;
} odometry_t;

#define MIN(x, y) ((x <= y) ? x : y)

static inline float normalizeAngle(float alpha) {
  alpha = fmodf(alpha, 2 * M_PI_F);

  if (alpha > M_PI_F) {
    alpha -= 2 * M_PI_F;
  } else if (alpha < -M_PI_F) {
    alpha += 2 * M_PI_F;
  }
  
  return alpha;
}

static inline void setPoseFromState(pose_t *pose, const state_t *state) {
  *pose = (pose_t){
    .position = state->position,
    .attitude = state->attitude
  };
}

static inline void setOdomFromPose(odometry_t *odom, const pose_t *pose) {
  *odom = (odometry_t){
    .pose = *pose,
    .twist = {{0,0,0,0}, {0,0,0,0}}
  };
}

/*
 * frontnet_kf.h
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

// We model the drone dynamics and inference prediction as a stochastic linear 
// process with normally-distributed and zero-mean noise. More precisely, we 
// call (p_n, v_n) the position and velocity of the human subject and o_n the
// inference prediction, at time t_n and w.r.t. the drone's odometry frame.
// We assume that: 
//    p_{n+1} = p_n + v_n * (t_{n+1} − t_n)
//    v_{n+1} = v_n +   a * (t_{n+1} − t_n)
//    o_n = p_n + e
// where the acceleration a ∈ R^4 has zero mean and covariance Q, and the 
// observation error e ∈ R^3 × S^1 has zero mean and covariance R.
// We make two further assumptions: the processes are isotropic and invariant,
// i.e., covariances Q and R are constant and diagonal.
// We can then decouple the Kalman filters for each component at the cost of 
// neglecting that predictions, w.r.t. the drone longitudinal and lateral axis, 
// have slightly different MSE and that errors depend on the human subject 
// relative position.
// 
// Terminology: https://en.wikipedia.org/wiki/Kalman_filter
#pragma once

#include "frontnet_types.h"

#include <stdint.h>

typedef struct kf_d1_state_s {
  // Position
  float x;  // [m] or [rad]
  
  // Velocity
  float v;  // [m/s] or [rad/s]

  // Covariance
  float p_xx;
  float p_vv;
  float p_xv;
} kf_d1_state_t;

// Decoupled Kalman filter 
typedef struct kf_d1_s {
  // The estimated component is an angle which should be normalized to [-pi; pi]
  bool angle;
  
  // Variance of observation noise (i.e., inference)
  float r_xx;

  // Variance of process noise (i.e., acceleration)
  float q_vv;
  
  // Current state estimate
  kf_d1_state_t state;
} kf_d1_t;

typedef struct frontnet_kf_s {
  // Disable Kalman filter and return the subject pose unfiltered, for test purposes
  bool bypassFilter;

  kf_d1_t x;
  kf_d1_t y;
  kf_d1_t z;
  kf_d1_t phi;

  uint32_t lastUpdate;
} frontnet_kf_t;

void frontnetKfUpdate(frontnet_kf_t *kf, const pose_t *subjectPose, odometry_t *subjectOdom);

/*
 * frontnet_kf.c
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

#include "frontnet_kf.h"
#include "frontnet_types.h"

#include "FreeRTOS.h"

#include "math3d.h"

#include <stdbool.h>
#include <stdint.h>

static void kfD1Update(kf_d1_t *kf, float xNew, float dt) {
  float q_vv = kf->q_vv * fsqr(dt);

  float x_ = kf->state.x + kf->state.v * dt;
  float v_ = kf->state.v;
  float p_xx_ = kf->state.p_xx + 2 * kf->state.p_xv * dt + kf->state.p_vv * fsqr(dt);
  float p_xv_ =                      kf->state.p_xv      + kf->state.p_vv * dt;
  float p_vv_ =                                            kf->state.p_vv             + q_vv;

  float y = xNew - x_;
  float s = kf->r_xx + p_xx_;

  if (kf->angle) {
    y = normalizeAngle(y);
  }

  kf->state.x = x_ + y * p_xx_ / s;
  kf->state.v = v_ + y * p_xv_ / s;
  kf->state.p_xx = p_xx_ - p_xx_ * p_xx_ / s;
  kf->state.p_xv = p_xv_ - p_xx_ * p_xv_ / s;
  kf->state.p_vv = p_vv_ - p_xv_ * p_xv_ / s;
}

void frontnetKfUpdate(frontnet_kf_t *kf, const pose_t *subjectPose, odometry_t *subjectOdom) {
  if (kf->bypassFilter) {
    setOdomFromPose(subjectOdom, subjectPose);
    return;
  }

  uint32_t timestamp = subjectPose->position.timestamp;
  float dt = 0.0f;
  if (kf->lastUpdate) {
    dt = ((float)T2M(timestamp - kf->lastUpdate)) / 1000.0f;
  }

  kfD1Update(  &kf->x,   subjectPose->position.x, dt);
  kfD1Update(  &kf->y,   subjectPose->position.y, dt);
  kfD1Update(  &kf->z,   subjectPose->position.z, dt);
  kfD1Update(&kf->phi, subjectPose->attitude.yaw, dt);

  kf->lastUpdate = timestamp;

  *subjectOdom = (odometry_t){
    .pose = {
      .position.timestamp = timestamp,
      .position.x = kf->x.state.x,
      .position.y = kf->y.state.x,
      .position.z = kf->z.state.x,

      .attitude.timestamp = timestamp,
      .attitude.roll  = 0.0f,
      .attitude.pitch = 0.0f,
      .attitude.yaw   = kf->phi.state.x,
    },

    .twist = {
      .linear.timestamp = timestamp,
      .linear.x = kf->x.state.v,
      .linear.y = kf->y.state.v,
      .linear.z = kf->z.state.v,

      .angular.timestamp = timestamp,
      .angular.roll  = 0.0f,
      .angular.pitch = 0.0f,
      .angular.yaw   = kf->phi.state.v,
    }
  };
}

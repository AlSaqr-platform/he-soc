/*
 * math3d.h — portable shim for nanocockpit-controller
 *
 * Provides scalar helpers and the vec/quat types used by controller_pid.c.
 */
#pragma once

#include <math.h>

#ifndef M_PI_F
#define M_PI_F   (3.14159265358979323846f)
#endif
#ifndef M_PI_2_F
#define M_PI_2_F (1.57079632679f)
#endif

static inline float radians(float deg) { return (M_PI_F / 180.0f) * deg; }
static inline float degrees(float rad) { return (180.0f / M_PI_F) * rad; }

/* ── 3-vector ── */

struct vec {
  float x, y, z;
};

static inline struct vec mkvec(float x, float y, float z) {
  return (struct vec){x, y, z};
}

/* ── quaternion ── */

struct quat {
  float x, y, z, w;
};

static inline struct quat mkquat(float x, float y, float z, float w) {
  return (struct quat){x, y, z, w};
}

/* Convert quaternion to roll/pitch/yaw (radians) */
static inline struct vec quat2rpy(struct quat q) {
  float roll  = atan2f(2.0f * (q.w * q.x + q.y * q.z),
                       1.0f - 2.0f * (q.x * q.x + q.y * q.y));
  float sinp  = 2.0f * (q.w * q.y - q.z * q.x);
  float pitch = (fabsf(sinp) >= 1.0f) ? copysignf(M_PI_2_F, sinp) : asinf(sinp);
  float yaw   = atan2f(2.0f * (q.w * q.z + q.x * q.y),
                       1.0f - 2.0f * (q.y * q.y + q.z * q.z));
  return mkvec(roll, pitch, yaw);
}

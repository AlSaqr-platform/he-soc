/*
 * stabilizer_types.h — portable shim
 *
 * Provides the subset of crazyflie-firmware's stabilizer_types.h used
 * by the frontnet pipeline. Struct layouts match the originals.
 */

#pragma once

#include <stdbool.h>
#include <stdint.h>

/* ── vec3 / point / velocity / acc ── */

struct vec3_s {
  uint32_t timestamp;
  float x;
  float y;
  float z;
};

typedef struct vec3_s point_t;
typedef struct vec3_s velocity_t;
typedef struct vec3_s acc_t;

/* ── attitude ── */

typedef struct attitude_s {
  uint32_t timestamp;
  float roll;
  float pitch;
  float yaw;
} attitude_t;

/* ── quaternion ── */

typedef struct quaternion_s {
  union {
    struct { float q0; float q1; float q2; float q3; };
    struct { float x;  float y;  float z;  float w;  };
  };
} quaternion_t;

/* ── state ── */

typedef struct state_s {
  attitude_t attitude;            /* deg  */
  quaternion_t attitudeQuaternion;
  point_t position;               /* m    */
  velocity_t velocity;            /* m/s  */
  acc_t acc;                      /* Gs   */
} state_t;

/* ── stabilizer mode ── */

typedef enum mode_e {
  modeDisable = 0,
  modeAbs,
  modeVelocity
} stab_mode_t;

/* ── setpoint ── */

typedef struct setpoint_s {
  uint32_t timestamp;
  attitude_t attitude;            /* deg   */
  attitude_t attitudeRate;        /* deg/s */
  quaternion_t attitudeQuaternion;
  float thrust;
  point_t position;               /* m     */
  velocity_t velocity;            /* m/s   */
  acc_t acceleration;             /* m/s^2 */
  bool velocity_body;
  struct {
    stab_mode_t x;
    stab_mode_t y;
    stab_mode_t z;
    stab_mode_t roll;
    stab_mode_t pitch;
    stab_mode_t yaw;
    stab_mode_t quat;
  } mode;
} setpoint_t;

/* ── compressed state (unused by pipeline, provided for header compat) ── */

typedef struct stateCompressed_s {
  uint32_t timestamp;
  int16_t x, y, z;
  int16_t vx, vy, vz;
  int16_t ax, ay, az;
  int32_t quat;
  int16_t rateRoll, ratePitch, rateYaw;
} __attribute__((packed)) stateCompressed_t;

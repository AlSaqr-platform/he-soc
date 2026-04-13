/*
 * stabilizer_types.h — portable shim for nanocockpit-controller
 *
 * Full set of types needed by the PID controller stack.
 * Struct layouts match the crazyflie-firmware originals.
 */
#pragma once

#include <stdbool.h>
#include <stdint.h>

/* ── Axis3f (from imu_types.h) ── */

typedef union {
  struct { float x; float y; float z; };
  float axis[3];
} Axis3f;

/* ── vec3 / point / velocity / acc / jerk ── */

struct vec3_s {
  uint32_t timestamp;
  float x;
  float y;
  float z;
};

typedef struct vec3_s point_t;
typedef struct vec3_s velocity_t;
typedef struct vec3_s acc_t;
typedef struct vec3_s jerk_t;

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

/* ── baro ── */

typedef struct baro_s {
  float pressure;     /* mbar */
  float temperature;  /* degree Celsius */
  float asl;          /* m (ASL) */
} baro_t;

/* ── sensor data ── */

typedef struct sensorData_s {
  Axis3f acc;   /* Gs */
  Axis3f gyro;  /* deg/s */
  Axis3f mag;   /* gauss */
  baro_t baro;
  uint64_t interruptTimestamp;
} sensorData_t;

/* ── state ── */

typedef struct state_s {
  attitude_t attitude;            /* deg (legacy CF2 body frame, pitch inverted) */
  quaternion_t attitudeQuaternion;
  point_t    position;            /* m */
  velocity_t velocity;            /* m/s */
  acc_t      acc;                 /* Gs (without gravity) */
} state_t;

/* ── control ── */

#define STABILIZER_NR_OF_MOTORS 4

typedef enum control_mode_e {
  controlModeLegacy      = 0,
  controlModeForceTorque = 1,
  controlModeForce       = 2,
  controlModePWM         = 3,
} control_mode_t;

typedef struct control_s {
  union {
    struct { int16_t roll; int16_t pitch; int16_t yaw; float thrust; }; /* controlModeLegacy */
    struct {
      float thrustSi;
      union { float torque[3]; struct { float torqueX; float torqueY; float torqueZ; }; };
    };
    float normalizedForces[STABILIZER_NR_OF_MOTORS];
  };
  control_mode_t controlMode;
} control_t;

/* ── stabilizer mode ── */

typedef enum mode_e {
  modeDisable  = 0,
  modeAbs,
  modeVelocity
} stab_mode_t;

/* ── setpoint ── */

typedef struct setpoint_s {
  uint32_t    timestamp;
  attitude_t  attitude;           /* deg */
  attitude_t  attitudeRate;       /* deg/s */
  quaternion_t attitudeQuaternion;
  float       thrust;
  point_t     position;           /* m */
  velocity_t  velocity;           /* m/s */
  acc_t       acceleration;       /* m/s^2 */
  jerk_t      jerk;               /* m/s^3 */
  bool        velocity_body;
  struct {
    stab_mode_t x, y, z, roll, pitch, yaw, quat;
  } mode;
} setpoint_t;

/* ── stabilizer step ── */

typedef uint32_t stabilizerStep_t;

/* ── loop rates ── */

#define RATE_1000_HZ 1000
#define RATE_500_HZ   500
#define RATE_250_HZ   250
#define RATE_100_HZ   100
#define RATE_50_HZ     50
#define RATE_25_HZ     25

#define RATE_MAIN_LOOP   RATE_1000_HZ
#define ATTITUDE_RATE    RATE_500_HZ
#define POSITION_RATE    RATE_100_HZ

#define RATE_DO_EXECUTE(RATE_HZ, TICK) ((TICK % (RATE_MAIN_LOOP / RATE_HZ)) == 0)

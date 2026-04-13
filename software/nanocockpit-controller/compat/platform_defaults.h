/*
 * platform_defaults.h — portable shim for nanocockpit-controller
 *
 * Baked-in CF2 platform defaults. Replaces the autoconf-driven
 * platform_defaults.h + platform_defaults_cf2.h include chain.
 */
#pragma once

/* ── Attitude PID filter settings ── */
#define ATTITUDE_LPF_CUTOFF_FREQ              15.0f
#define ATTITUDE_LPF_ENABLE                   false
#define ATTITUDE_ROLL_RATE_LPF_CUTOFF_FREQ    30.0f
#define ATTITUDE_PITCH_RATE_LPF_CUTOFF_FREQ   30.0f
#define ATTITUDE_YAW_RATE_LPF_CUTOFF_FREQ     30.0f
#define ATTITUDE_RATE_LPF_ENABLE              false
#define YAW_MAX_DELTA                         0.0f

/* ── Position PID filter settings ── */
#define PID_POS_XY_FILT_ENABLE    true
#define PID_POS_XY_FILT_CUTOFF    20.0f
#define PID_POS_Z_FILT_ENABLE     true
#define PID_POS_Z_FILT_CUTOFF     20.0f
#define PID_VEL_XY_FILT_ENABLE    true
#define PID_VEL_XY_FILT_CUTOFF    20.0f
#define PID_VEL_Z_FILT_ENABLE     true
#define PID_VEL_Z_FILT_CUTOFF     20.0f

/* ── Attitude rate PID gains (CF2) ── */
#define PID_ROLL_RATE_KP   250.0f
#define PID_ROLL_RATE_KI   500.0f
#define PID_ROLL_RATE_KD   2.5f
#define PID_ROLL_RATE_KFF  0.0f
#define PID_ROLL_RATE_INTEGRATION_LIMIT    33.3f

#define PID_PITCH_RATE_KP   250.0f
#define PID_PITCH_RATE_KI   500.0f
#define PID_PITCH_RATE_KD   2.5f
#define PID_PITCH_RATE_KFF  0.0f
#define PID_PITCH_RATE_INTEGRATION_LIMIT   33.3f

#define PID_YAW_RATE_KP   120.0f
#define PID_YAW_RATE_KI   16.7f
#define PID_YAW_RATE_KD   0.0f
#define PID_YAW_RATE_KFF  0.0f
#define PID_YAW_RATE_INTEGRATION_LIMIT     166.7f

/* ── Attitude angle PID gains (CF2) ── */
#define PID_ROLL_KP   6.0f
#define PID_ROLL_KI   3.0f
#define PID_ROLL_KD   0.0f
#define PID_ROLL_KFF  0.0f
#define PID_ROLL_INTEGRATION_LIMIT    20.0f

#define PID_PITCH_KP   6.0f
#define PID_PITCH_KI   3.0f
#define PID_PITCH_KD   0.0f
#define PID_PITCH_KFF  0.0f
#define PID_PITCH_INTEGRATION_LIMIT   20.0f

#define PID_YAW_KP   6.0f
#define PID_YAW_KI   1.0f
#define PID_YAW_KD   0.35f
#define PID_YAW_KFF  0.0f
#define PID_YAW_INTEGRATION_LIMIT     360.0f

/* ── Velocity PID gains (CF2) ── */
#define PID_VEL_X_KP   25.0f
#define PID_VEL_X_KI   1.0f
#define PID_VEL_X_KD   0.0f
#define PID_VEL_X_KFF  0.0f

#define PID_VEL_Y_KP   25.0f
#define PID_VEL_Y_KI   1.0f
#define PID_VEL_Y_KD   0.0f
#define PID_VEL_Y_KFF  0.0f

#define PID_VEL_Z_KP   25.0f
#define PID_VEL_Z_KI   15.0f
#define PID_VEL_Z_KD   0.0f
#define PID_VEL_Z_KFF  0.0f

#define PID_VEL_ROLL_MAX    20.0f
#define PID_VEL_PITCH_MAX   20.0f
#define PID_VEL_THRUST_BASE 36000.0f
#define PID_VEL_THRUST_MIN  20000.0f

/* ── Position PID gains (CF2) ── */
#define PID_POS_X_KP   2.0f
#define PID_POS_X_KI   0.0f
#define PID_POS_X_KD   0.0f
#define PID_POS_X_KFF  0.0f

#define PID_POS_Y_KP   2.0f
#define PID_POS_Y_KI   0.0f
#define PID_POS_Y_KD   0.0f
#define PID_POS_Y_KFF  0.0f

#define PID_POS_Z_KP   2.0f
#define PID_POS_Z_KI   0.5f
#define PID_POS_Z_KD   0.0f
#define PID_POS_Z_KFF  0.0f

#define PID_POS_VEL_X_MAX  1.0f
#define PID_POS_VEL_Y_MAX  1.0f
#define PID_POS_VEL_Z_MAX  1.0f

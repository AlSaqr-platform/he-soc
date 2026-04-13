/*
 * attitude_pid_controller.c — ported verbatim from crazyflie-firmware
 * src/modules/src/controller/attitude_pid_controller.c (commit ee39e61)
 *
 * Changes from original:
 *  - log.h, param.h, commander.h → compat shims (all macros expand to nothing)
 *  - platform_defaults.h → compat shim with baked-in CF2 defaults
 *  - LOG_GROUP_START/STOP, PARAM_GROUP_START/STOP blocks kept but expand to nothing
 */
#include <stdbool.h>
#include <stdint.h>

#include "compat/stabilizer_types.h"
#include "attitude_controller.h"
#include "pid.h"
#include "compat/param.h"
#include "compat/log.h"
#include "compat/commander.h"
#include "compat/platform_defaults.h"

static bool attFiltEnable   = ATTITUDE_LPF_ENABLE;
static bool rateFiltEnable  = ATTITUDE_RATE_LPF_ENABLE;
static float attFiltCutoff  = ATTITUDE_LPF_CUTOFF_FREQ;
static float omxFiltCutoff  = ATTITUDE_ROLL_RATE_LPF_CUTOFF_FREQ;
static float omyFiltCutoff  = ATTITUDE_PITCH_RATE_LPF_CUTOFF_FREQ;
static float omzFiltCutoff  = ATTITUDE_YAW_RATE_LPF_CUTOFF_FREQ;
static float yawMaxDelta    = YAW_MAX_DELTA;

static inline int16_t saturateSignedInt16(float in)
{
  if      (in >  INT16_MAX) return  INT16_MAX;
  else if (in < -INT16_MAX) return -INT16_MAX;
  else                      return (int16_t)in;
}

PidObject pidRollRate  = { .kp = PID_ROLL_RATE_KP,  .ki = PID_ROLL_RATE_KI,
                           .kd = PID_ROLL_RATE_KD,   .kff = PID_ROLL_RATE_KFF };
PidObject pidPitchRate = { .kp = PID_PITCH_RATE_KP, .ki = PID_PITCH_RATE_KI,
                           .kd = PID_PITCH_RATE_KD,  .kff = PID_PITCH_RATE_KFF };
PidObject pidYawRate   = { .kp = PID_YAW_RATE_KP,   .ki = PID_YAW_RATE_KI,
                           .kd = PID_YAW_RATE_KD,    .kff = PID_YAW_RATE_KFF };

PidObject pidRoll  = { .kp = PID_ROLL_KP,  .ki = PID_ROLL_KI,
                       .kd = PID_ROLL_KD,   .kff = PID_ROLL_KFF };
PidObject pidPitch = { .kp = PID_PITCH_KP, .ki = PID_PITCH_KI,
                       .kd = PID_PITCH_KD,  .kff = PID_PITCH_KFF };
PidObject pidYaw   = { .kp = PID_YAW_KP,   .ki = PID_YAW_KI,
                       .kd = PID_YAW_KD,    .kff = PID_YAW_KFF };

static int16_t rollOutput;
static int16_t pitchOutput;
static int16_t yawOutput;

static bool isInit;

void attitudeControllerInit(const float updateDt)
{
  if (isInit) return;

  pidInit(&pidRollRate,  0, pidRollRate.kp,  pidRollRate.ki,  pidRollRate.kd,
          pidRollRate.kff,  updateDt, ATTITUDE_RATE, omxFiltCutoff, rateFiltEnable);
  pidInit(&pidPitchRate, 0, pidPitchRate.kp, pidPitchRate.ki, pidPitchRate.kd,
          pidPitchRate.kff, updateDt, ATTITUDE_RATE, omyFiltCutoff, rateFiltEnable);
  pidInit(&pidYawRate,   0, pidYawRate.kp,   pidYawRate.ki,   pidYawRate.kd,
          pidYawRate.kff,   updateDt, ATTITUDE_RATE, omzFiltCutoff, rateFiltEnable);

  pidSetIntegralLimit(&pidRollRate,  PID_ROLL_RATE_INTEGRATION_LIMIT);
  pidSetIntegralLimit(&pidPitchRate, PID_PITCH_RATE_INTEGRATION_LIMIT);
  pidSetIntegralLimit(&pidYawRate,   PID_YAW_RATE_INTEGRATION_LIMIT);

  pidInit(&pidRoll,  0, pidRoll.kp,  pidRoll.ki,  pidRoll.kd,  pidRoll.kff,
          updateDt, ATTITUDE_RATE, attFiltCutoff, attFiltEnable);
  pidInit(&pidPitch, 0, pidPitch.kp, pidPitch.ki, pidPitch.kd, pidPitch.kff,
          updateDt, ATTITUDE_RATE, attFiltCutoff, attFiltEnable);
  pidInit(&pidYaw,   0, pidYaw.kp,   pidYaw.ki,   pidYaw.kd,   pidYaw.kff,
          updateDt, ATTITUDE_RATE, attFiltCutoff, attFiltEnable);

  pidSetIntegralLimit(&pidRoll,  PID_ROLL_INTEGRATION_LIMIT);
  pidSetIntegralLimit(&pidPitch, PID_PITCH_INTEGRATION_LIMIT);
  pidSetIntegralLimit(&pidYaw,   PID_YAW_INTEGRATION_LIMIT);

  isInit = true;
}

bool attitudeControllerTest(void) { return isInit; }

void attitudeControllerCorrectRatePID(
       float rollRateActual,  float pitchRateActual,  float yawRateActual,
       float rollRateDesired, float pitchRateDesired, float yawRateDesired)
{
  pidSetDesired(&pidRollRate, rollRateDesired);
  rollOutput  = saturateSignedInt16(pidUpdate(&pidRollRate,  rollRateActual,  false));

  pidSetDesired(&pidPitchRate, pitchRateDesired);
  pitchOutput = saturateSignedInt16(pidUpdate(&pidPitchRate, pitchRateActual, false));

  pidSetDesired(&pidYawRate, yawRateDesired);
  yawOutput   = saturateSignedInt16(pidUpdate(&pidYawRate,   yawRateActual,   false));
}

void attitudeControllerCorrectAttitudePID(
       float eulerRollActual,  float eulerPitchActual,  float eulerYawActual,
       float eulerRollDesired, float eulerPitchDesired, float eulerYawDesired,
       float* rollRateDesired, float* pitchRateDesired, float* yawRateDesired)
{
  pidSetDesired(&pidRoll, eulerRollDesired);
  *rollRateDesired  = pidUpdate(&pidRoll,  eulerRollActual,  false);

  pidSetDesired(&pidPitch, eulerPitchDesired);
  *pitchRateDesired = pidUpdate(&pidPitch, eulerPitchActual, false);

  pidSetDesired(&pidYaw, eulerYawDesired);
  *yawRateDesired   = pidUpdate(&pidYaw,   eulerYawActual,   true);
}

void attitudeControllerResetRollAttitudePID(float rollActual)   { pidReset(&pidRoll,  rollActual);  }
void attitudeControllerResetPitchAttitudePID(float pitchActual) { pidReset(&pidPitch, pitchActual); }

void attitudeControllerResetAllPID(float rollActual, float pitchActual, float yawActual)
{
  pidReset(&pidRoll,      rollActual);
  pidReset(&pidPitch,     pitchActual);
  pidReset(&pidYaw,       yawActual);
  pidReset(&pidRollRate,  0);
  pidReset(&pidPitchRate, 0);
  pidReset(&pidYawRate,   0);
}

void attitudeControllerGetActuatorOutput(int16_t* roll, int16_t* pitch, int16_t* yaw)
{
  *roll  = rollOutput;
  *pitch = pitchOutput;
  *yaw   = yawOutput;
}

float attitudeControllerGetYawMaxDelta(void) { return yawMaxDelta; }

LOG_GROUP_START(pid_attitude)
LOG_ADD(LOG_FLOAT, roll_outP,  &pidRoll.outP)
LOG_ADD(LOG_FLOAT, roll_outI,  &pidRoll.outI)
LOG_ADD(LOG_FLOAT, roll_outD,  &pidRoll.outD)
LOG_ADD(LOG_FLOAT, roll_outFF, &pidRoll.outFF)
LOG_ADD(LOG_FLOAT, pitch_outP,  &pidPitch.outP)
LOG_ADD(LOG_FLOAT, pitch_outI,  &pidPitch.outI)
LOG_ADD(LOG_FLOAT, pitch_outD,  &pidPitch.outD)
LOG_ADD(LOG_FLOAT, pitch_outFF, &pidPitch.outFF)
LOG_ADD(LOG_FLOAT, yaw_outP,  &pidYaw.outP)
LOG_ADD(LOG_FLOAT, yaw_outI,  &pidYaw.outI)
LOG_ADD(LOG_FLOAT, yaw_outD,  &pidYaw.outD)
LOG_ADD(LOG_FLOAT, yaw_outFF, &pidYaw.outFF)
LOG_GROUP_STOP(pid_attitude)

LOG_GROUP_START(pid_rate)
LOG_ADD(LOG_FLOAT, roll_outP,  &pidRollRate.outP)
LOG_ADD(LOG_FLOAT, roll_outI,  &pidRollRate.outI)
LOG_ADD(LOG_FLOAT, roll_outD,  &pidRollRate.outD)
LOG_ADD(LOG_FLOAT, roll_outFF, &pidRollRate.outFF)
LOG_ADD(LOG_FLOAT, pitch_outP,  &pidPitchRate.outP)
LOG_ADD(LOG_FLOAT, pitch_outI,  &pidPitchRate.outI)
LOG_ADD(LOG_FLOAT, pitch_outD,  &pidPitchRate.outD)
LOG_ADD(LOG_FLOAT, pitch_outFF, &pidPitchRate.outFF)
LOG_ADD(LOG_FLOAT, yaw_outP,  &pidYawRate.outP)
LOG_ADD(LOG_FLOAT, yaw_outI,  &pidYawRate.outI)
LOG_ADD(LOG_FLOAT, yaw_outD,  &pidYawRate.outD)
LOG_ADD(LOG_FLOAT, yaw_outFF, &pidYawRate.outFF)
LOG_GROUP_STOP(pid_rate)

PARAM_GROUP_START(pid_attitude)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_kp,  &pidRoll.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_ki,  &pidRoll.ki)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_kd,  &pidRoll.kd)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_kff, &pidRoll.kff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_kp,  &pidPitch.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_ki,  &pidPitch.ki)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_kd,  &pidPitch.kd)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_kff, &pidPitch.kff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_kp,  &pidYaw.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_ki,  &pidYaw.ki)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_kd,  &pidYaw.kd)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_kff, &pidYaw.kff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yawMaxDelta, &yawMaxDelta)
PARAM_ADD(PARAM_INT8  | PARAM_PERSISTENT, attFiltEn,  &attFiltEnable)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, attFiltCut, &attFiltCutoff)
PARAM_GROUP_STOP(pid_attitude)

PARAM_GROUP_START(pid_rate)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_kp,  &pidRollRate.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_ki,  &pidRollRate.ki)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_kd,  &pidRollRate.kd)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, roll_kff, &pidRollRate.kff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_kp,  &pidPitchRate.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_ki,  &pidPitchRate.ki)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_kd,  &pidPitchRate.kd)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pitch_kff, &pidPitchRate.kff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_kp,  &pidYawRate.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_ki,  &pidYawRate.ki)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_kd,  &pidYawRate.kd)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yaw_kff, &pidYawRate.kff)
PARAM_ADD(PARAM_INT8  | PARAM_PERSISTENT, rateFiltEn,  &rateFiltEnable)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, omxFiltCut,  &omxFiltCutoff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, omyFiltCut,  &omyFiltCutoff)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, omzFiltCut,  &omzFiltCutoff)
PARAM_GROUP_STOP(pid_rate)

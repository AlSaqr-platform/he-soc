/*
 * controller_pid.c — ported verbatim from crazyflie-firmware
 * src/modules/src/controller/controller_pid.c (commit ee39e61)
 *
 * Changes from original:
 *  - log.h, param.h → compat shims
 *  - math3d.h → compat shim (adds struct quat, mkquat, quat2rpy)
 */

#include "compat/stabilizer_types.h"
#include "attitude_controller.h"
#include "position_controller.h"
#include "controller_pid.h"
#include "compat/log.h"
#include "compat/param.h"
#include "compat/math3d.h"

#define ATTITUDE_UPDATE_DT  (float)(1.0f / ATTITUDE_RATE)

static attitude_t attitudeDesired;
static attitude_t rateDesired;
static float      actuatorThrust;

static float cmd_thrust;
static float cmd_roll;
static float cmd_pitch;
static float cmd_yaw;
static float r_roll;
static float r_pitch;
static float r_yaw;
static float accelz;

void controllerPidInit(void)
{
  attitudeControllerInit(ATTITUDE_UPDATE_DT);
  positionControllerInit();
}

bool controllerPidTest(void)
{
  return attitudeControllerTest();
}

static float capAngle(float angle) {
  float result = angle;
  while (result >  180.0f) result -= 360.0f;
  while (result < -180.0f) result += 360.0f;
  return result;
}

void controllerPid(control_t* control, const setpoint_t* setpoint,
                   const sensorData_t* sensors, const state_t* state,
                   const stabilizerStep_t stabilizerStep)
{
  control->controlMode = controlModeLegacy;

  if (RATE_DO_EXECUTE(ATTITUDE_RATE, stabilizerStep)) {
    if (setpoint->mode.yaw == modeVelocity) {
      attitudeDesired.yaw = capAngle(
          attitudeDesired.yaw + setpoint->attitudeRate.yaw * ATTITUDE_UPDATE_DT);

      float yawMaxDelta = attitudeControllerGetYawMaxDelta();
      if (yawMaxDelta != 0.0f) {
        float delta = capAngle(attitudeDesired.yaw - state->attitude.yaw);
        if      (delta >  yawMaxDelta) attitudeDesired.yaw = state->attitude.yaw + yawMaxDelta;
        else if (delta < -yawMaxDelta) attitudeDesired.yaw = state->attitude.yaw - yawMaxDelta;
      }
    } else if (setpoint->mode.yaw == modeAbs) {
      attitudeDesired.yaw = setpoint->attitude.yaw;
    } else if (setpoint->mode.quat == modeAbs) {
      struct quat setpoint_quat = mkquat(
          setpoint->attitudeQuaternion.x, setpoint->attitudeQuaternion.y,
          setpoint->attitudeQuaternion.z, setpoint->attitudeQuaternion.w);
      struct vec rpy = quat2rpy(setpoint_quat);
      attitudeDesired.yaw = degrees(rpy.z);
    }
    attitudeDesired.yaw = capAngle(attitudeDesired.yaw);
  }

  if (RATE_DO_EXECUTE(POSITION_RATE, stabilizerStep)) {
    positionController(&actuatorThrust, &attitudeDesired, setpoint, state);
  }

  if (RATE_DO_EXECUTE(ATTITUDE_RATE, stabilizerStep)) {
    if (setpoint->mode.z == modeDisable)
      actuatorThrust = setpoint->thrust;
    if (setpoint->mode.x == modeDisable || setpoint->mode.y == modeDisable) {
      attitudeDesired.roll  = setpoint->attitude.roll;
      attitudeDesired.pitch = setpoint->attitude.pitch;
    }

    attitudeControllerCorrectAttitudePID(
        state->attitude.roll,  state->attitude.pitch,  state->attitude.yaw,
        attitudeDesired.roll,  attitudeDesired.pitch,  attitudeDesired.yaw,
        &rateDesired.roll,     &rateDesired.pitch,     &rateDesired.yaw);

    if (setpoint->mode.roll == modeVelocity) {
      rateDesired.roll = setpoint->attitudeRate.roll;
      attitudeControllerResetRollAttitudePID(state->attitude.roll);
    }
    if (setpoint->mode.pitch == modeVelocity) {
      rateDesired.pitch = setpoint->attitudeRate.pitch;
      attitudeControllerResetPitchAttitudePID(state->attitude.pitch);
    }

    attitudeControllerCorrectRatePID(
        sensors->gyro.x, -sensors->gyro.y, sensors->gyro.z,
        rateDesired.roll,  rateDesired.pitch,  rateDesired.yaw);

    attitudeControllerGetActuatorOutput(&control->roll, &control->pitch, &control->yaw);
    control->yaw = -control->yaw;

    cmd_thrust = control->thrust;
    cmd_roll   = control->roll;
    cmd_pitch  = control->pitch;
    cmd_yaw    = control->yaw;
    r_roll     = radians(sensors->gyro.x);
    r_pitch    = -radians(sensors->gyro.y);
    r_yaw      = radians(sensors->gyro.z);
    accelz     = sensors->acc.z;
  }

  control->thrust = actuatorThrust;

  if (control->thrust == 0) {
    control->thrust = 0;
    control->roll   = 0;
    control->pitch  = 0;
    control->yaw    = 0;

    cmd_thrust = control->thrust;
    cmd_roll   = control->roll;
    cmd_pitch  = control->pitch;
    cmd_yaw    = control->yaw;

    attitudeControllerResetAllPID(
        state->attitude.roll, state->attitude.pitch, state->attitude.yaw);
    positionControllerResetAllPID(
        state->position.x, state->position.y, state->position.z);

    attitudeDesired.yaw = state->attitude.yaw;
  }
}

LOG_GROUP_START(controller)
LOG_ADD(LOG_FLOAT, cmd_thrust, &cmd_thrust)
LOG_ADD(LOG_FLOAT, cmd_roll,   &cmd_roll)
LOG_ADD(LOG_FLOAT, cmd_pitch,  &cmd_pitch)
LOG_ADD(LOG_FLOAT, cmd_yaw,    &cmd_yaw)
LOG_ADD(LOG_FLOAT, r_roll,     &r_roll)
LOG_ADD(LOG_FLOAT, r_pitch,    &r_pitch)
LOG_ADD(LOG_FLOAT, r_yaw,      &r_yaw)
LOG_ADD(LOG_FLOAT, accelz,     &accelz)
LOG_GROUP_STOP(controller)

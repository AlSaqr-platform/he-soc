/*
 * position_controller_pid.c — ported verbatim from crazyflie-firmware
 * src/modules/src/controller/position_controller_pid.c (commit ee39e61)
 *
 * Changes from original:
 *  - log.h, param.h → compat shims
 *  - num.h → compat shim
 *  - platform_defaults.h → compat shim with baked-in CF2 defaults
 *  - CONFIG_CONTROLLER_PID_IMPROVED_BARO_Z_HOLD not defined → standard path
 *  - UNIT_TEST not defined → normal struct initialisation used
 */

#include <math.h>
#include "compat/num.h"
#include "compat/log.h"
#include "compat/param.h"
#include "pid.h"
#include "position_controller.h"
#include "compat/platform_defaults.h"

struct pidAxis_s {
  PidObject    pid;
  stab_mode_t  previousMode;
  float        setpoint;
  float        output;
};

struct this_s {
  struct pidAxis_s pidVX;
  struct pidAxis_s pidVY;
  struct pidAxis_s pidVZ;
  struct pidAxis_s pidX;
  struct pidAxis_s pidY;
  struct pidAxis_s pidZ;
  uint16_t thrustBase;
  uint16_t thrustMin;
};

static float rLimit         = PID_VEL_ROLL_MAX;
static float pLimit         = PID_VEL_PITCH_MAX;
static float rpLimitOverhead = 1.10f;
static float xVelMax        = PID_POS_VEL_X_MAX;
static float yVelMax        = PID_POS_VEL_Y_MAX;
static float zVelMax        = PID_POS_VEL_Z_MAX;
static float velMaxOverhead  = 1.10f;

static const float thrustScale = 1000.0f;

#define DT (float)(1.0f / POSITION_RATE)

static bool  posFiltEnable  = PID_POS_XY_FILT_ENABLE;
static bool  velFiltEnable  = PID_VEL_XY_FILT_ENABLE;
static float posFiltCutoff  = PID_POS_XY_FILT_CUTOFF;
static float velFiltCutoff  = PID_VEL_XY_FILT_CUTOFF;
static bool  posZFiltEnable = PID_POS_Z_FILT_ENABLE;
static bool  velZFiltEnable = PID_VEL_Z_FILT_ENABLE;
static float posZFiltCutoff = PID_POS_Z_FILT_CUTOFF;
static float velZFiltCutoff = PID_VEL_Z_FILT_CUTOFF;

static struct this_s this = {
  .pidVX = { .pid = { .kp = PID_VEL_X_KP, .ki = PID_VEL_X_KI,
                      .kd = PID_VEL_X_KD, .kff = PID_VEL_X_KFF }, .pid.dt = DT },
  .pidVY = { .pid = { .kp = PID_VEL_Y_KP, .ki = PID_VEL_Y_KI,
                      .kd = PID_VEL_Y_KD, .kff = PID_VEL_Y_KFF }, .pid.dt = DT },
  .pidVZ = { .pid = { .kp = PID_VEL_Z_KP, .ki = PID_VEL_Z_KI,
                      .kd = PID_VEL_Z_KD, .kff = PID_VEL_Z_KFF }, .pid.dt = DT },
  .pidX  = { .pid = { .kp = PID_POS_X_KP, .ki = PID_POS_X_KI,
                      .kd = PID_POS_X_KD, .kff = PID_POS_X_KFF }, .pid.dt = DT },
  .pidY  = { .pid = { .kp = PID_POS_Y_KP, .ki = PID_POS_Y_KI,
                      .kd = PID_POS_Y_KD, .kff = PID_POS_Y_KFF }, .pid.dt = DT },
  .pidZ  = { .pid = { .kp = PID_POS_Z_KP, .ki = PID_POS_Z_KI,
                      .kd = PID_POS_Z_KD, .kff = PID_POS_Z_KFF }, .pid.dt = DT },
  .thrustBase = (uint16_t)PID_VEL_THRUST_BASE,
  .thrustMin  = (uint16_t)PID_VEL_THRUST_MIN,
};

void positionControllerInit(void)
{
  pidInit(&this.pidX.pid, this.pidX.setpoint, this.pidX.pid.kp, this.pidX.pid.ki,
          this.pidX.pid.kd, this.pidX.pid.kff, this.pidX.pid.dt,
          POSITION_RATE, posFiltCutoff, posFiltEnable);
  pidInit(&this.pidY.pid, this.pidY.setpoint, this.pidY.pid.kp, this.pidY.pid.ki,
          this.pidY.pid.kd, this.pidY.pid.kff, this.pidY.pid.dt,
          POSITION_RATE, posFiltCutoff, posFiltEnable);
  pidInit(&this.pidZ.pid, this.pidZ.setpoint, this.pidZ.pid.kp, this.pidZ.pid.ki,
          this.pidZ.pid.kd, this.pidZ.pid.kff, this.pidZ.pid.dt,
          POSITION_RATE, posZFiltCutoff, posZFiltEnable);

  pidInit(&this.pidVX.pid, this.pidVX.setpoint, this.pidVX.pid.kp, this.pidVX.pid.ki,
          this.pidVX.pid.kd, this.pidVX.pid.kff, this.pidVX.pid.dt,
          POSITION_RATE, velFiltCutoff, velFiltEnable);
  pidInit(&this.pidVY.pid, this.pidVY.setpoint, this.pidVY.pid.kp, this.pidVY.pid.ki,
          this.pidVY.pid.kd, this.pidVY.pid.kff, this.pidVY.pid.dt,
          POSITION_RATE, velFiltCutoff, velFiltEnable);
  pidInit(&this.pidVZ.pid, this.pidVZ.setpoint, this.pidVZ.pid.kp, this.pidVZ.pid.ki,
          this.pidVZ.pid.kd, this.pidVZ.pid.kff, this.pidVZ.pid.dt,
          POSITION_RATE, velZFiltCutoff, velZFiltEnable);
}

static float runPid(float input, struct pidAxis_s* axis, float setpoint, float dt) {
  axis->setpoint = setpoint;
  pidSetDesired(&axis->pid, axis->setpoint);
  return pidUpdate(&axis->pid, input, false);
}

float state_body_x, state_body_y, state_body_vx, state_body_vy;

void positionController(float* thrust, attitude_t* attitude,
                        const setpoint_t* setpoint, const state_t* state)
{
  this.pidX.pid.outputLimit = xVelMax * velMaxOverhead;
  this.pidY.pid.outputLimit = yVelMax * velMaxOverhead;
  this.pidZ.pid.outputLimit = fmaxf(zVelMax, 0.5f) * velMaxOverhead;

  float cosyaw = cosf(state->attitude.yaw * (float)M_PI / 180.0f);
  float sinyaw = sinf(state->attitude.yaw * (float)M_PI / 180.0f);

  float setp_body_x =  setpoint->position.x * cosyaw + setpoint->position.y * sinyaw;
  float setp_body_y = -setpoint->position.x * sinyaw + setpoint->position.y * cosyaw;

  state_body_x =  state->position.x * cosyaw + state->position.y * sinyaw;
  state_body_y = -state->position.x * sinyaw + state->position.y * cosyaw;

  float globalvx = setpoint->velocity.x;
  float globalvy = setpoint->velocity.y;

  Axis3f setpoint_velocity;
  setpoint_velocity.x = setpoint->velocity.x;
  setpoint_velocity.y = setpoint->velocity.y;
  setpoint_velocity.z = setpoint->velocity.z;

  if (setpoint->mode.x == modeAbs)
    setpoint_velocity.x = runPid(state_body_x, &this.pidX, setp_body_x, DT);
  else if (!setpoint->velocity_body)
    setpoint_velocity.x = globalvx * cosyaw + globalvy * sinyaw;

  if (setpoint->mode.y == modeAbs)
    setpoint_velocity.y = runPid(state_body_y, &this.pidY, setp_body_y, DT);
  else if (!setpoint->velocity_body)
    setpoint_velocity.y = globalvy * cosyaw - globalvx * sinyaw;

  if (setpoint->mode.z == modeAbs)
    setpoint_velocity.z = runPid(state->position.z, &this.pidZ, setpoint->position.z, DT);

  velocityController(thrust, attitude, &setpoint_velocity, state);
}

void velocityController(float* thrust, attitude_t* attitude,
                        const Axis3f* setpoint_velocity, const state_t* state)
{
  this.pidVX.pid.outputLimit = pLimit * rpLimitOverhead;
  this.pidVY.pid.outputLimit = rLimit * rpLimitOverhead;
  this.pidVZ.pid.outputLimit = (65535.0f / 2.0f / thrustScale);

  float cosyaw = cosf(state->attitude.yaw * (float)M_PI / 180.0f);
  float sinyaw = sinf(state->attitude.yaw * (float)M_PI / 180.0f);
  state_body_vx =  state->velocity.x * cosyaw + state->velocity.y * sinyaw;
  state_body_vy = -state->velocity.x * sinyaw + state->velocity.y * cosyaw;

  attitude->pitch = -runPid(state_body_vx, &this.pidVX, setpoint_velocity->x, DT);
  attitude->roll  = -runPid(state_body_vy, &this.pidVY, setpoint_velocity->y, DT);

  attitude->roll  = constrain(attitude->roll,  -rLimit, rLimit);
  attitude->pitch = constrain(attitude->pitch, -pLimit, pLimit);

  float thrustRaw = runPid(state->velocity.z, &this.pidVZ, setpoint_velocity->z, DT);
  *thrust = thrustRaw * thrustScale + this.thrustBase;
  if (*thrust < this.thrustMin)
    *thrust = this.thrustMin;
  *thrust = constrain(*thrust, 0, 65535.0f);
}

void positionControllerResetAllPID(float xActual, float yActual, float zActual)
{
  pidReset(&this.pidX.pid,  xActual);
  pidReset(&this.pidY.pid,  yActual);
  pidReset(&this.pidZ.pid,  zActual);
  pidReset(&this.pidVX.pid, 0);
  pidReset(&this.pidVY.pid, 0);
  pidReset(&this.pidVZ.pid, 0);
}

void positionControllerResetAllfilters(void)
{
  filterReset(&this.pidX.pid,  POSITION_RATE, posFiltCutoff,  posFiltEnable);
  filterReset(&this.pidY.pid,  POSITION_RATE, posFiltCutoff,  posFiltEnable);
  filterReset(&this.pidZ.pid,  POSITION_RATE, posZFiltCutoff, posZFiltEnable);
  filterReset(&this.pidVX.pid, POSITION_RATE, velFiltCutoff,  velFiltEnable);
  filterReset(&this.pidVY.pid, POSITION_RATE, velFiltCutoff,  velFiltEnable);
  filterReset(&this.pidVZ.pid, POSITION_RATE, velZFiltCutoff, velZFiltEnable);
}

LOG_GROUP_START(posCtl)
LOG_ADD(LOG_FLOAT, targetVX, &this.pidVX.pid.desired)
LOG_ADD(LOG_FLOAT, targetVY, &this.pidVY.pid.desired)
LOG_ADD(LOG_FLOAT, targetVZ, &this.pidVZ.pid.desired)
LOG_ADD(LOG_FLOAT, targetX,  &this.pidX.pid.desired)
LOG_ADD(LOG_FLOAT, targetY,  &this.pidY.pid.desired)
LOG_ADD(LOG_FLOAT, targetZ,  &this.pidZ.pid.desired)
LOG_ADD(LOG_FLOAT, bodyVX, &state_body_vx)
LOG_ADD(LOG_FLOAT, bodyVY, &state_body_vy)
LOG_ADD(LOG_FLOAT, bodyX,  &state_body_x)
LOG_ADD(LOG_FLOAT, bodyY,  &state_body_y)
LOG_GROUP_STOP(posCtl)

PARAM_GROUP_START(posCtlPid)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, xKp,  &this.pidX.pid.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, yKp,  &this.pidY.pid.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, zKp,  &this.pidZ.pid.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, zKi,  &this.pidZ.pid.ki)
PARAM_ADD(PARAM_UINT16 | PARAM_PERSISTENT, thrustBase, &this.thrustBase)
PARAM_ADD(PARAM_UINT16 | PARAM_PERSISTENT, thrustMin,  &this.thrustMin)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, rLimit,  &rLimit)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, pLimit,  &pLimit)
PARAM_GROUP_STOP(posCtlPid)

PARAM_GROUP_START(velCtlPid)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, vxKp, &this.pidVX.pid.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, vyKp, &this.pidVY.pid.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, vzKp, &this.pidVZ.pid.kp)
PARAM_ADD(PARAM_FLOAT | PARAM_PERSISTENT, vzKi, &this.pidVZ.pid.ki)
PARAM_GROUP_STOP(velCtlPid)

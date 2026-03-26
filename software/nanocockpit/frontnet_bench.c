/*
 * frontnet_bench.c
 *
 * Standalone per-stage benchmark of the frontnet inference pipeline.
 * Compiles against the original frontnet_kf.c, frontnet_ctrl.c, and headers
 * with minimal compat shims for the Crazyflie/FreeRTOS platform types.
 *
 * The only functions defined here are computeSubjectPoseInOdomFrame and
 * computeTargetOdom, which are static in frontnet_main.c and cannot be linked.
 * They are copied verbatim below.
 *
 * Build (he-soc cross-compile):
 *   cd software/nanocockpit && make build
 */

#include "frontnet_config.h"
#include "frontnet_types.h"
#include "frontnet_kf.h"
#include "frontnet_ctrl.h"
#include "frontnet_inference.h"

#include <printf/printf.h>
#include <stdint.h>
#include <string.h>

/* -------------------------------------------------------------------
 * Functions copied verbatim from frontnet_main.c (they are static
 * there and cannot be linked externally).
 * ------------------------------------------------------------------- */

static void computeSubjectPoseInOdomFrame(const inference_stamped_t *inference, const state_t *state, pose_t *subjectPose) {
  // Convert an inference output, expressed in frame cf/base_link (with a flipped yaw, hence the +M_PI_F), to a pose expressed in frame cf/odom
  // NOTE: the firmware uses degrees and degree/s for attitudes and attitude rates in its data types (state_t and setpoint_t)
  float statePhi = radians(state->attitude.yaw);
  float sn = sinf(statePhi);
  float cs = cosf(statePhi);

  *subjectPose = (pose_t){
    .position = {
      .timestamp = inference->stm32_timestamp,
      .x = state->position.x + cs * inference->x - sn * inference->y,
      .y = state->position.y + sn * inference->x + cs * inference->y,
      .z = state->position.z + inference->z,
    },

    .attitude = {
      .timestamp = inference->stm32_timestamp,
      .roll  = 0.0f,
      .pitch = 0.0f,
      .yaw   = statePhi + inference->phi + M_PI_F
    }
  };
}

static void computeTargetOdom(const frontnet_target_t *config, const odometry_t *subjectOdom, const state_t *state, odometry_t *targetOdom) {
  // Compute the target odometry (i.e., pose + velocity) that we want the drone to reach, expressed in frame cf/odom
  const point_t *subjectPos = &subjectOdom->pose.position;
  const attitude_t *subjectAtt = &subjectOdom->pose.attitude;

  // Target pose is horizontalDistance meters in front of subject pose, in the direction of subject yaw
  float targetX = subjectPos->x + cosf(subjectAtt->yaw) * config->horizontalDistance;
  float targetY = subjectPos->y + sinf(subjectAtt->yaw) * config->horizontalDistance;

  // Target altitude is relative to either the ground or the subject, depending on configuration
  float targetZ;
  if (config->altitudeReference == GROUND_ALTITUDE_REF) {
    targetZ = config->altitude;
  } else if (config->altitudeReference == SUBJECT_ALTITUDE_REF) {
    targetZ = subjectPos->z + config->altitude;
  } else {
    targetZ = 0.0f;
  }

  // Target yaw keeps the drone looking at the subject as it's moving to reach it
  float targetYaw = atan2f(subjectPos->y - state->position.y, subjectPos->x - state->position.x);

  *targetOdom = (odometry_t){
    .pose = {
      .position.timestamp = subjectPos->timestamp,
      .position.x = targetX,
      .position.y = targetY,
      .position.z = targetZ,

      .attitude.timestamp = subjectAtt->timestamp,
      .attitude.roll  = 0.0f,
      .attitude.pitch = 0.0f,
      .attitude.yaw   = targetYaw
    },

    // Target moves at the same velocity as the subject, allowing control to anticipate it
    .twist = subjectOdom->twist
  };
}

/* -------------------------------------------------------------------
 * Test inference sequence (from frontnet_test_inferences.c)
 * ------------------------------------------------------------------- */

#define TEST_BASE_HORIZONTAL_DISTANCE 1.3f

static const inference_stamped_t test_inferences[] = {
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE - 0.5f,  0.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.5f,  0.0f,  0.0f,  0.0f},

  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f, +1.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f, -1.0f,  0.0f,  0.0f},

  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f, +0.5f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f, -0.5f,  0.0f},

  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f, +M_PI_F/4},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f,  0.0f},
  {0, TEST_BASE_HORIZONTAL_DISTANCE + 0.0f,  0.0f,  0.0f, -M_PI_F/4},
};

#define N_TEST_INFERENCES (sizeof(test_inferences) / sizeof(test_inferences[0]))

/* -------------------------------------------------------------------
 * Cycle counter via RISC-V mcycle CSR
 * ------------------------------------------------------------------- */

static inline uint64_t read_mcycle(void) {
#if __riscv_xlen == 64
  uint64_t cycles;
  __asm__ volatile ("csrr %0, mcycle" : "=r"(cycles));
  return cycles;
#else
  uint32_t hi, lo, hi2;
  do {
    __asm__ volatile ("csrr %0, mcycleh" : "=r"(hi));
    __asm__ volatile ("csrr %0, mcycle"  : "=r"(lo));
    __asm__ volatile ("csrr %0, mcycleh" : "=r"(hi2));
  } while (hi != hi2);
  return ((uint64_t)hi << 32) | lo;
#endif
}

/* -------------------------------------------------------------------
 * Per-stage profiler
 * ------------------------------------------------------------------- */

typedef struct {
  const char *name;
  uint64_t total;
  uint64_t min;
  uint64_t max;
  uint32_t count;
} stage_prof_t;

static void stage_init(stage_prof_t *s, const char *name) {
  s->name  = name;
  s->total = 0;
  s->min   = UINT64_MAX;
  s->max   = 0;
  s->count = 0;
}

static void stage_record(stage_prof_t *s, uint64_t cycles) {
  s->total += cycles;
  if (cycles < s->min) s->min = cycles;
  if (cycles > s->max) s->max = cycles;
  s->count++;
}

static void stage_print(const stage_prof_t *s) {
  if (s->count == 0) return;
  double avg = (double)s->total / s->count;
  printf("  %-35s  %6u calls  avg %8.0f  min %8lu  max %8lu\n",
         s->name, s->count, avg,
         (unsigned long)s->min, (unsigned long)s->max);
}

/* -------------------------------------------------------------------
 * Simulated drone state
 * ------------------------------------------------------------------- */

static state_t make_state(uint32_t timestamp_ms) {
  return (state_t){
    .attitude  = { .timestamp = timestamp_ms, .roll = 0, .pitch = 0, .yaw = 0 },
    .position  = { .timestamp = timestamp_ms, .x = 0, .y = 0, .z = 1.0f },
    .velocity  = { .timestamp = timestamp_ms, .x = 0, .y = 0, .z = 0 },
  };
}

/* -------------------------------------------------------------------
 * Main
 * ------------------------------------------------------------------- */

int main(int argc, char **argv) {
  int iterations = 10000;

  /* Pipeline state — mirrors frontnetTask statics */
  frontnet_kf_t kf = FRONTNET_KF_DEFAULT_CONFIG;
  frontnet_target_t targetConfig = FRONTNET_TARGET_DEFAULT_CONFIG;
  frontnet_ctrl_t controllerConfig = FRONTNET_CTRL_DEFAULT_CONFIG;

  odometry_t subjectOdom = {0};
  odometry_t targetOdom = {0};
  setpoint_t setpoint = {0};

  /* Per-stage profilers */
  stage_prof_t prof_pose, prof_kf, prof_target, prof_ctrl, prof_total;
  stage_init(&prof_pose,   "computeSubjectPoseInOdomFrame");
  stage_init(&prof_kf,     "frontnetKfUpdate");
  stage_init(&prof_target, "computeTargetOdom");
  stage_init(&prof_ctrl,   "frontnetSetpointUpdate");
  stage_init(&prof_total,  "total pipeline");

  /* Simulated time at 100 Hz */
  uint32_t sim_time_ms = 0;
  const uint32_t dt_ms = 10;

  /* Inferences at 20 Hz (every 5th step) */
  const uint32_t inference_period_ms = 50;
  int inference_idx = 0;
  uint32_t next_inference_ms = 0;

  printf("Running %d iterations (%.1f simulated seconds at 100Hz)\n",
         iterations, iterations * dt_ms / 1000.0);
  printf("Inference rate: %.0f Hz\n\n", 1000.0 / inference_period_ms);

  for (int i = 0; i < iterations; i++) {
    sim_time_ms += dt_ms;

    if (sim_time_ms < next_inference_ms)
      continue;

    inference_stamped_t inf = test_inferences[inference_idx % N_TEST_INFERENCES];
    inf.stm32_timestamp = sim_time_ms;
    inference_idx++;
    next_inference_ms = sim_time_ms + inference_period_ms;

    state_t state = make_state(sim_time_ms);
    uint64_t c0, c1;

    uint64_t pipeline_start = read_mcycle();

    /* 1. computeSubjectPoseInOdomFrame */
    pose_t subjectPose;
    c0 = read_mcycle();
    computeSubjectPoseInOdomFrame(&inf, &state, &subjectPose);
    c1 = read_mcycle();
    stage_record(&prof_pose, c1 - c0);

    /* 2. frontnetKfUpdate */
    c0 = read_mcycle();
    frontnetKfUpdate(&kf, &subjectPose, &subjectOdom);
    c1 = read_mcycle();
    stage_record(&prof_kf, c1 - c0);

    /* 3. computeTargetOdom */
    c0 = read_mcycle();
    computeTargetOdom(&targetConfig, &subjectOdom, &state, &targetOdom);
    c1 = read_mcycle();
    stage_record(&prof_target, c1 - c0);

    /* 4. frontnetSetpointUpdate */
    c0 = read_mcycle();
    frontnetSetpointUpdate(&controllerConfig, &targetOdom, &state, &setpoint);
    c1 = read_mcycle();
    stage_record(&prof_ctrl, c1 - c0);

    uint64_t pipeline_end = read_mcycle();
    stage_record(&prof_total, pipeline_end - pipeline_start);
  }

  /* -- Summary -- */
  printf("                                                          (cycles)\n");
  printf("  %-35s  %6s  %12s  %8s  %8s\n",
         "stage", "calls", "avg", "min", "max");
  printf("  ------------------------------------------------------------------------------\n");
  stage_print(&prof_pose);
  stage_print(&prof_kf);
  stage_print(&prof_target);
  stage_print(&prof_ctrl);
  printf("  ------------------------------------------------------------------------------\n");
  stage_print(&prof_total);

  return 0;
}

/*
 * frontnet_bench.c
 *
 * Standalone per-stage benchmark of the frontnet inference pipeline.
 * Compiles against the original frontnet_kf.c, frontnet_ctrl.c, and headers
 * with minimal compat shims for the Crazyflie/FreeRTOS platform types.
 *
 * Build (he-soc cross-compile):
 * cd software/nanocockpit && make build
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
 * Functions copied verbatim from frontnet_main.c
 * ------------------------------------------------------------------- */

static void computeSubjectPoseInOdomFrame(const inference_stamped_t *inference, const state_t *state, pose_t *subjectPose) {
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
  const point_t *subjectPos = &subjectOdom->pose.position;
  const attitude_t *subjectAtt = &subjectOdom->pose.attitude;

  float targetX = subjectPos->x + cosf(subjectAtt->yaw) * config->horizontalDistance;
  float targetY = subjectPos->y + sinf(subjectAtt->yaw) * config->horizontalDistance;

  float targetZ;
  if (config->altitudeReference == GROUND_ALTITUDE_REF) {
    targetZ = config->altitude;
  } else if (config->altitudeReference == SUBJECT_ALTITUDE_REF) {
    targetZ = subjectPos->z + config->altitude;
  } else {
    targetZ = 0.0f;
  }

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
    .twist = subjectOdom->twist
  };
}

// --- Setup Counters ---
static inline void setup_icache_miss_counter(void) {
    __asm__ volatile ("csrw mhpmevent3, %0" : : "r" (0b01));
}

static inline void setup_dcache_miss_counter(void) {
    __asm__ volatile ("csrw mhpmevent4, %0" : : "r" (0b10));
}

// --- Read Counters ---
static inline uint64_t read_icache_misses(void) {
    uint64_t counter;
    __asm__ volatile ("csrr %0, mhpmcounter3" : "=r" (counter));
    return counter;
}

static inline uint64_t read_dcache_misses(void) {
    uint64_t counter;
    __asm__ volatile ("csrr %0, mhpmcounter4" : "=r" (counter));
    return counter;
}

/* -------------------------------------------------------------------
 * Test inference sequence
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
  uint64_t icache_miss;
  uint64_t dcache_miss;
} stage_prof_t;

static void stage_init(stage_prof_t *s, const char *name) {
  s->name  = name;
  s->total = 0;
  s->min   = UINT64_MAX;
  s->max   = 0;
  s->count = 0;
  s->icache_miss = 0;
  s->dcache_miss = 0;
}

static void stage_record(stage_prof_t *s, uint64_t cycles, uint64_t i_miss, uint64_t d_miss) {
  s->total += cycles;
  if (cycles < s->min) s->min = cycles;
  if (cycles > s->max) s->max = cycles;
  s->count++;
  s->icache_miss += i_miss;
  s->dcache_miss += d_miss;
}

static void stage_print(const stage_prof_t *s) {
  if (s->count == 0) return;
  double avg = (double)s->total / s->count;

  if (s->icache_miss > 0 || s->dcache_miss > 0 || s->name[0] == 't') {
      double i_avg = (double)s->icache_miss / s->count;
      double d_avg = (double)s->dcache_miss / s->count;
      printf("  %-35s  %6u  %12.1f  %8lu  %8lu  %12.1f  %12.1f\n",
             s->name, s->count, avg,
             (unsigned long)s->min, (unsigned long)s->max, i_avg, d_avg);
  } else {
      printf("  %-35s  %6u  %12.1f  %8lu  %8lu  %12s  %12s\n",
             s->name, s->count, avg,
             (unsigned long)s->min, (unsigned long)s->max, "-", "-");
  }
}

static void print_results(const char *title,
                          const stage_prof_t *pose,
                          const stage_prof_t *kf,
                          const stage_prof_t *target,
                          const stage_prof_t *ctrl,
                          const stage_prof_t *total) {
  printf("\n%s\n", title);
  printf("                                                               (cycles)                               (misses)\n");
  printf("  %-35s  %6s  %12s  %8s  %8s  %12s  %12s\n", "stage", "calls", "avg", "min", "max", "avg i-miss", "avg d-miss");
  printf("  ----------------------------------------------------------------------------------------------------------------------\n");
  stage_print(pose);
  stage_print(kf);
  stage_print(target);
  stage_print(ctrl);
  printf("  ----------------------------------------------------------------------------------------------------------------------\n");
  stage_print(total);
}

/* -------------------------------------------------------------------
 * Simulated drone state
 * ------------------------------------------------------------------- */

static state_t make_state(uint32_t timestamp, int i) {
  float t = i * 0.01f;
  return (state_t){
    .attitude  = { .timestamp = timestamp,
                   .roll = 2.0f * sinf(t),
                   .pitch = 1.5f * cosf(t * 0.7f),
                   .yaw = 30.0f * sinf(t * 0.3f) },
    .position  = { .timestamp = timestamp,
                   .x = 0.5f * sinf(t * 0.5f),
                   .y = 0.5f * cosf(t * 0.5f),
                   .z = 1.0f + 0.2f * sinf(t * 0.2f) },
    .velocity  = { .timestamp = timestamp,
                   .x = 0.25f * cosf(t * 0.5f),
                   .y = -0.25f * sinf(t * 0.5f),
                   .z = 0.04f * cosf(t * 0.2f) },
  };
}

/* -------------------------------------------------------------------
 * Main
 * ------------------------------------------------------------------- */

int main(int argc, char **argv) {
  int iterations = 1000;
  int warmup     = 3;

  /* ----------------------------------------------------------------
   * Phase 1 — cold cache (single invocation, no warmup)
   * ---------------------------------------------------------------- */

  stage_prof_t cold_pose, cold_kf, cold_target, cold_ctrl, cold_total;
  stage_init(&cold_pose,   "computeSubjectPoseInOdomFrame");
  stage_init(&cold_kf,     "frontnetKfUpdate");
  stage_init(&cold_target, "computeTargetOdom");
  stage_init(&cold_ctrl,   "frontnetSetpointUpdate");
  stage_init(&cold_total,  "total pipeline");

  {
    frontnet_kf_t     kf               = FRONTNET_KF_DEFAULT_CONFIG;
    frontnet_target_t targetConfig     = FRONTNET_TARGET_DEFAULT_CONFIG;
    frontnet_ctrl_t   controllerConfig = FRONTNET_CTRL_DEFAULT_CONFIG;
    odometry_t        subjectOdom      = {0};
    odometry_t        targetOdom       = {0};
    setpoint_t        setpoint         = {0};

    inference_stamped_t inf = test_inferences[0];
    inf.stm32_timestamp = 0;

    state_t state = make_state(0, 0);
    uint64_t c0, c1;

    setup_icache_miss_counter();
    setup_dcache_miss_counter();

    uint64_t i0 = read_icache_misses();
    uint64_t d0 = read_dcache_misses();
    uint64_t pipeline_start = read_mcycle();

    pose_t subjectPose;
    c0 = read_mcycle();
    computeSubjectPoseInOdomFrame(&inf, &state, &subjectPose);
    c1 = read_mcycle();
    stage_record(&cold_pose, c1 - c0, 0, 0);

    c0 = read_mcycle();
    frontnetKfUpdate(&kf, &subjectPose, &subjectOdom);
    c1 = read_mcycle();
    stage_record(&cold_kf, c1 - c0, 0, 0);

    c0 = read_mcycle();
    computeTargetOdom(&targetConfig, &subjectOdom, &state, &targetOdom);
    c1 = read_mcycle();
    stage_record(&cold_target, c1 - c0, 0, 0);

    c0 = read_mcycle();
    frontnetSetpointUpdate(&controllerConfig, &targetOdom, &state, &setpoint);
    c1 = read_mcycle();
    stage_record(&cold_ctrl, c1 - c0, 0, 0);

    uint64_t pipeline_end = read_mcycle();
    uint64_t i1 = read_icache_misses();
    uint64_t d1 = read_dcache_misses();
    stage_record(&cold_total, pipeline_end - pipeline_start, i1 - i0, d1 - d0);
  }

  /* ----------------------------------------------------------------
   * Phase 2 — warm cache
   * ---------------------------------------------------------------- */

  stage_prof_t warm_pose, warm_kf, warm_target, warm_ctrl, warm_total;
  stage_init(&warm_pose,   "computeSubjectPoseInOdomFrame");
  stage_init(&warm_kf,     "frontnetKfUpdate");
  stage_init(&warm_target, "computeTargetOdom");
  stage_init(&warm_ctrl,   "frontnetSetpointUpdate");
  stage_init(&warm_total,  "total pipeline");

  {
    frontnet_kf_t     kf               = FRONTNET_KF_DEFAULT_CONFIG;
    frontnet_target_t targetConfig     = FRONTNET_TARGET_DEFAULT_CONFIG;
    frontnet_ctrl_t   controllerConfig = FRONTNET_CTRL_DEFAULT_CONFIG;
    odometry_t        subjectOdom      = {0};
    odometry_t        targetOdom       = {0};
    setpoint_t        setpoint         = {0};

    printf("Warming up for %d pipeline invocations, then profiling %d invocations\n\n",
           warmup, iterations);

    for (int i = 0; i < warmup + iterations; i++) {
      inference_stamped_t inf = test_inferences[i % N_TEST_INFERENCES];
      inf.stm32_timestamp = i;

      int profiling = (i >= warmup);

      state_t state = make_state(i, i);
      uint64_t c0, c1;

      uint64_t i0 = read_icache_misses();
      uint64_t d0 = read_dcache_misses();
      uint64_t pipeline_start = read_mcycle();

      pose_t subjectPose;
      c0 = read_mcycle();
      computeSubjectPoseInOdomFrame(&inf, &state, &subjectPose);
      c1 = read_mcycle();
      if (profiling) stage_record(&warm_pose, c1 - c0, 0, 0);

      c0 = read_mcycle();
      frontnetKfUpdate(&kf, &subjectPose, &subjectOdom);
      c1 = read_mcycle();
      if (profiling) stage_record(&warm_kf, c1 - c0, 0, 0);

      c0 = read_mcycle();
      computeTargetOdom(&targetConfig, &subjectOdom, &state, &targetOdom);
      c1 = read_mcycle();
      if (profiling) stage_record(&warm_target, c1 - c0, 0, 0);

      c0 = read_mcycle();
      frontnetSetpointUpdate(&controllerConfig, &targetOdom, &state, &setpoint);
      c1 = read_mcycle();
      if (profiling) stage_record(&warm_ctrl, c1 - c0, 0, 0);

      uint64_t pipeline_end = read_mcycle();
      uint64_t i1 = read_icache_misses();
      uint64_t d1 = read_dcache_misses();

      if (profiling) stage_record(&warm_total, pipeline_end - pipeline_start, i1 - i0, d1 - d0);
    }
  }

  /* ----------------------------------------------------------------
   * Results
   * ---------------------------------------------------------------- */

  print_results("=== Cold (first invocation, D-cache cold) ===",
                &cold_pose, &cold_kf, &cold_target, &cold_ctrl, &cold_total);

  print_results("=== Warm (steady-state) ===",
                &warm_pose, &warm_kf, &warm_target, &warm_ctrl, &warm_total);

  return 0;
}

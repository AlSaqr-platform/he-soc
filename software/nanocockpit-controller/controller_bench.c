/*
 * controller_bench.c
 *
 * Standalone per-step benchmark of the Crazyflie PID controller stack.
 * Profiles controllerPid() across the three execution modes that occur
 * in the real 1 kHz stabilizer loop:
 *
 *   step % 2  == 0  →  attitude-angle + rate PID run   (ATTITUDE_RATE = 500 Hz)
 *   step % 2  != 0  →  rate PID only
 *   step % 10 == 0  →  position + attitude-angle + rate PID run (POSITION_RATE = 100 Hz)
 *
 * All sensors/state/setpoint are synthetic; no FreeRTOS or hardware needed.
 *
 * Build (he-soc cross-compile):
 *   cd software/nanocockpit-controller && make build
 */

#include "controller_pid.h"
#include "compat/stabilizer_types.h"

#include <printf/printf.h>
#include <stdint.h>
#include <string.h>
#include <math.h>

/* -------------------------------------------------------------------
 * Hardware performance counters (RISC-V mcycle / mhpmcounter)
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

static inline void setup_icache_miss_counter(void) {
  __asm__ volatile ("csrw mhpmevent3, %0" : : "r" (0b01));
}

static inline void setup_dcache_miss_counter(void) {
  __asm__ volatile ("csrw mhpmevent4, %0" : : "r" (0b10));
}

static inline uint64_t read_icache_misses(void) {
  uint64_t v;
  __asm__ volatile ("csrr %0, mhpmcounter3" : "=r"(v));
  return v;
}

static inline uint64_t read_dcache_misses(void) {
  uint64_t v;
  __asm__ volatile ("csrr %0, mhpmcounter4" : "=r"(v));
  return v;
}

/* -------------------------------------------------------------------
 * Per-stage profiler (same structure as nanocockpit/frontnet_bench.c)
 * ------------------------------------------------------------------- */

typedef struct {
  const char *name;
  uint64_t    total;
  uint64_t    min;
  uint64_t    max;
  uint32_t    count;
  uint64_t    icache_miss;
  uint64_t    dcache_miss;
} stage_prof_t;

static void stage_init(stage_prof_t *s, const char *name) {
  s->name        = name;
  s->total       = 0;
  s->min         = UINT64_MAX;
  s->max         = 0;
  s->count       = 0;
  s->icache_miss = 0;
  s->dcache_miss = 0;
}

static void stage_record(stage_prof_t *s, uint64_t cycles,
                         uint64_t i_miss, uint64_t d_miss) {
  s->total += cycles;
  if (cycles < s->min) s->min = cycles;
  if (cycles > s->max) s->max = cycles;
  s->count++;
  s->icache_miss += i_miss;
  s->dcache_miss += d_miss;
}

static void stage_print(const stage_prof_t *s) {
  if (s->count == 0) return;
  double avg   = (double)s->total / s->count;
  double i_avg = (double)s->icache_miss / s->count;
  double d_avg = (double)s->dcache_miss / s->count;
  printf("  %-38s  %6u  %12.1f  %8lu  %8lu  %12.1f  %12.1f\n",
         s->name, s->count, avg,
         (unsigned long)s->min, (unsigned long)s->max,
         i_avg, d_avg);
}

static void print_header(const char *title) {
  printf("\n%s\n", title);
  printf("                                                                  (cycles)                               (misses)\n");
  printf("  %-38s  %6s  %12s  %8s  %8s  %12s  %12s\n",
         "stage", "calls", "avg", "min", "max", "avg i-miss", "avg d-miss");
  printf("  -------------------------------------------------------------------------------------------------------------------------\n");
}

static void print_footer(void) {
  printf("  -------------------------------------------------------------------------------------------------------------------------\n");
}

/* -------------------------------------------------------------------
 * Synthetic inputs
 * ------------------------------------------------------------------- */

/*
 * Setpoint: position-hold at (1, 0, 1) m with zero velocity,
 * full absolute position mode so positionController actually runs.
 */
static setpoint_t make_setpoint(uint32_t ts) {
  setpoint_t sp;
  memset(&sp, 0, sizeof(sp));
  sp.timestamp       = ts;
  sp.position.x      = 1.0f;
  sp.position.y      = 0.0f;
  sp.position.z      = 1.0f;
  sp.thrust          = 40000.0f;
  sp.mode.x          = modeAbs;
  sp.mode.y          = modeAbs;
  sp.mode.z          = modeAbs;
  sp.mode.roll       = modeDisable;
  sp.mode.pitch      = modeDisable;
  sp.mode.yaw        = modeAbs;
  sp.attitude.yaw    = 0.0f;
  return sp;
}

/* Simulated drone state — slow sinusoidal motion */
static state_t make_state(uint32_t ts, int i) {
  float t = i * 0.001f;   /* 1 kHz step → 1 ms per tick */
  state_t s;
  memset(&s, 0, sizeof(s));
  s.attitude.timestamp   = ts;
  s.attitude.roll        =  2.0f * sinf(t * 2.0f);
  s.attitude.pitch       =  1.5f * cosf(t * 1.4f);
  s.attitude.yaw         = 10.0f * sinf(t * 0.6f);
  s.position.timestamp   = ts;
  s.position.x           =  0.5f * sinf(t);
  s.position.y           =  0.5f * cosf(t);
  s.position.z           =  1.0f + 0.1f * sinf(t * 0.4f);
  s.velocity.timestamp   = ts;
  s.velocity.x           =  0.5f * cosf(t);
  s.velocity.y           = -0.5f * sinf(t);
  s.velocity.z           =  0.04f * cosf(t * 0.4f);
  return s;
}

/* Simulated sensor data (gyro, accel) */
static sensorData_t make_sensors(uint32_t ts, int i) {
  float t = i * 0.001f;
  sensorData_t sd;
  memset(&sd, 0, sizeof(sd));
  sd.gyro.x = 5.0f * sinf(t * 2.0f);
  sd.gyro.y = 4.0f * cosf(t * 1.8f);
  sd.gyro.z = 1.5f * sinf(t * 0.9f);
  sd.acc.x  = 0.05f * cosf(t * 3.0f);
  sd.acc.y  = 0.04f * sinf(t * 2.5f);
  sd.acc.z  = 1.0f;
  return sd;
}

/* -------------------------------------------------------------------
 * Main
 * ------------------------------------------------------------------- */

int main(int argc, char **argv) {
  int iterations = 1000;
  int warmup     = 10;

  setup_icache_miss_counter();
  setup_dcache_miss_counter();

  /* ----------------------------------------------------------------
   * Phase 1 — cold cache
   * Each of the three execution modes is profiled once in order:
   *   step=10  (pos+att+rate)
   *   step=2   (att+rate)
   *   step=1   (rate only)
   * ---------------------------------------------------------------- */

  stage_prof_t cold_pos_att_rate, cold_att_rate, cold_rate_only, cold_total;
  stage_init(&cold_pos_att_rate, "pos+att+rate  (step%10==0)");
  stage_init(&cold_att_rate,     "att+rate      (step%2==0)");
  stage_init(&cold_rate_only,    "rate only     (step%2!=0)");
  stage_init(&cold_total,        "total (3 steps)");

  {
    controllerPidInit();

    control_t    ctrl;
    setpoint_t   sp   = make_setpoint(0);
    state_t      st   = make_state(0, 0);
    sensorData_t sens = make_sensors(0, 0);
    uint64_t c0, c1, i0, d0, i1, d1;

    uint64_t total_start = read_mcycle();
    i0 = read_icache_misses();
    d0 = read_dcache_misses();

    c0 = read_mcycle();
    controllerPid(&ctrl, &sp, &sens, &st, 10);   /* pos+att+rate */
    c1 = read_mcycle();
    stage_record(&cold_pos_att_rate, c1 - c0, 0, 0);

    c0 = read_mcycle();
    controllerPid(&ctrl, &sp, &sens, &st, 2);    /* att+rate */
    c1 = read_mcycle();
    stage_record(&cold_att_rate, c1 - c0, 0, 0);

    c0 = read_mcycle();
    controllerPid(&ctrl, &sp, &sens, &st, 1);    /* rate only */
    c1 = read_mcycle();
    stage_record(&cold_rate_only, c1 - c0, 0, 0);

    i1 = read_icache_misses();
    d1 = read_dcache_misses();
    stage_record(&cold_total, read_mcycle() - total_start, i1 - i0, d1 - d0);
  }

  /* ----------------------------------------------------------------
   * Phase 2 — warm cache
   * Runs the real stabilizerStep increment sequence so the three modes
   * fire in their natural ratio (1:5:10).
   * ---------------------------------------------------------------- */

  stage_prof_t warm_pos_att_rate, warm_att_rate, warm_rate_only, warm_total;
  stage_init(&warm_pos_att_rate, "pos+att+rate  (step%10==0)");
  stage_init(&warm_att_rate,     "att+rate      (step%2==0,!=10)");
  stage_init(&warm_rate_only,    "rate only     (step%2!=0)");
  stage_init(&warm_total,        "total pipeline (per step)");

  {
    controllerPidInit();   /* re-init to reset integrators */

    printf("Warming up for %d steps, then profiling %d steps\n\n",
           warmup, iterations);

    for (int i = 1; i <= warmup + iterations; i++) {
      stabilizerStep_t step = (stabilizerStep_t)i;
      int profiling = (i > warmup);

      state_t      st   = make_state((uint32_t)i, i);
      sensorData_t sens = make_sensors((uint32_t)i, i);
      setpoint_t   sp   = make_setpoint((uint32_t)i);
      control_t    ctrl;

      uint64_t c0, c1, i0, d0, i1, d1;

      i0 = read_icache_misses();
      d0 = read_dcache_misses();
      c0 = read_mcycle();

      controllerPid(&ctrl, &sp, &sens, &st, step);

      c1 = read_mcycle();
      i1 = read_icache_misses();
      d1 = read_dcache_misses();

      if (!profiling) continue;

      uint64_t cyc   = c1 - c0;
      uint64_t i_mis = i1 - i0;
      uint64_t d_mis = d1 - d0;

      if (step % 10 == 0)
        stage_record(&warm_pos_att_rate, cyc, i_mis, d_mis);
      else if (step % 2 == 0)
        stage_record(&warm_att_rate,     cyc, i_mis, d_mis);
      else
        stage_record(&warm_rate_only,    cyc, i_mis, d_mis);

      stage_record(&warm_total, cyc, i_mis, d_mis);
    }
  }

  /* ----------------------------------------------------------------
   * Results
   * ---------------------------------------------------------------- */

  print_header("=== Cold (first invocations, D-cache cold) ===");
  stage_print(&cold_pos_att_rate);
  stage_print(&cold_att_rate);
  stage_print(&cold_rate_only);
  print_footer();
  stage_print(&cold_total);

  print_header("=== Warm (steady-state, 1000 steps) ===");
  stage_print(&warm_pos_att_rate);
  stage_print(&warm_att_rate);
  stage_print(&warm_rate_only);
  print_footer();
  stage_print(&warm_total);

  return 0;
}

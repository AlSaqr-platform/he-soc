//#include "util.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdatomic.h>
#include <math.h>
#include "utils.h"
#include "encoding.h"

#include "mm_fp.h"

#include "gpio_v3.h"
#include "udma.h"

#define OUT 1
#define IN  0
#define ARCHI_GPIO_ADDR 0x1A105000
#define GPIO2_PAD_A2_ADDR 0x1A10500C

// This assess the computation of a single matrix among C0+C1 ot two matrix M0-M1 on each core
// 0 : single matrix among C0+C1
// 1 : two matrix M0-M1 on each core
#define SAME_MATRIX 0

#define IDLE 0
#define GPIO_EN 0

__attribute__ ((section(".heapl2ram"))) volatile int flag[2] = { 0, 0};

__attribute__ ((section(".heapl2ram"))) volatile int victim = -1;

__attribute__ ((section(".heapl2ram"))) volatile int core_1 = -1;

__attribute__ ((section(".heapl2ram"))) volatile int barrier_counter_dst = 0;

__attribute__ ((section(".heapl2ram"))) volatile int barrier_counter_src = 0;

__attribute__ ((section(".heapl2ram"))) volatile int barrier_ready = 0;


static __attribute__ ((noinline)) void lock(int cid) {
  flag[cid] = 1;
  victim = cid;
  int other_cid = 1-cid;
  while( flag[other_cid] && (victim==cid) ) {
    __asm__ volatile("nop;");
  }
}

static __attribute__ ((noinline)) void unlock(int cid) {
  flag[cid] = 0;
}

static __attribute__ ((noinline)) int atomic_increment(volatile int *addr) {
    int old;
    asm volatile ("amoadd.w %0, %2, %1"
                  : "=r"(old), "+A"(*addr)
                  : "r"(1)
                  : "memory");
    return old + 1; // Return incremented value (old + 1)
}

static __attribute__ ((noinline)) int atomic_deincrement(volatile int *addr) {
    int old;
    asm volatile ("amoadd.w %0, %2, %1"
                  : "=r"(old), "+A"(*addr)
                  : "r"(-1)
                  : "memory");
    return old - 1; // Return incremented value (old - 1)
}

static __attribute__ ((noinline)) int atomic_reset(volatile int *addr) {
    int old;
    asm volatile ("amoxor.w %0, %2, %1"
                  : "=r"(old), "+A"(*addr)
                  : "r"(old)
                  : "memory");
    return old^old; // Return incremented value (old + 1)
}

static __attribute__ ((noinline)) void my_barrier(int core_id) {

  if(core_id==0){
    atomic_increment(&barrier_counter_src);
    while(barrier_counter_dst==0){
    }
    barrier_counter_dst=0;
  }else{
    while(barrier_counter_src==0){
    }
    barrier_counter_src=0;
    atomic_increment(&barrier_counter_dst);
  }
}


uint32_t configure_gpio(uint32_t number, uint32_t direction){
  uint32_t address;
  uint32_t dir;
  uint32_t gpioen;

  //--- set GPIO
  if(number < 32)
  {
    if (direction == IN)
    {

      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_OFFSET;

      gpioen = pulp_read32(address);
      //--- enable GPIO
      //printf("GPIOEN RD: %x\n",gpioen);
      gpioen |= (1 << number);
      //printf("GPIOEN WR: %x\n",gpioen);
      pulp_write32(address, gpioen);
      //--- set direction
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_OFFSET;
      dir = pulp_read32(address);
      //printf("GPIODIR RD: %x\n",dir);
      dir |= (0 << number);
      //printf("GPIODIR WR: %x\n",dir);
      pulp_write32(address, dir);

    }else if (direction == OUT){
      //--- enable GPIO
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_OFFSET;
      gpioen = pulp_read32(address);
      gpioen |= (1 << number);
      pulp_write32(address, gpioen);
      //--- set direction
      dir=gpioen;
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_OFFSET;
      pulp_write32(address, dir);
    }
  }else{
    if (direction == IN)
    {
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_32_63_OFFSET;
      gpioen = pulp_read32(address);
      //--- enable GPIO
      //printf("GPIOEN RD: %x\n",gpioen);
      gpioen |= (1 << (number-32));
      //printf("GPIOEN WR: %x\n",gpioen);
      pulp_write32(address, gpioen);
      //--- set direction
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_32_63_OFFSET;
      dir = pulp_read32(address);
      //printf("GPIODIR RD: %x\n",dir);
      dir |= (0 << (number-32));
      //printf("GPIODIR WR: %x\n",dir);
      pulp_write32(address, dir);
    }else if (direction == OUT){
      //--- enable GPIO
      address = ARCHI_GPIO_ADDR + GPIO_GPIOEN_32_63_OFFSET;
      gpioen = pulp_read32(address);
      gpioen |= (1 << (number-32));
      pulp_write32(address, gpioen);
      //--- set direction
      dir=gpioen;
      address = ARCHI_GPIO_ADDR + GPIO_PADDIR_32_63_OFFSET;
      pulp_write32(address, dir);
    }
  }

  while(pulp_read32(address) != dir);

}

void matrix_init0() {
  unsigned int i, j;

  // init, copy to TCDM
  for(i = 0; i < SIZE; i++) {
    for(j = 0; j < SIZE; j++) {
      g_mA[i][j] = m_a[i * SIZE + j];
      g_mB[i][j] = m_b[i * SIZE + j];
      g_mC[i][j] = 0;
    }
  }
}

void matrix_init1() {
  unsigned int i, j;

  // init, copy to TCDM
  for(i = 0; i < SIZE; i++) {
    for(j = 0; j < SIZE; j++) {
      g_mA1[i][j] = m_a[i * SIZE + j];
      g_mB1[i][j] = m_b[i * SIZE + j];
      g_mC1[i][j] = 0;
    }
  }
}

unsigned int matrix_check0() {
  unsigned int errors = 0;
  unsigned int i, j;
  float diff;
  float THR=0.004f;
  // check
  for(i = 0; i < SIZE; i++) {
    for(j = 0; j < SIZE; j++) {
       diff = fabs(g_mC[i][j] - m_exp[i * SIZE + j]);
      if(diff > THR) {
        errors++;
        //printf("g_mC[%d][%d] = %f, expected = %f \r\n", i, j, g_mC[i][j], m_exp[i * SIZE + j]);
        //uart_wait_tx_done();
      }
    }
  }
  return errors;
}

unsigned int matrix_check1() {
  unsigned int errors = 0;
  unsigned int i, j;
  float diff;
  float THR=0.004f;
  // check
  for(i = 0; i < SIZE; i++) {
    for(j = 0; j < SIZE; j++) {
       diff = fabs(g_mC[i][j] - m_exp[i * SIZE + j]);
      if(diff > THR) {
        errors++;
        //printf("g_mC[%d][%d] = %f, expected = %f \r\n", i, j, g_mC[i][j], m_exp[i * SIZE + j]);
        //uart_wait_tx_done();
      }
    }
  }
  return errors;
}

int thread_entry(int cid, int nc){
  uint32_t gpio_val= 0x00000004;

  uint32_t res= -1;

  //SAME_MATRIX 0 : single matrix among C0+C1
  //SAME_MATRIX 1 : two matrix M0-M1 on each core

  #if IDLE==0
    //Compute
    #if GPIO_EN==1
    if (cid==0){
      // Config Pad GPIO 2
      alsaqr_periph_padframe_periphs_a_02_mux_set(2);
      // Set GPIO 0 OUT
      configure_gpio(2, OUT);
      pulp_write32(GPIO2_PAD_A2_ADDR,0x00000000);
    }
    #endif

    #if SAME_MATRIX==0
      res=mm_fp_dual(cid, nc);
    #else
      res=mm_fp_dual(cid, nc-1);
    #endif

  #else
    // Cores in sleep - > CG FLL0
    //pulp_write32(0x1A10000C,0x2801ff70);
    while (1) {
     asm volatile ("wfi");
    }
  #endif

    return res;
}

int mm_fp_dual(int cid, int nc) {

  uint64_t perf_c;

  int num_cores = nc;
  int core_id = cid;

  unsigned int i, j, k;
  unsigned int chunk;
  unsigned int lb, ub;
  unsigned int errors = 0;
  unsigned int errors1 = 0;

  unsigned int llc_hit;
  unsigned int llc_miss;
  long unsigned int start, end;

  uint32_t gpio_val= 0x00000004;

  size_t instret, cycles, icachemiss, dcachemiss;

  chunk = SIZE / num_cores;

  // lower bound
  #if SAME_MATRIX==0
  lb = core_id * chunk;
  #else
  lb = 0 * chunk;
  #endif

  // upper bound
  ub = lb + chunk;

  //Power Loop
  //while(1){
    if(core_id == 0) {
      matrix_init0();
    }else{
      // I initialize M1 for C1 only when SAME_MATRIX==1
      #if SAME_MATRIX==1
      matrix_init1();
      #endif
    }

    // Compute M0-M1 on C0-C1
    #if SAME_MATRIX==1
      // Kernel
      if (core_id==0){
        for(i = lb; i < ub; i++) {
          for(j = 0; j < SIZE; j++) {
            for(k = 0; k < SIZE; k++) {
              g_mC[i][j] += g_mA[i][k] * g_mB[k][j];
            }
          }
        }
        errors=matrix_check0();
        if(errors==0){
          //printf("Success0!!!\r\n" );
          //uart_wait_tx_done();
          gpio_val ^= 0x00000004;
          pulp_write32(GPIO2_PAD_A2_ADDR,gpio_val);
        }
        else{
          //printf("Failed0!!!\r\n" );
          //uart_wait_tx_done();
          pulp_write32(GPIO2_PAD_A2_ADDR,0x00000000);
          //while(1){}
        }
        //uart_wait_tx_done();
      }else{
        for(i = lb; i < ub; i++) {
          for(j = 0; j < SIZE; j++) {
            for(k = 0; k < SIZE; k++) {
              g_mC1[i][j] += g_mA1[i][k] * g_mB1[k][j];
            }
          }
        }
        errors1=matrix_check1();
        if(errors1==0){
          //printf("Success1!!!\r\n" );
          //uart_wait_tx_done();
          gpio_val ^= 0x00000004;
          pulp_write32(GPIO2_PAD_A2_ADDR,gpio_val);
        }
        else{
          //printf("Failed1!!!\r\n" );
          //uart_wait_tx_done();
          pulp_write32(GPIO2_PAD_A2_ADDR,0x00000000);
          //while(1){}
        }
        //uart_wait_tx_done();
      }
    #else
      // Compute M0 on C0+C1
      my_barrier(core_id);
      for(i = lb; i < ub; i++) {
        for(j = 0; j < SIZE; j++) {
          for(k = 0; k < SIZE; k++) {
            g_mC[i][j] += g_mA[i][k] * g_mB[k][j];
          }
        }
      }
      my_barrier(core_id);

      // Core 0 check results
      if (core_id==0){
        errors=matrix_check0();
        //gpio_val ^= 0x00000004;
        //pulp_write32(GPIO2_PAD_A2_ADDR,gpio_val);
        if(errors==0){
          //printf("Both core computed the SAME matrix wit success!!!\r\n" );
          //uart_wait_tx_done();
          #if GPIO_EN==1
          gpio_val ^= 0x00000004;
          pulp_write32(GPIO2_PAD_A2_ADDR,gpio_val);
          #endif
        }
        else{
          //printf("Both core computed the SAME matrix wit errors!!!!!!\r\n" );
          //uart_wait_tx_done();
          pulp_write32(GPIO2_PAD_A2_ADDR,0x00000000);
          //while(1){}
        }
      }
      // sync barrier
      my_barrier(core_id);
    #endif
  //} //Power Loop

  return errors+errors1;

}

int main(int argc, char const *argv[]) {
  return 0;
}

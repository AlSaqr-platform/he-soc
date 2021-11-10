/*
 * Copyright (C) 2018 ETH Zurich, University of Bologna
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#ifndef __ARCHI_CHIPS_PULP_PROPERTIES_H__
#define __ARCHI_CHIPS_PULP_PROPERTIES_H__

/*
 * FPGA
 */

#ifndef ARCHI_FPGA_FREQUENCY
#define ARCHI_FPGA_FREQUENCY 1000000
#endif

#ifndef ARCHI_FPGA_FC_FREQUENCY
#define ARCHI_FPGA_FC_FREQUENCY 1000000
#endif

#ifndef ARCHI_FPGA_CL_FREQUENCY
#define ARCHI_FPGA_CL_FREQUENCY 1000000
#endif

/*
 * MEMORIES
 */ 

#define ARCHI_HAS_L2                   1
#define ARCHI_HAS_L2_MULTI             1
#define ARCHI_HAS_L1                   1

#define ARCHI_L2_PRIV0_ADDR  0x1c000000
#define ARCHI_L2_PRIV0_SIZE  0x00008000

#define ARCHI_L2_PRIV1_ADDR  0x1c008000
#define ARCHI_L2_PRIV1_SIZE  0x00008000

#define ARCHI_L2_SHARED_ADDR  0x1c010000
#define ARCHI_L2_SHARED_SIZE  0x00070000



/*
 * MEMORY ALIAS
 */

#define ARCHI_HAS_L1_ALIAS             1
#define ARCHI_HAS_L2_ALIAS             1



/*
 * IP VERSIONS
 */

#define UDMA_VERSION        3
#define PERIPH_VERSION      2
#define TIMER_VERSION       2
#define SOC_EU_VERSION      2
#define APB_SOC_VERSION     3
#define STDOUT_VERSION      2
#define GPIO_VERSION        2
#define EU_VERSION          3
#define ITC_VERSION         1
#define FLL_VERSION         1
#define RISCV_VERSION       4
#define MCHAN_VERSION       7
#define PADS_VERSION        2


/*
 * CLUSTER
 */

#define ARCHI_HAS_CLUSTER   1
#define ARCHI_L1_TAS_BIT    20
#ifndef ARCHI_CLUSTER_NB_PE
#define ARCHI_CLUSTER_NB_PE 8
#endif
#define ARCHI_NB_CLUSTER    1


/*
 * HWS
 */

#define ARCHI_EU_NB_HW_MUTEX 1



/*
 * FC
 */

#ifndef ARCHI_NO_FC
#define ARCHI_FC_CID        31
#define ARCHI_HAS_FC_ITC     1
#define ARCHI_HAS_FC         1
#define ARCHI_CORE_HAS_1_10  1
#endif


/*
 * CLOCKS
 */

#define ARCHI_REF_CLOCK_LOG2 15
#define ARCHI_REF_CLOCK      (1<<ARCHI_REF_CLOCK_LOG2)



/*
 * UDMA
 */

#define ARCHI_UDMA_HAS_SPIM   1
#define ARCHI_UDMA_HAS_UART   1
#define ARCHI_UDMA_HAS_SDIO   1
#define ARCHI_UDMA_HAS_I2C    1
#define ARCHI_UDMA_HAS_I2S    0
#define ARCHI_UDMA_HAS_CAM    1
#define ARCHI_UDMA_HAS_TRACER 1
#define ARCHI_UDMA_HAS_FILTER 1

#define ARCHI_UDMA_NB_SPIM    12
#define ARCHI_UDMA_NB_UART    8
#define ARCHI_UDMA_NB_SDIO    2
#define ARCHI_UDMA_NB_I2C     5
#define ARCHI_UDMA_NB_I2S     0
#define ARCHI_UDMA_NB_CAM     2
#define ARCHI_UDMA_NB_TRACER  1
#define ARCHI_UDMA_NB_FILTER  1

#define ARCHI_UDMA_UART_ID(id)            (0 + (id))
#define ARCHI_UDMA_SPIM_ID(id)            (8 + (id))
#define ARCHI_UDMA_I2C_ID(id)             (20 + (id))
#define ARCHI_UDMA_SDIO_ID(id)            (25 + (id))
//#define ARCHI_UDMA_I2S_ID(id)             
#define ARCHI_UDMA_CAM_ID(id)             (27 + (id))
#define ARCHI_UDMA_FILTER_ID(id)          (29  + (id))
//#define ARCHI_UDMA_TRACER_ID(id)          8
//#define ARCHI_UDMA_TGEN_ID(id)            9

#define ARCHI_NB_PERIPH                   29



/*
 * FLLS
*/

#define ARCHI_NB_FLL  3


/*
 * CLUSTER EVENTS
 */

#define ARCHI_CL_EVT_DMA0        8
#define ARCHI_CL_EVT_DMA1        9
#define ARCHI_EVT_TIMER0      10
#define ARCHI_EVT_TIMER1      11
#define ARCHI_CL_EVT_ACC0        12
#define ARCHI_CL_EVT_ACC1        13
#define ARCHI_CL_EVT_ACC2        14
#define ARCHI_CL_EVT_ACC3        15
#define ARCHI_CL_EVT_BAR         16
#define ARCHI_CL_EVT_MUTEX       17
#define ARCHI_CL_EVT_DISPATCH    18
#define ARCHI_EVT_MPU_ERROR   28
#define ARCHI_CL_EVT_SOC_EVT     30
#define ARCHI_EVT_SOC_FIFO    31


#endif

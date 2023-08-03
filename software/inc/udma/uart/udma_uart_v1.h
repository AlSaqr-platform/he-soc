/*
 * Copyright (C) 2018 ETH Zurich and University of Bologna
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

#ifndef __ARCHI_UDMA_UDMA_UART_V1_H__
#define __ARCHI_UDMA_UDMA_UART_V1_H__

#include "udma.h"

// UART custom registers offset definition
#define UART_STATUS_OFFSET               (0x00)
#define UART_SETUP_OFFSET                (0x04)

// UART custom registers bitfields offset, mask, value definition
// STATUS
#define UART_TX_BUSY_OFFSET   0
#define UART_TX_BUSY_WIDTH    1
#define UART_TX_BUSY_MASK   (0x1 << UART_TX_BUSY_OFFSET)
#define UART_TX_BUSY      (0x1 << UART_TX_BUSY_OFFSET)

#define UART_RX_BUSY_OFFSET   1
#define UART_RX_BUSY_WIDTH    1
#define UART_RX_BUSY_MASK   (0x1 << UART_RX_BUSY_OFFSET)
#define UART_RX_BUSY      (0x1 << UART_RX_BUSY_OFFSET)

#define UART_RX_PE_OFFSET   2
#define UART_RX_PE_WIDTH    1
#define UART_RX_PE_MASK     (0x1 << UART_RX_PE_OFFSET)
#define UART_RX_PE      (0x1 << UART_RX_PE_OFFSET)

// SETUP
#define UART_PARITY_OFFSET    0
#define UART_PARITY_WIDTH   1
#define UART_PARITY_MASK    (0x1 << UART_PARITY_OFFSET)
#define UART_PARITY_DIS     (0 << UART_PARITY_OFFSET)
#define UART_PARITY_ENA     (1 << UART_PARITY_OFFSET)

#define UART_BIT_LENGTH_OFFSET    1
#define UART_BIT_LENGTH_WIDTH   2
#define UART_BIT_LENGTH_MASK    (0x3 << UART_BIT_LENGTH_OFFSET)
#define UART_BIT_LENGTH_5   (0 << UART_BIT_LENGTH_OFFSET)
#define UART_BIT_LENGTH_6   (1 << UART_BIT_LENGTH_OFFSET)
#define UART_BIT_LENGTH_7   (2 << UART_BIT_LENGTH_OFFSET)
#define UART_BIT_LENGTH_8   (3 << UART_BIT_LENGTH_OFFSET)

#define UART_STOP_BITS_OFFSET   3
#define UART_STOP_BITS_WIDTH    1
#define UART_STOP_BITS_MASK   (0x1 << UART_STOP_BITS_OFFSET)
#define UART_STOP_BITS_1    (0 << UART_STOP_BITS_OFFSET)
#define UART_STOP_BITS_2    (1 << UART_STOP_BITS_OFFSET)

#define UART_TX_OFFSET    8
#define UART_TX_WIDTH   1
#define UART_TX_MASK    (0x1 << UART_TX_OFFSET)
#define UART_TX_DIS   (0 << UART_TX_OFFSET)
#define UART_TX_ENA   (1 << UART_TX_OFFSET)

#define UART_RX_OFFSET    9
#define UART_RX_WIDTH   1
#define UART_RX_MASK    (0x1 << UART_RX_OFFSET)
#define UART_RX_DIS   (0 << UART_RX_OFFSET)
#define UART_RX_ENA   (1 << UART_RX_OFFSET)

#define UART_CLKDIV_OFFSET    16
#define UART_CLKDIV_WIDTH   16
#define UART_CLKDIV_MASK    (0xffff << UART_CLKDIV_OFFSET)
#define UART_CLKDIV(val)    (val << UART_CLKDIV_OFFSET)

#define ARCHI_UDMA_UART_RX_EVT           0
#define ARCHI_UDMA_UART_TX_EVT           1

#define UDMA_UART_OFFSET(id)          UDMA_PERIPH_OFFSET(ARCHI_UDMA_UART_ID(id))
#define UDMA_UART_RX_ADDR(id)         (ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(id) + UDMA_CHANNEL_RX_OFFSET)
#define UDMA_UART_TX_ADDR(id)         (ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(id) + UDMA_CHANNEL_TX_OFFSET)
#define UDMA_UART_CUSTOM_ADDR(id)     (ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(id) + UDMA_CHANNEL_CUSTOM_OFFSET)
#define ARCHI_SOC_EVENT_UART_RX(id)    (ARCHI_SOC_EVENT_PERIPH_FIRST_EVT(ARCHI_UDMA_UART_ID(id)) + ARCHI_UDMA_UART_RX_EVT)
#define ARCHI_SOC_EVENT_UART_TX(id)    (ARCHI_SOC_EVENT_PERIPH_FIRST_EVT(ARCHI_UDMA_UART_ID(id)) + ARCHI_UDMA_UART_TX_EVT)

#define UDMA_USART_OFFSET(id)          UDMA_PERIPH_OFFSET(ARCHI_UDMA_USART_ID(id))
#define UDMA_USART_RX_ADDR(id)         (ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(id) + UDMA_CHANNEL_RX_OFFSET)
#define UDMA_USART_TX_ADDR(id)         (ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(id) + UDMA_CHANNEL_TX_OFFSET)
#define UDMA_USART_CUSTOM_ADDR(id)     (ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(id) + UDMA_CHANNEL_CUSTOM_OFFSET)
#define ARCHI_SOC_EVENT_USART_RX(id)    (ARCHI_SOC_EVENT_PERIPH_FIRST_EVT(ARCHI_UDMA_USART_ID(id)) + ARCHI_UDMA_UART_RX_EVT)
#define ARCHI_SOC_EVENT_USART_TX(id)    (ARCHI_SOC_EVENT_PERIPH_FIRST_EVT(ARCHI_UDMA_USART_ID(id)) + ARCHI_UDMA_UART_TX_EVT)

int udma_uart_open(int uart_id, int test_freq, int baudrate);
void udma_uart_close(int uart_id);
int udma_uart_write(int uart_id, void *buffer, uint32_t size);
int udma_uart_read(int uart_id, void *buffer, uint32_t size);

int udma_usart_open(int usart_id, int test_freq, int baudrate);
void udma_usart_close(int usart_id);
int udma_usart_write(int usart_id, void *buffer, uint32_t size);
int udma_usart_read(int usart_id, void *buffer, uint32_t size);

static inline void plp_uart_setup(int channel, int parity, uint16_t clk_counter)
{

  // [31:16]: clock divider (from SoC clock)
  // [9]: RX enable
  // [8]: TX enable
  // [3]: stop bits  0 = 1 stop bit
  //                 1 = 2 stop bits
  // [2:1]: bits     00 = 5 bits
  //                 01 = 6 bits
  //                 10 = 7 bits
  //                 11 = 8 bits
  // [0]: parity

  unsigned int val = 0x0306 | parity; // both tx and rx enabled; 8N1 configuration; 1 stop bits

  val |= ((clk_counter) << 16);

  pulp_write32(ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_SETUP_OFFSET, val);
}
static inline void plp_usart_setup(int channel, int parity, uint16_t clk_counter)
{

  // [31:16]: clock divider (from SoC clock)
  // [9]: RX enable
  // [8]: TX enable
  // [3]: stop bits  0 = 1 stop bit
  //                 1 = 2 stop bits
  // [2:1]: bits     00 = 5 bits
  //                 01 = 6 bits
  //                 10 = 7 bits
  //                 11 = 8 bits
  // [0]: parity

  unsigned int val = 0x0306 | parity; // both tx and rx enabled; 8N1 configuration; 1 stop bits

  val |= ((clk_counter) << 16);

  pulp_write32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_SETUP_OFFSET, val);
}

static inline void plp_uart_disable(int channel) {
  pulp_write32(ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_SETUP_OFFSET, 0x00500006);
}
static inline void plp_usart_disable(int channel) {
  pulp_write32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_SETUP_OFFSET, 0x00500006);
}

static inline int plp_uart_tx_busy(int channel) {
  return pulp_read32(ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_STATUS_OFFSET) & 1;
}
static inline int plp_usart_tx_busy(int channel) {
  return pulp_read32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_STATUS_OFFSET) & 1;
}

static inline int plp_uart_rx_busy(int channel) {
  return (pulp_read32(ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_STATUS_OFFSET) >> 1) & 1;
}
static inline int plp_usart_rx_busy(int channel) {
  return (pulp_read32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + UART_STATUS_OFFSET) >> 1) & 1;
}

static inline unsigned int plp_uart_reg_read(int channel, unsigned int addr)
{ //adr is an offset, expected UART_STATUS_OFFSET or UART_SETUP_OFFSET
  return pulp_read32(ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + addr);
}
static inline unsigned int plp_usart_reg_read(int channel, unsigned int addr)
{ //adr is an offset, expected UART_STATUS_OFFSET or UART_SETUP_OFFSET
  return pulp_read32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + addr);
}

static inline void plp_uart_reg_write(int channel, unsigned int addr, unsigned int cfg)
{ //adr is an offset, expected UART_STATUS_OFFSET or UART_SETUP_OFFSET
  pulp_write32(ARCHI_UDMA_ADDR + UDMA_UART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + addr, cfg);
}
static inline void plp_usart_reg_write(int channel, unsigned int addr, unsigned int cfg)
{ //adr is an offset, expected UART_STATUS_OFFSET or UART_SETUP_OFFSET
  pulp_write32(ARCHI_UDMA_ADDR + UDMA_USART_OFFSET(channel) + UDMA_CHANNEL_CUSTOM_OFFSET + addr, cfg);
}

#endif


#include "alsaqr_periph_fpga_padframe.h"
#define  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG0_BASE_ADDR ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS
#include "alsaqr_periph_fpga_padframe_periphs_regs.h"
#include "bitfield.h"

#define REG_WRITE32(addr, value) *((volatile uint32_t*) addr) = (uint32_t) value
#define REG_READ32(addr) *((volatile uint32_t*) addr)


void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_DRV_FIELD);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_OEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_PUEN_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SLW_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SMT_BIT);
}

void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

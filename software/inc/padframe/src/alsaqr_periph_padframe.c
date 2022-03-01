
#include "alsaqr_periph_padframe.h"
#define  ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG0_BASE_ADDR ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS
#include "alsaqr_periph_padframe_periphs_regs.h"
#include "bitfield.h"

#define REG_WRITE32(addr, value) *((volatile uint32_t*) addr) = (uint32_t) value
#define REG_READ32(addr) *((volatile uint32_t*) addr)


void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_13_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_14_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_15_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_16_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_17_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_18_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_19_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_20_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_21_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_22_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_23_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_24_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_25_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_26_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_27_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_28_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_29_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_30_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_31_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_32_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_33_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_34_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_35_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_36_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_37_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_38_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_39_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_40_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_41_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_42_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_43_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_44_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_45_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_46_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_47_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_48_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_49_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_50_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_51_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_52_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_53_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_54_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_55_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_56_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_B_57_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_C_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_D_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_E_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_00_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_01_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_02_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_03_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_04_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_05_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_06_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_07_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_08_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 2;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_09_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_10_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_11_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_12_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_13_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_14_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_15_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_16_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_17_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_18_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_19_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_20_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_21_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_22_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_23_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_24_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_F_25_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 1;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM0_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM1_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM2_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM3_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM4_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM5_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM6_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_chip2pad_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_CHIP2PAD_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_chip2pad_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_CHIP2PAD_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_drv_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_field32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_DRV_FIELD, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_drv_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_field32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_DRV_FIELD);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_oen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_OEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_oen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_OEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_puen_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_PUEN_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_puen_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_PUEN_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_slw_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_SLW_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_slw_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_SLW_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_smt_set(uint8_t value) {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  reg = bitfield_bit32_write(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_SMT_BIT, value);
  REG_WRITE32(address, reg);
}

uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_smt_get() {
  uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_REG_OFFSET;
  uint32_t reg = REG_READ32(address);
  return bitfield_bit32_read(reg, ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_CFG_SMT_BIT);
}

void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_sel_t mux_sel) {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;
  uint32_t field_mask = (1<<sel_size)-1;
  REG_WRITE32(address, mux_sel & field_mask);
}

alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_get() {
  const uint32_t address = ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS + ALSAQR_PERIPH_PADFRAME_PERIPHS_CONFIG_PAD_GPIO_PWM7_MUX_SEL_REG_OFFSET;
  const uint32_t sel_size = 4;

  uint32_t field_mask = (1<<sel_size)-1;
  return REG_READ32(address) & field_mask;
}


#ifndef ALSAQR_PERIPH_FPGA_PADFRAME_H
#define ALSAQR_PERIPH_FPGA_PADFRAME_H
#include <stdint.h>

#define ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS 0x1A104000

#ifndef ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS
#error "ALSAQR_PERIPH_FPGA_PADFRAME_BASE_ADDRESS is not defined. Set this token to the configuration base address of your padframe before you include this header file."
#endif



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_00
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_00
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_00
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_00
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_00
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_00
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_00_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_00_group_GPIO_B_port_GPIO0 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_00_group_SPI0_port_SPI_CS0 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_00.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_00.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_01
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_01
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_01
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_01
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_01
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_01
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_01_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_01_group_GPIO_B_port_GPIO1 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_01_group_SPI0_port_SPI_SCK = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_01.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_01.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_02
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_02
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_02
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_02
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_02
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_02
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_02_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_02_group_GPIO_B_port_GPIO2 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_02_group_SPI0_port_SPI_MISO = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_02.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_02.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_03
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_03
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_03
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_03
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_03
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_03
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_03_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_03_group_GPIO_B_port_GPIO3 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_03_group_SPI0_port_SPI_MOSI = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_03.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_03.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_04
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_04
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_04
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_04
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_04
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_04
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_04_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_04_group_GPIO_B_port_GPIO4 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_04_group_I2C0_port_I2C_SCL = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_04.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_04.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_05
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_05
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_05
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_05
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_05
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_05
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_05_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_05_group_GPIO_B_port_GPIO5 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_05_group_I2C0_port_I2C_SDA = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_05.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_05.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_06
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_06
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_06
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_06
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_06
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_06
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_06_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_06_group_GPIO_B_port_GPIO6 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_06_group_UART0_port_UART_TX = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_06.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_06.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_07
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_07
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_07
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_07
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_07
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_07
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_07_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_07_group_GPIO_B_port_GPIO7 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_07_group_UART0_port_UART_RX = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_07.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_07.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_08
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_08
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_08
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_08
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_08
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_08
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_08_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_08_group_GPIO_B_port_GPIO8 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_08_group_SDIO0_port_SDIO_DATA0 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_08.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_08.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_09
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_09
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_09
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_09
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_09
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_09
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_09_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_09_group_GPIO_B_port_GPIO9 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_09_group_SDIO0_port_SDIO_DATA1 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_09.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_09.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_10
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_10
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_10
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_10
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_10
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_10
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_10_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_10_group_GPIO_B_port_GPIO10 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_10_group_SDIO0_port_SDIO_DATA2 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_10.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_10.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_11
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_11
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_11
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_11
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_11
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_11
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_11_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_11_group_GPIO_B_port_GPIO11 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_11_group_SDIO0_port_SDIO_DATA3 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_11.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_11.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_12
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_12
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_12
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_12
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_12
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_12
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_12_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_12_group_GPIO_B_port_GPIO12 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_12_group_SDIO0_port_SDIO_CLK = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_12.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_12.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_13
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_13
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_13
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_13
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_13
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_13
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_13_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_13_group_GPIO_B_port_GPIO13 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_13_group_SDIO0_port_SDIO_CMD = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_13.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_13.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_14
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_14
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_14
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_14
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_14
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_14
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_14_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_14_group_GPIO_B_port_GPIO14 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_14_group_QSPI_OT_port_QSPI_SCK = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_14.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_14.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_15
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_15
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_15
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_15
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_15
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_15
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_15_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_15_group_GPIO_B_port_GPIO15 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_15_group_QSPI_OT_port_QSPI_CSN = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_15.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_15.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_15_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_16
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_16
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_16
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_16
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_16
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_16
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_16_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_16_group_GPIO_B_port_GPIO16 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_16_group_QSPI_OT_port_QSPI_SD0 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_16.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_16.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_16_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_17
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_17
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_17
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_17
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_17
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_17
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_17_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_17_group_GPIO_B_port_GPIO17 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_17_group_QSPI_OT_port_QSPI_SD1 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_17.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_17.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_17_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_18
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_18
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_18
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_18
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_18
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_18
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_18_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_18_group_GPIO_B_port_GPIO18 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_18_group_QSPI_OT_port_QSPI_SD2 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_18.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_18.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_18_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_19
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_19
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_19
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_19
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_19
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_19
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_19_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_19_group_GPIO_B_port_GPIO19 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_19_group_QSPI_OT_port_QSPI_SD3 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_19.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_19.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_19_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_20
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_20
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_20
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_20
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_20
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_20
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_20_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_20_group_GPIO_B_port_GPIO20 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_20_group_QSPI_port_QSPI_SCK = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_20.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_20.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_20_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_21
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_21
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_21
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_21
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_21
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_21
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_21_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_21_group_GPIO_B_port_GPIO21 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_21_group_QSPI_port_QSPI_CSN = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_21.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_21.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_21_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_22
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_22
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_22
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_22
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_22
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_22
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_22_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_22_group_GPIO_B_port_GPIO22 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_22_group_QSPI_port_QSPI_SD0 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_22.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_22.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_22_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_23
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_23
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_23
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_23
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_23
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_23
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_23_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_23_group_GPIO_B_port_GPIO23 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_23_group_QSPI_port_QSPI_SD1 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_23.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_23.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_23_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_24
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_24
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_24
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_24
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_24
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_24
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_24_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_24_group_GPIO_B_port_GPIO24 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_24_group_QSPI_port_QSPI_SD2 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_24.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_24.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_24_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_25
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_25
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_25
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_25
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_25
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_25
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_25_REGISTER = 0,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_25_group_GPIO_B_port_GPIO25 = 1,
  ALSAQR_PERIPH_FPGA_PADFRAME_PERIPHS_PAD_GPIO_B_25_group_QSPI_port_QSPI_SD3 = 2,
} alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_25.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_mux_set(alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_25.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_mux_sel_t alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_25_mux_get();




#endif /*  ALSAQR_PERIPH_FPGA_PADFRAME_H */

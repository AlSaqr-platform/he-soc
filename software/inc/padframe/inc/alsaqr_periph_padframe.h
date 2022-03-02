
#ifndef ALSAQR_PERIPH_PADFRAME_H
#define ALSAQR_PERIPH_PADFRAME_H
#include <stdint.h>

#define ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS 0x1A104000

#ifndef ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS
#error "ALSAQR_PERIPH_PADFRAME_BASE_ADDRESS is not defined. Set this token to the configuration base address of your padframe before you include this header file."
#endif



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_00
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_00
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_00
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_00
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_00
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_00
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_00_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_00_group_GPIO_B_port_GPIO0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_00_group_SPI0_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_00.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_00.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_00_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_01
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_01
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_01
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_01
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_01
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_01
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_01_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_01_group_GPIO_B_port_GPIO1 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_01_group_SPI0_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_01.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_01.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_01_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_02
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_02
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_02
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_02
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_02
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_02
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_02_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_02_group_GPIO_B_port_GPIO2 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_02_group_SPI0_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_02.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_02.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_02_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_03
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_03
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_03
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_03
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_03
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_03
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_03_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_03_group_GPIO_B_port_GPIO3 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_03_group_SPI0_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_03.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_03.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_03_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_04
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_04
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_04
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_04
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_04
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_04
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_04_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_04_group_GPIO_B_port_GPIO4 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_04_group_SPI1_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_04.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_04.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_04_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_05
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_05
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_05
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_05
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_05
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_05
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_05_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_05_group_GPIO_B_port_GPIO5 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_05_group_SPI1_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_05.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_05.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_05_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_06
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_06
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_06
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_06
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_06
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_06
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_06_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_06_group_GPIO_B_port_GPIO6 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_06_group_SPI1_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_06.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_06.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_06_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_07
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_07
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_07
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_07
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_07
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_07
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_07_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_07_group_GPIO_B_port_GPIO7 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_07_group_SPI1_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_07.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_07.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_07_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_08
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_08
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_08
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_08
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_08
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_08
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_08_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_08_group_GPIO_B_port_GPIO8 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_08_group_SPI2_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_08.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_08.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_08_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_09
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_09
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_09
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_09
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_09
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_09
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_09_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_09_group_GPIO_B_port_GPIO9 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_09_group_SPI2_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_09.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_09.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_09_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_10
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_10
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_10
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_10
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_10
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_10
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_10_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_10_group_GPIO_B_port_GPIO10 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_10_group_SPI2_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_10.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_10.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_10_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_11
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_11
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_11
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_11
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_11
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_11
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_11_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_11_group_GPIO_B_port_GPIO11 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_11_group_SPI2_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_11.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_11.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_11_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_12
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_12
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_12
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_12
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_12
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_12
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_12_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_12_group_GPIO_B_port_GPIO12 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_12_group_SPI3_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_12.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_12.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_12_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_13
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_13
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_13
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_13
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_13
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_13
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_13_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_13_group_GPIO_B_port_GPIO13 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_13_group_SPI3_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_13.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_13.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_13_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_14
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_14
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_14
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_14
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_14
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_14
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_14_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_14_group_GPIO_B_port_GPIO14 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_14_group_SPI3_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_14.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_14.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_14_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_15
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_15
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_15
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_15
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_15
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_15
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_15_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_15_group_GPIO_B_port_GPIO15 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_15_group_SPI3_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_15.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_15.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_15_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_16
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_16
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_16
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_16
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_16
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_16
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_16_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_16_group_GPIO_B_port_GPIO16 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_16_group_SPI4_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_16.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_16.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_16_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_17
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_17
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_17
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_17
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_17
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_17
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_17_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_17_group_GPIO_B_port_GPIO17 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_17_group_SPI4_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_17.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_17.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_17_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_18
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_18
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_18
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_18
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_18
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_18
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_18_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_18_group_GPIO_B_port_GPIO18 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_18_group_SPI4_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_18.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_18.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_18_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_19
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_19
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_19
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_19
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_19
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_19
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_19_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_19_group_GPIO_B_port_GPIO19 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_19_group_SPI4_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_19.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_19.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_19_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_20
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_20
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_20
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_20
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_20
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_20
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_20_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_20_group_GPIO_B_port_GPIO20 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_20_group_SPI5_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_20.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_20.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_20_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_21
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_21
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_21
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_21
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_21
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_21
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_21_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_21_group_GPIO_B_port_GPIO21 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_21_group_SPI5_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_21.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_21.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_21_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_22
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_22
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_22
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_22
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_22
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_22
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_22_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_22_group_GPIO_B_port_GPIO22 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_22_group_SPI5_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_22.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_22.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_22_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_23
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_23
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_23
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_23
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_23
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_23
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_23_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_23_group_GPIO_B_port_GPIO23 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_23_group_SPI5_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_23.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_23.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_23_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_24
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_24
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_24
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_24
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_24
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_24
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_24_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_24_group_GPIO_B_port_GPIO24 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_24_group_SPI6_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_24.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_24.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_24_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_25
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_25
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_25
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_25
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_25
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_25
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_25_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_25_group_GPIO_B_port_GPIO25 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_25_group_SPI6_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_25.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_25.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_25_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_26
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_26
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_26
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_26
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_26
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_26
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_26
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_26
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_26
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_26
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_26
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_26
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_26_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_26_group_GPIO_B_port_GPIO26 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_26_group_SPI6_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_26.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_26.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_26_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_27
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_27
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_27
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_27
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_27
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_27
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_27
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_27
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_27
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_27
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_27
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_27
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_27_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_27_group_GPIO_B_port_GPIO27 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_27_group_SPI6_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_27.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_27.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_27_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_28
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_28
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_28
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_28
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_28
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_28
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_28
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_28
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_28
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_28
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_28
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_28
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_28_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_28_group_GPIO_B_port_GPIO28 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_28_group_QSPI_port_QSPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_28.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_28.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_28_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_29
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_29
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_29
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_29
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_29
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_29
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_29
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_29
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_29
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_29
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_29
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_29
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_29_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_29_group_GPIO_B_port_GPIO29 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_29_group_QSPI_port_QSPI_CSN = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_29.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_29.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_29_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_30
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_30
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_30
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_30
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_30
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_30
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_30
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_30
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_30
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_30
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_30
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_30
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_30_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_30_group_GPIO_B_port_GPIO30 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_30_group_QSPI_port_QSPI_SD0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_30.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_30.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_30_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_31
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_31
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_31
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_31
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_31
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_31
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_31
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_31
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_31
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_31
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_31
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_31
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_31_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_31_group_GPIO_B_port_GPIO31 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_31_group_QSPI_port_QSPI_SD1 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_31.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_31.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_31_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_32
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_32
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_32
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_32
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_32
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_32
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_32
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_32
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_32
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_32
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_32
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_32
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_32_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_32_group_GPIO_B_port_GPIO32 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_32_group_QSPI_port_QSPI_SD2 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_32.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_32.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_32_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_33
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_33
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_33
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_33
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_33
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_33
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_33
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_33
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_33
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_33
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_33
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_33
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_33_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_33_group_GPIO_B_port_GPIO33 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_33_group_QSPI_port_QSPI_SD3 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_33.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_33.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_33_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_34
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_34
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_34
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_34
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_34
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_34
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_34
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_34
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_34
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_34
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_34
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_34
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_34_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_34_group_GPIO_B_port_GPIO34 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_34_group_SDIO0_port_SDIO_DATA0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_34.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_34.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_34_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_35
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_35
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_35
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_35
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_35
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_35
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_35
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_35
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_35
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_35
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_35
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_35
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_35_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_35_group_GPIO_B_port_GPIO35 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_35_group_SDIO0_port_SDIO_DATA1 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_35.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_35.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_35_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_36
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_36
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_36
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_36
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_36
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_36
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_36
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_36
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_36
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_36
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_36
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_36
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_36_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_36_group_GPIO_B_port_GPIO36 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_36_group_SDIO0_port_SDIO_DATA2 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_36.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_36.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_36_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_37
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_37
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_37
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_37
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_37
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_37
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_37
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_37
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_37
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_37
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_37
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_37
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_37_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_37_group_GPIO_B_port_GPIO37 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_37_group_SDIO0_port_SDIO_DATA3 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_37.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_37.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_37_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_38
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_38
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_38
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_38
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_38
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_38
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_38
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_38
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_38
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_38
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_38
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_38
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_38_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_38_group_GPIO_B_port_GPIO38 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_38_group_SDIO0_port_SDIO_CLK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_38.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_38.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_38_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_39
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_39
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_39
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_39
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_39
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_39
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_39
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_39
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_39
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_39
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_39
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_39
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_39_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_39_group_GPIO_B_port_GPIO39 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_39_group_SDIO0_port_SDIO_CMD = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_39.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_39.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_39_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_40
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_40
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_40
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_40
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_40
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_40
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_40
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_40
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_40
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_40
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_40
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_40
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_40_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_40_group_GPIO_B_port_GPIO40 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_40_group_UART0_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_40.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_40.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_40_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_41
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_41
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_41
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_41
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_41
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_41
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_41
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_41
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_41
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_41
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_41
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_41
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_41_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_41_group_GPIO_B_port_GPIO41 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_41_group_UART0_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_41.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_41.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_41_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_42
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_42
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_42
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_42
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_42
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_42
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_42
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_42
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_42
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_42
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_42
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_42
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_42_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_42_group_GPIO_B_port_GPIO42 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_42_group_UART1_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_42.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_42.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_42_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_43
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_43
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_43
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_43
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_43
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_43
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_43
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_43
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_43
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_43
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_43
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_43
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_43_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_43_group_GPIO_B_port_GPIO43 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_43_group_UART1_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_43.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_43.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_43_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_44
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_44
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_44
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_44
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_44
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_44
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_44
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_44
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_44
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_44
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_44
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_44
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_44_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_44_group_GPIO_B_port_GPIO44 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_44_group_UART2_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_44.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_44.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_44_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_45
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_45
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_45
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_45
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_45
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_45
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_45
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_45
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_45
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_45
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_45
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_45
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_45_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_45_group_GPIO_B_port_GPIO45 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_45_group_UART2_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_45.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_45.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_45_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_46
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_46
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_46
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_46
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_46
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_46
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_46
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_46
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_46
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_46
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_46
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_46
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_46_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_46_group_GPIO_B_port_GPIO46 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_46_group_UART3_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_46.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_46.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_46_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_47
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_47
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_47
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_47
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_47
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_47
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_47
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_47
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_47
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_47
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_47
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_47
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_47_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_47_group_GPIO_B_port_GPIO47 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_47_group_UART3_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_47.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_47.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_47_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_48
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_48
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_48
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_48
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_48
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_48
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_48
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_48
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_48
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_48
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_48
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_48
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_48_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_48_group_GPIO_B_port_GPIO48 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_48_group_UART4_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_48.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_48.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_48_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_49
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_49
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_49
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_49
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_49
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_49
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_49
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_49
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_49
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_49
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_49
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_49
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_49_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_49_group_GPIO_B_port_GPIO49 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_49_group_UART4_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_49.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_49.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_49_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_50
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_50
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_50
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_50
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_50
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_50
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_50
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_50
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_50
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_50
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_50
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_50
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_50_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_50_group_GPIO_B_port_GPIO50 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_50_group_I2C0_port_I2C_SCL = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_50.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_50.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_50_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_51
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_51
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_51
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_51
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_51
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_51
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_51
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_51
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_51
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_51
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_51
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_51
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_51_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_51_group_GPIO_B_port_GPIO51 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_51_group_I2C0_port_I2C_SDA = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_51.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_51.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_51_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_52
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_52
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_52
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_52
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_52
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_52
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_52
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_52
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_52
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_52
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_52
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_52
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_52_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_52_group_GPIO_B_port_GPIO52 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_52_group_I2C4_port_I2C_SCL = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_52.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_52.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_52_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_53
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_53
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_53
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_53
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_53
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_53
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_53
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_53
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_53
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_53
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_53
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_53
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_53_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_53_group_GPIO_B_port_GPIO53 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_53_group_I2C4_port_I2C_SDA = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_53.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_53.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_53_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_54
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_54
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_54
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_54
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_54
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_54
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_54
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_54
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_54
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_54
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_54
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_54
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_54_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_54_group_GPIO_B_port_GPIO54 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_54_group_I2C5_port_I2C_SCL = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_54.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_54.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_54_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_55
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_55
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_55
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_55
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_55
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_55
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_55
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_55
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_55
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_55
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_55
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_55
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_55_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_55_group_GPIO_B_port_GPIO55 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_55_group_I2C5_port_I2C_SDA = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_55.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_55.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_55_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_56
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_56
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_56
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_56
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_56
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_56
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_56
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_56
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_56
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_56
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_56
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_56
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_56_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_56_group_GPIO_B_port_GPIO56 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_56.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_56.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_56_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_b_57
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_b_57
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_b_57
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_b_57
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_b_57
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_b_57
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_b_57
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_b_57
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_b_57
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_b_57
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_b_57
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_b_57
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_57_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_B_57_group_GPIO_B_port_GPIO57 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_b_57.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_b_57.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_b_57_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_c_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_c_00
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_c_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_c_00
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_c_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_c_00
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_c_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_c_00
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_c_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_c_00
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_c_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_c_00
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_00_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_00_group_CAN0_port_CAN_TX = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_00_group_SPI7_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_c_00.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_c_00.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_00_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_c_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_c_01
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_c_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_c_01
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_c_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_c_01
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_c_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_c_01
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_c_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_c_01
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_c_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_c_01
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_01_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_01_group_CAN0_port_CAN_RX = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_01_group_SPI7_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_c_01.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_c_01.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_01_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_c_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_c_02
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_c_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_c_02
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_c_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_c_02
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_c_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_c_02
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_c_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_c_02
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_c_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_c_02
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_02_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_02_group_CAN1_port_CAN_TX = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_02_group_SPI7_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_c_02.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_c_02.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_02_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_c_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_c_03
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_c_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_c_03
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_c_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_c_03
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_c_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_c_03
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_c_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_c_03
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_c_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_c_03
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_03_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_03_group_CAN1_port_CAN_RX = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_C_03_group_SPI7_port_SPI_CS0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_c_03.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_c_03.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_c_03_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_00
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_00
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_00
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_00
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_00
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_00
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_00_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_00_group_CAM0_port_CAM_PCLK = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_00_group_I2C1_port_I2C_SCL = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_00.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_00.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_00_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_01
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_01
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_01
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_01
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_01
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_01
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_01_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_01_group_CAM0_port_CAM_HSYNC = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_01_group_I2C1_port_I2C_SDA = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_01.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_01.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_01_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_02
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_02
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_02
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_02
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_02
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_02
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_02_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_02_group_CAM0_port_CAM_DATA0_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_02_group_I2C2_port_I2C_SCL = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_02.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_02.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_02_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_03
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_03
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_03
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_03
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_03
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_03
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_03_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_03_group_CAM0_port_CAM_DATA1_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_03_group_I2C2_port_I2C_SDA = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_03.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_03.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_03_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_04
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_04
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_04
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_04
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_04
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_04
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_04_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_04_group_CAM0_port_CAM_DATA2_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_04_group_I2C3_port_I2C_SCL = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_04.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_04.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_04_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_05
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_05
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_05
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_05
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_05
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_05
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_05_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_05_group_CAM0_port_CAM_DATA3_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_05_group_I2C3_port_I2C_SDA = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_05.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_05.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_05_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_06
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_06
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_06
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_06
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_06
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_06
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_06_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_06_group_CAM0_port_CAM_DATA4_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_06_group_UART7_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_06.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_06.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_06_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_07
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_07
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_07
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_07
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_07
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_07
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_07_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_07_group_CAM0_port_CAM_DATA5_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_07_group_UART7_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_07.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_07.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_07_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_08
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_08
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_08
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_08
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_08
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_08
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_08_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_08_group_CAM0_port_CAM_DATA6_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_08.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_08.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_08_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_09
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_09
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_09
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_09
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_09
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_09
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_09_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_09_group_CAM0_port_CAM_DATA7_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_09.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_09.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_09_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_d_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_d_10
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_d_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_d_10
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_d_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_d_10
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_d_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_d_10
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_d_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_d_10
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_d_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_d_10
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_10_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_D_10_group_CAM0_port_CAM_VSYNC = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_d_10.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_d_10.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_d_10_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_00
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_00
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_00
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_00
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_00
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_00
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_00_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_00_group_CAM1_port_CAM_PCLK = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_00_group_SPI8_port_SPI_SCK = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_00_group_SPI9_port_SPI_SCK = 3,
} alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_00.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_00.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_00_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_01
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_01
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_01
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_01
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_01
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_01
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_01_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_01_group_CAM1_port_CAM_HSYNC = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_01_group_SPI8_port_SPI_CS0 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_01_group_SPI9_port_SPI_CS0 = 3,
} alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_01.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_01.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_01_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_02
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_02
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_02
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_02
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_02
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_02
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_02_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_02_group_CAM1_port_CAM_DATA0_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_02_group_SPI8_port_SPI_MISO = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_02_group_SPI9_port_SPI_MISO = 3,
} alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_02.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_02.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_02_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_03
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_03
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_03
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_03
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_03
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_03
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_03_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_03_group_CAM1_port_CAM_DATA1_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_03_group_SPI8_port_SPI_MOSI = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_03_group_SPI9_port_SPI_MOSI = 3,
} alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_03.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_03.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_03_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_04
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_04
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_04
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_04
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_04
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_04
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_04_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_04_group_CAM1_port_CAM_DATA2_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_04.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_04.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_04_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_05
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_05
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_05
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_05
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_05
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_05
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_05_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_05_group_CAM1_port_CAM_DATA3_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_05.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_05.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_05_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_06
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_06
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_06
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_06
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_06
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_06
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_06_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_06_group_CAM1_port_CAM_DATA4_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_06.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_06.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_06_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_07
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_07
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_07
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_07
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_07
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_07
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_07_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_07_group_CAM1_port_CAM_DATA5_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_07.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_07.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_07_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_08
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_08
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_08
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_08
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_08
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_08
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_08_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_08_group_CAM1_port_CAM_DATA6_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_08_group_SPI10_port_SPI_SCK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_08.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_08.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_08_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_09
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_09
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_09
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_09
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_09
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_09
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_09_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_09_group_CAM1_port_CAM_DATA7_I = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_09_group_SPI10_port_SPI_MISO = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_09.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_09.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_09_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_10
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_10
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_10
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_10
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_10
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_10
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_10_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_10_group_CAM1_port_CAM_VSYNC = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_10_group_SPI10_port_SPI_MOSI = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_10.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_10.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_10_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_11
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_11
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_11
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_11
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_11
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_11
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_11_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_11_group_SPI10_port_SPI_CS0 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_11.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_11.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_11_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_e_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_e_12
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_e_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_e_12
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_e_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_e_12
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_e_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_e_12
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_e_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_e_12
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_e_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_e_12
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_12_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_E_12_group_SPI10_port_SPI_CS1 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_e_12.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_e_12.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_e_12_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_00
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_00
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_00
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_00
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_00
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_00
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_00
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_00_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_00_group_ETH_port_ETH_RST = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_00.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_00.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_00_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_01
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_01
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_01
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_01
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_01
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_01
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_01
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_01_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_01_group_ETH_port_ETH_TXCK = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_01_group_SDIO1_port_SDIO_DATA0 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_01.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_01.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_01_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_02
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_02
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_02
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_02
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_02
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_02
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_02
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_02_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_02_group_ETH_port_ETH_TXCTL = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_02_group_SDIO1_port_SDIO_DATA1 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_02.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_02.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_02_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_03
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_03
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_03
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_03
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_03
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_03
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_03
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_03_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_03_group_ETH_port_ETH_TXD0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_03_group_SDIO1_port_SDIO_DATA2 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_03.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_03.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_03_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_04
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_04
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_04
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_04
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_04
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_04
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_04
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_04_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_04_group_ETH_port_ETH_TXD1 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_04_group_SDIO1_port_SDIO_DATA3 = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_04.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_04.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_04_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_05
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_05
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_05
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_05
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_05
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_05
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_05
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_05_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_05_group_ETH_port_ETH_TXD2 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_05_group_SDIO1_port_SDIO_CLK = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_05.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_05.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_05_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_06
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_06
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_06
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_06
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_06
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_06
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_06
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_06_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_06_group_ETH_port_ETH_TXD3 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_06_group_SDIO1_port_SDIO_CMD = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_06.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_06.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_06_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_07
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_07
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_07
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_07
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_07
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_07
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_07
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_07_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_07_group_ETH_port_ETH_MDC = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_07_group_UART6_port_UART_TX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_07.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_07.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_07_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_08
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_08
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_08
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_08
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_08
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_08
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_08
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_08_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_08_group_ETH_port_ETH_MDIO = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_08_group_UART6_port_UART_RX = 2,
} alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_08.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_08.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_08_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_09
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_09
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_09
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_09
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_09
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_09
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_09
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_09_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_09_group_ETH_port_ETH_RXCK = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_09.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_09.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_09_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_10
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_10
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_10
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_10
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_10
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_10
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_10
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_10_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_10_group_ETH_port_ETH_RXCTL = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_10.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_10.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_10_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_11
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_11
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_11
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_11
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_11
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_11
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_11
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_11_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_11_group_ETH_port_ETH_RXD0 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_11.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_11.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_11_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_12
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_12
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_12
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_12
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_12
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_12
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_12
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_12_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_12_group_ETH_port_ETH_RXD1 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_12.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_12.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_12_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_13
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_13
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_13
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_13
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_13
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_13
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_13
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_13_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_13_group_ETH_port_ETH_RXD2 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_13.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_13.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_13_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_14
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_14
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_14
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_14
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_14
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_14
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_14
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_14_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_14_group_ETH_port_ETH_RXD3 = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_14.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_14.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_14_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_15
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_15
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_15
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_15
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_15
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_15
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_15
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_15_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_15_group_UART5_port_UART_TX = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_15.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_15.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_15_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_16
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_16
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_16
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_16
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_16
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_16
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_16
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_16_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_16_group_UART5_port_UART_RX = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_16.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_16.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_16_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_17
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_17
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_17
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_17
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_17
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_17
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_17
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_17_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_17_group_DDR_LINK_port_CLK_I = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_17.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_17.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_17_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_18
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_18
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_18
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_18
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_18
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_18
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_18
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_18_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_18_group_DDR_LINK_port_DDR0_IN = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_18.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_18.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_18_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_19
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_19
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_19
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_19
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_19
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_19
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_19
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_19_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_19_group_DDR_LINK_port_DDR1_IN = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_19.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_19.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_19_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_20
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_20
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_20
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_20
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_20
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_20
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_20
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_20_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_20_group_DDR_LINK_port_DDR2_IN = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_20.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_20.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_20_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_21
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_21
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_21
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_21
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_21
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_21
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_21
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_21_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_21_group_DDR_LINK_port_DDR3_IN = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_21.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_21.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_21_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_22
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_22
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_22
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_22
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_22
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_22
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_22
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_22_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_22_group_DDR_LINK_port_DDR0_OUT = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_22.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_22.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_22_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_23
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_23
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_23
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_23
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_23
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_23
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_23
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_23_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_23_group_DDR_LINK_port_DDR1_OUT = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_23.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_23.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_23_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_24
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_24
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_24
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_24
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_24
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_24
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_24
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_24_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_24_group_DDR_LINK_port_DDR2_OUT = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_24.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_24.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_24_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_f_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_f_25
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_f_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_f_25
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_f_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_f_25
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_f_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_f_25
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_f_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_f_25
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_f_25
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_f_25
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_25_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_F_25_group_DDR_LINK_port_DDR3_OUT = 1,
} alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_f_25.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_f_25.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_f_25_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm0
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm0
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm0
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm0
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm0
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm0
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm0
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm0
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm0
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm0
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm0
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm0
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM0_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm0.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm0.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm0_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm1
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm1
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm1
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm1
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm1
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm1
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm1
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm1
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm1
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm1
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm1
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm1
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM1_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm1.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm1.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm1_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm2
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm2
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm2
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm2
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm2
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm2
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm2
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm2
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm2
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm2
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm2
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm2
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM2_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm2.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm2.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm2_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm3
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm3
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm3
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm3
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm3
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm3
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm3
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm3
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm3
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm3
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm3
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm3
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM3_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm3.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm3.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm3_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm4
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm4
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm4
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm4
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm4
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm4
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm4
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm4
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm4
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm4
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm4
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm4
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM4_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm4.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm4.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm4_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm5
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm5
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm5
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm5
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm5
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm5
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm5
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm5
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm5
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm5
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm5
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm5
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM5_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm5.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm5.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm5_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm6
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm6
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm6
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm6
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm6
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm6
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm6
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm6
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm6
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm6
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm6
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm6
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM6_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm6.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm6.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm6_mux_get();



/**
 * Sets the chip2pad pad signal for the pad: pad_gpio_pwm7
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_chip2pad_set(uint8_t value);

/**
 * Get the currently configured chip2pad value for the pad: pad_gpio_pwm7
 *
 * @return The value of the chip2pad field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_chip2pad_get();

/**
 * Sets the drv pad signal for the pad: pad_gpio_pwm7
 *
 * @param value The value to program into the pad configuration register. A value smaller than 3.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_drv_set(uint8_t value);

/**
 * Get the currently configured drv value for the pad: pad_gpio_pwm7
 *
 * @return The value of the drv field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_drv_get();

/**
 * Sets the oen pad signal for the pad: pad_gpio_pwm7
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_oen_set(uint8_t value);

/**
 * Get the currently configured oen value for the pad: pad_gpio_pwm7
 *
 * @return The value of the oen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_oen_get();

/**
 * Sets the puen pad signal for the pad: pad_gpio_pwm7
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_puen_set(uint8_t value);

/**
 * Get the currently configured puen value for the pad: pad_gpio_pwm7
 *
 * @return The value of the puen field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_puen_get();

/**
 * Sets the slw pad signal for the pad: pad_gpio_pwm7
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_slw_set(uint8_t value);

/**
 * Get the currently configured slw value for the pad: pad_gpio_pwm7
 *
 * @return The value of the slw field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_slw_get();

/**
 * Sets the smt pad signal for the pad: pad_gpio_pwm7
 *
 * @param value The value to program into the pad configuration register. A value smaller than 1.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_smt_set(uint8_t value);

/**
 * Get the currently configured smt value for the pad: pad_gpio_pwm7
 *
 * @return The value of the smt field
 */
uint8_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_cfg_smt_get();

typedef enum {
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_REGISTER = 0,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM0 = 1,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM1 = 2,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM2 = 3,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM3 = 4,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM4 = 5,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM5 = 6,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM6 = 7,
  ALSAQR_PERIPH_PADFRAME_PERIPHS_PAD_GPIO_PWM7_group_PWM_port_PWM7 = 8,
} alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_sel_t;

/**
   * Choose the entity (a port or the dedicated configuration register) that controls pad_gpio_pwm7.
   *
   * @param mux_sel Port or configuration register to connect to the pad.
 */
void alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_set(alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_sel_t mux_sel);

/**
 * Read the current multiplexer select value configured for pad_gpio_pwm7.
 *
 * @return Port or configuration register currently connected to the pad.
 */
 alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_sel_t alsaqr_periph_padframe_periphs_pad_gpio_pwm7_mux_get();




#endif /*  ALSAQR_PERIPH_PADFRAME_H */

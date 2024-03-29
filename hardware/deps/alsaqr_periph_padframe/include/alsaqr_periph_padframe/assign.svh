// File auto-generated by Padrick 0.1.0.post0.dev51+g806b078.dirty

// Assignment Macros
// Assigns all members of port struct to another struct with same names but potentially different order

`define ASSIGN_PERIPHS_SPI_OT_PAD2SOC(load, driver) \
  assign load.sd0_i = driver.sd0_o; \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI_OT_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \
  assign load.sd0_oen_i = driver.sd0_oen_o; \
  assign load.sd1_i = driver.sd1_o; \
  assign load.sd1_oen_i = driver.sd1_oen_o; \

`define ASSIGN_PERIPHS_UART_CORE_PAD2SOC(load, driver) \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_UART_CORE_SOC2PAD(load, driver) \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_SDIO0_PAD2SOC(load, driver) \
  assign load.cmd_i = driver.cmd_o; \
  assign load.data0_i = driver.data0_o; \
  assign load.data1_i = driver.data1_o; \
  assign load.data2_i = driver.data2_o; \
  assign load.data3_i = driver.data3_o; \

`define ASSIGN_PERIPHS_SDIO0_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.cmd_i = driver.cmd_o; \
  assign load.cmd_oen_i = driver.cmd_oen_o; \
  assign load.data0_i = driver.data0_o; \
  assign load.data0_oen_i = driver.data0_oen_o; \
  assign load.data1_i = driver.data1_o; \
  assign load.data1_oen_i = driver.data1_oen_o; \
  assign load.data2_i = driver.data2_o; \
  assign load.data2_oen_i = driver.data2_oen_o; \
  assign load.data3_i = driver.data3_o; \
  assign load.data3_oen_i = driver.data3_oen_o; \

`define ASSIGN_PERIPHS_SDIO1_PAD2SOC(load, driver) \
  assign load.cmd_i = driver.cmd_o; \
  assign load.data0_i = driver.data0_o; \
  assign load.data1_i = driver.data1_o; \
  assign load.data2_i = driver.data2_o; \
  assign load.data3_i = driver.data3_o; \

`define ASSIGN_PERIPHS_SDIO1_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.cmd_i = driver.cmd_o; \
  assign load.cmd_oen_i = driver.cmd_oen_o; \
  assign load.data0_i = driver.data0_o; \
  assign load.data0_oen_i = driver.data0_oen_o; \
  assign load.data1_i = driver.data1_o; \
  assign load.data1_oen_i = driver.data1_oen_o; \
  assign load.data2_i = driver.data2_o; \
  assign load.data2_oen_i = driver.data2_oen_o; \
  assign load.data3_i = driver.data3_o; \
  assign load.data3_oen_i = driver.data3_oen_o; \


`define ASSIGN_PERIPHS_PWM0_SOC2PAD(load, driver) \
  assign load.pwm0_i = driver.pwm0_o; \
  assign load.pwm1_i = driver.pwm1_o; \
  assign load.pwm2_i = driver.pwm2_o; \
  assign load.pwm3_i = driver.pwm3_o; \


`define ASSIGN_PERIPHS_PWM1_SOC2PAD(load, driver) \
  assign load.pwm0_i = driver.pwm0_o; \
  assign load.pwm1_i = driver.pwm1_o; \
  assign load.pwm2_i = driver.pwm2_o; \
  assign load.pwm3_i = driver.pwm3_o; \

`define ASSIGN_PERIPHS_I2C0_PAD2SOC(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.sda_i = driver.sda_o; \

`define ASSIGN_PERIPHS_I2C0_SOC2PAD(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.scl_oe_i = driver.scl_oe_o; \
  assign load.sda_i = driver.sda_o; \
  assign load.sda_oe_i = driver.sda_oe_o; \

`define ASSIGN_PERIPHS_I2C1_PAD2SOC(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.sda_i = driver.sda_o; \

`define ASSIGN_PERIPHS_I2C1_SOC2PAD(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.scl_oe_i = driver.scl_oe_o; \
  assign load.sda_i = driver.sda_o; \
  assign load.sda_oe_i = driver.sda_oe_o; \

`define ASSIGN_PERIPHS_I2C2_PAD2SOC(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.sda_i = driver.sda_o; \

`define ASSIGN_PERIPHS_I2C2_SOC2PAD(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.scl_oe_i = driver.scl_oe_o; \
  assign load.sda_i = driver.sda_o; \
  assign load.sda_oe_i = driver.sda_oe_o; \

`define ASSIGN_PERIPHS_I2C3_PAD2SOC(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.sda_i = driver.sda_o; \

`define ASSIGN_PERIPHS_I2C3_SOC2PAD(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.scl_oe_i = driver.scl_oe_o; \
  assign load.sda_i = driver.sda_o; \
  assign load.sda_oe_i = driver.sda_oe_o; \

`define ASSIGN_PERIPHS_I2C4_PAD2SOC(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.sda_i = driver.sda_o; \

`define ASSIGN_PERIPHS_I2C4_SOC2PAD(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.scl_oe_i = driver.scl_oe_o; \
  assign load.sda_i = driver.sda_o; \
  assign load.sda_oe_i = driver.sda_oe_o; \

`define ASSIGN_PERIPHS_I2C5_PAD2SOC(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.sda_i = driver.sda_o; \

`define ASSIGN_PERIPHS_I2C5_SOC2PAD(load, driver) \
  assign load.scl_i = driver.scl_o; \
  assign load.scl_oe_i = driver.scl_oe_o; \
  assign load.sda_i = driver.sda_o; \
  assign load.sda_oe_i = driver.sda_oe_o; \

`define ASSIGN_PERIPHS_UART0_PAD2SOC(load, driver) \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_UART0_SOC2PAD(load, driver) \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_UART1_PAD2SOC(load, driver) \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_UART1_SOC2PAD(load, driver) \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_UART2_PAD2SOC(load, driver) \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_UART2_SOC2PAD(load, driver) \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_USART0_PAD2SOC(load, driver) \
  assign load.cts_i = driver.cts_o; \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_USART0_SOC2PAD(load, driver) \
  assign load.rts_i = driver.rts_o; \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_USART1_PAD2SOC(load, driver) \
  assign load.cts_i = driver.cts_o; \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_USART1_SOC2PAD(load, driver) \
  assign load.rts_i = driver.rts_o; \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_USART2_PAD2SOC(load, driver) \
  assign load.cts_i = driver.cts_o; \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_USART2_SOC2PAD(load, driver) \
  assign load.rts_i = driver.rts_o; \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_USART3_PAD2SOC(load, driver) \
  assign load.cts_i = driver.cts_o; \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_USART3_SOC2PAD(load, driver) \
  assign load.rts_i = driver.rts_o; \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_ETH_PAD2SOC(load, driver) \
  assign load.eth_md_i = driver.eth_md_o; \
  assign load.eth_rxck_i = driver.eth_rxck_o; \
  assign load.eth_rxctl_i = driver.eth_rxctl_o; \
  assign load.eth_rxd0_i = driver.eth_rxd0_o; \
  assign load.eth_rxd1_i = driver.eth_rxd1_o; \
  assign load.eth_rxd2_i = driver.eth_rxd2_o; \
  assign load.eth_rxd3_i = driver.eth_rxd3_o; \

`define ASSIGN_PERIPHS_ETH_SOC2PAD(load, driver) \
  assign load.eth_md_i = driver.eth_md_o; \
  assign load.eth_md_oe = driver.eth_md_oe; \
  assign load.eth_mdc_i = driver.eth_mdc_o; \
  assign load.eth_rstn_i = driver.eth_rstn_o; \
  assign load.eth_txck_i = driver.eth_txck_o; \
  assign load.eth_txctl_i = driver.eth_txctl_o; \
  assign load.eth_txd0_i = driver.eth_txd0_o; \
  assign load.eth_txd1_i = driver.eth_txd1_o; \
  assign load.eth_txd2_i = driver.eth_txd2_o; \
  assign load.eth_txd3_i = driver.eth_txd3_o; \

`define ASSIGN_PERIPHS_CAN0_PAD2SOC(load, driver) \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_CAN0_SOC2PAD(load, driver) \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_CAN1_PAD2SOC(load, driver) \
  assign load.rx_i = driver.rx_o; \

`define ASSIGN_PERIPHS_CAN1_SOC2PAD(load, driver) \
  assign load.tx_i = driver.tx_o; \

`define ASSIGN_PERIPHS_CAM0_PAD2SOC(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.data0_i = driver.data0_o; \
  assign load.data1_i = driver.data1_o; \
  assign load.data2_i = driver.data2_o; \
  assign load.data3_i = driver.data3_o; \
  assign load.data4_i = driver.data4_o; \
  assign load.data5_i = driver.data5_o; \
  assign load.data6_i = driver.data6_o; \
  assign load.data7_i = driver.data7_o; \
  assign load.hsync_i = driver.hsync_o; \
  assign load.vsync_i = driver.vsync_o; \


`define ASSIGN_PERIPHS_CAM1_PAD2SOC(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.data0_i = driver.data0_o; \
  assign load.data1_i = driver.data1_o; \
  assign load.data2_i = driver.data2_o; \
  assign load.data3_i = driver.data3_o; \
  assign load.data4_i = driver.data4_o; \
  assign load.data5_i = driver.data5_o; \
  assign load.data6_i = driver.data6_o; \
  assign load.data7_i = driver.data7_o; \
  assign load.hsync_i = driver.hsync_o; \
  assign load.vsync_i = driver.vsync_o; \



`define ASSIGN_PERIPHS_FLL_SOC_SOC2PAD(load, driver) \
  assign load.clk_soc_i = driver.clk_soc_o; \


`define ASSIGN_PERIPHS_FLL_CVA6_SOC2PAD(load, driver) \
  assign load.clk_cva6_i = driver.clk_cva6_o; \

`define ASSIGN_PERIPHS_SPI0_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI0_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI1_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI1_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI2_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI2_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI3_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI3_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI4_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI4_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI5_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI5_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI6_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI6_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI7_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI7_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.csn1_i = driver.csn1_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI8_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI8_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI9_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI9_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_SPI10_PAD2SOC(load, driver) \
  assign load.sd1_i = driver.sd1_o; \

`define ASSIGN_PERIPHS_SPI10_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \

`define ASSIGN_PERIPHS_QSPI_LINUX_PAD2SOC(load, driver) \
  assign load.sd0_i = driver.sd0_o; \
  assign load.sd1_i = driver.sd1_o; \
  assign load.sd2_i = driver.sd2_o; \
  assign load.sd3_i = driver.sd3_o; \

`define ASSIGN_PERIPHS_QSPI_LINUX_SOC2PAD(load, driver) \
  assign load.clk_i = driver.clk_o; \
  assign load.csn0_i = driver.csn0_o; \
  assign load.sd0_i = driver.sd0_o; \
  assign load.sd0_oen_i = driver.sd0_oen_o; \
  assign load.sd1_i = driver.sd1_o; \
  assign load.sd1_oen_i = driver.sd1_oen_o; \
  assign load.sd2_i = driver.sd2_o; \
  assign load.sd2_oen_i = driver.sd2_oen_o; \
  assign load.sd3_i = driver.sd3_o; \
  assign load.sd3_oen_i = driver.sd3_oen_o; \

`define ASSIGN_PERIPHS_GPIO_B_PAD2SOC(load, driver) \
  assign load.gpio0_i = driver.gpio0_o; \
  assign load.gpio1_i = driver.gpio1_o; \
  assign load.gpio2_i = driver.gpio2_o; \
  assign load.gpio3_i = driver.gpio3_o; \
  assign load.gpio4_i = driver.gpio4_o; \
  assign load.gpio5_i = driver.gpio5_o; \
  assign load.gpio6_i = driver.gpio6_o; \
  assign load.gpio7_i = driver.gpio7_o; \
  assign load.gpio8_i = driver.gpio8_o; \
  assign load.gpio9_i = driver.gpio9_o; \
  assign load.gpio10_i = driver.gpio10_o; \
  assign load.gpio11_i = driver.gpio11_o; \
  assign load.gpio12_i = driver.gpio12_o; \
  assign load.gpio13_i = driver.gpio13_o; \
  assign load.gpio14_i = driver.gpio14_o; \
  assign load.gpio15_i = driver.gpio15_o; \
  assign load.gpio16_i = driver.gpio16_o; \
  assign load.gpio17_i = driver.gpio17_o; \
  assign load.gpio18_i = driver.gpio18_o; \
  assign load.gpio19_i = driver.gpio19_o; \
  assign load.gpio20_i = driver.gpio20_o; \
  assign load.gpio21_i = driver.gpio21_o; \
  assign load.gpio22_i = driver.gpio22_o; \
  assign load.gpio23_i = driver.gpio23_o; \
  assign load.gpio24_i = driver.gpio24_o; \
  assign load.gpio25_i = driver.gpio25_o; \
  assign load.gpio26_i = driver.gpio26_o; \
  assign load.gpio27_i = driver.gpio27_o; \
  assign load.gpio28_i = driver.gpio28_o; \
  assign load.gpio29_i = driver.gpio29_o; \
  assign load.gpio30_i = driver.gpio30_o; \
  assign load.gpio31_i = driver.gpio31_o; \
  assign load.gpio32_i = driver.gpio32_o; \
  assign load.gpio33_i = driver.gpio33_o; \
  assign load.gpio34_i = driver.gpio34_o; \
  assign load.gpio35_i = driver.gpio35_o; \
  assign load.gpio36_i = driver.gpio36_o; \
  assign load.gpio37_i = driver.gpio37_o; \
  assign load.gpio38_i = driver.gpio38_o; \
  assign load.gpio39_i = driver.gpio39_o; \
  assign load.gpio40_i = driver.gpio40_o; \
  assign load.gpio41_i = driver.gpio41_o; \
  assign load.gpio42_i = driver.gpio42_o; \
  assign load.gpio43_i = driver.gpio43_o; \
  assign load.gpio44_i = driver.gpio44_o; \
  assign load.gpio45_i = driver.gpio45_o; \
  assign load.gpio46_i = driver.gpio46_o; \
  assign load.gpio47_i = driver.gpio47_o; \

`define ASSIGN_PERIPHS_GPIO_B_SOC2PAD(load, driver) \
  assign load.gpio0_d_i = driver.gpio0_d_o; \
  assign load.gpio0_i = driver.gpio0_o; \
  assign load.gpio1_d_i = driver.gpio1_d_o; \
  assign load.gpio1_i = driver.gpio1_o; \
  assign load.gpio2_d_i = driver.gpio2_d_o; \
  assign load.gpio2_i = driver.gpio2_o; \
  assign load.gpio3_d_i = driver.gpio3_d_o; \
  assign load.gpio3_i = driver.gpio3_o; \
  assign load.gpio4_d_i = driver.gpio4_d_o; \
  assign load.gpio4_i = driver.gpio4_o; \
  assign load.gpio5_d_i = driver.gpio5_d_o; \
  assign load.gpio5_i = driver.gpio5_o; \
  assign load.gpio6_d_i = driver.gpio6_d_o; \
  assign load.gpio6_i = driver.gpio6_o; \
  assign load.gpio7_d_i = driver.gpio7_d_o; \
  assign load.gpio7_i = driver.gpio7_o; \
  assign load.gpio8_d_i = driver.gpio8_d_o; \
  assign load.gpio8_i = driver.gpio8_o; \
  assign load.gpio9_d_i = driver.gpio9_d_o; \
  assign load.gpio9_i = driver.gpio9_o; \
  assign load.gpio10_d_i = driver.gpio10_d_o; \
  assign load.gpio10_i = driver.gpio10_o; \
  assign load.gpio11_d_i = driver.gpio11_d_o; \
  assign load.gpio11_i = driver.gpio11_o; \
  assign load.gpio12_d_i = driver.gpio12_d_o; \
  assign load.gpio12_i = driver.gpio12_o; \
  assign load.gpio13_d_i = driver.gpio13_d_o; \
  assign load.gpio13_i = driver.gpio13_o; \
  assign load.gpio14_d_i = driver.gpio14_d_o; \
  assign load.gpio14_i = driver.gpio14_o; \
  assign load.gpio15_d_i = driver.gpio15_d_o; \
  assign load.gpio15_i = driver.gpio15_o; \
  assign load.gpio16_d_i = driver.gpio16_d_o; \
  assign load.gpio16_i = driver.gpio16_o; \
  assign load.gpio17_d_i = driver.gpio17_d_o; \
  assign load.gpio17_i = driver.gpio17_o; \
  assign load.gpio18_d_i = driver.gpio18_d_o; \
  assign load.gpio18_i = driver.gpio18_o; \
  assign load.gpio19_d_i = driver.gpio19_d_o; \
  assign load.gpio19_i = driver.gpio19_o; \
  assign load.gpio20_d_i = driver.gpio20_d_o; \
  assign load.gpio20_i = driver.gpio20_o; \
  assign load.gpio21_d_i = driver.gpio21_d_o; \
  assign load.gpio21_i = driver.gpio21_o; \
  assign load.gpio22_d_i = driver.gpio22_d_o; \
  assign load.gpio22_i = driver.gpio22_o; \
  assign load.gpio23_d_i = driver.gpio23_d_o; \
  assign load.gpio23_i = driver.gpio23_o; \
  assign load.gpio24_d_i = driver.gpio24_d_o; \
  assign load.gpio24_i = driver.gpio24_o; \
  assign load.gpio25_d_i = driver.gpio25_d_o; \
  assign load.gpio25_i = driver.gpio25_o; \
  assign load.gpio26_d_i = driver.gpio26_d_o; \
  assign load.gpio26_i = driver.gpio26_o; \
  assign load.gpio27_d_i = driver.gpio27_d_o; \
  assign load.gpio27_i = driver.gpio27_o; \
  assign load.gpio28_d_i = driver.gpio28_d_o; \
  assign load.gpio28_i = driver.gpio28_o; \
  assign load.gpio29_d_i = driver.gpio29_d_o; \
  assign load.gpio29_i = driver.gpio29_o; \
  assign load.gpio30_d_i = driver.gpio30_d_o; \
  assign load.gpio30_i = driver.gpio30_o; \
  assign load.gpio31_d_i = driver.gpio31_d_o; \
  assign load.gpio31_i = driver.gpio31_o; \
  assign load.gpio32_d_i = driver.gpio32_d_o; \
  assign load.gpio32_i = driver.gpio32_o; \
  assign load.gpio33_d_i = driver.gpio33_d_o; \
  assign load.gpio33_i = driver.gpio33_o; \
  assign load.gpio34_d_i = driver.gpio34_d_o; \
  assign load.gpio34_i = driver.gpio34_o; \
  assign load.gpio35_d_i = driver.gpio35_d_o; \
  assign load.gpio35_i = driver.gpio35_o; \
  assign load.gpio36_d_i = driver.gpio36_d_o; \
  assign load.gpio36_i = driver.gpio36_o; \
  assign load.gpio37_d_i = driver.gpio37_d_o; \
  assign load.gpio37_i = driver.gpio37_o; \
  assign load.gpio38_d_i = driver.gpio38_d_o; \
  assign load.gpio38_i = driver.gpio38_o; \
  assign load.gpio39_d_i = driver.gpio39_d_o; \
  assign load.gpio39_i = driver.gpio39_o; \
  assign load.gpio40_d_i = driver.gpio40_d_o; \
  assign load.gpio40_i = driver.gpio40_o; \
  assign load.gpio41_d_i = driver.gpio41_d_o; \
  assign load.gpio41_i = driver.gpio41_o; \
  assign load.gpio42_d_i = driver.gpio42_d_o; \
  assign load.gpio42_i = driver.gpio42_o; \
  assign load.gpio43_d_i = driver.gpio43_d_o; \
  assign load.gpio43_i = driver.gpio43_o; \
  assign load.gpio44_d_i = driver.gpio44_d_o; \
  assign load.gpio44_i = driver.gpio44_o; \
  assign load.gpio45_d_i = driver.gpio45_d_o; \
  assign load.gpio45_i = driver.gpio45_o; \
  assign load.gpio46_d_i = driver.gpio46_d_o; \
  assign load.gpio46_i = driver.gpio46_o; \
  assign load.gpio47_d_i = driver.gpio47_d_o; \
  assign load.gpio47_i = driver.gpio47_o; \



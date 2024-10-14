/*
 * Copyright (C) 2024 ETH Zurich and University of Bologna
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

/* 
 * Maintainer: Chaoqun Liang (chaoqun.liang@unibo.it)
 */

#include <stdio.h>
#include <stdint.h>
#include "utils.h"

#define N_REPS           2
#define ETH_BASE         0x30000000
#define MDIO_OFFSET      0x8

int main() {
    #ifdef ETH2FMC
        /* Do nothing */
    #elif SIMPLE_PAD
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_00_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_01_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_02_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_03_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_04_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_05_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_06_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_07_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_08_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_09_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_10_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_11_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_12_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_13_mux_set( 1 );
        alsaqr_periph_fpga_padframe_periphs_pad_gpio_b_14_mux_set( 1 );
    #else
        alsaqr_periph_padframe_periphs_b_23_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_24_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_25_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_26_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_27_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_28_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_29_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_30_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_31_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_32_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_33_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_34_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_35_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_36_mux_set( 0 );
        alsaqr_periph_padframe_periphs_b_37_mux_set( 0 );
        alsaqr_periph_padframe_periphs_a_15_mux_set( 1 );
        alsaqr_periph_padframe_periphs_a_16_mux_set( 1 );
        alsaqr_periph_padframe_periphs_a_17_mux_set( 1 );
        alsaqr_periph_padframe_periphs_a_18_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_19_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_20_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_21_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_22_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_23_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_24_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_25_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_26_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_27_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_28_mux_set( 2 );
        alsaqr_periph_padframe_periphs_a_29_mux_set( 1 );
    #endif

    // Pointer to the MDIO register address
    volatile uint32_t *mdio_reg = (volatile uint32_t*)(ETH_BASE+MDIO_OFFSET);

    // Test patterns for clk, o, and oe fields
    uint32_t test_patterns[] = {0x0, 0x1, 0x2, 0x3, 0x4, 0x7};

    for (int i = 0; i < sizeof(test_patterns) / sizeof(test_patterns[0]); i++) {
        // Write to mdio_clk, mdio_o, and mdio_oe (lower 3 bits)
        *mdio_reg = (test_patterns[i] & 0x7);  // Mask to ensure only bits 0-2 are written

        // Read back the entire register
        uint32_t readback = *mdio_reg;

        // Extract each field to validate
        uint32_t read_clk = readback & 0x1;            // Bit 0 (mdio_clk)
        uint32_t read_o = (readback >> 1) & 0x1;       // Bit 1 (mdio_o)
        uint32_t read_oe = (readback >> 2) & 0x1;      // Bit 2 (mdio_oe)
        uint32_t read_i = (readback >> 3) & 0x1;       // Bit 3 (mdio_i) - external input

        // Verify written values against readback
        if (read_clk != (test_patterns[i] & 0x1) ||
            read_o != ((test_patterns[i] >> 1) & 0x1) ||
            read_oe != ((test_patterns[i] >> 2) & 0x1)) {
            printf("Test failed for pattern 0x%X\n", test_patterns[i]);
        } else {
            printf("Test passed for pattern 0x%X\n", test_patterns[i]);
        }

        // Log the value of mdio_i as a status check
        printf("mdio_i (external input) = %d\n", read_i);
    }

    return 0;
}

#!/bin/bash

# =============================================================================
# Script: setup.sh
# Description: Configures environment variables for the ALSAQR project based
#              on user input or existing environment settings and executes
#              the appropriate make command within the HW_HOME directory.
# =============================================================================

# Exit immediately if a command exits with a non-zero status
# set -e

# =============================================================================
# Constants
# =============================================================================
PROJECT_DIR_NAME="alsaqr"
VIVADO_VERSION="vitis-2020.2"
DEFAULT_VSIM_PATH="$PWD/sim"

# =============================================================================
# Variables to Unset Before Configuration
# =============================================================================
# List of environment variables set by this script
variables_to_unset=(
    PROJECT_HOME
    BOARD
    XILINX_PART
    XILINX_BOARD
    AXI_ID_DDR_WIDTH
    MAIN_MEM
    SIMPLE_PAD
    ETH2FMC_NO_PAD
    USE_OT
    NUM_CORES
    EXCLUDE_ROT
    EXCLUDE_CLUSTER
    VSIM_PATH
)

# =============================================================================
# Helper Functions
# =============================================================================

# Function to unset previously set environment variables
unset_variables() {
    echo "Unsetting previously set environment variables..."
    for var in "${variables_to_unset[@]}"; do
        unset "$var"
    done
    echo "All relevant environment variables have been unset."
}

# Function to prompt the user and read input
prompt_user() {
    local prompt_message="$1"
    local user_input
    read -p "$prompt_message" user_input
    echo "$user_input"
}

# Function to configure the FPGA board settings
configure_board() {
    if [ -z "$BOARD" ]; then
        echo "Select the FPGA board:"
        echo "1) ZCU102"
        echo "2) VCU118"
        BOARD_SELECTION=$(prompt_user "Enter your choice (1 or 2): ")

        case "$BOARD_SELECTION" in
            1)
                export BOARD="zcu102"
                export XILINX_PART="xczu9eg-ffvb1156-2-e"
                export XILINX_BOARD="xilinx.com:zcu102:part0:3.2"
                ;;
            2)
                export BOARD="vcu118"
                export XILINX_PART="xcvu9p-flga2104-2L-e"
                export XILINX_BOARD="xilinx.com:vcu118:part0:2.0"
                ;;
            *)
                echo "Invalid selection for BOARD. Please run the script again and choose 1 or 2."
                exit 1
                ;;
        esac
    fi
}

# Function to configure LLC instantiation
configure_llc() {
    LLC_OPTION=$(prompt_user "Are you instantiating the LLC? (y/n): ")

    case "$LLC_OPTION" in
        y|Y)
            export AXI_ID_DDR_WIDTH="10"
            ;;
        n|N)
            export AXI_ID_DDR_WIDTH="9"
            ;;
        *)
            echo "Invalid input for LLC. Please enter 'y' or 'n'."
            configure_llc
            ;;
    esac
}

# Function to configure main memory settings
configure_main_memory() {
    echo "Select the main memory type:"
    echo "1) DDR4"
    echo "2) HYPER"

    MAIN_MEM_SELECTION=$(prompt_user "Enter your choice (1 or 2): ")

    case "$MAIN_MEM_SELECTION" in
        1)
            export MAIN_MEM="DDR4"
            export SIMPLE_PAD="SPI-I2C-UART-SDIO"
            configure_opentitan
            ;;
        2)
            export MAIN_MEM="HYPER"
            export SIMPLE_PAD="0"
            export ETH2FMC_NO_PAD="0"
            export USE_OT="0"
            ;;
        *)
            echo "Invalid selection for main memory. Please choose 1 or 2."
            configure_main_memory
            ;;
    esac
}

# Function to configure OpenTitan settings
configure_opentitan() {
    OT_OPTION=$(prompt_user "Are you instantiating OpenTitan? (y/n): ")

    case "$OT_OPTION" in
        y|Y)
            export USE_OT="1"
            export ETH2FMC_NO_PAD="0"
            ;;
        n|N)
            export USE_OT="0"
            export ETH2FMC_NO_PAD="1"
            ;;
        *)
            echo "Invalid input for OpenTitan. Please enter 'y' or 'n'."
            configure_opentitan
            ;;
    esac
}

# Function to configure the number of CVA6 cores
configure_num_cores() {
    echo "Select the number of CVA6 cores:"
    echo "1) 2 cores"
    echo "2) 4 cores"

    CORES_SELECTION=$(prompt_user "Enter your choice (1 or 2): ")

    case "$CORES_SELECTION" in
        1)
            export NUM_CORES="2"
            ;;
        2)
            export NUM_CORES="4"
            echo "Warning: Using 4 cores limits frequency to 20MHz and disables Ethernet testing."
            ;;
        *)
            echo "Invalid selection for number of cores. Please choose 1 or 2."
            configure_num_cores
            ;;
    esac
}

# Function to configure cluster exclusion
configure_cluster() {
    CLUSTER_OPTION=$(prompt_user "Do you want to exclude the cluster? (y/n): ")

    case "$CLUSTER_OPTION" in
        y|Y)
            export EXCLUDE_CLUSTER="1"
            ;;
        n|N)
            export EXCLUDE_CLUSTER="0"
            ;;
        *)
            echo "Invalid input for cluster exclusion. Please enter 'y' or 'n'."
            configure_cluster
            ;;
    esac
}

# Function to compute EXCLUDE_ROT as the negation of USE_OT
compute_exclude_rot() {
    if [ "$USE_OT" -eq "1" ]; then
        export EXCLUDE_ROT="0"
    else
        export EXCLUDE_ROT="1"
    fi
}

# Function to execute the appropriate make command in HW_HOME
execute_make_command() {
    # Check if HW_HOME is set
    if [ -z "$HW_HOME" ]; then
        echo "Error: HW_HOME environment variable is not set."
        echo "Please set HW_HOME to the hardware directory before running the script."
        exit 1
    fi

    # Check if HW_HOME is a valid directory
    if [ ! -d "$HW_HOME" ]; then
        echo "Error: HW_HOME directory '$HW_HOME' does not exist."
        exit 1
    fi

    echo "Executing make command in HW_HOME directory: $HW_HOME"

    if [ "$MAIN_MEM" = "HYPER" ]; then
        echo "Executing make command for HYPER memory..."
        make -C "$HW_HOME" scripts-bender-fpga \
            exclude-rot="$EXCLUDE_ROT" \
            exclude-cluster="$EXCLUDE_CLUSTER" \
            exclude-llc="$AXI_ID_DDR_WIDTH"
    elif [ "$MAIN_MEM" = "DDR4" ]; then
        echo "Executing make command for DDR4 memory..."
        make -C "$HW_HOME" scripts-bender-fpga-ddr \
            exclude-rot="$EXCLUDE_ROT" \
            exclude-cluster="$EXCLUDE_CLUSTER" \
            exclude-llc="$AXI_ID_DDR_WIDTH" \
            simple-padframe="$SIMPLE_PAD" \
            test-eth="$ETH2FMC_NO_PAD"
    else
        echo "Unknown MAIN_MEM type: $MAIN_MEM. Cannot execute make command."
        exit 1
    fi
}

# Function to display the configured settings
display_settings() {
    echo "==================== Configuration Summary ===================="
    echo "PROJECT_HOME           = $PROJECT_HOME"
    echo "VIVADO_VERSION         = $VIVADO_VERSION"
    echo "BOARD                  = $BOARD"
    echo "XILINX_PART            = $XILINX_PART"
    echo "XILINX_BOARD           = $XILINX_BOARD"
    echo "AXI_ID_DDR_WIDTH       = $AXI_ID_DDR_WIDTH"
    echo "MAIN_MEMORY            = $MAIN_MEM"
    echo "NUM_CORES              = $NUM_CORES"
    echo "PERIPHERALS_VALID      = $SIMPLE_PAD"
    echo "ETHERNET_NO_PADFRAME   = $ETH2FMC_NO_PAD"
    echo "USE_OT                 = $USE_OT"
    echo "EXCLUDE_ROT            = $EXCLUDE_ROT"
    echo "EXCLUDE_CLUSTER        = $EXCLUDE_CLUSTER"
    echo "VSIM_PATH              = $VSIM_PATH"
    echo "HW_HOME                = $HW_HOME"
    echo "==============================================================="
}

# =============================================================================
# Main Script Execution
# =============================================================================

# =============================================================================
# Early Check for HW_HOME
# =============================================================================

# Function to check if HW_HOME is defined before proceeding
check_hw_home() {
    if [ -z "$HW_HOME" ]; then
        echo "Error: HW_HOME environment variable is not set."
        echo "Please set HW_HOME to the hardware directory before running the script."
        exit 1
    fi

    if [ ! -d "$HW_HOME" ]; then
        echo "Error: HW_HOME directory '$HW_HOME' does not exist."
        exit 1
    fi

    echo "HW_HOME is set to: $HW_HOME"
}

# Call the check_hw_home function early in the script
check_hw_home

# Unset previously set environment variables
unset_variables

# Set PROJECT_HOME and VIVADO_VERSION
export PROJECT_HOME="$(pwd)/$PROJECT_DIR_NAME"
export VIVADO_VERSION="$VIVADO_VERSION"

# Configure FPGA Board
configure_board

# Configure LLC
configure_llc

# Configure Main Memory
configure_main_memory

# Configure Number of Cores
configure_num_cores

# Configure Cluster Exclusion
configure_cluster

# Compute EXCLUDE_ROT based on USE_OT
compute_exclude_rot

# Set VSIM_PATH
export VSIM_PATH="${VSIM_PATH:-$DEFAULT_VSIM_PATH}"

# Display the final settings
display_settings

# Execute the appropriate make command in HW_HOME
execute_make_command

# =============================================================================
# End of Script
# =============================================================================

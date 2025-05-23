#!/bin/bash

export PROJECT_HOME=$(pwd)/alsaqr

export VIVADO_VERSION=vitis-2020.2
#VIVADO SETTINGS
#Settings are board specific. Check FPGA board datasheet to add new target
# either "vcu118" or "zcu102"

if [ -z "$BOARD" ]; then
    read -p "Which board you want to use:  1-zcu102 2-vcu118: " BOARD

    if [ "$BOARD" = "1" ]; then
        export BOARD="zcu102"
        export XILINX_PART="xczu9eg-ffvb1156-2-e"
        export XILINX_BOARD="xilinx.com:zcu102:part0:3.2"
    elif [ "$BOARD" = "2" ]; then
        export BOARD="vcu118"
        export XILINX_PART="xcvu9p-flga2104-2L-e"
        export XILINX_BOARD="xilinx.com:vcu118:part0:2.0"
    fi
fi

read -p "Are you instantiating the LLC? y/n " LLC
if [ "$LLC" = "y" ]; then
    export AXI_ID_DDR_WIDTH="9"
elif [ "$LLC" = "n" ]; then
    export AXI_ID_DDR_WIDTH="8"
fi

read -p "Which main memory are you using:  1-DDR 2-HYPER: " MAIN_MEM
if [ "$MAIN_MEM" = "1" ]; then
    export MAIN_MEM="DDR4"
    export SIMPLE_PAD="SPI-I2C-UART-SDIO"
    read -p "Are you instantiating OpenTitan? y/n " OT
    if [ "$OT" = "y" ]; then
        export USE_OT="1"
        export ETH2FMC_NO_PAD="0"
    elif [ "$OT" = "n" ]; then
        export USE_OT="0"
        read -p "Are you instantiating Ethernet? y/n " ETH
        if [ "$ETH" = "y" ]; then
            export ETH2FMC_NO_PAD="1"
        elif [ "$ETH" = "n" ]; then
            export ETH2FMC_NO_PAD="0"
        fi
    fi
elif [ "$MAIN_MEM" = "2" ]; then
    export MAIN_MEM="HYPER"
    export SIMPLE_PAD="0"
    export ETH2FMC_NO_PAD="0"
    export USE_OT="0"
fi

read -p "How many CVA6 cores? 2/4 " NUM_CORES
if [ "$NUM_CORES" = "2" ]; then
    export NUM_CORES="2"
elif [ "$NUM_CORES" = "4" ]; then
    export NUM_CORES="4"
    echo "This limits frequency to 20MHz, cannot test ethernet"
fi

echo "$BOARD"
echo "XILINX_PART=$XILINX_PART"
echo "XILINX_BOARD=$XILINX_BOARD"
echo "AXI_ID_DDR_WIDTH=$AXI_ID_DDR_WIDTH"
echo "MAIN MEMORY = $MAIN_MEM"
echo "NUM CORES = $NUM_CORES"
echo "PERIPHERALS VALIDATION = $SIMPLE_PAD"
echo "USE OT = $USE_OT"
echo "USE ETH = $ETH2FMC_NO_PAD"

export VSIM_PATH=$PWD/sim

#!/bin/bash

export PROJECT_HOME=$(pwd)/alsaqr

export VIVADO_VERSION=vitis-2020.2
#VIVADO SETTINGS
#Settings are board specific. Check FPGA board datasheet to add new target
# either "vcu118" or "zcu102"

if [ -z "$BOARD"  ]; then
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
    export AXI_ID_DDR_WIDTH="8"
elif [ "$LLC" = "n" ]; then
    export AXI_ID_DDR_WIDTH="7"
fi

if [ -z "$MAIN_MEM"  ]; then
    read -p "Which main memory are you using:  1-DDR 2-HYPER: " MAIN_MEM

    if [ "$MAIN_MEM" = "1" ]; then
        export MAIN_MEM="DDR4"
        read -p "Are you validating the peripherals? y/n " SIMPLE_PAD
        if [ "$SIMPLE_PAD" = "y" ]; then
            export SIMPLE_PAD="1"
        elif [ "$SIMPLE_PAD" = "n" ]; then
            export SIMPLE_PAD="0"
        fi
    elif [ "$MAIN_MEM" = "2" ]; then
        export MAIN_MEM="HYPER"
        export SIMPLE_PAD="0"
    fi
fi

echo "$BOARD"
echo "XILINX_PART=$XILINX_PART"
echo "XILINX_BOARD=$XILINX_BOARD"
echo "AXI_ID_DDR_WIDTH=$AXI_ID_DDR_WIDTH"
echo "MAIN MEMORY = $MAIN_MEM"
echo "PERIPHERALS VALIDATION = $SIMPLE_PAD"

export VSIM_PATH=$PWD/sim

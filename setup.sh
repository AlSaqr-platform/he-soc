#!/bin/bash
echo "exporting RISCV"

export RISCV=/opt/riscv/

export PATH=:$RISCV/bin:$PATH

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware
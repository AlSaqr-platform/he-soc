#!/bin/bash

## Update the paths to you QUESTA and RISCV-TOOLCHAIN homes

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

# Change this path
export QUESTASIM_HOME=/usr/pack/questa-2022.3-bt/questasim/

echo "exporting RISCV"

# Change this paths
export PATH=/usr/pack/riscv-1.0-kgf/riscv64-gcc-11.2.0/bin:$PATH

export RISCV=/usr/pack/riscv-1.0-kgf/riscv64-gcc-11.2.0

echo "cloning submodules"

ulimit -n 2048

git submodule update --init --recursive

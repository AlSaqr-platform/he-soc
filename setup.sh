#!/bin/bash
echo "exporting RISCV"

export PATH=/opt/riscv64/bin:$PATH

export RISCV=/opt/riscv64

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/tools/questasim/

echo "exporting RISCV 32 bit with zfinx"

export PATH=/opt/riscv/bin:$PATH

echo "cloning submodules"

git submodule update --init --recursive

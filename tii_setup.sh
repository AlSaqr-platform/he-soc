#!/bin/bash
echo "exporting RISCV"

#RISC-V Toolchain
export PATH=/home/hyunmin/WORK_ALSAQR/opt/riscv/riscv32-unknown-elf:$PATH

export PATH=/opt/riscv/bin:$PATH

export RISCV=/opt/riscv

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

#Questasim installation location
export QUESTASIM_HOME=/home/fayad/questa/questasim/

echo "exporting RISCV 32 bit with zfinx"

export PATH=/home/hyunmin/WORK_ALSAQR/opt/riscv/bin:$PATH

echo "cloning submodules"

ulimit -n 2048

git submodule update --init --recursive
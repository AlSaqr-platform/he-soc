#!/bin/bash
echo "exporting RISCV"

export RISCV=/usr/scratch/lagrev5/lvalente/riscv_install

echo "exporting CLANG"

export PATH=/usr/scratch/lagrev1/ytortorella/hero-linux-toolchain/install/bin:$PATH

export ROOT_DIR=$(pwd)

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

export TOOLCHAIN=LLVM

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/usr/pack/modelsim-10.7b-kgf/questasim/

echo "cloning submodules"

git submodule update --init --recursive

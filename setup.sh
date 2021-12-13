#!/bin/bash
echo "exporting RISCV"

export PATH=/usr/scratch/lagrev5/lvalente/riscv_install/bin:$PATH

export RISCV=/usr/scratch/lagrev5/lvalente/riscv_install

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/usr/pack/modelsim-10.7b-kgf/questasim/

echo "cloning submodules"

git submodule update --init --recursive


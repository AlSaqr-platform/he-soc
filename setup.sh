#!/bin/bash
echo "exporting RISCV"

export PATH=/usr/scratch/lagrev5/lvalente/riscv_install/bin:$PATH

export RISCV=/usr/scratch/lagrev5/lvalente/riscv_install

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/usr/pack/modelsim-10.7b-kgf/questasim/

echo "exporting RISCV 32 bit"

export PATH=/usr/pack/pulpsdk-1.0-kgf/artifactory/pulp-sdk-release/pkg/pulp_riscv_gcc/1.0.16/bin:$PATH

echo "exporting RISCV 32 bit with zfinx"

export PATH=/usr/pack/riscv-1.0-kgf/pulp-gcc-2.5.0-rc1/bin:$PATH

ulimit -n 2048

echo "cloning submodules"

git submodule update --init --recursive


ln -s -f /home/sinigaglias/gf22_symlink/fll_behav      	hardware/deps

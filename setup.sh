#!/bin/bash
echo "exporting RISCV"

export PATH=/usr/scratch/lagrev5/lvalente/riscv_install/bin:$PATH

export RISCV=/usr/scratch/lagrev5/lvalente/riscv_install

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/usr/pack/modelsim-10.7b-kgf/questasim/

echo "exporting RISCV 32 bit with zfinx"

export PATH=/usr/pack/pulpsdk-1.0-kgf/artifactory/pulp-sdk-release/pkg/pulp_riscv_gcc/1.0.16/bin:$PATH

echo "cloning submodules"

git submodule update --init --recursive

git clone git@github.com:AlSaqr-platform/cluster-runtime.git

#!/bin/bash
echo "exporting RISCV"

#algrin export PATH=/usr/scratch/lagrev5/lvalente/riscv_install/bin:$PATH
export PATH=/opt/riscv/bin/:$PATH

#algrin export RISCV=/usr/scratch/lagrev5/lvalente/riscv_install
export RISCV=/opt/riscv

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

#algrin export QUESTASIM_HOME=/usr/pack/modelsim-10.7b-kgf/questasim/
export QUESTASIM_HOME=/tools/Siemens/questasim/

echo "exporting RISCV 32 bit with zfinx"

export PATH=/usr/pack/pulpsdk-1.0-kgf/artifactory/pulp-sdk-release/pkg/pulp_riscv_gcc/1.0.16/bin:$PATH

echo "cloning submodules"
ulimit -n 2048
git submodule update --init --recursive

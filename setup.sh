#!/bin/bash
echo "exporting RISCV"

export PATH=/usr/scratch/lagrev5/lvalente/riscv_install/bin:$PATH

export RISCV=/usr/scratch/lagrev5/lvalente/riscv_install

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/usr/pack/modelsim-10.7b-kgf/questasim/

echo "exporting RISCV 32 bit with zfinx"

export PATH=/usr/pack/pulpsdk-1.0-kgf/artifactory/pulp-sdk-release/pkg/pulp_riscv_gcc/1.0.16/bin:/scratch/eparisi/he-soc:$PATH

echo "cloning submodules"

git submodule update --init --recursive

git clone git@github.com:AlSaqr-platform/cluster_runtime -b fc0a2be7910e3a9df6ac1594c575f174a336070d

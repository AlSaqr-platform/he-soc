#!/bin/bash
echo "exporting RISCV"

export PATH=/opt/riscv/bin/:$PATH
export QUESTA=questa-2022.3-bt

export RISCV=/opt/riscv

export SW_HOME=$(pwd)/software

export HW_HOME=$(pwd)/hardware

echo "exporting QUESTASIM PATH"

export QUESTASIM_HOME=/usr/pack/questa-2022.3-bt/questasim/

echo "exporting RISCV 32 bit with zfinx"

export PATH=/usr/pack/pulpsdk-1.0-kgf/artifactory/pulp-sdk-release/pkg/pulp_riscv_gcc/1.0.16/bin:$PATH

echo "cloning submodules"
ulimit -n 2048
git submodule update --init --recursive

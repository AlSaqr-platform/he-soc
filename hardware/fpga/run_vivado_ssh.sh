#!/bin/bash

source he-soc/setup.sh

TEST_REMOTE_PATH=/home/pulpone/maicol/tests
TEST_LOCAL_PATH=/scratch/mciani/test/he-soc/software
TEST_LOCAL_PATH_IBEX=/scratch/mciani/he-soc/hardware/working_dir/opentitan/hw/top_earlgrey/sw/tests/

BITSTREAM_LOCAL_NAME=/scratch/mciani/he-soc/hardware/fpga/reports/alsaqr_xilinx.bit
BITSTREAM_REMOTE_NAME=/home/pulpone/maicol/bitstream

TEST_PATH_IBEX=hello_test/hello_test.elf
TEST_PATH=hello/hello.riscv
TEST=$TEST_PATH
TEST_IBEX=$TEST_PATH_IBEX

TEST_LOCAL_NAME=$TEST_LOCAL_PATH/$TEST
TEST_REMOTE_NAME=$TEST_REMOTE_PATH/$TEST


TEST_LOCAL_NAME_IBEX=$TEST_LOCAL_PATH_IBEX/$TEST_IBEX
TEST_REMOTE_NAME_IBEX=$TEST_REMOTE_PATH_IBEX/$TEST_IBEX

echo "Tranfser $TEST to remote host..."
#scp_ariane
#scp_ibex

scp $TEST_LOCAL_NAME pulpone@137.204.213.243:$TEST_REMOTE_NAME
scp $TEST_LOCAL_NAME_IBEX pulpone@137.204.213.243:$TEST_REMOTE_NAME_IBEX
scp $BITSTREAM_LOCAL_NAME pulpone@137.204.213.243:$BITSTREAM_REMOTE_NAME

echo "Upload the bitstream..."


ssh  -X pulpone@137.204.213.243 '/home/pulpone/maicol/scripts/load_ssh_bit.sh'

#mate-terminal -- ssh -X -t pulpone@137.204.213.243 "sudo /home/pulpone/riscv-openocd/src/openocd -f /home/pulpone/riscv-openocd/zcu-102-ariane.cfg"

#mate-terminal -- ssh -X pulpone@137.204.213.243 "export PATH=/opt/riscv/bin:$PATH && riscv64-unknown-linux-gnu-gdb $TEST_REMOTE_NAME"

#mate-terminal -- ssh -X -t pulpone@137.204.213.243 "sudo killall -9 screen && sudo screen /dev/ttyUSB1 115200"

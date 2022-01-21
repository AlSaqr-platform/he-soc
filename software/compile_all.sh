#!/bin/bash
# Read a string with spaces using for loop
BASEDIR=$(pwd)
test_list=`xargs printf '%s ' < regression.list | cut -b 1-`

cd pulp
source setup.sh
make clean all
cd ../axi_tlb/stimuli
make clean all
cd ../../../
source setup.sh
cd software

for value in $test_list
do
    cd $value
    make clean all
    cd $BASEDIR
done

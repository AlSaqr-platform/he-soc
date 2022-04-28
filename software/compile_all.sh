#!/bin/bash
# Read a string with spaces using for loop
BASEDIR=$(pwd)
test_list=`xargs printf '%s ' < regression.list | cut -b 1-`

cd $BASEDIR/../
source ./setup.sh

# cd $BASEDIR/hello_pulp/stimuli
# make clean all
# cd $BASEDIR/fpu_pulp/stimuli
# make clean all
# cd $BASEDIR/axi_tlb/stimuli
# make clean all
# cd $BASEDIR/dma/c2h_transfer/stimuli
# make clean all
# cd $BASEDIR/dma/h2c_transfer/stimuli
# make clean all
# 
cd $BASEDIR

for value in $test_list
do
    cd $value
    make clean all
    cd $BASEDIR
done

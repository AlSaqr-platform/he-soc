#!/bin/bash
# Read a string with spaces using for loop
BASEDIR=$(pwd)
test_list=`xargs printf '%s ' < regression.list | cut -b 1-`

for value in $test_list
do
    cd $value
    make clean all
    cd $BASEDIR
done

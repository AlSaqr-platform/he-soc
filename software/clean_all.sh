#!/bin/bash
# Read a string with spaces using for loop
BASEDIR=$(pwd)
test_list=`xargs printf '%s ' < regression.list | cut -b 1-`
 
cd $BASEDIR

for value in $test_list
do
    cd $value
    make clean
    cd $BASEDIR
done

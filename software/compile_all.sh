#!/bin/bash
# Read a string with spaces using for loop
BASEDIR=$(pwd)
cluster_list=`xargs printf '%s ' < cluster_regression.list | cut -b 1-`
host_list=`xargs printf '%s ' < regression.list | cut -b 1-`

cluster_test=1
host_test=1

# Accept user input from the command line
while getopts "ch" opt; do
  case ${opt} in
    c) host_test=0
    ;;
    h) cluster_test=0
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
        exit 1
        ;;
    :) echo "Option -$OPTARG requires an argument" >&2
       exit 1
       ;;
  esac
done

cd $BASEDIR/../
source ./setup.sh
source $BASEDIR/pulp-runtime/configs/pulp_cluster.sh

cd $BASEDIR

if [ $cluster_test -eq 1 ]
then

    for value in $cluster_list
    do
        make -C $value/stimuli clean all dump_header
        make -C $value clean all CLUSTER_BIN=1
    done

fi

if [ $host_test -eq 1 ]
then

    for value in $host_list
    do
        make -C $value clean all
    done

fi

#!/bin/env python3

import subprocess
import sys
import os
import psutil
import csv
import re
import shutil  # Import the shutil module

file = open('regressions/regression.csv')
csvreader = csv.reader(file)

tests_passed = 0
num_tests = 0

# The assumption is that all the cluster-related tests must be at the end of the list!!
first_cl_test = 23

for row in csvreader:
    num_tests += 1
    # Parsing the CSV row
    bm = int(row[0])
    cva6 = row[1]
    ot = row[2]
    cl = row[3]
    db = row[4]
    sec_b = row[5]
    cid = row[6]
    clk = row[7]
    eth = int(row[8])

    # Creating the transcript file name
    transcript_name = f'transcript_{num_tests}.log'

    # Constructing script arguments using a list
    scripts_args = [
        f"sec_boot={sec_b}",
        f"dual-boot={db}",
        f"clk-bypass={clk}"
    ]

    # Add conditional argument for ethernet
    if eth == 1:
        scripts_args.append("exclude-rot=1")
        scripts_args.append("test-eth=1")

    # Join all arguments into a single string
    scripts_args_str = " ".join(scripts_args)

    # Command for the subprocess, with branching logic for `first_cl_test`
    if num_tests < first_cl_test:
        command = (
            f"make scripts_vip_macro {scripts_args_str}; "
            f"make -C {cva6} clean all; "
            f"make clean macro_sim BOOTMODE={bm} ibex-elf-bin={ot} nogui=1; "
            f"mv transcript regressions/regression_reports/transcript_test_{num_tests}"
        )
    else:
        command = (
            f"make scripts_vip_macro {scripts_args_str}; "
            f"make -C {os.path.join(cva6, 'stimuli')} clean all dump_header; "
            f"make -C {cva6} clean all CLUSTER_BIN=1; "
            f"make clean macro_sim BOOTMODE={bm} ibex-elf-bin={ot} nogui=1; "
            f"mv transcript regressions/regression_reports/transcript_test_{num_tests}"
        )

    # Execute the command in a subprocess
    proc = subprocess.Popen(command, shell=True, stderr=subprocess.STDOUT)

    try:
        proc.wait(timeout=30000000000)  # Original long timeout retained
    except subprocess.TimeoutExpired:
        print("Timeout")
        proc.kill()  # Kills the process if it times out

    # Check for return code, exit if there's an error
    retvalue = proc.poll()
    if retvalue != 0:
        exit(1)

    # Increment the tests passed counter
    tests_passed += 1
print("Passed tests: %d/%d\n" %(tests_passed, num_tests) )

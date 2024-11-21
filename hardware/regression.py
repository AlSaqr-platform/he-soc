#!/bin/env python3

import subprocess
import sys
import os
import psutil
import csv
import re
import shutil  # Import the shutil module

# Ensure the regressions/regression_reports/ directory exists
os.makedirs('regressions/regression_reports/', exist_ok=True)

# Open the regression CSV file
try:
    with open('regressions/regression.csv', 'r') as file:
        csvreader = csv.reader(file)

        tests_passed = 0
        num_tests = 0

        # The assumption is that all the cluster-related tests must be at the end of the list!!
        minho_tests = 5

        for row in csvreader:
            num_tests += 1
            # Parsing the CSV row
            try:
                bm = int(row[0])
                cva6 = row[1]
                ot = row[2]
                cl = row[3]
                db = row[4]
                sec_b = row[5]
                cid = row[6]
                clk = row[7]
                eth = int(row[8])
            except IndexError:
                print(f"Error: Row {num_tests} does not have enough columns.")
                continue
            except ValueError:
                print(f"Error: Invalid data type in row {num_tests}.")
                continue

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
                scripts_args.append("include-ethernet=1")

            # Join all arguments into a single string
            scripts_args_str = " ".join(scripts_args)

            # Command for the subprocess, with branching logic for `minho_tests`
            if num_tests > minho_tests:
                command = (
                    f"("
                    f"  set -x; "  # Enable command tracing
                    f"  make scripts_vip_macro {scripts_args_str} && "
                    f"  make -C {cva6} clean all && "
                    f"  make clean macro_sim BOOTMODE={bm} ibex-elf-bin={ot} nogui=1 && "
                    f"  mkdir -p regressions/regression_reports/test_{num_tests} && "
                    f"  mv transcript regressions/regression_reports/test_{num_tests}/transcript.log && "
                    f"  mv trace_hart_0.log regressions/regression_reports/test_{num_tests}/trace_hart_0.log && "
                    f"  mv trace_hart_1.log regressions/regression_reports/test_{num_tests}/trace_hart_1.log"
                    f") | tee regressions/regression_reports/test_{num_tests}/terminal.log"
                )
            else:
                command = (
                    f"("
                    f"  set -x; "  # Enable command tracing
                    f"  make scripts_vip_macro {scripts_args_str} && "
                    f"  make bin_to_slm_path test_path={cva6} && "
                    f"  make clean macro_sim nogui=1 && "
                    f"  mkdir -p regressions/regression_reports/test_{num_tests} && "
                    f"  mv transcript regressions/regression_reports/test_{num_tests}/transcript.log && "
                    f"  mv trace_hart_0.log regressions/regression_reports/test_{num_tests}/trace_hart_0.log && "
                    f"  mv trace_hart_1.log regressions/regression_reports/test_{num_tests}/trace_hart_1.log"
                    f") | tee regressions/regression_reports/test_{num_tests}/terminal.log"
                )

            # Display the command being executed
            print(f"\nExecuting Test {num_tests}:")
            print(f"Command: {command.split('|')[0].strip()}")
            print(f"Logging to: regressions/regression_reports/log_test_{num_tests}.log")

            # Execute the command in a subprocess
            try:
                proc = subprocess.Popen(command, shell=True, executable='/bin/bash')

                try:
                    proc.wait(timeout=3600*4)  # Adjusted timeout to 300 seconds (5 minutes)
                except subprocess.TimeoutExpired:
                    print(f"Test {num_tests}: Timeout expired. Terminating the process.")
                    proc.kill()
                    tests_passed += 0
                    continue

                # Check for return code
                retvalue = proc.returncode
                if retvalue != 0:
                    print(f"Test {num_tests} failed with return code {retvalue}. Check log_test_{num_tests}.log for details.")
                    continue
                else:
                    print(f"Test {num_tests} passed successfully.")
                    tests_passed += 1

            except Exception as e:
                print(f"Test {num_tests}: An exception occurred: {e}")
                continue
    
        print(f"\nPassed tests: {tests_passed}/{num_tests}\n")
    
except FileNotFoundError:
    print("Error: 'regressions/regression.csv' file not found.")
    sys.exit(1)
except Exception as e:
    print(f"An unexpected error occurred: {e}")
    sys.exit(1)

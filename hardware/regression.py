#!/bin/env python3

import subprocess
import sys
import os
import csv
import shutil  # Import the shutil module

# Ensure the regressions/regression_reports/ directory exists
os.makedirs('regressions/regression_reports/', exist_ok=True)

try:
    with open('regressions/regression.csv', 'r') as file:
        csvreader = csv.reader(file)

        tests_passed = 0
        num_tests = 0

        # The assumption is that all the cluster-related tests must be at the end of the list!!
        minho_tests = 4

        for row in csvreader:
            num_tests += 1
            # Parse the CSV row
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

            # Create the test directory BEFORE executing the command
            test_dir = f"regressions/regression_reports/test_{num_tests}"
            os.makedirs(test_dir, exist_ok=True)

            # Construct script arguments
            scripts_args = [
                f"sec_boot={sec_b}",
                f"dual-boot={db}",
                f"clk-bypass={clk}"
            ]
            if eth == 1:
                scripts_args.append("include-ethernet=1")
            scripts_args_str = " ".join(scripts_args)

            # Build command based on test type
            if num_tests > minho_tests:
                command = (
                    "set -ex; "  # Enable command tracing and exit on error
                    f"make scripts_vip_macro {scripts_args_str} && "
                    f"make -C {cva6} clean all && "
                    f"make clean macro_sim BOOTMODE={bm} ibex-elf-bin={ot} nogui=1 && "
                    f"mv transcript {test_dir}/transcript.log && "
                    f"mv trace_core*.log {test_dir}/ && "
                    f"mv trace_hart_0.log {test_dir}/ && "
                    f"mv trace_hart_1.log {test_dir}/"
                )
            else:
                command = (
                    "set -ex; "  # Enable command tracing and exit on error
                    f"make scripts_vip_macro {scripts_args_str} && "
                    f"make bin_to_slm_path test_path={cva6} && "
                    f"make clean macro_sim nogui=1 && "
                    f"mv transcript {test_dir}/transcript.log && "
                    f"mv trace_core*.log {test_dir}/ && "
                    f"mv trace_hart_0.log {test_dir}/ && "
                    f"mv trace_hart_1.log {test_dir}/"
                )

            # Pipe output to tee so that terminal output is logged in test_dir/terminal.log
            full_command = f"({command}) | tee {test_dir}/terminal.log"

            print(f"\nExecuting Test {num_tests}:")
            print(f"Command: {command}")
            print(f"Logging to: {test_dir}/terminal.log")

            try:
                proc = subprocess.Popen(full_command, shell=True, executable='/bin/bash')
                try:
                    proc.wait(timeout=3600*7)
                except subprocess.TimeoutExpired:
                    print(f"Test {num_tests}: Timeout expired. Terminating the process.")
                    proc.kill()
                    sys.exit(1)  # Stop executing further tests

                # Check the process return code
                if proc.returncode != 0:
                    print(f"Test {num_tests}: Command failed with return code {proc.returncode}. Stopping further execution.")
                    sys.exit(1)

                # Instead of relying solely on the return code,
                # check if the transcript log was successfully moved.
                transcript_path = f"{test_dir}/transcript.log"
                if not os.path.exists(transcript_path):
                    print(f"Test {num_tests} failed. Transcript log missing. Stopping further execution.")
                    sys.exit(1)
                else:
                    print(f"Test {num_tests} passed successfully.")
                    tests_passed += 1

            except Exception as e:
                print(f"Test {num_tests}: An exception occurred: {e}")
                sys.exit(1)  # Stop on exception

        print(f"\nPassed tests: {tests_passed}/{num_tests}\n")

except FileNotFoundError:
    print("Error: 'regressions/regression.csv' file not found.")
    sys.exit(1)
except Exception as e:
    print(f"An unexpected error occurred: {e}")
    sys.exit(1)

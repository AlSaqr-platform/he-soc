#!/bin/env python3

import subprocess
import sys
import os
import csv
import shutil  # Import the shutil module

# Ensure the regressions/regression_netlist_reports/ directory exists
os.makedirs('regressions/regression_netlist_reports/', exist_ok=True)

try:
    with open('regressions/regression_netlist.csv', 'r') as file:
        csvreader = csv.reader(file)

        tests_passed = 0
        num_tests = 0

        # The assumption is that all the cluster-related tests must be at the end of the list!!
        minho_tests = 0

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

            # Pre-create the test directory before executing the command
            test_dir = f"regressions/regression_netlist_reports/test_{num_tests}"
            os.makedirs(test_dir, exist_ok=True)

            # Constructing script arguments using a list
            scripts_args = [
                f"sec_boot={sec_b}",
                f"dual-boot={db}",
                f"clk-bypass={clk}"
            ]
            if eth == 1:
                scripts_args.append("include-ethernet=1")
            scripts_args_str = " ".join(scripts_args)

            # Build command based on test number
            if num_tests > minho_tests:
                command = (
                    "set -x; "  # Enable command tracing
                    f"make post_synth_all post_synth=1 {scripts_args_str} && "
                    f"make -C {cva6} clean all && "
                    f"make clean synth_sim post_synth=1 BOOTMODE={bm} ibex-elf-bin={ot} nogui=1 && "
                    f"mv transcript {test_dir}/transcript.log"
                )
            else:
                command = (
                    "set -x; "  # Enable command tracing
                    f"make post_synth_all post_synth=1 {scripts_args_str} && "
                    f"make bin_to_slm_path test_path={cva6} && "
                    f"make clean synth_sim post_synth=1 nogui=1 && "
                    f"mv transcript {test_dir}/transcript.log"
                )

            # Pipe output to tee so that terminal output is logged in the test directory
            full_command = f"({command}) | tee {test_dir}/terminal.log"

            print(f"\nExecuting Test {num_tests}:")
            print(f"Command: {command}")
            print(f"Logging to: {test_dir}/terminal.log")

            try:
                proc = subprocess.Popen(full_command, shell=True, executable='/bin/bash')

                try:
                    proc.wait(timeout=3600 * 8)
                except subprocess.TimeoutExpired:
                    print(f"Test {num_tests}: Timeout expired. Terminating the process.")
                    proc.kill()
                    continue

                # Instead of relying solely on the return code,
                # check if the transcript file was successfully moved.
                transcript_path = f"{test_dir}/transcript.log"
                if os.path.exists(transcript_path):
                    print(f"Test {num_tests} passed successfully.")
                    tests_passed += 1
                else:
                    print(f"Test {num_tests} failed. Transcript log missing.")
            except Exception as e:
                print(f"Test {num_tests}: An exception occurred: {e}")
                continue

        print(f"\nPassed tests: {tests_passed}/{num_tests}\n")

except FileNotFoundError:
    print("Error: 'regressions/regression_netlist.csv' file not found.")
    sys.exit(1)
except Exception as e:
    print(f"An unexpected error occurred: {e}")
    sys.exit(1)

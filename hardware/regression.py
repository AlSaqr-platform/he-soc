#!/usr/bin/env python3

import subprocess
import sys
import os
import csv
import shutil

# Ensure output directory exists
REPORT_ROOT = 'regressions/regression_reports'
os.makedirs(REPORT_ROOT, exist_ok=True)

# Open the regression CSV file
try:
    with open('regressions/regression.csv', 'r') as file:
        csvreader = csv.reader(file)

        tests_passed = 0
        num_tests = 0

        # All cluster-related tests start at this index
        first_cl_test = 24

        for row in csvreader:
            num_tests += 1

            # Unpack columns
            try:
                bm        = int(row[0])
                cva6      = row[1]
                ot        = row[2]
                cl        = row[3]
                db        = row[4]
                sec_b     = row[5]
                cid       = row[6]
                clk       = row[7]
            except (IndexError, ValueError) as e:
                print(f"[Test {num_tests}] CSV parse error: {e!s}")
                sys.exit(1)

            # Prepare per-test report directory
            test_dir = os.path.join(REPORT_ROOT, f"test_{num_tests}")
            os.makedirs(test_dir, exist_ok=True)

            # Build the sequence of make commands, chained with &&
            common = (
                f"make scripts_vip_macro sec_boot={sec_b} dual-boot={db} clk-bypass={clk}"
                f" && make -C {cva6} clean all"
            )
            if num_tests < first_cl_test:
                sim_cmd = f"make clean macro_sim BOOTMODE={bm} ibex-elf-bin={ot} nogui=1"
            else:
                sim_cmd = (
                    f"make -C {cva6}/stimuli clean all dump_header"
                    f" && make -C {cva6} clean all CLUSTER_BIN=1"
                    f" && make clean macro_sim BOOTMODE={bm} ibex-elf-bin={ot} nogui=1"
                )

            # Full shell command: enable tracing, chain commands, then tee
            shell_cmd = (
                f"( set -x;"
                f" {common} && {sim_cmd};"
                f" ) 2>&1 | tee {os.path.join(test_dir, 'terminal.log')}"
            )

            print(f"\n[Test {num_tests}] Running. Logs ? {test_dir}/terminal.log")

            # Execute and automatically fail on any sub-command error
            try:
                subprocess.run(
                    shell_cmd,
                    shell=True,
                    executable='/bin/bash',
                    check=True,
                    timeout=3600*7  # e.g. 7 hour timeout
                )
            except subprocess.TimeoutExpired:
                print(f"[Test {num_tests}] TIMEOUT after 7h. Aborting.")
                sys.exit(1)
            except subprocess.CalledProcessError as e:
                print(f"[Test {num_tests}] FAILED (exit {e.returncode}). See terminal.log for details.")
                sys.exit(e.returncode)

            # If we reach here, the make+sim succeeded: move transcript into the report dir
            try:
                shutil.move('transcript', os.path.join(test_dir, 'transcript.log'))
            except FileNotFoundError:
                print(f"[Test {num_tests}] WARNING: transcript file not found.")
            tests_passed += 1

        # Summary
        print(f"\nPassed tests: {tests_passed}/{num_tests}\n")

except FileNotFoundError:
    print("Error: 'regressions/regression.csv' not found.")
    sys.exit(1)

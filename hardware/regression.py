import subprocess
import sys
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
    num_tests = num_tests + 1
    bm = int(row[0])
    cva6 = row[1]
    ot = row[2]
    cl = row[3]
    db = row[4]
    sec_b = row[5]
    cid = row[6]
    clk = row[7]
    transcript_name = 'transcript_{}.log'.format(num_tests)  # New name for the transcript file
    
    if (num_tests<first_cl_test):
        proc = subprocess.Popen("make scripts_vip_macro sec_boot=%s dual-boot=%s clk-bypass=%s; make -C %s clean all; make clean macro_sim BOOTMODE=%s ibex-elf-bin=%s nogui=1; mv transcript regressions/regression_reports/transcript_test_%d" %(sec_b, db, clk, cva6, bm, ot, num_tests), shell=True, stderr=subprocess.STDOUT)
    else:
        proc = subprocess.Popen("make scripts_vip_macro sec_boot=%s dual-boot=%s clk-bypass=%s; make -C %s/stimuli clean all dump_header; make -C %s clean all CLUSTER_BIN=1; make clean macro_sim BOOTMODE=%s ibex-elf-bin=%s nogui=1; mv transcript regressions/regression_reports/transcript_test_%d" %(sec_b, db, clk, cva6, cva6, bm, ot, num_tests), shell=True, stderr=subprocess.STDOUT)
    
    try:
        proc.wait(timeout=30000000000);
    except subprocess.TimeoutExpired:
        print("Timeout")
        kill(proc.pid)
    retvalue = proc.poll()
    if(retvalue!=0):
        exit(1)
    tests_passed = tests_passed +1

print("Passed tests: %d/%d\n" %(tests_passed, num_tests) )

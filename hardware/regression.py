import subprocess
import sys
import psutil
import csv
import re
import shutil  # Import the shutil module

file = open('regression.csv')
csvreader = csv.reader(file)

tests_passed = 0
num_tests = 0

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
    proc = subprocess.Popen("make scripts_vip_macro preload=1 sec_boot=%s dual-boot=%s clk-bypass=%s; make -C %s clean all; make clean macro_sim BOOTMODE=%s ibex-elf-bin=%s nogui=1; mv transcript regression_reports/transcript_test_%d" %(sec_b, db, clk, cva6, bm, ot, num_tests), shell=True, stderr=subprocess.STDOUT)
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

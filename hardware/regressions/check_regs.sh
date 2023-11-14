#!/bin/bash
# check simulation output (only for questasim flow)
#
# $1 simulation output file basename
# $2 number of tests to check
#

cd regressions/regression_reports

# only use colors in interactive mode
if [[ -z "$-" ]]; then
  GREEN=''
  RED=''
  NC=''
else
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  NC='\033[0m' # No Color
fi

 #get NUM_TOTAL number of tests
NUM_TOTAL=`ls | wc -l`

echo "list containing tests: $2"

echo "checking files:"
ls "${1}"*.log

# check for patterns
NUM_PASSED=`grep -rn SUCCESS   | wc -l`
NUM_FAILED=`grep -rn FAILED    | wc -l`
NUM_FATAL=`grep  -rn Fatal:    | wc -l`
NUM_ERROR=`grep  -rn Error:    | wc -l`

echo "NUM_TOTAL:  $NUM_TOTAL"
echo "NUM_PASSED: $NUM_PASSED"
echo "NUM_FAILED: $NUM_FAILED"
echo "NUM_FATAL:  $NUM_FATAL"
echo "NUM_ERROR:  $NUM_ERROR"

if [[ $(($NUM_FAILED)) -gt 0 ]]; then
  echo -e "${RED}FAILED $NUM_FAILED of $NUM_TOTAL tests ${NC}"
  exit 1;
elif [[ $(($NUM_FATAL)) -ne  0 ]]; then
  echo -e "${RED}FAILED at least one test due to $NUM_FATAL FATAL assertions ${NC}"
  exit 1;
elif [[ $(($NUM_ERROR)) -ne 0 ]]; then
  echo -e "${RED}FAILED at least one test due to $NUM_ERROR ERROR assertions ${NC}"
  exit 1;
elif [[ $(($NUM_PASSED)) -ne $(($NUM_TOTAL)) ]]; then
  echo -e "${RED}FAILED since not all tests have been executed  ${NC}"
  exit 1;
else
  echo -e "${GREEN}PASSED all $NUM_TOTAL tests ${NC}"
  exit 0;
fi

#!/bin/bash

make -f ../bin/complexpack.mk clean
make -f ../bin/complexpack.mk init
make -f ../bin/complexpack.mk run

cmp -s complexpack_results.txt ../out/complexpack_results.txt
STATUS=$?
if [ $STATUS -eq 0 ]; then
  echo "PASS!"
  # match
elif [ $STATUS -eq 1 ]; then
  echo "FAIL"
  exit 88
  # compare
else
  echo "ERROR. Unexpected result when comparing to the reference output!"
  exit 89
fi

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."

#!/bin/bash

make -f ../bin/complexpack.mk clean
make -f ../bin/complexpack.mk init
make -f ../bin/complexpack.mk run

if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "This script has been running for $SECONDS $units."
exit 0

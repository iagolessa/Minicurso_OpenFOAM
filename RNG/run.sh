#!/bin/sh

echo "Running with relaxation factor: 0.7"

mpirun -np 2 simpleFoam -parallel > log0 2>&1





#!/bin/sh

echo "Running with relaxation factor: 0.5"

mpirun -np 2 simpleFoam -parallel > log0 2>&1





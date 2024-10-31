#!/bin/sh

rm -r proc*
cd system
m4 wedgeDifusser.m4>blockMeshDict
cd ..
blockMesh
cp -r 0 0.org
potentialFoam -writep -writePhi > log.potential

decomposePar
mpirun -n 2 renumberMesh -overwrite -parallel




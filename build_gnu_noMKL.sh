#!/bin/bash

# builds libraries for Gfortran

MKLROOT=

export FC=$(which mpif90)
export CC=$(which mpicc)

echo "FC=$FC"
echo "CC=$CC"

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDSCALAPACK=1


## Scalapack

(

[[ $BUILDSCALAPACK != 1 ]] && exit

[[ $CLEAN == 1 ]] && rm -rf scalapack/build/*

cd scalapack/build

cmake -Wno-dev ..

cmake --build -j . -- -l 4
)

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...

# Directories for self-compiled LAPACK and BLAS
# LAPACK=  BLAS=

make s d FC=$FC FL=$FC CC=$CC \
     LSCOTCHDIR= ISCOTCH= \
     LMETISDIR= IMETIS= \
     SCALAPDIR=../../scalapack \
     SCALAP='-L$(SCALAPDIR) -lscalapack' \
     ORDERINGSF=-Dpord
)

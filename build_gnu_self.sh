#!/bin/bash

# builds libraries for Gfortran
# Note: Currently, Scalapack appears to be incompatible with OpenMPI 4.0. Try OpenMPI 3.1

MKLROOT=

export MPIROOT=$HOME/.local/openmpi-3.1-gcc7/
export LAPACKROOT=$HOME/.local/lapack-gcc7/
export SCALAPACKROOT=$HOME/.local/scalapack-gcc7/
export MUMPSROOT=$HOME/.local/mumps-gcc7/

export FC=$MPIROOT/bin/mpif90
export CC=$MPIROOT/bin/mpicc

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDSCALAPACK=1


## Scalapack

(

[[ $BUILDSCALAPACK != 1 ]] && exit

[[ $CLEAN == 1 ]] && rm -rf scalapack/build/*

cd scalapack/build

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$SCALAPACKROOT -DMPI_ROOT=$MPIROOT -DLAPACK_ROOT=$LAPACKROOT ..

cmake --build -j . --target install -- -l 4
)

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...

# Directories for self-compiled LAPACK and BLAS
# LAPACK=  BLAS=

make s d FC=$FC FL=$FC CC=$CC \
LAPACK=$LAPACKROOT BLAS=$LAPACKROOT \    
LSCOTCHDIR= ISCOTCH= \
LMETISDIR= IMETIS= \
SCALAPDIR=$SCALAPACKROOT \
SCALAP='-L$(SCALAPDIR) -lscalapack' \
ORDERINGSF=-Dpord

# Mumps makefile doesn't have an "install" target so let's do it ourself.
mkdir -p $MUMPSROOT/{lib,include}
cp lib/{libpord,lib{s,d}mumps,libmumps_common}.a $MUMPSROOT/lib
cp include/{s,d}mumps_struc.h include/mumps_compat.h $MUMPSROOT/include/
)

#!/bin/bash

# builds libraries for Gfortran
# Note: Currently, Scalapack appears to be incompatible with OpenMPI 4.0. Try OpenMPI 3.1

set -e
set -u

# disables Intel compiler from interfering
MKLROOT=

PREFIX=$1
SUFFIX=$2
MPIPREFIX=$3
LAPACKPREFIX=$4

[[ -d $PREFIX ]] || { "Install directory $PREFIX does not exist"; exit 1; }
[[ -d $MPIPREFIX ]] || { "MPI directory $MPIPREFIX does not exist"; exit 1; }
[[ -d $LAPACKPREFIX ]] || { "LAPACK directory $LAPACKPREFIX does not exist"; exit 1; }

export SCALAPACKPREFIX=$PREFIX/scalapack-$SUFFIX/
export MUMPSPREFIX=$PREFIX/mumps-$SUFFIX/

export FC=$MPIPREFIX/bin/mpif90
export CC=$MPIPREFIX/bin/mpicc

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDSCALAPACK=1


## Scalapack

(

[[ $BUILDSCALAPACK != 1 ]] && exit

[[ $CLEAN == 1 ]] && rm -rf scalapack/build/*

cd scalapack/build

cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$SCALAPACKPREFIX -DMPI_ROOT=$MPIPREFIX -DLAPACK_ROOT=$LAPACKPREFIX ..

cmake --build -j . --target install -- -l 4
)

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...

# Directories for self-compiled LAPACK and BLAS
# LAPACK=  BLAS=

make s d FC=$FC FL=$FC CC=$CC \
LAPACK=$LAPACKPREFIX BLAS=$LAPACKPREFIX \
LSCOTCHDIR= ISCOTCH= \
LMETISDIR= IMETIS= \
SCALAPDIR=$SCALAPACKPREFIX \
SCALAP='-L$(SCALAPDIR) -lscalapack' \
ORDERINGSF=-Dpord

# Mumps makefile doesn't have an "install" target so let's do it ourself.
mkdir -p $MUMPSPREFIX/{lib,include}
cp lib/{libpord,lib{s,d}mumps,libmumps_common}.a $MUMPSPREFIX/lib
cp include/{s,d}mumps*.h include/mumps_compat.h $MUMPSPREFIX/include/
)

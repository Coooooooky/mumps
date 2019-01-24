#!/bin/bash

# builds MUMPS libraries for Gfortran using all self-compiled OpenMPI, LAPACK, Scalapack

set -e
set -u

# disables Intel compiler from interfering
MKLROOT=

PREFIX=$1
SUFFIX=$2
MPIPREFIX=$3
LAPACKPREFIX=$4
SCALAPACKPREFIX=$5

[[ -d $PREFIX ]] || { "Install directory $PREFIX does not exist"; exit 1; }
[[ -d $MPIPREFIX ]] || { "MPI directory $MPIPREFIX does not exist"; exit 1; }
[[ -d $LAPACKPREFIX ]] || { "LAPACK directory $LAPACKPREFIX does not exist"; exit 1; }

export MUMPSPREFIX=$PREFIX/mumps-$SUFFIX/

export FC=$MPIPREFIX/bin/mpif90
export CC=$MPIPREFIX/bin/mpicc

echo "FC=$FC"
echo "CC=$CC"


## MUMPS

# no -j due to old Makefile...

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


#!/bin/bash

# builds MKL-based libraries for Gfortran

set -e

. $MKLROOT/../bin/compilervars.sh intel64
. $MKLROOT/bin/mklvars.sh intel64 ilp64

export FC=mpif90 CC=mpicc

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDLAPACK95=0
BUILDMETIS=1
BUILDSCOTCH=1

## LAPACK95   (N.B. included in Intel MKL, but MKL LAPACK95 needs to be compiled for GNU)
(
[[ $BUILDLAPACK95 != 1 ]] && exit

cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

# no -j due to Makefile syntax...
make double -C SRC FC=mpif90
)

## METIS
(
[[ $BUILDMETIS != 1 ]] && exit
cd metis

[[ $CLEAN == 1 ]] && { make clean; make config; }

make -j -l4 FC=mpif90
)

## Scotch
(
[[ $BUILDSCOTCH != 1 ]] && exit
cd scotch/src

[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

# no -j due to Makefile syntax (results in missing scotch.h)...
make FC=mpif90

cd esmumps
make -j -l4 FC=mpif90
)

## Scalapack included in MKL


## MUMPS
SCALAP='-L$(SCALAPDIR) -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -liomp5 -lpthread -ldl -lm'
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...
make s d FC=mpif90 \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     INCPAR=-I$MKLROOT/../mpi/intel64/include/ \
     LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP
)


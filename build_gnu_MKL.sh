#!/bin/bash

# builds libraries for Gfortran

set -e

. $MKLROOT/../bin/compilervars.sh intel64
. $MKLROOT/bin/mklvars.sh intel64 ilp64

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDLAPACK95=0
BUILDMETIS=1
BUILDSCOTCH=1
BUILDSCALAPACK=1

## LAPACK95
(
[[ $BUILDLAPACK95 != 1 ]] && exit

cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

# no -j due to Makefile syntax...
make double -C SRC FC=mpifort
)

## METIS
(
[[ $BUILDMETIS != 1 ]] && exit
cd metis

[[ $CLEAN == 1 ]] && { make clean; make config; }

make -j -l4 FC=mpifort
)

## Scotch
(
[[ $BUILDSCOTCH != 1 ]] && exit
cd scotch/src

[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

# no -j due to Makefile syntax (results in missing scotch.h)...
make FC=mpifort

cd esmumps
make -j -l4 FC=mpifort
)

## Scalapack included in MKL


## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...
make s d FC=mpif90 \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     INCPAR=-I$HOME/intel/compilers_and_libraries/linux/mpi/intel64/include/ \
     LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP
)


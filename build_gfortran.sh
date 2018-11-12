#!/bin/bash

# builds libraries for Gfortran

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDLAPACK95=0

## LAPACK95
(
[[ $BUILDLAPACK95 != 1 ]] && exit

cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

# no -j due to Makefile syntax...
make double -C SRC FC=gfortran
)

## METIS
(
cd metis

[[ $CLEAN == 1 ]] && { make clean; make config; }

make -j -l4 FC=mpif90
)

## Scotch
(
cd scotch/src

[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

# no -j due to Makefile syntax (results in missing scotch.h)...
make FC=mpif90

cd esmumps
make -j -l4 FC=mpif90
)

## Scalapack

(
cd scalapack/

[[ $CLEAN == 1 ]] && make clean

cmake -Wno-dev .

make -j -l4
)

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...
make s d FC=mpif90 \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
     SCALAPDIR=../../scalapack \
     SCALAP='-L$(SCALAPDIR) -lscalapack'
)

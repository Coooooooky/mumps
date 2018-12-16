#!/bin/bash

# builds libraries for Gfortran

MKLROOT=

export FC=/usr/bin/mpif90

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1

BUILDLAPACK95=0
BUILDSCALAPACK=1

## LAPACK95
(
[[ $BUILDLAPACK95 != 1 ]] && exit

cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

# no -j due to Makefile syntax...
make double -C SRC FC=$FC
)


## Scalapack

(

[[ $BUILDSCALAPACK != 1 ]] && exit

cd scalapack/

[[ $CLEAN == 1 ]] && make clean

cmake -Wno-dev .

make -j -l4
)

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...
make s d FC=$FC \
     LSCOTCHDIR= ISCOTCH= \
     LMETISDIR= IMETIS= \
     SCALAPDIR=../../scalapack \
     SCALAP='-L$(SCALAPDIR) -lscalapack'
)

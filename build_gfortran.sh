#!/bin/bash

# builds libraries for Intel Fortran

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1 

## LAPACK95
(cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

make double -C SRC FC=mpif90
)

## METIS
(cd metis

[[ $CLEAN == 1 ]] && { make clean; make config; }

make FC=mpif90
)

## Scotch
(cd scotch/src
[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

make FC=mpif90

cd esmumps
make FC=mpif90
)

## Scalapack is included with Intel Fortran

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

make s d FC=mpif90 \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
     SCALAPDIR=../../scalapack \
     SCALAP='-L$(SCALAPDIR) -lscalapack'
)

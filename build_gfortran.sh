#!/bin/bash

# builds libraries for Intel Fortran

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1 

## LAPACK95
(cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

make double -C SRC
)

## METIS
(cd metis

[[ $CLEAN == 1 ]] && { make clean; make config; }

make
)

## Scotch
(cd scotch/src
[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

make

cd esmumps
make
)

## Scalapack is included with Intel Fortran

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean


make s d \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
     SCALAPDIR=../../scalapack \
     SCALAP='-L$(SCALAPDIR) -lscalapack'
)

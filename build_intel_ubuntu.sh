#!/bin/bash

# builds libraries for Intel Fortran

set -e

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1 

## LAPACK95
(cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

make double -C SRC FC=ifort OPTS0="-O3 -fPIC -fno-trapping-math"
)

## METIS
(cd metis

[[ $CLEAN == 1 ]] && { make clean; make config FC=ifort; }

make FC=ifort
)

## Scotch
(cd scotch/src
[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

make FC=ifort

cd esmumps
make FC=ifort
)

## Scalapack is included with Intel Fortran

## MUMPS
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

make s d FC=ifort \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     INCPAR=-I$HOME/intel/compilers_and_libraries/linux/mpi/intel64/include/ \
     LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
     SCALAPDIR=$MKLROOT \
     SCALAP='-L$(SCALAPDIR) -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -liomp5 -lpthread -ldl -lm'
)

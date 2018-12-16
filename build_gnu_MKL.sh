#!/bin/bash

# builds MKL-based libraries for Gfortran

set -e

# if MKLROOT is not defined, try a default value
[[ -v MKLROOT ]] || export MKLROOT=$HOME/intel/compilers_and_libraries/linux/bin/

. $MKLROOT/../bin/compilervars.sh intel64
. $MKLROOT/bin/mklvars.sh intel64 lp64

export FC=/usr/bin/mpif90 CC=/usr/bin/mpicc

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1


## Scalapack included in MKL


## MUMPS
SCALAP='-L$(SCALAPDIR) -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -liomp5 -lpthread -ldl -lm'
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

# no -j due to Makefile...
make s d FC=$FC \
     LSCOTCHDIR= ISCOTCH= \
     INCPAR=-I$MKLROOT/../mpi/intel64/include/ \
     LMETISDIR= IMETIS= \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP
)


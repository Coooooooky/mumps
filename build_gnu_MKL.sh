#!/bin/bash
# builds MKL-based libraries for Gfortran

set -u
set -e

# if MKLROOT is not defined, try a default value
[[ -v MKLROOT ]] || export MKLROOT=$HOME/intel/compilers_and_libraries/linux/bin/

. $MKLROOT/../bin/compilervars.sh intel64
. $MKLROOT/bin/mklvars.sh intel64 lp64

export FC=$(which /usr/bin/mpif90)
export CC=$(which /usr/bin/mpicc)

echo "FC=$FC"
echo "CC=$CC"

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1



## MUMPS


(
cd MUMPS

[[ $CLEAN == 1 ]] && make clean

SCALAP='-L$MKLROOT -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -liomp5 -lpthread -ldl -lm'

# no -j due to Makefile...
make s d FC=$FC FL=$FC CC=$CC \
     LSCOTCHDIR= ISCOTCH= \
     INCPAR=-I$MKLROOT/../mpi/intel64/include/ \
     LMETISDIR= IMETIS= \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP \
     ORDERINGSF=-Dpord
)


#!/bin/bash

# attempt to detect CentOS, default to Ubuntu otherwise
# builds libraries for Intel Fortran

set -e

# if MKLROOT is not defined, try a default value
[[ -v MKLROOT ]] || export MKLROOT=$HOME/intel/compilers_and_libraries/linux/bin/

. $MKLROOT/../bin/compilervars.sh intel64
. $MKLROOT/bin/mklvars.sh intel64 lp64

# DO NOT change to mpif90 or mpicc as that would use GNU compilers!!!
export FC=$MKLROOT/../mpi/intel64/bin/mpiifort
export CC=$MKLROOT/../mpi/intel64/bin/mpiicc
export CXX=icpc

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1


## Scalapack is included with Intel Fortran

## MUMPS
SCALAP='-L$MKLROOT -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -liomp5 -lpthread -ldl -lm'
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

if [[ -f /etc/redhat-release ]]; then

  make s d FC=$FC FL=$FC CC=$CC CXX=$CXX \
     LIBBLAS='-L$MKLROOT -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core' \
     LAPACK='-L$MKLROOT -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core' \
     LSCOTCHDIR= ISCOTCH= \
     INCPAR=-I/share/pkg/openmpi/3.0.0_intel-2018/install1/include/ \
     LMETISDIR= IMETIS= \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP

else

  make s d FC=$FC FL=$FC CC=$CC CXX=$CXX \
     LIBBLAS='-L$MKLROOT -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core' \
     LAPACK='-L$MKLROOT -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core' \
     INCPAR=-I$MKLROOT/../mpi/intel64/include/ \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP \
     LSCOTCHDIR= ISCOTCH= \
     LMETISDIR= IMETIS= \
     ORDERINGSF=-Dpord
     
     #     OPTF=-qopenmp OPTL=-qopenmp OPTC=-qopenmp \
     #LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     #LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \

fi
)

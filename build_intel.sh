#!/bin/bash

# attempt to detect CentOS, default to Ubuntu otherwise
# builds libraries for Intel Fortran

set -e

export CC=icc CXX=icpc

[[ $1 == -k ]] && CLEAN=0 || CLEAN=1 

BUILDLAPACK95=0
BUILDMETIS=0
BUILDSCOTCH=0

## LAPACK95   (N.B. included in Intel MKL)
(
[[ $BUILDLAPACK95 != 1 ]] && exit

cd LAPACK95/

[[ $CLEAN == 1 ]] && make clean -C SRC

make double -C SRC FC=mpiifort OPTS0="-O3 -fPIC -fno-trapping-math"
)

## METIS
(
[[ $BUILDLAPACK95 != 1 ]] && exit

cd metis

[[ $CLEAN == 1 ]] && { make clean; make config CC=icc CXX=icpc; }

make -j -l4 FC=mpiifort
)

## Scotch
(
[[ $BUILDSCOTCH != 1 ]] && exit


cd scotch/src
[[ $CLEAN == 1 ]] && { make clean; cd esmumps; make clean; cd ..; }

make FC=mpiifort CC=icc CCS=icc CCD=icc CCP=mpiicc CXX=icpc

cd esmumps
make -j -l4 FC=mpiifort CC=icc CCS=icc CCD=icc CCP=mpiicc CXX=icpc
)

## Scalapack is included with Intel Fortran

## MUMPS
SCALAP='-L$(SCALAPDIR) -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_lp64 -liomp5 -lpthread -ldl -lm'
(cd MUMPS

[[ $CLEAN == 1 ]] && make clean

if [[ -f /etc/redhat-release ]]; then

  make d FC=mpiifort CC=icc CXX=icpc \
     LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     INCPAR=-I/share/pkg/openmpi/3.0.0_intel-2018/install1/include/ \
     LMETISDIR=/share/pkg/metis/5.1.0/install/lib IMETIS=-I/share/pkg/metis/5.1.0/install/include \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP

else

  make d FC=mpiifort CC=icc CXX=icpc \
     SCALAPDIR=$MKLROOT \
     SCALAP=$SCALAP ]
     INCPAR=-I$HOME/intel/compilers_and_libraries/linux/mpi/intel64/include/ # don't remove this line!
     #LSCOTCHDIR=../../scotch/lib ISCOTCH=-I../../scotch/include \
     #LMETISDIR=../../metis/libmetis IMETIS=-I../../metis/include \
fi     
)

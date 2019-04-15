#!/bin/bash
# builds MKL-based libraries for Gfortran

set -u
set -e

# if MKLROOT is not defined, try a default value
if [[ ! -v MKLROOT ]]
then
export MKLROOT=$HOME/intel/compilers_and_libraries/linux/bin/
. $MKLROOT/bin/mklvars.sh intel64 lp64
fi

export FC=$(which /usr/bin/mpif90)
export CC=$(which /usr/bin/mpicc)

echo "FC=$FC"
echo "CC=$CC"

## MUMPS

rm -f build/CMakeCache.txt

cmake -B build -S .
cmake --build build -j --target install

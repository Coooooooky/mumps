#!/bin/bash

# attempt to detect CentOS, default to Ubuntu otherwise
# builds libraries for Intel Fortran

set -u
set -e

# if MKLROOT is not defined, try a default value
if [[ ! -v MKLROOT ]]
then
export MKLROOT=$HOME/intel/compilers_and_libraries/linux/bin/
. $MKLROOT/../bin/compilervars.sh intel64
fi

export FC=$MKLROOT/../mpi/intel64/bin/mpiifort
export CC=$MKLROOT/../mpi/intel64/bin/mpiicc
export CXX=icpc

echo "FC=$FC"
echo "CC=$CC"

rm -f build/CMakeCache.txt

cmake -B build -S .

cmake --build build -j --target install

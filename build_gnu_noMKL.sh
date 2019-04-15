#!/bin/bash
# builds libraries for Gfortran

set -u
set -e

MKLROOT=
LD_LIBRARY_PATH=

export FC=$(which mpif90)
export CC=$(which mpicc)

echo "FC=$FC"
echo "CC=$CC"

rm -f build/CMakeCache.txt

cmake -DUSEMKL=off -B build -S .
cmake --build build -j --target install



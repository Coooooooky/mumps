[![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/lo4lftvwo0kghir5?svg=true)](https://ci.appveyor.com/project/scivision/fortran-libs)

[![Travis-CI Build Status](https://travis-ci.org/scivision/fortran-libs.svg)](https://travis-ci.org/scivision/fortran-libs)

Related: [Fortran 2018 examples](https://github.com/scivision/fortran2018-examples)

---

# Fortran Libraries

These Fortran libraries are copied and Makefiles lightly modified to build easily with Gfortran on a wide variety of systems including Linux, MacOS and Windows.
A few simple demos / self-tests are included, and are run by:
```sh
cd tests/bin
cmake -DLAPACK95_ROOT=../LAPACK95 -DMUMPS_ROOT=../MUMPS ..
make
make test
```

Look under `cmake/Modules/Find_____.cmake` to conveniently link these libraries to your project.


For Intel compilers, try building all these libraries at once by:
```sh
./build_intel.sh
```

## LAPACK95
To build 
[LAPACK95](http://www.netlib.org/lapack95/)
library with any Fortran compiler simply:
```sh
cd LAPACK95/
make clean -C SRC

make double -C SRC 
```
which creates `lapack95.a` in `LAPACK95/`  with "double" precision.
Use "single" or other options described in tne README files under LAPACK95 and LAPACK95/SRC if complex etc. precision is needed.

## MUMPS

Instead of compiling, it's often easier to:

* Ubuntu: `apt install libmumps-dev`
* CentOS: `yum install MUMPS-openmpi`

MUMPS is available for Linux, OSX and 
[Windows](http://mumps.enseeiht.fr/index.php?page=links).

1. Build Metis and Scalapack with ESMUMPS
2. build MUMPS. If using Intel Fortran, check `which mpif90` to be sure it's pointing to Intel instead of GNU
   ```sh
   cd MUMPS/
   make clean

   make
   ```

on systems where you have to build your own Scalapack, Scotch, etc. you will need to tell Make where to find them.
See the example `build_gfortran.sh` or `build_intel.sh`.

### OSX

[Reference](http://mumps.enseeiht.fr/index.php?page=links)

```sh
brew tap dpo/openblas
brew tap-pin dpo/openblas
brew options mumps
brew install mumps
```

## Scalapack
Instead of compiling, it's often easier to:

* Ubuntu: `apt install libscalapack-openmpi-dev`
* CentOS: `yum install scalapack-openmpi`

To build Scalapack (and BLACS):

* Ubuntu: `apt install libmetis-dev libparmetis-dev libscotch-dev libptscotch-dev libatlas-base-dev openmpi-bin libopenmpi-dev liblapack-dev`
* CentOS: ` `

cd scalapack/
cmake .
make
```
which creates `lib/libscalapack.a`


The build can be verified by
```sh
make test
```

For the program you're building with Scalapack, include it via CMake with a command like:
```sh
cmake -DSCALAPACK_ROOT=~/fortran-libs/scalapack ..
```

## Scotch

Instead of compiling, it's often easier to:

* Ubuntu: `apt install libscotch-dev`
* CentOS: `yum install scotch`

Otherwise you can compile Scotch by:

```sh
cd scotch/src
make

cd esmumps
make
```

## Metis

Instead of compiling, it's often easier to:

* Ubuntu: `apt install libmetis-dev`
* CentOS: `yum install metis`

Otherwise you can compile Metis by:

```sh
cd metis
make config
make
```

which creates `libmetis/libmetis.a`



## CMake
The `cmake/Modules` directory contains several `Find___.cmake` files useful for Fortran libraries in CMake including:

* [MKL](https://software.intel.com/mkl)
* [SCALAPACK](http://www.netlib.org/scalapack/)
* [BLACS](http://www.netlib.org/blacs/)
* [LAPACK95](http://www.netlib.org/lapack95/)
* [MUMPS](http://mumps.enseeiht.fr/)
* [Scotch](https://gforge.inria.fr/projects/scotch/)
* [GNU Octave](https://www.gnu.org/software/octave/)

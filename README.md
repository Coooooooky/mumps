[![AppVeyor Build status](https://ci.appveyor.com/api/projects/status/lo4lftvwo0kghir5?svg=true)](https://ci.appveyor.com/project/scivision/fortran-utils)

[![Travis-CI Build Status](https://travis-ci.org/scivision/fortran-utils.svg)](https://travis-ci.org/scivision/fortran-utils)

Related: [Fortran 2018 examples](https://github.com/scivision/fortran2018-examples)

---

# Fortran Utilities

These Fortran libraries are copied and Makefiles lightly modified to build easily with Gfortran on a wide variety of systems including Linux, MacOS and Windows.
A few simple demos / self-tests are included, and are run by:
```sh
cd tests/bin
cmake -DLAPACK95_ROOT=../LAPACK95 -DMUMPS_ROOT=../MUMPS ..
make
make test
```

Look under `cmake/Modules/Find_____.cmake` to conveniently link these libraries to your project.

## LAPACK95
To build 
[LAPACK95](http://www.netlib.org/lapack95/)
library with any Fortran compiler simply:
```sh
cd LAPACK95/
make double -C SRC 
```
which creates `lapack95.a` in `LAPACK95/`  with "double" precision.
Use "single" or other options described in tne README files under LAPACK95 and LAPACK95/SRC if complex etc. precision is needed.

## MUMPS
MUMPS is available for Linux, OSX and [Windows](http://mumps.enseeiht.fr/index.php?page=links).

### OSX

[Reference](http://mumps.enseeiht.fr/index.php?page=links)

```sh
brew tap dpo/openblas
brew tap-pin dpo/openblas
brew options mumps
brew install mumps
```

## CMake
The `cmake/Modules` directory contains several `Find___.cmake` files useful for Fortran libraries in CMake including:

* [MKL](https://software.intel.com/mkl)
* [SCALAPACK](http://www.netlib.org/scalapack/)
* [BLACS](http://www.netlib.org/blacs/)
* [LAPACK95](http://www.netlib.org/lapack95/)
* [MUMPS](http://mumps.enseeiht.fr/)
* [GNU Octave](https://www.gnu.org/software/octave/)

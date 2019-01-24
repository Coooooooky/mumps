[![Travis-CI Build Status](https://travis-ci.org/scivision/fortran-libs.svg)](https://travis-ci.org/scivision/fortran-libs)
[![Build status](https://ci.appveyor.com/api/projects/status/dyonair98wk9u5gv?svg=true)](https://ci.appveyor.com/project/scivision/mumps)
---

# MUMPS

http://mumps.enseeiht.fr/

## Build 
For convenience, we include build scripts that allow quickly switching compilers (e.g. gfortran, ifort).

* Intel `ifort`: `./build_intel.sh`
* GNU Gfortran: `./build_gnu_noMKL.sh`
* GNU Gfotran + Intel MKL: `./build_gnu_MKL.sh`

## Test libraries

A few simple demos / self-tests are included for use , and are run by:
```sh
cd tests/bin

cmake ..    # if using Intel compilers:  FC=mpiifort cmake ..

make

ctest -V
```

## prebuilt

Instead of compiling, it's often easier to:

* Ubuntu: `apt install libmumps-dev`
* CentOS: `yum install MUMPS-openmpi`

MUMPS is available for Linux, OSX and 
[Windows](http://mumps.enseeiht.fr/index.php?page=links).


#### OSX

[Reference](http://mumps.enseeiht.fr/index.php?page=links)

```sh
brew tap dpo/openblas
brew tap-pin dpo/openblas
brew options mumps
brew install mumps
```


[![Build Status](https://travis-ci.org/scivision/mumps.svg?branch=master)](https://travis-ci.org/scivision/mumps)
[![Build status](https://ci.appveyor.com/api/projects/status/dyonair98wk9u5gv?svg=true)](https://ci.appveyor.com/project/scivision/mumps)
---

# MUMPS

http://mumps.enseeiht.fr/

## Build

We have provided `build.py` for this project, that works like:

```sh
python build.py gcc
```

For Intel, load the compiler environment (set MKLROOT) first, like:

```sh
. ~/intel.sh

python build.py intel
```

Likewise, to build for GCC with MKL:


```sh
. ~/intel.sh

python build.py gcc
```



### Manual build

Meson &ge; 0.50 or CMake &ge; 3.13 can build MUMPS

```sh
meson build
ninja -C build

meson test -C build
```

or

```sh
cmake -B build -S .
cmake --build build -j
```

To fully specify libraries, do like:
```sh
FC=gfortran cmake .. -DSCALAPACK_ROOT=~/lib_gcc/scalapack -DMUMPS_ROOT=~/lib_gcc/mumps -DMPI_ROOT=~/lib_gcc/openmpi-3.1.3 -DLAPACK_ROOT=~/lib_gcc/lapack
```

## prebuilt

Instead of compiling, it's often easier to:

* Ubuntu: `apt install libmumps-dev`
* CentOS: `yum install MUMPS-openmpi`

MUMPS is available for Linux, OSX and
[Windows](http://mumps.enseeiht.fr/index.php?page=links).


### OSX

[Reference](http://mumps.enseeiht.fr/index.php?page=links)

```sh
brew tap dpo/openblas
brew install mumps
```

## Testing

In general, using MPI on Windows requires a username/password to access even the local network.
https://www.scivision.dev/intel-mpi-windows-bug

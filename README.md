[![Build Status](https://travis-ci.org/scivision/mumps.svg?branch=master)](https://travis-ci.org/scivision/mumps)
[![Build status](https://ci.appveyor.com/api/projects/status/dyonair98wk9u5gv?svg=true)](https://ci.appveyor.com/project/scivision/mumps)
---

# MUMPS

http://mumps.enseeiht.fr/

## Build

Meson or CMake can build MUMPS

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
SCALAPACK_ROOT=~/.local/scalapack-gcc8 MUMPS_ROOT=~/.local/mumps-gcc8 MPI_ROOT=~/.local/openmpi-3.1.3-gcc8/ LAPACK_ROOT=~/.local/lapack-gcc8 FC=gfortran-8  cmake ..
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
brew tap-pin dpo/openblas
brew options mumps
brew install mumps
```

## Testing

In general, using MPI on Windows requires a username/password to access even the local network.
https://www.scivision.dev/intel-mpi-windows-bug
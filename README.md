# Fortran Utilities

Related: [Fortran 2018 examples](https://github.com/scivision/fortran2018-examples)


## LAPACK95
To build 
[LAPACK95](http://www.netlib.org/lapack95/)
library with any Fortran compiler simply:
```sh
cd LAPACK95/
make double -C SRC 
```
which should create `lapack95.a` in `LAPACK95/`  with "double" precision (use "single" or other options described in tne README files under LAPACK95 and LAPACK95/SRC if complex etc. precision is needed).

## CMake
The `cmake/Modules` directory contains several `Find___.cmake` files useful for Fortran programs including:

* MKL
* SCALAPACK
* BLACS
* MPI
* LAPACK95
* MUMPS
* GNU Octave

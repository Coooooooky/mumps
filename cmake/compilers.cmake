cmake_policy(VERSION 3.13)
cmake_policy(SET CMP0076 NEW)


if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)
  if(WIN32)
    set(FFLAGS /4Yd)
  else()
    set(FFLAGS -implicitnone)
  endif()

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-mtune=native)
  set(FFLAGS -fimplicit-none)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang)

endif()

cmake_policy(SET CMP0074 NEW)

if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)

  if(CMAKE_BUILD_TYPE STREQUAL Debug)
     add_compile_options(-debug extended)
  endif()
  add_compile_options(-warn -traceback -check all -fp-stack-check)

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-mtune=native -fimplicit-none -Wall -Wpedantic -Wextra -Warray-bounds -fexceptions)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang) 
  add_compile_options(-Mallocatable=03)
endif()

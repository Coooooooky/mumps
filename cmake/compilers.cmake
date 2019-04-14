if(CMAKE_Fortran_COMPILER_ID STREQUAL Intel)

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL GNU)
  add_compile_options(-mtune=native -fimplicit-none)
elseif(CMAKE_Fortran_COMPILER_ID STREQUAL PGI)

elseif(CMAKE_Fortran_COMPILER_ID STREQUAL Flang)

endif()

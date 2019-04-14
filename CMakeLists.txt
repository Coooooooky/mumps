cmake_minimum_required(VERSION 3.12)
project(MUMPS
  LANGUAGES C Fortran
  VERSION 5.1.2
  HOMEPAGE_URL http://mumps.enseeiht.fr/)
enable_testing()

cmake_policy(SET CMP0076 NEW)

if(NOT DEFINED ARITH)
  set(ARITH d)
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)

set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/lib)

find_package(MPI REQUIRED COMPONENTS Fortran C)

find_package(SCALAPACK REQUIRED)

add_subdirectory(PORD)
add_subdirectory(src)

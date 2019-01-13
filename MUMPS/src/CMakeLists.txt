cmake_minimum_required(VERSION 3.12)
project(MUMPS C Fortran)

if(NOT DEFINED ARITH)
  set(ARITH d)
endif()

if(NOT DEFINED ORDERING)
  set(ORDERING PORD)
endif()

# FIXME: add option for Scotch, Metis
if(ORDERING STREQUAL PORD)
  add_compile_definitions(pord)
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../PORD/include)
  link_libraries(${CMAKE_CURRENT_SOURCE_DIR}/../PORD/lib)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/sources.cmake)

find_package(MPI REQUIRED COMPONENTS Fortran)
link_libraries(MPI::MPI_Fortran)

# -- mUMPS BUILD
add_library(mumps_common ${COMM_SRC})

add_library(${ARITH}mumps ${SRC})
target_include_directories(${ARITH}mumps PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../include)
add_dependencies(${ARITH}mumps mumps_common)

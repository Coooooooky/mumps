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
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../PORD ${CMAKE_CURRENT_BINARY_DIR}/lib)
  add_compile_definitions("pord")
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../PORD/include)
  link_libraries(pord)
endif()

find_package(MPI REQUIRED COMPONENTS Fortran C)
link_libraries(MPI::MPI_Fortran MPI::MPI_C)

# --- PORD


# -- mUMPS BUILD
include(${CMAKE_CURRENT_SOURCE_DIR}/sources.cmake)

add_library(mumps_common ${COMM_SRC})

add_library(${ARITH}mumps ${SRC})
target_include_directories(${ARITH}mumps PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../include)
add_dependencies(${ARITH}mumps mumps_common)

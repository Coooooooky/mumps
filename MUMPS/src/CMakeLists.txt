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
  set(OINC ${CMAKE_CURRENT_SOURCE_DIR}/../PORD/include)
endif()

include(${CMAKE_CURRENT_SOURCE_DIR}/sources.cmake)

find_package(MPI REQUIRED COMPONENTS Fortran)

add_library(mumps_common ${COMM_SRC})
target_link_libraries(mumps_common PRIVATE MPI::MPI_Fortran)
target_include_directories(mumps_common PRIVATE ${OINC})

add_library(${ARITH}mumps ${SRC})
target_include_directories(${ARITH}mumps PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../include)
target_link_libraries(${ARITH}mumps PRIVATE MPI::MPI_Fortran)
add_dependencies(${ARITH}mumps mumps_common)

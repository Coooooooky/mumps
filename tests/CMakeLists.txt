# This test requires special configuration to work on Windows, as does any program using MPI:
# https://www.scivision.dev/intel-mpi-windows-bug
cmake_minimum_required(VERSION 3.12)
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()
project(FortranLibsDemo C Fortran)
enable_testing()

get_directory_property(hasParent PARENT_DIRECTORY)
if(NOT hasParent)
  list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/Modules/)
  include(${CMAKE_CURRENT_SOURCE_DIR}/../cmake/compilers.cmake)
endif()

find_package(MPI REQUIRED COMPONENTS Fortran)
find_package(LAPACK REQUIRED)
find_package(SCALAPACK REQUIRED)

if(NOT DEFINED MUMPS_ROOT)
  set(MUMPS_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../)
endif()
find_package(MUMPS REQUIRED COMPONENTS d)

add_executable(mumpscfg test_mumps.f90)
target_link_libraries(mumpscfg PRIVATE ${MUMPS_LIBRARIES} ${SCALAPACK_LIBRARIES} ${LAPACK_LIBRARIES} MPI::MPI_Fortran)
target_include_directories(mumpscfg PRIVATE ${MUMPS_INCLUDE_DIRS})

add_test(NAME MumpsCfg
  COMMAND ${MPIEXEC_EXECUTABLE} ${MPIEXEC_NUMPROC_FLAG} ${MPIEXEC_MAX_NUMPROCS} $<TARGET_FILE:mumpscfg>)
set_tests_properties(MumpsCfg PROPERTIES TIMEOUT 5)
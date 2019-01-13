cmake_minimum_required (VERSION 3.12)
project(FortranLibsDemo Fortran)
enable_testing()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../cmake/Modules/)

include(../cmake/compilers.cmake)

find_package(MPI REQUIRED COMPONENTS Fortran)

if(NOT MUMPS_ROOT)
  set(MUMPS_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/../MUMPS)
endif()
find_package(MUMPS REQUIRED COMPONENTS d)

message(STATUS MUMPS_INCLUDE_DIRS  ${MUMPS_INCLUDE_DIRS})

add_executable(mumpscfg test_mumps.f90)
target_link_libraries(mumpscfg PRIVATE ${MUMPS_LIBRARIES} MPI::MPI_Fortran)
target_include_directories(mumpscfg PRIVATE ${MUMPS_INCLUDE_DIRS})

add_test(NAME MumpsCfg COMMAND mumpscfg)

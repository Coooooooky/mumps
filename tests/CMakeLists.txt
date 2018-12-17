cmake_minimum_required (VERSION 3.12)
project(FortranLibsDemo Fortran)
enable_testing()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../cmake/Modules/)

include(../cmake/compilers.cmake)

find_package(MPI REQUIRED COMPONENTS Fortran)

set(MUMPS_ROOT ../MUMPS)
find_package(MUMPS REQUIRED COMPONENTS d)

add_executable(mumpscfg test_mumps.f90)
target_link_libraries(mumpscfg PRIVATE ${MUMPS_LIBRARIES} MPI::MPI_Fortran)
target_include_directories(mumpscfg PRIVATE ${MUMPS_INCLUDE_DIRS})

add_test(NAME MumpsCfg COMMAND mumpscfg)

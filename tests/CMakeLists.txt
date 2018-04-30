cmake_minimum_required (VERSION 3.0)
project(FortranLibsDemo Fortran C)
enable_testing()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/../cmake/Modules/)

if(CMAKE_BUILD_TYPE STREQUAL Debug)
  add_compile_options(-g -O0)
else()
  add_compile_options(-O3)
endif()

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  # -r8  after literals are fixed to "e" or "wp"
    if(CMAKE_BUILD_TYPE STREQUAL Debug)
     add_compile_options(-debug extended)
  endif()
  add_compile_options(-warn -traceback -check all -fp-stack-check)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
  # -fdefault-real-8  after literals are fixed to "e" or "wp"
  add_compile_options(-mtune=native -fimplicit-none -Wall -Wpedantic -Wextra -Warray-bounds -fexceptions -fbacktrace)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)
  add_compile_options(-Mallocatable=03)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang) 
  add_compile_options(-Mallocatable=03)
endif()

# --- LAPACK 95
set(LAPACK95_ROOT ../LAPACK95)
find_package(LAPACK95 REQUIRED)

add_executable(lp95 assert.f90)
target_link_libraries(lp95 PRIVATE ${LAPACK95_LIBRARIES})
target_include_directories(lp95 PRIVATE ${LAPACK95_INCLUDE_DIRS})

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  target_sources(lp95 PRIVATE DemoLapack95_MKL.f90)
else()
  target_sources(lp95 PRIVATE DemoLapack95.f90)
endif()

add_test(NAME Lapack95 COMMAND lp95)

# --- MUMPS
# making MUMPS optional since MacOS Travis-CI takes 10 minutes to brew install mumps.
set(METIS_ROOT ../metis)
set(Scotch_ROOT ../scotch)
set(MUMPS_ROOT ../MUMPS)
find_package(MUMPS)

if(MUMPS_FOUND)
  include_directories(${MUMPS_INCLUDE_DIRS})

  add_executable(mumpscfg test_mumps.f90)
  target_link_libraries(mumpscfg PRIVATE ${MUMPS_LIBRARIES})

  add_test(NAME MumpsCfg COMMAND mumpscfg)
endif()

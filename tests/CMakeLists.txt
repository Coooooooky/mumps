cmake_minimum_required (VERSION 3.3)
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
  add_compile_options(-mtune=native -fimplicit-none -Wall -Wpedantic -Wextra -Warray-bounds -fexceptions)
elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL PGI)

elseif(${CMAKE_Fortran_COMPILER_ID} STREQUAL Flang) 
  add_compile_options(-Mallocatable=03)
endif()


# --- MUMPS
# making MUMPS optional since MacOS Travis-CI takes 10 minutes to brew install mumps.
set(MUMPS_ROOT ../MUMPS)
find_package(MUMPS COMPONENTS d)

if(MUMPS_FOUND)
  add_executable(mumpscfg test_mumps.f90)
  target_link_libraries(mumpscfg PRIVATE ${MUMPS_LIBRARIES})
  target_include_directories(mumpscfg PRIVATE ${MUMPS_INCLUDE_DIRS})

  add_test(NAME MumpsCfg COMMAND mumpscfg)
endif()

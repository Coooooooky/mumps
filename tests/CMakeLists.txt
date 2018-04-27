cmake_minimum_required (VERSION 3.0)
project(FortranLibsDemo Fortran C)
enable_testing()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../cmake/Modules/")

add_compile_options(-g -fimplicit-none -mtune=native)

# --- LAPACK 95
set(LAPACK95_ROOT ../LAPACK95)
find_package(LAPACK95 REQUIRED)

add_executable(lp95 assert.f90 DemoLapack95.f90)
target_link_libraries(lp95 PRIVATE ${LAPACK95_LIBRARIES})
target_include_directories(lp95 PRIVATE ${LAPACK95_INCLUDE_DIRS})

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

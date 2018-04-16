# - Try to find Netlib LAPACK95 library
# https://cmake.org/cmake/help/v3.11/manual/cmake-developer.7.html#find-modules

#.rst:
# FindLAPACK95
# -------
# Michael Hirsch, Ph.D.
#
# Finds the LAPACK95 static library  (need the .a/.lib specified or CMake won't find it, unlike .so/.dll that can be omitted)
# tested with Netlib LAPACK95, minor tweaks for others may be necessary--let me know.
#
# This will define the following variables::
#
#   LAPACK95_FOUND    - True if the system has the LAPACK95 library
#   LAPACK95_VERSION  - The version of the LAPACK95 library which was found

find_package(PkgConfig)
pkg_check_modules(PC_LAPACK95 QUIET LAPACK95)


find_library(LAPACK95_LIBRARY
             NAMES lapack95.a mkl_lapack95_lp64.a mkl_lapack95_lp64.lib
             PATHS ${PC_LAPACK95_LIBRARY_DIRS}
             HINTS ${LAPACK95_ROOT})

find_path(LAPACK95_INCLUDE_DIR
          NAMES f95_lapack.mod
          PATHS ${PC_LAPACK95_INCLUDE_DIRS}
          PATH_SUFFIXES lapack95_modules
          HINTS ${LAPACK95_ROOT})

set(LAPACK95_VERSION ${PC_LAPACK95_VERSION})


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LAPACK95
    FOUND_VAR LAPACK95_FOUND
    REQUIRED_VARS LAPACK95_LIBRARY LAPACK95_INCLUDE_DIR
    VERSION_VAR LAPACK95_VERSION)

if(LAPACK95_FOUND)
  set(LAPACK95_LIBRARIES ${LAPACK95_LIBRARY})
  set(LAPACK95_INCLUDE_DIRS ${LAPACK95_INCLUDE_DIR})
  set(LAPACK95_DEFINITIONS  ${PC_LAPACK95_CFLAGS_OTHER})
endif()


mark_as_advanced(LAPACK95_INCLUDE_DIR LAPACK95_LIBRARY)


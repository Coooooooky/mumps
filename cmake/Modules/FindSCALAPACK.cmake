# https://github.com/certik/hermes/blob/master/hermes_common/cmake/FindSCALAPACK.cmake
# ScaLAPACK and BLACS

find_package(PkgConfig)
pkg_check_modules(PC_SCALAPACK QUIET SCALAPACK)


find_library(SCALAPACK_LIBRARY
             NAMES scalapack scalapack-pvm scalapack-mpi scalapack-mpich scalapack-mpich2 scalapack-openmpi scalapack-lam
             PATHS ${PC_SCALAPACK_LIBRARY_DIRS}
             HINTS ${SCALAPACK_ROOT})

set(SCALAPACK_VERSION ${PC_SCALAPACK_VERSION})

# =====================================
pkg_check_modules(PC_BLACS QUIET BLACS)

find_library(BLACS_LIBRARY
            NAMES blacs blacs-pvm blacs-mpi blacsF77init-openmpi blacsCinit-openmpi blacs-mpich blacs-mpich2 blacs-openmpi blacs-lam
            PATHS ${PC_BLACS_LIBRARY_DIRS}
            HINTS ${BLACS_ROOT})

set(BLACS_VERSION ${PC_BLACS_VERSION})

#=================================================
# Report the found libraries, quit with fatal error if any required library has not been found.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SCALAPACK
    FOUND_VAR SCALAPACK_FOUND
    REQUIRED_VARS SCALAPACK_LIBRARY BLACS_LIBRARY
    VERSION_VAR SCALAPACK_VERSION)

if(SCALAPACK_FOUND)
  set(SCALAPACK_LIBRARIES ${SCALAPACK_LIBRARY} ${BLACS_LIBRARY})
  set(SCALAPACK_DEFINITIONS  ${PC_SCALAPACK_CFLAGS_OTHER} ${PC_BLACS_CFLAGS_OTHER})
endif()

mark_as_advanced(SCALAPACK_LIBRARY BLACS_LIBRARY)

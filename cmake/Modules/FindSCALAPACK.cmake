# https://github.com/certik/hermes/blob/master/hermes_common/cmake/FindSCALAPACK.cmake
# ScaLAPACK and BLACS

unset(SCALAPACK_LIBRARY)

if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  foreach(alib mkl_scalapack_lp64 mkl_intel_lp64 mkl_intel_thread mkl_core mkl_blacs_intelmpi_lp64 iomp5) 
    find_library(blib
             NAMES ${alib}
             PATHS $ENV{MKLROOT}/lib
                   $ENV{MKLROOT}/lib/intel64
                   $ENV{INTEL}/mkl/lib/intel64
             NO_DEFAULT_PATH)
    list(APPEND SCALAPACK_LIBRARY ${blib})
  endforeach()
  list(APPEND SCALAPACK_LIBRARY pthread dl m)
else()
  find_package(PkgConfig)
  pkg_check_modules(PC_SCALAPACK QUIET SCALAPACK)


  find_library(SCALAPACK_LIBRARY
               NAMES scalapack scalapack-pvm scalapack-mpi scalapack-mpich scalapack-mpich2 scalapack-openmpi scalapack-lam
               PATHS ${PC_SCALAPACK_LIBRARY_DIRS}
               PATH_SUFFIXES lib
               HINTS ${SCALAPACK_ROOT})

  set(SCALAPACK_VERSION ${PC_SCALAPACK_VERSION})

  # ======== BLACS
  # Note: the static compilation of Scalapack with CMake means that BLACS can be entirely within libscalapack.a
  pkg_check_modules(PC_BLACS QUIET BLACS)

  find_library(BLACS_LIBRARY
              NAMES blacs blacs-pvm blacs-mpi blacs-openmpi blacsF77init-openmpi blacs-mpich blacs-mpich2 blacs-lam
              PATHS ${PC_BLACS_LIBRARY_DIRS}
              PATH_SUFFIXES lib
              HINTS ${BLACS_ROOT})

  if(BLACS_LIBRARY)
    set(BLACS_FOUND TRUE)
    find_library(BLACS_OPENMPI 
                NAMES blacs-openmpi 
                PATHS ${PC_BLACS_LIBRARY_DIRS}
                PATH_SUFFIXES lib
                HINTS  ${BLACS_ROOT})
    find_library(BLACS_CINIT 
                NAMES blacsCinit-openmpi
                PATHS ${PC_BLACS_LIBRARY_DIRS}
                PATH_SUFFIXES lib
                HINTS  ${BLACS_ROOT})
    list(APPEND BLACS_LIBRARY ${BLACS_OPENMPI} ${BLACS_CINIT})

    set(BLACS_VERSION ${PC_BLACS_VERSION})
  endif()
  set(SCALAPACK_DEFINITIONS  ${PC_SCALAPACK_CFLAGS_OTHER})
endif()
#=================================================
# Report the found libraries, quit with fatal error if any required library has not been found.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(SCALAPACK
    FOUND_VAR SCALAPACK_FOUND
    REQUIRED_VARS SCALAPACK_LIBRARY   # don't put BLACS_LIBRARY REQUIRED_VARS because it might be in libscalapack.a
    VERSION_VAR SCALAPACK_VERSION)

if(SCALAPACK_FOUND)
  set(SCALAPACK_LIBRARIES ${SCALAPACK_LIBRARY})
  if(BLACS_FOUND)
    list(APPEND SCALAPACK_LIBRARIES ${BLACS_LIBRARY})
  endif()
endif()

mark_as_advanced(SCALAPACK_LIBRARY BLACS_LIBRARY)

################################################################################
#
# \file      cmake/FindMKL.cmake
# \author    J. Bakosi
# \copyright 2012-2015, Jozsef Bakosi, 2016, Los Alamos National Security, LLC.
# \brief     Find the Math Kernel Library from Intel
# \date      Thu 26 Jan 2017 02:05:50 PM MST
#
################################################################################

# Find the Math Kernel Library from Intel
#
#  MKL_FOUND - System has MKL
#  MKL_INCLUDE_DIRS - MKL include files directories
#  MKL_LIBRARIES - The MKL libraries
#  MKL_INTERFACE_LIBRARY - MKL interface library
#  MKL_SEQUENTIAL_LAYER_LIBRARY - MKL sequential layer library
#  MKL_CORE_LIBRARY - MKL core library
#
#  The environment variables MKLROOT and INTEL are used to find the library.
#  Everything else is ignored. If MKL is found "-DMKL_LP64" is added to
#  CMAKE_C_FLAGS and CMAKE_CXX_FLAGS.
#
#  Example usage:
#
#  find_package(MKL)
#  if(MKL_FOUND)
#    target_link_libraries(TARGET ${MKL_LIBRARIES})
#  endif()

# If already in cache, be silent
if (MKL_INCLUDE_DIRS AND MKL_LIBRARIES AND MKL_INTERFACE_LIBRARY AND
    MKL_SEQUENTIAL_LAYER_LIBRARY AND MKL_CORE_LIBRARY)
  set (MKL_FIND_QUIETLY TRUE)
endif()

# MPI
if(${CMAKE_Fortran_COMPILER_ID} STREQUAL Intel)
  unset(MPI_Fortran_LIBRARIES)
  unset(MPI_Fortran_INCLUDE_PATH)
  if(MPI IN_LIST MKL_FIND_COMPONENTS)
#    message(STATUS "Trying to find Intel MKL MPI libraries under: "  $ENV{MKLROOT})
    find_path(MPI_Fortran_INCLUDE_PATH 
              NAMES mpi.h mpif.h
              HINTS $ENV{MKLROOT}/../mpi/intel64/include)
              
    FOREACH(comp mkl_intel_lp64 mkl_intel_thread mkl_core iomp5)
      find_library(MKL_${comp}_lib
              NAMES ${comp}
              PATHS $ENV{MKLROOT}/../compiler/lib/intel64_lin
                    $ENV{MKLROOT}/lib/intel64           
              HINTS ${MKLROOT})
  
      if(MKL_${comp}_lib)
        list(APPEND MPI_Fortran_LIBRARIES ${MKL_${comp}_lib})
        mark_as_advanced(MKL_${comp}_lib)
      else()
          message(FATAL_ERROR "did not find " ${MKL_${comp}_lib})
      endif()
    ENDFOREACH()
     
    list(APPEND MPI_Fortran_LIBRARIES pthread dl m)
  endif()
  
  message(STATUS "Intel MKL MPI libraries: "  ${MPI_Fortran_LIBRARIES})
endif()

if(NOT BUILD_SHARED_LIBS)
  if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
    set(INT_LIB "libmkl_gf_lp64.a")
  else()
    set(INT_LIB "libmkl_intel_lp64.a")
  endif()
  set(SEQ_LIB "libmkl_sequential.a")
  set(THR_LIB "libmkl_intel_thread.a")
  set(COR_LIB "libmkl_core.a")
else()
  if(${CMAKE_Fortran_COMPILER_ID} STREQUAL GNU)
    set(INT_LIB "mkl_gf_lp64")
  else()
    set(INT_LIB "mkl_intel_lp64")
  endif()
  set(SEQ_LIB "mkl_sequential")
  set(THR_LIB "mkl_intel_thread")
  set(COR_LIB "mkl_core")
endif()

# include

find_path(MKL_INCLUDE_DIR 
          NAMES mkl.h 
          HINTS $ENV{MKLROOT}/include)


# libs
find_library(MKL_INTERFACE_LIBRARY
             NAMES ${INT_LIB}
             PATHS $ENV{MKLROOT}/lib
                   $ENV{MKLROOT}/lib/intel64
                   $ENV{INTEL}/mkl/lib/intel64
             NO_DEFAULT_PATH)

find_library(MKL_SEQUENTIAL_LAYER_LIBRARY
             NAMES ${SEQ_LIB}
             PATHS $ENV{MKLROOT}/lib
                   $ENV{MKLROOT}/lib/intel64
                   $ENV{INTEL}/mkl/lib/intel64
             NO_DEFAULT_PATH)

find_library(MKL_CORE_LIBRARY
             NAMES ${COR_LIB}
             PATHS $ENV{MKLROOT}/lib
                   $ENV{MKLROOT}/lib/intel64
                   $ENV{INTEL}/mkl/lib/intel64
             NO_DEFAULT_PATH)

set(MKL_INCLUDE_DIRS ${MKL_INCLUDE_DIR})
set(MKL_LIBRARIES ${MKL_INTERFACE_LIBRARY} ${MKL_SEQUENTIAL_LAYER_LIBRARY} ${MKL_CORE_LIBRARY})

if (MKL_INCLUDE_DIR AND
    MKL_INTERFACE_LIBRARY AND
    MKL_SEQUENTIAL_LAYER_LIBRARY AND
    MKL_CORE_LIBRARY)

    if (NOT DEFINED ENV{CRAY_PRGENVPGI} AND
        NOT DEFINED ENV{CRAY_PRGENVGNU} AND
        NOT DEFINED ENV{CRAY_PRGENVCRAY} AND
        NOT DEFINED ENV{CRAY_PRGENVINTEL})
      set(ABI "-m64")
    endif()

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DMKL_LP64 ${ABI}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMKL_LP64 ${ABI}")

else()

  set(MKL_INCLUDE_DIRS "")
  set(MKL_LIBRARIES "")
  set(MKL_INTERFACE_LIBRARY "")
  set(MKL_SEQUENTIAL_LAYER_LIBRARY "")
  set(MKL_CORE_LIBRARY "")

endif()

# Handle the QUIETLY and REQUIRED arguments and set MKL_FOUND to TRUE if
# all listed variables are TRUE.
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(MKL DEFAULT_MSG 
                MKL_LIBRARIES 
                MKL_INCLUDE_DIRS 
                MKL_INTERFACE_LIBRARY 
                MKL_SEQUENTIAL_LAYER_LIBRARY 
                MKL_CORE_LIBRARY
                MPI_Fortran_LIBRARIES
                MPI_Fortran_INCLUDE_PATH)

MARK_AS_ADVANCED(MKL_INCLUDE_DIRS MKL_LIBRARIES 
                MKL_INTERFACE_LIBRARY MKL_SEQUENTIAL_LAYER_LIBRARY MKL_CORE_LIBRARY)

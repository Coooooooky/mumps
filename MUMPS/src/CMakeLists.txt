cmake_minimum_required(VERSION 3.12)
project(MUMPS 
  LANGUAGES C Fortran
  VERSION 5.1.2
  HOMEPAGE_URL http://mumps.enseeiht.fr/)

if(NOT DEFINED ARITH)
  set(ARITH d)
endif()

if(NOT DEFINED ORDERING)
  set(ORDERING PORD)
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../../cmake/Modules)

set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../include)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../lib)

# FIXME: add option for Scotch, Metis
if(ORDERING STREQUAL PORD)
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/../PORD ${CMAKE_CURRENT_BINARY_DIR}/lib)
  add_compile_definitions("pord")
  include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../PORD/include)
  link_libraries(pord)
endif()

find_package(MPI REQUIRED COMPONENTS Fortran C)
link_libraries(MPI::MPI_Fortran MPI::MPI_C)

find_package(SCALAPACK REQUIRED)


# -- mUMPS BUILD
include(${CMAKE_CURRENT_SOURCE_DIR}/sources.cmake)

add_library(mumps_common ${COMM_SRC})
target_link_libraries(mumps_common ${SCALAPACK_LIBRARIES})

add_library(cint ${CINT_SRC}) # don't install
target_compile_definitions(cint PRIVATE MUMPS_ARITH=MUMPS_ARITH_${ARITH})

add_library(${ARITH}mumps ${SRC})
target_include_directories(${ARITH}mumps PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../include)
target_link_libraries(${ARITH}mumps cint ${SCALAPACK_LIBRARIES})
add_dependencies(${ARITH}mumps mumps_common)

# --- install
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(UNIX)
    set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/.local/mumps-${PROJECT_VERSION}" CACHE PATH "..." FORCE)
  endif()
endif()

install(TARGETS pord mumps_common ${ARITH}mumps
  ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX})

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/../include  # no trailing slash!
  DESTINATION ${CMAKE_INSTALL_PREFIX})

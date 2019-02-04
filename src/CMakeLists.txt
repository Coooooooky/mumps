add_compile_definitions("Add_")


# -- mUMPS BUILD
include(${CMAKE_CURRENT_SOURCE_DIR}/sources.cmake)

add_library(mumps_common ${IOC_SRC} ${COMM_SRC})
target_link_libraries(mumps_common ${SCALAPACK_LIBRARIES} MPI::MPI_Fortran MPI::MPI_C)
target_link_libraries(mumps_common pord)


add_library(${ARITH}mumps ${CINT_SRC} ${SRC})
target_compile_definitions(${ARITH}mumps PRIVATE MUMPS_ARITH=MUMPS_ARITH_${ARITH})
target_include_directories(${ARITH}mumps PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_link_libraries(${ARITH}mumps 
#${ARITH}mumps_load ${ARITH}mumps_ooc ${ARITH}ana_aux_par
 ${SCALAPACK_LIBRARIES} MPI::MPI_Fortran MPI::MPI_C)

add_dependencies(${ARITH}mumps mumps_common)

# --- install
if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
  if(UNIX)
    set(CMAKE_INSTALL_PREFIX "$ENV{HOME}/.local/mumps-${PROJECT_VERSION}" CACHE PATH "..." FORCE)
  endif()
endif()

install(TARGETS pord mumps_common ${ARITH}mumps
  ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX})

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include  # no trailing slash!
  DESTINATION ${CMAKE_INSTALL_PREFIX})


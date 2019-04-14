
set(PORDINT_SRC mumps_pord.c)

set(METISINT_SRC mumps_metis.c mumps_metis64.c mumps_metis_int.c)

set(SCOTCHINT_SRC mumps_scotch.c mumps_scotch64.c mumps_scotch_int.c)

# Dependencies between modules:
#add_library(${ARITH}mumps_load ${ARITH}mumps_comm_buffer.F ${ARITH}mumps_struc_def.F fac_future_niv2_mod.F)
#target_link_libraries(${ARITH}mumps_load MPI::MPI_Fortran)

#add_library(${ARITH}mumps_ooc ${ARITH}mumps_struc_def.F  ${ARITH}mumps_ooc_buffer.F mumps_ooc_common.F)

#add_library(${ARITH}ana_aux_par ${ARITH}mumps_struc_def.F mumps_memory_mod.F ana_orderings_wrappers_m.F)

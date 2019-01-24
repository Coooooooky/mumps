
set(COMM_SRC lr_common.F ana_omp_m.F ana_orderings_wrappers_m.F mumps_memory_mod.F mumps_static_mapping.F mumps_sol_es.F fac_future_niv2_mod.F mumps_comm_ibcast.F mumps_ooc_common.F double_linked_list.F fac_asm_build_sort_index_m.F fac_asm_build_sort_index_ELT_m.F omp_tps_common_m.F mumps_l0_omp_m.F front_data_mgt_m.F fac_maprow_data_m.F fac_descband_data_m.F fac_ibct_data_m.F
ana_orderings.F ana_AMDMF.F bcast_errors.F estim_flops.F mumps_type_size.F  mumps_type2_blocking.F  mumps_version.F  tools_common.F  mumps_print_defined.F
mumps_common.c mumps_size.c mumps_io_err.c ana_set_ordering.F mumps_numa.c  mumps_thread.c mumps_save_restore_C.c)

set(IOC_SRC mumps_io.c mumps_io_basic.c mumps_io_thread.c)

set(PORDINT_SRC mumps_pord.c)

set(METISINT_SRC mumps_metis.c mumps_metis64.c mumps_metis_int.c)

set(SCOTCHINT_SRC mumps_scotch.c mumps_scotch64.c mumps_scotch_int.c)

set(SRC  ${ARITH}ana_aux_par.F  ${ARITH}ana_lr.F ${ARITH}fac_asm_master_m.F ${ARITH}fac_asm_master_ELT_m.F ${ARITH}omp_tps_m.F ${ARITH}mumps_comm_buffer.F ${ARITH}mumps_load.F ${ARITH}mumps_lr_data_m.F ${ARITH}mumps_ooc_buffer.F ${ARITH}mumps_ooc.F ${ARITH}mumps_struc_def.F ${ARITH}static_ptr_m.F ${ARITH}lr_core.F ${ARITH}lr_type.F ${ARITH}lr_stats.F ${ARITH}fac_lr.F ${ARITH}fac_omp_m.F ${ARITH}fac_par_m.F ${ARITH}fac_front_LU_type1.F ${ARITH}fac_front_LU_type2.F ${ARITH}fac_front_LDLT_type1.F ${ARITH}fac_front_LDLT_type2.F ${ARITH}fac_front_aux.F ${ARITH}fac_front_type2_aux.F ${ARITH}mumps_save_restore_files.F ${ARITH}mumps_save_restore.F
${ARITH}ini_driver.F ${ARITH}ana_driver.F ${ARITH}fac_driver.F ${ARITH}sol_driver.F ${ARITH}end_driver.F ${ARITH}ana_aux_ELT.F ${ARITH}ana_aux.F ${ARITH}ana_dist_m.F ${ARITH}ana_LDLT_preprocess.F ${ARITH}ana_reordertree.F ${ARITH}arrowheads.F ${ARITH}bcast_int.F ${ARITH}fac_asm_ELT.F ${ARITH}fac_asm.F ${ARITH}fac_b.F ${ARITH}fac_distrib_distentry.F ${ARITH}fac_distrib_ELT.F ${ARITH}fac_lastrtnelind.F ${ARITH}fac_mem_alloc_cb.F ${ARITH}fac_mem_compress_cb.F ${ARITH}fac_mem_free_block_cb.F ${ARITH}fac_mem_stack_aux.F ${ARITH}fac_mem_stack.F ${ARITH}fac_process_band.F ${ARITH}fac_process_blfac_slave.F ${ARITH}fac_process_blocfacto_LDLT.F ${ARITH}fac_process_blocfacto.F ${ARITH}fac_process_bf.F ${ARITH}fac_process_end_facto_slave.F ${ARITH}fac_process_contrib_type1.F ${ARITH}fac_process_contrib_type2.F ${ARITH}fac_process_contrib_type3.F ${ARITH}fac_process_maprow.F ${ARITH}fac_process_master2.F ${ARITH}fac_process_message.F ${ARITH}fac_process_root2slave.F ${ARITH}fac_process_root2son.F ${ARITH}fac_process_rtnelind.F ${ARITH}fac_root_parallel.F ${ARITH}fac_scalings.F ${ARITH}fac_determinant.F ${ARITH}fac_scalings_simScaleAbs.F ${ARITH}fac_scalings_simScale_util.F ${ARITH}fac_sol_pool.F ${ARITH}fac_type3_symmetrize.F ${ARITH}ini_defaults.F
${ARITH}mumps_driver.F ${ARITH}mumps_f77.F ${ARITH}mumps_iXamax.F ${ARITH}ana_mtrans.F ${ARITH}ooc_panel_piv.F ${ARITH}rank_revealing.F ${ARITH}sol_aux.F ${ARITH}sol_bwd_aux.F ${ARITH}sol_bwd.F ${ARITH}sol_c.F ${ARITH}sol_fwd_aux.F ${ARITH}sol_fwd.F ${ARITH}sol_matvec.F ${ARITH}sol_root_parallel.F ${ARITH}tools.F ${ARITH}type3_root.F
fac_future_niv2_mod.F mumps_ooc_common.F mumps_memory_mod.F ana_orderings_wrappers_m.F mumps_comm_ibcast.F omp_tps_common_m.F fac_ibct_data_m.F fac_asm_build_sort_index_m.F fac_asm_build_sort_index_ELT_m.F mumps_l0_omp_m.F lr_common.F)

set(CINT_SRC mumps_c.c)

# Dependencies between modules:
#add_library(${ARITH}mumps_load ${ARITH}mumps_comm_buffer.F ${ARITH}mumps_struc_def.F fac_future_niv2_mod.F)
#target_link_libraries(${ARITH}mumps_load MPI::MPI_Fortran)

#add_library(${ARITH}mumps_ooc ${ARITH}mumps_struc_def.F  ${ARITH}mumps_ooc_buffer.F mumps_ooc_common.F)

#add_library(${ARITH}ana_aux_par ${ARITH}mumps_struc_def.F mumps_memory_mod.F ana_orderings_wrappers_m.F)

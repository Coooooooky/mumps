program test_mumps
use, intrinsic:: iso_fortran_env, only: output_unit, error_unit

implicit none

include 'dmumps_struc.h'  ! per MUMPS manual

type (DMUMPS_STRUC) mumps_par

mumps_par%icntl(1) = error_unit  ! error messages
mumps_par%icntl(2) = output_unit !  diagnosic, statistics, and warning messages
mumps_par%icntl(3) = output_unit ! global info, for the host (myid==0)
mumps_par%icntl(4) = 1           ! default is 2, this reduces verbosity

print '(40I2)',mumps_par%icntl

call DMUMPS(mumps_par)

if (.not. all(mumps_par%icntl(:4) == [0, 6, 6, 1])) error stop 'MUMPS parameters not correctly set'

end program

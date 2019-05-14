
lapack = dependency('lapack')
blas = dependency('blas')

mumps_lib = fc.find_library('dmumps', dirs : meson.build_root())

mumpscfg = executable('mumpscfg', 'test_mumps.f90',
  dependencies : [blas, lapack, scalapack, mumps_lib, mpif],
  include_directories : '../include')

test('Mumps Config', mumpscfg)

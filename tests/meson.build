
lapack = dependency('lapack')
blas = dependency('blas')

libmumps = fc.find_library('dmumps', dir : meson.build_root())
mumpscfg = executable('mumpscfg', 'test_mumps.f90',
  dependencies : [blas, lapack, scalapack, libmumps, mpif],
  include_directories : '../include')
test('MumpsCfg', mumpscfg)

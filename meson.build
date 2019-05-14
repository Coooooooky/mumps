project('MUMPS', 'c', 'fortran',
  version : '5.1.2',
  default_options : ['default_library=static'])

arith = 'd'
ordering = 'PORD'

fc = meson.get_compiler('fortran')

mpic = dependency('mpi', language : 'c')
mpif = dependency('mpi', language : 'fortran')

scalapack = dependency('scalapack')

subdir('PORD')

subdir('src')

subdir('tests')

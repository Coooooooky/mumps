cmake_minimum_required(VERSION 3.0)
project(PORD C)

add_library(pord lib/graph.c lib/gbipart.c lib/gbisect.c lib/ddcreate.c lib/ddbisect.c lib/nestdiss.c lib/multisector.c lib/gelim.c lib/bucket.c lib/tree.c lib/symbfac.c lib/interface.c lib/sort.c lib/minpriority.c)
target_include_directories(pord PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

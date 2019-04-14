cmake_minimum_required(VERSION 3.13)
project(PORD C)

add_library(pord)
target_include_directories(pord PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

add_subdirectory(lib)
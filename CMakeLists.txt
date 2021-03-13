cmake_minimum_required(VERSION 3.0)
set(CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH}" "${CMAKE_CURRENT_LIST_DIR}/cmake/modules")

# register D support
include(EnableD)

project(hello D C CXX)
include(ProjectSetup)

add_subdirectory(libs)

add_subdirectory(src)
add_subdirectory(lib)

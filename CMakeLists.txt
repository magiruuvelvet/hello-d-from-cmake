cmake_minimum_required(VERSION 3.0)

project(hello D CXX)

add_executable(hello "hello.d" "func.d" "interop.d" "interop.cpp")

# required for module imports
include_directories(hello ${PROJECT_SOURCE_DIR})

target_link_libraries(hello "c++")

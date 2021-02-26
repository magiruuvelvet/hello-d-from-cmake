cmake_minimum_required(VERSION 3.0)

project(hello D C CXX)

add_executable(hello
    hello.d
    func.d
    interop.d
    interop.cpp
    interop2.d
    interop2_c.c
)

# required for module imports
include_directories(hello ${PROJECT_SOURCE_DIR})

target_link_libraries(hello "c++")

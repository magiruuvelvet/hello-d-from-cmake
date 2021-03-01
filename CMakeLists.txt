cmake_minimum_required(VERSION 3.0)

project(hello D C CXX)

add_library(hellolib STATIC
    interop.cpp
    interop2_c.c
)
target_compile_options(hellolib PRIVATE "-fPIC")

add_executable(hello
    hello.d
    func.d
    interop.d
    interop2.d
    Class.d
    Template.d
    Interface.d
)

# required for module imports
include_directories(hello PRIVATE ${PROJECT_SOURCE_DIR})

#target_compile_options(hello PRIVATE "--relocation-model=pic")

target_link_libraries(hello PUBLIC "c++" PRIVATE hellolib)

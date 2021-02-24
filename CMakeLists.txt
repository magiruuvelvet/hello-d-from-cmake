cmake_minimum_required(VERSION 3.0)

project(hello D)

add_executable(hello "hello.d" "func.d")

# required for module imports
include_directories(hello ${PROJECT_SOURCE_DIR})

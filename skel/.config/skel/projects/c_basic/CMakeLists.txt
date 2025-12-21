cmake_minimum_required(VERSION 4.2.0)

project({{name}} C)

set(CMAKE_C_COMPILER clang)
add_compile_options(
    -std=c23
    -g
    -pedantic
    -Wall
    -Wextra
    -Wconversion
    -Werror=incompatible-pointer-types
)

file(GLOB_RECURSE sources CONFIGURE_DEPENDS ./src/*.c)
add_executable({{name}} ${sources})
target_include_directories({{name}} PRIVATE ${PROJECT_SOURCE_DIR})

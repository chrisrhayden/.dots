cmake_minimum_required(VERSION 4.2.1)

project(okshell LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick)

set(sources src/search.cpp src/fzy.cpp)

add_compile_options(
    -pedantic
    -Wall
    -Wextra
    -Wconversion
    -Werror=incompatible-pointer-types
    -O3
)

qt_standard_project_setup(REQUIRES 6.10)

qt_add_qml_module(okshell
    URI build
    SOURCES
        ${sources}
)

target_include_directories(okshell PRIVATE src)
target_link_libraries(okshell PRIVATE Qt6::Core Qt6::Quick)

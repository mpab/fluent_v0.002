project(fluent CXX)

if (MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /EHsc")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif()

cmake_minimum_required(VERSION 3.17)

add_library(lexparse
    ../lexparse/driver.cpp
    ../lexparse/driver.hpp
    ../lexparse/lexeme.hpp
    ../lexparse/scanner.hpp
    ../lexparse/command.hpp
    ../lexparse/lexer.l
    ../lexparse/parser.yy
    ../lexparse-build/lexer.cc
    ../lexparse-build/parser.cc
)

target_include_directories(lexparse PRIVATE . $ENV{BOOST_HOME} $ENV{FLEX_BISON_HOME} ../lexparse ../lexparse-build)

add_executable(fluent
    main.cpp
    command.cpp
    ../lexparse/command.hpp
)

target_include_directories(fluent PRIVATE . $ENV{BOOST_HOME} $ENV{FLEX_BISON_HOME} ../lexparse ../lexparse-build)

target_link_libraries(fluent PRIVATE lexparse)

set_property(TARGET fluent
             PROPERTY CXX_STANDARD 14)

enable_testing()

add_test(NAME basic
         COMMAND ${CMAKE_SOURCE_DIR}/test/commands.txt
         WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

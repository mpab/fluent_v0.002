project(fluent CXX)

if (MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /EHsc")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif()

cmake_minimum_required(VERSION 3.17)

add_executable(fluent
    main.cpp
    command.cpp
    ../lexparse/driver.cpp
    ../lexparse/lexer.l
    ../lexparse/parser.yy
    ../lexparse-build/lexer.cc
    ../lexparse-build/parser.cc
)

target_include_directories(fluent PRIVATE . $ENV{BOOST_HOME} $ENV{FLEX_BISON_HOME} ../lexparse ../lexparse-build)

set_property(TARGET fluent
             PROPERTY CXX_STANDARD 14)

enable_testing()

add_test(NAME basic
         COMMAND ${CMAKE_SOURCE_DIR}/test/commands.txt
         WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

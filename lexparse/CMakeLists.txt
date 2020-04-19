project(lexparse CXX)

if (MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /EHsc")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
endif()

cmake_minimum_required(VERSION 3.17)

find_package(BISON REQUIRED)
BISON_TARGET(parser
             parser.yy
             ${CMAKE_CURRENT_BINARY_DIR}/parser.cc)

find_package(FLEX REQUIRED)
FLEX_TARGET(lexer
            lexer.l
            ${CMAKE_CURRENT_BINARY_DIR}/lexer.cc)

ADD_FLEX_BISON_DEPENDENCY(lexer parser)

add_library(lexparse
    driver.cpp
    ${FLEX_lexer_OUTPUTS}
    ${BISON_parser_OUTPUTS}
    ${FLEX_BISON_INTERFACE}
)

target_include_directories(lexparse PRIVATE . ${CMAKE_CURRENT_BINARY_DIR} $ENV{FLEX_BISON_HOME})

set_property(TARGET lexparse
             PROPERTY CXX_STANDARD 14)


%skeleton "lalr1.cc"
%require  "3.0"
%debug 
%defines 
%define api.namespace {CMD}
%define api.parser.class {Parser}

%code requires{
   namespace CMD {
      class Driver;
      class Scanner;
   }

// The following definitions is missing when %locations isn't used
# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
   #include <iostream>
   #include <cstdlib>
   #include <fstream>
   
   /* include for all driver functions */
   #include "driver.hpp"

  #undef yylex
  #define yylex scanner.yylex

  using T = CMD::Parser::token_type;
}

%define api.value.type variant
%define parse.assert

%token END    0     "end of file"
%token NL
%token SPC
%token CHAR
%token CON_ABORT

%token <std::string> TEXT

%token COMMENT
%token ELLIPSIS 
%token IF ELSEIF ELSE 
%token WHILE
%token OUT

%token OPERATOR

%token SYMBOL
%token BAD_SYMBOL
%token INTEGER
%token REAL
%token BAD_REAL
%token QSTRING

%token GEQ
%token LEQ
%token EQ
%token NEQ

%left GEQ LEQ EQ NEQ '>' '<'
%left '+' '-'
%left '*' '/'
%left '^'

%locations

%%

command: END | list END;

list
  : item
  | list item
  ;

item
  : CHAR      { driver.chr(); }
  | NL        { driver.newline(); }
  | SPC       { driver.space(); }

  | TEXT      { driver.text($1); }

  | CON_ABORT  { driver.abort(); }

  ;

%%

void CMD::Parser::error(const location_type &l, const std::string &err_message) {
   std::cerr << err_message << std::endl;
}

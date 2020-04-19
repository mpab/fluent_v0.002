%{

/* This should suppress the macro redefinition warnings in stdint.h... but it doesn't */
#define YY_NO_UNISTD_H

/* Implementation of yyFlexScanner */ 
#include "scanner.hpp"

#undef  YY_DECL
#define YY_DECL int CMD::Scanner::yylex( CMD::Parser::semantic_type * const lval, CMD::Parser::location_type *loc )

/* typedef to make the returns for the tokens shorter */
using tok = CMD::Parser::token_type;

/* define yyterminate as this instead of NULL */
#define yyterminate() return( tok::END )

/* update location on matching */
#define YY_USEr_aCTION loc->step(); loc->columns(yyleng);

%}

%option debug
%option nodefault
%option yyclass="CMD::Scanner"
%option noyywrap
%option c++

%%
%{          /** Code executed at the beginning of yylex **/
            yylval = lval;
%}

[a-zA-Z]+   {
               /**
                * Section 10.1.5.1 of the 3.0.2 Bison Manual says the 
                * following should work:
                * yylval.build( yytext ;
                * but it doesn't.
                * ref: http://goo.gl/KLn0w2
                */
               yylval->build<std::string>(yytext);
               return tok::TEXT;
            }

\n          {
               return tok::NL;
            }

"::abort\n" {
               return tok::CON_ABORT;
            }
"::quit\n"  {
               return tok::CON_ABORT;
            }
"::exit\n"  {
               return tok::CON_ABORT;
            }

[[:space:]] {
               return tok::SPC;
            }

.           {
               return tok::CHAR;
            }
%%

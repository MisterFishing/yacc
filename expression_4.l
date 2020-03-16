%{
#include <stdlib.h>
#include "y.tab.h"
%}

%option yylineno

%%

[A-Za-z]([A-Za-z]|[0-9])*  {  return IDENTIFIER;  }

[0-9]+  {  return INTEGER;  }

"+"|"-"|"*"|"/"|"("|")"  {  return *yytext;  }

[ \t\r\n]

. 	{
		printf("lexical error: line %d\n", yylineno);
		exit(0);
	}

%%

int yywrap()
{
	return 1;
}


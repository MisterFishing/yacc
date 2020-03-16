%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

FILE * yyin;

extern int yylineno;

void yyerror(char* msg);
%}

%token IDENTIFIER INTEGER

%left '+' '-'
%left '*' '/'

%%

start: expression
;

expression: INTEGER
| IDENTIFIER
| expression '+' expression
| expression '-' expression
| expression '*' expression
| expression '/' expression
| '(' expression ')'
;

%%
	
void yyerror(char* msg) 
{
	printf("%s: line %d\n", msg, yylineno);
	exit(0);
}

int main(int argc, char *argv[]) {
	if(argc!=2) {
		printf("usage: %s filename\n", argv[0]);
		exit(0);
	}			

	if( (yyin=fopen(argv[1], "r")) ==NULL )
	{
		printf("open file %s failed\n", argv[1]);
		exit(0);
	}

	yyparse();

	fclose(yyin);
	return 0;
}


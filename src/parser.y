/*******************************************************************************
* Name        : erpel/src/parser.y                                             *
* Author      : M.E.Rosner                                                     *
* E-Mail      : marty[at]rosner[dot]io                                         *
* Version     : 0.0.01                                                         *
* Copyright   : Copyright (C) 2020, 2021 M.E.Rosner; Berlin; Germany           *
* Description : An Enterprise Ressource Planning Notation and Tool Kit         *
* URL         : https://github.com/exo-mer/2021-financial-ERPEL                *
*******************************************************************************/

%{
#include <stdio.h>

//#include "y.tab.h"
#include "lex.yy.h"

float res_default = 0.0f;

void yyerror(char const *msg);
%}

%union { int num; float flt; char *sym; }

%token <sym> T_LPS T_RPS
%token <sym> T_EOL
%token <sym> T_CMT T_CMA T_SEM

%token <sym> T_IDS
%token <num> T_NUM
%token <flt> T_FLT

%start lines

%%

lines: line /* thinking in nodes instead */
    | lines line
;

line: /*T_EOL
    | nodes T_EOL
    | T_CMT T_EOL
    | nodes T_CMT T_EOL*/
	T_EOL
 |	nodes T_EOL
 |	T_CMT T_EOL
 |	nodes T_CMT T_EOL
;

nodes:	node_
 |	nodes node_
 |	tag_o nodes tag_c
 |	T_IDS tag_o nodes tag_c
/* NEW */
/*    | T_LPS T_EOL nodes T_RPS */
;

/*node_: T_LPS T_RPS
    | T_LPS T_IDS T_RPS
    | T_LPS T_FLT T_RPS
    | T_LPS T_NUM T_RPS
    | T_IDS T_LPS T_RPS
    | T_IDS T_LPS T_IDS T_RPS
    | T_IDS T_LPS T_FLT T_RPS
    | T_IDS T_LPS T_NUM T_RPS*/
/* NEW */
/*    | T_LPS T_EOL nodes T_RPS*/
/*    | T_LPS T_EOL T_RPS
    | T_LPS T_EOL T_IDS T_RPS
    | T_LPS T_IDS T_EOL */
;

node_:	tag_o tag_c
 |	tag_o T_EOL tag_c
/* |	tag_o T_IDS tag_c	
 |	tag_o T_FLT tag_c
 |	tag_o T_NUM tag_c*/
/* |	T_IDS tag_o tag_c
 |	T_IDS tag_o T_IDS tag_c
 |	T_IDS tag_o T_FLT tag_c
 |	T_IDS tag_o T_NUM tag_c*/
 |	tag_o cont_ tag_c
 |	T_IDS tag_o tag_c
 |	T_IDS tag_o cont_ tag_c
/* NEW */
/* |	tag_o tag_o cont_ tag_c tag_c */
;
tag_o:	T_LPS
/* |	T_LPS T_EOL */
/* |	T_EOL T_LPS*/
;
tag_c:	T_RPS
/* |	T_RPS T_EOL
 |	T_EOL T_RPS*/
;

cont_:	T_IDS
 |	cont_ T_IDS
 |	T_FLT
 |	cont_ T_FLT
 |	T_NUM
 |	cont_ T_NUM
;
%%

void yyerror(char const *msg)
{
  fprintf(stderr,"line %d: %s\n",yylineno, msg);
}

int main()
{
  // yydebug = 1;
  yyparse();
  printf("finished processing.\n");
  yylex_destroy();

  return 0;
}

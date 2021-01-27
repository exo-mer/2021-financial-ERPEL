/*******************************************************************************
* Name        : erpel/src/lex.l                                                *
* Author      : M.E.Rosner                                                     *
* E-Mail      : marty[at]rosner[dot]io                                         *
* Version     : 0.0.01                                                         *
* Copyright   : Copyright (C) 2020, 2021 M.E.Rosner; Berlin; Germany           *
* Description : An Enterprise Ressource Planning Notation and Tool Kit         *
* URL         : https://github.com/exo-mer/2021-financial-ERPEL                *
*******************************************************************************/

%option header-file="lex.yy.h"
%option noyywrap
%option yylineno

%{
#include <stdio.h>

#include "y.tab.h"
%}

%%
"<"|"\/"|"["|"("|"{"		{ yylval.sym = strdup(yytext); return T_LPS;			}
">"|"\\"|"]"|")"|"}"		{ yylval.sym = strdup(yytext); return T_RPS;			}

[\n]+				{ yylval.sym = strdup(yytext); return T_EOL;			}
[ \t]				{ ;								}

"#"(.|"\["|"\]"|"\."|"\;"|"\:"|"\-"|"\/"|"\("|"\)"|"\{"|"\}")*	{ yylval.sym = strdup(yytext); return T_CMT;	}
";"				{ yylval.sym = strdup(yytext); return T_SEM;			}
","				{ yylval.sym = strdup(yytext); return T_CMA;			}

([0-9])+			{ yylval.flt = atof(yytext); return T_NUM;			}
([0-9]*"."[0-9]+)		{ yylval.flt = atof(yytext); return T_FLT;			}

[a-zA-Z0-9]*			{ yylval.sym = strdup(yytext); return T_IDS; 			}

.				{ fprintf(stderr,"unknown / unspecified at: %d\n",yylineno);	}
%%

################################################################################
# Name        : erpel/src/Makefile                                             #
# Author      : M.E.Rosner                                                     #
# E-Mail      : marty[at]rosner[dot]io                                         #
# Version     : 0.0.01                                                         #
# Copyright   : Copyright (C) 2020, 2021 M.E.Rosner; Berlin; Germany           #
# Description : An Enterprise Ressource Planning Notation and Tool Kit         #
# URL         : https://github.com/exo-mer/2021-financial-ERPEL                #
################################################################################

CC = /usr/bin/cc
CFLAGS= -o
LEX = /usr/bin/lex
LFLAGS= -8
YACC= /usr/bin/yacc
YFLAGS= -d -v

RM = /bin/rm -f

test-erpel: lex.yy.h lex.yy.c y.tab.h y.tab.c
	${CC} ${CFLAGS} test-erpel y.tab.c lex.yy.c 

y.tab.h y.tab.c:
	${YACC} ${YFLAGS} parser.y

lex.yy.h lex.yy.c:
	${LEX} ${LFLAGS} lex.l

clean:
	${RM} lex.yy.* y.tab.* *.o y.output test-erpel

run:
	./test-erpel

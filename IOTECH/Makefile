parser: lex.yy.c y.tab.c
	gcc -o parser y.tab.c
y.tab.c: CS315f22_team40.yacc
	yacc CS315f22_team40.yacc
lex.yy.c: CS315f22_team40.lex
	lex CS315f22_team40.lex
%token SEMICOLON LP RP LCB RCB COMMA TERMINATE_PRIM_FUNC CON_IDENTIFIER DIGIT
%token ASSIGNMENT_OP ADD_OP SUB_OP MULT_OP DIV_OP MOD_OP EQ_OP NOT_EQ_OP LESS_OP LESS_EQ_OP GREATER_OP GREATER_EQ_OP
%token TRUE FALSE NOT VOID INT_TYPE FLOAT_TYPE BOOL_TYPE STRING_TYPE
%token IF ELSE FOR WHILE DO FUNC_DEF RETURN AND OR CONST
%token READ_TIME_PRIM_FUNC READ_TEMP_PRIM_FUNC READ_HUMID_PRIM_FUNC READ_AIR_PRESS_PRIM_FUNC READ_AIR_QUALITY_PRIM_FUNC
%token READ_LIGHT_PRIM_FUNC READ_SOUND_LEVEL_PRIM_FUNC SET_SWITCH_PRIM_FUNC SEND_PRIM_FUNC RECEIVE_PRIM_FUNC CONNECT
%token IDENTIFIER INT_LITERAL FLOAT_LITERAL STRING_LITERAL 
%%
start: 	program;
program:  stmt_list 
	| stmt_list func_list 
	;
stmt_list: stmt | stmt_list stmt 
;

func_list: func | func func_list
;

func:	 	 FUNC_DEF void_func | FUNC_DEF non_void_func
		  | error LCB ;
void_func:	 VOID signature LCB stmt_list RCB;
non_void_func:	type signature LCB stmt_list rtrn RCB;
rtrn:		RETURN expression SEMICOLON;

signature:	IDENTIFIER LP in_args RP
		| IDENTIFIER LP RP;
in_args:	type IDENTIFIER
		| type IDENTIFIER COMMA in_args;

func_call:	IDENTIFIER LP RP
		| IDENTIFIER LP args RP
		| non_void_prim_func_call
		| void_prim_func_call;
void_prim_func_call: SET_SWITCH_PRIM_FUNC LP value COMMA DIGIT  RP;
non_void_prim_func_call: READ_TIME_PRIM_FUNC LP RP
			| READ_TEMP_PRIM_FUNC LP RP
			| READ_HUMID_PRIM_FUNC LP RP
			| READ_AIR_PRESS_PRIM_FUNC LP RP
			| READ_AIR_QUALITY_PRIM_FUNC LP RP
			| READ_LIGHT_PRIM_FUNC LP RP
			| READ_SOUND_LEVEL_PRIM_FUNC LP value RP;
args:		arg | arg COMMA args;
arg:		expression;
stmt:		block_stmt | non_block_stmt | error SEMICOLON
;
block_stmt:	if_stmt | while_stmt | for_stmt | do_while_stmt;
non_block_stmt:	assign_stmt SEMICOLON 
		| decleration_stmt SEMICOLON
		| func_call SEMICOLON
		| connect_url SEMICOLON
		| send_func SEMICOLON
		| terminate_func SEMICOLON;
if_stmt:	IF LP logic_exprs RP LCB stmt_list RCB
		| IF LP logic_exprs RP LCB stmt_list RCB ELSE LCB stmt_list RCB
		| IF LP logic_exprs RP LCB stmt_list RCB elseif_stmt ELSE LCB stmt_list RCB
		| IF LP logic_exprs RP LCB stmt_list RCB elseif_stmt
		;
elseif_stmt:	ELSE IF LP logic_exprs RP LCB stmt_list RCB
		| elseif_stmt ELSE IF LP logic_exprs RP LCB stmt_list RCB
		;
while_stmt:	WHILE LP logic_exprs RP LCB stmt_list RCB;
for_stmt:	FOR LP for_init SEMICOLON logic_exprs SEMICOLON assign_stmt RP LCB stmt_list RCB;
for_init:	decleration_stmt | assign_stmt;
do_while_stmt:	DO LCB stmt_list RCB WHILE LP logic_exprs RP SEMICOLON;

connect_url:	CONNECT CON_IDENTIFIER LP STRING_LITERAL RP;
send_func:	CON_IDENTIFIER SEND_PRIM_FUNC LP value RP;
receive:	CON_IDENTIFIER RECEIVE_PRIM_FUNC LP RP;
terminate_func: CON_IDENTIFIER TERMINATE_PRIM_FUNC LP RP;

decleration_stmt: type IDENTIFIER | type assign_stmt | CONST type assign_stmt;
assign_stmt:	IDENTIFIER ASSIGNMENT_OP expression
		;

expression:	expression low_prec_op term
		| term;
term:		term high_prec_op factor
		| factor;
factor:		value
		| func_call
		| receive
		| LP expression RP
		;
logic_exprs:	conjunction | logic_exprs OR conjunction;
conjunction:	negation | conjunction AND negation;
negation:	NOT negation | logic_expr | LP logic_exprs RP;
logic_expr:	IDENTIFIER | value comp_op value | TRUE | FALSE;
comp_op:	EQ_OP | NOT_EQ_OP | LESS_OP | LESS_EQ_OP | GREATER_OP | GREATER_EQ_OP; 
low_prec_op:	ADD_OP | SUB_OP;
high_prec_op:	MULT_OP | DIV_OP | MOD_OP;
type:		FLOAT_TYPE | INT_TYPE | BOOL_TYPE |STRING_TYPE;
value:		IDENTIFIER | STRING_LITERAL | INT_LITERAL | FLOAT_LITERAL | TRUE | FALSE| DIGIT;

%%
#include "lex.yy.c"
void yyerror(char *s) { fprintf(stdout, "%s on line: %d! \n", s, yylineno); }
int main() {
	yyparse();
	if ( 1 >  yynerrs ) {
		printf("Input program is valid!\n");
		return 0;
	}
	return 1;
}






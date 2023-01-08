%option yylineno
%%
; return(SEMICOLON);
\( return(LP);
\) return(RP);
\{ return(LCB);
\} return(RCB);
\, return(COMMA);

\= return(ASSIGNMENT_OP);
\+ return(ADD_OP);
\- return(SUB_OP);
\* return(MULT_OP);
\/ return(DIV_OP);
\% return(MOD_OP);
\=\= return(EQ_OP);
\!\= return(NOT_EQ_OP);
\<  return(LESS_OP);
 \<\= return(LESS_EQ_OP);
\> return(GREATER_OP);
\>\= return(GREATER_EQ_OP);

true return(TRUE);
false return(FALSE);
not return(NOT);

void return(VOID);
int return(INT_TYPE);
float return(FLOAT_TYPE);
bool return(BOOL_TYPE);
string return(STRING_TYPE);
const return(CONST);

if return(IF);
else return(ELSE);
for return(FOR);
while return(WHILE);
do return(DO);
func return(FUNC_DEF);
return return(RETURN);
and return(AND);
or return(OR);
ReadTimeStamp return(READ_TIME_PRIM_FUNC);
ReadTemperature return(READ_TEMP_PRIM_FUNC);
ReadHumidity return(READ_HUMID_PRIM_FUNC);
ReadAirPress return(READ_AIR_PRESS_PRIM_FUNC);
ReadAirQual return(READ_AIR_QUALITY_PRIM_FUNC);
ReadLight  return(READ_LIGHT_PRIM_FUNC);                                                                                                                
ReadSoundLevel return(READ_SOUND_LEVEL_PRIM_FUNC);
SetSwitch return(SET_SWITCH_PRIM_FUNC);
\.send return(SEND_PRIM_FUNC);
\.receive return(RECEIVE_PRIM_FUNC);
\.terminate return(TERMINATE_PRIM_FUNC);
connection return(CONNECT);
\$[a-zA-Z]+ return(CON_IDENTIFIER);


[a-zA-Z]+ return(IDENTIFIER);

\#.*  ;
\!\#[^(\#\!)]*\#\! ;

[0-9] return(DIGIT);
[+-]?[0-9]+ return(INT_LITERAL);
[+-]?[0-9]*\.[0-9]+ return(FLOAT_LITERAL);
\".*\" return(STRING_LITERAL);
[ \t\n] ;
. ;
%%
int yywrap() { return 1; }



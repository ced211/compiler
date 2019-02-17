# compiler

<u>TODO:</u>

- [x] Line comments with <<EOF>>
- [x] Comment blocks with Stack mechanism
- [x] Integer-literals (prob avec binaries 0b1011)
- [ ] String literal
  <u>Note:</u> 
  "\""					{str.clear(); str.(yytext); yy_push_state(str_lit); column += yyleng;}
  <str_lit>				{yy_pop_state();}
- [ ] Fault handler


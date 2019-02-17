/*
* Compiler project 1 : Lexical Analyser
* Julien L'hoest and Cédric Schils
*/

%{
	#include <stdio.h>
	#include <string>
	#include <stdlib.h>
	#include <iostream>
  	using namespace std;
  	extern int yylex();
	
	const char coma = ',';
	unsigned line = 1;
	unsigned column = 1;
	string str;
	char buffer[1000];

	void bin2Decimal(char* bin_digit,char* buffer){
		char** p;
		unsigned long number = 0;
		number = strtoul(&bin_digit[2],p,2);
		sprintf(buffer, "%lu", number);
		return;
	}
	void hex2Decimal(char* hex_digit,char* buffer){
		char** p;
		unsigned long number = 0;
		number = strtoul(&hex_digit[2],p,16);
		sprintf(buffer, "%lu", number);
		return;
	}
	void update_clm_line(char* str,unsigned* column,unsigned* line){
		unsigned i = 0;
		while(str[i] != '\0'){
			*column++;
			if(str[i] == '\n')
				*line++;
			if(str[i] == '\r')
				*column = 1;
		}
	}
	char* strValue(char* str){
		unsigned length = strlen(str);
		char* value = NULL;
		unsigned i =0;
		value = (char*) malloc(2*sizeof(char)*length);
		int j = 0;
		while(str[i] != '\0'){
			if(str[i] == '\\'){
				i++;
				if(str[i] == 'n'){
					value[j] = '\\';
					value[j+1] = 'x';
					value[j+2] = '0';
					value[j+3] = 'a';
					j += 3;
				}
				if(str[i] == 'r'){
					value[j] = '\\';
					value[j+1] = 'x';
					value[j+2] = '0';
					value[j+3] = 'd';
					j += 3;
				}
				if(str[i] == 't'){
					value[j] = '\\';
					value[j+1] = 'x';
					value[j+2] = '0';
					value[j+3] = '8';
					j += 3;
				}
				if(str[i] == '\\'){
					value[j] = '\\';
				}
				else{
					value[j] = str[i];
				}		
			}
			else{
				value[j] = str[i];
			}
			i++;
			j++;
		}
		value[j] = '\0';
		return value;
	}
%}

%option noyywrap
%option stack

/* regular definitions */
lowercase-letter 	[a-z]
uppercase-letter 	[A-Z]
letter 			{lowercase-letter}|{uppercase-letter}
bin-digit 		[0-1]
digit 			{bin-digit}|[2-9]
hex-digit 		{digit}|[a-fA-F]

whitespaces 	\n|\f|\r|\t|" "	

comment-line 		"//"[^\n\r]*

integer-literal 	{digit}+|"0x"{hex-digit}+|"0b"{bin-digit}+

type-identifier 	{uppercase-letter}({letter}|{digit}|"_")*

object-identifier 	{lowercase-letter}({letter}|{digit}|"_")*

escape-sequence 	"b"|"t"|"n"|"r"|'"'|"\"|"x"{hex-digit}{2}	//|lf(" "|{tab})*
escaped-char 		"\"{escape-sequence}
regular-char 		^[\n\r{escaped-char}]
string-literal		("\""({regular-char}|{escaped-char})*"\"") 

lbrace				"{"
rbrace				"}"
lpar				"("
rpar				")"
colon				":"
semicolon			";"
comma				","
plus				"+"
minus				"-"
times				"*"
div					"/"
pow					"^"
dot					"."
equal				"="
lower				"<"
lower-equal			"<="
assign				"<-"

operators 			({lbrace}|{rbrace}|{lpar}|{rpar}|{colon}|{semicolon}|{comma}|{plus}|{minus}|{times}|{div}|{pow}|{dot}|{equal}|{lower}|{lower-equal}|{assign})

custom 				[^ \t\n\r\f\{\}\(\)\:;,+\-\*\/\^.=<"<=""<\-"]

%x l_comment b_comment str_lit

%%

\n			{line += 1;}
\r 			{column = 1;}
[ \t\f] 	{column += yyleng;}

"and"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"bool"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"class"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"do" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"else"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"extends"		{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"false"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"if"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"in" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"int32"			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"isnull"		{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"let" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"new" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"not" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"string" 		{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"then" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"true" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"unit" 			{cout << line << coma << column << coma << yytext << endl; column += yyleng;}
"while" 		{cout << line << coma << column << coma << yytext << endl; column += yyleng;}

"{"  			{cout << line << coma << column << coma << "lbrace" << endl; column += yyleng;}
"}"  			{cout << line << coma << column << coma << "rbrace" << endl; column += yyleng;}
"("  			{cout << line << coma << column << coma << "lpar" << endl; column += yyleng;}
")"  			{cout << line << coma << column << coma << "rpar" << endl; column += yyleng;}
":"  			{cout << line << coma << column << coma << "colon" << endl; column += yyleng;}
";"  			{cout << line << coma << column << coma << "semicolon" << endl; column += yyleng;}
","  			{cout << line << coma << column << coma << "coma" << endl; column += yyleng;}
"+"  			{cout << line << coma << column << coma << "plus" << endl; column += yyleng;}
"-"  			{cout << line << coma << column << coma << "minus" << endl; column += yyleng;}
"*"  			{cout << line << coma << column << coma << "times" << endl; column += yyleng;}
"/"  			{cout << line << coma << column << coma << "div" << endl; column += yyleng;}
"^"  			{cout << line << coma << column << coma << "pow" << endl; column += yyleng;}
"."  			{cout << line << coma << column << coma << "dot" << endl; column += yyleng;}
"="  			{cout << line << coma << column << coma << "equal" << endl; column += yyleng;}
"<"  			{cout << line << coma << column << coma << "lower" << endl; column += yyleng;}
"<="  			{cout << line << coma << column << coma << "lower-equal" << endl; column += yyleng;}
"<-"  			{cout << line << coma << column << coma << "assign" << endl; column += yyleng;}

{digit}+				{cout << line << coma << column << coma << "integer-literal" << coma << yytext << endl; column += yyleng;}
"0b"{bin-digit}+		{string buff = yytext; cout << line << coma << column << coma << "integer-literal" << coma << stoi(buff.erase(0, 2), nullptr, 2) << endl; column += yyleng;}
"0x"{hex-digit}+		{cout << line << coma << column << coma << "integer-literal" << coma << stoi(yytext, nullptr, 0) << endl; column += yyleng;}

{type-identifier}	{printf("%d,%d,type-identifier,%s\n", line, column, yytext); column += yyleng;}
{object-identifier}	{printf("%d,%d,type-identifier,%s\n", line, column, yytext); column += yyleng;}

{comment-line} 			{column += yyleng; yy_push_state(l_comment);}
<l_comment>[^\n\r]*\n 	{column += yyleng; line++; yy_pop_state();}
<l_comment>[^\n\r]*\r 	{column = 1; yy_push_state(l_comment); yy_pop_state();}
<l_comment><<EOF>> 		{yy_pop_state();}


("\""(.)*"\"")		{char* val = strValue(yytext) ;printf("%d,%d,string-literal,%s\n", line, column,val);free(val);column += yyleng;}


"(*"         {cout << yytext; yy_push_state(b_comment);}

<b_comment>"(*"				{cout << yytext; yy_push_state(b_comment);}
<b_comment>[^(*)\n]*      	{column += yyleng; cout << yytext;}  /* eat anything that's not a '*' a '(' or a ')' */
<b_comment>"*"+[^(*)\n]*   	{column += yyleng; cout << yytext;}/* eat up '*'s not followed by ')'s */
<b_comment>"("+[^(*\n]*		{column += yyleng; cout << yytext;}
<b_comment>\n           	{line++; cout << endl;}
<b_comment>"*)"        		{cout << yytext; yy_pop_state();}

<<EOF>>						{cout << "End of file dear" << endl; return 0;}
.							{cerr << "Unrecognized token: " << line << coma << column << coma << yytext << endl; column += yyleng;}
{integer-literal}{custom}* {cerr << "Unrecognized token: " << line << coma << column << coma <<"'"<< yytext <<"'"<< endl; column += yyleng;}

%%
int main(int argc, char** argv) {

	if(argv != NULL) {
   		cerr << "No file path specified" << endl;
   		//return -1;
	}

	if(argc < 1){
		cerr << "No file path specified" << endl;
		//return -1;
 	}

	FILE *f = fopen(argv[1], "r");
 	if(!f) {
    	cerr << "Unable to open file specify in " << argv[1] << endl;
    return -1;
  }
  
  // set lex to read from it instead of defaulting to STDIN:
  yyin = f;

  // lex through the input:
  while(yylex());
  
  fclose(f);

  return 0;

}

/*
* Compiler project 1 : Lexical Analyser
* Julien L'hoest and Cédric Schils
*/

%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	
	int line = 1, int column = 1;

	char* bin2Decimal(char* bin_digit){
		length = strlen(bin_digit);
		char* p;
		char buffer[255];
		if(length <= 2){
			//error handling...
		}
		char digit[length-1];
		unsigned long long number = strtoull(&bin_digit[2],p,2);
		sprintf(buffer, "%llu", number);
		return buffer;
	}
	char* hex2Decimal(char* hex_digit){
		char*p;
		char buffer[255];
		unsigned long long number = strtoull(hex_digit,p,0);
		sprintf(buffer, "%llu", number);
		return buffer;
	}
%}

/* regular definitions */
lowercase-letter 	[a-z]
uppercase-letter 	[A-Z]
letter 				{lowercase-letter}|{uppercase-letter}
bin-digit 			0|1
digit 				({bin-digit}|[2-9])
hex-digit 			({digit}|[a-fA-F])

tab 				"\t"
lf 					"\n"
ff 					"\f" // Go next page page
cr 					"\r"
whitespace 			" "|tab|lf|ff|cr 	//TODOOOOOOO decider c'est quoi \n, \r et \r\n car different selon OS

comment-line 		"//"(^{lf})*({lf}|<<EOF>>) //TODOOOOOO selon d'autre source le "^" n'a pas la mm signification que dans le cours


integer-literal 	{digit}+|"0x"{hex-digit}+|"0b"{bin-digit}+

type-identifier 	{uppercase-letter}({letter}|{digit}|"_")*

object-identifier 	{lowercase-letter}({letter}|{digit}|"_")*

escape-sequence 	"b"|"t"|"n"|"r"|'"'|"\"|"x"{hex-digit}{hex-digit}|lf(" "|{tab})*
escaped-char 		"\"{escape-sequence}
regular-char 		
string-literal		'"'({regular-char}{escaped-char})*'"'

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

%%
		//TODOOOOOOOOO utiliser la fct yylloc au lieu d'utiliser des variables perso pour colonne et ligne
lf			{line += 1;}
rc 			{column = 1;}
tab			{column += yyleng;}
whitespace 	{;}

"and"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"bool"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"class"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"do" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"else"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"extends"		{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"false"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"if"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"in" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"int32"			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"isnull"		{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"let" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"new" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"not" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"string" 		{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"then" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"true" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"unit" 			{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}
"while" 		{printf("%d,%d,%s\n", line, column, yytext); column += yyleng;}

"{"  			{printf("%d,%d,lbrace\n", line, column); column += yyleng;}
"}"  			{printf("%d,%d,rbrace\n", line, column); column += yyleng;}
"("  			{printf("%d,%d,lpar\n", line, column); column += yyleng;}
")"  			{printf("%d,%d,rpar\n", line, column); column += yyleng;}
":"  			{printf("%d,%d,colon\n", line, column); column += yyleng;}
";"  			{printf("%d,%d,semicolon\n", line, column); column += yyleng;}
","  			{printf("%d,%d,coma\n", line, column); column += yyleng;}
"+"  			{printf("%d,%d,plus\n", line, column); column += yyleng;}
"-"  			{printf("%d,%d,minus\n", line, column); column += yyleng;}
"*"  			{printf("%d,%d,times\n", line, column); column += yyleng;}
"/"  			{printf("%d,%d,div\n", line, column); column += yyleng;}
"^"  			{printf("%d,%d,pow\n", line, column); column += yyleng;}
"."  			{printf("%d,%d,dot\n", line, column); column += yyleng;}
"="  			{printf("%d,%d,equal\n", line, column); column += yyleng;}
"<"  			{printf("%d,%d,lower\n", line, column); column += yyleng;}
"<="  			{printf("%d,%d,lower-equal\n", line, column); column += yyleng;}
"<-"  			{printf("%d,%d,assign\n", line, column); column += yyleng;}

{digit}			{printf("%d,%d,integer-literal,%s\n", line, column, yytext); column += yyleng;}
{bin-digit}		{printf("%d,%d,integer-literal,%s\n", line, column, bin2Decimal(yytext)); column += yyleng;}
{hex-digit}		{printf("%d,%d,integer-literal,%s\n", line, column, hex2Decimal(yytext)); column += yyleng;}



comment-line {printf("%d,%d,comment-line,%s\n", line, column, yytext); line += 1; columns = 1;}


%%
int main (void) {
   yylex ();
   return 0;
   }

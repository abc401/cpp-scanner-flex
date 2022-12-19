
ONETONINE           [1-9]
ZEROTONINE		[0-9]
BIT			    [01]
OCTIT		    [0-7]
HEXIT		    [0-9a-fA-F]

ALPHA-UNDER	[a-zA-Z_]

%{
void print_token(char *token_type) {
    printf("%s: %s\n", token_type, yytext);
}
%}

%%

[#](.|\\\n)*\n {
	print_token("Preprocessor Directive");
}

"alignas"|"decltype"|"namespace"|"struct"|"alignof"|"default"|"new" |
"switch"|"and"|"delete"|"noexcept"|"template"|"and_eq"|"do" |
"not"|"this"|"asm"|"double"|"not_eq"|"thread_local"|"auto" |
"dynamic_cast"|"throw"|"bitand"|"else"|"operator"|"bitor"|"enum" |
"or"|"try"|"bool"|"explicit"|"or_eq"|"typedef"|"break" |
"export"|"private"|"typeid"|"case"|"extern"|"protected"|"typename" |
"catch"|"public"|"union"|"char"|"float"|"register"|"unsigned" |
"char16_t"|"for"|"reinterpret_cast"|"using"|"char32_t"|"friend"|"return" |
"virtual"|"class"|"goto"|"short"|"void"|"compl"|"if" |
"signed"|"volatile"|"const"|"inline"|"sizeof"|"wchar_t"|"constexpr" |
"int"|"static"|"while"|"const_cast"|"long"|"static_assert"|"xor" |
"continue"|"mutable"|"static_cast"|"xor_eq"	{
	print_token("Keyword");
}

"nullptr" {
	print_token("Pointer Literal");
}

"false"|"true" {
	print_token("Boolean Literal");
}


{ZEROTONINE}*"."{ZEROTONINE}+([eE][-+]?{ZEROTONINE}+)?([fFlL])? {
	print_token("Flaot Literal");
}



0[bB]{BIT}+([uU]?[lL]{0,2}) {
    print_token("Binary Literal");
}

0{OCTIT}+([uU]?[lL]{0,2}) {
    print_token("Octal Literal");
}

0|{ONETONINE}{ZEROTONINE}*([uU]?[lL]{0,2}) {
    print_token("Decimal Literal");
}

0[xX]{HEXIT}+([uU]?[lL]{0,2}) {
    print_token("Hex Literal");
}

("u8"|[LuU])?\'([^\\\n]|\\.{1})+\' {
	print_token("Character Literal");
}

("u8"|[LuU])?\"([^\\\n]|\\.{1})*\" {
	print_token("String Literal");
}

"::"|"."|"->"|"["|"]"|"("|")" |
"++"|"--"|"typeid"|"const_cast" |
"sizeof"|"~"|"compl"|"!"|"not"|"-"|"+" |
"&"|"*"|"new"|"delete"|"("|")"|".*" |
"->*"|"*"|"/"|"%"|"+"|"-"|"<<" |
">>"|"<"|">"|"<="|">="|"=="|"!=" |
"not_eq"|"&"|"bitand"|"^"|"xor"|"|"|"bitor" |
"&&"|"and"|"||"|"or"|"?"|":"|"=" |
"*="|"/="|"%="|"+="|"-="|"<<="|">>=" |
"&="|"and_eq"|"|="|"or_eq"|"^="|"xor_eq"|"throw" {
	print_token("Operator");
}

{ALPHA-UNDER}({ALPHA-UNDER}|{ZEROTONINE})* {
	print_token("Identifier");
}

"{"|"}" {
	print_token("Delimiter");
}

[ \n\t]+ |
"/*"(.|\n)*"*/" |
"//".*

. {
    print_token("Unknown Token");
}

%%

int yywrap() {}
int main() {
    yylex();
}
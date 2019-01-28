%token <string> VAR
%token LAMBDA
%token DOT
%token LPAREN
%token RPAREN
%token EOF
/* %nonassoc LV0 */
%nonassoc LAMBDA
%nonassoc VAR
%start <Utlc_ast.term option> start
%%

simple_term :
  | VAR { Utlc_ast.Var $1 }
  | LPAREN; complex_term; RPAREN { $2 }
  | LAMBDA; VAR; DOT; complex_term %prec LAMBDA { Utlc_ast.Abs ($2, $4) }
;
complex_term :
  | complex_term; simple_term { Utlc_ast.App ($1, $2) }
  | simple_term /* %prec LV0 */ { $1 }
;
start :
  complex_term; EOF { Some $1 }
;

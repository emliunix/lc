{
exception SyntaxError of string
}
rule read =
  parse
  | [' ']
    { read lexbuf }
  | ['a'-'z' 'A'-'Z']+ as v
    { Utlc_yacc.VAR v }
  | '\\'
    { Utlc_yacc.LAMBDA}
  | '.'
    { Utlc_yacc.DOT }
  | '('
    { Utlc_yacc.LPAREN }
  | ')'
    { Utlc_yacc.RPAREN }
  | _
    { raise (SyntaxError "invalid char")}
  | eof
    { Utlc_yacc.EOF }

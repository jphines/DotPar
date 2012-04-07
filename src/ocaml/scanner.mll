{
  open Parser

  let incr_linenum lexbuf =
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.Lexing.lex_curr_p <- { pos with
      Lexing.pos_lnum = pos.Lexing.pos_lnum + 1;
      Lexing.pos_bol = pos.Lexing.pos_cnum;
    }

}

let newline      = '\n' | "\r\n"
let whitespace   = [' ' '\t'] | newline
let digit        = ['0'-'9']
let number       = digit+ | digit* '.' digit+
let alpha        = ['_' 'a'-'z' 'A'-'Z']
let alphanum     = alpha | digit
let identifier   = alpha alphanum*
let escaped_char = ("\\"[^'\n'])
let string_char  = escaped_char | [^ '\\' '\n' '"']
let char_char    = escaped_char | [^ '\\' '\n' '\'']

rule token = parse
| newline             { incr_linenum lexbuf; token lexbuf }
| whitespace          { token lexbuf }
| "/*"                { multi_comment lexbuf }
| "//"                { single_comment lexbuf }
| "import"            { IMPORT }
| "true"              { TRUE }
| "false"             { FALSE }
| "nil"               { NIL }
| "boolean"           { BOOLEAN }
| "char"              { CHAR }
| "func"              { FUNC }
| "number"            { NUMBER }
| "void"              { VOID }
| "if"                { IF }
| "else"              { ELSE }
| "elif"              { ELIF }
| "for"               { FOR }
| "in"                { IN }
| "return"            { RETURN }

| '('                 { LPAREN }
| ')'                 { RPAREN }
| '{'                 { LBRACE }
| '}'                 { RBRACE }
| '['                 { LBRACK }
| ']'                 { RBRACK }
| ';'                 { SEMI }
| ','                 { COMMA }
| ':'                 { COLON }

| "&&"                { AND }
| "||"                { OR }
| "!"                 { NOT }
| ">"                 { GT }
| "<"                 { LT }
| ">="                { GEQ }
| "<="                { LEQ }
| "=="                { EQ }
| "!="                { NEQ }
| "="                 { ASSIGN }
| "+"                 { ADD }
| "-"                 { SUB }
| "*"                 { MULT }
| "/"                 { DIV }
| "%"                 { REM }
| number              { NUM_LITERAL }
| identifier          { IDENTIFIER }
| "'" char_char "'"   { CHAR_LITERAL }
| '"' string_char* '"'{ STRING_LITERAL }
| eof                 { EOF }
| _ as char           { raise (Failure("illegal character " ^ Char.escaped char)) }


and single_comment = parse
  | ['\n' '\r']      { token lexbuf }
  | _                { single_comment lexbuf }

and multi_comment = parse
  | "*/"             { token lexbuf }
  | _                { multi_comment lexbuf }

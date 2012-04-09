(* Abstract syntax tree definitions *)

(* type boolean_literal = *)
(*     Bool of bool *)

(* type relational_expression = *)
(*     Relational_expression of string * expression * expression *)

type unop = Neg | Not
type binop =
    Add | Sub | Mult | Div | Mod
  | Eq | Neq | Lt | Leq | Gt | Geq
  | And | Or

type expression =
    Assignment_expression of expression * expression
  | Declaration of var_type * expression
  | Declaration_expression of var_type * expression * expression
  (* | Array_expression of array_expression *) (* todo *)
        (* unary operators *)
  | Unop of unop * expression
        (* all binary operators *)
  | Binop of expression * binop * expression
        (* postfix *)
  | Function_call of expression * expression list
  | Array_access of expression * expression
        (* *)
  | Variable of string
        (* constants *)
  | Char_literal of char
  | Number_literal of float
  | String_literal of string
  | Boolean_literal of bool
  | Nil_literal
      (* *)
  | Empty_expression

and basic_type =
    Void_type
  | Number_type
  | Char_type
  | Boolean_type

and param =
    Param of var_type * expression

and var_type =
    Basic_type of basic_type
  | Array_type of var_type
  | Fixed_array_type of var_type * expression
  | Func_type of var_type * var_type list
  | Func_param_type of var_type * param list

and selection_statement = {
    if_cond : expression;
    if_body : statements;
    else_body : statements;
    elif_conds : expression list;
    elif_bodies : statements list;
  }

and iteration_statement = expression * expression * expression * statements

and jump_statement = {
    return : expression;
  }

and function_definition = {
   name : string;
   ret_type : var_type;
   (* !!! param_list : ; *)
   body : statements;
}

and statement =
    Expression of expression
  | Statements of statements (* compound statements *)
  | Selection of selection_statement
  | Iteration of iteration_statement
  | Jump of jump_statement
  | Function_definition of function_definition

and statements = statement list;;

type program = statements;;

(***********************************************************************)

(* let rec string_of_expression expression = *)
(*   match expression with *)
(*     Number_literal(n) -> (string_of_float n) ^ "\n" *)
(*   | _-> raise Not_found *)

(* and string_of_basic_type btype = *)
(*   match btype with *)
(*     Void_type -> "void" *)
(*   | _-> raise Not_found *)

(* and string_of_function_definition fn = *)
(*   "func " ^ fn.name ^ ":" ^ (string_of_type fn.ret_type) ^ *)
(*   "()" ^ "{" ^ (string_of_statements fn.body) ^ "}" *)

(* and string_of_statement statement = *)
(*   match statement with *)
(*     Expression(e) -> (string_of_expression e) ^ "\n" *)
(*   | Function_definition(f) -> (string_of_function_definition f) ^ "\n" *)
(*   | _-> raise Not_found *)

(* and string_of_statements statements = *)
(*   match statements with *)
(*     head::tail -> (string_of_statement head) ^ (string_of_statements tail) *)
(*   | _-> "" *)

(* and string_of_type vtype = *)
(*   match vtype with *)
(*     Basic_type(b) -> (string_of_basic_type b) *)
(*   | _-> raise Not_found *)
(* ;; *)

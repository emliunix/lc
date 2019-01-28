open Utlc_yacc;;
open Utlc_ast;;

(* let aPos:Lexing.position = {
 *     pos_fname = "xx";
 *     pos_lnum = 0;
 *     pos_bol = 0;
 *     pos_cnum = 0;
 *   };;
 * 
 * let example = [LAMBDA; VAR "x"; DOT; LAMBDA; VAR "y"; DOT; VAR "x"; VAR "y"];;
 * let run () =
 *   let _parser = MenhirLib.Convert.Simplified.traditional2revised Utlc_yacc.start in
 *   let tokens ls =
 *       let pos = ref 0 in
 *       (fun () ->
 *         let v = List.nth ls !pos in
 *         pos := !pos + 1;
 *         (v, aPos, aPos)
 *       )
 *   in
 *   match _parser (tokens example) with
 *   | None -> print_endline "is none"
 *   | Some t -> string_of_term t |> print_endline;; *)

let string_of_token:(token -> string) =
  function
  | VAR x -> x
  | LAMBDA -> "\\"
  | DOT -> "."
  | EOF -> "$"
  | LPAREN -> "("
  | RPAREN -> ")"
;;
let dump_tokens (s:string) =
  let buf = Lexing.from_string s in
  let _end = ref false in
  while not !_end do
    let tok = Utlc_lex.read buf in
    tok |> string_of_token |> print_endline;
    match tok with
    | EOF -> _end := true
    | _ -> ()
  done
;;
let print_test_expr () =
  Abs ("x", (Abs ("y", (App ((Var "y"), (Var "x"))))))
  |> string_of_term |> print_endline
;;
let test_parse () =
  let data = {|\x.(\y.y)x|} in
  let buf = Lexing.from_string data in
  let term = Utlc_yacc.start Utlc_lex.read buf in
  match term with
  | None -> print_endline "is None"
  | Some t -> t |> string_of_term |> print_endline;
;;

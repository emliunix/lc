type var = string;;
type term =
  | Var of var
  | Abs of var * term
  | App of term * term
;;

let rec string_of_term =
  function
  | Var x -> x
  | Abs (x, t) -> "(λ" ^ x ^ "." ^ (string_of_term t) ^ ")"
  | App (t1, t2) -> (string_of_term t1) ^ " " ^ (string_of_term t2);;

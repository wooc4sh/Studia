(*
let rec fold_left f acc = function
| [] -> acc
| h :: t -> fold_left f (f acc h) t *)

let fold_left f a xs =
  let rec it ys acc =
    match ys with
    | [] -> acc
    | h :: t -> it t (f acc h)
      in it xs a

let rec fold_right f a xs =
match xs with
| [] -> a
| h :: t -> (f h) (fold_right f t a)

(*Zadanie 1
Dla listy pustej product powinen zwracac 1,
bo jest to element nautralny dla mnozenia*)

let product xs =
fold_left ( * ) 1 xs  

(*Zadanie 2*)

let square a = a * a

let inc x = x + 1

let compose f g x = f (g x)

(*
compose square inc 5 ->  square (inc 5) ->
-> square 6 -> 36

compose inc square 5 -> inc (square 5) ->
-> inc 25 -> 26
*)



(*Zadanie 3*)

let build_list n f =
let rec it x =
if x = n then 
[]
else
(f x) :: it (x+1)
in it 0

(*negatives*)
let negatives n = 
build_list n (fun x -> 0 - (inc x))

(*reciprocals*)
let reciprocals n =
build_list n (fun x -> 1.0 /. float_of_int (inc x))

(*evens*)
let evens n = 
build_list n (fun x -> 2 * x)

let identityM n =
build_list n 
(fun x -> 
(build_list n 
(fun y -> if y = x then 1 else 0)))

(*Zadanie 4*)

let empty_set = 
fun y -> false

let singleton a =
fun x -> if x = a then true else false

let in_set a s = 
s a

let union s t = 
fun x -> (in_set x s) || (in_set x t)

let intersect s t = 
fun x -> (in_set x s) && (in_set x t)

(*Zbior liczb nieparzystych*)
let odd_numbers =
fun x -> if x mod 2 = 1 then true else false
(*Zbior liczb od 0 do 10 naturalne*)
let some_set = 
fun x -> if x <= 10 && x >= 0 then true else false

(*Liczby nieparzyste z przedzialu 0:10*)
let example = intersect odd_numbers some_set


type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

(*Zadanie 5: czesc jest na kartce*)
let rec insert_bst t elem = 
match t with
| Leaf -> Node (Leaf, elem, Leaf)
| Node (l, v, r) -> if elem < v then Node ((insert_bst l elem), v, r)
else if elem > v then Node (l, v, (insert_bst r elem))
else Node (l, v, r)

(*insert-bst za pomoca folda*)
(*TODO*)

let example_tree =
Node (Node (Leaf, 2, Leaf), 
5, 
Node (Node (Leaf, 6, Leaf), 
8, 
Node (Leaf, 9, Leaf)))

(* Zadanie 6*)
let rec fold_tree f a t =
  match t with
  | Leaf -> a
  | Node (l, v, r) -> f (fold_tree f a l) v (fold_tree f a r) 

let tree_product t =
  fold_tree (fun x y z ->  x*y*z) 1 t
let tree_flip t = 
  fold_tree (fun x y z -> Node (z, y, x)) Leaf t
let tree_height t = 
  fold_tree (fun x y z -> if x > z then 1 + x else 1 + z) 
  0 t

let foo t =
  match t with
  | Leaf -> 0
  | Node (l, v, r) -> v

let min3 x y z = min (min x y) z
let max3 x y z = max (max x y) z

let tree_span t = 
  let init_v = foo t in
  fold_tree (fun x y z -> 
              (min3 (fst x) y (fst z)),
                          (max3 (snd x) y (snd z)) )
            (init_v, init_v)
            t

let preorder t =
  fold_tree (fun x y z -> y::[] @ x @ z)
            []
            t

(*Zadanie 7*)

let rec flat_append t xs =
  match t with
  | Leaf -> xs
  | Node (l, v, r) -> if (l = Leaf) && (r = Leaf) then v :: xs
                      else if (l = Leaf) && (r <> Leaf) then v :: (flat_append r xs)
                      else if (l <> Leaf) && (r = Leaf) then (flat_append l (v :: xs))
                      else flat_append l (v :: flat_append r xs)       (*MOZNA TYLKO TE LINIE, PRZEANALIZUJ TO*)

let flatt t = 
  flat_append t []

(*Zadanie 8*)

let rec insert_bst_d t elem = 
  match t with
  | Leaf -> Node (Leaf, elem, Leaf)
  | Node (l, v, r) -> if elem < v then Node ((insert_bst_d l elem), v, r)
  else if elem > v then Node (l, v, (insert_bst_d r elem))
  else Node (l, v, (insert_bst_d r elem))



let flatten t = fold_tree (fun l v r -> l @ [v] @ r) [] t


let tree_sort xs = 
  flatten (fold_left insert_bst_d Leaf xs)

(*Zadanie 9*)


let tree_sort_2 xs = 
  flatten (fold_left insert_bst_d Leaf xs)



  

(*  *)
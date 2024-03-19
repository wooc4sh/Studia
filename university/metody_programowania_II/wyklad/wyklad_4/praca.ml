(*
 Sygnatura kolekcji. Zawiera konstruktor pusty, peek
 *)

module type COLLECTION = sig
  type 'a coll
  val empty : 'a coll
  val peek : 'a coll -> 'a
  val push : 'a -> 'a coll -> 'a coll
  val pop : 'a coll -> 'a coll
end

(*Tu mamy przyklad modul kolejka, ktory spelnia te sygnature*)
module Queue : COLLECTION = struct
  type 'a coll = Queue of 'a list * 'a list

  let empty = Queue ([], [])

  let mk_queue = function
    | ([], ys) -> Queue (List.rev ys, [])
    | (xs, ys) -> Queue (xs, ys)

  let peek = function
    | Queue (x :: _, _) -> x
    | Queue ([], _) -> failwith "peek on empty queue"

  let push x (Queue (xs, ys)) = mk_queue (xs, x :: ys)

  let pop = function
    | Queue (_ :: xs, ys) -> mk_queue (xs, ys)
    | Queue ([], _) -> failwith "pop on empty queue"
end

(*A tu modul stos ktory rowniez spelnia te sygnature*)
module Stack : COLLECTION = struct
  type 'a coll = 'a list
  let empty = []
  let peek = function
    | [] -> failwith "peek on empty stack"
    | x :: _ -> x
  let pop = function
  | [] -> failwith "pop on empty stack"
  | _ :: xs -> xs
  let push x xs = x :: xs
end

(*Definicja typu drzewa*)
type 'a tree = Leaf | Node of 'a tree * 'a * 'a tree

(*Przykladowe drzewo*)
let ex_tree = Node (Node (Node (Leaf, 0, Leaf), 1, Node (Leaf, 2, Leaf)), 3, 
  Node (Leaf, 4, Node (Leaf, 5, Leaf)))


(*
 Generalnie funktor to taka funkcja, ktora bierze strukture i zwraca strukture 
 *)
module Search = functor (M : COLLECTION) -> struct
  open M
  let search t =
    let rec it q xs =
      if q = empty
      then List.rev xs
      else match peek q with
      | Leaf -> it (pop q) xs
      | Node (l, v, r) -> it (q |> pop |> push l |> push r) (v :: xs)
    in it (push t empty) []
end

module Bfs = Search (Queue)
module Dfs = Search (Stack)

let bfs = Bfs.search
let dfs = Dfs.search

module type DICT = sig
  type ('a, 'b) dict
  val empty : ('a, 'b) dict
  val insert : 'a -> 'b -> ('a, 'b) dict -> ('a, 'b) dict
  val remove : 'a -> ('a, 'b) dict -> ('a, 'b) dict
  val find_opt : 'a -> ('a, 'b) dict -> 'b option
  val find : 'a -> ('a, 'b) dict -> 'b
  val to_list : ('a, 'b) dict -> ('a * 'b) list
end

module ListDict : DICT = struct
  type ('a, 'b) dict = ('a * 'b) list
  let empty = []
  let remove k d = List.filter (fun (k', _) -> k <> k') d
  let insert k v d = (k, v) :: remove k d
  let find_opt k d = List.find_opt (fun (k', _) -> k = k') d |> Option.map snd
  let find k d = List.find (fun (k', _) -> k = k') d |> snd
  let to_list d = d
end

module type PRIO_QUEUE = sig
  type ('a, 'b) pq
  
  val empty : ('a, 'b) pq
  val insert : 'a -> 'b -> ('a, 'b) pq -> ('a, 'b) pq
  val pop : ('a, 'b) pq -> ('a, 'b) pq
  val min_with_prio : ('a, 'b) pq -> 'a * 'b
end

module ListPrioQueue : PRIO_QUEUE = struct
  type ('a, 'b) pq = ('a * 'b) list

  let empty = []
  let rec insert a x q = match q with
  | [] -> [a, x]
  | (b, y) :: ys -> if a < b then (a, x) :: q else (b, y) :: insert a x ys
  let pop q = List.tl q
  let min_with_prio q = List.hd q
end
 

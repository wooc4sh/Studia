module type PRIO_QUEUE = sig
  type ('a, 'b) pq
  
  val empty : ('a, 'b) pq
  val insert : 'a -> 'b -> ('a, 'b) pq -> ('a, 'b) pq
  val pop : ('a, 'b) pq -> ('a, 'b) pq
  val min_with_prio : ('a, 'b) pq -> 'a * 'b
end

module LeftistHeap : PRIO_QUEUE = struct

  exception Empty

  type ('a, 'b) pq =
    | HLeaf
    | HNode of int * ('a, 'b) pq * 'a * 'b * ('a, 'b) pq (*sie sklada z: ranga, lewe poddrzewo, element, priorytet, prawe poddrzewo*)

  let empty = HLeaf (*????*)

  let rank = function HLeaf -> 0 | HNode (n,_,_,_,_) -> n (*zwraca ranking*)

  let heap_ordered p = function (*predykat czesciowy porzadek*)
    | HLeaf -> true
    | HNode (_,_,p',_,_) -> p <= p' 

  let rec is_valid = function 
    | HLeaf -> true
    | HNode (n,l,p,v,r) -> 
        rank r <= rank l 
        && rank r + 1 = n
        && heap_ordered p l 
        && heap_ordered p r
        && is_valid l 
        && is_valid r

  let make_node p v l r = 
    let left_rank = rank l and right_rank = rank r in 
      if left_rank <= right_rank then HNode (left_rank + 1, r, v, p, l) (*to zamien*)
      else HNode (right_rank + 1, l, v, p, r)
  
  let rec merge_heap h1 h2 = 
    match h1, h2 with
    | t, HLeaf | HLeaf, t -> t
    | HNode (_, l, v, p1, r), HNode (_, _, _, p2, _) -> 
        if p1 > p2 then merge_heap h2 h1
        else let merged = merge_heap r h2 in 
        make_node p1 v l merged

  let singleton v p = HNode (0, HLeaf, v, p, HLeaf)

  let insert v p h = merge_heap (singleton v p) h 

  let pop = function
  | HLeaf -> raise Empty
  | HNode (n, l, p, v, r) -> merge_heap l r

  let min_with_prio = function
  | HLeaf -> raise Empty
  | HNode (_,_,p,v,_) -> (p, v)
  
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

module Pqsort = functor (M : PRIO_QUEUE) -> struct
  open M
  
  let foo xs = 
    List.fold_left (fun x y -> (insert y y x)) empty xs
  
  (*Zamienia liste na kolejke priorytetowa*)
  let solve xs = 
    let rec it acc ys =
      match ys with
      | [] -> acc
      | h :: t -> it (insert h h acc) t
    in it empty xs
  
  

  (*Zamienia kolejke priorytetowa na liste posortowana*)
  let bar = function
    | a, b -> a
  
  (*let z = (min_with_prio ys) in it (bar z) (pop ys)*)
  
  let resolve t = 
    let rec it acc ys =
      if ys = empty then List.rev acc
      else let p = min_with_prio ys in
      let q = bar p in it (q::acc) (pop ys)
      in it [] t
end

let ex_list = [3;1;8;12;7;21;19;42]

module A = Pqsort (ListPrioQueue)
module B = Pqsort (LeftistHeap)

let list_to_prio_list = A.solve
let list_to_left_heap = B.solve

let prio_list_to_list = A.resolve (list_to_prio_list ex_list)
let left_heap_to_list = B.resolve (list_to_left_heap ex_list)




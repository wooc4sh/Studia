module LeftistHeap = struct

  type ('a, 'b) heap =
    | HLeaf
    | HNode of int * ('a, 'b) heap * 'a * 'b * ('a, 'b) heap (*sie sklada z: ranga, lewe poddrzewo, element, priorytet, prawe poddrzewo*)

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

  let singleton v p = HNode (1, HLeaf, v, p, HLeaf)

  let insert v p h = merge_heap (singleton v p) h 
  
  let empty_heap = HLeaf (*????*)

end



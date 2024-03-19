module type DICT = sig
  type key
  type 'a dict
  val empty : 'a dict
  val insert : key -> 'a -> 'a dict -> 'a dict
  val remove : key -> 'a dict -> 'a dict
  val find_opt : key -> 'a dict -> 'a option 
  (*val find : key -> 'a dict -> 'a*)
  val to_list : 'a dict -> (key * 'a) list (*<- flat tree*)
end

module MyKey = struct
  type t = int
  let compare a1 a2 = a1 - a2;
end

module MakeListDict = functor (M : Map.OrderedType) -> struct  
  open M
  type key = t 

  type 'a dict = 
    | HLeaf
    | HNode of (int * 'a dict * key * 'a * 'a dict)

  let empty = HLeaf
  let rank = function HLeaf -> 0 | HNode (n,_,_,_,_) -> n


  let make_node p v l r = 
    let left_rank = rank l and right_rank = rank r in 
      if left_rank <= right_rank then HNode (left_rank + 1, r, p, v, l) (*to zamien*)
      else HNode (right_rank + 1, l, p, v, r)

  let rec merge_heap h1 h2 = 
    match h1, h2 with
    | t, HLeaf | HLeaf, t -> t
    | HNode (_, l, p1, v, r), HNode (_, _, p2, _, _) -> 
        if (compare p1 p2) > 0 then merge_heap h2 h1 (*<-- wazne*)
        else let merged = merge_heap r h2 in 
        make_node p1 v l merged


  let singleton p v = HNode (0, HLeaf, p, v, HLeaf)

  let insert p v h = merge_heap (singleton p v) h 

  let rec remove x = function 
    | HLeaf -> HLeaf
    | HNode (n,l,p,v,r) -> if (compare p x) = 0 then merge_heap l r else merge_heap (remove x l) (insert p v (remove x r))

  let rec find_opt k = function
    | HLeaf -> None
    | HNode (_,_,p,v,_) when (compare k p) = 0 -> Some v
    | HNode (_,l,p,v,r) when (compare k p) < 0 -> find_opt k l
    | HNode (_,l,p,v,r) when (compare k p) > 0 -> find_opt k r
    | HNode _ -> failwith "some error"

  let rec to_list t = 
    match t with
     | HLeaf -> []
     | HNode(n,l,p,v,r) -> List.append (to_list l) (List.cons (p, v) (to_list r))
  

  end

module CHarListDict : DICT = MakeListDict (MyKey)


  

  
  
  

  
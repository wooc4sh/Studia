module type HUFFMAN = sig 
  type 'a code_tree
  type 'a code_dict
  val code_tree : 'a list -> 'a code_tree
  val dict_of_code_tree : 'a code_tree -> 'a code_dict
  val encode : 'a list -> 'a code_dict -> int list
  val decode : int list -> 'a code_tree -> 'a list
end   

module type DICT = sig
  type ('a, 'b) dict
  val empty : ('a, 'b) dict
  val insert : 'a -> 'b -> ('a, 'b) dict -> ('a, 'b) dict
  val remove : 'a -> ('a, 'b) dict -> ('a, 'b) dict
  val find_opt : 'a -> ('a, 'b) dict -> 'b option
  val find : 'a -> ('a, 'b) dict -> 'b
  val to_list : ('a, 'b) dict -> ('a * 'b) list
end

module type PRIO_QUEUE = sig
  type ('a, 'b) pq
  
  val empty : ('a, 'b) pq
  val insert : 'a -> 'b -> ('a, 'b) pq -> ('a, 'b) pq
  val pop : ('a, 'b) pq -> ('a, 'b) pq
  val min_with_prio : ('a, 'b) pq -> 'a * 'b
end

module Hufman = functor (P : PRIO_QUEUE) (D : DICT) -> struct

  type 'a code_tree = CTNode of 'a code_tree * 'a code_tree | CTLeaf of 'a
  type 'a code_dict = ('a, int list) D.dict

  let find_else x d =
    Option.value ~default:0 (D.find_opt x d)
  
  let freq_dict xs =
    let rec it xs d =
      match xs with
      | [] -> d
      | x :: xs' -> 
        it xs' (D.insert x (1 + find_else x d) d)                        
    in it xs D.empty

  let rec algo q =
    let p1, t1 = P.min_with_prio q
    and q1 = P.pop q
    in if q1 = P.empty then t1
    else let p2, t2 = P.min_with_prio q1
    and q2 = P.pop q1
    in algo (P.insert (p1 + p2) (CTNode (t1, t2)) q2)
  
  let initial_pq xs =
    List.fold_left (fun q (x, n) -> P.insert n (CTLeaf x) q) P.empty xs
  
  let make_code_tree d = 
    D.to_list d |> initial_pq |> algo

  let dict_of_code_tree t =
    let rec aux t rcpref d =
      match t with
      | CTLeaf x -> D.insert x (List.rev rcpref) d
      | CTNode (l, r) -> aux l (0 :: rcpref) (aux r (1 :: rcpref) d)
    in aux t [] D.empty

  let encode (xs : 'a list) (d : 'a code_dict) =
    List.fold_right (@) (List.map (fun x -> D.find x d) xs) []

  let decode bs t =
    let rec walk bs cur_t =
      match cur_t with
      | CTLeaf v -> v :: start bs
      | CTNode (l, r) ->
        match bs with
        | 0 :: bs' -> walk bs' l
        | 1 :: bs' -> walk bs' r
        | _ :: _ -> failwith "a value other than 0 or 1 encountered"
        | [] -> failwith "incomplete code"
    and start bs =
      if bs = [] then [] else walk bs t
    in start bs

    let code_tree x = make_code_tree (freq_dict x)
    
  end

  module ListDict : DICT = struct
    type ('a, 'b) dict = ('a * 'b) list
    let empty = []
    let remove k d = List.filter (fun (k', _) -> k <> k') d
    let insert k v d = (k, v) :: remove k d
    let find_opt k d = List.find_opt (fun (k', _) -> k = k') d |> Option.map snd (**)
    let find k d = List.find (fun (k', _) -> k = k') d |> snd
    let to_list d = d
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




  module A : HUFFMAN = Hufman (LeftistHeap) (ListDict)

  let ex_string = "konstantynopolitańczykowianeczka"
  let list_of_string s = String.to_seq s |> List.of_seq
  let string_of_list s = List.to_seq s |> String.of_seq

  

  let ex_code_tree = A.code_tree (list_of_string ex_string)
  let ex_code_dict = A.dict_of_code_tree ex_code_tree

  let ex_encoded_string = A.encode (list_of_string ex_string) ex_code_dict
  let ex_decoded_list = A.decode ex_encoded_string ex_code_tree;;
  
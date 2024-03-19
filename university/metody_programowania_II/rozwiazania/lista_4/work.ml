(*module type X = sig
  exception Empty
  type 'a leftist
  val empty : 'a leftist
  val rank : 'a leftist -> int
  val merge : 'a leftist -> 'a leftist -> 'a leftist
  val get_min : 'a leftist -> 'a
  val delete_min : 'a leftist -> 'a leftist
  val make_node : 'a leftist -> 'a -> 'a leftist -> 'a leftist
end*)

module LeftistTree = struct

exception Empty

type 'a leftist = 
| Leaf
| Node of 'a leftist * 'a * 'a leftist * int

let empty = Leaf

let singleton k = Node (Leaf, k, Leaf, 1)

let rank = function
| Leaf -> 0
| Node (_,_,_,r) -> r

let make_node l v r = 
  let rank_left = rank l and rank_right = rank r in
  if rank_left >= rank_right then Node (l, v, r, rank_right + 1)
  else Node (r, v, l, rank_left + 1)

let rec merge t1 t2 =  
  match t1,t2 with
    | Leaf, t | t, Leaf -> t
    | Node (l, k1, r, _), Node (_, k2, _, _) ->
      if k1 > k2 then merge t2 t1 (* switch merge if necessary *)
      else 
        let merged = merge r t2 in (* always merge with right *)
        (*let rank_left = rank l and rank_right = rank merged in
        if rank_left >= rank_right then Node (l, k1, merged, rank_right+1)
        else Node (merged, k1, l, rank_left+1)*) (* left becomes right due to being shorter *)
        make_node l k1 merged

let insert x t = merge (singleton x) t

let rec delete x = function 
 | Leaf -> Leaf
 | Node (l, v, r, _) -> if v = x then merge l r else merge (delete x l) (insert v (delete x r))
                               

let get_min = function
| Leaf -> raise Empty
| Node (_,k,_,_) -> k

let delete_min = function
| Leaf -> raise Empty
| Node (l,_,r,_) -> merge l r
end
(*
module Temp (M : X) = struct
  open M

  let x = get_min

end

Czyli
Temp jest to funkcja ktora bierze strukture M o sygnaturze X i zwraca przerobiona strukture M 
jak to wyglada w praktyce:
Mamy funktor Temp, ktory bierze strukture o sygnaturze X
Sygnature taka ma np LeftistTree
Temp ma tylko jedn0 "pole" x jest to inna nazwa na funkcje get_min
Zatem: najpierw tworzymy modul B = temp (LeftistTree)
Czyli B jest to struktura LeftistTree przerobiona przez funktor Temp
Temp to biedna wersja LeftistTree bo ma tylko jedno pole x
Nastepnie mamy juz instancje LeftistTree mianowicie y 
B.x jest to funkcja ktora bierze drzewo lewicowe i zwraca jego x czyli get_min
B.x y zwroci nam element minimalny z drzewa y
*)

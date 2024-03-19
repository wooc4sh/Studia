(*module type DICT = sig
  type ('a, 'b) dict 
  val empty : ('a, 'b) dict 
  val insert : 'a -> 'b -> ('a, 'b) dict -> ('a, 'b) dict 
  val remove : 'a -> ('a, 'b) dict -> ('a, 'b) dict 
  val find_opt : 'a -> ('a, 'b) dict -> 'b option 
  val find : 'a -> ('a, 'b) dict -> 'b 
  val to_list : ('a, 'b) dict -> ('a * 'b) list 
end
*)

module type DICT = sig
  type key
  type 'a dict
  val empty : 'a dict
  val insert : key -> 'a -> 'a dict -> 'a dict
  val remove : key -> 'a dict -> 'a dict
  val find_opt : key -> 'a dict -> 'a option 
  val find : key -> 'a dict -> 'a
  val to_list : 'a dict -> (key * 'a) list
end
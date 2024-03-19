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

module MakeListDict = functor (M : Map.OrderedType) -> struct  
  open M

  type key = t 
  type 'a dict = (t * 'a) list

  let empty  = []
  let remove k d = List.filter (fun (k', _) -> (compare k k') <> 0) d
  let find_opt k d = List.find_opt (fun (k', _) -> (compare k k') = 0) d |> Option.map snd 
  let insert k v d = (k, v) :: remove k d
  let find k d = List.find (fun (k', _) -> (compare k k') = 0) d |> snd
  let to_list d = d

  end

module MyKey = struct
    type t = char
    let compare ch1 ch2 = (Char.code ch1) - (Char.code ch2);
  end

module CharListDict : (DICT with type key = MyKey.t) = MakeListDict (MyKey)

let example = CharListDict.empty

(*module ListDict : DICT = struct
  type ('a, 'b) dict = ('a * 'b) list
  let empty = []
  let remove k d = List.filter (fun (k', _) -> k <> k') d
  let insert k v d = (k, v) :: remove k d
  let find_opt k d = List.find_opt (fun (k', _) -> k = k') d |> Option.map snd (**)
  let find k d = List.find (fun (k', _) -> k = k') d |> snd
  let to_list d = d*)
  

  
  
  

  
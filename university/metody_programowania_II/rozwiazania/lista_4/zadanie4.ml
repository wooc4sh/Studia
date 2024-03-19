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

module MyKey = struct
    type t = char
    let compare ch1 ch2 = (Char.code ch1) - (Char.code ch2);
  end

module MakeMapDict = functor (M : Map.OrderedType) -> struct
  
  module Dict = Map.Make(M)

  type key = Dict.key
  type 'a dict =  'a Dict.t

  let remove = Dict.remove
  let empty = Dict.empty
  let find_opt = Dict.find_opt
  let find = Dict.find
  let insert = Dict.add
  let to_list = Dict.to_list

end

module CharMapDict : (DICT with type key = MyKey.t) = MakeMapDict (MyKey)

let example = CharMapDict.(insert 'a' 10 empty)


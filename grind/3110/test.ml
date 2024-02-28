let x : int = 3110

let val_of_option o b =
  match o with
    Some a -> a
    None -> b



type vec2 = float * float

let mk_vec x y = ((x,y) : vec2)

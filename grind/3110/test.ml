let x : int = 42




let rec append xs ys =
  match xs with
    | [] -> ys
    | h :: t -> h :: append t ys
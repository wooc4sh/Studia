let rec fib_rec n = 
  match n with
  | 0 -> 0
  | 1 -> 1
  | _ -> (fib_rec (n-1)) + (fib_rec (n-2))

let fib_iter n = 
  let rec it temp acc k =
    match k with
     | 0 -> temp
     | _ -> it acc (temp + acc) (k-1)
  in it 0 1 n
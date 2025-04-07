let user_input () =
  In_channel.input_lines In_channel.stdin
  |> List.map @@ String.split_on_char ' '
  |> List.map @@ List.filter (fun s -> String.length s <> 0)
  |> List.map @@ List.map @@ int_of_string
  |> List.map @@ fun xs -> (List.hd xs, List.hd (List.tl xs))

let answer =
  let xs, ys = user_input () |> List.split in
  let sorted_xs = List.sort Int.compare xs in
  let sorted_ys = List.sort Int.compare ys in
  List.fold_right2 (fun x y acc -> acc + Int.abs (x - y)) sorted_xs sorted_ys 0

let () = answer |> print_int

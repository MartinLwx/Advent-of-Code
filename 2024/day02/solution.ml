let is_safe line =
  match line |> String.split_on_char ' ' |> List.map int_of_string with
  | [] -> failwith "Impossible"
  | head :: rest ->
      let is_increasing, _ =
        rest
        |> List.fold_left
             (fun (status, last) x ->
               (status && 1 <= x - last && x - last <= 3, x))
             (true, head)
      in
      let is_decreasing, _ =
        rest
        |> List.fold_left
             (fun (status, last) x ->
               (status && 1 <= last - x && last - x <= 3, x))
             (true, head)
      in
      is_increasing || is_decreasing

let answer =
  In_channel.fold_lines
    (fun acc line ->
      if is_safe line then
        acc + 1
      else
        acc)
    0 In_channel.stdin

let () = answer |> print_int


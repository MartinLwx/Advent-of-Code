open Re

let parse_mul s =
  let ops =
    String.length s - 5 (* 'm', 'u', 'l', '(', '')' *)
    |> String.sub s 4 |> String.split_on_char ',' |> List.map int_of_string
  in
  List.hd ops * (List.hd @@ List.tl ops)

let process regex line =
  try
    line |> Re.all regex
    |> List.map (fun m -> Group.get m 0)
    |> List.map parse_mul |> List.fold_left ( + ) 0
  with Not_found -> 0

let answer =
  let r =
    Re.compile
      Re.(
        seq
          [
            str "mul(";
            repn digit 1 (Some 3);
            str ",";
            repn digit 1 (Some 3);
            str ")";
          ])
  in
  In_channel.fold_lines
    (fun acc line -> acc + process r line)
    0 In_channel.stdin

let () = answer |> print_int


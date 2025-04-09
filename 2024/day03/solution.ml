open Re

(** Parse mul(x,y) and return x*y **)
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
    |> List.fold_left
         (fun (acc, status) x ->
           match (status, x) with
           | `enable, "don't()" -> (acc, `disable)
           | `enable, "do()" -> (acc, `enable)
           | `enable, s -> (acc + parse_mul s, `enable)
           | `disable, "don't()" -> (acc, `disable)
           | `disable, "do()" -> (acc, `enable)
           | `disable, _ -> (acc, `disable))
         (0, `enable)
    |> fst
  with Not_found -> 0

let answer =
  let r =
    Re.compile
      Re.(
        alt
          [
            seq
              [
                str "mul(";
                repn digit 1 (Some 3);
                str ",";
                repn digit 1 (Some 3);
                str ")";
              ];
            str "do()";
            str "don't()";
          ])
  in
  In_channel.input_lines In_channel.stdin |> String.concat "\n" |> process r

let () = answer |> print_int


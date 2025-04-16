let read_matrix () =
  In_channel.input_lines In_channel.stdin
  |> List.map (fun s -> List.of_seq @@ String.to_seq s)
  |> List.map Array.of_list |> Array.of_list

let legal_str s = s = "MAS" || s = "SAM"

let legal_x_shape i j matrix =
  let s1 =
    [ matrix.(i - 1).(j - 1); matrix.(i).(j); matrix.(i + 1).(j + 1) ]
    |> List.to_seq |> String.of_seq
  in
  let s2 =
    [ matrix.(i + 1).(j - 1); matrix.(i).(j); matrix.(i - 1).(j + 1) ]
    |> List.to_seq |> String.of_seq
  in
  legal_str s1 && legal_str s2

let handle matrix =
  let m = Array.length matrix in
  let n = Array.length matrix.(0) in
  let ans = ref 0 in
  for i = 1 to m - 2 do
    for j = 1 to n - 2 do
      if legal_x_shape i j matrix then
        ans := 1 + !ans
    done
  done;
  !ans

let _ = read_matrix () |> handle |> print_int


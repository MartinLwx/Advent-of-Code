let count regex s = Re.all regex s |> List.length

let flip_horizontal matrix =
  matrix
  |> Array.map (fun row ->
         row |> Array.to_seq |> List.of_seq |> List.rev |> Array.of_list)

let transpose matrix =
  let m = Array.length matrix in
  let n = Array.length @@ matrix.(0) in
  let copy = Array.make_matrix n m '.' in
  for i = 0 to n - 1 do
    for j = 0 to m - 1 do
      copy.(i).(j) <- matrix.(j).(i)
    done
  done;
  copy

let get_diagonal matrix =
  let m = Array.length matrix in
  let n = Array.length matrix.(0) in
  let ans = ref [] in
  for k = 0 to m + n - 2 do
    let temp = ref [] in
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        if i + j = k then
          temp := matrix.(i).(j) :: !temp
      done
    done;
    ans := !temp :: !ans
  done;
  !ans

let get_another_diagonal matrix =
  let m = Array.length matrix in
  let n = Array.length matrix.(0) in
  let ans = ref [] in
  for k = n - 1 downto 1 - m do
    let temp = ref [] in
    for i = 0 to m - 1 do
      for j = 0 to n - 1 do
        if j - i = k then
          temp := matrix.(i).(j) :: !temp
      done
    done;
    ans := !temp :: !ans
  done;
  !ans

let to_str_list matrix =
  matrix
  |> Array.map (fun x -> x |> Array.to_seq |> String.of_seq)
  |> Array.to_list

let handle matrix =
  let regex = Re.compile @@ Re.str "XMAS" in
  let matrix_T = matrix |> transpose in
  let diagonal =
    matrix |> get_diagonal |> List.map Array.of_list |> Array.of_list
  in
  let another_agonal =
    matrix |> get_another_diagonal |> List.map Array.of_list |> Array.of_list
  in
  let choices =
    [
      matrix;
      matrix |> flip_horizontal;
      matrix_T;
      matrix_T |> flip_horizontal;
      diagonal;
      diagonal |> flip_horizontal;
      another_agonal;
      another_agonal |> flip_horizontal;
    ]
  in
  choices |> List.map to_str_list |> List.concat
  |> List.fold_left (fun acc x -> acc + count regex x) 0

let read_matrix () =
  In_channel.input_lines In_channel.stdin
  |> List.map (fun s -> List.of_seq @@ String.to_seq s)
  |> List.map Array.of_list |> Array.of_list

let _ = read_matrix () |> handle |> print_int


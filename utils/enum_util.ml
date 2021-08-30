let string_without_prefix s p =
  String.sub s p (String.length s - p)

let () =
  let channel = open_in Sys.argv.(1) in
  let rec loop a =
    try
      let line = input_line channel in
      loop (line::a)
    with End_of_file -> close_in channel; a
  in
  let lines = List.rev @@ loop [] in
  match lines with
  | prefix::type_name::names ->
    let prefix = int_of_string prefix in
    (* generate that bindings file *)
    Printf.printf "type %s =\n" type_name;
    List.iter (fun s ->
      Printf.printf "  | %s (** %s *)\n" (string_without_prefix s prefix) s
    ) names;
    Printf.printf "\nmodule Enums = functor (T : Cstubs.Types.TYPE) -> struct\n";
    List.iter (fun s ->
      Printf.printf "  let %s = T.constant \"%s\" T.int\n" (String.lowercase_ascii s) s
    ) names;
    Printf.printf "  let %s = T.enum \"%s\" ~typedef:true [\n" type_name (String.sub (List.hd names) 0 prefix);
    List.iter (fun s ->
      Printf.printf "    %s, %s;\n" (string_without_prefix s prefix) (String.lowercase_ascii s)
    ) names;
    Printf.printf "  ] ~unexpected:(fun _ -> raise (Invalid_argument \"Unknown enum value %s\"))\n" type_name;
    Printf.printf "end\n"
  |_ -> assert false

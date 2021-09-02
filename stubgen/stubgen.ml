let c_headers = "
#include <gurobi_c.h>
" (* can define own constants depending on C env *)

let () =
  let out = open_out "gurobi_types_gen.c" in
  let fmt = Format.formatter_of_out_channel out in
  Format.fprintf fmt "%s@\n" c_headers;
  Cstubs.Types.write_c fmt (module Bindings.Types);
  Format.pp_print_flush fmt ();
  close_out out;

  let out = open_out "gurobi_stubs.c" in
  let fmt = Format.formatter_of_out_channel out in
  Format.fprintf fmt "%s@\n" c_headers;
  Cstubs.write_c fmt ~prefix:"ml_gurobi_" (module Bindings.Stubs);
  Format.pp_print_flush fmt ();
  close_out out;

  let out = open_out "gurobi_generated.ml" in
  let fmt = Format.formatter_of_out_channel out in
  Cstubs.write_ml fmt ~prefix:"ml_gurobi_" (module Bindings.Stubs);
  Format.pp_print_flush fmt ();
  close_out out

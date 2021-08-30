open Gurobi
open Ctypes

let () =
  let env_ptr = allocate (ptr grb_Env) (from_voidp grb_Env null) in
  let err1 = loadenv env_ptr "gurobi.log" in
  let env = !@ env_ptr in

  let model_ptr = allocate (ptr grb_Model) (from_voidp grb_Model null) in
  let err2 = readmodel env "test.lp" model_ptr in
  let model = !@ model_ptr in
  let err3 = optimize model in
  ()

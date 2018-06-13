let () =
  try
    let env = C.loadenv () in
    let model = C.readmodel env "test.lp" in
    C.optimize model
  with C.GRBError (_,code,s) -> Printf.printf "Failed with exception %s (%d)\n" s code

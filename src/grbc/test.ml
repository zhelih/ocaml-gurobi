let () =
  let env = C.loadenv () in
  let model = C.readmodel env "test.lp" in
  C.optimize model

open Ctypes
open Foreign

type grb_Env
let grb_Env : grb_Env structure typ = structure "GRBEnv"
type grb_Model
let grb_Model : grb_Model structure typ = structure "GRBModel"

let optimize = foreign "GRBoptimize" ((ptr grb_Model) @-> returning int)
let loadenv = foreign "GRBloadenv" ((ptr (ptr grb_Env))  @-> string @-> returning int)
let readmodel = foreign "GRBreadmodel" ((ptr grb_Env) @-> string @-> (ptr (ptr grb_Model)) @-> returning int)

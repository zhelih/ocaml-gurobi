type grbModel
type grbEnv
external optimize: grbModel -> unit = "caml_grb_optimize"
external readmodel: grbEnv -> string -> grbModel = "caml_grb_readmodel"
external loadenv: ?logfile:string -> unit -> grbEnv = "caml_grb_loadenv"

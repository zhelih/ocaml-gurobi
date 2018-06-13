type grbModel
type grbEnv
type grbErrorCode =
  | GRB_ERROR_OUT_OF_MEMORY
  | GRB_ERROR_NULL_ARGUMENT
  | GRB_ERROR_INVALID_ARGUMENT
  | GRB_ERROR_UNKNOWN_ATTRIBUTE
  | GRB_ERROR_DATA_NOT_AVAILABLE
  | GRB_ERROR_INDEX_OUT_OF_RANGE
  | GRB_ERROR_UNKNOWN_PARAMETER
  | GRB_ERROR_VALUE_OUT_OF_RANGE
  | GRB_ERROR_NO_LICENSE
  | GRB_ERROR_SIZE_LIMIT_EXCEEDED
  | GRB_ERROR_CALLBACK
  | GRB_ERROR_FILE_READ
  | GRB_ERROR_FILE_WRITE
  | GRB_ERROR_NUMERIC
  | GRB_ERROR_IIS_NOT_INFEASIBLE
  | GRB_ERROR_NOT_FOR_MIP
  | GRB_ERROR_OPTIMIZATION_IN_PROGRESS
  | GRB_ERROR_DUPLICATES
  | GRB_ERROR_NODEFILE
  | GRB_ERROR_Q_NOT_PSD
  | GRB_ERROR_QCP_EQUALITY_CONSTRAINT
  | GRB_ERROR_NETWORK
  | GRB_ERROR_JOB_REJECTED
  | GRB_ERROR_NOT_SUPPORTED
  | GRB_ERROR_EXCEED_2B_NONZEROS
  | GRB_ERROR_INVALID_PIECEWISE_OBJ
  | GRB_ERROR_UPDATEMODE_CHANGE
  | GRB_ERROR_CLOUD
  | GRB_ERROR_MODEL_MODIFICATION
  | GRB_UNKNOWN

exception GRBError of (grbErrorCode * int * string)

external optimize: grbModel -> unit = "caml_grb_optimize"
external readmodel: grbEnv -> string -> grbModel = "caml_grb_readmodel"
external loadenv: ?logfile:string -> unit -> grbEnv = "caml_grb_loadenv"

let () = Callback.register_exception "GRBError" (GRBError (GRB_UNKNOWN, 0, ""))
let () = Printexc.register_printer (fun exn ->
  match exn with
  | GRBError (_, code, str) -> Some ("GRBError : " ^ str ^ " (" ^ string_of_int code ^ ")")
  | _ -> None
)

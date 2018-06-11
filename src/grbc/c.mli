type grbModel
type grbEnv
(*
(* version numbers *)
val grb_VERSION_MAJOR     : int
val grb_VERSION_MINOR     : int
val grb_VERSION_TECHNICAL : int

(* default and max priority for Compute Server jobs *)
val grb_DEFAULT_CS_PRIORITY : int
val grb_MAX_CS_PRIORITY     : int

(* error codes *)
type grbError =
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

(* constraint senses *)
type grbSense = GRB_LESS_EQUAL | GRB_GREATER_EQUAL | GRB_EQUAL

(* variable types *)
type grbVartype = GRB_CONTINUOUS | GRB_BINARY | GRB_INTEGER | GRB_SEMICONT | GRB_SEMIINT

(* objective sense *)
type grbObjsense = GRB_MINIMIZE | GRB_MAXIMIZE

(* SOS types *)
type grbSostype = GRB_SOS_TYPE1 | GRB_SOS_TYPE2

(* Numeric constants *)
val grb_INFINITY       : float
val grb_UNDEFINED      : float (* 1e100 ? *)
val grb_MAXINT         : int

(* Limits *)
val grb_MAX_NAMELEN    : int
val grb_MAX_STRLEN     : int
val grb_MAX_CONCURRENT : int

(* Model attributes *)
type grbAttr =
  | GRB_INT_ATTR_NUMCONSTRS        (* # of constraints *)
  | GRB_INT_ATTR_NUMVARS              (* # of vars *)
  | GRB_INT_ATTR_NUMSOS                (* # of sos constraints *)
  | GRB_INT_ATTR_NUMQCONSTRS      (* # of quadratic constraints *)
  | GRB_INT_ATTR_NUMGENCONSTRS  (* # of general constraints *)
  | GRB_INT_ATTR_NUMNZS                (* # of nz in A *)
  | GRB_DBL_ATTR_DNUMNZS              (* # of nz in A *)
  | GRB_INT_ATTR_NUMQNZS              (* # of nz in Q *)
  | GRB_INT_ATTR_NUMQCNZS            (* # of nz in q constraints *)
  | GRB_INT_ATTR_NUMINTVARS        (* # of integer vars *)
  | GRB_INT_ATTR_NUMBINVARS        (* # of binary vars *)
  | GRB_INT_ATTR_NUMPWLOBJVARS  (* # of variables with PWL obj. *)
  | GRB_STR_ATTR_MODELNAME          (* model name *)
  | GRB_INT_ATTR_MODELSENSE        (* 1=min, -1=max *)
  | GRB_DBL_ATTR_OBJCON                (* Objective constant *)
  | GRB_INT_ATTR_IS_MIP                 (* Is model a MIP? *)
  | GRB_INT_ATTR_IS_QP                   (* Model has quadratic obj? *)
  | GRB_INT_ATTR_IS_QCP                 (* Model has quadratic constr? *)
  | GRB_STR_ATTR_SERVER                (* Name of compute server *)

(* Variable attributes *)

  | GRB_DBL_ATTR_LB                           (* Lower bound *)
  | GRB_DBL_ATTR_UB                           (* Upper bound *)
  | GRB_DBL_ATTR_OBJ                         (* Objective coeff *)
  | GRB_CHAR_ATTR_VTYPE                    (* Integrality type *)
  | GRB_DBL_ATTR_START                     (* MIP start value *)
  | GRB_DBL_ATTR_PSTART                   (* LP primal solution warm start *)
  | GRB_INT_ATTR_BRANCHPRIORITY   (* MIP branch priority *)
  | GRB_STR_ATTR_VARNAME                 (* Variable name *)
  | GRB_INT_ATTR_PWLOBJCVX             (* Convexity of variable PWL obj *)
  | GRB_DBL_ATTR_VARHINTVAL
  | GRB_INT_ATTR_VARHINTPRI

(* Constraint attributes *)

  | GRB_DBL_ATTR_RHS                (* RHS *)
  | GRB_DBL_ATTR_DSTART          (* LP dual solution warm start *)
  | GRB_CHAR_ATTR_SENSE           (* Sense ('<', '>', or '=') *)
  | GRB_STR_ATTR_CONSTRNAME  (* Constraint name *)
  | GRB_INT_ATTR_LAZY              (* Lazy constraint? *)

(* Quadratic constraint attributes *)

  | GRB_DBL_ATTR_QCRHS       (* QC RHS *)
  | GRB_CHAR_ATTR_QCSENSE  (* QC sense ('<', '>', or '=') *)
  | GRB_STR_ATTR_QCNAME     (* QC name *)

(* General constraint attributes *)

  | GRB_INT_ATTR_GENCONSTRTYPE    (* Type of general constraint *)
  | GRB_STR_ATTR_GENCONSTRNAME    (* Name of general constraint *)

(* Model statistics *)

  | GRB_DBL_ATTR_MAX_COEFF           (* Max (abs) nz coeff in A *)
  | GRB_DBL_ATTR_MIN_COEFF           (* Min (abs) nz coeff in A *)
  | GRB_DBL_ATTR_MAX_BOUND           (* Max (abs) finite var bd *)
  | GRB_DBL_ATTR_MIN_BOUND           (* Min (abs) var bd *)
  | GRB_DBL_ATTR_MAX_OBJ_COEFF    (* Max (abs) obj coeff *)
  | GRB_DBL_ATTR_MIN_OBJ_COEFF    (* Min (abs) obj coeff *)
  | GRB_DBL_ATTR_MAX_RHS               (* Max (abs) rhs coeff *)
  | GRB_DBL_ATTR_MIN_RHS               (* Min (abs) rhs coeff *)
  | GRB_DBL_ATTR_MAX_QCCOEFF       (* Max (abs) nz coeff in Q *)
  | GRB_DBL_ATTR_MIN_QCCOEFF       (* Min (abs) nz coeff in Q *)
  | GRB_DBL_ATTR_MAX_QOBJ_COEFF  (* Max (abs) obj coeff of quadratic part *)
  | GRB_DBL_ATTR_MIN_QOBJ_COEFF  (* Min (abs) obj coeff of quadratic part *)

(* Model solution attributes *)

  | GRB_DBL_ATTR_RUNTIME            (* Run time for optimization *)
  | GRB_INT_ATTR_STATUS              (* Optimization status *)
  | GRB_DBL_ATTR_OBJVAL              (* Solution objective *)
  | GRB_DBL_ATTR_OBJBOUND          (* Best bound on solution *)
  | GRB_DBL_ATTR_OBJBOUNDC        (* Continuous bound *)
  | GRB_DBL_ATTR_POOLOBJBOUND   (* Best bound on pool solution *)
  | GRB_DBL_ATTR_POOLOBJVAL      (* Solution objective for solutionnumber *)
  | GRB_DBL_ATTR_MIPGAP              (* MIP optimality gap *)
  | GRB_INT_ATTR_SOLCOUNT          (* # of solutions found *)
  | GRB_DBL_ATTR_ITERCOUNT        (* Iters performed (simplex) *)
  | GRB_INT_ATTR_BARITERCOUNT   (* Iters performed (barrier) *)
  | GRB_DBL_ATTR_NODECOUNT         (* Nodes explored (B&C) *)
  | GRB_DBL_ATTR_OPENNODECOUNT  (* Unexplored nodes (B&C) *)
  | GRB_INT_ATTR_HASDUALNORM     (* 0, no basis,
                                                     1, has basis, so can be computed
                                                     2, available *)

(* Variable attributes related to the current solution *)

  | GRB_DBL_ATTR_X                  (* Solution value *)
  | GRB_DBL_ATTR_XN                (* Alternate MIP solution *)
  | GRB_DBL_ATTR_BARX            (* Best barrier iterate *)
  | GRB_DBL_ATTR_RC                (* Reduced costs *)
  | GRB_DBL_ATTR_VDUALNORM  (* Dual norm square *)
  | GRB_INT_ATTR_VBASIS        (* Variable basis status *)

(* Constraint attributes related to the current solution *)

  | GRB_DBL_ATTR_PI                (* Dual value *)
  | GRB_DBL_ATTR_QCPI            (* Dual value for QC *)
  | GRB_DBL_ATTR_SLACK          (* Constraint slack *)
  | GRB_DBL_ATTR_QCSLACK      (* QC Constraint slack *)
  | GRB_DBL_ATTR_CDUALNORM  (* Dual norm square *)
  | GRB_INT_ATTR_CBASIS        (* Constraint basis status *)

(* Solution quality attributes *)

  | GRB_DBL_ATTR_BOUND_VIO
  | GRB_DBL_ATTR_BOUND_SVIO
  | GRB_INT_ATTR_BOUND_VIO_INDEX
  | GRB_INT_ATTR_BOUND_SVIO_INDEX
  | GRB_DBL_ATTR_BOUND_VIO_SUM
  | GRB_DBL_ATTR_BOUND_SVIO_SUM
  | GRB_DBL_ATTR_CONSTR_VIO
  | GRB_DBL_ATTR_CONSTR_SVIO
  | GRB_INT_ATTR_CONSTR_VIO_INDEX
  | GRB_INT_ATTR_CONSTR_SVIO_INDEX
  | GRB_DBL_ATTR_CONSTR_VIO_SUM
  | GRB_DBL_ATTR_CONSTR_SVIO_SUM
  | GRB_DBL_ATTR_CONSTR_RESIDUAL
  | GRB_DBL_ATTR_CONSTR_SRESIDUAL
  | GRB_INT_ATTR_CONSTR_RESIDUAL_INDEX
  | GRB_INT_ATTR_CONSTR_SRESIDUAL_INDEX
  | GRB_DBL_ATTR_CONSTR_RESIDUAL_SUM
  | GRB_DBL_ATTR_CONSTR_SRESIDUAL_SUM
  | GRB_DBL_ATTR_DUAL_VIO
  | GRB_DBL_ATTR_DUAL_SVIO
  | GRB_INT_ATTR_DUAL_VIO_INDEX
  | GRB_INT_ATTR_DUAL_SVIO_INDEX
  | GRB_DBL_ATTR_DUAL_VIO_SUM
  | GRB_DBL_ATTR_DUAL_SVIO_SUM
  | GRB_DBL_ATTR_DUAL_RESIDUAL
  | GRB_DBL_ATTR_DUAL_SRESIDUAL
  | GRB_INT_ATTR_DUAL_RESIDUAL_INDEX
  | GRB_INT_ATTR_DUAL_SRESIDUAL_INDEX
  | GRB_DBL_ATTR_DUAL_RESIDUAL_SUM
  | GRB_DBL_ATTR_DUAL_SRESIDUAL_SUM
  | GRB_DBL_ATTR_INT_VIO
  | GRB_INT_ATTR_INT_VIO_INDEX
  | GRB_DBL_ATTR_INT_VIO_SUM
  | GRB_DBL_ATTR_COMPL_VIO
  | GRB_INT_ATTR_COMPL_VIO_INDEX
  | GRB_DBL_ATTR_COMPL_VIO_SUM
  | GRB_DBL_ATTR_KAPPA
  | GRB_DBL_ATTR_KAPPA_EXACT
  | GRB_DBL_ATTR_N2KAPPA

(* LP sensitivity analysis *)

  | GRB_DBL_ATTR_SA_OBJLOW
  | GRB_DBL_ATTR_SA_OBJUP
  | GRB_DBL_ATTR_SA_LBLOW
  | GRB_DBL_ATTR_SA_LBUP
  | GRB_DBL_ATTR_SA_UBLOW
  | GRB_DBL_ATTR_SA_UBUP
  | GRB_DBL_ATTR_SA_RHSLOW
  | GRB_DBL_ATTR_SA_RHSUP

(* IIS *)

  | GRB_INT_ATTR_IIS_MINIMAL      (* Boolean: Is IIS Minimal? *)
  | GRB_INT_ATTR_IIS_LB                (* Boolean: Is var LB in IIS? *)
  | GRB_INT_ATTR_IIS_UB                (* Boolean: Is var UB in IIS? *)
  | GRB_INT_ATTR_IIS_CONSTR        (* Boolean: Is constr in IIS? *)
  | GRB_INT_ATTR_IIS_SOS              (* Boolean: Is SOS in IIS? *)
  | GRB_INT_ATTR_IIS_QCONSTR      (* Boolean: Is QConstr in IIS? *)
  | GRB_INT_ATTR_IIS_GENCONSTR  (* Boolean: Is general constr in IIS? *)

(* Tuning *)

  | GRB_INT_ATTR_TUNE_RESULTCOUNT

(* Advanced simplex features *)

  | GRB_DBL_ATTR_FARKASDUAL
  | GRB_DBL_ATTR_FARKASPROOF
  | GRB_DBL_ATTR_UNBDRAY
  | GRB_INT_ATTR_INFEASVAR
  | GRB_INT_ATTR_UNBDVAR

(* Presolve attribute *)

  | GRB_INT_ATTR_VARPRESTAT
  | GRB_DBL_ATTR_PREFIXVAL

(* Multi objective attribute, controlled by parameter ObjNumber (= i) *)

  | GRB_DBL_ATTR_OBJN                  (* ith objective *)
  | GRB_DBL_ATTR_OBJNVAL            (* Solution objective for Multi-objectives *)
  | GRB_DBL_ATTR_OBJNCON            (* constant term *)
  | GRB_DBL_ATTR_OBJNWEIGHT      (* weight *)
  | GRB_INT_ATTR_OBJNPRIORITY  (* priority *)
  | GRB_DBL_ATTR_OBJNRELTOL      (* relative tolerance *)
  | GRB_DBL_ATTR_OBJNABSTOL      (* absolute tolerance *)
  | GRB_STR_ATTR_OBJNNAME          (* name *)
  | GRB_INT_ATTR_NUMOBJ              (* number of objectives *)

(* Alternate define *)

  | GRB_DBL_ATTR_Xn

type grbGeneral =
  | GRB_GENCONSTR_MAX
  | GRB_GENCONSTR_MIN
  | GRB_GENCONSTR_ABS
  | GRB_GENCONSTR_AND
  | GRB_GENCONSTR_OR
  | GRB_GENCONSTR_INDICATOR

type grbDataType = Char | Int | Double | String (* type of the data in attribute *)
(* type of the attribute *)
type grbAttrType =
| Model (* model attribute *)
| Variable (* variable attribute *)
| Linear (* linear constraint attribute *)
| SOS (* SOS constraint attribute *)
| Quadratic (* quadratic constraint attribute *)
| General (* general constraint attribute *)
val string_of_attr : grbAttr -> string
val getattrinfo: grbModel -> grbAttr -> grbDataType * grbAttrType * bool (* bool indicates if settable *)
val getattrinfo_s: grbModel -> string -> grbDataType * grbAttrType * bool (* bool indicates if settable *)
val isattravailable: grbModel -> grbAttr -> bool
type grbAttrData = Char of char | Int of int | Double of float | String of string | Bool of bool
val getattr: grbModel -> grbAttr -> grbAttrData
val setattr: grbModel -> grbAttr -> grbAttrData -> unit

(* Callback *)
(*TODO *)

val getcoeff: grbModel -> int -> int -> float
(*TODO constraints management *)
*)
val optimize: grbModel -> unit
(*
val optimizeasync: grbModel -> unit
val copymodel: grbModel -> grbModel
val fixedmodel: grbModel -> grbModel
*)
val readmodel: grbEnv -> string -> grbModel
(*val read: grbModel -> string -> unit (* read into existing model *)
val write: grbModel -> string -> unit
val ismodelfile: string -> bool
(*TODO newmodel and addition of constraints *)

val updatemodel: grbModel -> unit
val resetmodel: grbModel -> unit
val freemodel: grbModel -> unit (* shall we? *)
val coumputeIIS: grbModel -> unit

(*TODO parameters *)
val getenv: grbModel -> grbEnv

val sync: grbModel -> unit (* Wait for a previous asynchronous optimization call to complete. *)
*)

val loadenv: ?logfile:string -> unit -> grbEnv

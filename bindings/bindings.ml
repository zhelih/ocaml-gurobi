type grb_error =
  | OUT_OF_MEMORY (** GRB_ERROR_OUT_OF_MEMORY *)
  | NULL_ARGUMENT (** GRB_ERROR_NULL_ARGUMENT *)
  | INVALID_ARGUMENT (** GRB_ERROR_INVALID_ARGUMENT *)
  | UNKNOWN_ATTRIBUTE (** GRB_ERROR_UNKNOWN_ATTRIBUTE *)
  | DATA_NOT_AVAILABLE (** GRB_ERROR_DATA_NOT_AVAILABLE *)
  | INDEX_OUT_OF_RANGE (** GRB_ERROR_INDEX_OUT_OF_RANGE *)
  | UNKNOWN_PARAMETER (** GRB_ERROR_UNKNOWN_PARAMETER *)
  | VALUE_OUT_OF_RANGE (** GRB_ERROR_VALUE_OUT_OF_RANGE *)
  | NO_LICENSE (** GRB_ERROR_NO_LICENSE *)
  | SIZE_LIMIT_EXCEEDED (** GRB_ERROR_SIZE_LIMIT_EXCEEDED *)
  | CALLBACK (** GRB_ERROR_CALLBACK *)
  | FILE_READ (** GRB_ERROR_FILE_READ *)
  | FILE_WRITE (** GRB_ERROR_FILE_WRITE *)
  | NUMERIC (** GRB_ERROR_NUMERIC *)
  | IIS_NOT_INFEASIBLE (** GRB_ERROR_IIS_NOT_INFEASIBLE *)
  | NOT_FOR_MIP (** GRB_ERROR_NOT_FOR_MIP *)
  | OPTIMIZATION_IN_PROGRESS (** GRB_ERROR_OPTIMIZATION_IN_PROGRESS *)
  | DUPLICATES (** GRB_ERROR_DUPLICATES *)
  | NODEFILE (** GRB_ERROR_NODEFILE *)
  | Q_NOT_PSD (** GRB_ERROR_Q_NOT_PSD *)
  | QCP_EQUALITY_CONSTRAINT (** GRB_ERROR_QCP_EQUALITY_CONSTRAINT *)
  | NETWORK (** GRB_ERROR_NETWORK *)
  | JOB_REJECTED (** GRB_ERROR_JOB_REJECTED *)
  | NOT_SUPPORTED (** GRB_ERROR_NOT_SUPPORTED *)
  | EXCEED_2B_NONZEROS (** GRB_ERROR_EXCEED_2B_NONZEROS *)
  | INVALID_PIECEWISE_OBJ (** GRB_ERROR_INVALID_PIECEWISE_OBJ *)
  | UPDATEMODE_CHANGE (** GRB_ERROR_UPDATEMODE_CHANGE *)
  | CLOUD (** GRB_ERROR_CLOUD *)
  | MODEL_MODIFICATION (** GRB_ERROR_MODEL_MODIFICATION *)

module Enums = functor (T : Cstubs.Types.TYPE) -> struct
  let grb_error_out_of_memory = T.constant "GRB_ERROR_OUT_OF_MEMORY" T.int
  let grb_error_null_argument = T.constant "GRB_ERROR_NULL_ARGUMENT" T.int
  let grb_error_invalid_argument = T.constant "GRB_ERROR_INVALID_ARGUMENT" T.int
  let grb_error_unknown_attribute = T.constant "GRB_ERROR_UNKNOWN_ATTRIBUTE" T.int
  let grb_error_data_not_available = T.constant "GRB_ERROR_DATA_NOT_AVAILABLE" T.int
  let grb_error_index_out_of_range = T.constant "GRB_ERROR_INDEX_OUT_OF_RANGE" T.int
  let grb_error_unknown_parameter = T.constant "GRB_ERROR_UNKNOWN_PARAMETER" T.int
  let grb_error_value_out_of_range = T.constant "GRB_ERROR_VALUE_OUT_OF_RANGE" T.int
  let grb_error_no_license = T.constant "GRB_ERROR_NO_LICENSE" T.int
  let grb_error_size_limit_exceeded = T.constant "GRB_ERROR_SIZE_LIMIT_EXCEEDED" T.int
  let grb_error_callback = T.constant "GRB_ERROR_CALLBACK" T.int
  let grb_error_file_read = T.constant "GRB_ERROR_FILE_READ" T.int
  let grb_error_file_write = T.constant "GRB_ERROR_FILE_WRITE" T.int
  let grb_error_numeric = T.constant "GRB_ERROR_NUMERIC" T.int
  let grb_error_iis_not_infeasible = T.constant "GRB_ERROR_IIS_NOT_INFEASIBLE" T.int
  let grb_error_not_for_mip = T.constant "GRB_ERROR_NOT_FOR_MIP" T.int
  let grb_error_optimization_in_progress = T.constant "GRB_ERROR_OPTIMIZATION_IN_PROGRESS" T.int
  let grb_error_duplicates = T.constant "GRB_ERROR_DUPLICATES" T.int
  let grb_error_nodefile = T.constant "GRB_ERROR_NODEFILE" T.int
  let grb_error_q_not_psd = T.constant "GRB_ERROR_Q_NOT_PSD" T.int
  let grb_error_qcp_equality_constraint = T.constant "GRB_ERROR_QCP_EQUALITY_CONSTRAINT" T.int
  let grb_error_network = T.constant "GRB_ERROR_NETWORK" T.int
  let grb_error_job_rejected = T.constant "GRB_ERROR_JOB_REJECTED" T.int
  let grb_error_not_supported = T.constant "GRB_ERROR_NOT_SUPPORTED" T.int
  let grb_error_exceed_2b_nonzeros = T.constant "GRB_ERROR_EXCEED_2B_NONZEROS" T.int
  let grb_error_invalid_piecewise_obj = T.constant "GRB_ERROR_INVALID_PIECEWISE_OBJ" T.int
  let grb_error_updatemode_change = T.constant "GRB_ERROR_UPDATEMODE_CHANGE" T.int
  let grb_error_cloud = T.constant "GRB_ERROR_CLOUD" T.int
  let grb_error_model_modification = T.constant "GRB_ERROR_MODEL_MODIFICATION" T.int
end

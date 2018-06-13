#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/callback.h>

#ifndef Val_none
#define Val_none Val_int(0)
#endif

#include <gurobi_c.h>
#include <string.h>

#ifdef __cplusplus
#define extern "C" {
#endif

/* Accessing the T* part of an OCaml custom block */
#define Pointer_val(v, T) (*((T **) Data_custom_val(v)))

// safe string handling, call free for a var afterwards
#define safe_string_val(v, var) \
  int _len = caml_string_length(v); \
  const char* _s_start = String_val(v); \
  char* var = malloc((_len+1)*sizeof(char)); \
  memcpy(var, _s_start, sizeof(char)*(_len+1)); // guaranteed to finish with \0 in OCaml runtime

// returning a pointer
#define return_ptr(ptr) \
  v_res = caml_alloc_custom(&objst_custom_ops, sizeof(void*), 0, 1); \
  memcpy(Data_custom_val(v_res), &ptr, sizeof(void*)); \
  CAMLreturn(v_res); 

// defaults for custom objects
static struct custom_operations objst_custom_ops = {
    identifier: "pointer handling",
    finalize:    custom_finalize_default,
    compare:     custom_compare_default,
    hash:        custom_hash_default,
    serialize:   custom_serialize_default,
    deserialize: custom_deserialize_default
};

// error map
typedef struct GRBErrorMapping GRBErrorMapping;
struct GRBErrorMapping
{
  char* name;
  int error;
};

GRBErrorMapping errorMap[] =
{
  {"GRB_ERROR_OUT_OF_MEMORY", GRB_ERROR_OUT_OF_MEMORY},
  {"GRB_ERROR_NULL_ARGUMENT", GRB_ERROR_NULL_ARGUMENT},
  {"GRB_ERROR_INVALID_ARGUMENT", GRB_ERROR_INVALID_ARGUMENT},
  {"GRB_ERROR_UNKNOWN_ATTRIBUTE", GRB_ERROR_UNKNOWN_ATTRIBUTE},
  {"GRB_ERROR_DATA_NOT_AVAILABLE", GRB_ERROR_DATA_NOT_AVAILABLE},
  {"GRB_ERROR_INDEX_OUT_OF_RANGE", GRB_ERROR_INDEX_OUT_OF_RANGE},
  {"GRB_ERROR_UNKNOWN_PARAMETER", GRB_ERROR_UNKNOWN_PARAMETER},
  {"GRB_ERROR_VALUE_OUT_OF_RANGE", GRB_ERROR_VALUE_OUT_OF_RANGE},
  {"GRB_ERROR_NO_LICENSE", GRB_ERROR_NO_LICENSE},
  {"GRB_ERROR_SIZE_LIMIT_EXCEEDED", GRB_ERROR_SIZE_LIMIT_EXCEEDED},
  {"GRB_ERROR_CALLBACK", GRB_ERROR_CALLBACK},
  {"GRB_ERROR_FILE_READ", GRB_ERROR_FILE_READ},
  {"GRB_ERROR_FILE_WRITE", GRB_ERROR_FILE_WRITE},
  {"GRB_ERROR_NUMERIC", GRB_ERROR_NUMERIC},
  {"GRB_ERROR_IIS_NOT_INFEASIBLE", GRB_ERROR_IIS_NOT_INFEASIBLE},
  {"GRB_ERROR_NOT_FOR_MIP", GRB_ERROR_NOT_FOR_MIP},
  {"GRB_ERROR_OPTIMIZATION_IN_PROGRESS", GRB_ERROR_OPTIMIZATION_IN_PROGRESS},
  {"GRB_ERROR_DUPLICATES", GRB_ERROR_DUPLICATES},
  {"GRB_ERROR_NODEFILE", GRB_ERROR_NODEFILE},
  {"GRB_ERROR_Q_NOT_PSD", GRB_ERROR_Q_NOT_PSD},
  {"GRB_ERROR_QCP_EQUALITY_CONSTRAINT", GRB_ERROR_QCP_EQUALITY_CONSTRAINT},
  {"GRB_ERROR_NETWORK", GRB_ERROR_NETWORK},
  {"GRB_ERROR_JOB_REJECTED", GRB_ERROR_JOB_REJECTED},
  {"GRB_ERROR_NOT_SUPPORTED", GRB_ERROR_NOT_SUPPORTED},
  {"GRB_ERROR_EXCEED_2B_NONZEROS", GRB_ERROR_EXCEED_2B_NONZEROS},
  {"GRB_ERROR_INVALID_PIECEWISE_OBJ", GRB_ERROR_INVALID_PIECEWISE_OBJ},
  {"GRB_ERROR_UPDATEMODE_CHANGE", GRB_ERROR_UPDATEMODE_CHANGE},
  {"GRB_ERROR_CLOUD", GRB_ERROR_CLOUD},
  {"GRB_ERROR_MODEL_MODIFICATION", GRB_ERROR_MODEL_MODIFICATION},
  {NULL, 0} // see raiseError
};

static void raiseError(int code)
{
  CAMLparam0();
  CAMLlocal1(exceptionData);
  value* exception;
  char* errorString = "Unknown Error";
  int i;

  for(i = 0; errorMap[i].name != NULL; ++i)
  {
    if(errorMap[i].error == code)
    {
      errorString = errorMap[i].name;
      break;
    }
  }

  exceptionData = caml_alloc_tuple(3);
  Store_field(exceptionData, 0, Val_int(i));
  Store_field(exceptionData, 1, Val_int(code));
  Store_field(exceptionData, 2, caml_copy_string(errorString));

  exception = caml_named_value("GRBError");
  if(exception == NULL)
    caml_failwith("GRBError not registered");
  caml_raise_with_arg(*exception, exceptionData);

  CAMLreturn0;
}

static void check(int code)
{
  if(code)
    raiseError(code);
}

CAMLprim value caml_grb_optimize(value v_model)
{
  CAMLparam1(v_model);
  GRBmodel* model = Pointer_val(v_model, GRBmodel);
  int err = GRBoptimize(model);
  check(err);
  CAMLreturn(Val_unit);
}

CAMLprim value caml_grb_readmodel(value v_env, value v_fname)
{
  CAMLparam2(v_env, v_fname);
  CAMLlocal1(v_res);
  GRBenv* env = Pointer_val(v_env, GRBenv);
  // safe string handling
  safe_string_val(v_fname, fname);

  GRBmodel* model;
  int err = GRBreadmodel(env, fname, &model);
  free(fname);
  check(err);
  return_ptr(model);
}

CAMLprim value caml_grb_loadenv(value v_logfile, value v_unit)
{
  CAMLparam2(v_logfile, v_unit);
  CAMLlocal1(v_res);
  GRBenv* env;
  int err;
  if(v_logfile == Val_none)
    err = GRBloadenv(&env, NULL);
  else {
    safe_string_val(v_logfile, logfile);
    err = GRBloadenv(&env, logfile);
    free(logfile);
  }
  check(err);
  return_ptr(env);
}
#ifdef __cplusplus
}
#endif

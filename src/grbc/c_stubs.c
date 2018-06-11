#ifdef __cplusplus
#define extern "C" {
#endif

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>

#ifndef Val_none
#define Val_none Val_int(0)
#endif

#include <gurobi_c.h>
#include <string.h>

/* Accessing the T* part of an OCaml custom block */
#define Pointer_val(v, T) (*((T **) Data_custom_val(v)))

// safe string handling, call free for a var afterwards
#define safe_string_val(v, var) \
  int _len = caml_string_length(v); \
  const char* _s_start = String_val(v); \
  char* var = malloc((_len+1)*sizeof(char)); \
  memcpy(var, _s_start, sizeof(char)*(_len+1));

// GUROBI error handling
inline void fail() { caml_failwith("GUROBI error"); }

// returning a pointer
#define return_ptr(ptr) \
  v_res = caml_alloc_custom(&objst_custom_ops, sizeof(void*), 0, 1); \
  memcpy(Data_custom_val(v_res), &ptr, sizeof(void*)); \
  CAMLreturn(v_res); 

// defaults for custom objects
static struct custom_operations objst_custom_ops = {
    identifier: "obj_st handling",
    finalize:    custom_finalize_default,
    compare:     custom_compare_default,
    hash:        custom_hash_default,
    serialize:   custom_serialize_default,
    deserialize: custom_deserialize_default
};

CAMLprim value caml_grb_optimize(value v_model)
{
  CAMLparam1(v_model);
  GRBmodel* model = Pointer_val(v_model, GRBmodel);
  int err = GRBoptimize(model);
  if(err)
    fail();
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
  if(err)
    fail();
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
  if(err)
    fail();
  return_ptr(env);
}
#ifdef __cplusplus
}
#endif



#ifdef __cplusplus
#define extern "C" {
#endif

#include <caml/mlvalues.h>
#include <gurobi_c.h>

CAMLprim value
caml_print_hello(value unit)
{
  printf("Hello\n");
  return Val_unit;
}

#ifdef __cplusplus
}
#endif



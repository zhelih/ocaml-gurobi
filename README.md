# ocaml-gurobi

OCaml bindings to [GUROBI](http://www.gurobi.com/products/gurobi-optimizer), a commericial LP
solver. You MUST have the solver already installed in your system with a valid license for the use.

Released under the terms of LGPL-2.1 with OCaml linking exception.

Build
-----

After installing the C library make sure $GUROBI_HOME is defined.
Now we need to make includes and libraries visible to the C compiler (and dynamic linker), e.g. build with:

  C_INCLUDE_PATH=$GUROBI_HOME/include LIBRARY_PATH=$GUROBI_HOME/lib make

Another way (more permanent) is something like the following:

  ln -s $GUROBI_HOME/include/*.h /usr/include/
  cp $GUROBI_HOME/lib/*.so* /usr/local/lib/
  ldconfig

then

  make

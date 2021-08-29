default:
	$(MAKE) C_INCLUDE_PATH=$(GUROBI_HOME)/include LIBRARY_PATH=$(GUROBI_HOME)/lib build

build:
	dune build

doc:
	dune build @doc

clean:
	dune clean

.PHONY: build doc clean

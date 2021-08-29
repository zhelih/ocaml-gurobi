build:
	dune build

doc:
	dune build @doc

clean:
	dune clean

.PHONY: build doc clean

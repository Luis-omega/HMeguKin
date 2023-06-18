.PHONY: test build run


test :
	cabal new-test --test-show-details=direct #streaming


run :
	cabal run compiler

build :
	cabal build


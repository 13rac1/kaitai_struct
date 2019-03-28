
.PHONY: build
build: docker compiler formats

.PHONY: test
test: cpp_stl_11 cpp_stl_98 go java lua perl python python3 ruby

.PHONY: docker
docker:
	docker build -t kaitai .

.PHONY: compiler
compiler:
	docker run --rm -it -v ${PWD}:/kaitai -v ${PWD}/.cache/:/root/.ivy2/cache -w /kaitai/tests kaitai ./build-compiler

.PHONY: formats
formats:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./build-formats

.PHONY: cpp_stl_11
cpp_stl_11:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-cpp_stl_11

.PHONY: cpp_stl_98
cpp_stl_98:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-cpp_stl_98

# TODO: C#

.PHONY: go
go:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./ci-go

.PHONY: java
java:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-java

# TODO: JavaScript

.PHONY: lua
lua:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-lua || true

.PHONY: perl
perl:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-perl

.PHONY: python
python:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-python || true

.PHONY: python3
python3:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./ci-python3 || true

.PHONY: ruby
ruby:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./run-ruby

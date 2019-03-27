

.PHONY: build
build: docker compiler formats

.PHONY: docker
docker:
	docker build -t kaitai .

.PHONY: compiler
compiler:
	docker run --rm -it -v ${PWD}:/kaitai -v ${PWD}/.cache/:/root/.ivy2/cache -w /kaitai/tests kaitai ./build-compiler

.PHONY: formats
formats:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./build-formats

ci-go:
	docker run --rm -it -v ${PWD}:/kaitai -w /kaitai/tests kaitai ./ci-go

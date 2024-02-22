.PHONY: all build test list clean test-build-v1 test-build-v2 $(TESTS)

all: build list test

build: build-base build-node

build-base: build-base-v1 build-base-v2

build-base-v1:
	docker build \
		--tag tgagor/base-v1/nvm base-nvm/v1

build-base-v2:
	docker build \
		--tag tgagor/base-v2/nvm base-nvm/v2

build-node: build-node-v1 build-node-v2
build-node-v1:
	docker build \
		--build-arg NODE_VERSION=v18 \
		--build-arg BASE_IMAGE=tgagor/base-v1/nvm \
		--tag tgagor/base-v1/node:18 base-node

build-node-v2:
	docker build \
		--build-arg NODE_VERSION=18 \
		--build-arg BASE_IMAGE=tgagor/base-v2/nvm \
		--tag tgagor/base-v2/node:18 base-node

list:
	@docker image ls \
		--filter dangling=false \
		--filter reference='tgagor/*/*'


test: test-v1 test-v2

test-v1: test-run-v1 test-build-v1
test-v2: test-run-v2 test-build-v2

test-run-v1:
	docker run -i tgagor/base-v1/node:18 node --version || echo "Failed."

test-run-v2:
	docker run -i tgagor/base-v2/node:18 node --version || echo "Failed."

TESTS = $(shell find tests -name Dockerfile -print | xargs -L1 dirname)

$(TESTS):
	@echo Running tests for $@
	docker build \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--tag tgagor/base/nvm-tests $@ || echo "Failed."

test-build-v1: export BASE_IMAGE=tgagor/base-v1/node:18
test-build-v1:
	@echo Testing v1 base images
	for i in $(TESTS); do \
		docker build \
			--build-arg BASE_IMAGE=$$BASE_IMAGE \
			$$i || echo "Failed."; \
	done

test-build-v2: export BASE_IMAGE=tgagor/base-v2/node:18
test-build-v2: $(TESTS)
	@echo Testing v2 base images

clean:
	@docker system prune -a -f --volumes

prune: clean

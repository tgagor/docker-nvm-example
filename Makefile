.PHONY: all build test list clean

all: build list test

build: build-base build-node

build-base: build-base-v1 build-base-v2

build-base-v1:
	docker build \
		--tag tgagor/v1/base/nvm v1/base-nvm

build-base-v2:
	docker build \
		--tag tgagor/v2/base/nvm v2/base-nvm

build-node: build-node-v1 build-node-v2
build-node-v1:
	docker build \
		--build-arg NODE_VERSION=v18 \
		--build-arg BASE_IMAGE=tgagor/v1/base/nvm \
		--tag tgagor/v1/base/node:18 base-node

build-node-v2:
	docker build \
		--build-arg NODE_VERSION=18 \
		--build-arg BASE_IMAGE=tgagor/v2/base/nvm \
		--tag tgagor/v2/base/node:18 base-node

list:
	@docker image ls \
		--filter dangling=false \
		--filter reference='tgagor/*/*/*'


test: test-v1 test-v2

test-v1: test-run-v1 test-build-v1
test-v2: test-run-v2 test-build-v2

test-run-v1:
	docker run -i tgagor/v1/base/node:18 node --version || echo "Failed."

test-run-v2:
	docker run -i tgagor/v2/base/node:18 node --version || echo "Failed."

test-build-v1:
	docker build \
		--build-arg BASE_IMAGE=tgagor/v1/base/node:18 \
		--tag tgagor/base/nvm-tests tests || echo "Failed."

test-build-v2:
	docker build \
		--build-arg BASE_IMAGE=tgagor/v2/base/node:18 \
		--tag tgagor/base/nvm-tests tests || echo "Failed."

clean:
	@docker system prune -a -f --volumes

prune: clean

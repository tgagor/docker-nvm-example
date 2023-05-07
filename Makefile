.PHONY: all build test list clean

all: build list test

build: build-base build-node

build-base:
	docker build \
		--tag tgagor/v1/base/nvm v1/base-nvm
	docker build \
		--tag tgagor/v1/base/nvm:alpine v1-alpine/base-nvm
	docker build \
		--tag tgagor/v2/base/nvm v2/base-nvm

build-node:
	docker build \
		--build-arg NODE_VERSION=v18 \
		--build-arg BASE_IMAGE=tgagor/v1/base/nvm \
		--tag tgagor/v1/base/node:18 base-node

	# build node v18 on base v1-alpine
	docker build \
		--build-arg NODE_VERSION=18 \
		--build-arg BASE_IMAGE=tgagor/v1/base/nvm:alpine \
		--tag tgagor/v1/base/node:18-alpine base-node

	# build node v18 on base v2
	docker build \
		--build-arg NODE_VERSION=18 \
		--build-arg BASE_IMAGE=tgagor/v2/base/nvm \
		--tag tgagor/v2/base/node:18 base-node

list:
	@docker image ls \
		--filter dangling=false \
		--filter reference='tgagor/*/*/*'


test:
	set -x

	# testing v1
	docker run -i tgagor/v1/base/node:18 \
		node --version || echo "Failed."
	docker run -i tgagor/v1/base/node:18-alpine \
		node --version || echo "Failed."

	# testing v2
	docker run -i tgagor/v2/base/node:18 \
		node --version || echo "Failed."

	docker build \
	  --tag tgagor/base/nvm-tests tests

clean:
	docker system prune -a -f --volumes

prune: clean

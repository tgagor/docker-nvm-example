ARG BASE_IMAGE=node:18
FROM $BASE_IMAGE

RUN nvm version

# install something with npm
# with v1 - it will fail, because we have to source nvm.sh first
# but it will work out of the box with v2
RUN npm install -g yarn && \
    yarn --version

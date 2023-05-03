ARG NODE_VERSION="lts/*"
ARG BASE_IMAGE=tgagor/v1/base/nvm
FROM $BASE_IMAGE

RUN nvm install --latest-npm $NODE_VERSION && \
    nvm alias default $NODE_VERSION

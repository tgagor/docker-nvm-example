ARG BASE_IMAGE=tgagor/base/nvm
FROM $BASE_IMAGE

ARG NODE_VERSION="lts/*"
RUN nvm install --latest-npm $NODE_VERSION && \
    node --version && \
    npm --version && \
    npx --version

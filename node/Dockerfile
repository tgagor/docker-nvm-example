ARG NODE_VERSION="lts/*"
FROM tgagor/base/nvm

RUN nvm install --latest-npm $NODE_VERSION && \
    nvm alias default $NODE_VERSION

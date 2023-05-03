ARG BASE_IMAGE
ARG NODE_VERSION
FROM $BASE_IMAGE

RUN echo $BASE_IMAGE && \
    echo $NODE_VERSION && \
    nvm install --latest-npm $NODE_VERSION

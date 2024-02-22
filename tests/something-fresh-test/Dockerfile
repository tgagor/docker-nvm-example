ARG BASE_IMAGE=node:18
FROM $BASE_IMAGE

RUN nvm version

# install something fresh
RUN nvm install --lts && \
    nvm which node && \
    ls -lah $(nvm which node) && \
    $(nvm which node) --version

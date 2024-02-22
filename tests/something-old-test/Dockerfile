ARG BASE_IMAGE=node:18
FROM $BASE_IMAGE

RUN nvm version

# install something old
RUN nvm install v16 && \
    nvm alias default v16 && \
    nvm which default && \
    ls -lah $(nvm which default) && \
    $(nvm which default) --version | grep v16 && \
    nvm list default | grep v16 && \
    node --version | grep v16

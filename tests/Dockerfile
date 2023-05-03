ARG BASE_IMAGE=tgagor/v1/node:18
FROM $BASE_IMAGE

RUN nvm version

# install something fresh
RUN nvm install --lts && \
    nvm which node && \
    ls -lah $(nvm which node) && \
    $(nvm which node) --version

# install something with npm
RUN npm install -g yarn && \
    yarn --version

# install something old
RUN nvm install v16 && \
    nvm alias default v16 && \
    nvm which default && \
    ls -lah $(nvm which default) && \
    $(nvm which default) --version | grep v16 && \
    nvm list default | grep v16 && \
    node --version | grep v16

FROM base-nvm

RUN nvm version

# install something fresh
RUN nvm install --lts && \
    nvm which node && \
    ls -lah $(nvm which node) && \
    $(nvm which node) --version

# install something old
RUN nvm install v16 && \
    nvm which node && \
    ls -lah $(nvm which node) && \
    $(nvm which node) --version && \
    nvm list default | grep v16 && \
    node --version

# install something with npm
RUN npm install -g yarn

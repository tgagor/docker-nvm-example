FROM alpine:3 as fetcher
ENV NVM_VERSION v0.39.3
RUN apk add git && \
    git clone \
    --depth 1 \
    --branch $NVM_VERSION \
    https://github.com/nvm-sh/nvm.git


FROM alpine:3

# we don't want to store cached files in the image
VOLUME /var/cache/apk

# prerequsities
RUN apk add --no-cache \
    bash \
    coreutils \
    curl

ENV NVM_DIR=/opt/nvm
SHELL ["/bin/bash", "--login", "-c"]

# add unprivileged user
RUN adduser -D -S jenkins
USER jenkins

# don't store npm cache in the image
VOLUME ~/.npm

# copy the nvm
COPY --from=fetcher --chown=jenkins:jenkins nvm $NVM_DIR

# install NVM
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use' >> ~/.profile

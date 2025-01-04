ARG UBUNTU_RELEASE=24.04
FROM ubuntu:${UBUNTU_RELEASE}

# we don't want to store cached files in the image
VOLUME ["/tmp", "/var/tmp", "/var/cache/apt"]

# prerequsities
RUN apt-get update && \
    apt-get install -y \
        curl

ARG NVM_VERSION=v0.39.3
ENV NVM_DIR=/opt/nvm
SHELL ["/usr/bin/bash", "--login", "-c"]

# add unprivileged user
RUN useradd -m -r -s /usr/sbin/nologin jenkins
USER jenkins

# don't store npm cache in the image
VOLUME ["~/.npm", "/opt/nvm/.cache"]

# copy the nvm
ADD --chown=jenkins:jenkins git@github.com:nvm-sh/nvm.git#${NVM_VERSION} ${NVM_DIR}

# install NVM
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use' >> ~/.profile

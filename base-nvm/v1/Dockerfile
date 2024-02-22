FROM ubuntu:22.04 as fetcher
ENV NVM_VERSION v0.39.3
RUN apt-get update && \
    apt-get install -y git && \
    git clone \
        --depth 1 \
        --branch $NVM_VERSION \
        https://github.com/nvm-sh/nvm.git


FROM ubuntu:22.04

# we don't want to store cached files in the image
VOLUME /var/cache/apt

# prerequsities
RUN apt-get update && \
    apt-get install -y \
        curl

ENV NVM_DIR=/opt/nvm
SHELL ["/usr/bin/bash", "--login", "-c"]

# add unprivileged user
RUN useradd -m -r -s /usr/sbin/nologin jenkins
USER jenkins

# don't store npm cache in the image
VOLUME ~/.npm

# copy the nvm
COPY --from=fetcher --chown=jenkins:jenkins nvm $NVM_DIR

# install NVM
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use' >> ~/.profile

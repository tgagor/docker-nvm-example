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
VOLUME /var/cache/apt ~/.npm

# prerequsities
RUN apt-get update && \
    apt-get install -y \
        curl

SHELL ["/usr/bin/bash", "--login", "-c"]

ENV NVM_DIR=/opt/nvm

# copy the nvm
COPY --from=fetcher nvm $NVM_DIR
COPY bin /usr/local/bin

# change ownership if needed
RUN chown -R $(id -un):$(id -gn) $NVM_DIR && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use' >> ~/.profile

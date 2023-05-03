FROM alpine:3 as fetcher
ENV NVM_VERSION v0.39.3
RUN apk add git && \
    git clone \
    --depth 1 \
    --branch $NVM_VERSION \
    https://github.com/nvm-sh/nvm.git


FROM alpine:3

# we don't want to store cached files in the image
VOLUME ~/.npm

# prerequsities
RUN apk add --no-cache \
    bash \
    coreutils \
    curl

SHELL ["/bin/bash", "--login", "-c"]

ENV NVM_DIR=/opt/nvm

# copy the nvm
COPY --from=fetcher nvm $NVM_DIR

# change ownership if needed
RUN chown -R $(id -un):$(id -gn) $NVM_DIR && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use' >> ~/.profile

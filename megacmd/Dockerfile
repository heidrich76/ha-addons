ARG BUILD_FROM
FROM ${BUILD_FROM}

# Add packages for MEGAcmd
RUN apk add --no-cache bash fuse gcompat git nano util-linux zstd

# Add packages for addon
RUN apk add --no-cache ttyd mosquitto-clients 

# Get MEGAcmd release from Github
ENV VERSION=v2.1.1b2
ENV BASE_URL=https://github.com/heidrich76/megacmd-alpine/releases/download/${VERSION}
RUN wget "${BASE_URL}/megacmd_alpine_${VERSION}_$(uname -m).tar.gz" -O /tmp/megacmd.tar.gz && \
  tar -xzf /tmp/megacmd.tar.gz -C / && rm /tmp/megacmd.tar.gz

WORKDIR /data

# Initialize system
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/*/run && \
  chmod a+x /usr/local/bin/*.sh

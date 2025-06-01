ARG BUILD_FROM
FROM ${BUILD_FROM}

# Add packages for addon
RUN apk add --no-cache bash nano ttyd mosquitto-clients

# Get MEGAcmd release from Github
ENV VERSION=v2.1.1b3
ENV BASE_URL=https://github.com/heidrich76/megacmd-alpine/releases/download/${VERSION}
RUN wget "${BASE_URL}/megacmd_alpine_${VERSION}_$(uname -m).apk" -O /tmp/megacmd.apk && \
  apk add --no-cache --allow-untrusted /tmp/megacmd.apk && rm /tmp/megacmd.apk

WORKDIR /data

# Initialize system
COPY rootfs /
RUN chmod a+x /etc/s6-overlay/s6-rc.d/*/run && \
  chmod a+x /usr/local/bin/*.sh

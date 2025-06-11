ARG BUILD_FROM
FROM jensheidrich76/megacmd-gui:v0.1.4 AS gui
FROM ${BUILD_FROM}

# Add gui
RUN apk add --no-cache bash wget uuidgen python3
COPY --from=gui /venv /venv
COPY --from=gui /opt/megacmd-gui opt/megacmd-gui

# Add packages for addon
RUN apk add --no-cache nano mosquitto-clients

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

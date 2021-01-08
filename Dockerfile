ARG BUILD_FROM=homeassistant/amd64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8

WORKDIR /usr/src/ecowitt2mqtt

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    && pip3 install --no-cache-dir ecowitt2mqtt

WORKDIR /
COPY start.sh /app/start.sh
ENTRYPOINT ["/app/start.sh"]

LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"

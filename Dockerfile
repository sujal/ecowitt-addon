ARG BUILD_FROM
FROM ${BUILD_FROM}

ENV LANG C.UTF-8

WORKDIR /usr/src/ecowitt2mqtt

# Install python/pip - taken from https://stackoverflow.com/questions/62554991/how-do-i-install-python-on-alpine-linux
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache \
        build-base \
        python3 \
        python3-dev \
    && ln -sf python3 /usr/bin/python \
    && python3 -m ensurepip \
    && pip3 install --no-cache --upgrade pip setuptools \
    && pip3 install --no-cache-dir ecowitt2mqtt

WORKDIR /
COPY start.sh /app/start.sh
CMD ["/app/start.sh"]

LABEL io.hass.version="VERSION" io.hass.type="addon" io.hass.arch="armhf|aarch64|i386|amd64"

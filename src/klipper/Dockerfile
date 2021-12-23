FROM python:3.10-alpine AS build

ARG KLIPPER_VERSION=master
ARG MOONRAKER_VERSION=master

WORKDIR /opt

RUN apk --no-cache --update add build-base \
      git \
      patch \
      openjpeg \
      py3-libgpiod \
      curl \
      openssl-dev \
      curl-dev \
      lmdb \
      libsodium-dev \
      zlib-dev \
      jpeg-dev \
      py3-virtualenv \
      python3-dev \
      libffi-dev \
      ncurses-dev

# Klipper build
RUN git clone --depth=1 -b "${KLIPPER_VERSION}" https://github.com/Klipper3d/klipper /opt/klipper
RUN cd /opt/klipper \
  && python -m venv venv \
  && venv/bin/pip install -r scripts/klippy-requirements.txt

# Moonraker build
RUN git clone --depth=1 -b "${MOONRAKER_VERSION}" https://github.com/Arksine/moonraker /opt/moonraker
RUN cd /opt/moonraker \
  && python -m venv venv \
  && venv/bin/pip install -r /opt/moonraker/scripts/moonraker-requirements.txt


FROM python:3.10-alpine AS run

RUN apk --no-cache --update add \
      openjpeg \
      py3-libgpiod \
      curl \
      openssl \
      curl \
      lmdb \
      libsodium \
      zlib \
      jpeg \
      iproute2 \
      git \
      supervisor \
      newlib-arm-none-eabi \
      gcc-arm-none-eabi \
      stm32flash \
      libusb-dev

COPY --from=build /opt/moonraker /opt/moonraker
COPY --from=build /opt/klipper /opt/klipper
WORKDIR /opt

RUN mkdir run cfg gcode db
RUN addgroup klipper \
 && adduser -S klipper -G klipper \
 && adduser klipper dialout \
 && chown -R klipper:klipper /opt/klipper /opt/moonraker

## Start
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint /entrypoint

COPY moonraker.conf printer.cfg /opt/cfg/

EXPOSE 7125
VOLUME ["/opt/run", "/opt/gcode", "/opt/db", "/opt/logs"]

ENTRYPOINT ["/entrypoint"]

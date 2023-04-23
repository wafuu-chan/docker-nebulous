# syntax=docker/dockerfile:1
FROM steamcmd/steamcmd
RUN steamcmd +force_install_dir /root/Nebulous +login anonymous +app_update 2353090 validate +workshop_download_item 887570 2965922098 +quit
FROM debian
ENV DEBIAN_FRONTEND=noninteractive
# Locales config for Unicode support
RUN echo locales locales/locales_to_be_generated multiselect     en_US.UTF-8 UTF-8 | debconf-set-selections && \
echo locales locales/default_environment_locale      select  en_US.UTF-8 | debconf-set-selections
RUN apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates locales && \
  rm -rf /var/lib/apt/lists/*
RUN mkdir /config /opt/Nebulous
COPY --from=0 /root/Nebulous /opt/Nebulous
# steamclient hack
RUN mkdir -p /opt/Nebulous/.steam/sdk64 && \
  mv /opt/Nebulous/linux64/steamclient.so /opt/Nebulous/.steam/sdk64/steamclient.so
USER root
RUN useradd --no-create-home --home-dir /opt/Nebulous nebulous
# Nebulous config and battle report folders
RUN chown nebulous:nebulous /opt/Nebulous/Saves && \
  mkdir /opt/Nebulous/.config && \
  chown nebulous:nebulous /opt/Nebulous/.config
USER nebulous
WORKDIR /opt/Nebulous
ENTRYPOINT /opt/Nebulous/NebulousDedicatedServer

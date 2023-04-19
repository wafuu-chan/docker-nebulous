# syntax=docker/dockerfile:1
FROM debian
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY Build_Server/ /opt/Nebulous
RUN mkdir /config
# steamclient hack
RUN mkdir -p /opt/Nebulous/.steam/sdk64 && mv /opt/Nebulous/steamclient.so /opt/Nebulous/.steam/sdk64/steamclient.so
RUN useradd --no-create-home --home-dir /opt/Nebulous nebulous
RUN mkdir -p /opt/Nebulous/Saves && chown nebulous:nebulous /opt/Nebulous/Saves
USER nebulous
WORKDIR /opt/Nebulous
ENTRYPOINT /opt/Nebulous/NebulousDedicatedServer

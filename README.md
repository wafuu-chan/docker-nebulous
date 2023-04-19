# [docker-nebulous](https://hub.docker.com/r/wafuu/nebulous)
Nebulous Fleet Command Docker Container

## Quickstart

To start a server using the config located in your current folder:
`docker run -it -v $PWD/DedicatedServerConfig.xml:/opt/Nebulous/DedicatedServerConfig.xml -p 7777:7777 -p 27016:27016/udp wafuu/nebulous`

## Developer Quickstart

1. Download Server files from Discord
2. Extract into folder
3. `docker build .`

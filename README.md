# arm-logspout

[![Build](https://github.com/jahrik/arm-logspout/actions/workflows/build.yml/badge.svg)](https://github.com/jahrik/arm-logspout/actions/workflows/build.yml)

Multi-arch [logspout](https://github.com/gliderlabs/logspout) image with the [logstash adapter](https://github.com/looplab/logspout-logstash) compiled in, shipping container logs to the `elk` swarm stack. Uses the official ONBUILD custom-module base.

## Run

```bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock \
  -e ROUTE_URIS=logstash://logstash:5000 jahrik/arm-logspout:latest
```

## Deploy (swarm)

```bash
docker network create -d overlay elk   # once
just deploy                            # global service, stack: elk
```

`ROUTE_URIS` defaults to `logstash://logstash:5000`.

## Build

```bash
just build
just push
```

CI: PR builds + version/adapter checks; merge to main pushes multi-arch (amd64/arm64/armv7) to Docker Hub.

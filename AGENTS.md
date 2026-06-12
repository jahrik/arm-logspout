# AGENTS.md

Multi-arch logspout image with the looplab logstash adapter, shipping container logs in the `elk` swarm stack.

## Commands

```bash
make build                                  # build jahrik/arm-logspout:latest
docker run --rm jahrik/arm-logspout:latest --version
make deploy                                 # swarm stack deploy (stack: elk)
```

## CI

`build.yml`: Test (build + `--version` + adapter grep in logs) on PR; Release (buildx amd64/arm64/armv7 push to Docker Hub) on merge to main. Needs `DOCKERHUB_USERNAME`/`DOCKERHUB_TOKEN` secrets.

## Quirks

- `FROM gliderlabs/logspout:v3.2.14` is an ONBUILD base: it copies `build.sh` + `modules.go` from the build context and recompiles logspout with the listed adapters. Both files must exist (`build.sh` is upstream's `custom/build.sh`, vendored verbatim). v3.2.14 (2021) is upstream's final release.
- The logstash module import is `github.com/looplab/logspout-logstash` (package moved to repo root; the old `/logstash` subpath no longer exists).
- Needs `/var/run/docker.sock` mounted; startup logs must list `logstash` in `# adapters:`.
- External `elk` overlay network — keep that wiring.

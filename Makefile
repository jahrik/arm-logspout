IMAGE = "jahrik/arm-logspout"
TAG = "arm32v7"
STACK = "elk"

all: build

git:
	@git clone https://github.com/gliderlabs/logspout.git

build: git
	@cd logspout && docker build -t ${IMAGE}:$(TAG) .
	@docker tag ${IMAGE}:$(TAG) ${IMAGE}:latest

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push ${IMAGE}:latest

deploy:
	@docker stack deploy -c docker-compose.yml ${STACK}

.PHONY: all build push deploy

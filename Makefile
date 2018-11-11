IMAGE = "jahrik/arm-logspout"
STACK = "elk"
ARCH := $(shell uname -m)
TAG = ${ARCH}

# CPP_FLAGS_32 := -D32_BIT ...  Some 32 specific compiler flags ...
# CPP_FLAGS_64 := -D64_BIT
# CPP_FLAGS := $(CPP_FLAGS_$(ARCH))  ... all the other flags ...

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

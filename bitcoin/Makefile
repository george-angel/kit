NAME=quay.io/george_angel/bitcoin
BITCOIN_VERSION=0.15.1
ITERATION=2

UNAME_M := $(shell uname -m)
ifneq ($(filter x86_64,$(UNAME_M)),)
        IMAGE=$(NAME):$(BITCOIN_VERSION)-amd64-$(ITERATION)
	DOCKERFILE=Dockerfile
endif
ifneq ($(filter armv7%,$(UNAME_M)),)
        IMAGE=$(NAME):$(BITCOIN_VERSION)-arm-$(ITERATION)
	DOCKERFILE=Dockerfile.arm
endif

build:
	docker $@ -t $(IMAGE) --build-arg BITCOIN_VERSION=$(BITCOIN_VERSION) -f $(DOCKERFILE) .

push:
	docker $@ $(IMAGE)

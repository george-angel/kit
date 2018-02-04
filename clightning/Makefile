NAME=quay.io/george_angel/clightning
LIGHTNING_VERSION=v0.5.2-2016-11-21
ITERATION=1

IMAGE=$(NAME):$(LIGHTNING_VERSION)-amd64-$(ITERATION)

build:
	docker $@ -t $(IMAGE) --build-arg LIGHTNING_VERSION=$(LIGHTNING_VERSION) .

push:
	docker $@ $(IMAGE)

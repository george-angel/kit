NAME=quay.io/george_angel/bitcoin
BITCOIN_VERSION=0.15.1
ITERATION=2

IMAGE=$(NAME):$(BITCOIN_VERSION)-amd64-$(ITERATION)

build:
	docker $@ -t $(IMAGE) --build-arg BITCOIN_VERSION=$(BITCOIN_VERSION) .

push:
	docker $@ $(IMAGE)

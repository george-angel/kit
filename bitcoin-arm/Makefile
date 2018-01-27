include ../_lib/bork/common.mk
include ../_lib/tf/base.makefile
include vars.mk

bork-libs=../_lib/bork/*

NAME=quay.io/george_angel/bitcoin
BITCOIN_VERSION=0.15.1
ITERATION=1

IMAGE=$(NAME):$(BITCOIN_VERSION)-arm-$(ITERATION)


_satisfy:
	# local bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" *.sh root@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" $(bork-libs) root@$(IP):/tmp/bork/
	# template
	(export IMAGE=$(IMAGE); \
	export CONF_RPCPASSWORD=$(rpcpassword); \
	envsubst < bitcoin.service.template) | $(ssh)$(IP) "cat - > /tmp/bork/bitcoin.service"
	$(ssh)$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) bork.sh"

build:
	docker $@ -t $(IMAGE) --build-arg BITCOIN_VERSION=$(BITCOIN_VERSION) .

push:
	docker $@ $(IMAGE)

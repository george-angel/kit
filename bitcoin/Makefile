include ../_lib/bork/common.mk
include ../_lib/tf/base.makefile

bork-libs=../_lib/bork/*

VER=0.15.1
NAME=quay.io/george_angel/bitcoin

_satisfy:
	# local bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" *.sh root@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" $(bork-libs) root@$(IP):/tmp/bork/
	# template
	ifeq ($(ARCH),"arm")
	  IMG=$(NAME):$(VER)-arm
	else
	  IMG=$(NAME):$(VER)
	endif
	(export IMG=$(IMG); \
	envsubst < bitcoin.service.template) | $(ssh)$(IP) "cat - > /tmp/bork/bitcoin.service"
	$(ssh)$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) bork.sh"

build-x86:
	docker build -t $(NAME):$(VER) -f Dockerfile .

push-x86:
	docker push $(NAME):$(VER)

build-arm:
	docker build -t $(NAME):$(VER)-arm -f Dockerfile.arm .

push-arm:
	docker push $(NAME):$(VER)-arm

run:
	docker $@ -ti \
	-p 8332:8332 \
	-p 8333:8333 \
	-v /tmp/btc-data:/bitcoin/data:rw \
	$(NAME):$(VER)

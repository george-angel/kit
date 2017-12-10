include ../_lib/bork/common.mk
include ../_lib/tf/base.makefile

bork-libs=../_lib/bork/*

VER = 0.15.1
NAME = quay.io/george_angel/bitcoin

_satisfy:
	# local bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" *.sh root@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" $(bork-libs) root@$(IP):/tmp/bork/
	# template
	(export IMG=$(NAME):$(VER); \
	envsubst < bitcoin.service.template) | $(ssh)$(IP) "cat - > /tmp/bork/bitcoin.service"
	$(ssh)$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) main.sh"

build:
	docker $@ -t $(NAME):$(VER) --build-arg VER=$(VER) .

push:
	docker $@ $(NAME):$(VER)

run:
	docker $@ -ti \
	-p 8333:8333 \
	-p 8334:8334 \
	-p 18333:18333 \
	-p 18334:18334 \
	-p 18555:18555 \
	-p 18556:18556 \
	-p 28901:28901 \
	-p 28902:28902 \
	-v /tmp/btc-data:/data:rw \
	$(NAME):$(VER)

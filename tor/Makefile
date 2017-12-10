include ../_lib/bork/common.mk
include ../_lib/tf/base.makefile
include vars.mk

image_name=quay.io/george_angel/tor
tor_ver=0.3.1.9

build:
	docker build -t $(image_name):$(tor_ver) --build-arg TOR_VER=$(tor_ver) .

push:
	docker push $(image_name):$(tor_ver)

_satisfy:
	# local bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" *.sh root@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" ../_lib/bork/* root@$(IP):/tmp/bork/
	# template
	(export TOR_VER=$(tor_ver); \
	export NAME=$(tor_name)$$(echo $(ROLE) | cut -c1)$(NUM); \
	export CONTACT=$(operator); \
	export ROLE=$(ROLE); \
	envsubst < tor.service.template) | $(ssh)$(IP) "cat - > /tmp/bork/tor.service"
	$(ssh)$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) tor-deb.sh"

_pull-latest:
	$(ssh)$(IP) docker pull $(image_name):$(tor_ver)

pull-latest-all:
	cat inventory/* | awk '{print $$1}' | parallel make _pull-latest IP={}

restart-svc-all:
	cat inventory/* | awk '{print $$1}' | parallel $(ssh){} sudo systemctl restart tor

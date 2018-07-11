include ../_lib/bork/common.mk
include ../_lib/tf/base.makefile
include vars.mk

image_name=quay.io/george_angel/tor
tor_ver=0.3.3.8

user=root

build:
	docker build -t $(image_name):$(tor_ver) --build-arg TOR_VER=$(tor_ver) .

push:
	docker push $(image_name):$(tor_ver)

_satisfy:
	# local bork files
	rsync -arvce "ssh $(ssh_opts)" *.sh $(user)@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh $(ssh_opts)" ../_lib/bork/* $(user)@$(IP):/tmp/bork/
	# template
	(export TOR_VER=$(tor_ver); \
	export NAME=$(tor_name)$$(echo $(ROLE) | cut -c1)$(NUM); \
	export CONTACT=$(operator); \
	export ROLE=$(ROLE); \
	envsubst < tor.service.template) | ssh $(ssh_opts) $(user)@$(IP) "cat - > /tmp/bork/tor.service"
	ssh $(ssh_opts) $(user)@$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) tor-deb.sh 2>/dev/null"

_pull-latest:
	ssh $(ssh_opts) $(user)@$(IP) docker pull $(image_name):$(tor_ver)

pull-latest-all:
	cat inventory/* | awk '{print $$1}' | parallel make _pull-latest IP={}

restart-svc-all:
	cat inventory/* | awk '{print $$1}' | parallel ssh $(ssh_opts) $(user)@{} sudo systemctl restart tor

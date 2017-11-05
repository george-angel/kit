include common.mk
include vars.mk

sync-inv:
	rsync ../tf/*-inv inventory/

_satisfy:
	# local bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" *.sh root@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" ../../lib/bork/* root@$(IP):/tmp/bork/
	# template
	(export TOR_VER=$(tor_ver); \
	export NAME=$(tor_name)$$(echo $(ROLE) | cut -c1)$(NUM); \
	export CONTACT=$(operator); \
	export ROLE=$(ROLE); \
	envsubst < tor.service.template) | $(ssh)$(IP) "cat - > /tmp/bork/tor.service"
	$(ssh)$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) tor-deb.sh"

# cat inventory/* :
# $1 ip
# $2 role
# $3 count
trust-all:
	cat inventory/* | awk '{print $$1}' | parallel ssh-keyscan {} >> ~/.ssh/known_hosts

satisfy-all:
	cat inventory/* | awk '{print "make _satisfy IP="$$1" ROLE="$$2" NUM="$$3" ACTION=satisfy"}' | parallel

status-all:
	cat inventory/* | awk '{print "make _satisfy IP="$$1" ROLE="$$2" NUM="$$3" ACTION=status"}' | parallel

_pull-latest:
	$(ssh)$(IP) docker pull angelx/tor:$(tor_ver)

pull-latest-all:
	cat inventory/* | awk '{print $$1}' | parallel make _pull-latest IP={}

restart-all:
	cat inventory/* | awk '{print $$1}' | parallel $(ssh){} sudo systemctl restart tor

restart-nodes:
	cat inventory/* | awk '{print $$1}' | parallel $(ssh){} sudo systemctl reboot

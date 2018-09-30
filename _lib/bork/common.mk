ssh_opts=-oStrictHostKeyChecking=no

# cat inventory/* :
# $1 ip
# $2 role
# $3 count
# $4 arch

_setup:
	ssh $(ssh_opts) $(user)@$(IP) apt-get -y update
	ssh $(ssh_opts) $(user)@$(IP) apt-get -y install git
	ssh $(ssh_opts) $(user)@$(IP) "test -d /usr/local/src/bork || git clone https://github.com/mattly/bork /usr/local/src/bork"
	ssh $(ssh_opts) $(user)@$(IP) "test -L /usr/local/bin/bork || ln -sf /usr/local/src/bork/bin/bork /usr/local/bin/bork"
	ssh $(ssh_opts) $(user)@$(IP) "test -L /usr/local/bin/bork-compile || ln -sf /usr/local/src/bork/bin/bork-compile /usr/local/bin/bork-compile"

_update:
	ssh $(ssh_opts) $(user)@$(IP) apt-get -y update

_upgrade:
	ssh $(ssh_opts) $(user)@$(IP) apt-get -y upgrade

trust-all:
	cat inventory/* | awk '{print $$1}' | parallel ssh-keyscan {} >> ~/.ssh/known_hosts

setup-all:
	cat inventory/* | awk '{print $$1}' | parallel make _setup IP={} user=root

update-all:
	cat inventory/* | awk '{print $$1}' | parallel make _update IP={}

upgrade-all:
	cat inventory/* | awk '{print $$1}' | parallel make _upgrade IP={}

satisfy-all:
	cat inventory/* | awk '{print "make _satisfy IP="$$1" ROLE="$$2" NUM="$$3" ARCH="$$4" ACTION=satisfy"}' | parallel

status-all:
	cat inventory/* | awk '{print "make _satisfy IP="$$1" ROLE="$$2" NUM="$$3" ARCH="$$4" ACTION=status"}' | parallel

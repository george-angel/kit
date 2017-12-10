ssh=ssh -oStrictHostKeyChecking=no root@

# cat inventory/* :
# $1 ip
# $2 role
# $3 count

_setup:
	$(ssh)$(IP) apt -y update
	$(ssh)$(IP) apt -y install git
	$(ssh)$(IP) git clone https://github.com/mattly/bork /usr/local/src/bork
	-$(ssh)$(IP) ln -sf /usr/local/src/bork/bin/bork /usr/local/bin/bork
	-$(ssh)$(IP) ln -sf /usr/local/src/bork/bin/bork-compile /usr/local/bin/bork-compile

trust-all:
	cat inventory/* | awk '{print $$1}' | parallel ssh-keyscan {} >> ~/.ssh/known_hosts

setup-all:
	cat inventory/* | awk '{print $$1}' | parallel make _setup IP={}

satisfy-all:
	cat inventory/* | awk '{print "make _satisfy IP="$$1" ROLE="$$2" NUM="$$3" ACTION=satisfy"}' | parallel

status-all:
	cat inventory/* | awk '{print "make _satisfy IP="$$1" ROLE="$$2" NUM="$$3" ACTION=status"}' | parallel

restart-node-all:
	cat inventory/* | awk '{print $$1}' | parallel $(ssh){} sudo systemctl reboot

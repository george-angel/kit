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

setup-all:
	cat inventory/* | awk '{print $$1}' | parallel make _setup IP={}

include ../_lib/bork/common.mk
include ../_lib/tf/base.makefile

bork-libs=../_lib/bork/*

_satisfy:
	# local bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" *.sh root@$(IP):/tmp/bork/
	# lib bork files
	rsync -arvce "ssh -o StrictHostKeyChecking=no" $(bork-libs) root@$(IP):/tmp/bork/
	# bork
	$(ssh)$(IP) "cd /tmp/bork/; export BORK_CONFLICT_RESOLVE=0; bork $(ACTION) main.sh"

TF := $(shell git rev-parse --show-toplevel)/lib/tf/tf.sh
TF_VAR_component := $(shell basename ${PWD})
export TF_VAR_component

plan:
	$(TF) $@ $(ARGS)

refresh:
	$(TF) $@ $(ARGS)

apply:
	-rm -f saved-plan
	$(TF) plan -out=saved-plan $(ARGS)
	$(TF) apply $(ARGS) saved-plan

apply-saved-plan:
	$(TF) apply $(ARGS) saved-plan

init:
	$(TF) $@

destroy:
	-rm -f saved-plan
	$(TF) plan -destroy -out=saved-plan $(ARGS)
	@echo -n "Hit ^C now to cancel, or press return TO DESTROY. ARE YOU SURE?" ; read something
	$(TF) apply saved-plan

graph:
	$(TF) $@ | dot -T png > graph.png
	echo created $(PWD)/graph.png

show:
	$(TF) $@ .terraform/terraform.tfstate

import:
	$(TF) $@ $(ARGS)

get:
	$(TF) $@ $(ARGS)

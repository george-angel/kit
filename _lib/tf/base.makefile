TF := $(shell git rev-parse --show-toplevel)/_lib/tf/tf
TF_VAR_component := $(shell basename ${PWD})
export TF_VAR_component

t-plan:
	$(TF) plan $(ARGS)

t-refresh:
	$(TF) refresh $(ARGS)

t-apply:
	$(TF) plan -out=saved-plan $(ARGS)
	$(TF) apply $(ARGS) saved-plan
	-rm -f saved-plan

t-init:
	$(TF) init

t-destroy:
	-rm -f saved-plan
	$(TF) plan -destroy -out=saved-plan $(ARGS)
	@echo -n "Hit ^C now to cancel, or press return TO DESTROY. ARE YOU SURE?" ; read something
	$(TF) apply saved-plan

t-show:
	$(TF) show .terraform/terraform.tfstate

t-import:
	$(TF) import $(ARGS)

t-get:
	$(TF) get $(ARGS)

TF := $(shell git rev-parse --show-toplevel)/_lib/tf/tf
TF_VAR_component := $(shell basename ${PWD})
export TF_VAR_component

CMDS = t-output t-refresh t-validate t-console t-import t-state t-taint t-untaint t-force-unlock t-version t-0.12checklist t-0.12upgrade t-graph t-providers t-show t-fmt
.PHONY: $(CMDS)

t-0.13upgrade:
	$(TF) 0.13upgrade $(ARGS)

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

t-state:
	$(TF) state $(ARGS)

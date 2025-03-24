OPTS = -v -t all -i hosts -f 10 site.yaml

a-ping:
	ansible all -m ping -i hosts
a-ping-tor:
	torsocks ansible all -m ping -i hosts
a-playbook:
	ansible-playbook $(OPTS) $(ARGS)
a-playbook-tor:
	torsocks ansible-playbook $(OPTS) $(ARGS)
a-playbook-check:
	ansible-playbook $(OPTS) --check $(ARGS)
a-playbook-check-tor:
	torsocks ansible-playbook $(OPTS) --check $(ARGS)

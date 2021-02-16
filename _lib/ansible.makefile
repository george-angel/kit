a-ping:
	ansible all -m ping -i hosts
a-ping-tor:
	torsocks ansible all -m ping -i hosts
a-playbook:
	ansible-playbook -v -i hosts -f 10 site.yaml $(ARGS)
a-playbook-tor:
	torsocks ansible-playbook -v -i hosts -f 10 site.yaml $(ARGS)
a-playbook-check:
	ansible-playbook -v -i hosts -f 10 site.yaml --check $(ARGS)
a-playbook-check-tor:
	ansible-playbook -v -i hosts -f 10 site.yaml --check $(ARGS)

a-ping:
	ansible all -m ping -i hosts
a-ping-tor:
	torsocks ansible all -m ping -i hosts
a-playbook:
	ansible-playbook -v -i hosts -f 10 site.yaml
a-playbook-tor:
	torsocks ansible-playbook -v -i hosts -f 10 site.yaml
a-playbook-check:
	ansible-playbook -v -i hosts -f 10 site.yaml --check

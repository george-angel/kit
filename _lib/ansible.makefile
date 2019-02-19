aping:
	torsocks ansible all -m ping -i hosts

aplaybook:
	torsocks ansible-playbook -i hosts -f 10 site.yaml

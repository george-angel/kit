include ../_lib/tf/base.makefile
include ../_lib/ansible.makefile

image-build:
	docker build -t tor --build-arg=TOR_VER=$(shell grep tor_ver vars/main.yaml | cut -d" " -f2) .

RELEASE = 0.13.0
NAME = quay.io/george_angel/ethminer

build:
	docker build -t $(NAME):$(RELEASE) --build-arg RELEASE=$(RELEASE) .

push:
	docker push $(NAME):$(RELEASE)

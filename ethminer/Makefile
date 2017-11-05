RELEASE = 0.12.0
NAME = angelx/ethminer

build:
	docker build -t $(NAME):$(RELEASE) --build-arg RELEASE=$(RELEASE) .

push:
	docker push $(NAME):$(RELEASE)

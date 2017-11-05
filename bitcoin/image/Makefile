VER = 0.15.0.1
NAME = angelx/bitcoin

build:
	docker build -t $(NAME):$(VER) --build-arg VER=$(VER) .

push:
	docker push $(NAME):$(VER)

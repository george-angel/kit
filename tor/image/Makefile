TOR_VER = 0.3.1.8
NAME = angelx/tor

build:
	docker build -t $(NAME):$(TOR_VER) --build-arg TOR_VER=$(TOR_VER) .

push:
	docker push $(NAME):$(TOR_VER)

AUTHOR=dockpack
NAME=tomcat
VERSION=7

.PHONY: all build bash run help
all: build

build:
	docker build -t $(AUTHOR)/$(NAME):$(VERSION) .

bash:
	docker exec -ti tomcat /bin/bash

run:
	docker run --name dockpacktomcat -h dockpacktomcat -d -p 8080:8080 $(AUTHOR)/$(NAME):$(VERSION)

help:
	@docker inspect $(AUTHOR)/$(NAME):$(VERSION) | grep -i running | head -1

test:
	open http://$(DOCKERHOST):8080/gameoflife/

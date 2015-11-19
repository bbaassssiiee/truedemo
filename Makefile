AUTHOR=dockpack
NAME=tomcat
VERSION=7
COMMANDO=$(shell docker inspect dockpack/tomcat:7 | grep -i running | head -1|cut -d " " -f2)

.PHONY: all build bash run
all: build

build:
#	(cd ansible && ansible-galaxy install --force -r requirements.yml)
	docker build -t $(AUTHOR)/$(NAME):$(VERSION) .

bash:
	docker exec -ti tomcat /bin/bash

run:
	docker run --name dockpacktomcat -h dockpacktomcat -d -p 8080:8080 $(AUTHOR)/$(NAME):$(VERSION)
